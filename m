Return-Path: <linux-fsdevel+bounces-64064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97832BD6FB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 03:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 970AE34EA77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 01:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC39B254B09;
	Tue, 14 Oct 2025 01:28:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857391D8E1A
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760405312; cv=none; b=kf/2tTLxZl5fNcrjWccBSIKQoAyjvJ3bnhBM/o6X8fdOrM32qVYMsBWgYsKJYmLUPxF1Ey3yyqvMhIqp1Aell1FHTET1QOorQ42Phb42PpIrvrGcnnwz6IcnGE4ADzCxfvR4IZ/+DYizpsOtAu/Liy5DfhOZe6YbT/TaN84u4jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760405312; c=relaxed/simple;
	bh=2iaJRMBuABmsLpaRzlvXY3A/+R7uQb2O6fB58p9cxbs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kS0KU8y2iLWS/eP3tv81uFYWkr5xKWdw92VB5k7LV7WYZt57lzExIvOJiarbvWfTlI4tn1qvx88WMAvxfDnUqzFXjJuItk9QskQ4fok8rz9DS1YrGrcPhiTcCdsf+S9mkQwGcvarvBGPapmCV32syEYCDp0qj+6sXdhYUOvV+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42955823202so125998775ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 18:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760405310; x=1761010110;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tgn1lOePYRH2Sriw8nstKDDD+vSZ8ON/KTb7F5kJjUA=;
        b=nNzRmXPor1c+9yEIaaMik5k1eJCCnWJQXizaf5ISl7hj1ycx68SsFYlhxqg5FH6puk
         2cxIMsjJ17MPpd9oMV5oo9Dm+w06zoUUFw44xFl95dBcW4E7Iy8UUix+GxNXJdGnwOFT
         iayIJid+77G+4zMNnsCrhSTJIHInf0q8kV9UcqHuyJ+mNd/0VNFmomLo/XBo3EtpGNqY
         idhkcmqGx5Mm03Fa+k5MxwpsVAqHnBMDNUnpudT8YWYzV+Ib2C6gMKoor3bMBhNkqO5X
         1VHaEJUXclM+9BlHLYWNA+6OcZX8NXlH4DYyR0Z8LwOAdVguEI7biZhBB+zlL3gzRJka
         w+wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYQjwbLozcNeCOvLS0DpO9RnNdy6xBONOtcx6TBnzmXevcRM1KLaeppQOMsPY3MGe08LrCy/0WZ0oqqOkI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6oygJ9jq4k1x2hHONoJdwXXTc7S2NY9kwgynxKWHjks9wLyYc
	NDU3FjzNdD7Z1/84B9nb8Xrpx3AbX74KVfRenwSqqv7+aFPurfn6Mleovl7upU3O67mKeb2LxUr
	cZyofjzuID7zpYVE9WcoCKwtddWuEbrJ8IAXQF3ViA4UH1GqCCIHm0OrWk5Y=
X-Google-Smtp-Source: AGHT+IGEqjw9Ysa+H3DCTaG592JABfzYXIyEwQ0PEbCruyGGphp7KAxeZYGdau3xdtk85lonyjDNv3V6z8DaZ6AN8N8nCKu3Q6KB
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2489:b0:42f:9649:56b4 with SMTP id
 e9e14a558f8ab-42f96495934mr173412685ab.13.1760405309702; Mon, 13 Oct 2025
 18:28:29 -0700 (PDT)
