Return-Path: <linux-fsdevel+bounces-62112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CD1B8428C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A2B189F764
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7B32F2609;
	Thu, 18 Sep 2025 10:40:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207892E3B15
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192030; cv=none; b=sfzqeOfngAtqC8la+Eu9ZoxSkV8/KC8DbCfdfZ7VacfG6Yv3/dfPh1i0UHHYqZQzKSb5b9Z8DXq8OfuagdZ+z2ozPAdtyskutIMAwZiEy0JPG761SLIDy5iJJPHZOB6UwF+nCYjZEV8Jj3VmtFEyssXI2y53E/rC6JzpzvU52m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192030; c=relaxed/simple;
	bh=GNAgiDi6/JxeBFQOGcVlqIu3+ahYTHrTaYNJINlTTHQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iM473dOKl3Okl4Orx3iydr5kwiIqW236Ce0lNsHQW7IiUIPISdJGdSGUtCIdrw1WODYPLZ6JhewlKRYPjruS18Q8vY1tKOnQby01WoSULBh/743UPY8GFpQCEerkapO0qoOl8yB4CI6OtYcn+a9BnUbVoIkoG4Gms55fkZ+6KX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-424048cbe07so9731695ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 03:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192027; x=1758796827;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akW+uia6Tphv4EpGjBvETcfbxqZ/XOp5s1ghoshpcPc=;
        b=qcUl3QMtH0jlh/XzZ0EmcPkfyfVxgWnxj0T8XoO3MKpXsjjA2uJ3OWq5bPEAmxz+Nl
         09g0OfDusZUrEaRfuPQiTIwShFoDbcB/EVcA6HJqCxf3RTaA7DXwTdM9SCzQnZyt5hqa
         d9wEaRo9Zs8/ojHM9Lp1soC3xALd0pJudoK6pEaGzVvMGTQW3/UzuDyFSYicPTMnWokw
         SDOUwddH4uRYLpk9SIoBoxF6ZwAl12OHvXXVxXaa12vJa2f4xnHjRjeDaaPfT/i6yHTz
         ixivfqxQfIe4X/a5IMzfGIEUF4Q4UmX3W8CJoY+eRTK4iG0AWPbXVBKPJ80O7MMplq/J
         kIow==
X-Gm-Message-State: AOJu0Yyn87/47WQkYL4N0HY8fuN5LN6b6tjJx1eQ5YekgoM+ZrddWxmk
	kauIgh543m2ZWr3Ip/DGwWGFvMt2YfE0bD6R6/pUOALPavDPaldT5OX025jihFM6TO2xBPi9e8m
	PGvX0QokBg7l5cT19k4QDQmmLks0UUFbol4/0OTESBpBC9LB/d8/pxEcs9CGX4Q==
X-Google-Smtp-Source: AGHT+IEmkvqlOFv6ifsliF6D0xw2GOWieYTR51lrTqw+a6Qx96XioMTc//tBxvlfArO4HOM9aimsv+qbIATMYdkL3q+TT/MQ24ES
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152e:b0:402:b8e3:c9f5 with SMTP id
 e9e14a558f8ab-4241a4cfc63mr81233055ab.2.1758192027297; Thu, 18 Sep 2025
 03:40:27 -0700 (PDT)
Date: Thu, 18 Sep 2025 03:40:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cbe19b.050a0220.28a605.0004.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in proc_invalidate_siblings_dcache
From: syzbot <syzbot+0aee5e8066eddbbe7397@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17db9b62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a7613f5d8c9cb65
dashboard link: https://syzkaller.appspot.com/bug?extid=0aee5e8066eddbbe7397
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-8f5ae30d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b5e2a13645b4/vmlinux-8f5ae30d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3100096abd6f/Image-8f5ae30d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0aee5e8066eddbbe7397@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in proc_invalidate_siblings_dcache+0x6ae/0x6bc fs/proc/inode.c:114
Read of size 8 at addr ffffaf801b161418 by task sshd/3178

