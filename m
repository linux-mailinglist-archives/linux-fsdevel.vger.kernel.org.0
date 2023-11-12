Return-Path: <linux-fsdevel+bounces-2764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E013B7E8E75
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 06:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3898B280D0D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 05:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C79833E3;
	Sun, 12 Nov 2023 05:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECEF2572
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 05:32:24 +0000 (UTC)
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E32030C5
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Nov 2023 21:32:22 -0800 (PST)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1cc56a9ece7so37963035ad.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Nov 2023 21:32:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699767142; x=1700371942;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wecRkOhay6AJ4tUOWQxw2D+dWI3NX6R2AnmUaHgFBYA=;
        b=eS7HRU7UsAdOouSk3XY2OWueffceqvokjq/LxZQUYxnHtCuxm1PoboRr9Zj1PH7Mth
         ajBDaCxcPF/a/82Me+R84W8J50eovnkGx9QDCtGS6cwhU8UxYYZJh9L01PIx2ZY0hujv
         0kcjXGmVFtKBU4fmuOPS8ZTpRLorYSt8/k5DafB2AzAAlwFo5/pgoTw55+hIaJSYyTjZ
         qIjb5PGC6ecAaYWegpNhztN2h8aa5PoPe+I4cHxnQM2WkitZWHMt+wKQY3F1y1HZQFLJ
         tI/+oY6ZggwHcq7xJsU/khzyZMmuZbkjVA+suTJ5kreobZsIz8Jx8FjxrYcw9FrpzbXF
         w/+Q==
X-Gm-Message-State: AOJu0YxKk5cZ6eKnQt/LDif+zvpihGCbksRhdous0+VN2SqLsLRnn9MA
	dpSc8wHIamwmM0YvbGz4XfIT1cjdvN/bcgky5o0RL/EgmJJu
X-Google-Smtp-Source: AGHT+IG1lx/yjlVQF+HQZKha5UErC5X0xoo1VV0VVjq9IFSuxvVkPSBy0jQmUe83QpS3BWIxze+2mD29esKiUe9gptCTvSswx0jB
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:2790:b0:1cc:229a:89f7 with SMTP id
 jw16-20020a170903279000b001cc229a89f7mr1088141plb.5.1699767141922; Sat, 11
 Nov 2023 21:32:21 -0800 (PST)
Date: Sat, 11 Nov 2023 21:32:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1fda20609ede0d1@google.com>
Subject: [syzbot] [squashfs?] KASAN: slab-out-of-bounds Write in
 squashfs_readahead (2)
From: syzbot <syzbot+604424eb051c2f696163@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk, 
	squashfs-devel@lists.sourceforge.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    13d88ac54ddd Merge tag 'vfs-6.7.fsid' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=121965ef680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=604424eb051c2f696163
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b40c7b680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f691ef680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9e81dc4903c2/disk-13d88ac5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f40fd7326b3f/vmlinux-13d88ac5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2f399cd6ff7d/bzImage-13d88ac5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8e127c645a04/mount_0.gz

The issue was bisected to:

commit f268eedddf3595e85f8883dc50aed29654785696
Author: Phillip Lougher <phillip@squashfs.org.uk>
Date:   Sat Jun 11 03:21:32 2022 +0000

    squashfs: extend "page actor" to handle missing pages

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1252b717680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1152b717680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1652b717680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+604424eb051c2f696163@syzkaller.appspotmail.com
Fixes: f268eedddf35 ("squashfs: extend "page actor" to handle missing pages")

SQUASHFS error: Unable to read metadata cache entry [6fa]
SQUASHFS error: Unable to read metadata cache entry [6fa]
SQUASHFS error: Unable to read metadata cache entry [6fa]
==================================================================
BUG: KASAN: slab-out-of-bounds in __readahead_batch include/linux/pagemap.h:1364 [inline]
BUG: KASAN: slab-out-of-bounds in squashfs_readahead+0x9a6/0x20d0 fs/squashfs/file.c:569
Write of size 8 at addr ffff88801e393648 by task syz-executor100/5067

