Return-Path: <linux-fsdevel+bounces-32426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB79A4F24
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 17:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A031B1F21B34
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 15:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBD0188A3B;
	Sat, 19 Oct 2024 15:37:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D588F558B7
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2024 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729352254; cv=none; b=tAFMftFzdILNLSCS7CMwLZGEFQGyiIun54n7S4kjrIJdZVYN8DaIGQUFJEbRgEqrw3QYsS2UYXYo+CaJp0IQmIPOiT6rkkQ8ivXtOpp95s9NPhWd+MKQD1Fugeg/CJg3AezSDOicb13JKnGu2+P2YPHal5MBwoQJczsNiwCtxIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729352254; c=relaxed/simple;
	bh=2L6SRdYn9Rwrq5pPC8b1sy9/bjn5+2ZXJvaLw1T8q7s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FwXY5MhXdLAst9ywY1pk8N6oKKA4X6u96k8/P68jCdWp03Z0T69Rp6bRzzLklNbX6bELhM77W1c5snjq8G6DucAU0LSlTt3yd4zS3nLv6R2MG2e7zvhtI2k8+ZAT/TvBzC7u7Rmw2Cn48z0sIcjEVkyxxVShF1Vr46YQmJeERLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3b7b13910so28804165ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2024 08:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729352251; x=1729957051;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ML/oUFDuKrOfIH0zxOadjPQ15yq/dr+Ot5792ZZ2iUc=;
        b=pR8G6ktUL++CRGQSMyyUhAbB+KHyL5z54NuqGAFA6t8LNC9rG3pNyXFGCJPrCHX9T9
         PYul6pKwG3eKLwLZZyriSWIxhJ23y06g9/6Ps2gejdKU0gTd0N6ZL3Wf6vCFJV+LoH1D
         wtrViMKyyYlrNTOvuv12cB0pGGyyeCvpQ/KaqSgn/sKFh1urTCTvSIHP4uueK5MwOvZC
         EhoyrhmSTe8BIxeItqVqc+M22Y62Ih+6OOaBgvkP7Fk7tjGpvmvo8S7fY06GJZfPrJK5
         NMprMz/3Kto6D6KnD1EVzt+xCszUNiODbtSs1QB4X3XZq4oA3oTpVdEq/giOhQI4T5ni
         aM2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWEaQ6OexfBsDAOXAidbHDhON1PhCzAKN2bpMnY43aY/HSdnBGKhwXAIesuFzX0xmAtayjhR9RbJ2N6l0n@vger.kernel.org
X-Gm-Message-State: AOJu0YwmrsUJ9Wil4Y9HFzONr/OpV7xr3cf5IgjwERIBMKIPf39ajvXR
	+IzVKOigC30qwHyhUSeoQdErYlF/dcWl0XcbqbyhgHQvSE/OFbzr1Ts2uhcgrhQrEzM0PVwgHl0
	ISXC3n9MzK/9fgHX2bWcq7gx0jS86iMAff3hRiQbQ9TfIrMwdMnHc6ZI=
X-Google-Smtp-Source: AGHT+IEAaeMdfGsVy4hf0CgYPhJbZiHby/jC7Dv6YAdbg3sS3zEEIj50qqqzk31RCKqA+JQFpCYvMunZYMa6ko/T0qBXJ6/uE5Cj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56f:0:b0:3a3:b439:5d09 with SMTP id
 e9e14a558f8ab-3a3f4060aabmr64108445ab.11.1729352250777; Sat, 19 Oct 2024
 08:37:30 -0700 (PDT)
