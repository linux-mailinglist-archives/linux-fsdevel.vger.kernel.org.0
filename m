Return-Path: <linux-fsdevel+bounces-48687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3F5AB2BA8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 23:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3D0175553
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 21:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D94258CD8;
	Sun, 11 May 2025 21:42:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E2C10F1
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 May 2025 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746999748; cv=none; b=svBxIqIOLVHgmtc9RNtzYk7j9YpxN9QEGwceCumquexfGQUms+yLy1cByXccfWF+eJVMuWsfJm0eIfhCl7ySQt3uc1sVuAulXv/kI7S+I3lW55Ja9npi6KeZRYw98i7Z4XGuMrgHUCylQOXpdS3nle6HgA8gs7kEfcb2u/Lu4Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746999748; c=relaxed/simple;
	bh=LXJMFWnBk4N9pTyqmyl6LXkVY936Ha4zgZdwMo/kEQY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nFUcvfRYujs7E5JRuQgNnbMC3WxnB3WxWtSXsGlkq/LN3c7AvXvGizVlJLTW81ae7ZVV2BJge9XcgzWA0YhDM9tOolS490DaUJr2513qmJUfgefBZp2DQjkRT6N7hO20GVzRoGqrbSMCUG/XXUDZ1dLDTx1bG5H9AlOzqkUQOZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3da6fe3c8e7so44117495ab.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 May 2025 14:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746999744; x=1747604544;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xcH+iCP8HyjQKhFK9npmu5UQTS+dc+8Qnc+eoK1DVCA=;
        b=by5JneDyFAin15o9WX6lITJ/hn8bl5tGOqohUlENP1FOAC/AeeZnLS1VGnLp9rHNqn
         C8vHxBBYBQgLUbp4G+DpAL6rAwdVYxetIF7/zy+PyutEDp5s21KecRePxs3glNJYK5bT
         zX0/VKdclpm+WAK0iO1T/dh3mBjvdvV7wmXugX04igUM+GczXWDQCM3LwbOtEpjXAWka
         BXmPHx2Yv30rTOaOmHXU3GOWcXmdJmoWE2cjdWPl0NOoWUgVHmVjueOq1Cga4JkU1kFi
         S/RYFvaZ8f9pK5QPtmCIDn/61WODFiVUdQ4suGgDZeIlcVGolDe6a5GAGbtGEx9byn9d
         MdPw==
X-Forwarded-Encrypted: i=1; AJvYcCXXYzlCwV0sQfwSEEEPDO4S1vYGxbqNJb9yLnnG/XHibymTRSKdnjFWcVqcE9VEcxhhjKjWbWLEYoExmZfG@vger.kernel.org
X-Gm-Message-State: AOJu0YzJiTwjrbxNhYlOuUF3b9lbtQZ6Ro7e8/zEz93GHm+K+7qsNlyD
	CCBeKagXAsyIwmQXKxq+nE5ZfV+3flFVP9OK/LjgVipz+tpIdXSPMbtWxRAzRs0AVQ2xOVqx3cQ
	FQ3VKoTk7sFDKbcLMVVUX10JVwEapZWtuprjQSvna7j15iHY0aDQot08=
X-Google-Smtp-Source: AGHT+IE9y4m1Al2i2ijRSt5Qgp1qV8QrHPe2IT2WSs2VAPOXp3B8dXWSGuVlooQbrfQaDNjfTb9zYMJIc7iLItmRJOeK9UliWKSs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2586:b0:3d3:fdcc:8fb8 with SMTP id
 e9e14a558f8ab-3da7e1e779amr113396385ab.10.1746999743898; Sun, 11 May 2025
 14:42:23 -0700 (PDT)
Date: Sun, 11 May 2025 14:42:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682119bf.050a0220.f2294.0040.GAE@google.com>
Subject: [syzbot] [netfs?] KASAN: slab-out-of-bounds Read in iov_iter_revert
From: syzbot <syzbot+25b83a6f2c702075fcbc@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d76bb1ebb558 Merge tag 'erofs-for-6.15-rc6-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178a8670580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4b1a03f36d77776
dashboard link: https://syzkaller.appspot.com/bug?extid=25b83a6f2c702075fcbc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2860fea791b5/disk-d76bb1eb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6ad835ce04a2/vmlinux-d76bb1eb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c0ebeae233a/bzImage-d76bb1eb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+25b83a6f2c702075fcbc@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in iov_iter_revert lib/iov_iter.c:633 [inline]
BUG: KASAN: slab-out-of-bounds in iov_iter_revert+0x443/0x5a0 lib/iov_iter.c:611
Read of size 4 at addr ffff8880307a4678 by task kworker/u8:9/3466

