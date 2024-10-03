Return-Path: <linux-fsdevel+bounces-30900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0344B98F40F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 18:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 313CFB218FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 16:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB0B1AB533;
	Thu,  3 Oct 2024 16:15:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEE61A705B
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972129; cv=none; b=ggjjwiZ/BedfL5fgeSL22RKc6XqL44x/IYPLgM+g1GZbWVNSkW3e3qhaHCeF9ddhu+JQR3EuKVjpP8QkZ7Wzh1eeMU4paBC84d6wtkCEy2lS+4VuW2Oj1OL3qifApnaeC8PtU/RhUgxm7Pg+uqbpj4ilFCltFmOeaj+CwrMPldA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972129; c=relaxed/simple;
	bh=b6J/0tWQcNPvP+l1CHFQJxzI60RzOKao80MI/fLyrjk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tmHW9TL3AS45Z+JdalMJ1B43rbtY8NzksIuT9tVZUp/IUowHffdVCsNKhjzKCz+G2GFpeLttXTO+GjDzW5BGWOp3fegutnUPpJdVve9YWzOpKsuH1MDfYDk+m60+Ci3JtxlfJCUuaCQ4cnoMswrB5iMLi+cF+5nHx6d1wk1wdko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a1e69f6f51so12031425ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2024 09:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727972126; x=1728576926;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20NLPACgvn9t5TG+MAIf5iKOCeLbeIFd3bPKrlolN1c=;
        b=JormabGMcSYo0nlVXw/U2LUtum5t30OCfSfo2AET/ZtYt69N96i+fdzZTWE/zkPPqj
         MOmThkMtMbWswR0QW4V+A++fk09lmTxSJpvm4zUWcvoXFz0b0R6Gzd1MnQcu+fHUVSfI
         fOxcHPyMxvoxN/6xWo+lkPFNUge5BOfxMuox4pzdUvCMcAtnY30hH9b6ArpvMyt33W1u
         dUyoVNr0YumFfXa54y8a4P+KCcmAfpeRf7RbOC7aEZ8mk4aD9o1+oo4hRhEPLn7/rGOt
         LyII0ZogehpbLp83cmoi8s4xgD4s288uLDYn0iNfGYorpn+ZNB0TyQIhv2OlqXSNwyfF
         k0ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXzw6bJVjTm5aZBwOlmozmHypBcSC7c9m65RF9AUNM5E26GJdBC1tunXwpzZ0LzHLgCNt45+/uNrXV+MJC@vger.kernel.org
X-Gm-Message-State: AOJu0YxxWFD2sab8h0mKBOCbZ5eWpPgXpZAVczjiJGVN8UI5srhcRUZt
	vKC7QZcr24CEciMpIay5ncup2ZGCYIazCy4W+4mEnQ3rrqdyrzzuJEOo/QK+CunxWP9GFuvcNLS
	PCjzRAS24z3AkZgFhPG0lcbQuY3i/O1OhR5H3ahOgcerK8/AXz6C0S10=
X-Google-Smtp-Source: AGHT+IEcHHJENohvuSzbWZF5Y2yEAa43TAoPZUZtmeWnDivYuwG9wsIre1WEgSM1NEi7fViahhU865BD+pAKy49J81eV/P26ZQnM
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6e:b0:3a2:7651:9867 with SMTP id
 e9e14a558f8ab-3a36592bc64mr64776165ab.13.1727972125717; Thu, 03 Oct 2024
 09:15:25 -0700 (PDT)
Date: Thu, 03 Oct 2024 09:15:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fec31d.050a0220.9ec68.0049.GAE@google.com>
Subject: [syzbot] [usb?] [fs?] [input?] INFO: rcu detected stall in __fsnotify_parent
From: syzbot <syzbot+a9cae4ac3dad4268693f@syzkaller.appspotmail.com>
To: amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9852d85ec9d4 Linux 6.12-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1503539f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=a9cae4ac3dad4268693f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128e4307980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d44acbbed8bd/disk-9852d85e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8e54c80139e6/vmlinux-9852d85e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/35f22e8643ee/bzImage-9852d85e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a9cae4ac3dad4268693f@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 1-...D
 } 2686 jiffies s: 2073 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 2531 Comm: acpid Not tainted 6.12.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__sanitizer_cov_trace_switch+0x3b/0x90 kernel/kcov.c:351
