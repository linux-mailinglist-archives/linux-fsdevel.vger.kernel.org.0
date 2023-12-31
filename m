Return-Path: <linux-fsdevel+bounces-7048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0346D820CCC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Dec 2023 20:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D59FBB21216
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Dec 2023 19:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E89BA3B;
	Sun, 31 Dec 2023 19:35:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F0B671
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Dec 2023 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b89d5c71dcso1176289039f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Dec 2023 11:35:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704051319; x=1704656119;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qYw7/ldIJh1p9SJY6IYq282r1KDte2/58Sd0APbI3wA=;
        b=Itwj8aTDGtXiEGY0UjZUlHLcy4VKm+mJj+NdovwnH4YF2Yik+s3GyaLMJhk1Ck6H/V
         TnZHpT8vd4dHBtMfy2OhXPToTl99wj3aG/DnX4fXd6+5GnQbGGO8NLxfMhnZ+dul+GXh
         PVSJAUz0zsKomYBiy8AzZAn+U6gftrbMHIGvXmKjuQT9j3B1jtA2LylCcGFIqgC6c1Hh
         Kj1TZiuQd4LT9bSaOTYXaNPZ6yAcwmUnPohpJB5QyunUSeZ3Ja54E4B2osTdm4/KnBbV
         k+SVVJHracX0fxSLdDQHqxUnHCteKBgMr9TtdJn4S5Fl491yMC7l6v5fujbDcG1F+hIP
         Rn+Q==
X-Gm-Message-State: AOJu0YwMBQqDJqYVsUYwOeUeoLfjr+l1HM6Egn3FGgaGSg2xGILHrHoa
	Ywevl5KQhZGl0d/0caxSuSfHoCA4GReMnvwTWpbFR9sg2Ftc
X-Google-Smtp-Source: AGHT+IFy+BPQ/2TwVjisSdAZVotswJyjkMEYZwuMmMafYbXL+pfw00p9SZH2e7l4QJ7dTnDsZgqo0bXro+wxHJ9KeUD1sjvc0njM
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4c:b0:35f:f683:fa1c with SMTP id
 f12-20020a056e020b4c00b0035ff683fa1cmr1562835ilu.5.1704051318927; Sun, 31 Dec
 2023 11:35:18 -0800 (PST)
Date: Sun, 31 Dec 2023 11:35:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b3bfa060dd35d57@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in dput (8)
From: syzbot <syzbot+eb9f416500ff134ab699@syzkaller.appspotmail.com>
To: brauner@kernel.org, davem@davemloft.net, jack@suse.cz, jhs@mojatatu.com, 
	jiri@resnulli.us, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	vinicius.gomes@intel.com, viro@zeniv.linux.org.uk, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    39676dfe5233 Add linux-next specific files for 20231222
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1586fd31e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3761490b734dc96
dashboard link: https://syzkaller.appspot.com/bug?extid=eb9f416500ff134ab699
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15449dcee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e2787ee80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/360542c2ca67/disk-39676dfe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/900dfb21ca8a/vmlinux-39676dfe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c94a2a3ea0e0/bzImage-39676dfe.xz