Date: Sat, 19 Oct 2024 08:37:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6713d23a.050a0220.1e4b4d.0029.GAE@google.com>
Subject: [syzbot] [serial?] BUG: soft lockup in debug_check_no_obj_freed
From: syzbot <syzbot+a234c2d63e0c171ca10e@syzkaller.appspotmail.com>
To: brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    07b887f8236e xhci: add helper to stop endpoint and wait fo..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1101fc5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9878fe11046ea2c6
dashboard link: https://syzkaller.appspot.com/bug?extid=a234c2d63e0c171ca10e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e64430580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c447438ae517/disk-07b887f8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1430abb44ca1/vmlinux-07b887f8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/53e62be3705b/bzImage-07b887f8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a234c2d63e0c171ca10e@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 0-...D
 } 2645 jiffies s: 773 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):

Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5465 Comm: udevd Not tainted 6.12.0-rc3-syzkaller-00051-g07b887f8236e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:io_serial_in+0x87/0xb0 drivers/tty/serial/8250/8250_port.c:407
Code: 72 b5 fe 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 1a 66 03 5d 40 89 da ec <5b> 0f b6 c0 5d 41 5c c3 cc cc cc cc e8 f8 ee 0d ff eb a2 e8 81 ef
RSP: 0018:ffffc90000006f08 EFLAGS: 00000002
RAX: dffffc0000000060 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: ffffffff82a06c30 RDI: ffffffff93635660
RBP: ffffffff93635620 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000020 R14: fffffbfff26c6b1e R15: dffffc0000000000
FS:  00007fefb97f9c80(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2dd5ffff CR3: 000000011c53e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 serial_in drivers/tty/serial/8250/8250.h:137 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:159 [inline]
 wait_for_lsr+0xda/0x180 drivers/tty/serial/8250/8250_port.c:2068
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3315 [inline]
 serial8250_console_write+0xf5a/0x17c0 drivers/tty/serial/8250/8250_port.c:3393
 console_emit_next_record kernel/printk/printk.c:3092 [inline]
 console_flush_all+0x800/0xc60 kernel/printk/printk.c:3180
 __console_flush_and_unlock kernel/printk/printk.c:3239 [inline]
 console_unlock+0xd9/0x210 kernel/printk/printk.c:3279
 vprintk_emit+0x424/0x6f0 kernel/printk/printk.c:2407
 vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:68
 _printk+0xc8/0x100 kernel/printk/printk.c:2432
 printk_stack_address arch/x86/kernel/dumpstack.c:72 [inline]
 show_trace_log_lvl+0x1b7/0x3d0 arch/x86/kernel/dumpstack.c:285
 sched_show_task kernel/sched/core.c:7589 [inline]
 sched_show_task+0x3f0/0x5f0 kernel/sched/core.c:7564
 show_state_filter+0xee/0x320 kernel/sched/core.c:7634
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
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 76 80 42 fa 48 89 df e8 8e fd 42 fa f7 c5 00 02 00 00 75 23 9c 58 f6 c4 02 75 37 <bf> 01 00 00 00 e8 d5 3f 37 fa 65 8b 05 b6 fd 12 79 85 c0 74 16 5b
RSP: 0018:ffffc90001abfbd8 EFLAGS: 00000246
RAX: 0000000000000002 RBX: ffffffff935bf3e0 RCX: 1ffffffff14ac291
RDX: 0000000000000000 RSI: ffffffff8727f1c0 RDI: ffffffff8746ea80
RBP: 0000000000000286 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8a564d8f R11: 0000000000000000 R12: ffffffff935bf3d8
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888102e9c000
 __debug_check_no_obj_freed lib/debugobjects.c:998 [inline]
 debug_check_no_obj_freed+0x328/0x600 lib/debugobjects.c:1019
 slab_free_hook mm/slub.c:2273 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x294/0x480 mm/slub.c:4727
 do_delayed_call include/linux/delayed_call.h:28 [inline]
 vfs_readlink+0x149/0x380 fs/namei.c:5272
 do_readlinkat+0x24c/0x390 fs/stat.c:551
 __do_sys_readlink fs/stat.c:574 [inline]
 __se_sys_readlink fs/stat.c:571 [inline]
 __x64_sys_readlink+0x78/0xc0 fs/stat.c:571
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fefb9925d47
Code: 73 01 c3 48 8b 0d e1 90 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 59 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b1 90 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffee0fa4b98 EFLAGS: 00000206 ORIG_RAX: 0000000000000059
RAX: ffffffffffffffda RBX: 00000000000000ff RCX: 00007fefb9925d47
RDX: 0000000000000400 RSI: 00007ffee0fa4fa8 RDI: 00007ffee0fa4ba8
RBP: 00007ffee0fa53e8 R08: 0000562cf15ca1fd R09: 0000000000000000
R10: 0000000000000010 R11: 0000000000000206 R12: 0000000000000200
R13: 00007ffee0fa4fa8 R14: 00007ffee0fa4ba8 R15: 00007ffee0fa5aa9
 </TASK>
 </TASK>
task:kworker/u8:6    state:R  running task     stack:32568 pid:6065  tgid:6065  ppid:282    flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6080  tgid:6080  ppid:243    flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:kworker/u8:7    state:R  running task     stack:32568 pid:6082  tgid:6082  ppid:1112   flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:6087  tgid:6087  ppid:243    flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6698
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f175529ea90
RSP: 002b:00007ffd1fc1f4a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f175538f860 RCX: 00007f175529ea90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f175538f860 R08: 0000000000000001 R09: 8d0dcd55e87a9e27
R10: 00007ffd1fc1f360 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f1755393658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:6091  tgid:6091  ppid:1168   flags:0x00000000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:26016 pid:6097  tgid:6097  ppid:1168   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:modprobe        state:R  running task     stack:23984 pid:6100  tgid:6100  ppid:1168   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:6105  tgid:6105  ppid:1168   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6698
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f347a9efa90
RSP: 002b:00007ffe0433c488 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f347aae0860 RCX: 00007f347a9efa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f347aae0860 R08: 0000000000000001 R09: 1c55e6acb1b2b457
R10: 00007ffe0433c340 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f347aae4658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6109  tgid:6109  ppid:243    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:kworker/u8:3    state:R  running task     stack:32568 pid:6115  tgid:6115  ppid:46     flags:0x00004000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6116  tgid:6116  ppid:243    flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6861
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7199
 might_resched include/linux/kernel.h:73 [inline]
 remove_vma+0x32/0x1a0 mm/vma.c:328
 exit_mmap+0x4e0/0xb30 mm/mmap.c:1888
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6119  tgid:6119  ppid:46     flags:0x00000000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6124  tgid:6124  ppid:1168   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6698
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb260c95a90
RSP: 002b:00007fffa19bd598 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fb260d86860 RCX: 00007fb260c95a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fb260d86860 R08: 0000000000000001 R09: c8beb5f7eefeb567
R10: 00007fffa19bd450 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fb260d8a658 R15: 0000000000000001
 </TASK>
task:kworker/u8:3    state:R  running task     stack:28784 pid:6128  tgid:6128  ppid:46     flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6861
 </TASK>
task:modprobe        state:R  running task     stack:24416 pid:6135  tgid:6135  ppid:1168   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:6142  tgid:6142  ppid:1168   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6698
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7623e7aa90
RSP: 002b:00007ffc42b305a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f7623f6b860 RCX: 00007f7623e7aa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f7623f6b860 R08: 0000000000000001 R09: e2a4624ea37f7418
R10: 00007ffc42b30460 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f7623f6f658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6147  tgid:6147  ppid:37     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6698
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f09bda7aa90
RSP: 002b:00007ffcfb5d2bc8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f09bdb6b860 RCX: 00007f09bda7aa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f09bdb6b860 R08: 0000000000000001 R09: e9ee8b4e2d520c1d
R10: 00007ffcfb5d2a80 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f09bdb6f658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:6152  tgid:6152  ppid:1168   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6155  tgid:6155  ppid:37     flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:6162  tgid:6162  ppid:243    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6698
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6ae101ca90
RSP: 002b:00007ffe8a140c58 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f6ae110d860 RCX: 00007f6ae101ca90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f6ae110d860 R08: 0000000000000001 R09: 881cc29ae1fba195
R10: 00007ffe8a140b10 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f6ae1111658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:23984 pid:6164  tgid:6164  ppid:1168   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6861
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6172  tgid:6172  ppid:243    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6698
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5ee9af4a90
RSP: 002b:00007ffc18c668c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f5ee9be5860 RCX: 00007f5ee9af4a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f5ee9be5860 R08: 0000000000000001 R09: 6ac5e88e10cb51a5
R10: 00007ffc18c66780 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f5ee9be9658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:6175  tgid:6175  ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6698
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbcf9197a90
RSP: 002b:00007ffeb25b2738 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fbcf9288860 RCX: 00007fbcf9197a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fbcf9288860 R08: 0000000000000001 R09: 203a0cb64f1957e4
R10: 00007ffeb25b25f0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fbcf928c658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24416 pid:6183  tgid:6183  ppid:243    flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:6184  tgid:6184  ppid:1168   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:6186  tgid:6186  ppid:37     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6698
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd04e702a90
RSP: 002b:00007ffc879c8398 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fd04e7f3860 RCX: 00007fd04e702a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fd04e7f3860 R08: 0000000000000001 R09: 03af5961ba57cc0e
R10: 00007ffc879c8250 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fd04e7f7658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:23984 pid:6187  tgid:6187  ppid:243    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6698
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe935edaa90
RSP: 002b:00007ffcfdc96a28 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fe935fcb860 RCX: 00007fe935edaa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fe935fcb860 R08: 0000000000000001 R09: 2e026b9deafd7ace
R10: 00007ffcfdc968e0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fe935fcf658 R15: 0000000000000001
 </TASK>
task:kworker/u8:8    state:R  running task     stack:28784 pid:6196  tgid:6196  ppid:1168   flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6861
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:6200  tgid:6200  ppid:37     flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:kworker/u8:2    state:R  running task     stack:32568 pid:6204  tgid:6204  ppid:37     flags:0x00004000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:6206  tgid:6206  ppid:1168   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:kworker/u8:3    state:R  running task     stack:32568 pid:6213  tgid:6213  ppid:46     flags:0x00004000
Call Trace:
 <TASK>
 </TASK>
task:kworker/u8:8    state:R  running task     stack:32568 pid:6224  tgid:6224  ppid:1168   flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:kworker/u8:5    state:R  running task     stack:32568 pid:6232  tgid:6232  ppid:243    flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:23984 pid:6233  tgid:6233  ppid:1112   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:kworker/u8:5    state:R  running task     stack:32568 pid:6242  tgid:6242  ppid:243    flags:0x00004000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6243  tgid:6243  ppid:46     flags:0x00000000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6253  tgid:6253  ppid:1112   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6256  tgid:6256  ppid:243    flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6698
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1aa73c7a90
RSP: 002b:00007ffd822968f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f1aa74b8860 RCX: 00007f1aa73c7a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f1aa74b8860 R08: 0000000000000001 R09: 772b712b87a2229b
R10: 00007ffd822967b0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f1aa74bc658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:6261  tgid:6261  ppid:1112   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6698
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f24fe1afa90
RSP: 002b:00007fffa5d033a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f24fe2a0860 RCX: 00007f24fe1afa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f24fe2a0860 R08: 0000000000000001 R09: a3709c33888e2dfd
R10: 00007fffa5d03260 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f24fe2a4658 R15: 0000000000000001
 </TASK>
task:kworker/u8:2    state:R  running task     stack:28784 pid:6264  tgid:6264  ppid:37     flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6861
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7199
 _cond_resched include/linux/sched.h:2031 [inline]
 stop_one_cpu+0x112/0x190 kernel/stop_machine.c:151
 </TASK>
task:modprobe        state:R  running task     stack:24416 pid:6273  tgid:6273  ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6282  tgid:6282  ppid:1168   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:6285  tgid:6285  ppid:243    flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:kworker/u8:8    state:R  running task     stack:32568 pid:6292  tgid:6292  ppid:1168   flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6295  tgid:6295  ppid:243    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6296  tgid:6296  ppid:37     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6298  tgid:6298  ppid:243    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6300  tgid:6300  ppid:37     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6698
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f19326fba90
RSP: 002b:00007ffc90dba708 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f19327ec860 RCX: 00007f19326fba90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f19327ec860 R08: 0000000000000001 R09: 468f387cc50540c0
R10: 00007ffc90dba5c0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f19327f0658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:6306  tgid:6306  ppid:243    flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6313  tgid:6313  ppid:243    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6698
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5bdbbcfa90
RSP: 002b:00007ffc0f4a1fa8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f5bdbcc0860 RCX: 00007f5bdbbcfa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f5bdbcc0860 R08: 0000000000000001 R09: 94314777406a5a21
R10: 00007ffc0f4a1e60 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f5bdbcc4658 R15: 0000000000000001
 </TASK>
task:kworker/u8:2    state:R  running task     stack:32568 pid:6321  tgid:6321  ppid:37     flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:6322  tgid:6322  ppid:1168   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6330  tgid:6330  ppid:1168   flags:0x00000002
Call Trace:
 <TASK>
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6336  tgid:6336  ppid:37     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:6340  tgid:6340  ppid:1168   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:kworker/u8:2    state:R  running task     stack:32568 pid:6345  tgid:6345  ppid:37     flags:0x00004000
Call Trace:
 <TASK>
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:6348  tgid:6348  ppid:1168   flags:0x00000000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:23984 pid:6352  tgid:6352  ppid:46     flags:0x00000002
Call Trace:
 <TASK>


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

