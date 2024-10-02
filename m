Return-Path: <linux-fsdevel+bounces-30641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D03B898CB87
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 05:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC341F22AB4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 03:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A9E14A90;
	Wed,  2 Oct 2024 03:34:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891DDF59
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 03:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727840065; cv=none; b=qh28+aFfpktoaQ7fJqnIFuUmgGZgV3Egn3+BZAuC/hj86tI+krlhJsK9r+qHbRyBIRd+nP2Jh8+ebPgbd6vstt32SY1QVWdHjaLcuFBr+G7ygpeoHo4ASsxE985BYfljZgT7bJFOsekJKyNsr22XNU2TXp4xfy6ofXA3ISUpHk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727840065; c=relaxed/simple;
	bh=70e1iePiQ82edJph/kTKFYdmVXUwzgKlXkfbUtCwtO4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XlvMb16tSu1+pwVApOwvku3DmEUgD4pGvIkTD6P9KRaRR0DUHvwl24d/OROEU9mRNi2yalCCLm6lvz5WZ91S42/67Sm+cLQ0Qk4ogfuMKK/RBwDVdzl283xoHboYmfFhFt5+Tpg+bm+3zkF+P81UFZYrxMsxu/pbvILvG8m3uV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0cadb1536so73348865ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 20:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727840061; x=1728444861;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MkOJey+XupLxcPbxFqhCj00A4FRaHpjd5GuSSVgp0Ds=;
        b=e4BSj4faomSnGoy+97oqwRh8QTjbnefnz4y24AiUVEDACO6meZ7mMXgtHDBQqYmYhv
         v4NNIrsFchIfdAox133RxwWHh/QE7yuElqmf764hVkixCn9DRPta444qslGQ7wuAR9X7
         N4Q2etcpYoKqdGrLDZ8b3WiT3B3ssU09Kr3DIH06Qb7WXYLNRgpnubwUXQWLA9q4HOv3
         ccB8oGrYRKMPMCCPNmuHGp6l0NyRyEfArY5Mop1p6HutmmR8fjSkjOZjPBiV+cmnVIPU
         XKMmQoeCKayZVETBR4iEIudKwOY+BRcCX1bJoID94HDKIizIZJzJEfpqtpVMzzFNeTSs
         vkSw==
X-Forwarded-Encrypted: i=1; AJvYcCVCQDJ55WB26yHLNyM28s2YgDImIO+ArKgmFoQHsuSiXPEu9OaFzGzPxJzImmDsiDV12N029SnIxTgXEKAu@vger.kernel.org
X-Gm-Message-State: AOJu0YyrVeaL8kqGeDlR+qkX75GmLlWIdTQhJ8qiuhpzkF7nSMO6DwNi
	MhutoDOClXE3UyxNYwQleob4VKrxW/egkyBfUtX5MscomS0pK+BPOPDCrI+EK/KLaWzJqX9G5R9
	C0apKGlz3+UOHw4VSWsnYRI/701eKvIWlBCO1UwBemdIHd9LDjowoV74=
X-Google-Smtp-Source: AGHT+IEJh9DWg8HhK0U1L9DKBhmKTzratJXJTRpy+vK15OTQdSJxOknwaD0iBQ/Jg1/BfpGHl8Gle71YQE2l+hhnjs/aQjOfdP4t
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148e:b0:3a0:9fa5:8f2 with SMTP id
 e9e14a558f8ab-3a365943b72mr17971095ab.18.1727840061627; Tue, 01 Oct 2024
 20:34:21 -0700 (PDT)
Date: Tue, 01 Oct 2024 20:34:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fcbf3d.050a0220.f28ec.04e9.GAE@google.com>
Subject: [syzbot] [fs?] INFO: rcu detected stall in sys_utimensat (3)
From: syzbot <syzbot+6dca7953fd4bbdf92f5d@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    075dbe9f6e3c Merge tag 'soc-ep93xx-dt-6.12' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=16081e80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d9e1c0225f14ccc
dashboard link: https://syzkaller.appspot.com/bug?extid=6dca7953fd4bbdf92f5d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14923e27980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131646a9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/47c253223330/disk-075dbe9f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f66e6e6c457a/vmlinux-075dbe9f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3580fe941737/bzImage-075dbe9f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6dca7953fd4bbdf92f5d@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-...D
 } 2676 jiffies s: 2761 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 2546 Comm: udevd Not tainted 6.11.0-syzkaller-11558-g075dbe9f6e3c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:io_serial_in+0x87/0xb0 drivers/tty/serial/8250/8250_port.c:407