CPU: 0 UID: 0 PID: 3466 Comm: kworker/u8:9 Not tainted 6.15.0-rc5-syzkaller-00043-gd76bb1ebb558 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Workqueue: events_unbound netfs_write_collection_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 iov_iter_revert lib/iov_iter.c:633 [inline]
 iov_iter_revert+0x443/0x5a0 lib/iov_iter.c:611
 netfs_retry_write_stream fs/netfs/write_retry.c:44 [inline]
 netfs_retry_writes+0x166d/0x1a50 fs/netfs/write_retry.c:231
 netfs_collect_write_results fs/netfs/write_collect.c:352 [inline]
 netfs_write_collection_worker+0x23fd/0x3830 fs/netfs/write_collect.c:374
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 970:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 nsim_fib6_rt_nh_add+0x4a/0x290 drivers/net/netdevsim/fib.c:500
 nsim_fib6_rt_create drivers/net/netdevsim/fib.c:562 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:752 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:889 [inline]
 nsim_fib_event_work+0x196a/0x2e80 drivers/net/netdevsim/fib.c:1493
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880307a4640
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 32 bytes to the right of
 allocated 24-byte region [ffff8880307a4640, ffff8880307a4658)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880307a4fc0 pfn:0x307a4
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88801b441780 ffffea0000c9f9d0 ffffea0001f01990
raw: ffff8880307a4fc0 0000000000400038 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP), pid 5741, tgid 5741 (dhcpcd-run-hook), ts 89207943594, free_ts 89206634714
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab mm/slub.c:2618 [inline]
 new_slab+0x244/0x340 mm/slub.c:2672
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3858
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3948
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4353
 kmalloc_noprof include/linux/slab.h:905 [inline]
 slab_free_hook mm/slub.c:2332 [inline]
 slab_free mm/slub.c:4642 [inline]
 kmem_cache_free+0x148/0x4d0 mm/slub.c:4744
 exit_mmap+0x511/0xb90 mm/mmap.c:1309
 __mmput+0x12a/0x410 kernel/fork.c:1379
 mmput+0x62/0x70 kernel/fork.c:1401
 exit_mm kernel/exit.c:589 [inline]
 do_exit+0x9d1/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
page last free pid 5741 tgid 5741 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0x69d/0xff0 mm/page_alloc.c:2725
 tlb_batch_list_free mm/mmu_gather.c:159 [inline]
 tlb_finish_mmu+0x237/0x7b0 mm/mmu_gather.c:499
 exit_mmap+0x403/0xb90 mm/mmap.c:1297
 __mmput+0x12a/0x410 kernel/fork.c:1379
 mmput+0x62/0x70 kernel/fork.c:1401
 exit_mm kernel/exit.c:589 [inline]
 do_exit+0x9d1/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880307a4500: 00 00 00 00 fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880307a4580: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff8880307a4600: 00 00 00 00 fc fc fc fc 00 00 00 fc fc fc fc fc
                                                                ^
 ffff8880307a4680: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff8880307a4700: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in iov_iter_revert lib/iov_iter.c:633 [inline]
BUG: KASAN: slab-out-of-bounds in iov_iter_revert+0x521/0x5a0 lib/iov_iter.c:611
Read of size 4 at addr ffff8880307a4668 by task kworker/u8:9/3466

CPU: 0 UID: 0 PID: 3466 Comm: kworker/u8:9 Tainted: G    B               6.15.0-rc5-syzkaller-00043-gd76bb1ebb558 #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Workqueue: events_unbound netfs_write_collection_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 iov_iter_revert lib/iov_iter.c:633 [inline]
 iov_iter_revert+0x521/0x5a0 lib/iov_iter.c:611
 netfs_retry_write_stream fs/netfs/write_retry.c:44 [inline]
 netfs_retry_writes+0x166d/0x1a50 fs/netfs/write_retry.c:231
 netfs_collect_write_results fs/netfs/write_collect.c:352 [inline]
 netfs_write_collection_worker+0x23fd/0x3830 fs/netfs/write_collect.c:374
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 970:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 nsim_fib6_rt_nh_add+0x4a/0x290 drivers/net/netdevsim/fib.c:500
 nsim_fib6_rt_create drivers/net/netdevsim/fib.c:562 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:752 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:889 [inline]
 nsim_fib_event_work+0x196a/0x2e80 drivers/net/netdevsim/fib.c:1493
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880307a4640
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 16 bytes to the right of
 allocated 24-byte region [ffff8880307a4640, ffff8880307a4658)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880307a4fc0 pfn:0x307a4
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88801b441780 ffffea0000c9f9d0 ffffea0001f01990
raw: ffff8880307a4fc0 0000000000400038 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP), pid 5741, tgid 5741 (dhcpcd-run-hook), ts 89207943594, free_ts 89206634714
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab mm/slub.c:2618 [inline]
 new_slab+0x244/0x340 mm/slub.c:2672
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3858
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3948
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4353
 kmalloc_noprof include/linux/slab.h:905 [inline]
 slab_free_hook mm/slub.c:2332 [inline]
 slab_free mm/slub.c:4642 [inline]
 kmem_cache_free+0x148/0x4d0 mm/slub.c:4744
 exit_mmap+0x511/0xb90 mm/mmap.c:1309
 __mmput+0x12a/0x410 kernel/fork.c:1379
 mmput+0x62/0x70 kernel/fork.c:1401
 exit_mm kernel/exit.c:589 [inline]
 do_exit+0x9d1/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
