Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0FA3ED030
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 10:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbhHPI1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 04:27:55 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:54979 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbhHPI1z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 04:27:55 -0400
Received: by mail-io1-f72.google.com with SMTP id o5-20020a6bf8050000b02905b026202a6fso5080580ioh.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Aug 2021 01:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0Q36JBmE+WRWq5GWrnH+Lxe/XmMCBfjGVMSABWLJLm0=;
        b=g93H7kqTIFpQ7NV/WtgYtsKQfFcMp+CzoFPrw6KuvPaZ8aG62UDVjBXdj9wuFC3P37
         TDwMYywm2J0na/+YA4K1z7SlK2vvXFEGZQyO4e3Q5ANEfB7+ozo3El8+/D7zmEIAEZHK
         2fTZFE8D87bU2xpRmm3i/5UCBqsGCGzrRYmCOUrCOKBRA2k9eNbGWKs1jDXOU4icMVyH
         7E9girsxodYFDPvMGgwmZW3z4sso8XzlMAozUdcQdPL9GbYy/jzIQXXZ3zFQG1CEUu56
         tthpjaGRL7esWybVLDs4gzZ1pVARj87iTZXcHk91v44fnkNijuBTI215TTcgZ9TsFUKb
         wOvg==
X-Gm-Message-State: AOAM533pLFP30rIOKbqcbMSihnd50sWD2qauIeUGIIzYrTUZfeU1dnLt
        Lz4kJPD7kFJ9ft60qqSYPL9w6eN4HFCZwYdp/GJbKs32m0TO
X-Google-Smtp-Source: ABdhPJzvUF5ahsEv8SmKcF/fy2P7hTr1F5Y8MvPARCzesZCwsJ0Bx71tylEYenNrocGHC2o5S8jnjAULfYUPDzesH6CVov/zqyk3
MIME-Version: 1.0
X-Received: by 2002:a05:6638:191c:: with SMTP id p28mr11815684jal.41.1629102444187;
 Mon, 16 Aug 2021 01:27:24 -0700 (PDT)
Date:   Mon, 16 Aug 2021 01:27:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007d148a05c9a8f898@google.com>
Subject: [syzbot] KASAN: use-after-free Read in __d_alloc (2)
From:   syzbot <syzbot+fb0d60a179096e8c2731@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b9011c7e671d Add linux-next specific files for 20210816
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17cc067e300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a245d1aa4f055cc1
dashboard link: https://syzkaller.appspot.com/bug?extid=fb0d60a179096e8c2731
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb0d60a179096e8c2731@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in memcpy include/linux/fortify-string.h:191 [inline]
BUG: KASAN: use-after-free in __d_alloc+0x19a/0x950 fs/dcache.c:1775
Read of size 5 at addr ffff88807c499120 by task kdevtmpfs/22

CPU: 0 PID: 22 Comm: kdevtmpfs Not tainted 5.14.0-rc5-next-20210816-syzkaller #0
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

The buggy address belongs to the object at ffff88807c499100
 which belongs to the cache names_cache of size 4096
The buggy address is located 32 bytes inside of
 4096-byte region [ffff88807c499100, ffff88807c49a100)
The buggy address belongs to the page:
page:ffffea0001f12600 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88807c49e600 pfn:0x7c498
head:ffffea0001f12600 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 0000000100000001 ffff888010dc53c0
raw: ffff88807c49e600 0000000080070005 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2981, ts 211981674424, free_ts 211786490796
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
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:138
 getname_flags+0x9a/0xe0 include/linux/audit.h:319
 user_path_at_empty+0x2b/0x90 fs/namei.c:2801
 user_path_at include/linux/namei.h:57 [inline]
 do_faccessat+0x127/0x850 fs/open.c:425
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x373/0x860 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3315 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3394
 qlink_free mm/kasan/quarantine.c:146 [inline]
 qlist_free_all+0x5a/0xc0 mm/kasan/quarantine.c:165
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0x8e/0xa0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:254 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:3173 [inline]
 slab_alloc mm/slub.c:3181 [inline]
 __kmalloc+0x1eb/0x320 mm/slub.c:4354
 kmalloc include/linux/slab.h:596 [inline]
 tomoyo_realpath_from_path+0xc3/0x620 security/tomoyo/realpath.c:254
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x21b/0x400 security/tomoyo/file.c:822
 security_inode_getattr+0xcf/0x140 security/security.c:1333
 vfs_getattr fs/stat.c:157 [inline]
 vfs_fstat+0x43/0xb0 fs/stat.c:182
 __do_sys_newfstat+0x81/0x100 fs/stat.c:422
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff88807c499000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807c499080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807c499100: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88807c499180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c499200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
