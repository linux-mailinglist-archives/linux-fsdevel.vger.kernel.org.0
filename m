Return-Path: <linux-fsdevel+bounces-29754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E1397D6DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 16:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC35B1F22E0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAE217BEC5;
	Fri, 20 Sep 2024 14:26:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BE617BB33
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842398; cv=none; b=YGh2Xm/uVP4f3wIe4sx/wZbX8Ou4kP9VwzsP5uvBtKPHW5cn2SsLNK0qveArBQlZ0i8AuDAfXrxsFizl0vSPjkEMjdTIsYM3GIowCwAaZU5ebajRMqH17bnY8UW6lpsGvdSVLMdFORo6nLzJ9KIQX/TVbKKA/t2GItUrkR19onU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842398; c=relaxed/simple;
	bh=TzJp4J2OqTXc4pPy+1Dt7yswjY+gxUBo9GvrpZd5LmE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Now7/z1w4RfiCxL2sMhYgOhA15Vg6MKx9+XCg02o2ASHlMrg9zq3J4/4/dAN2WqRHBlJA2yKkiMTXc8KGioyNh/0l87ghfkVVQgTRtA5vVmbxCKI13bEPnaJmxr2icZcDC6iNK4zw7y2BGabj/6+bq83Ly5wgCuObfyU9HYhXE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0cc71ca7aso5056175ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2024 07:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726842395; x=1727447195;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ab9kvaGxjnKKrLV9AAejHQkW8vzpzTXyhKtnlcip2QE=;
        b=i/emdFpPaTtG1m82RLdhvd5Up9aKtkAqioq86EoX17NaJRMqhaBNRiLc9zEjeVpOQz
         AYvvFbUMzKIBG+9ZfrChMFh5C4ivs+O4tXFJ+gwuItitzjpYdz7yfETOQMWqzP6V91pS
         OCQgX1CAPIJrUS6fNbYRDf6XkZGwZm+DkvRCoIBOmkWlchsY8RfT+IBn5/sKNgkFGPtM
         YpcCWWxyB3VoBgFbVRbNCcPMlPSLa2g3eDgB7nNhno+basNPruRcOeFVEOOB1qXH2wGV
         Wzj7GY249eXAkOKETJeZgVkSi/JCNC5mHoqTXPYEIlqIoFvxhbb/4Qcng92lkmSaZDl1
         icNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWua1RTLUb1dfCs23dm9qF3BGpMe7JJCcHm+kBHeRqxZY99l4+0vFzyDysbaDATQEH5Snpf3od0zK6hJTUf@vger.kernel.org
X-Gm-Message-State: AOJu0YziuRpG41D3GdQ15hHGSi19aD5ZiXvaZn+tp0KRfZ2gro+r6kI/
	gqjDWpdNphqmw4/4Pp7QsiE+WQ0F2pqikw5t/uztKrqxtadgCOv0eiyqCvb0NeISm3nKThgBtWN
	8a2CM5fOb+JaqDkLVlfd5LdjmsWX9RbMZ8RH3/aQcWq2WrnXg8Oq/xDY=
X-Google-Smtp-Source: AGHT+IHeZofzFeA2g4M2K1ddfeOi0NFm7kVhTfhNxQYoMRGTJymSYqzhEPB6oWkM55b2i1u4g7yO64Z7PVjXdca1swJwrdwPhkaj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0e:b0:3a0:922f:8e9a with SMTP id
 e9e14a558f8ab-3a0c9d6f2ffmr30349625ab.17.1726842395072; Fri, 20 Sep 2024
 07:26:35 -0700 (PDT)
Date: Fri, 20 Sep 2024 07:26:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ed861b.050a0220.2abe4d.0016.GAE@google.com>
Subject: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
From: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a940d9a43e62 Merge tag 'soc-arm-6.12' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e1469f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=44d46e514184cd24
dashboard link: https://syzkaller.appspot.com/bug?extid=2625ce08c2659fb9961a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1785b500580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177244a9980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-a940d9a4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e9929bfe422c/vmlinux-a940d9a4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a6c74ee261ed/bzImage-a940d9a4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in folioq_folio_order include/linux/folio_queue.h:140 [inline]
BUG: KASAN: slab-use-after-free in folioq_folio_size include/linux/folio_queue.h:145 [inline]
BUG: KASAN: slab-use-after-free in iov_iter_folioq_revert lib/iov_iter.c:597 [inline]
BUG: KASAN: slab-use-after-free in iov_iter_revert lib/iov_iter.c:642 [inline]
BUG: KASAN: slab-use-after-free in iov_iter_revert+0x503/0x5a0 lib/iov_iter.c:609
Read of size 1 at addr ffff888027bdfd1d by task kworker/u32:4/101

