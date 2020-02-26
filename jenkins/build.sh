#!/bin/bash
set -x
set -e
docker build -t openroad/openroad --target base-dependencies .

# Build a parallel area to the workspace for the flow test
pwd=`pwd`
dir=$(dirname "${pwd}")
base=$(basename "${pwd}")
flow=$dir/${base}__flow
if [[ ! -d $flow ]]; then
    mkdir $flow
fi

docker run -u $(id -u ${USER}):$(id -g ${USER}) -v ${pwd}:/OpenROAD -v ${flow}:/OpenROAD-flow openroad/openroad bash -c "./OpenROAD/jenkins/install.sh"