Date: Mon, 13 Oct 2025 18:28:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68eda73d.a70a0220.b3ac9.0022.GAE@google.com>
Subject: [syzbot] [fs?] INFO: rcu detected stall in unwind_next_frame (5)
From: syzbot <syzbot+0f5d9b52b3f467f78d36@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    07fdad3a9375 Merge tag 'net-next-6.18' of git://git.kernel..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11eb4b34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5bcbbf19237350b5
dashboard link: https://syzkaller.appspot.com/bug?extid=0f5d9b52b3f467f78d36
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d1b458580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2ef8bd056945/disk-07fdad3a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a9847877fb22/vmlinux-07fdad3a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d00de7416031/bzImage-07fdad3a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0f5d9b52b3f467f78d36@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (1 GPs behind) idle=8e14/1/0x4000000000000000 softirq=18748/18750 fqs=1
rcu: 	(detected by 1, t=10502 jiffies, g=12053, q=759 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5982 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:memset_orig+0x75/0xb0 arch/x86/lib/memset_64.S:92
Code: 89 47 30 48 89 47 38 48 8d 7f 40 75 d8 0f 1f 84 00 00 00 00 00 89 d1 83 e1 38 74 14 c1 e9 03 66 0f 1f 44 00 00 ff c9 48 89 07 <48> 8d 7f 08 75 f5 83 e2 07 74 0a ff ca 88 07 48 8d 7f 01 75 f6 4c
RSP: 0018:ffffc90000007c80 EFLAGS: 00000002
RAX: 0000000000000000 RBX: ffff888056c2a340 RCX: 0000000000000001
RDX: 0000000000000010 RSI: 0000000000000000 RDI: ffffc90000007ca0
RBP: 0000000000000000 R08: ffffc90000007caf R09: 0000000000000000
R10: ffffc90000007ca0 R11: fffff52000000f96 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffffffff8b6cf420 R15: ffff8880b8627bc0
FS:  000055558512b500(0000) GS:ffff888125d3b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffba57b3000 CR3: 000000003058e000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 debug_object_activate+0x38/0x420 lib/debugobjects.c:806
 debug_hrtimer_activate kernel/time/hrtimer.c:438 [inline]
 debug_activate kernel/time/hrtimer.c:477 [inline]
 enqueue_hrtimer+0x30/0x3a0 kernel/time/hrtimer.c:1081
 __run_hrtimer kernel/time/hrtimer.c:1794 [inline]
 __hrtimer_run_queues+0x656/0xc60 kernel/time/hrtimer.c:1841
 hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1903
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
 __sysvec_apic_timer_interrupt+0x108/0x410 arch/x86/kernel/apic/apic.c:1058
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1052
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x175/0x360 kernel/locking/lockdep.c:5872
Code: 00 00 00 00 9c 8f 44 24 30 f7 44 24 30 00 02 00 00 0f 85 cd 00 00 00 f7 44 24 08 00 02 00 00 74 01 fb 65 48 8b 05 6b ec f1 10 <48> 3b 44 24 58 0f 85 f2 00 00 00 48 83 c4 60 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc90003987818 EFLAGS: 00000206
RAX: 0b2e9023536a4b00 RBX: 0000000000000000 RCX: 0b2e9023536a4b00
RDX: 0000000000000001 RSI: ffffffff8d9c68ab RDI: ffffffff8bc03b60
RBP: ffffffff8172ad05 R08: 0000000000000000 R09: ffffffff8172ad05
R10: ffffc900039879d8 R11: ffffffff81ab4450 R12: 0000000000000002
R13: ffffffff8e13a960 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:841 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1169 [inline]
 unwind_next_frame+0xc2/0x2390 arch/x86/kernel/unwind_orc.c:479
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2422 [inline]
 slab_free mm/slub.c:4695 [inline]
 kmem_cache_free+0x18f/0x400 mm/slub.c:4797
 file_free fs/file_table.c:71 [inline]
 __fput+0x6c2/0xa70 fs/file_table.c:481
 fput_close_sync+0x119/0x200 fs/file_table.c:573
 __do_sys_close fs/open.c:1587 [inline]
 __se_sys_close fs/open.c:1572 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1572
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffba558db2a
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 43 91 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 a3 91 02 00 8b 44 24
RSP: 002b:00007fffa7a45e40 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007ffba558db2a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00007fffa7a4578c R09: 0079746972756365
R10: 00007fffa7a457f0 R11: 0000000000000293 R12: 0000000000000000
R13: 00007ffba57b1280 R14: 0000000000000003 R15: 00007fffa7a45ef0
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10499 jiffies! g12053 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=0 timer-softirq=8549
rcu: rcu_preempt kthread starved for 10500 jiffies! g12053 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:26760 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7026
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4b9/0x870 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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

