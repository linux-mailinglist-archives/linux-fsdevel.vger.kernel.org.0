Return-Path: <linux-fsdevel+bounces-29753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBBD97D6D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 16:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568091F25048
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D13417BEBD;
	Fri, 20 Sep 2024 14:26:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C117BB24
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842398; cv=none; b=uVI+ZpRYXaZOBzvhvX7p048CMANdU1oHshVpVSihVixBIASSSa5OQJIUiX5xRuLLpAf7VvrSYlNPaJ72gHpXb2H2bufxux65b1USIozV1nRPphFiUarWK/sWEbC2DhIV3s4q1w0yvx0hgXrpt9jxvtK/rFEnmcx0mFAv3jdnanI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842398; c=relaxed/simple;
	bh=Sl41qM1tBGFgHmlJ7WpSk0lu73CUGCVGNKPQqigOobE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O/4ARDTuECMTTEPKbaQAE4y8wTk0m9h+x5ud4aZGLG0JvfIc2+mVraCVFa2LUVQuTZoGYlOWvJPCCSUOvkoOftUUa7ES8J30lL6cggHPG08xFSA+5yh1dQEhcKCuYy2AUYjLhRB08iik6uYCgvtNcwYEM31lm7cIgJ+tXywLBhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0987c35f2so25076085ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2024 07:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726842395; x=1727447195;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYlSRMhn2MQRNSq12rQhiTyCbn18Z0G3g7k8xUtyfcY=;
        b=syZBQ+TSn3jXuB4NfSU95ckP7aHlOU0KwQq4KLbCk4HaRppHI8cyZg5B5y5kGbJ+zx
         /EfEp2CrzvCxj6bFUFg4n4Om/8Zk+1s5tAT8EN9q6h1Gk8zUJHqNziM2rRjGTPhfRMf5
         OwPtamxIvPLvjZZTk3N8Oww4tOPT4aKOAMLmaOojhwCBRpuCWYbZXQ0DMnLIzjJve726
         89EjJDUK/H2q3XatiTHB2tbn5Zo9reM6YosFBHLRCwYihTZ38Znq54e8bkVDQKtINP4f
         xVX8XXHORY/VnXtTUPoyKkXsX8lXTz/8oS4y7t7kNQekVNOvgW7RabXVlJsMT4DWS4qB
         ccYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnjEQWYmtCFmHVgvZQ77MJwkkV+o6HJkZwq8sOxjmIuonyi+8mZCaCpZguDUZdWI6W1ZIF95nq0GKnOCTn@vger.kernel.org
X-Gm-Message-State: AOJu0YyseP848Td76wi5wSRzkxu78dY00/akz4uV3zwolhWdcp8FaIJH
	B0ImMfbmcFkCS1W92DabJkyedASFoMte16OPGIvgRRH+4GYyOa97O2DGVG9OzZJwqIkV+ZlEg9d
	FlLhquiQHenthXlZ/XUNwmoGX5GZJIVtj8UeEj0edhNhACnWV4Hverig=
X-Google-Smtp-Source: AGHT+IFeXBC6vh6nsJi1RrqN1F0xfcEDD6b7D/oi8T5Q3eG8e+5BGp2Us9qfOxZgukTOLkDeEh8qxxZPBd2bj3SoiDqQtqBuCjsq
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1686:b0:3a0:915d:a4a7 with SMTP id
 e9e14a558f8ab-3a0c8c8c9b0mr33738615ab.2.1726842394758; Fri, 20 Sep 2024
 07:26:34 -0700 (PDT)
Date: Fri, 20 Sep 2024 07:26:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ed861a.050a0220.2abe4d.0015.GAE@google.com>
Subject: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_advance
From: syzbot <syzbot+7c48153a9d788824044b@syzkaller.appspotmail.com>
To: brauner@kernel.org, dhowells@redhat.com, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, netfs@lists.linux.dev, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a430d95c5efa Merge tag 'lsm-pr-20240911' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15b24427980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d85e1e571a820894
dashboard link: https://syzkaller.appspot.com/bug?extid=7c48153a9d788824044b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1511a607980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c7d69f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4faaa939b3a4/disk-a430d95c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/83c722076440/vmlinux-a430d95c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/24c938d49c40/bzImage-a430d95c.xz