The issue was bisected to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=104c379ee80000
console output: https://syzkaller.appspot.com/x/log.txt?x=144c379ee80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eb9f416500ff134ab699@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (1 GPs behind) idle=754c/1/0x4000000000000000 softirq=6521/6522 fqs=5
rcu: 	(detected by 0, t=10502 jiffies, g=6645, q=124 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5081 Comm: syz-executor262 Not tainted 6.7.0-rc6-next-20231222-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:check_preemption_disabled+0x1d/0xe0 lib/smp_processor_id.c:56
Code: 04 90 0f 0b 90 e9 83 fc ff ff 0f 1f 00 41 54 55 53 48 83 ec 08 65 8b 1d 4d 2e 77 75 65 8b 05 42 2e 77 75 a9 ff ff ff 7f 74 0b <48> 83 c4 08 89 d8 5b 5d 41 5c c3 9c 58 f6 c4 02 74 ee 65 48 8b 05
RSP: 0018:ffffc900001f0d10 EFLAGS: 00000002
RAX: 0000000000010002 RBX: 0000000000000001 RCX: ffffffff81686719
RDX: fffffbfff1e74b63 RSI: ffffffff8b2f95c0 RDI: ffffffff8b2f9600
RBP: 1ffff9200003e1ac R08: 0000000000000000 R09: fffffbfff1e74b62
R10: ffffffff8f3a5b17 R11: ffffffff8acf3060 R12: ffff8880b992bad8
R13: ffff888022d1b340 R14: 000000000003c2cc R15: ffffffff88ad04f0
FS:  00005555574c3380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001d88 CR3: 0000000029bb6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 rcu_dynticks_curr_cpu_in_eqs include/linux/context_tracking.h:122 [inline]
 rcu_is_watching+0x12/0xb0 kernel/rcu/tree.c:700
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x4c8/0x6a0 kernel/locking/lockdep.c:5765
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:149 [inline]
 _raw_spin_unlock_irqrestore+0x1a/0x70 kernel/locking/spinlock.c:194
 __run_hrtimer kernel/time/hrtimer.c:1684 [inline]
 __hrtimer_run_queues+0x5a4/0xc20 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
 __sysvec_apic_timer_interrupt+0x10c/0x410 arch/x86/kernel/apic/apic.c:1082
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:destroy_inode+0x44/0x1b0 fs/inode.c:305
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 4c 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 6b 28 48 8d 7d 30 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 1f 01 00 00 4c 8d a3 b8 01 00 00 48 8b 6d 30 48
RSP: 0018:ffffc90003b0fd70 EFLAGS: 00000a06
RAX: dffffc0000000000 RBX: ffff88807daf9ec0 RCX: 0000000000000000
RDX: 1ffff11002e59806 RSI: ffffffff81f6c6fc RDI: ffff8880172cc030
RBP: ffff8880172cc000 R08: 0000000000000000 R09: ffffed100fb5f3e9
R10: ffff88807daf9f4b R11: ffffffff8ace32a0 R12: 0000000000000001
R13: 0000000000000020 R14: ffffffff8be8e660 R15: ffff88807daf9f98
 iput_final fs/inode.c:1739 [inline]
 iput.part.0+0x570/0x7c0 fs/inode.c:1765
 iput+0x5c/0x80 fs/inode.c:1755
 dentry_unlink_inode+0x292/0x430 fs/dcache.c:400
 __dentry_kill+0x1ca/0x5f0 fs/dcache.c:603
 dput.part.0+0x4ac/0x9a0 fs/dcache.c:845
 dput+0x1f/0x30 fs/dcache.c:835
 __fput+0x3b9/0xb70 fs/file_table.c:384
 __fput_sync+0x47/0x50 fs/file_table.c:461
 __do_sys_close fs/open.c:1592 [inline]
 __se_sys_close fs/open.c:1577 [inline]
 __x64_sys_close+0x86/0xf0 fs/open.c:1577
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f79c2db61c0
Code: ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 80 3d e1 de 07 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
RSP: 002b:00007fff0221e5b8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f79c2db61c0
RDX: 00007f79c2db6f29 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00000000000f4240 R08: 0000000100000000 R09: 0000000100000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff0221e610
R13: 0000000000000001 R14: 00007fff0221e610 R15: 0000000000000003
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.569 msecs
rcu: rcu_preempt kthread starved for 10492 jiffies! g6645 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28256 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf15/0x5c80 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6817
 schedule_timeout+0x136/0x290 kernel/time/timer.c:2183
 rcu_gp_fqs_loop+0x1eb/0xb00 kernel/rcu/tree.c:1631
 rcu_gp_kthread+0x271/0x380 kernel/rcu/tree.c:1830
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 PID: 1043 Comm: kworker/u4:7 Not tainted 6.7.0-rc6-next-20231222-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:csd_lock_wait kernel/smp.c:311 [inline]
RIP: 0010:smp_call_function_many_cond+0x4e4/0x1570 kernel/smp.c:855
Code: 0b 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89 f5 49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 7e c5 0b 00 f3 90 <41> 0f b6 04 24 40 38 c5 7c 08 84 c0 0f 85 44 0e 00 00 8b 43 08 31
RSP: 0018:ffffc90004eaf920 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff8880b9942060 RCX: ffffffff817c4e68
RDX: ffff8880201b3b80 RSI: ffffffff817c4e42 RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffed101732840d
R13: 0000000000000001 R14: ffff8880b9942068 R15: ffff8880b983dec0
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005623e60a17e8 CR3: 000000000cf78000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1023
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2086 [inline]
 text_poke_bp_batch+0x22b/0x750 arch/x86/kernel/alternative.c:2296
 text_poke_flush arch/x86/kernel/alternative.c:2487 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2484 [inline]
 text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2494
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x1d7/0x400 kernel/jump_label.c:829
 static_key_enable_cpuslocked+0x1b7/0x270 kernel/jump_label.c:205
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218
 toggle_allocation_gate mm/kfence/core.c:826 [inline]
 toggle_allocation_gate+0xf4/0x250 mm/kfence/core.c:818
 process_one_work+0x8a4/0x15f0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b6/0x1290 kernel/workqueue.c:2787
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


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

