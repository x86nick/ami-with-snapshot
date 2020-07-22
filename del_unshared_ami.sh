#!/bin/bash

for ami in $(aws ec2 describe-images --owners "self" | jq -r '.Images[].ImageId')
  do
    ct=$(aws ec2 describe-image-attribute --image-id "$ami" --attribute 'launchPermission' | \
      jq '[.LaunchPermissions[]]|length')
    if [ 0 -eq "$ct" ]; then echo "$ami"; fi
done
