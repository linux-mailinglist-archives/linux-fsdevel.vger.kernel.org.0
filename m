Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C553CF702
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 11:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhGTI6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 04:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhGTI6J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:58:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4494BC061574;
        Tue, 20 Jul 2021 02:38:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t3so27631839edc.7;
        Tue, 20 Jul 2021 02:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ob2cL9xsCuqI2PtZCWk4ZnfruGA/KtiWAaZc2Xrr4AE=;
        b=goq6yCQPn/6AnEsFbyX2k+3qh8cv1+Kn3s6p2QPPbSaOJTqpkvxalHq2CtwvJ/x9NH
         MaPHlgNqCVgT0yrQoPQxlanIWryDj5GNQkebvgmavNwAyt/sLhZiRD2uU5/FshixSweE
         tRXovwpnIBJCdOuFamWmlVnIT1wMpzyAMwBvzlS+a9nGB1U9InErKigu4UuRtbMWEgej
         +1URvihDMERpFLKHK+LbEJWBuGdVDbsLAVEZiMgl502Je1yTiPvO/TPBJmegUQ5BMwH8
         0j0F8SxJQwBCpjDjI3gJ60pAY8W7DKaVDx/cwN+afAu/BiQoS3u8r++tINTjkE9mR8aP
         o7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ob2cL9xsCuqI2PtZCWk4ZnfruGA/KtiWAaZc2Xrr4AE=;
        b=db74qaueC+i+2fxS1k4Vc+ARBjFxr7aOJodBw8tUS8tt6vji8HrUTMd8DywYUAa0KH
         IbMVmGM5BMvzXV5c9af4Bqov2djL5xJrCnoUbQKLVvC1BctR8MFDQV/ne4KqecOv081/
         FVJP6edrSbNFJpoEbOYYsy9sL8KU4aLBe+2csbTXIeYiCPMs7SmJMGVRfNA6nwqogmdM
         0CR8ANqdTfDHWDJZZi10vgm44uHpsT3m3UJsPXmDZj8mx348plMkao7U+mt//Cd+i8+o
         yCdqX/bZjGn05on7fLGPz8ZTwvRBCc+w55DcuBL0R/BsmeMtMl9MRY/2stL1OtS2A6jX
         uJqQ==
X-Gm-Message-State: AOAM532MEBdDz6ZVGXEAhbqQX9GoMqw6/JLAtvGb7nqYKl1qeWgc/6++
        Lb8CSKwGp/SR7Qag/3+5KvDTskmeWeEKV3LaaEDzoFMSS7HTyQ==
X-Google-Smtp-Source: ABdhPJyFYULltN0VLmruKU6gln2nBG30ldbFf2khnefL2E+dRSChweVniLR25706q27205hxMP3yUCyt6LutA6yXFB8=
X-Received: by 2002:a05:6402:5209:: with SMTP id s9mr30408240edd.92.1626773925557;
 Tue, 20 Jul 2021 02:38:45 -0700 (PDT)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 20 Jul 2021 15:08:34 +0530
Message-ID: <CAOuPNLhqSpaTm3u4kFsnuZ0PLDKuX8wsxuF=vUJ1TEG0EP+L1g@mail.gmail.com>
Subject: Kernel 4.14: Using dm-verity with squashfs rootfs - mounting issue
To:     open list <linux-kernel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>, dm-devel@redhat.com,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>, agk@redhat.com,
        snitzer@redhat.com, shli@kernel.org, mpatocka@redhat.com,
        samitolvanen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Our ARM32 Linux embedded system consists of these:
* Linux Kernel: 4.14
* Processor: Qualcomm Arm32 Cortex-A7
* Storage: NAND 512MB
* Platform: Simple busybox
* Filesystem: UBIFS, Squashfs
* Consists of nand raw partitions, squashfs ubi volumes.

My requirement:
We wanted to use dm-verity at boot time to check the integrity of
squashfs-rootfs before mounting.

Problem:
dm-0 is not able to locate and mount the squash fs rootfs block.
The same approach is working when emulating with ext4 but fails with squash=
fs.

Logs:
[....]
[    0.000000] Kernel command line: [...] verity=3D"96160 12020
d7b8a7d0c01b9aec888930841313a81603a50a2a7be44631c4c813197a50d681 0 "
rootfstype=3Dsquashfs root=3D/dev/mtdblock34 ubi.mtd=3D30,0,30 [...]
root=3D/dev/dm-0 dm=3D"system none ro,0 96160 verity 1 /dev/mtdblock34
/dev/mtdblock39 4096 4096 12020 8 sha256
d7b8a7d0c01b9aec888930841313a81603a50a2a7be44631c4c813197a50d681
aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7"
[....]
[    4.693620] vreg_conn_pa: disa=E2=96=92[    4.700662] md: Skipping
autodetection of RAID arrays. (raid=3Dautodetect will force)
[    4.700713] device-mapper: init: attempting early device configuration.
[    4.708224] device-mapper: init: adding target '0 96160 verity 1
/dev/mtdblock34 /dev/mtdblock39 4096 4096 12020 8 sha256
d7b8a7d0c01b9aec888930841313a81603a50a2a7be44631c4c813197a50d681
aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7'
[    4.714979] device-mapper: verity: sha256 using implementation
"sha256-generic"
[    4.737808] device-mapper: init: dm-0 is ready
[....]
[    5.278103] No filesystem could mount root, tried:
[    5.278107]  squashfs
[    5.280477]
[    5.287627] Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(253,0)
[...]

Not sure, why is it still locating block "253" here which seems like a
MAJOR number ?

Working logs on ext4:
[....]
[    4.529822] v=E2=96=92[    4.534035] md: Skipping autodetection of RAID
arrays. (raid=3Dautodetect will force)
[    4.534087] device-mapper: init: attempting early device configuration.
[    4.550316] device-mapper: init: adding target '0 384440 verity 1
/dev/ubiblock0_0 /dev/ubiblock0_0 4096 4096 48055 48063 sha256
a02e0c13afb31e99b999c64aae6f4644c24addbc58db5689902cc5ba0be2d15b
aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7 10
restart_on_corruption ignore_zero_blocks use_fec_from_device
/dev/ubiblock0_0 fec_roots 2 fec_blocks 48443 fec_start 48443'
[    4.572215] device-mapper: verity: sha256 using implementation
"sha256-generic"
[    4.610692] device-mapper: init: dm-0 is ready
[    4.720174] EXT4-fs (dm-0): mounted filesystem with ordered data
mode. Opts: (null)
[    4.720438] VFS: Mounted root (ext4 filesystem) readonly on device 253:0=
.
[    4.737256] devtmpfs: mounted
[....]

Questions:
a) Is dm-verity supposed to work on squashfs block devices ?
b) Are there any known issues with dm-verity on Kernel 4.14 ?
c) Are there any patches that we are missing ?


Thanks,
Pintu
