Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101E74310DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 08:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhJRGx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 02:53:26 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14824 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhJRGxZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 02:53:25 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HXnTQ5srLz90F9;
        Mon, 18 Oct 2021 14:46:18 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 14:51:13 +0800
Received: from linux-suspe12sp5.huawei.com (10.67.133.83) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 14:51:12 +0800
From:   ChenJingwen <chenjingwen6@huawei.com>
To:     <keescook@chromium.org>
CC:     <akpm@linux-foundation.org>, <avagin@openvz.org>,
        <chenjingwen6@huawei.com>, <khalid.aziz@oracle.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mhocko@suse.com>, <mpe@ellerman.id.au>,
        <torvalds@linux-foundation.org>, <viro@zeniv.linux.org.uk>
Subject: [PATCH] elf: don't use MAP_FIXED_NOREPLACE for elf interpreter mappings
Date:   Mon, 18 Oct 2021 14:51:12 +0800
Message-ID: <20211018065112.170631-1-chenjingwen6@huawei.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <202110041255.83A6616D9@keescook>
References: <202110041255.83A6616D9@keescook>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.133.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> >  The reason is that the elf interpreter (ld.so) has overlapping segments.
> >
> Ewww. What toolchain generated this (and what caused it to just start
> happening)? (This was added in v4.17; it's been 3 years.)

gcc 7.3.0 for powerpc Book3E (e5500).

I wonder if there are some linker options related to the overlapping segments.
I tried to find it out why but I failed. And I also didn't see the answer in the
previous discussion yet (Maybe I missed it).

What confuses me is why the other reports only have overlapping sections for
executable binaries or dynamic libraries, but not for their ld.so.
I can keep looking for the reason but it may take a longe time for me.

> > readelf -l ld-2.31.so
> > Program Headers:
> >   Type           Offset             VirtAddr           PhysAddr
> >                  FileSiz            MemSiz              Flags  Align
> >   LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
> >                  0x000000000002c94c 0x000000000002c94c  R E    0x10000
> >   LOAD           0x000000000002dae0 0x000000000003dae0 0x000000000003dae0
> >                  0x00000000000021e8 0x0000000000002320  RW     0x10000
> >   LOAD           0x000000000002fe00 0x000000000003fe00 0x000000000003fe00
> >                  0x00000000000011ac 0x0000000000001328  RW     0x10000
> > 
> > The reason for this problem is the same as described in
> > commit ad55eac74f20 ("elf: enforce MAP_FIXED on overlaying elf segments").
> > Not only executable binaries, elf interpreters (e.g. ld.so) can have
> > overlapping elf segments, so we better drop MAP_FIXED_NOREPLACE and go
> > back to MAP_FIXED in load_elf_interp.
>
> We could also just expand the logic that fixed[1] this for ELF, yes?
>
> Andrew, are you able to pick up [1], BTW? It seems to have fallen
> through the cracks.
>
> [1] https://lore.kernel.org/all/20210916215947.3993776-1-keescook@chromium.org/T/#u

Yes, I expand the logic[1] to load_elf_interp and "init" succeeds to start.
Should I submit another patch?