CPU: 1 UID: 0 PID: 3178 Comm: sshd Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0 PREEMPT 
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff8007949a>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:132
[<ffffffff8000329a>] show_stack+0x30/0x3c arch/riscv/kernel/stacktrace.c:138
[<ffffffff80060b76>] __dump_stack lib/dump_stack.c:94 [inline]
[<ffffffff80060b76>] dump_stack_lvl+0x12e/0x1a6 lib/dump_stack.c:120
[<ffffffff8000ee40>] print_address_description mm/kasan/report.c:378 [inline]
[<ffffffff8000ee40>] print_report+0x28e/0x5a2 mm/kasan/report.c:482
[<ffffffff80b1ed32>] kasan_report+0xf0/0x214 mm/kasan/report.c:595
[<ffffffff80b20dca>] __asan_report_load8_noabort+0x12/0x1a mm/kasan/report_generic.c:381
[<ffffffff80e6eeda>] proc_invalidate_siblings_dcache+0x6ae/0x6bc fs/proc/inode.c:114
[<ffffffff80e83324>] proc_flush_pid+0x20/0x2a fs/proc/base.c:3483
[<ffffffff80159a0c>] release_task+0xcda/0x1cae kernel/exit.c:293
[<ffffffff8015c1a4>] wait_task_zombie kernel/exit.c:1264 [inline]
[<ffffffff8015c1a4>] wait_consider_task+0x17c4/0x3922 kernel/exit.c:1491
[<ffffffff80161c48>] do_wait_thread kernel/exit.c:1554 [inline]
[<ffffffff80161c48>] __do_wait+0x1b2/0x7ba kernel/exit.c:1672
[<ffffffff80162468>] do_wait+0x218/0x6ca kernel/exit.c:1706
[<ffffffff80163d84>] kernel_wait4+0x188/0x5a6 kernel/exit.c:1865
[<ffffffff801642f8>] __do_sys_wait4+0x156/0x162 kernel/exit.c:1893
[<ffffffff80164678>] __se_sys_wait4 kernel/exit.c:1889 [inline]
[<ffffffff80164678>] __riscv_sys_wait4+0x8a/0xd6 kernel/exit.c:1889
[<ffffffff8007715e>] syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
[<ffffffff863c3c76>] do_trap_ecall_u+0x396/0x530 arch/riscv/kernel/traps.c:343
[<ffffffff863ed596>] handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197

Allocated by task 3178:
 stack_trace_save+0xa0/0xd2 kernel/stacktrace.c:122
 kasan_save_stack+0x3e/0x6a mm/kasan/common.c:47
 kasan_save_track+0x16/0x28 mm/kasan/common.c:68
 kasan_save_alloc_info+0x30/0x3e mm/kasan/generic.c:562
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x7c/0x82 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x104/0x3bc mm/slub.c:4236
 alloc_pid+0xd8/0x128a kernel/pid.c:183
 copy_process+0x426c/0x72da kernel/fork.c:2191
 kernel_clone+0x128/0xd9e kernel/fork.c:2605
 __do_sys_clone+0xfe/0x13e kernel/fork.c:2748
 __se_sys_clone kernel/fork.c:2716 [inline]
 __riscv_sys_clone+0xa0/0x10e kernel/fork.c:2716
 syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
 do_trap_ecall_u+0x396/0x530 arch/riscv/kernel/traps.c:343
 handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197

Freed by task 3192:
 stack_trace_save+0xa0/0xd2 kernel/stacktrace.c:122
 kasan_save_stack+0x3e/0x6a mm/kasan/common.c:47
 kasan_save_track+0x16/0x28 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x5a mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x4a/0x62 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kmem_cache_free+0x2b4/0x562 mm/slub.c:4782
 put_pid.part.0+0x104/0x144 kernel/pid.c:104
 put_pid+0x24/0x36 kernel/pid.c:98
 proc_free_inode+0x4a/0xbc fs/proc/inode.c:76
 i_callback+0x42/0x8e fs/inode.c:325
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xa24/0x1ef8 kernel/rcu/tree.c:2861
 rcu_core_si+0xc/0x14 kernel/rcu/tree.c:2878
 handle_softirqs+0x4b2/0x132e kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0x18c/0x550 kernel/softirq.c:680
 irq_exit_rcu+0x10/0xf8 kernel/softirq.c:696
 handle_riscv_irq+0x40/0x4c arch/riscv/kernel/traps.c:390
 call_on_irq_stack+0x32/0x40 arch/riscv/kernel/entry.S:360