CPU: 1 PID: 5067 Comm: syz-executor100 Not tainted 6.6.0-syzkaller-15156-g13d88ac54ddd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x142/0x170 mm/kasan/report.c:588
 __readahead_batch include/linux/pagemap.h:1364 [inline]
 squashfs_readahead+0x9a6/0x20d0 fs/squashfs/file.c:569
 read_pages+0x183/0x830 mm/readahead.c:160
 page_cache_ra_unbounded+0x68e/0x7c0 mm/readahead.c:269
 page_cache_sync_readahead include/linux/pagemap.h:1266 [inline]
 filemap_get_pages+0x49c/0x2080 mm/filemap.c:2497
 filemap_read+0x42b/0x10b0 mm/filemap.c:2593
 __kernel_read+0x425/0x8b0 fs/read_write.c:428
 integrity_kernel_read+0xb0/0xf0 security/integrity/iint.c:221
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0xad1/0x1b30 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x554/0xb30 security/integrity/ima/ima_api.c:290
 process_measurement+0x1373/0x21c0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xf1/0x170 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3624 [inline]
 path_openat+0x2893/0x3280 fs/namei.c:3779
 do_filp_open+0x234/0x490 fs/namei.c:3809
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_open fs/open.c:1463 [inline]
 __se_sys_open fs/open.c:1459 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1459
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f0e73d6c5f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd516ff158 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007f0e73d6c5f9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
RBP: 00007f0e73ddf610 R08: 0000000000000225 R09: 0000000000000000
R10: 00007ffd516ff020 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd516ff328 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 5067:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1007 [inline]
 __kmalloc+0xb9/0x230 mm/slab_common.c:1020
 kmalloc_array include/linux/slab.h:637 [inline]
 squashfs_readahead+0x30c/0x20d0 fs/squashfs/file.c:552
 read_pages+0x183/0x830 mm/readahead.c:160
 page_cache_ra_unbounded+0x68e/0x7c0 mm/readahead.c:269
 page_cache_sync_readahead include/linux/pagemap.h:1266 [inline]
 filemap_get_pages+0x49c/0x2080 mm/filemap.c:2497
 filemap_read+0x42b/0x10b0 mm/filemap.c:2593
 __kernel_read+0x425/0x8b0 fs/read_write.c:428
 integrity_kernel_read+0xb0/0xf0 security/integrity/iint.c:221
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0xad1/0x1b30 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x554/0xb30 security/integrity/ima/ima_api.c:290
 process_measurement+0x1373/0x21c0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xf1/0x170 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3624 [inline]
 path_openat+0x2893/0x3280 fs/namei.c:3779
 do_filp_open+0x234/0x490 fs/namei.c:3809
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_open fs/open.c:1463 [inline]
 __se_sys_open fs/open.c:1459 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1459
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff88801e393640
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 8-byte region [ffff88801e393640, ffff88801e393648)

The buggy address belongs to the physical page:
page:ffffea000078e4c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88801e393230 pfn:0x1e393
anon flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888012c41280 0000000000000000 dead000000000001
raw: ffff88801e393230 0000000080660063 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 10649202635, free_ts 9358727270
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1544 [inline]
 get_page_from_freelist+0x339a/0x3530 mm/page_alloc.c:3312
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4568
 alloc_pages_mpol+0x3de/0x640 mm/mempolicy.c:2133
 alloc_slab_page+0x6a/0x160 mm/slub.c:1870
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2070
 ___slab_alloc+0xc85/0x1310 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x21d/0x300 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc_node_track_caller+0xa5/0x230 mm/slab_common.c:1027
 kstrdup+0x3a/0x70 mm/util.c:62
 __kernfs_new_node+0x9d/0x870 fs/kernfs/dir.c:611
 kernfs_new_node+0x99/0x170 fs/kernfs/dir.c:679
 kernfs_create_link+0xa5/0x1f0 fs/kernfs/symlink.c:39
 sysfs_do_create_link_sd+0x85/0x100 fs/sysfs/symlink.c:44
 device_create_sys_dev_entry+0x10f/0x170 drivers/base/core.c:3451
 device_add+0x8cf/0xd30 drivers/base/core.c:3595
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1137 [inline]
 free_unref_page_prepare+0x92a/0xa50 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 vfree+0x186/0x2e0 mm/vmalloc.c:2842
 delayed_vfree_work+0x56/0x80 mm/vmalloc.c:2763
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Memory state around the buggy address:
 ffff88801e393500: 00 fc fc fc fc fa fc fc fc fc 05 fc fc fc fc 05
 ffff88801e393580: fc fc fc fc 00 fc fc fc fc 05 fc fc fc fc fa fc
>ffff88801e393600: fc fc fc 00 fc fc fc fc 00 fc fc fc fc 00 fc fc
                                              ^
 ffff88801e393680: fc fc 00 fc fc fc fc 00 fc fc fc fc 00 fc fc fc
 ffff88801e393700: fc 00 fc fc fc fc fb fc fc fc fc 00 fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

