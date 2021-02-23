Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98F9322DEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 16:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhBWPsy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 10:48:54 -0500
Received: from linux.microsoft.com ([13.77.154.182]:41060 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbhBWPsI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:48:08 -0500
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by linux.microsoft.com (Postfix) with ESMTPSA id B74C42089C9B;
        Tue, 23 Feb 2021 07:47:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B74C42089C9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614095247;
        bh=CNobBivITyIZHfV9IIhBh12WyKXN0ArCPEmTlhSkQys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AnWeEW+Ah60JQOeGC0VbHERpDEPpLFss8vZ9u9f1/Zj/tWCEOvEaNwGrEJHsKUib8
         k/IxJZVPeLBQm2ku7quSz0P7Fb1VzwXEeKzxkZNByyfl1VskznqcWyc8zLI7Xq8I2c
         pINtq091F6bkw43wY5mu0wF7wRD2HO3tzV4nUV10=
Received: by mail-pf1-f178.google.com with SMTP id w18so9010011pfu.9;
        Tue, 23 Feb 2021 07:47:27 -0800 (PST)
X-Gm-Message-State: AOAM530fb7kMUxO8Tah2WM4y+nDQwVed39m0t31rVu9g9MdNHb/5b5A/
        DPNLqCZqfAgf2Pbci3HfoPvjny7V/DU74BHCaIc=
X-Google-Smtp-Source: ABdhPJxpQGF6YDtaKy9RwYuxdhixk5+xajdkcOUF6LcT/2J4R6s08m7LRjdk1BOqzpmP8JcZJdeTBLElCiLzh161BEo=
X-Received: by 2002:a62:fc45:0:b029:1ed:bdd2:a07d with SMTP id
 e66-20020a62fc450000b02901edbdd2a07dmr2847913pfh.0.1614095247349; Tue, 23 Feb
 2021 07:47:27 -0800 (PST)
MIME-Version: 1.0
References: <20210206000903.215028-1-mcroce@linux.microsoft.com>
In-Reply-To: <20210206000903.215028-1-mcroce@linux.microsoft.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Tue, 23 Feb 2021 16:46:51 +0100
X-Gmail-Original-Message-ID: <CAFnufp1zuXTVcNvSX9eE9hekZ6h455JVve0q2=Ht+xd007CVdQ@mail.gmail.com>
Message-ID: <CAFnufp1zuXTVcNvSX9eE9hekZ6h455JVve0q2=Ht+xd007CVdQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] block: add a sequence number to disks
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 6, 2021 at 1:09 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> From: Matteo Croce <mcroce@microsoft.com>
>
> With this series a monotonically increasing number is added to disks,
> precisely in the genhd struct, and it's exported in sysfs and uevent.
>
> This helps the userspace correlate events for devices that reuse the
> same device, like loop.
>
> The first patch is the core one, the 2..4 expose the information in
> different ways, while the last one increase the sequence number for
> loop devices at every attach.
>
>     # udevadm monitor -kp |grep -e ^DEVNAME -e ^DISKSEQ &
>     [1] 523
>     # losetup -fP 3part
>     [ 3698.615848] loop0: detected capacity change from 16384 to 0
>     DEVNAME=/dev/loop0
>     DISKSEQ=13
>     [ 3698.647189]  loop0: p1 p2 p3
>     DEVNAME=/dev/loop0
>     DISKSEQ=13
>     DEVNAME=/dev/loop0p1
>     DISKSEQ=13
>     DEVNAME=/dev/loop0p2
>     DISKSEQ=13
>     DEVNAME=/dev/loop0p3
>     DISKSEQ=13
>     # losetup -fP 2part
>     [ 3705.170766] loop1: detected capacity change from 40960 to 0
>     DEVNAME=/dev/loop1
>     DISKSEQ=14
>     [ 3705.247280]  loop1: p1 p2
>     DEVNAME=/dev/loop1
>     DISKSEQ=14
>     DEVNAME=/dev/loop1p1
>     DISKSEQ=14
>     DEVNAME=/dev/loop1p2
>     DISKSEQ=14
>     # ./getdiskseq /dev/loop*
>     /dev/loop0:     13
>     /dev/loop0p1:   13
>     /dev/loop0p2:   13
>     /dev/loop0p3:   13
>     /dev/loop1:     14
>     /dev/loop1p1:   14
>     /dev/loop1p2:   14
>     /dev/loop2:     5
>     /dev/loop3:     6
>     /dev/loop-control: Function not implemented
>     # grep . /sys/class/block/*/diskseq
>     /sys/class/block/loop0/diskseq:13
>     /sys/class/block/loop1/diskseq:14
>     /sys/class/block/loop2/diskseq:5
>     /sys/class/block/loop3/diskseq:6
>     /sys/class/block/ram0/diskseq:1
>     /sys/class/block/ram1/diskseq:2
>     /sys/class/block/vda/diskseq:7
>
> If merged, this feature will immediately used by the userspace:
> https://github.com/systemd/systemd/issues/17469#issuecomment-762919781
>
> Matteo Croce (5):
>   block: add disk sequence number
>   block: add ioctl to read the disk sequence number
>   block: refactor sysfs code
>   block: export diskseq in sysfs
>   loop: increment sequence number
>
>  Documentation/ABI/testing/sysfs-block | 12 ++++++++
>  block/genhd.c                         | 43 ++++++++++++++++++++++++---
>  block/ioctl.c                         |  2 ++
>  drivers/block/loop.c                  |  3 ++
>  include/linux/genhd.h                 |  2 ++
>  include/uapi/linux/fs.h               |  1 +
>  6 files changed, 59 insertions(+), 4 deletions(-)
>
> --
> 2.29.2
>

Hi,

Did anyone have a chance to look at this series?

Ideas or suggestions?

Regards,


--
per aspera ad upstream