page last free pid 5741 tgid 5741 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0x69d/0xff0 mm/page_alloc.c:2725
 tlb_batch_list_free mm/mmu_gather.c:159 [inline]
 tlb_finish_mmu+0x237/0x7b0 mm/mmu_gather.c:499
 exit_mmap+0x403/0xb90 mm/mmap.c:1297
 __mmput+0x12a/0x410 kernel/fork.c:1379
 mmput+0x62/0x70 kernel/fork.c:1401
 exit_mm kernel/exit.c:589 [inline]
 do_exit+0x9d1/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880307a4500: 00 00 00 00 fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880307a4580: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff8880307a4600: 00 00 00 00 fc fc fc fc 00 00 00 fc fc fc fc fc
                                                          ^
 ffff8880307a4680: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff8880307a4700: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in iov_iter_revert lib/iov_iter.c:633 [inline]
BUG: KASAN: slab-out-of-bounds in iov_iter_revert+0x521/0x5a0 lib/iov_iter.c:611
Read of size 4 at addr ffff8880307a4658 by task kworker/u8:9/3466

CPU: 1 UID: 0 PID: 3466 Comm: kworker/u8:9 Tainted: G    B               6.15.0-rc5-syzkaller-00043-gd76bb1ebb558 #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Workqueue: events_unbound netfs_write_collection_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 iov_iter_revert lib/iov_iter.c:633 [inline]
 iov_iter_revert+0x521/0x5a0 lib/iov_iter.c:611
 netfs_retry_write_stream fs/netfs/write_retry.c:44 [inline]
 netfs_retry_writes+0x166d/0x1a50 fs/netfs/write_retry.c:231
 netfs_collect_write_results fs/netfs/write_collect.c:352 [inline]
 netfs_write_collection_worker+0x23fd/0x3830 fs/netfs/write_collect.c:374
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 970:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 nsim_fib6_rt_nh_add+0x4a/0x290 drivers/net/netdevsim/fib.c:500
 nsim_fib6_rt_create drivers/net/netdevsim/fib.c:562 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:752 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:889 [inline]
 nsim_fib_event_work+0x196a/0x2e80 drivers/net/netdevsim/fib.c:1493
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880307a4640
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes to the right of
 allocated 24-byte region [ffff8880307a4640, ffff8880307a4658)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880307a4fc0 pfn:0x307a4
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88801b441780 ffffea0000c9f9d0 ffffea0001f01990
raw: ffff8880307a4fc0 0000000000400038 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP), pid 5741, tgid 5741 (dhcpcd-run-hook), ts 89207943594, free_ts 89206634714
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab mm/slub.c:2618 [inline]
 new_slab+0x244/0x340 mm/slub.c:2672
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3858
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3948
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4353
 kmalloc_noprof include/linux/slab.h:905 [inline]
 slab_free_hook mm/slub.c:2332 [inline]
 slab_free mm/slub.c:4642 [inline]
 kmem_cache_free+0x148/0x4d0 mm/slub.c:4744
 exit_mmap+0x511/0xb90 mm/mmap.c:1309
 __mmput+0x12a/0x410 kernel/fork.c:1379
 mmput+0x62/0x70 kernel/fork.c:1401
 exit_mm kernel/exit.c:589 [inline]
 do_exit+0x9d1/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
page last free pid 5741 tgid 5741 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0x69d/0xff0 mm/page_alloc.c:2725
 tlb_batch_list_free mm/mmu_gather.c:159 [inline]
 tlb_finish_mmu+0x237/0x7b0 mm/mmu_gather.c:499
 exit_mmap+0x403/0xb90 mm/mmap.c:1297
 __mmput+0x12a/0x410 kernel/fork.c:1379
 mmput+0x62/0x70 kernel/fork.c:1401
 exit_mm kernel/exit.c:589 [inline]
 do_exit+0x9d1/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880307a4500: 00 00 00 00 fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880307a4580: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff8880307a4600: 00 00 00 00 fc fc fc fc 00 00 00 fc fc fc fc fc
                                                    ^
 ffff8880307a4680: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff8880307a4700: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in iov_iter_bvec_advance lib/iov_iter.c:504 [inline]
BUG: KASAN: slab-out-of-bounds in iov_iter_advance+0x652/0x6c0 lib/iov_iter.c:576
Read of size 4 at addr ffff8880307a4658 by task kworker/u8:9/3466

CPU: 0 UID: 0 PID: 3466 Comm: kworker/u8:9 Tainted: G    B               6.15.0-rc5-syzkaller-00043-gd76bb1ebb558 #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Workqueue: events_unbound netfs_write_collection_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 iov_iter_bvec_advance lib/iov_iter.c:504 [inline]
 iov_iter_advance+0x652/0x6c0 lib/iov_iter.c:576
 netfs_reissue_write+0x13d/0x240 fs/netfs/write_issue.c:250
 netfs_retry_write_stream fs/netfs/write_retry.c:46 [inline]
 netfs_retry_writes+0x168a/0x1a50 fs/netfs/write_retry.c:231
 netfs_collect_write_results fs/netfs/write_collect.c:352 [inline]
 netfs_write_collection_worker+0x23fd/0x3830 fs/netfs/write_collect.c:374
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 970:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 nsim_fib6_rt_nh_add+0x4a/0x290 drivers/net/netdevsim/fib.c:500
 nsim_fib6_rt_create drivers/net/netdevsim/fib.c:562 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:752 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:889 [inline]
 nsim_fib_event_work+0x196a/0x2e80 drivers/net/netdevsim/fib.c:1493
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880307a4640
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes to the right of
 allocated 24-byte region [ffff8880307a4640, ffff8880307a4658)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x307a4
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b441780 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000400040 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP), pid 5741, tgid 5741 (dhcpcd-run-hook), ts 89207943594, free_ts 89206634714
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab mm/slub.c:2618 [inline]
 new_slab+0x244/0x340 mm/slub.c:2672
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3858
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3948
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4353
 kmalloc_noprof include/linux/slab.h:905 [inline]
 slab_free_hook mm/slub.c:2332 [inline]
 slab_free mm/slub.c:4642 [inline]
 kmem_cache_free+0x148/0x4d0 mm/slub.c:4744
 exit_mmap+0x511/0xb90 mm/mmap.c:1309
 __mmput+0x12a/0x410 kernel/fork.c:1379
 mmput+0x62/0x70 kernel/fork.c:1401
 exit_mm kernel/exit.c:589 [inline]
 do_exit+0x9d1/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
