Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDFD33C755
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 21:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhCOUDF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 16:03:05 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:33975 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbhCOUCz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:02:55 -0400
Received: by mail-ej1-f50.google.com with SMTP id si25so12686408ejb.1;
        Mon, 15 Mar 2021 13:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=embSwMWKLR6mcojsmr9qI/asFqc3qxsVqoQVl8EgYLk=;
        b=Ap6WK7et//RMwv4PoAfLVBkmaxWXZSlNS/OzSouGECrQf8rKNt63SgZPIboy85WY9k
         Yms0aoKrSSkzJo8PRI0d24R2TNPFZyV9qi33qTWS+aoqp5ruYzRWQSvHnMN9PwxbWer2
         U6Bb8cZm6yprSFweJgsTvUBiNUcC8RJl2xa7pfGm+MUuYM/iT1X8DS9rs4WAd/FLC+7C
         JIezABlNqWaX2v6Vde1sADiH8d9tiiLRb722494oiKhwmCk57opEE6r++9MuZOC4TzDS
         LF8yoW9SfQcbvWjqgV14rduwUE/1CPra19eT9/V+QaucxdBKlHMQmLOJyEJlCCCwcQRR
         Y0BA==
X-Gm-Message-State: AOAM5335k+GFNkQRqde06k3BlNVRz+ROleIaEofu5T2gFUEvtIjX5WGE
        XYeiaDjWk4haNfq8yhb/Q4IPpgbuAHydaw==
X-Google-Smtp-Source: ABdhPJyx3QM4ywAoSpn8hnDr2mudD6du5ZjdHOy0G7Uo62mvt+m3mjQ1/YY5ppPB6qChgQAlR+O8mg==
X-Received: by 2002:a17:906:3b47:: with SMTP id h7mr25280421ejf.377.1615838573458;
        Mon, 15 Mar 2021 13:02:53 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-188-216-41-250.cust.vodafonedsl.it. [188.216.41.250])
        by smtp.gmail.com with ESMTPSA id x21sm8551210eds.53.2021.03.15.13.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 13:02:52 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH -next 0/5] block: add a sequence number to disks
Date:   Mon, 15 Mar 2021 21:02:37 +0100
Message-Id: <20210315200242.67355-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.30.2
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

This is just a resend after the merge window and rebased on linux-block.
Also, added more people in CC from the get_maintainer.pl output
as well as -next in the subject.

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
2.30.2