Code: 53 48 8b 46 08 48 83 f8 20 74 6b 77 48 48 83 f8 08 74 5b 48 83 f8 10 75 2f 41 bd 03 00 00 00 4c 8b 75 00 31 db 4d 85 f6 74 1e <48> 8b 74 dd 10 4c 89 e2 4c 89 ef 48 83 c3 01 48 8b 4c 24 28 e8 8c
RSP: 0018:ffffc900001b7b80 EFLAGS: 00000006
RAX: 0000000000000000 RBX: 0000000000000007 RCX: ffffffff86e77fb0
RDX: ffff8881161b57c0 RSI: 000000000000000e RDI: 0000000000000001
RBP: ffffffff8810b580 R08: 0000000000000001 R09: 000000000000000e
R10: 0000000000000009 R11: 00000000000f2a50 R12: 0000000000000009
R13: 0000000000000001 R14: 000000000000000a R15: 0000000000000009
FS:  00007fe032ed9740(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa376d2f24a CR3: 00000001161ee000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 vsnprintf+0x740/0x1880 lib/vsprintf.c:2772
 sprintf+0xcd/0x110 lib/vsprintf.c:3007
 print_time kernel/printk/printk.c:1362 [inline]
 info_print_prefix+0x25c/0x350 kernel/printk/printk.c:1388
 record_print_text+0x141/0x400 kernel/printk/printk.c:1437
 printk_get_next_message+0x2a6/0x670 kernel/printk/printk.c:2978
 console_emit_next_record kernel/printk/printk.c:3046 [inline]
 console_flush_all+0x6ec/0xc60 kernel/printk/printk.c:3180
 __console_flush_and_unlock kernel/printk/printk.c:3239 [inline]
 console_unlock+0xd9/0x210 kernel/printk/printk.c:3279
 vprintk_emit+0x424/0x6f0 kernel/printk/printk.c:2407
 vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:68
 _printk+0xc8/0x100 kernel/printk/printk.c:2432
 printk_stack_address arch/x86/kernel/dumpstack.c:72 [inline]
 show_trace_log_lvl+0x1b7/0x3d0 arch/x86/kernel/dumpstack.c:285
 sched_show_task kernel/sched/core.c:7582 [inline]
 sched_show_task+0x3f0/0x5f0 kernel/sched/core.c:7557
 show_state_filter+0xee/0x320 kernel/sched/core.c:7627
 k_spec drivers/tty/vt/keyboard.c:667 [inline]
 k_spec+0xed/0x150 drivers/tty/vt/keyboard.c:656
 kbd_keycode drivers/tty/vt/keyboard.c:1522 [inline]
 kbd_event+0xcbd/0x17a0 drivers/tty/vt/keyboard.c:1541
 input_handler_events_default+0x116/0x1b0 drivers/input/input.c:2549
 input_pass_values+0x777/0x8e0 drivers/input/input.c:126
 input_event_dispose drivers/input/input.c:352 [inline]
 input_handle_event+0xb30/0x14d0 drivers/input/input.c:369
 input_event drivers/input/input.c:398 [inline]
 input_event+0x83/0xa0 drivers/input/input.c:390
 hidinput_hid_event+0xa12/0x2410 drivers/hid/hid-input.c:1719
 hid_process_event+0x4b7/0x5e0 drivers/hid/hid-core.c:1540
 hid_input_array_field+0x535/0x710 drivers/hid/hid-core.c:1652
 hid_process_report drivers/hid/hid-core.c:1694 [inline]
 hid_report_raw_event+0xa02/0x11c0 drivers/hid/hid-core.c:2040
 __hid_input_report.constprop.0+0x341/0x440 drivers/hid/hid-core.c:2110
 hid_irq_in+0x35e/0x870 drivers/hid/usbhid/hid-core.c:285
 __usb_hcd_giveback_urb+0x389/0x6e0 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x396/0x450 drivers/usb/core/hcd.c:1734
 dummy_timer+0x17c3/0x38d0 drivers/usb/gadget/udc/dummy_hcd.c:1988
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x20a/0xae0 kernel/time/hrtimer.c:1755
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1772
 handle_softirqs+0x206/0x8d0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xac/0x110 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1037
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:87 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x111/0x1a0 mm/kasan/generic.c:189
Code: 44 89 c2 e8 11 eb ff ff 83 f0 01 5b 5d 41 5c c3 cc cc cc cc 48 85 d2 74 4f 48 01 ea eb 09 48 83 c0 01 48 39 d0 74 41 80 38 00 <74> f2 eb b2 41 bc 08 00 00 00 45 29 dc 49 8d 14 2c eb 0c 48 83 c0
RSP: 0018:ffffc9000181fad8 EFLAGS: 00000246
RAX: fffffbfff14ac801 RBX: fffffbfff14ac802 RCX: ffffffff813258ce
RDX: fffffbfff14ac802 RSI: 0000000000000008 RDI: ffffffff8a564008
RBP: fffffbfff14ac801 R08: 0000000000000000 R09: fffffbfff14ac801
R10: ffffffff8a56400f R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 cpumask_test_cpu include/linux/cpumask.h:570 [inline]
 cpu_online include/linux/cpumask.h:1117 [inline]
 trace_lock_acquire+0x3e/0x1d0 include/trace/events/lock.h:24
 lock_acquire+0x2f/0xb0 kernel/locking/lockdep.c:5796
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 lockref_get_not_zero+0x18/0x80 lib/lockref.c:73
 dget_parent+0xc5/0x5e0 fs/dcache.c:906
 __fsnotify_parent+0x634/0xa30 fs/notify/fsnotify.c:238
 fsnotify_parent include/linux/fsnotify.h:96 [inline]
 fsnotify_file include/linux/fsnotify.h:131 [inline]
 fsnotify_access include/linux/fsnotify.h:380 [inline]
 vfs_read+0x465/0xbd0 fs/read_write.c:573
 ksys_read+0x1fa/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe032fa3b6a
Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffe11ef0a38 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00005609d311c360 RCX: 00007fe032fa3b6a
RDX: 0000000000000018 RSI: 00007ffe11ef0a40 RDI: 000000000000000a
RBP: 0000000000000006 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000008 R11: 0000000000000246 R12: 000000000000000a
R13: 00007ffe11ef0a40 R14: 0000000000000001 R15: 000000000000000a
 </TASK>
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4620272a90
RSP: 002b:00007ffcce04cb58 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f4620363860 RCX: 00007f4620272a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f4620363860 R08: 0000000000000000 R09: c43f99a82ecb6f3c
R10: 00007ffcce04ca10 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f4620367658 R15: 0000000000000001
 </TASK>
task:kworker/u8:7    state:R  running task     stack:32568 pid:14342 tgid:14342 ppid:4699   flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:14368 tgid:14368 ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:14372 tgid:14372 ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f22e82faa90
RSP: 002b:00007ffe9e935028 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f22e83eb860 RCX: 00007f22e82faa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f22e83eb860 R08: 0000000000000000 R09: 96308bf341258112
R10: 00007ffe9e934ee0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f22e83ef658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:14377 tgid:14377 ppid:56     flags:0x00000000
Call Trace:
 <TASK>
 </TASK>
task:kworker/u8:0    state:R  running task     stack:32568 pid:14384 tgid:14384 ppid:11     flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:14390 tgid:14390 ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:kworker/u8:3    state:R  running task     stack:28784 pid:14392 tgid:14392 ppid:46     flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:kworker/u8:4    state:R  running task     stack:32568 pid:14405 tgid:14405 ppid:56     flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:14408 tgid:14408 ppid:46     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f69ac1e6a90
RSP: 002b:00007fff6280c9d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f69ac2d7860 RCX: 00007f69ac1e6a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f69ac2d7860 R08: 0000000000000000 R09: ed1d0755febd8f8a
R10: 00007fff6280c890 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f69ac2db658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:14415 tgid:14415 ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
 rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:737
 </TASK>
task:kworker/u8:3    state:R  running task     stack:32568 pid:14417 tgid:14417 ppid:46     flags:0x00004000
Call Trace:
 <TASK>
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:14424 tgid:14424 ppid:56     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe41198aa90
RSP: 002b:00007ffcd919a0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fe411a7b860 RCX: 00007fe41198aa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fe411a7b860 R08: 0000000000000000 R09: 03feb842ab08c1d0
R10: 00007ffcd9199fb0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fe411a7f658 R15: 0000000000000001
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u8:0/11:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900000bfd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:3/46:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000517d80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:4/56:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000567d80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
5 locks held by acpid/2531:
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: dget_parent+0x3c/0x5e0 fs/dcache.c:903
 #1: ffff88811c96b230 (&dev->event_lock){..-.}-{2:2}, at: input_event drivers/input/input.c:397 [inline]
 #1: ffff88811c96b230 (&dev->event_lock){..-.}-{2:2}, at: input_event+0x70/0xa0 drivers/input/input.c:390
 #2: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #2: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: input_pass_values+0x8b/0x8e0 drivers/input/input.c:118
 #3: ffffffff89387ad8 (kbd_event_lock){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #3: ffffffff89387ad8 (kbd_event_lock){..-.}-{2:2}, at: kbd_event+0x8a/0x17a0 drivers/tty/vt/keyboard.c:1535
 #4: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #4: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #4: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
2 locks held by getty/2604:
 #0: ffff888100eaf0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
6 locks held by kworker/0:4/5488:
 #0: ffff888105adf548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90001bcfd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff8881097c1190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff8881097c1190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88811bf1d190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88811bf1d190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff88811c69e160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88811c69e160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88811c69e160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
 #5: ffff88811174da20 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #5: ffff88811174da20 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #5: ffff88811174da20 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
1 lock held by syz-executor/12367:
 #0: ffffffff88ec6a78 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:329
1 lock held by syz.1.36/12986:
 #0: ffffffff88ec6a78 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x282/0x3b0 kernel/rcu/tree_exp.h:297
1 lock held by modprobe/14443:

=============================================

keytouch 0003:0926:3333.0013: can't resubmit intr, dummy_hcd.1-1/input0, status -19
task:init            state:S stack:22176 pid:1     tgid:1     ppid:0      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 do_sigtimedwait+0x42f/0x5c0 kernel/signal.c:3665
 __do_sys_rt_sigtimedwait kernel/signal.c:3709 [inline]
 __se_sys_rt_sigtimedwait kernel/signal.c:3687 [inline]
 __x64_sys_rt_sigtimedwait+0x1ec/0x2e0 kernel/signal.c:3687
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2aa1ab323c
RSP: 002b:00007ffedee0ba60 EFLAGS: 00000246 ORIG_RAX: 0000000000000080
RAX: ffffffffffffffda RBX: 00007f2aa1ce913c RCX: 00007f2aa1ab323c
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f2aa1cee4a8
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffedee0bac8 R14: 0000559d87fb6169 R15: 00007f2aa1d25a80
 </TASK>
task:kthreadd        state:S stack:27024 pid:2     tgid:2     ppid:0      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 kthreadd+0x5ba/0x7d0 kernel/kthread.c:753
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:pool_workqueue_ state:S stack:30464 pid:3     tgid:3     ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 kthread_worker_fn+0x502/0xba0 kernel/kthread.c:849
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-rcu_g state:I stack:30288 pid:4     tgid:4     ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-sync_ state:I stack:30832 pid:5     tgid:5     ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-slub_ state:I stack:30832 pid:6     tgid:6     ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-netns state:I stack:30832 pid:7     tgid:7     ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:0     state:I stack:26880 pid:8     tgid:8     ppid:2      flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:1     state:I stack:22896 pid:9     tgid:9     ppid:2      flags:0x00004000
Workqueue:  0x0 (pm)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:0H    state:I stack:29584 pid:10    tgid:10    ppid:2      flags:0x00004000
Workqueue:  0x0 (events_highpri)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/u8:0    state:I stack:23136 pid:11    tgid:11    ppid:2      flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-mm_pe state:I stack:30832 pid:12    tgid:12    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:rcu_tasks_kthre state:I stack:29312 pid:13    tgid:13    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rcu_tasks_one_gp+0x55a/0xe90 kernel/rcu/tasks.h:610
 rcu_tasks_kthread+0x1c3/0x260 kernel/rcu/tasks.h:657
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:rcu_tasks_trace state:I stack:28896 pid:14    tgid:14    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rcu_tasks_one_gp+0x55a/0xe90 kernel/rcu/tasks.h:610
 rcu_tasks_kthread+0x1c3/0x260 kernel/rcu/tasks.h:657
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:ksoftirqd/0     state:S stack:23440 pid:15    tgid:15    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 smpboot_thread_fn+0x2d5/0xa30 kernel/smpboot.c:160
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:rcu_preempt     state:I stack:26608 pid:16    tgid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_timeout+0x136/0x2a0 kernel/time/timer.c:2615
 rcu_gp_fqs_loop+0x1eb/0xb00 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0x271/0x380 kernel/rcu/tree.c:2247
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:rcu_exp_par_gp_ state:S stack:30928 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 kthread_worker_fn+0x502/0xba0 kernel/kthread.c:849
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:rcu_exp_gp_kthr state:D stack:28688 pid:18    tgid:18    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_timeout+0x136/0x2a0 kernel/time/timer.c:2615
 synchronize_rcu_expedited_wait_once kernel/rcu/tree_exp.h:536 [inline]
 synchronize_rcu_expedited_wait kernel/rcu/tree_exp.h:649 [inline]
 rcu_exp_wait_wake+0x95b/0x1640 kernel/rcu/tree_exp.h:678
 kthread_worker_fn+0x305/0xba0 kernel/kthread.c:842
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:migration/0     state:S stack:30032 pid:19    tgid:19    ppid:2      flags:0x00004000
Stopper: 0x0 <- 0x0
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 smpboot_thread_fn+0x2d5/0xa30 kernel/smpboot.c:160
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:cpuhp/0         state:S stack:26688 pid:20    tgid:20    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 smpboot_thread_fn+0x2d5/0xa30 kernel/smpboot.c:160
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:cpuhp/1         state:S stack:26896 pid:21    tgid:21    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 smpboot_thread_fn+0x2d5/0xa30 kernel/smpboot.c:160
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:migration/1     state:S stack:30192 pid:22    tgid:22    ppid:2      flags:0x00004000
Stopper: 0x0 <- 0x0
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 smpboot_thread_fn+0x2d5/0xa30 kernel/smpboot.c:160
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:ksoftirqd/1     state:R  running task     stack:25584 pid:23    tgid:23    ppid:2      flags:0x00004008
Call Trace:
 <TASK>
 sched_show_task kernel/sched/core.c:7582 [inline]
 sched_show_task+0x3f0/0x5f0 kernel/sched/core.c:7557
 show_state_filter+0xee/0x320 kernel/sched/core.c:7627
 k_spec drivers/tty/vt/keyboard.c:667 [inline]
 k_spec+0xed/0x150 drivers/tty/vt/keyboard.c:656
 kbd_keycode drivers/tty/vt/keyboard.c:1522 [inline]
 kbd_event+0xcbd/0x17a0 drivers/tty/vt/keyboard.c:1541
 input_handler_events_default+0x116/0x1b0 drivers/input/input.c:2549
 input_pass_values+0x777/0x8e0 drivers/input/input.c:126
 input_event_dispose drivers/input/input.c:352 [inline]
 input_handle_event+0xb30/0x14d0 drivers/input/input.c:369
 input_event drivers/input/input.c:398 [inline]
 input_event+0x83/0xa0 drivers/input/input.c:390
 hidinput_hid_event+0xa12/0x2410 drivers/hid/hid-input.c:1719
 hid_process_event+0x4b7/0x5e0 drivers/hid/hid-core.c:1540
 hid_input_array_field+0x535/0x710 drivers/hid/hid-core.c:1652
 hid_process_report drivers/hid/hid-core.c:1694 [inline]
 hid_report_raw_event+0xa02/0x11c0 drivers/hid/hid-core.c:2040
 __hid_input_report.constprop.0+0x341/0x440 drivers/hid/hid-core.c:2110
 hid_irq_in+0x35e/0x870 drivers/hid/usbhid/hid-core.c:285
 __usb_hcd_giveback_urb+0x389/0x6e0 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x396/0x450 drivers/usb/core/hcd.c:1734
 dummy_timer+0x17c3/0x38d0 drivers/usb/gadget/udc/dummy_hcd.c:1988
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x20a/0xae0 kernel/time/hrtimer.c:1755
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1772
 handle_softirqs+0x206/0x8d0 kernel/softirq.c:554
 run_ksoftirqd kernel/softirq.c:927 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:919
 smpboot_thread_fn+0x661/0xa30 kernel/smpboot.c:164
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/1:0     state:R  running task     stack:22208 pid:24    tgid:24    ppid:2      flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/1:0H    state:I stack:28880 pid:25    tgid:25    ppid:2      flags:0x00004000
Workqueue:  0x0 (events_highpri)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kdevtmpfs       state:S stack:27360 pid:26    tgid:26    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 devtmpfs_work_loop+0x6d6/0x7d0 drivers/base/devtmpfs.c:408
 devtmpfsd+0x4c/0x50 drivers/base/devtmpfs.c:441
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-inet_ state:I stack:30080 pid:27    tgid:27    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/u8:1    state:I stack:24912 pid:28    tgid:28    ppid:2      flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kauditd         state:S stack:29120 pid:29    tgid:29    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 kauditd_thread+0x4da/0xa60 kernel/audit.c:911
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:khungtaskd      state:S stack:29824 pid:30    tgid:30    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_timeout+0x136/0x2a0 kernel/time/timer.c:2615
 watchdog+0x130/0x1240 kernel/hung_task.c:383
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:oom_reaper      state:S stack:30176 pid:31    tgid:31    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 oom_reaper+0x9cc/0xb50 mm/oom_kill.c:645
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-write state:I stack:30832 pid:32    tgid:32    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kcompactd0      state:S stack:28800 pid:33    tgid:33    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_timeout+0x136/0x2a0 kernel/time/timer.c:2615
 kcompactd+0xa8e/0xd50 mm/compaction.c:3181
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-kbloc state:I stack:30176 pid:34    tgid:34    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:irq/9-acpi      state:S stack:30176 pid:35    tgid:35    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 irq_wait_for_interrupt kernel/irq/manage.c:1125 [inline]
 irq_thread+0x19f/0x670 kernel/irq/manage.c:1321
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/1:1     state:I stack:21504 pid:36    tgid:36    ppid:2      flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/u8:2    state:I stack:26304 pid:37    tgid:37    ppid:2      flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-ata_s state:I stack:30176 pid:38    tgid:38    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-md    state:I stack:30176 pid:39    tgid:39    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-md_bi state:I stack:30176 pid:40    tgid:40    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-edac- state:I stack:30080 pid:41    tgid:41    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/1:1H    state:I stack:28272 pid:42    tgid:42    ppid:2      flags:0x00004000
Workqueue:  0x0 (kblockd)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675


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