page last free pid 5741 tgid 5741 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0x69d/0xff0 mm/page_alloc.c:2725
 tlb_batch_list_free mm/mmu_gather.c:159 [inline]
 tlb_finish_mmu+0x237/0x7b0 mm/mmu_gather.c:499
 exit_mmap+0x403/0xb90 mm/mmap.c:1297
 __mmput+0x12a/0x410 kernel/fork.c:1379
 mmput+0x62/0x70 kernel/fork.c:1401
 exit_mm kernel/exit.c:589 [inline]
 do_exit+0x9d1/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880307a4500: 00 00 00 00 fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880307a4580: 00 00 00 fc fc fc fc fc 00 00 00 fc fc fc fc fc
>ffff8880307a4600: 00 00 00 00 fc fc fc fc 00 00 00 fc fc fc fc fc
                                                    ^
 ffff8880307a4680: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff8880307a4700: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in iov_iter_bvec_advance lib/iov_iter.c:504 [inline]
BUG: KASAN: slab-out-of-bounds in iov_iter_advance+0x652/0x6c0 lib/iov_iter.c:576
Read of size 4 at addr ffff8880307a4668 by task kworker/u8:9/3466

CPU: 0 UID: 0 PID: 3466 Comm: kworker/u8:9 Tainted: G    B               6.15.0-rc5-syzkaller-00043-gd76bb1ebb558 #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Workqueue: events_unbound netfs_write_collection_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 iov_iter_bvec_advance lib/iov_iter.c:504 [inline]
 iov_iter_advance+0x652/0x6c0 lib/iov_iter.c:576
 netfs_reissue_write+0x13d/0x240 fs/netfs/write_issue.c:250
 netfs_retry_write_stream fs/netfs/write_retry.c:46 [inline]
 netfs_retry_writes+0x168a/0x1a50 fs/netfs/write_retry.c:231
 netfs_collect_write_results fs/netfs/write_collect.c:352 [inline]
 netfs_write_collection_worker+0x23fd/0x3830 fs/netfs/write_collect.c:374
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 970:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 nsim_fib6_rt_nh_add+0x4a/0x290 drivers/net/netdevsim/fib.c:500
 nsim_fib6_rt_create drivers/net/netdevsim/fib.c:562 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:752 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:889 [inline]
 nsim_fib_event_work+0x196a/0x2e80 drivers/net/netdevsim/fib.c:1493
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880307a4640
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 16 bytes to the right of
 allocated 24-byte region [ffff8880307a4640, ffff8880307a4658)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x307a4
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b441780 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000400040 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP), pid 5741, tgid 5741 (dhcpcd-run-hook), ts 89207943594, free_ts 89206634714
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab mm/slub.c:2618 [inline]
 new_slab+0x244/0x340 mm/slub.c:2672
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3858
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3948
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4353
 kmalloc_noprof include/linux/slab.h:905 [inline]
 slab_free_hook mm/slub.c:2332 [inline]
 slab_free mm/slub.c:4642 [inline]
 kmem_cache_free+0x148/0x4d0 mm/slub.c:4744
 exit_mmap+0x511/0xb90 mm/mmap.c:1309
 __mmput+0x12a/0x410 kernel/fork.c:1379
 mmput+0x62/0x70 kernel/fork.c:1401
 exit_mm kernel/exit.c:589 [inline]
 do_exit+0x9d1/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
page last free pid 5741 tgid 5741 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0x69d/0xff0 mm/page_alloc.c:2725
 tlb_batch_list_free mm/mmu_gather.c:159 [inline]
 tlb_finish_mmu+0x237/0x7b0 mm/mmu_gather.c:499
 exit_mmap+0x403/0xb90 mm/mmap.c:1297
 __mmput+0x12a/0x410 kernel/fork.c:1379
 mmput+0x62/0x70 kernel/fork.c:1401
 exit_mm kernel/exit.c:589 [inline]
 do_exit+0x9d1/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880307a4500: 00 00 00 00 fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880307a4580: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff8880307a4600: 00 00 00 00 fc fc fc fc 00 00 00 fc fc fc fc fc
                                                          ^
 ffff8880307a4680: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff8880307a4700: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in iov_iter_bvec_advance lib/iov_iter.c:504 [inline]
