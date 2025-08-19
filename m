Return-Path: <linux-fsdevel+bounces-58296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DDAB2C3EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 14:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE7A189E36C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 12:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABF03043C8;
	Tue, 19 Aug 2025 12:35:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406ED305070
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606935; cv=none; b=A3fTSgl3rW43bSEV+Libsw5nkmCDFboUH11DqiBuu9hKu5J3rSXAbjlHPF6wBQG0G0eiOjUw1wb0KS7ZYNxxbaiPkZPcdIV8OmekBM8LzrXa5HWvlOYc50gMKloyM8ppeTPZw3tabMwlgAxtv5gZNZcUduMq8MQDM+HeJeAxc8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606935; c=relaxed/simple;
	bh=q95Qb+hhBhfnL6Tk2OrDgDDxMo9Sus2kxRpHY53GEjY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V0aLktC2ZoOKM9L9oWZcaLSXaLaWCbWgV3OQO7b6IghXPq4M63XGfZwT9wpmIiIR4OtaaektORLCeBCMbHSAUY2o8twoPl19mkufDtR2WhyR4Otlqvm0JyYFeD+MT19Ld9CrssGWuDXDwxlyCuKWjbhpdXKmrVbNIEaoBGPIw6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-88432dc61d9so1388342339f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 05:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606933; x=1756211733;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOvnU9r+K7ZpX4gBu6BS9eomr8G8AbQJhvuYBCN3cBw=;
        b=g7I9KSU+8zZhVDGg4hp1+VbVVYC0fkYCl/jNTs7qudDb0BuGKZFqhnxpmT+fyxGp6b
         IXbeY7Q/dyktvWAHij+pKOq8pqMcojJoj21xwnrBEdddUNvERvxygXznNZx13gT9PbIC
         pawfqIVbvz0pzX5DAf5AjMFWmBFZc0eB9Om+A8LPl7hj2b/TAAuXkrKafindJL9U+zk4
         xtDXm15zOLcR1fMg7+lsl0llFrfMR9tpD0gbuDzi181oQZ+QQQJCoU1NWwjsXr/uull8
         Jb/HyhcTrsPagIE98sFLo7PL8wHsSbfJRiC52UHtjzqPdy/bJVOJdUiMsT4lj8cgFC1G
         dItA==
X-Forwarded-Encrypted: i=1; AJvYcCX0LR2e6viulcV975pH4rljVa3pHar4MFX+fgdX09WkFneBU0S+N5zdmns4PN9Mansyo6QVFLn5f0DUElTq@vger.kernel.org
X-Gm-Message-State: AOJu0YxRsNYvjLK+V09jMzgwKAt9z6lGgl5zGHhvUpWv8DTq8r6VTYzM
	zhPN6UYAhMcMFOm1QOt8u1mRtVdzoTt4e07ZKjLsV0egHXw5pXxj00ir7bJGp67LlQmbFwVQIHs
	BaXpS3hZPLrcB85iOBPPVbpqFBTaGk/NVZTuDWl1UqlpEHF82V2M01/wJm88=
X-Google-Smtp-Source: AGHT+IEI/1DKd1RUwxo+QrnTf+jaQy3KAVGbJHEv2V/rviSxbMgiJ0Mk9V4rxJBhkcG+TewcbHNj5I6B0JabnOTGaEDJ6m8PrJzO
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2141:b0:3e5:7f54:dcda with SMTP id
 e9e14a558f8ab-3e6765c3e5cmr43319725ab.1.1755606933212; Tue, 19 Aug 2025
 05:35:33 -0700 (PDT)
