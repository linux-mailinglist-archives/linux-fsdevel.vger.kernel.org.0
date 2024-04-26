Return-Path: <linux-fsdevel+bounces-17857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429D28B2FD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 07:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF47A1F22DB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 05:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBFA13A403;
	Fri, 26 Apr 2024 05:48:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE5613A3E1
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 05:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714110505; cv=none; b=AEACglpBDZK9AdhJT6JsniHLAYoKtH/UdG1C42ET7XjqpRUIf3+RYgzeKjgBcIXzT2WvA8vFQ2Un+jLsd3hOIHGwXCSVFx1LJ1AM17KC88vZXmIGJTtvP4iCqJbFQPwMhDHq+5s9KV7VqfrHN2ui9unzUr56nCJZvHjKaIvtIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714110505; c=relaxed/simple;
	bh=n2hwnDX1DtoG9eWI5dGgtCD6QP28LTwrk8Wf3nuGHaU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aAg7bf9gBZzR+04+bNBg5wB0NqiYJAtu9jeBj6CYAzQDixtMFwZ9fAbYffGraYj1QPTIps5svcHbiyDoPpa7h1XUdzCNL/BVQi58BG6o6B6fI2F+EiEuJbfLGgvZuug0P7BuZ5kr373etlZzTZrnVGkQrfbmjj8+klDOphTWcRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d9913d3174so172478639f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 22:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714110503; x=1714715303;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TRBElUij4AplwGg3LNPg/2TmfFw9rof5Ew/G14Ngn4k=;
        b=mvEwb/uYxQjyp5W6rIa5hK5tqwQxXFUqCqGAmeurYnf+AI0JsthgNTM50UKanQyL5S
         1e7rEt5eR4qnwu9fJ9SWlEuzXx01C8DdvPjuBETZz/JH5rG1OCg59iadHQjK9FZldAVM
         G9w+9+0T2VV7+pq1p9gd45+4jYNcv671I6rFZgUGd3qEFLBkjdEfJJMO94sHhY7ECxin
         1xOOXpEFu5W1tQSi28dy3Dz6r8x168ESLWOF4Tg8GH4cxkBXxkkr1ddX6uItW1XviYCJ
         co/2/3tXcf6lH4TqKQkkR4bZPql0HD5xzrZmoYv0OqyaQ4SHeuhSdiJCv1b+zmsB7Z25
         NhLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwwr+VucobZeNSnkHkEg7bbKrubZ1PNiwiJaK48or/WM8w4gouXfht1pBjpJsbgw16tRrzUinV+/F4plka2Y3+EHIamDFk7lNqG2h3Mw==
X-Gm-Message-State: AOJu0YzlcAcDsr9vdNN9ZeRE1WCAO63CoA8CH1+KiYmjVAz072rCcNYA
	if5i1WB3RdmjnMgW3ZcbMySYVa/Rw3RzYx5QTW7OqYykfK3IBoQivAHjB7MW3IWIzEeCucjSpCq
	IL36AgvYJlnDtEcuV15K5m54hPPPMCMed02ATHX05H7YjO8mVDOnyYGk=
X-Google-Smtp-Source: AGHT+IFrvFxPESnUY4ebGhdRfMbsFDTFcsyi5iNKm7iWsXcJ4vBH1ZdPtgFwgWeyghz2Lb2qHCMd2yHmRbUo0zTL8re6Dhjszi2F
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12eb:b0:36b:3c17:28d0 with SMTP id
 l11-20020a056e0212eb00b0036b3c1728d0mr45857iln.6.1714110503126; Thu, 25 Apr
 2024 22:48:23 -0700 (PDT)