BUG: KASAN: slab-out-of-bounds in iov_iter_advance+0x652/0x6c0 lib/iov_iter.c:576
Read of size 4 at addr ffff8880307a4678 by task kworker/u8:9/3466

CPU: 1 UID: 0 PID: 3466 Comm: kworker/u8:9 Tainted: G    B               6.15.0-rc5-syzkaller-00043-gd76bb1ebb558 #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Workqueue: events_unbound netfs_write_collection_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 iov_iter_bvec_advance lib/iov_iter.c:504 [inline]
 iov_iter_advance+0x652/0x6c0 lib/iov_iter.c:576
 netfs_reissue_write+0x13d/0x240 fs/netfs/write_issue.c:250
 netfs_retry_write_stream fs/netfs/write_retry.c:46 [inline]
 netfs_retry_writes+0x168a/0x1a50 fs/netfs/write_retry.c:231
 netfs_collect_write_results fs/netfs/write_collect.c:352 [inline]
 netfs_write_collection_worker+0x23fd/0x3830 fs/netfs/write_collect.c:374
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 970:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 nsim_fib6_rt_nh_add+0x4a/0x290 drivers/net/netdevsim/fib.c:500
 nsim_fib6_rt_create drivers/net/netdevsim/fib.c:562 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:752 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:889 [inline]
 nsim_fib_event_work+0x196a/0x2e80 drivers/net/netdevsim/fib.c:1493
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880307a4640
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 32 bytes to the right of
 allocated 24-byte region [ffff8880307a4640, ffff8880307a4658)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x307a4
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b441780 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000400040 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP), pid 5741, tgid 5741 (dhcpcd-run-hook), ts 89207943594, free_ts 89206634714
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab mm/slub.c:2618 [inline]
 new_slab+0x244/0x340 mm/slub.c:2672
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3858
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3948
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4353
 kmalloc_noprof include/linux/slab.h:905 [inline]
 slab_free_hook mm/slub.c:2332 [inline]
 slab_free mm/slub.c:4642 [inline]
 kmem_cache_free+0x148/0x4d0 mm/slub.c:4744
 exit_mmap+0x511/0xb90 mm/mmap.c:1309
 __mmput+0x12a/0x410 kernel/fork.c:1379
 mmput+0x62/0x70 kernel/fork.c:1401
 exit_mm kernel/exit.c:589 [inline]
 do_exit+0x9d1/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
page last free pid 5741 tgid 5741 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0x69d/0xff0 mm/page_alloc.c:2725
 tlb_batch_list_free mm/mmu_gather.c:159 [inline]
 tlb_finish_mmu+0x237/0x7b0 mm/mmu_gather.c:499
 exit_mmap+0x403/0xb90 mm/mmap.c:1297
 __mmput+0x12a/0x410 kernel/fork.c:1379
 mmput+0x62/0x70 kernel/fork.c:1401
 exit_mm kernel/exit.c:589 [inline]
 do_exit+0x9d1/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880307a4500: 00 00 00 00 fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880307a4580: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff8880307a4600: 00 00 00 00 fc fc fc fc 00 00 00 fc fc fc fc fc
                                                                ^
 ffff8880307a4680: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff8880307a4700: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: wild-memory-access in memcpy_from_iter lib/iov_iter.c:73 [inline]
BUG: KASAN: wild-memory-access in iterate_bvec include/linux/iov_iter.h:123 [inline]
BUG: KASAN: wild-memory-access in iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
BUG: KASAN: wild-memory-access in iterate_and_advance include/linux/iov_iter.h:328 [inline]
BUG: KASAN: wild-memory-access in __copy_from_iter lib/iov_iter.c:249 [inline]
BUG: KASAN: wild-memory-access in _copy_from_iter+0x8c9/0x15b0 lib/iov_iter.c:260
Read of size 50 at addr ffe728a1399fbe06 by task kworker/u8:9/3466

CPU: 0 UID: 0 PID: 3466 Comm: kworker/u8:9 Tainted: G    B               6.15.0-rc5-syzkaller-00043-gd76bb1ebb558 #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Workqueue: events_unbound netfs_write_collection_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 __asan_memcpy+0x23/0x60 mm/kasan/shadow.c:105
 memcpy_from_iter lib/iov_iter.c:73 [inline]
 iterate_bvec include/linux/iov_iter.h:123 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 __copy_from_iter lib/iov_iter.c:249 [inline]
 _copy_from_iter+0x8c9/0x15b0 lib/iov_iter.c:260
 copy_from_iter include/linux/uio.h:228 [inline]
 copy_from_iter_full include/linux/uio.h:245 [inline]
 pdu_write_u net/9p/protocol.c:234 [inline]
 p9pdu_vwritef+0x2da/0x1d30 net/9p/protocol.c:614
 p9_client_prepare_req+0x247/0x4d0 net/9p/client.c:651
 p9_client_rpc+0x1c4/0xc50 net/9p/client.c:691
 p9_client_write+0x245/0x6f0 net/9p/client.c:1648
 v9fs_issue_write+0xe3/0x1b0 fs/9p/vfs_addr.c:59
 netfs_do_issue_write+0x95/0x110 fs/netfs/write_issue.c:239
 netfs_retry_write_stream fs/netfs/write_retry.c:46 [inline]
 netfs_retry_writes+0x168a/0x1a50 fs/netfs/write_retry.c:231
 netfs_collect_write_results fs/netfs/write_collect.c:352 [inline]
 netfs_write_collection_worker+0x23fd/0x3830 fs/netfs/write_collect.c:374
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in iterate_bvec include/linux/iov_iter.h:117 [inline]
BUG: KASAN: slab-out-of-bounds in iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
BUG: KASAN: slab-out-of-bounds in iterate_and_advance include/linux/iov_iter.h:328 [inline]
BUG: KASAN: slab-out-of-bounds in __copy_from_iter lib/iov_iter.c:249 [inline]
BUG: KASAN: slab-out-of-bounds in _copy_from_iter+0x132f/0x15b0 lib/iov_iter.c:260
Read of size 4 at addr ffff8880307a465c by task kworker/u8:9/3466

