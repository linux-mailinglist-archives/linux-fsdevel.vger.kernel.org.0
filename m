Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8556F3EE1FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 03:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhHQBOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 21:14:51 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:47809 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhHQBOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:14:50 -0400
Received: by mail-io1-f69.google.com with SMTP id f1-20020a5edf01000000b005b85593f933so667838ioq.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Aug 2021 18:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Z3X8403/fr3kHezVLEO9JYPsZegPxIpm1kX7Yl1Mzbg=;
        b=PEXsFT7f7f+TAte5xDdEOiilfdkjvuIgmsOK4pcLiyy1DXXKi60DO30tNRHCgDl/pz
         kGuaIxla+6P9lTtFytKq7VnymhQPvasOHz1UTQLeBsqCbSQd05Ni3R/OWgwRaaCYalyt
         wSmcA/ZUD2w4aiAOl1EsloIo5q9Dcxq7DHq+hdcm6UFycMoiXta7NgaDpPd4gVkDmLJu
         X0/CaBeDW7zxnLwRI+X04yjQa4a6KFrC7B94WgfV2uXrn7nRhhIL8MeYrOm8IR4qnB0h
         fiA49wvzeYCok1KpU/jVRy785byRZeuS7zIQk2qsdvNxoXmCa7SUFJB0PjFiNr67DMXA
         7uqA==
X-Gm-Message-State: AOAM533r1gauemphntZq8bjt/S08S+QxS0VBeprMedOznjpvRKMXqrss
        N4ixjb08wQvVWiItIN96LQnN6Hwmbunb2fqNPBPOxp3kR5/O
X-Google-Smtp-Source: ABdhPJwDiyGQxhLwX63DZZ3pduxAzJxyiRwpEN9nR/OMV/LZM3kpxGNONzw/XjelZtmnD9mcsMf2YshOEll9BcL8GlTcQtUvxh8p
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ee1:: with SMTP id j1mr48277ilk.61.1629162858424;
 Mon, 16 Aug 2021 18:14:18 -0700 (PDT)
Date:   Mon, 16 Aug 2021 18:14:18 -0700
In-Reply-To: <0000000000007d148a05c9a8f898@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007532de05c9b709ca@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __d_alloc (2)
From:   syzbot <syzbot+fb0d60a179096e8c2731@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    b9011c7e671d Add linux-next specific files for 20210816
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16364131300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a245d1aa4f055cc1
dashboard link: https://syzkaller.appspot.com/bug?extid=fb0d60a179096e8c2731
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149ada7e300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12860919300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb0d60a179096e8c2731@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in memcpy include/linux/fortify-string.h:191 [inline]
BUG: KASAN: use-after-free in __d_alloc+0x19a/0x950 fs/dcache.c:1775
Read of size 5 at addr ffff88801978d520 by task kdevtmpfs/22

CPU: 1 PID: 22 Comm: kdevtmpfs Not tainted 5.14.0-rc5-next-20210816-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 memcpy+0x20/0x60 mm/kasan/shadow.c:65
 memcpy include/linux/fortify-string.h:191 [inline]
 __d_alloc+0x19a/0x950 fs/dcache.c:1775
 d_alloc+0x4a/0x230 fs/dcache.c:1823
 __lookup_hash+0xc8/0x180 fs/namei.c:1554
 kern_path_locked+0x17e/0x320 fs/namei.c:2567
 handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Allocated by task 22:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 __kasan_slab_alloc+0x84/0xa0 mm/kasan/common.c:467
 kasan_slab_alloc include/linux/kasan.h:254 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:3173 [inline]
 slab_alloc mm/slub.c:3181 [inline]
 kmem_cache_alloc+0x20d/0x390 mm/slub.c:3186
 getname_kernel+0x4e/0x370 fs/namei.c:226
 kern_path_locked+0x71/0x320 fs/namei.c:2558
 handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Freed by task 22:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xfb/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:1681 [inline]
 slab_free_freelist_hook+0x7e/0x190 mm/slub.c:1706
 slab_free mm/slub.c:3450 [inline]
 kmem_cache_free+0x8a/0x5a0 mm/slub.c:3466
 putname.part.0+0xe1/0x120 fs/namei.c:270
 putname include/linux/err.h:41 [inline]
 filename_parentat fs/namei.c:2547 [inline]
 kern_path_locked+0xc2/0x320 fs/namei.c:2558
 handle_remove+0xa2/0x5fe drivers/base/devtmpfs.c:312
 handle drivers/base/devtmpfs.c:382 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
 devtmpfsd+0x1b9/0x2a3 drivers/base/devtmpfs.c:437
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

The buggy address belongs to the object at ffff88801978d500
 which belongs to the cache names_cache of size 4096
The buggy address is located 32 bytes inside of
 4096-byte region [ffff88801978d500, ffff88801978e500)
The buggy address belongs to the page:
page:ffffea000065e200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x19788
head:ffffea000065e200 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea0001e1e600 0000000200000002 ffff888010dc53c0
raw: 0000000000000000 0000000080070007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 328, ts 7013756312, free_ts 0
 prep_new_page mm/page_alloc.c:2424 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4151
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5373
 alloc_pages+0x1a7/0x300 mm/mempolicy.c:2188
 alloc_slab_page mm/slub.c:1744 [inline]
 allocate_slab mm/slub.c:1881 [inline]
 new_slab+0x319/0x490 mm/slub.c:1944
 ___slab_alloc+0x8b9/0xf50 mm/slub.c:2961
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3048
 slab_alloc_node mm/slub.c:3139 [inline]
 slab_alloc mm/slub.c:3181 [inline]
 kmem_cache_alloc+0x369/0x390 mm/slub.c:3186
 getname_kernel+0x4e/0x370 fs/namei.c:226
 kernel_execve+0x24/0x460 fs/exec.c:1939
 call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801978d400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801978d480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801978d500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88801978d580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801978d600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