Date: Tue, 19 Aug 2025 05:35:33 -0700
In-Reply-To: <673fdc18.050a0220.363a1b.012c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a46f95.050a0220.e29e5.00c3.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in security_file_ioctl (9)
From: syzbot <syzbot+b6f8640465bdf47ca708@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, brauner@kernel.org, daniel@iogearbox.net, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    864e3396976e net: gso: Forbid IPv6 TSO with extensions on ..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=144e26f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c321f33e4545e2a1
dashboard link: https://syzkaller.appspot.com/bug?extid=b6f8640465bdf47ca708
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170a43bc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/576f260f8fdb/disk-864e3396.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/90ce2b40a623/vmlinux-864e3396.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e9f2532beed2/bzImage-864e3396.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6f8640465bdf47ca708@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (3 ticks this GP) idle=3c4c/1/0x4000000000000000 softirq=18260/18260 fqs=0
rcu: 	(detected by 0, t=10502 jiffies, g=12221, q=404 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6109 Comm: syz.0.22 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:137 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x29f/0x2c0 mm/kasan/generic.c:189
Code: f3 49 83 c3 05 eb 07 4d 01 f3 49 83 c3 06 4d 89 dc 4d 85 db 0f 84 44 ff ff ff 4d 01 d1 4d 39 cc 75 11 41 83 e0 07 45 0f be 09 <45> 39 c8 0f 8c 2b ff ff ff 0f b6 d2 e8 a0 ef ff ff 34 01 e9 1c ff
RSP: 0018:ffffc90000a08ae8 EFLAGS: 00000006
RAX: 00000000ffffff01 RBX: ffffffffffffffff RCX: ffffffff819e00e1
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffc90000a08b60
RBP: ffffc90000a08bd0 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff5200014116c R12: fffff5200014116c
R13: ffffffff99d527c0 R14: fffff5200014116d R15: 1ffff9200014116c
FS:  00007f17a98396c0(0000) GS:ffff888125d1b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000600 CR3: 000000006fc8c000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1301 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:111 [inline]
 do_raw_spin_lock+0x121/0x290 kernel/locking/spinlock_debug.c:116
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0xb3/0xf0 kernel/locking/spinlock.c:162
 debug_object_activate+0xbb/0x420 lib/debugobjects.c:818
 debug_hrtimer_activate kernel/time/hrtimer.c:445 [inline]
 debug_activate kernel/time/hrtimer.c:484 [inline]
 enqueue_hrtimer+0x30/0x3a0 kernel/time/hrtimer.c:1088
 __run_hrtimer kernel/time/hrtimer.c:1778 [inline]
 __hrtimer_run_queues+0x656/0xc60 kernel/time/hrtimer.c:1825
 hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1887
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1039 [inline]
 __sysvec_apic_timer_interrupt+0x108/0x410 arch/x86/kernel/apic/apic.c:1056
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:86 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x89/0x2c0 mm/kasan/generic.c:189
Code: ff df 4f 8d 1c 17 49 ff c8 4d 89 c1 49 c1 e9 03 48 bb 01 00 00 00 00 fc ff df 4d 8d 34 19 4d 89 f4 4d 29 dc 49 83 fc 10 7f 29 <4d> 85 e4 0f 84 41 01 00 00 4c 89 cb 48 f7 d3 4c 01 fb 41 80 3b 00
RSP: 0018:ffffc90003037910 EFLAGS: 00000283
RAX: ffffffff8b758901 RBX: dffffc0000000001 RCX: ffffffff8b7589f6
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8c935a00
RBP: ffffffff8c935a08 R08: ffffffff8c935a07 R09: 1ffffffff1926b40
R10: dffffc0000000000 R11: fffffbfff1926b40 R12: 0000000000000001
R13: ffffc90003037aa0 R14: fffffbfff1926b41 R15: 1ffffffff1926b40
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 vsnprintf+0x386/0xf00 lib/vsprintf.c:2878
 dynamic_dname+0xfc/0x1b0 fs/d_path.c:308
 tomoyo_realpath_from_path+0x170/0x5d0 security/tomoyo/realpath.c:258
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_number_perm+0x1e8/0x5a0 security/tomoyo/file.c:723
 security_file_ioctl+0xcb/0x2d0 security/security.c:2943
 __do_sys_ioctl fs/ioctl.c:592 [inline]
 __se_sys_ioctl+0x47/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f17a898ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f17a9839038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f17a8bb5fa0 RCX: 00007f17a898ebe9
RDX: 0000200000000600 RSI: 0000000000008933 RDI: 0000000000000003
RBP: 00007f17a8a11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f17a8bb6038 R14: 00007f17a8bb5fa0 R15: 00007ffccbbdc5c8
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10501 jiffies! g12221 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=1 timer-softirq=3961
rcu: rcu_preempt kthread starved for 10502 jiffies! g12221 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:27224 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