CPU: 1 UID: 0 PID: 3466 Comm: kworker/u8:9 Tainted: G    B               6.15.0-rc5-syzkaller-00043-gd76bb1ebb558 #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Workqueue: events_unbound netfs_write_collection_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 iterate_bvec include/linux/iov_iter.h:117 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 __copy_from_iter lib/iov_iter.c:249 [inline]
 _copy_from_iter+0x132f/0x15b0 lib/iov_iter.c:260
 copy_from_iter include/linux/uio.h:228 [inline]
 copy_from_iter_full include/linux/uio.h:245 [inline]
 pdu_write_u net/9p/protocol.c:234 [inline]
 p9pdu_vwritef+0x2da/0x1d30 net/9p/protocol.c:614
 p9_client_prepare_req+0x247/0x4d0 net/9p/client.c:651
 p9_client_rpc+0x1c4/0xc50 net/9p/client.c:691
 p9_client_write+0x245/0x6f0 net/9p/client.c:1648
 v9fs_issue_write+0xe3/0x1b0 fs/9p/vfs_addr.c:59
 netfs_do_issue_write+0x95/0x110 fs/netfs/write_issue.c:239
 netfs_retry_write_stream fs/netfs/write_retry.c:46 [inline]
 netfs_retry_writes+0x168a/0x1a50 fs/netfs/write_retry.c:231
 netfs_collect_write_results fs/netfs/write_collect.c:352 [inline]
 netfs_write_collection_worker+0x23fd/0x3830 fs/netfs/write_collect.c:374
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 970:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 nsim_fib6_rt_nh_add+0x4a/0x290 drivers/net/netdevsim/fib.c:500
 nsim_fib6_rt_create drivers/net/netdevsim/fib.c:562 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:752 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:889 [inline]
 nsim_fib_event_work+0x196a/0x2e80 drivers/net/netdevsim/fib.c:1493
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880307a4640
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 4 bytes to the right of
 allocated 24-byte region [ffff8880307a4640, ffff8880307a4658)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x307a4
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b441780 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000400040 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP), pid 5741, tgid 5741 (dhcpcd-run-hook), ts 89207943594, free_ts 89206634714
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab mm/slub.c:2618 [inline]
 new_slab+0x244/0x340 mm/slub.c:2672
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3858
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3948
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4353
 kmalloc_noprof include/linux/slab.h:905 [inline]
 slab_free_hook mm/slub.c:2332 [inline]
 slab_free mm/slub.c:4642 [inline]
 kmem_cache_free+0x148/0x4d0 mm/slub.c:4744
 exit_mmap+0x511/0xb90 mm/mmap.c:1309
 __mmput+0x12a/0x410 kernel/fork.c:1379
 mmput+0x62/0x70 kernel/fork.c:1401
 exit_mm kernel/exit.c:589 [inline]
 do_exit+0x9d1/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
page last free pid 5741 tgid 5741 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0x69d/0xff0 mm/page_alloc.c:2725
 tlb_batch_list_free mm/mmu_gather.c:159 [inline]
 tlb_finish_mmu+0x237/0x7b0 mm/mmu_gather.c:499
 exit_mmap+0x403/0xb90 mm/mmap.c:1297
 __mmput+0x12a/0x410 kernel/fork.c:1379
 mmput+0x62/0x70 kernel/fork.c:1401
 exit_mm kernel/exit.c:589 [inline]
 do_exit+0x9d1/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880307a4500: 00 00 00 00 fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880307a4580: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff8880307a4600: 00 00 00 00 fc fc fc fc 00 00 00 fc fc fc fc fc
                                                    ^
 ffff8880307a4680: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff8880307a4700: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in iterate_bvec include/linux/iov_iter.h:120 [inline]
BUG: KASAN: slab-out-of-bounds in iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
BUG: KASAN: slab-out-of-bounds in iterate_and_advance include/linux/iov_iter.h:328 [inline]
BUG: KASAN: slab-out-of-bounds in __copy_from_iter lib/iov_iter.c:249 [inline]
BUG: KASAN: slab-out-of-bounds in _copy_from_iter+0x1459/0x15b0 lib/iov_iter.c:260
Read of size 4 at addr ffff8880307a4658 by task kworker/u8:9/3466

