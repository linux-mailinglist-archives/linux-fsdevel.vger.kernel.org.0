Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE2311965
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Feb 2021 04:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhBFDDr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 22:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhBFCwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:52:51 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7BBC033275;
        Fri,  5 Feb 2021 17:26:54 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id a8so12786755lfi.8;
        Fri, 05 Feb 2021 17:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYoAF7gPgCmz0hFYeiRmD4lOmSaTwA1DbF9cbEqAcQ0=;
        b=ie63wiewQTPFO5AyrseRnYIWAna3cvOcmTRM5ltEPbD/emfDeZilCvFSRht467yRcU
         ZEB6fBxFTpZEoCOnKTGrp9PBRcBCX3ds2VEpVtxD65Iazdpv8z+lAVJmFOfJgoYTkUg2
         AVJyZJLnX4OYRbYlHYVeuO7tRizj+wEnCT69pI745LhjTB0wyk69MifKgYNnKyMTa10r
         udJG6kPRhuAJbQoryGMdbrSF1fFeiZXSd/+do9GOTUK6XdDnIh1Behu/KA/ndg1Zd2r7
         jVtx9qjqZi8M5yYCCSkxAmC8ul2LD8nDoNeQUkYReihA75x6X6dfGPSdpmTWbWuJVDNP
         owLw==
X-Gm-Message-State: AOAM531BqxcM1IzhRPKa5mHXDJEWIaJvx8RUP8VZJOtFUr63kUX1MBAc
        H2Q8iiwZ9A1OrPRYmaZWTNezPSIHBBc=
X-Google-Smtp-Source: ABdhPJz0zPGnTDbhSwzmVhzv+2yGPRYdicJfRxej/w+rmJd8/nndZwohleSblLFZNNYj9MfNIOTTQw==
X-Received: by 2002:a5d:49c1:: with SMTP id t1mr7634170wrs.56.1612570147262;
        Fri, 05 Feb 2021 16:09:07 -0800 (PST)
Received: from msft-t490s.teknoraver.net (net-37-182-2-234.cust.vodafonedsl.it. [37.182.2.234])
        by smtp.gmail.com with ESMTPSA id d3sm14566390wrp.79.2021.02.05.16.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 16:09:06 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 0/5] block: add a sequence number to disks
Date:   Sat,  6 Feb 2021 01:08:58 +0100
Message-Id: <20210206000903.215028-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

With this series a monotonically increasing number is added to disks,
precisely in the genhd struct, and it's exported in sysfs and uevent.

This helps the userspace correlate events for devices that reuse the
same device, like loop.

The first patch is the core one, the 2..4 expose the information in
different ways, while the last one increase the sequence number for
loop devices at every attach.

    # udevadm monitor -kp |grep -e ^DEVNAME -e ^DISKSEQ &
    [1] 523
    # losetup -fP 3part
    [ 3698.615848] loop0: detected capacity change from 16384 to 0
    DEVNAME=/dev/loop0
    DISKSEQ=13
    [ 3698.647189]  loop0: p1 p2 p3
    DEVNAME=/dev/loop0
    DISKSEQ=13
    DEVNAME=/dev/loop0p1
    DISKSEQ=13
    DEVNAME=/dev/loop0p2
    DISKSEQ=13
    DEVNAME=/dev/loop0p3
    DISKSEQ=13
    # losetup -fP 2part
    [ 3705.170766] loop1: detected capacity change from 40960 to 0
    DEVNAME=/dev/loop1
    DISKSEQ=14
    [ 3705.247280]  loop1: p1 p2
    DEVNAME=/dev/loop1
    DISKSEQ=14
    DEVNAME=/dev/loop1p1
    DISKSEQ=14
    DEVNAME=/dev/loop1p2
    DISKSEQ=14
    # ./getdiskseq /dev/loop*
    /dev/loop0:     13
    /dev/loop0p1:   13
    /dev/loop0p2:   13
    /dev/loop0p3:   13
    /dev/loop1:     14
    /dev/loop1p1:   14
    /dev/loop1p2:   14
    /dev/loop2:     5
    /dev/loop3:     6
    /dev/loop-control: Function not implemented
    # grep . /sys/class/block/*/diskseq
    /sys/class/block/loop0/diskseq:13
    /sys/class/block/loop1/diskseq:14
    /sys/class/block/loop2/diskseq:5
    /sys/class/block/loop3/diskseq:6
    /sys/class/block/ram0/diskseq:1
    /sys/class/block/ram1/diskseq:2
    /sys/class/block/vda/diskseq:7

If merged, this feature will immediately used by the userspace:
https://github.com/systemd/systemd/issues/17469#issuecomment-762919781

Matteo Croce (5):
  block: add disk sequence number
  block: add ioctl to read the disk sequence number
  block: refactor sysfs code
  block: export diskseq in sysfs
  loop: increment sequence number

 Documentation/ABI/testing/sysfs-block | 12 ++++++++
 block/genhd.c                         | 43 ++++++++++++++++++++++++---
 block/ioctl.c                         |  2 ++
 drivers/block/loop.c                  |  3 ++
 include/linux/genhd.h                 |  2 ++
 include/uapi/linux/fs.h               |  1 +
 6 files changed, 59 insertions(+), 4 deletions(-)

-- 
2.29.2