Last potentially related work creation:
 stack_trace_save+0xa0/0xd2 kernel/stacktrace.c:122
 kasan_save_stack+0x3e/0x6a mm/kasan/common.c:47
 kasan_record_aux_stack+0x114/0x160 mm/kasan/generic.c:548
 __call_rcu_common.constprop.0+0x9e/0x9da kernel/rcu/tree.c:3123
 call_rcu+0xc/0x14 kernel/rcu/tree.c:3243
 free_pid+0x20a/0x2d0 kernel/pid.c:147
 free_pids+0x4c/0x8a kernel/pid.c:159
 release_task+0xcf0/0x1cae kernel/exit.c:296
 wait_task_zombie kernel/exit.c:1264 [inline]
 wait_consider_task+0x17c4/0x3922 kernel/exit.c:1491
 do_wait_thread kernel/exit.c:1554 [inline]
 __do_wait+0x1b2/0x7ba kernel/exit.c:1672
 do_wait+0x218/0x6ca kernel/exit.c:1706
 kernel_wait4+0x188/0x5a6 kernel/exit.c:1865
 __do_sys_wait4+0x156/0x162 kernel/exit.c:1893
 __se_sys_wait4 kernel/exit.c:1889 [inline]
 __riscv_sys_wait4+0x8a/0xd6 kernel/exit.c:1889
 syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
 do_trap_ecall_u+0x396/0x530 arch/riscv/kernel/traps.c:343
 handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197

The buggy address belongs to the object at ffffaf801b161380
 which belongs to the cache pid of size 272
The buggy address is located 152 bytes inside of
 freed 272-byte region [ffffaf801b161380, ffffaf801b161490)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9b160
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xffe000000000040(head|node=0|zone=0|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 0ffe000000000040 ffffaf8011a93780 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080150015 00000000f5000000 0000000000000000
head: 0ffe000000000040 ffffaf8011a93780 dead000000000100 dead000000000122
head: 0000000000000000 0000000080150015 00000000f5000000 0000000000000000
head: 0ffe000000000001 ffff8d80006c5801 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 949, tgid 949 (kworker/u9:4), ts 62141947100, free_ts 0
 __set_page_owner+0x94/0x4a8 mm/page_owner.c:329
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0xdc/0x1ba mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x7fa/0x359a mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x22e/0x2120 mm/page_alloc.c:5148
 alloc_pages_mpol+0x1fa/0x5bc mm/mempolicy.c:2416
 alloc_frozen_pages_noprof+0x174/0x2f0 mm/mempolicy.c:2487
 alloc_slab_page mm/slub.c:2487 [inline]
 allocate_slab mm/slub.c:2655 [inline]
 new_slab+0x27c/0x38c mm/slub.c:2709
 ___slab_alloc+0xb5a/0x1192 mm/slub.c:3891
 __slab_alloc.constprop.0+0x60/0xb0 mm/slub.c:3981
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 kmem_cache_alloc_noprof+0xd0/0x3bc mm/slub.c:4236
 alloc_pid+0xd8/0x128a kernel/pid.c:183
 copy_process+0x426c/0x72da kernel/fork.c:2191
 kernel_clone+0x128/0xd9e kernel/fork.c:2605
 user_mode_thread+0xd4/0x110 kernel/fork.c:2683
 call_usermodehelper_exec_work kernel/umh.c:171 [inline]
 call_usermodehelper_exec_work+0xd4/0x1ac kernel/umh.c:157
 process_one_work+0x96a/0x1f32 kernel/workqueue.c:3236
page_owner free stack trace missing

Memory state around the buggy address:
 ffffaf801b161300: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffffaf801b161380: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffffaf801b161400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffffaf801b161480: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffffaf801b161500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


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

