Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067593CF906
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 13:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbhGTLCb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 07:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237298AbhGTLCA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 07:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626781339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n6CRkkVDcUbWGOvKNrPboXEb+Fnw8bwD+7x+VNz7iJ0=;
        b=dE+VZiCEbzBM6brQy6VLKF3mwgyPpALpuB6OYq4sX8kbs+izGwOcubOmtGUe9WU11XFS/E
        2XJFd1QEzcpZGbexKQatHv0/oPSdivPhlTJ9VN7Nj6hQuH/kMcdZUIL+APPnpRQLMIwVli
        no39z/RqbEVa/AmAlmVY5bDC/TIcgJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-kwVincl4MVqK2PjzAgAODg-1; Tue, 20 Jul 2021 07:42:18 -0400
X-MC-Unique: kwVincl4MVqK2PjzAgAODg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6A801940925;
        Tue, 20 Jul 2021 11:42:00 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3C81784C9;
        Tue, 20 Jul 2021 11:41:58 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 16KBfwba021967;
        Tue, 20 Jul 2021 07:41:58 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 16KBfvNm021963;
        Tue, 20 Jul 2021 07:41:57 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 20 Jul 2021 07:41:57 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Pintu Agarwal <pintu.ping@gmail.com>
cc:     open list <linux-kernel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>, dm-devel@redhat.com,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>, agk@redhat.com,
        snitzer@redhat.com, shli@kernel.org, samitolvanen@google.com
Subject: Re: Kernel 4.14: Using dm-verity with squashfs rootfs - mounting
 issue
In-Reply-To: <CAOuPNLhqSpaTm3u4kFsnuZ0PLDKuX8wsxuF=vUJ1TEG0EP+L1g@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2107200737510.19984@file01.intranet.prod.int.rdu2.redhat.com>
References: <CAOuPNLhqSpaTm3u4kFsnuZ0PLDKuX8wsxuF=vUJ1TEG0EP+L1g@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="185206533-1311100962-1626781318=:19984"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185206533-1311100962-1626781318=:19984
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi

Try to set up dm-verity with block size 512 bytes.

I don't know what block size does squashfs use, but if the filesystem 
block size is smaller than dm-verity block size, it doesn't work.

Mikulas



On Tue, 20 Jul 2021, Pintu Agarwal wrote:

> Hi,
> 
> Our ARM32 Linux embedded system consists of these:
> * Linux Kernel: 4.14
> * Processor: Qualcomm Arm32 Cortex-A7
> * Storage: NAND 512MB
> * Platform: Simple busybox
> * Filesystem: UBIFS, Squashfs
> * Consists of nand raw partitions, squashfs ubi volumes.
> 
> My requirement:
> We wanted to use dm-verity at boot time to check the integrity of
> squashfs-rootfs before mounting.
> 
> Problem:
> dm-0 is not able to locate and mount the squash fs rootfs block.
> The same approach is working when emulating with ext4 but fails with squashfs.
> 
> Logs:
> [....]
> [    0.000000] Kernel command line: [...] verity="96160 12020
> d7b8a7d0c01b9aec888930841313a81603a50a2a7be44631c4c813197a50d681 0 "
> rootfstype=squashfs root=/dev/mtdblock34 ubi.mtd=30,0,30 [...]
> root=/dev/dm-0 dm="system none ro,0 96160 verity 1 /dev/mtdblock34
> /dev/mtdblock39 4096 4096 12020 8 sha256
> d7b8a7d0c01b9aec888930841313a81603a50a2a7be44631c4c813197a50d681
> aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7"
> [....]
> [    4.693620] vreg_conn_pa: disa▒[    4.700662] md: Skipping
> autodetection of RAID arrays. (raid=autodetect will force)
> [    4.700713] device-mapper: init: attempting early device configuration.
> [    4.708224] device-mapper: init: adding target '0 96160 verity 1
> /dev/mtdblock34 /dev/mtdblock39 4096 4096 12020 8 sha256
> d7b8a7d0c01b9aec888930841313a81603a50a2a7be44631c4c813197a50d681
> aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7'
> [    4.714979] device-mapper: verity: sha256 using implementation
> "sha256-generic"
> [    4.737808] device-mapper: init: dm-0 is ready
> [....]
> [    5.278103] No filesystem could mount root, tried:
> [    5.278107]  squashfs
> [    5.280477]
> [    5.287627] Kernel panic - not syncing: VFS: Unable to mount root
> fs on unknown-block(253,0)
> [...]
> 
> Not sure, why is it still locating block "253" here which seems like a
> MAJOR number ?
> 
> Working logs on ext4:
> [....]
> [    4.529822] v▒[    4.534035] md: Skipping autodetection of RAID
> arrays. (raid=autodetect will force)
> [    4.534087] device-mapper: init: attempting early device configuration.
> [    4.550316] device-mapper: init: adding target '0 384440 verity 1
> /dev/ubiblock0_0 /dev/ubiblock0_0 4096 4096 48055 48063 sha256
> a02e0c13afb31e99b999c64aae6f4644c24addbc58db5689902cc5ba0be2d15b
> aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7 10
> restart_on_corruption ignore_zero_blocks use_fec_from_device
> /dev/ubiblock0_0 fec_roots 2 fec_blocks 48443 fec_start 48443'
> [    4.572215] device-mapper: verity: sha256 using implementation
> "sha256-generic"
> [    4.610692] device-mapper: init: dm-0 is ready
> [    4.720174] EXT4-fs (dm-0): mounted filesystem with ordered data
> mode. Opts: (null)
> [    4.720438] VFS: Mounted root (ext4 filesystem) readonly on device 253:0.
> [    4.737256] devtmpfs: mounted
> [....]
> 
> Questions:
> a) Is dm-verity supposed to work on squashfs block devices ?
> b) Are there any known issues with dm-verity on Kernel 4.14 ?
> c) Are there any patches that we are missing ?
> 
> 
> Thanks,
> Pintu
> 
--185206533-1311100962-1626781318=:19984--