The issue was bisected to:

commit 983cdcf8fe141b0ce16bc71959a5dc55bcb0764d
Author: David Howells <dhowells@redhat.com>
Date:   Thu Jun 6 06:48:55 2024 +0000

    netfs: Simplify the writeback code

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1087bb00580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1287bb00580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1487bb00580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7c48153a9d788824044b@syzkaller.appspotmail.com
Fixes: 983cdcf8fe14 ("netfs: Simplify the writeback code")

==================================================================
BUG: KASAN: slab-use-after-free in iov_iter_folioq_advance lib/iov_iter.c:540 [inline]
BUG: KASAN: slab-use-after-free in iov_iter_advance+0x677/0x6c0 lib/iov_iter.c:576
Read of size 8 at addr ffff88802a63dd20 by task syz-executor341/5249

CPU: 1 UID: 0 PID: 5249 Comm: syz-executor341 Not tainted 6.11.0-syzkaller-02574-ga430d95c5efa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 iov_iter_folioq_advance lib/iov_iter.c:540 [inline]
 iov_iter_advance+0x677/0x6c0 lib/iov_iter.c:576
 netfs_write_folio+0x745/0x18f0 fs/netfs/write_issue.c:481
 netfs_writepages+0x2ba/0xb90 fs/netfs/write_issue.c:541
 do_writepages+0x1a6/0x7f0 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 v9fs_dir_release+0x429/0x590 fs/9p/vfs_dir.c:219
 __fput+0x3f9/0xb60 fs/file_table.c:431
 task_work_run+0x151/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2bb0 kernel/exit.c:882
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1040
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff0e2c14089
Code: Unable to access opcode bytes at 0x7ff0e2c1405f.
RSP: 002b:00007ffe69e64ba8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff0e2c14089
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007ff0e2c8f390 R08: ffffffffffffffb8 R09: 0000000000000006
R10: 000000007ffff000 R11: 0000000000000246 R12: 00007ff0e2c8f390
R13: 0000000000000000 R14: 00007ff0e2c8fde0 R15: 00007ff0e2be5070
 </TASK>