Code: 74 b5 fe 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 1a 66 03 5d 40 89 da ec <5b> 0f b6 c0 5d 41 5c c3 cc cc cc cc e8 08 ea 0d ff eb a2 e8 91 ea
RSP: 0018:ffffc900001b7f08 EFLAGS: 00000002
RAX: dffffc0000000060 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: ffffffff82a04140 RDI: ffffffff9362a660
RBP: ffffffff9362a620 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000020 R14: fffffbfff26c551e R15: dffffc0000000000
FS:  00007f6ef7a6cc80(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200012b8 CR3: 0000000116722000 CR4: 00000000003506f0
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
 __hrtimer_run_queues+0x20c/0xcc0 kernel/time/hrtimer.c:1755
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
RIP: 0010:lock_acquire+0x1f2/0x560 kernel/locking/lockdep.c:5790
Code: c1 05 da 76 cf 7e 83 f8 01 0f 85 ea 02 00 00 9c 58 f6 c4 02 0f 85 d5 02 00 00 48 85 ed 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0018:ffffc900014ffb50 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff9200029ff6c RCX: 0000000000000001
RDX: 0000000000000001 RSI: ffffffff8727f4c0 RDI: ffffffff8746eb20
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff1f547c3
R10: ffffffff8faa3e1f R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: ffff888115a223f8 R15: 0000000000000000
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1716 [inline]
 sb_start_write include/linux/fs.h:1852 [inline]
 mnt_want_write+0x6f/0x450 fs/namespace.c:515
 vfs_utimes+0x6b9/0x850 fs/utimes.c:36
 do_utimes_fd fs/utimes.c:120 [inline]
 do_utimes+0x21a/0x2a0 fs/utimes.c:144
 __do_sys_utimensat fs/utimes.c:164 [inline]
 __se_sys_utimensat fs/utimes.c:148 [inline]
 __x64_sys_utimensat+0x1c7/0x290 fs/utimes.c:148
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6ef7b9afcc
Code: d8 64 89 02 48 83 c8 ff 89 ef 48 89 44 24 08 e8 99 00 fa ff 48 8b 44 24 08 48 83 c4 30 5d c3 c3 41 89 ca b8 18 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 10 48 8b 15 2d 6e 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffca65b3bb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000118
RAX: ffffffffffffffda RBX: 000055fb37157040 RCX: 00007f6ef7b9afcc
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000c
RBP: 000000000000000c R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: ffffffffffffffff R14: 00000000ffffffff R15: 00000000ffffffff
 </TASK>
 __do_sys_epoll_wait fs/eventpoll.c:2471 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2466 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f735c0e6457
RSP: 002b:00007ffed7b36718 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007ffed7b36728 RCX: 00007f735c0e6457
RDX: 0000000000000040 RSI: 00007ffed7b36728 RDI: 0000000000000003
RBP: 00007ffed7b36ab8 R08: 0000000000000aac R09: 00007f735c25b080
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007ffed7b36ab8 R15: 00007ffed7b36dc8
 </TASK>
task:dhcpcd          state:S stack:26384 pid:2583  tgid:2583  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x272/0x3b0 kernel/time/hrtimer.c:2281
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5ded2bbad5
RSP: 002b:00007ffcabd8b540 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00005600b8e03ee0 RCX: 00007f5ded2bbad5
RDX: 00007ffcabd8b560 RSI: 0000000000000004 RDI: 00005600b8e0de70
RBP: 00007ffcabd8b890 R08: 0000000000000008 R09: 00007f5ded3a4080
R10: 00007ffcabd8b890 R11: 0000000000000246 R12: 00007ffcabd8b588
R13: 000056008712e610 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:dhcpcd          state:S stack:23888 pid:2584  tgid:2584  ppid:2583   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5ded2bbad5
RSP: 002b:00007ffcabd8b540 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00005600b8e03ee0 RCX: 00007f5ded2bbad5
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00005600b8e03ec0
RBP: 00007ffcabd8b890 R08: 0000000000000008 R09: fb18c1db426bd72e
R10: 00007ffcabd8b890 R11: 0000000000000246 R12: 0000000000000000
R13: 000056008712e610 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:dhcpcd          state:S stack:27984 pid:2585  tgid:2585  ppid:2583   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5ded2bbad5
RSP: 002b:00007ffcabd8b540 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00005600b8e03ee0 RCX: 00007f5ded2bbad5
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 00005600b8e0cfe0
RBP: 00007ffcabd8b890 R08: 0000000000000008 R09: 000056008712e3d0
R10: 00007ffcabd8b890 R11: 0000000000000246 R12: 0000000000000000
R13: 000056008712e610 R14: 0000000000000003 R15: 0000000000000000
 </TASK>
task:dhcpcd          state:S stack:27088 pid:2586  tgid:2586  ppid:2583   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5ded2bbad5
RSP: 002b:00007ffcabd8b540 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00005600b8e03ee0 RCX: 00007f5ded2bbad5
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 00005600b8e0cfe0
RBP: 00007ffcabd8b890 R08: 0000000000000008 R09: 000056008712e3d0
R10: 00007ffcabd8b890 R11: 0000000000000246 R12: 0000000000000000
R13: 000056008712e610 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:dhcpcd          state:S stack:25904 pid:2602  tgid:2602  ppid:2584   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5ded2bbad5
RSP: 002b:00007ffcabd8b540 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00005600b8e03ee0 RCX: 00007f5ded2bbad5
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00005600b8e0ed50
RBP: 00007ffcabd8b890 R08: 0000000000000008 R09: 0000000000000000
R10: 00007ffcabd8b890 R11: 0000000000000246 R12: 0000000000000000
R13: 000056008712e610 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:sshd            state:S stack:27120 pid:2604  tgid:2604  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6336e5bad5
RSP: 002b:00007ffe8b847dd0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 000055905248dab0 RCX: 00007f6336e5bad5
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000559052493490
RBP: 0000000000000064 R08: 0000000000000008 R09: 0000000000000000
R10: 00007ffe8b847f88 R11: 0000000000000246 R12: 0000559052493490
R13: 00007ffe8b847f88 R14: 0000000000000002 R15: 000055905248eb0c
 </TASK>
task:getty           state:S stack:25408 pid:2606  tgid:2606  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 wait_woken+0x175/0x1c0 kernel/sched/wait.c:423
 n_tty_read+0x10fb/0x1480 drivers/tty/n_tty.c:2277
 iterate_tty_read drivers/tty/tty_io.c:859 [inline]
 tty_read+0x30e/0x5b0 drivers/tty/tty_io.c:934
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x86e/0xbd0 fs/read_write.c:569
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f65d29d0b6a
RSP: 002b:00007ffffd789b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000563fa3d372c0 RCX: 00007f65d29d0b6a
RDX: 0000000000000001 RSI: 00007ffffd789b80 RDI: 0000000000000000
RBP: 0000563fa3d37320 R08: 0000000000000000 R09: 6636c34c59ad5bfc
R10: 0000000000000010 R11: 0000000000000246 R12: 0000563fa3d3735c
R13: 00007ffffd789b80 R14: 0000000000000000 R15: 0000563fa3d3735c
 </TASK>
task:sshd            state:S stack:25408 pid:2645  tgid:2645  ppid:2604   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x272/0x3b0 kernel/time/hrtimer.c:2281
 poll_schedule_timeout.constprop.0+0xba/0x190 fs/select.c:241
 do_poll fs/select.c:964 [inline]
 do_sys_poll+0xad5/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x25a/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1f32fbdad5
RSP: 002b:00007ffc4664c220 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00000000000668a0 RCX: 00007f1f32fbdad5
RDX: 00007ffc4664c240 RSI: 0000000000000004 RDI: 000055b9f94156e0
RBP: 000055b9f94142b0 R08: 0000000000000008 R09: 0000000000000000
R10: 00007ffc4664c328 R11: 0000000000000246 R12: 000055b9cd52baa4
R13: 0000000000000001 R14: 000055b9cd52c3e8 R15: 00007ffc4664c2a8
 </TASK>
task:syz-executor326 state:S stack:25408 pid:2647  tgid:2647  ppid:2645   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 do_nanosleep+0x216/0x510 kernel/time/hrtimer.c:2032
 hrtimer_nanosleep+0x146/0x370 kernel/time/hrtimer.c:2080
 common_nsleep+0xa1/0xd0 kernel/time/posix-timers.c:1365
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1411 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1388 [inline]
 __x64_sys_clock_nanosleep+0x344/0x4a0 kernel/time/posix-timers.c:1388
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0dd87f95c3
RSP: 002b:00007ffc3208c828 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: ffffffffffffffb8 RCX: 00007f0dd87f95c3
RDX: 00007ffc3208c840 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffc3208c840 R11: 0000000000000202 R12: 00007ffc3208c8a0
R13: 00007ffc3208c980 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
task:syz-executor326 state:S stack:27200 pid:2649  tgid:2649  ppid:2647   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 do_nanosleep+0x216/0x510 kernel/time/hrtimer.c:2032
 hrtimer_nanosleep+0x146/0x370 kernel/time/hrtimer.c:2080
 common_nsleep+0xa1/0xd0 kernel/time/posix-timers.c:1365
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1411 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1388 [inline]
 __x64_sys_clock_nanosleep+0x344/0x4a0 kernel/time/posix-timers.c:1388
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0dd87f95c3
RSP: 002b:00007ffc3208c678 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000054305 RCX: 00007f0dd87f95c3
RDX: 00007ffc3208c690 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000ad4 R08: 0000000000005f2e R09: 00007f0dd878c080
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc3208c6dc
R13: 00007ffc3208c710 R14: 00007ffc3208c6f0 R15: 000000000000000c
 </TASK>
task:syz-executor326 state:S stack:27152 pid:2650  tgid:2650  ppid:2647   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 do_nanosleep+0x216/0x510 kernel/time/hrtimer.c:2032
 hrtimer_nanosleep+0x146/0x370 kernel/time/hrtimer.c:2080
 common_nsleep+0xa1/0xd0 kernel/time/posix-timers.c:1365
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1411 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1388 [inline]
 __x64_sys_clock_nanosleep+0x344/0x4a0 kernel/time/posix-timers.c:1388
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0dd87f95c3
RSP: 002b:00007ffc3208c678 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000054321 RCX: 00007f0dd87f95c3
RDX: 00007ffc3208c690 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000ad5 R08: 0000000000005f2e R09: 00007f0dd878c080
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc3208c6dc
R13: 00007ffc3208c710 R14: 00007ffc3208c6f0 R15: 000000000000000c
 </TASK>
task:syz-executor326 state:S stack:26192 pid:2652  tgid:2652  ppid:2647   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 do_nanosleep+0x216/0x510 kernel/time/hrtimer.c:2032
 hrtimer_nanosleep+0x146/0x370 kernel/time/hrtimer.c:2080
 common_nsleep+0xa1/0xd0 kernel/time/posix-timers.c:1365
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1411 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1388 [inline]
 __x64_sys_clock_nanosleep+0x344/0x4a0 kernel/time/posix-timers.c:1388
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0dd87f95c3
RSP: 002b:00007ffc3208c678 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 00000000000542dd RCX: 00007f0dd87f95c3
RDX: 00007ffc3208c690 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000ad2 R08: 0000000000005f2e R09: 00007f0dd878c080
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc3208c6dc
R13: 00007ffc3208c710 R14: 00007ffc3208c6f0 R15: 000000000000000c
 </TASK>
task:syz-executor326 state:S stack:26192 pid:2653  tgid:2653  ppid:2647   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 do_nanosleep+0x216/0x510 kernel/time/hrtimer.c:2032
 hrtimer_nanosleep+0x146/0x370 kernel/time/hrtimer.c:2080
 common_nsleep+0xa1/0xd0 kernel/time/posix-timers.c:1365
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1411 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1388 [inline]
 __x64_sys_clock_nanosleep+0x344/0x4a0 kernel/time/posix-timers.c:1388
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0dd87f95c3
RSP: 002b:00007ffc3208c678 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000054359 RCX: 00007f0dd87f95c3
RDX: 00007ffc3208c690 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000ad6 R08: 0000000000005f2e R09: 00007f0dd878c080
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc3208c6dc
R13: 00007ffc3208c710 R14: 00007ffc3208c6f0 R15: 000000000000000c
 </TASK>
task:syz-executor326 state:S stack:25776 pid:2654  tgid:2654  ppid:2647   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 do_nanosleep+0x216/0x510 kernel/time/hrtimer.c:2032
 hrtimer_nanosleep+0x146/0x370 kernel/time/hrtimer.c:2080
 common_nsleep+0xa1/0xd0 kernel/time/posix-timers.c:1365
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1411 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1388 [inline]
 __x64_sys_clock_nanosleep+0x344/0x4a0 kernel/time/posix-timers.c:1388
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0dd87f95c3
RSP: 002b:00007ffc3208c678 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000054303 RCX: 00007f0dd87f95c3
RDX: 00007ffc3208c690 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000ad3 R08: 0000000000005f2e R09: 00007f0dd878c080
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc3208c6dc
R13: 00007ffc3208c710 R14: 00007ffc3208c6f0 R15: 000000000000000c
 </TASK>
task:kworker/1:2     state:S stack:21056 pid:2660  tgid:2660  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 input_register_device+0x997/0x1140 drivers/input/input.c:2463
 hidinput_connect+0x1d9c/0x2ba0 drivers/hid/hid-input.c:2343
 hid_connect+0x13a8/0x18a0 drivers/hid/hid-core.c:2234
 hid_hw_start drivers/hid/hid-core.c:2349 [inline]
 hid_hw_start+0xaa/0x140 drivers/hid/hid-core.c:2340
 __hid_device_probe drivers/hid/hid-core.c:2703 [inline]
 hid_device_probe+0x3e7/0x490 drivers/hid/hid-core.c:2736
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3682
 hid_add_device+0x37f/0xa70 drivers/hid/hid-core.c:2882
 usbhid_probe+0xd3b/0x1410 drivers/hid/usbhid/hid-core.c:1431
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3682
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3682
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2e58/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/1:3     state:I stack:21152 pid:2661  tgid:2661  ppid:2      flags:0x00004000
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
task:kworker/0:3     state:I stack:21808 pid:2664  tgid:2664  ppid:2      flags:0x00004000
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
task:kworker/1:4     state:I stack:22416 pid:2665  tgid:2665  ppid:2      flags:0x00004000
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
task:kworker/1:5     state:I stack:28840 pid:2674  tgid:2674  ppid:2      flags:0x00004000
Workqueue:  0x0 (mm_percpu_wq)
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
task:kworker/1:6     state:I stack:29072 pid:2677  tgid:2677  ppid:2      flags:0x00004000
Workqueue:  0x0 (mm_percpu_wq)
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
task:kworker/1:7     state:I stack:30064 pid:2678  tgid:2678  ppid:2      flags:0x00004000
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
task:kworker/0:4     state:D stack:21744 pid:2693  tgid:2693  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 __input_unregister_device+0x136/0x450 drivers/input/input.c:2272
 input_unregister_device+0xb9/0x100 drivers/input/input.c:2511
 hidinput_disconnect+0x160/0x3e0 drivers/hid/hid-input.c:2376
 hid_disconnect+0x14d/0x1b0 drivers/hid/hid-core.c:2320
 hid_hw_stop drivers/hid/hid-core.c:2369 [inline]
 hid_device_remove+0x1a8/0x260 drivers/hid/hid-core.c:2757
 device_remove+0xc8/0x170 drivers/base/dd.c:567
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3871
 hid_remove_device drivers/hid/hid-core.c:2939 [inline]
 hid_destroy_device+0xe5/0x150 drivers/hid/hid-core.c:2959
 usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1458
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3871
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:5     state:D stack:22416 pid:2707  tgid:2707  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 exp_funnel_lock+0x344/0x3b0 kernel/rcu/tree_exp.h:320
 synchronize_rcu_expedited+0x290/0x450 kernel/rcu/tree_exp.h:976
 led_trigger_set+0x557/0xc60 drivers/leds/led-triggers.c:202
 led_match_default_trigger drivers/leds/led-triggers.c:269 [inline]
 led_match_default_trigger drivers/leds/led-triggers.c:263 [inline]
 led_trigger_set_default drivers/leds/led-triggers.c:287 [inline]
 led_trigger_set_default+0x1bd/0x2a0 drivers/leds/led-triggers.c:276
 led_classdev_register_ext+0x78c/0x9e0 drivers/leds/led-class.c:555
 led_classdev_register include/linux/leds.h:273 [inline]
 input_leds_connect+0x54a/0x8e0 drivers/input/input-leds.c:145
 input_attach_handler.isra.0+0x181/0x260 drivers/input/input.c:1027
 input_register_device+0xa8e/0x1140 drivers/input/input.c:2470
 hidinput_connect+0x1d9c/0x2ba0 drivers/hid/hid-input.c:2343
 hid_connect+0x13a8/0x18a0 drivers/hid/hid-core.c:2234
 hid_hw_start drivers/hid/hid-core.c:2349 [inline]
 hid_hw_start+0xaa/0x140 drivers/hid/hid-core.c:2340
 __hid_device_probe drivers/hid/hid-core.c:2703 [inline]
 hid_device_probe+0x3e7/0x490 drivers/hid/hid-core.c:2736
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3682
 hid_add_device+0x37f/0xa70 drivers/hid/hid-core.c:2882
 usbhid_probe+0xd3b/0x1410 drivers/hid/usbhid/hid-core.c:1431
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3682
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3682
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2e58/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:6     state:I stack:28848 pid:2712  tgid:2712  ppid:2      flags:0x00004000
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
task:kworker/0:7     state:I stack:30304 pid:2726  tgid:2726  ppid:2      flags:0x00004000
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
task:udevd           state:S stack:27280 pid:2735  tgid:2735  ppid:2546   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 ep_poll fs/eventpoll.c:2062 [inline]
 do_epoll_wait+0x139b/0x1a90 fs/eventpoll.c:2459
 __do_sys_epoll_wait fs/eventpoll.c:2471 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2466 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6ef7ba4457
RSP: 002b:00007ffca65b3a88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6ef7ba4457
RDX: 0000000000000004 RSI: 00007ffca65b3ac8 RDI: 0000000000000004
RBP: 000055fb3886c220 R08: 0000000000000007 R09: 7e497159cdf32cc2
R10: 00000000ffffffff R11: 0000000000000246 R12: 000055fb3887e4a0
R13: 00007ffca65b3ac8 R14: 00000000ffffffff R15: 000055fb388432c0
 </TASK>
task:udevd           state:S stack:27248 pid:2737  tgid:2737  ppid:2546   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 ep_poll fs/eventpoll.c:2062 [inline]
 do_epoll_wait+0x139b/0x1a90 fs/eventpoll.c:2459
 __do_sys_epoll_wait fs/eventpoll.c:2471 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2466 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6ef7ba4457
RSP: 002b:00007ffca65b3a88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6ef7ba4457
RDX: 0000000000000004 RSI: 00007ffca65b3ac8 RDI: 0000000000000004
RBP: 000055fb38861e00 R08: 0000000000000007 R09: 7e497159cdf32cc2
R10: 00000000ffffffff R11: 0000000000000246 R12: 000055fb3887ae40
R13: 00007ffca65b3ac8 R14: 00000000ffffffff R15: 000055fb388432c0
 </TASK>
task:udevd           state:S stack:25888 pid:2742  tgid:2742  ppid:2546   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 ep_poll fs/eventpoll.c:2062 [inline]
 do_epoll_wait+0x139b/0x1a90 fs/eventpoll.c:2459
 __do_sys_epoll_wait fs/eventpoll.c:2471 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2466 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6ef7ba4457
RSP: 002b:00007ffca65b3a88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6ef7ba4457
RDX: 0000000000000004 RSI: 00007ffca65b3ac8 RDI: 0000000000000004
RBP: 000055fb3886c220 R08: 0000000000000007 R09: 7e497159cdf32cc2
R10: 00000000ffffffff R11: 0000000000000246 R12: 000055fb38879110
R13: 00007ffca65b3ac8 R14: 00000000ffffffff R15: 000055fb388432c0
 </TASK>
task:udevd           state:S stack:27744 pid:2743  tgid:2743  ppid:2546   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 ep_poll fs/eventpoll.c:2062 [inline]
 do_epoll_wait+0x139b/0x1a90 fs/eventpoll.c:2459
 __do_sys_epoll_wait fs/eventpoll.c:2471 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2466 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6ef7ba4457
RSP: 002b:00007ffca65b3a88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6ef7ba4457
RDX: 0000000000000004 RSI: 00007ffca65b3ac8 RDI: 0000000000000004
RBP: 000055fb38873e60 R08: 0000000000000007 R09: 7e497159cdf32cc2
R10: 00000000ffffffff R11: 0000000000000246 R12: 000055fb388600e0
R13: 00007ffca65b3ac8 R14: 00000000ffffffff R15: 000055fb388432c0
 </TASK>
task:udevd           state:S stack:26784 pid:2744  tgid:2744  ppid:2546   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 ep_poll fs/eventpoll.c:2062 [inline]
 do_epoll_wait+0x139b/0x1a90 fs/eventpoll.c:2459
 __do_sys_epoll_wait fs/eventpoll.c:2471 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2466 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6ef7ba4457
RSP: 002b:00007ffca65b3a88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6ef7ba4457
RDX: 0000000000000004 RSI: 00007ffca65b3ac8 RDI: 0000000000000004
RBP: 000055fb38922f80 R08: 0000000000000007 R09: 7e497159cdf32cc2
R10: 00000000ffffffff R11: 0000000000000246 R12: 000055fb3887edf0
R13: 00007ffca65b3ac8 R14: 00000000ffffffff R15: 000055fb388432c0
 </TASK>
task:udevd           state:S stack:27328 pid:2745  tgid:2745  ppid:2546   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 ep_poll fs/eventpoll.c:2062 [inline]
 do_epoll_wait+0x139b/0x1a90 fs/eventpoll.c:2459
 __do_sys_epoll_wait fs/eventpoll.c:2471 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2466 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6ef7ba4457
RSP: 002b:00007ffca65b3a88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6ef7ba4457
RDX: 0000000000000004 RSI: 00007ffca65b3ac8 RDI: 0000000000000004
RBP: 000055fb3884f8f0 R08: 0000000000000007 R09: 7e497159cdf32cc2
R10: 00000000ffffffff R11: 0000000000000246 R12: 000055fb3887d6c0
R13: 00007ffca65b3ac8 R14: 00000000ffffffff R15: 000055fb388432c0
 </TASK>
task:udevd           state:S stack:28096 pid:2746  tgid:2746  ppid:2546   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 ep_poll fs/eventpoll.c:2062 [inline]
 do_epoll_wait+0x139b/0x1a90 fs/eventpoll.c:2459
 __do_sys_epoll_wait fs/eventpoll.c:2471 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2466 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6ef7ba4457
RSP: 002b:00007ffca65b3a88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6ef7ba4457
RDX: 0000000000000004 RSI: 00007ffca65b3ac8 RDI: 0000000000000004
RBP: 000055fb38875ef0 R08: 0000000000000007 R09: 7e497159cdf32cc2
R10: 00000000ffffffff R11: 0000000000000246 R12: 000055fb388835d0
R13: 00007ffca65b3ac8 R14: 00000000ffffffff R15: 000055fb388432c0
 </TASK>
task:udevd           state:S stack:27536 pid:2747  tgid:2747  ppid:2546   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 ep_poll fs/eventpoll.c:2062 [inline]
 do_epoll_wait+0x139b/0x1a90 fs/eventpoll.c:2459
 __do_sys_epoll_wait fs/eventpoll.c:2471 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2466 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6ef7ba4457
RSP: 002b:00007ffca65b3a88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6ef7ba4457
RDX: 0000000000000004 RSI: 00007ffca65b3ac8 RDI: 0000000000000004
RBP: 000055fb38875ef0 R08: 0000000000000007 R09: 7e497159cdf32cc2
R10: 00000000ffffffff R11: 0000000000000246 R12: 000055fb38883820
R13: 00007ffca65b3ac8 R14: 00000000ffffffff R15: 000055fb388432c0
 </TASK>
task:udevd           state:S stack:26000 pid:2748  tgid:2748  ppid:2546   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 ep_poll fs/eventpoll.c:2062 [inline]
 do_epoll_wait+0x139b/0x1a90 fs/eventpoll.c:2459
 __do_sys_epoll_wait fs/eventpoll.c:2471 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2466 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6ef7ba4457
RSP: 002b:00007ffca65b3a88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6ef7ba4457
RDX: 0000000000000004 RSI: 00007ffca65b3ac8 RDI: 0000000000000004
RBP: 000055fb3887e4a0 R08: 0000000000000007 R09: 7e497159cdf32cc2
R10: 00000000ffffffff R11: 0000000000000246 R12: 000055fb3887fde0
R13: 00007ffca65b3ac8 R14: 00000000ffffffff R15: 000055fb388432c0
 </TASK>
task:udevd           state:S stack:28368 pid:2759  tgid:2759  ppid:2546   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 ep_poll fs/eventpoll.c:2062 [inline]
 do_epoll_wait+0x139b/0x1a90 fs/eventpoll.c:2459
 __do_sys_epoll_wait fs/eventpoll.c:2471 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2466 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6ef7ba4457
RSP: 002b:00007ffca65b3a88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6ef7ba4457
RDX: 0000000000000004 RSI: 00007ffca65b3ac8 RDI: 0000000000000004
RBP: 000055fb3887fff0 R08: 0000000000000006 R09: 7e497159cdf32cc2
R10: 00000000ffffffff R11: 0000000000000246 R12: 000055fb3888f0e0
R13: 00007ffca65b3ac8 R14: 00000000ffffffff R15: 000055fb388432c0
 </TASK>
task:syz-executor326 state:D stack:28192 pid:2770  tgid:2770  ppid:2652   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 exp_funnel_lock+0x344/0x3b0 kernel/rcu/tree_exp.h:320
 synchronize_rcu_expedited+0x290/0x450 kernel/rcu/tree_exp.h:976
 module_remove_driver+0x2e/0x260 drivers/base/module.c:102
 bus_remove_driver+0x143/0x2c0 drivers/base/bus.c:743
 driver_unregister+0x76/0xb0 drivers/base/driver.c:274
 usb_gadget_unregister_driver+0x49/0x70 drivers/usb/gadget/udc/core.c:1731
 raw_release+0x1ae/0x2b0 drivers/usb/gadget/legacy/raw_gadget.c:462
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2c50 kernel/exit.c:939
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0dd87cf739
RSP: 002b:00007ffc3208c658 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0dd87cf739
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f0dd884c390 R08: ffffffffffffffb8 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0dd884c390
R13: 0000000000000000 R14: 00007f0dd88500a0 R15: 00007f0dd879d8f0
 </TASK>
task:syz-executor326 state:D stack:28368 pid:2771  tgid:2771  ppid:2654   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 synchronize_rcu_expedited+0x392/0x450 kernel/rcu/tree_exp.h:991
 module_remove_driver+0x2e/0x260 drivers/base/module.c:102
 bus_remove_driver+0x143/0x2c0 drivers/base/bus.c:743
 driver_unregister+0x76/0xb0 drivers/base/driver.c:274
 usb_gadget_register_driver_owner+0x1da/0x2f0 drivers/usb/gadget/udc/core.c:1721
 raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:595 [inline]
 raw_ioctl+0x1731/0x2b90 drivers/usb/gadget/legacy/raw_gadget.c:1306
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18f/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0dd87d166b
RSP: 002b:00007ffc3208a5b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f0dd87d166b
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000005
RBP: 00007ffc3208b670 R08: 0000000000000010 R09: 00342e6364755f79
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007ffc3208a640 R14: 00007ffc3208c6f0 R15: 00007f0dd884c3e0
 </TASK>
task:syz-executor326 state:S stack:28368 pid:2772  tgid:2772  ppid:2649   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3e1/0x600 kernel/sched/completion.c:116
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion_interruptible+0x1f/0x40 kernel/sched/completion.c:216
 raw_process_ep_io+0x5d7/0xb90 drivers/usb/gadget/legacy/raw_gadget.c:1121
 raw_ioctl_ep_write drivers/usb/gadget/legacy/raw_gadget.c:1152 [inline]
 raw_ioctl+0xa4d/0x2b90 drivers/usb/gadget/legacy/raw_gadget.c:1324
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18f/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0dd87d166b
RSP: 002b:00007ffc3208b630 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000034 RCX: 00007f0dd87d166b
RDX: 00007ffc3208b6a0 RSI: 0000000040085507 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000ffffff81 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc3208c6dc
R13: 00007ffc3208c710 R14: 00007ffc3208c6f0 R15: 000000000000000c
 </TASK>
task:syz-executor326 state:D stack:28224 pid:2773  tgid:2773  ppid:2650   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:329
 synchronize_rcu_expedited+0x290/0x450 kernel/rcu/tree_exp.h:976
 module_remove_driver+0x2e/0x260 drivers/base/module.c:102
 bus_remove_driver+0x143/0x2c0 drivers/base/bus.c:743
 driver_unregister+0x76/0xb0 drivers/base/driver.c:274
 usb_gadget_unregister_driver+0x49/0x70 drivers/usb/gadget/udc/core.c:1731
 raw_release+0x1ae/0x2b0 drivers/usb/gadget/legacy/raw_gadget.c:462
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2c50 kernel/exit.c:939
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0dd87cf739
RSP: 002b:00007ffc3208c658 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0dd87cf739
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f0dd884c390 R08: ffffffffffffffb8 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0dd884c390
R13: 0000000000000000 R14: 00007f0dd88500a0 R15: 00007f0dd879d8f0
 </TASK>
task:syz-executor326 state:S stack:28368 pid:2774  tgid:2774  ppid:2653   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3e1/0x600 kernel/sched/completion.c:116
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion_interruptible+0x1f/0x40 kernel/sched/completion.c:216
 raw_process_ep_io+0x5d7/0xb90 drivers/usb/gadget/legacy/raw_gadget.c:1121
 raw_ioctl_ep_write drivers/usb/gadget/legacy/raw_gadget.c:1152 [inline]
 raw_ioctl+0xa4d/0x2b90 drivers/usb/gadget/legacy/raw_gadget.c:1324
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18f/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0dd87d166b
RSP: 002b:00007ffc3208b630 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0dd87d166b
RDX: 00007ffc3208b6a0 RSI: 0000000040085507 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000ffffff81 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc3208c6dc
R13: 00007ffc3208c710 R14: 00007ffc3208c6f0 R15: 000000000000000c
 </TASK>

Showing all locks held in the system:
7 locks held by kworker/1:0/24:
 #0: ffff888105adf548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000019fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888109f6c190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888109f6c190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff888105f6a190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888105f6a190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff88810636e160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88810636e160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffff88810b741a20 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #5: ffff88810b741a20 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #6: ffffffff89bd5968 (input_mutex){+.+.}-{3:3}, at: input_register_device+0x997/0x1140 drivers/input/input.c:2463
5 locks held by udevd/2546:
 #0: ffff888115a223f8 (sb_writers#6){.+.+}-{0:0}, at: vfs_utimes+0x6b9/0x850 fs/utimes.c:36
 #1: ffff8881102d1230 (&dev->event_lock){..-.}-{2:2}, at: input_event drivers/input/input.c:397 [inline]
 #1: ffff8881102d1230 (&dev->event_lock){..-.}-{2:2}, at: input_event+0x70/0xa0 drivers/input/input.c:390
 #2: ffffffff88ebacc0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #2: ffffffff88ebacc0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff88ebacc0 (rcu_read_lock){....}-{1:2}, at: input_pass_values+0x8b/0x8e0 drivers/input/input.c:118
 #3: ffffffff893872d8 (kbd_event_lock){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #3: ffffffff893872d8 (kbd_event_lock){..-.}-{2:2}, at: kbd_event+0x8a/0x17a0 drivers/tty/vt/keyboard.c:1535
 #4: ffffffff88ebacc0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #4: ffffffff88ebacc0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #4: ffffffff88ebacc0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6701
2 locks held by getty/2606:
 #0: ffff88810aabb0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
7 locks held by kworker/1:2/2660:
 #0: ffff888105adf548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000177fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888109fb7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888109fb7190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff888105f6b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888105f6b190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff8881093e6160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff8881093e6160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffff888107b09a20 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #5: ffff888107b09a20 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #6: ffffffff89bd5968 (input_mutex){+.+.}-{3:3}, at: input_register_device+0x997/0x1140 drivers/input/input.c:2463
7 locks held by kworker/0:4/2693:
 #0: ffff888105adf548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900017efd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888109f61190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888109f61190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff888109f2a190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888109f2a190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff88810a339160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88810a339160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88810a339160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
 #5: ffff888108f95a20 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #5: ffff888108f95a20 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #5: ffff888108f95a20 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
 #6: ffffffff89bd5968 (input_mutex){+.+.}-{3:3}, at: __input_unregister_device+0x136/0x450 drivers/input/input.c:2272
10 locks held by kworker/0:5/2707:
 #0: ffff888105adf548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900016afd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888109b6e190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888109b6e190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff888109fd7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888109fd7190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff88810a33b160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88810a33b160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffff88810bbbda20 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #5: ffff88810bbbda20 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #6: ffffffff89bd5968 (input_mutex){+.+.}-{3:3}, at: input_register_device+0x997/0x1140 drivers/input/input.c:2463
 #7: ffff88811f95e8a0 (&led_cdev->led_access){+.+.}-{3:3}, at: led_classdev_register_ext+0x51b/0x9e0 drivers/leds/led-class.c:515
 #8: ffffffff892bb010 (triggers_list_lock){++++}-{3:3}, at: led_trigger_set_default drivers/leds/led-triggers.c:2

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

