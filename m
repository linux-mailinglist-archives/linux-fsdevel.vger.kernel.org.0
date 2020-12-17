Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B4C2DD9B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 21:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgLQUOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 15:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgLQUOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:14:52 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B6BC061794
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 12:14:12 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id d6so4309025vkb.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 12:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=Wkj6zzMnbmHy1R927KKmX6dciAdOSfnBEhhcIO0d4mk=;
        b=PPAyoOEDgniD3rqXx8Mi6rD5GpNBJwOiVBxhD42bmoaznzZsKpod6IqJbT+h7jBQt+
         yi1+gKzDOfcU1z+wRNNmMPTyGeJhP5k9fm983/7vptKYdZpR0tYtrqTkvecUzzA5dCQg
         rS+LQD/mZpn53A04eicsCE61IBAawwpIEP+syhhmyKGXdBvjLzIwUV97crndts7bA/0Y
         s+d6VNmypMyUer25By0XwRKfqMImCmtTIxPWgHgZOeaDPhaJPSAzePdxomXa+xh+cyTJ
         cTyJmG5aZp7gunTFS6n1zCQj4baZey9fE9bEyLMUXqeZC4+Ayw6+5F8abYnJCkuqFX1c
         8b7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Wkj6zzMnbmHy1R927KKmX6dciAdOSfnBEhhcIO0d4mk=;
        b=SLHKL7LjEiRlyzRLrl98eF6Fp3lu/pg8vXENokLQorwAht9ssRk2lHiDKpQiFRds7h
         PlXM4n/O2Gvwyuef15RvSv4EIlhaZayRDU5xf970aNpXOiDgo43FzkkEEU5rarjOftXJ
         xw42HjwwHmVfOVv2JjPEEUPiKlCW29hKzq8aALdC3SNlVjnvdigJqDcRDv9QHm/36fkr
         SRXk1yTjFkyJ0FhMTaUwuHl60eHt48xIu/QTQ7IbfRhSdKo8iRGr+RssMgvakvH5cTCs
         B7XC0LSNRbsm9ZrnT/y06kzO7oxQtuPV39j7ySxn2bKNIV6ElH5++2nHywfoUJHsdbSn
         GrUg==
X-Gm-Message-State: AOAM531LF0qsLtZ5UdRTOfE+5X9WJSbKUkyifXt8tmihauZ1dQyehTPG
        LdqvycweMvOFYtSXFo0Hj7Ce70Nv5ziQRFqZ7tIYFu5KZkb08A0W
X-Google-Smtp-Source: ABdhPJwTsWEW0HIHZqFlTbomU9Yax7JLlEZ50fezzGyZFhlXnEp2jCKytISdZB9hiijGKBofms5utlsmDgZqnrRoGOI=
X-Received: by 2002:ac5:c92e:: with SMTP id u14mr721440vkl.15.1608236050994;
 Thu, 17 Dec 2020 12:14:10 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 17 Dec 2020 13:13:54 -0700
Message-ID: <CAJCQCtQUvyopGxBcXzenTy8MuEvm+W1PQNqzFf1Qp=p1M9pBGQ@mail.gmail.com>
Subject: how to track down cause for EBUSY on /dev/vda4?
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Short version:
# mkfs.any /dev/vda4
unable to open /dev/vda4: Device or resource busy

Curiously /dev/vda4 is just a blank partition, not in use by anything
that I'm aware of. And gdisk is allowed to modify the GPT on /dev/vda
without complaint. This is a snippet from strace of the above command
at the failure point:

openat(AT_FDCWD, "/dev/vda4", O_RDWR|O_EXCL) = -1 EBUSY (Device or
resource busy)
write(2, "ERROR: ", 7ERROR: )                  = 7
write(2, "unable to open /dev/vda4: Device"..., 49unable to open
/dev/vda4: Device or resource busy) = 49
write(2, "\n", 1
)

Long version:

1. Create an image with xorriso. Result is an ISO 9660 image that also
contains an MBR and GPT. Together, these are all in conflict but
permit magical indirection to successfully boot a computer whether
it's UEFI or BIOS, on optical or USB sticks.

2. Write this image to a USB stick using cat or dd.

3. The horrible idea occurs to use the large pile of extra space on
the USB stick for persistence. Therefore a partition must be added.

4. Given the MBR is not a single partition PMBR, its existence
invalidates the GPT. And at least gdisk doesn't want to modify the GPT
at all. But I can create a new GPT and PMBR, and in effect merge the
old MBR and GPT entries to protect the two El Torito EFI system
partitions, and the ISO 9660 image as a whole. Write this out to
/dev/vda without any complaint, and the resulting image still boots
BIOS and UEFI systems.

5. Upon reboot, /dev/vda4 exists, a large empty partition. The idea is
to format it, but all of the following commands fail with EBUSY:
# mkdosfs /dev/vda4
# mkfs.ext4 /dev/vda4
# mkfs.xfs /dev/vda4
# mkfs.btrfs /dev/vda4
# btrfs device add /dev/vda4 /run/rootfsbase  [1]

6. Color me confused. Granted, despite cleaning up the conflicting MBR
and GPT, this is still an odd duck. ISO 9660 ostensibly is a read-only
format, and /proc/mounts shows

/dev/vda /run/initramfs/live iso9660
ro,relatime,nojoliet,check=s,map=n,blocksize=2048 0 0

So it sees the whole vda device as iso9660 and ro? But permits gdisk
to modify some select sectors on vda? I admit it's an ambiguous image.
Is it a duck or is it a rabbit? And therefore best to just look at it,
not make modifications to it. Yet /dev/vda is modifiable, where the
partitions aren't. Hmm.

Thanks,

--
Chris Murphy


[1]
The last one for the future fs-devel trivia pursuit game. There is a
mounted btrfs "seed" on /run/rootfsbase, and it's possible to make it
a read-write "sprout" merely by adding a writable device. The command
implies mkfs and file system resize. Once it completes, it's possible
to remount,rw and all changes are directed to this device.


-- 
Chris Murphy