CPU: 1 UID: 0 PID: 3466 Comm: kworker/u8:9 Tainted: G    B               6.15.0-rc5-syzkaller-00043-gd76bb1ebb558 #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Workqueue: events_unbound netfs_write_collection_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 iterate_bvec include/linux/iov_iter.h:120 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 __copy_from_iter lib/iov_iter.c:249 [inline]
 _copy_from_iter+0x1459/0x15b0 lib/iov_iter.c:260
 copy_from_iter include/linux/uio.h:228 [inline]
 copy_from_iter_full include/linux/uio.h:245 [inline]
 pdu_write_u net/9p/protocol.c:234 [inline]
 p9pdu_vwritef+0x2da/0x1d30 net/9p/protocol.c:614
 p9_client_prepare_req+0x247/0x4d0 net/9p/client.c:651
 p9_client_rpc+0x1c4/0xc50 net/9p/client.c:691
 p9_client_write+0x245/0x6f0 net/9p/client.c:1648
 v9fs_issue_write+0xe3/0x1b0 fs/9p/vfs_addr.c:59
 netfs_do_issue_write+0x95/0x110 fs/netfs/write_issue.c:239
 netfs_retry_write_stream fs/netfs/write_retry.c:46 [inline]
 netfs_retry_writes+0x168a/0x1a50 fs/netfs/write_retry.c:231
 netfs_collect_write_results fs/netfs/write_collect.c:352 [inline]
 netfs_write_collection_worker+0x23fd/0x3830 fs/netfs/write_collect.c:374
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 970:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 nsim_fib6_rt_nh_add+0x4a/0x290 drivers/net/netdevsim/fib.c:500
 nsim_fib6_rt_create drivers/net/netdevsim/fib.c:562 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:752 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:889 [inline]
 nsim_fib_event_work+0x196a/0x2e80 drivers/net/netdevsim/fib.c:1493
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880307a4640
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes to the right of
 allocated 24-byte region [ffff8880307a4640, ffff8880307a4658)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x307a4
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b441780 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000400040 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP), pid 5741, tgid 5741 (dhcpcd-run-hook), ts 89207943594, free_ts 89206634714
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab mm/slub.c:2618 [inline]
 new_slab+0x244/0x340 mm/slub.c:2672
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3858
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3948
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4353
 kmalloc_noprof include/linux/slab.h:905 [inline]
 slab_free_hook mm/slub.c:2332 [inline]
 slab_free mm/slub.c:4642 [inline]
 kmem_cache_free+0x148/0x4d0 mm/slub.c:4744
 exit_mmap+0x511/0xb90 mm/mmap.c:1309
 __mmput+0x12a/0x410 kernel/fork.c:1379
 mmput+0x62/0x70 kernel/fork.c:1401
 exit_mm kernel/exit.c:589 [inline]
 do_exit+0x9d1/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
page last free pid 5741 tgid 5741 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0x69d/0xff0 mm/page_alloc.c:2725
 tlb_batch_list_free mm/mmu_gather.c:159 [inline]
 tlb_finish_mmu+0x237/0x7b0 mm/mmu_gather.c:499
 exit_mmap+0x403/0xb90 mm/mmap.c:1297
 __mmput+0x12a/0x410 kernel/fork.c:1379
 mmput+0x62/0x70 kernel/fork.c:1401
 exit_mm kernel/exit.c:589 [inline]
 do_exit+0x9d1/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880307a4500: 00 00 00 00 fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880307a4580: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff8880307a4600: 00 00 00 00 fc fc fc fc 00 00 00 fc fc fc fc fc
                                                    ^
 ffff8880307a4680: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff8880307a4700: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in iterate_bvec include/linux/iov_iter.h:129 [inline]
BUG: KASAN: slab-out-of-bounds in iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
BUG: KASAN: slab-out-of-bounds in iterate_and_advance include/linux/iov_iter.h:328 [inline]
BUG: KASAN: slab-out-of-bounds in __copy_from_iter lib/iov_iter.c:249 [inline]
BUG: KASAN: slab-out-of-bounds in _copy_from_iter+0x1416/0x15b0 lib/iov_iter.c:260
Read of size 4 at addr ffff8880307a4658 by task kworker/u8:9/3466