Allocated by task 5249:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:690 [inline]
 netfs_buffer_append_folio+0x181/0x750 fs/netfs/misc.c:25
 netfs_write_folio+0x542/0x18f0 fs/netfs/write_issue.c:421
 netfs_writepages+0x2ba/0xb90 fs/netfs/write_issue.c:541
 do_writepages+0x1a6/0x7f0 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 v9fs_dir_release+0x429/0x590 fs/9p/vfs_dir.c:219
 __fput+0x3f9/0xb60 fs/file_table.c:431
 task_work_run+0x151/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2bb0 kernel/exit.c:882
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1040
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 12:
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
 process_one_work+0x9c8/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88802a63dc00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 288 bytes inside of
 freed 512-byte region [ffff88802a63dc00, ffff88802a63de00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2a63c
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000040 ffff88801ac41c80 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001fdffffff 0000000000000000
head: 00fff00000000040 ffff88801ac41c80 dead000000000122 0000000000000000
head: 0000000000000000 0000000080100010 00000001fdffffff 0000000000000000
head: 00fff00000000002 ffffea0000a98f01 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5249, tgid 5249 (syz-executor341), ts 139218928620, free_ts 130646507944
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
 netfs_buffer_append_folio+0x181/0x750 fs/netfs/misc.c:25
 netfs_write_folio+0x542/0x18f0 fs/netfs/write_issue.c:421
 netfs_writepages+0x2ba/0xb90 fs/netfs/write_issue.c:541
 do_writepages+0x1a6/0x7f0 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 v9fs_dir_release+0x429/0x590 fs/9p/vfs_dir.c:219
 __fput+0x3f9/0xb60 fs/file_table.c:431
page last free pid 4682 tgid 4682 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2619
 __put_partials+0x14c/0x170 mm/slub.c:3049
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3989 [inline]
 slab_alloc_node mm/slub.c:4038 [inline]
 kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4045
 getname_flags.part.0+0x4c/0x550 fs/namei.c:139
 getname_flags+0x93/0xf0 include/linux/audit.h:322
 vfs_fstatat+0x86/0x160 fs/stat.c:340
 __do_sys_newfstatat+0xa2/0x130 fs/stat.c:505
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802a63dc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802a63dc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802a63dd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88802a63dd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802a63de00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: slab-use-after-free in iov_iter_folioq_advance lib/iov_iter.c:540 [inline]
BUG: KASAN: slab-use-after-free in iov_iter_advance+0x677/0x6c0 lib/iov_iter.c:576
Read of size 8 at addr ffff88802a63f520 by task syz-executor341/5249

CPU: 1 UID: 0 PID: 5249 Comm: syz-executor341 Tainted: G    B              6.11.0-syzkaller-02574-ga430d95c5efa #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 iov_iter_folioq_advance lib/iov_iter.c:540 [inline]
 iov_iter_advance+0x677/0x6c0 lib/iov_iter.c:576
 netfs_write_folio+0x745/0x18f0 fs/netfs/write_issue.c:481
 netfs_writepages+0x2ba/0xb90 fs/netfs/write_issue.c:541
 do_writepages+0x1a6/0x7f0 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 v9fs_dir_release+0x429/0x590 fs/9p/vfs_dir.c:219
 __fput+0x3f9/0xb60 fs/file_table.c:431
 task_work_run+0x151/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2bb0 kernel/exit.c:882
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1040
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff0e2c14089
Code: Unable to access opcode bytes at 0x7ff0e2c1405f.
RSP: 002b:00007ffe69e64ba8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff0e2c14089
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007ff0e2c8f390 R08: ffffffffffffffb8 R09: 0000000000000006
R10: 000000007ffff000 R11: 0000000000000246 R12: 00007ff0e2c8f390
R13: 0000000000000000 R14: 00007ff0e2c8fde0 R15: 00007ff0e2be5070
 </TASK>

Allocated by task 5249:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:690 [inline]
 netfs_buffer_append_folio+0x181/0x750 fs/netfs/misc.c:25
 netfs_write_folio+0x542/0x18f0 fs/netfs/write_issue.c:421
 netfs_writepages+0x2ba/0xb90 fs/netfs/write_issue.c:541
 do_writepages+0x1a6/0x7f0 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 v9fs_dir_release+0x429/0x590 fs/9p/vfs_dir.c:219
 __fput+0x3f9/0xb60 fs/file_table.c:431
 task_work_run+0x151/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2bb0 kernel/exit.c:882
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1040
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 12:
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
 process_one_work+0x9c8/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88802a63f400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 288 bytes inside of
 freed 512-byte region [ffff88802a63f400, ffff88802a63f600)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2a63c
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000040 ffff88801ac41c80 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001fdffffff 0000000000000000
head: 00fff00000000040 ffff88801ac41c80 dead000000000122 0000000000000000
head: 0000000000000000 0000000080100010 00000001fdffffff 0000000000000000
head: 00fff00000000002 ffffea0000a98f01 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5249, tgid 5249 (syz-executor341), ts 139218928620, free_ts 130646507944
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
 netfs_buffer_append_folio+0x181/0x750 fs/netfs/misc.c:25
 netfs_write_folio+0x542/0x18f0 fs/netfs/write_issue.c:421
 netfs_writepages+0x2ba/0xb90 fs/netfs/write_issue.c:541
 do_writepages+0x1a6/0x7f0 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 v9fs_dir_release+0x429/0x590 fs/9p/vfs_dir.c:219
 __fput+0x3f9/0xb60 fs/file_table.c:431
page last free pid 4682 tgid 4682 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2619
 __put_partials+0x14c/0x170 mm/slub.c:3049
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3989 [inline]
 slab_alloc_node mm/slub.c:4038 [inline]
 kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4045
 getname_flags.part.0+0x4c/0x550 fs/namei.c:139
 getname_flags+0x93/0xf0 include/linux/audit.h:322
 vfs_fstatat+0x86/0x160 fs/stat.c:340
 __do_sys_newfstatat+0xa2/0x130 fs/stat.c:505
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802a63f400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802a63f480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802a63f500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88802a63f580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802a63f600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: slab-use-after-free in iov_iter_folioq_advance lib/iov_iter.c:540 [inline]
BUG: KASAN: slab-use-after-free in iov_iter_advance+0x677/0x6c0 lib/iov_iter.c:576
Read of size 8 at addr ffff88802c8aad20 by task syz-executor341/5249

CPU: 1 UID: 0 PID: 5249 Comm: syz-executor341 Tainted: G    B              6.11.0-syzkaller-02574-ga430d95c5efa #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 iov_iter_folioq_advance lib/iov_iter.c:540 [inline]
 iov_iter_advance+0x677/0x6c0 lib/iov_iter.c:576
 netfs_write_folio+0x745/0x18f0 fs/netfs/write_issue.c:481
 netfs_writepages+0x2ba/0xb90 fs/netfs/write_issue.c:541
 do_writepages+0x1a6/0x7f0 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 v9fs_dir_release+0x429/0x590 fs/9p/vfs_dir.c:219
 __fput+0x3f9/0xb60 fs/file_table.c:431
 task_work_run+0x151/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2bb0 kernel/exit.c:882
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1040
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff0e2c14089
Code: Unable to access opcode bytes at 0x7ff0e2c1405f.
RSP: 002b:00007ffe69e64ba8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff0e2c14089
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007ff0e2c8f390 R08: ffffffffffffffb8 R09: 0000000000000006
R10: 000000007ffff000 R11: 0000000000000246 R12: 00007ff0e2c8f390
R13: 0000000000000000 R14: 00007ff0e2c8fde0 R15: 00007ff0e2be5070
 </TASK>

Allocated by task 5249:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:690 [inline]
 netfs_buffer_append_folio+0x181/0x750 fs/netfs/misc.c:25
 netfs_write_folio+0x542/0x18f0 fs/netfs/write_issue.c:421
 netfs_writepages+0x2ba/0xb90 fs/netfs/write_issue.c:541
 do_writepages+0x1a6/0x7f0 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 v9fs_dir_release+0x429/0x590 fs/9p/vfs_dir.c:219
 __fput+0x3f9/0xb60 fs/file_table.c:431
 task_work_run+0x151/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2bb0 kernel/exit.c:882
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1040
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 11:
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
 process_one_work+0x9c8/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88802c8aac00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 288 bytes inside of
 freed 512-byte region [ffff88802c8aac00, ffff88802c8aae00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2c8a8
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000040 ffff88801ac41c80 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001fdffffff 0000000000000000
head: 00fff00000000040 ffff88801ac41c80 dead000000000122 0000000000000000
head: 0000000000000000 0000000080100010 00000001fdffffff 0000000000000000
head: 00fff00000000002 ffffea0000b22a01 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5249, tgid 5249 (syz-executor341), ts 141121433556, free_ts 130792291213
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
 netfs_buffer_append_folio+0x181/0x750 fs/netfs/misc.c:25
 netfs_write_folio+0x542/0x18f0 fs/netfs/write_issue.c:421
 netfs_writepages+0x2ba/0xb90 fs/netfs/write_issue.c:541
 do_writepages+0x1a6/0x7f0 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 v9fs_dir_release+0x429/0x590 fs/9p/vfs_dir.c:219
 __fput+0x3f9/0xb60 fs/file_table.c:431
page last free pid 5243 tgid 5243 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2619
 __put_partials+0x14c/0x170 mm/slub.c:3049
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3989 [inline]
 slab_alloc_node mm/slub.c:4038 [inline]
 __kmalloc_cache_noprof+0x11e/0x300 mm/slub.c:4185
 kmalloc_noprof include/linux/slab.h:690 [inline]
 kzalloc_noprof include/linux/slab.h:816 [inline]
 p9_fd_open net/9p/trans_fd.c:828 [inline]
 p9_fd_create+0x164/0x490 net/9p/trans_fd.c:1102
 p9_client_create+0x879/0x1210 net/9p/client.c:1015
 v9fs_session_init+0x1f8/0x1a80 fs/9p/v9fs.c:410
 v9fs_mount+0xc6/0xa50 fs/9p/vfs_super.c:122
 legacy_get_tree+0x10c/0x220 fs/fs_context.c:662
 vfs_get_tree+0x92/0x380 fs/super.c:1800
 do_new_mount fs/namespace.c:3507 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount fs/namespace.c:4032 [inline]
 __x64_sys_mount+0x294/0x320 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802c8aac00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802c8aac80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802c8aad00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88802c8aad80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802c8aae00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

