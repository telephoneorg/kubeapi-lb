SHELL := /bin/bash

GITHUB_USER ?= joeblackwaslike
GITHUB_ORG ?= telephoneorg
GITHUB_REPO := kubeapi-lb

DOCKER_USER ?= joeblackwaslike
DOCKER_ORG ?= telephoneorg
DOCKER_REPO := kubeapi-lb
DOCKER_TAG := latest
DOCKER_IMAGE := $(DOCKER_ORG)/$(DOCKER_REPO):$(DOCKER_TAG)

.PHONY: all build build-test test push-image

all: build test

build:
	docker build --force-rm -t $(DOCKER_IMAGE) build

build-test:
	tests/edit $(DOCKER_IMAGE) tail -f /dev/null

test:
	tests/run $(DOCKER_IMAGE) tail -f /dev/null

push-image:
	if [[ $$TRAVIS == 'true' ]]; then \
		docker login -u $(DOCKER_USER) -p $(DOCKER_PASS); \
	fi
	docker push $(DOCKER_IMAGE)