CPU: 1 UID: 0 PID: 3466 Comm: kworker/u8:9 Tainted: G    B               6.15.0-rc5-syzkaller-00043-gd76bb1ebb558 #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Workqueue: events_unbound netfs_write_collection_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 iterate_bvec include/linux/iov_iter.h:129 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 __copy_from_iter lib/iov_iter.c:249 [inline]
 _copy_from_iter+0x1416/0x15b0 lib/iov_iter.c:260
 copy_from_iter include/linux/uio.h:228 [inline]
 copy_from_iter_full include/linux/uio.h:245 [inline]
 pdu_write_u net/9p/protocol.c:234 [inline]
 p9pdu_vwritef+0x2da/0x1d30 net/9p/protocol.c:614
 p9_client_prepare_req+0x247/0x4d0 net/9p/client.c:651
 p9_client_rpc+0x1c4/0xc50 net/9p/client.c:691
 p9_client_write+0x245/0x6f0 net/9p/client.c:1648
 v9fs_issue_write+0xe3/0x1b0 fs/9p/vfs_addr.c:59
 netfs_do_issue_write+0x95/0x110 fs/netfs/write_issue.c:239
 netfs_retry_write_stream fs/netfs/write_retry.c:46 [inline]
 netfs_retry_writes+0x168a/0x1a50 fs/netfs/write_retry.c:231
 netfs_collect_write_results fs/netfs/write_collect.c:352 [inline]
 netfs_write_collection_worker+0x23fd/0x3830 fs/netfs/write_collect.c:374
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 970:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 nsim_fib6_rt_nh_add+0x4a/0x290 drivers/net/netdevsim/fib.c:500
 nsim_fib6_rt_create drivers/net/netdevsim/fib.c:562 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:752 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:889 [inline]
 nsim_fib_event_work+0x196a/0x2e80 drivers/net/netdevsim/fib.c:1493
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880307a4640
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes to the right of
 allocated 24-byte region [ffff8880307a4640, ffff8880307a4658)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x307a4
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b441780 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000400040 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP), pid 5741, tgid 5741 (dhcpcd-run-hook), ts 89207943594, free_ts 89206634714
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab mm/slub.c:2618 [inline]
 new_slab+0x244/0x340 mm/slub.c:2672
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3858
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3948
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4353
 kmalloc_noprof include/linux/slab.h:905 [inline]
 slab_free_hook mm/slub.c:2332 [inline]
 slab_free mm/slub.c:4642 [inline]
 kmem_cache_free+0x148/0x4d0 mm/slub.c:4744
 exit_mmap+0x511/0xb90 mm/mmap.c:1309
 __mmput+0x12a/0x410 kernel/fork.c:1379
 mmput+0x62/0x70 kernel/fork.c:1401
 exit_mm kernel/exit.c:589 [inline]
 do_exit+0x9d1/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
page last free pid 5741 tgid 5741 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0x69d/0xff0 mm/page_alloc.c:2725
 tlb_batch_list_free mm/mmu_gather.c:159 [inline]
 tlb_finish_mmu+0x237/0x7b0 mm/mmu_gather.c:499
 exit_mmap+0x403/0xb90 mm/mmap.c:1297
 __mmput+0x12a/0x410 kernel/fork.c:1379
 mmput+0x62/0x70 kernel/fork.c:1401
 exit_mm kernel/exit.c:589 [inline]
 do_exit+0x9d1/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880307a4500: 00 00 00 00 fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880307a4580: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff8880307a4600: 00 00 00 00 fc fc fc fc 00 00 00 fc fc fc fc fc
                                                    ^
 ffff8880307a4680: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff8880307a4700: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: slab-out-of-bounds in iterate_bvec include/linux/iov_iter.h:117 [inline]
BUG: KASAN: slab-out-of-bounds in iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
BUG: KASAN: slab-out-of-bounds in iterate_and_advance include/linux/iov_iter.h:328 [inline]
BUG: KASAN: slab-out-of-bounds in __copy_from_iter lib/iov_iter.c:249 [inline]
BUG: KASAN: slab-out-of-bounds in _copy_from_iter+0x132f/0x15b0 lib/iov_iter.c:260
Read of size 4 at addr ffff8880307a466c by task kworker/u8:9/3466

CPU: 0 UID: 0 PID: 3466 Comm: kworker/u8:9 Tainted: G    B               6.15.0-rc5-syzkaller-00043-gd76bb1ebb558 #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
Workqueue: events_unbound netfs_write_collection_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 iterate_bvec include/linux/iov_iter.h:117 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 __copy_from_iter lib/iov_iter.c:249 [inline]
 _copy_from_iter+0x132f/0x15b0 lib/iov_iter.c:260
 copy_from_iter include/linux/uio.h:228 [inline]
 copy_from_iter_full include/linux/uio.h:245 [inline]
 pdu_write_u net/9p/protocol.c:234 [inline]
 p9pdu_vwritef+0x2da/0x1d30 net/9p/protocol.c:614
 p9_client_prepare_req+0x247/0x4d0 net/9p/client.c:651
 p9_client_rpc+0x1c4/0xc50 net/9p/client.c:691
 p9_client_write+0x245/0x6f0 net/9p/client.c:1648
 v9fs_issue_write+0xe3/0x1b0 fs/9p/vfs_addr.c:59
 netfs_do_issue_write+0x95/0x110 fs/netfs/write_issue.c:239
 netfs_retry_write_stream fs/netfs/write_retry.c:46 [inline]
 netfs_retry_writes+0x168a/0x1a50 fs/netfs/write_retry.c:231
 netfs_collect_write_results fs/netfs/write_collect.c:352 [inline]
 netfs_write_collection_worker+0x23fd/0x3830 fs/netfs/write_collect.c:374
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 970:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 nsim_fib6_rt_nh_add+0x4a/0x290 drivers/net/netdevsim/fib.c:500
 nsim_fib6_rt_create drivers/net/netdevsim/fib.c:562 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:752 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:889 [inline]
 nsim_fib_event_work+0x196a/0x2e80 drivers/net/netdevsim/fib.c:1493
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880307a4640
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 20 bytes to the right of
 allocated 24-byte region [ffff8880307a4640, ffff8880307a4658)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x307a4
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b441780 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000400040 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP), pid 5741, tgid 5741 (dhcpcd-run-hook), ts 89207943594, free_ts 89206634714
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab mm/slub.c:261

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