Date: Thu, 25 Apr 2024 22:48:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a519120616f973cb@google.com>
Subject: [syzbot] [v9fs?] INFO: rcu detected stall in sys_mount (7)
From: syzbot <syzbot+de026b20f56e1598e760@syzkaller.appspotmail.com>
To: andrii@kernel.org, asmadeus@codewreck.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	ericvh@kernel.org, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lucho@ionkov.net, martin.lau@linux.dev, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3b68086599f8 Merge tag 'sched_urgent_for_v6.9_rc5' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164f8bf7180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f47e5e015c177e57
dashboard link: https://syzkaller.appspot.com/bug?extid=de026b20f56e1598e760
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1775971b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1290b320980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eaff65771f64/disk-3b680865.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/426ae4806417/vmlinux-3b680865.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0e9686bbff2/bzImage-3b680865.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de026b20f56e1598e760@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5096/1:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=5437, q=6 ncpus=2)
task:syz-executor398 state:R  running task     stack:23960 pid:5096  tgid:5096  ppid:5090   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1796/0x4a00 kernel/sched/core.c:6746
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7068
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:check_region_inline mm/kasan/generic.c:171 [inline]
RIP: 0010:kasan_check_range+0xe/0x290 mm/kasan/generic.c:189
Code: 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 55 41 57 41 56 41 54 53 b0 01 <48> 85 f6 0f 84 a0 01 00 00 4c 8d 04 37 49 39 f8 0f 82 56 02 00 00
RSP: 0018:ffffc90003e7f370 EFLAGS: 00000246
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff81727ab4
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8fa7b6a8
RBP: ffffc90003e7f4e8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: ffff888029e00000 R12: 1ffff920007cfe7c
R13: dffffc0000000000 R14: 0000000000000000 R15: 00007f1d974c829a
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 cpumask_test_cpu include/linux/cpumask.h:505 [inline]
 cpu_online include/linux/cpumask.h:1120 [inline]
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire+0xd4/0x550 kernel/locking/lockdep.c:5725
 rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 rcu_read_lock include/linux/rcupdate.h:781 [inline]
 is_bpf_text_address+0x42/0x2b0 kernel/bpf/core.c:767
 kernel_text_address+0xa7/0xe0 kernel/extable.c:125
 __kernel_text_address+0xd/0x40 kernel/extable.c:79
 unwind_get_return_address+0x5d/0xc0 arch/x86/kernel/unwind_orc.c:369
 arch_stack_walk+0x125/0x1b0 arch/x86/kernel/stacktrace.c:26
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc+0x233/0x4a0 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x26f/0x540 security/tomoyo/realpath.c:80
 tomoyo_mount_acl security/tomoyo/mount.c:97 [inline]
 tomoyo_mount_permission+0x356/0xb80 security/tomoyo/mount.c:237
 security_sb_mount+0x8f/0xd0 security/security.c:1460
 path_mount+0xb9/0xfb0 fs/namespace.c:3621
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1d974c829a
RSP: 002b:00007ffd54ae8348 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f1d9751e043 RCX: 00007f1d974c829a
RDX: 00007f1d9751e051 RSI: 00007f1d9751e043 RDI: 00007f1d9751e051
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000055557430c370
R13: 0000000000000004 R14: 00007ffd54ae83c0 R15: 00007ffd54ae83b0
 </TASK>
rcu: rcu_preempt kthread starved for 10548 jiffies! g5437 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26736 pid:16    tgid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x1796/0x4a00 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6838
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2582
 rcu_gp_fqs_loop+0x2df/0x1370 kernel/rcu/tree.c:1663
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:1862
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5120 Comm: syz-executor398 Not tainted 6.9.0-rc4-syzkaller-00274-g3b68086599f8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:lockdep_enabled kernel/locking/lockdep.c:122 [inline]
RIP: 0010:lock_release+0x125/0x9f0 kernel/locking/lockdep.c:5767
Code: 7e 85 c0 0f 85 23 05 00 00 65 48 8b 04 25 80 d3 03 00 48 89 44 24 18 48 8d 98 d4 0a 00 00 48 89 d8 48 c1 e8 03 42 0f b6 04 38 <84> c0 0f 85 d8 05 00 00 83 3b 00 0f 85 f1 04 00 00 4c 8d b4 24 b0
RSP: 0018:ffffc900040d7b20 EFLAGS: 00000803
RAX: 0000000000000000 RBX: ffff8880787fa8d4 RCX: ffffffff8172a120
RDX: 0000000000000000 RSI: ffffffff8c1eb140 RDI: ffffffff8c1eb100
RBP: ffffc900040d7c60 R08: ffffffff8fa7b6af R09: 1ffffffff1f4f6d5
R10: dffffc0000000000 R11: fffffbfff1f4f6d6 R12: 1ffff9200081af70
R13: ffffffff815cefdd R14: ffff888029df1718 R15: dffffc0000000000
FS:  000055557430c3c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1d974de4c0 CR3: 00000000773d4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:157 [inline]
 _raw_spin_unlock_irq+0x16/0x50 kernel/locking/spinlock.c:202
 spin_unlock_irq include/linux/spinlock.h:401 [inline]
 get_signal+0x14dd/0x1740 kernel/signal.c:2914
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x102/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1d974c6e79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd54ae8348 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007f1d974c6e79
RDX: 000000002006b000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000055557430c370
R13: 0000000000000000 R14: 00007ffd54ae83c0 R15: 00007ffd54ae83b0
 </TASK>
sched: RT throttling activated


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