CPU: 1 UID: 0 PID: 101 Comm: kworker/u32:4 Not tainted 6.11.0-syzkaller-03917-ga940d9a43e62 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound netfs_write_collection_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 folioq_folio_order include/linux/folio_queue.h:140 [inline]
 folioq_folio_size include/linux/folio_queue.h:145 [inline]
 iov_iter_folioq_revert lib/iov_iter.c:597 [inline]
 iov_iter_revert lib/iov_iter.c:642 [inline]
 iov_iter_revert+0x503/0x5a0 lib/iov_iter.c:609
 netfs_retry_write_stream fs/netfs/write_collect.c:181 [inline]
 netfs_retry_writes fs/netfs/write_collect.c:361 [inline]
 netfs_collect_write_results fs/netfs/write_collect.c:529 [inline]
 netfs_write_collection_worker+0x44d2/0x4f80 fs/netfs/write_collect.c:551
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5341:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:690 [inline]
 netfs_buffer_append_folio+0x181/0x750 fs/netfs/misc.c:25
 netfs_write_folio+0x542/0x18f0 fs/netfs/write_issue.c:421
 netfs_writepages+0x2ba/0xb90 fs/netfs/write_issue.c:541
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 v9fs_dir_release+0x429/0x590 fs/9p/vfs_dir.c:219
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2bb0 kernel/exit.c:882
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 get_signal+0x25fb/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0x13f/0x280 kernel/entry/common.c:231
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

Freed by task 101:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2250 [inline]
 slab_free mm/slub.c:4474 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4595
 netfs_delete_buffer_head+0xa6/0x100 fs/netfs/misc.c:59
 netfs_writeback_unlock_folios fs/netfs/write_collect.c:139 [inline]
 netfs_collect_write_results fs/netfs/write_collect.c:493 [inline]
 netfs_write_collection_worker+0x20f9/0x4f80 fs/netfs/write_collect.c:551
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888027bdfc00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 285 bytes inside of
 freed 512-byte region [ffff888027bdfc00, ffff888027bdfe00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27bdc
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000040 ffff88801ac42c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000001fdffffff 0000000000000000
head: 00fff00000000040 ffff88801ac42c80 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000001fdffffff 0000000000000000
head: 00fff00000000002 ffffea00009ef701 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 9199521764, free_ts 9199474394
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x1351/0x2e50 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4702
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x4e/0xf0 mm/slub.c:2319
 allocate_slab mm/slub.c:2482 [inline]
 new_slab+0x84/0x260 mm/slub.c:2535
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3721
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3811
 __slab_alloc_node mm/slub.c:3864 [inline]
 slab_alloc_node mm/slub.c:4026 [inline]
 __kmalloc_cache_noprof+0x2b4/0x300 mm/slub.c:4185
 kmalloc_noprof include/linux/slab.h:690 [inline]
 kzalloc_noprof include/linux/slab.h:816 [inline]
 device_private_init drivers/base/core.c:3527 [inline]
 device_add+0xccf/0x1a70 drivers/base/core.c:3578
 device_create_groups_vargs+0x1f8/0x270 drivers/base/core.c:4374
 device_create+0xe9/0x130 drivers/base/core.c:4413
 aoechr_init+0x116/0x1c0 drivers/block/aoe/aoechr.c:305
 aoe_init+0x79/0x1f0 drivers/block/aoe/aoemain.c:54
 do_one_initcall+0x128/0x700 init/main.c:1269
 do_initcall_level init/main.c:1331 [inline]
 do_initcalls init/main.c:1347 [inline]
 do_basic_setup init/main.c:1366 [inline]
 kernel_init_freeable+0x69d/0xca0 init/main.c:1580
 kernel_init+0x1c/0x2b0 init/main.c:1469
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2619
 stack_depot_save_flags+0x2da/0x8f0 lib/stackdepot.c:666
 kasan_save_stack+0x42/0x60 mm/kasan/common.c:48
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:690 [inline]
 kzalloc_noprof include/linux/slab.h:816 [inline]
 call_usermodehelper_setup+0x9a/0x340 kernel/umh.c:363
 kobject_uevent_env+0x15ff/0x1860 lib/kobject_uevent.c:628
 kset_register+0x1b6/0x2b0 lib/kobject.c:877
 class_register+0x22e/0x340 drivers/base/class.c:203
 aoechr_init+0xb0/0x1c0 drivers/block/aoe/aoechr.c:298
 aoe_init+0x79/0x1f0 drivers/block/aoe/aoemain.c:54
 do_one_initcall+0x128/0x700 init/main.c:1269
 do_initcall_level init/main.c:1331 [inline]
 do_initcalls init/main.c:1347 [inline]
 do_basic_setup init/main.c:1366 [inline]
 kernel_init_freeable+0x69d/0xca0 init/main.c:1580
 kernel_init+0x1c/0x2b0 init/main.c:1469
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888027bdfc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888027bdfc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888027bdfd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888027bdfd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888027bdfe00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

