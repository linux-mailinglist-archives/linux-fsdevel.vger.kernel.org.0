Return-Path: <linux-fsdevel+bounces-31054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A06999154E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 10:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9361AB22E3B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 08:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14DE13D52F;
	Sat,  5 Oct 2024 08:27:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119313CAA5
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728116850; cv=none; b=dzWLNKd1m7hbPYS3LbioeHy313+7KSyFONN+0mMNDEONZxeT2e8u8axeVKr/UFjLtuyX/hxWEriHYcD3MgMvWbjHlQ2nHmKBHLrcNyQ7FT/9KBbH0URXeRqeju6aa80LtfXPM9hIaJxoog3YWulAvlQ1Xnc90si5rio+BjY5kMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728116850; c=relaxed/simple;
	bh=jLzsXd0t+3nZwJPLhU+lj/1gYwdNxuzrJdQ+f0b8jRg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BIjE7eBoSS02kue21s9RiWQEO9Ku2D8b1NMUJst8vaBv68tU1WhWxYOG5geiqFp9W/v3eH/gbsAz4tTsfnWIQpNdXrIXRx4Aw2UXAP4KrLF7fkgzx0cT8xZthmZteJTxB02mhi1VSRME+4OMe7CtK1Nc/TiP4BRX+TpOmAz+OqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a345a02c23so29849375ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Oct 2024 01:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728116846; x=1728721646;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6x73EdS9bV/xYGKa330rQC/GAe7IgVCIO1U6eTTD7v4=;
        b=cdgLqRhParxBqDoZEBtA2OLp4Tlp/L4YffLKiytPzZx4XMnDMh715TrVIaGxycWeNG
         f4jyguMyAzrDSVVlz2z0X2JZnR1FxHrg1bGlNvpbeRphprp9rWTNtTimmWtw/woQ/ISb
         h+XNqDWz8r1f8bmXIkthSLoceEDLmO+6OeSrJxWfofVV1fReSYZa+os6yjCprv6tn4qH
         lRtacD7JTkixqKjNfkR0GW0LUwGqYBs6UvB/R4Yg6grGHj7qvV8a7Aae6CUESIsEJ1US
         ExqBrY7ilw70ADwX3rBcHs+IEmSDKBieSynqV6+/Absb0VHayJM7jst7SXCf849tSp26
         /NMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeiKN36tuJPtjGCTDwZ5Qf65woYm+xUh21GMdsxWuNdmYd6s4aG71YCh5l+k4rHAAaGkyjGvKuIEwD7zdO@vger.kernel.org
X-Gm-Message-State: AOJu0YztExLWmwQoTtGxuVMQQnOv/L94gXIKHq2t8QGoPhpOURLE6rug
	5bUibfVfqNw2anVQoiRx6PoVaeDD6tDJvvGrwjv9TYWDHjRnJaKbEGuwFG5pbYr1u4wdNJAcpPu
	ZEmmgwaBXQcM0r1Dz6qS1eMsp/oCtegKCttIJE+ErsLtO732vhIsv6lE=
X-Google-Smtp-Source: AGHT+IHhnoIUXrzIt6es0wUOaE9ES7FQG3jqSTz9dW+G56WX2uFKCj3hV2gvWF5v+MMICHLwNf5vv78IjfDPr8n3xqYz+sg/jCL3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d88:b0:3a3:449b:597b with SMTP id
 e9e14a558f8ab-3a375bb0080mr49865185ab.18.1728116846317; Sat, 05 Oct 2024
 01:27:26 -0700 (PDT)
Date: Sat, 05 Oct 2024 01:27:26 -0700
In-Reply-To: <66fec31d.050a0220.9ec68.0049.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6700f86e.050a0220.49194.04b6.GAE@google.com>
Subject: Re: [syzbot] [usb?] [fs?] [input?] INFO: rcu detected stall in __fsnotify_parent
From: syzbot <syzbot+a9cae4ac3dad4268693f@syzkaller.appspotmail.com>
To: amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    4a9fe2a8ac53 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=156a479f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=a9cae4ac3dad4268693f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16aad307980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c74d27980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/883c5319cb52/disk-4a9fe2a8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/caf4421ed2ef/vmlinux-4a9fe2a8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d8e3beb01d49/bzImage-4a9fe2a8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a9cae4ac3dad4268693f@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 0-...D
 } 2630 jiffies s: 645 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):

Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 2531 Comm: acpid Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:io_serial_out+0x8f/0xb0 drivers/tty/serial/8250/8250_port.c:413
Code: 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 1c 66 03 5d 40 44 89 e8 89 da ee <5b> 5d 41 5c 41 5d c3 cc cc cc cc e8 f1 eb 0d ff eb a0 e8 7a ec 0d
RSP: 0018:ffffc90000006f60 EFLAGS: 00000002
RAX: 000000000000002e RBX: 00000000000003f8 RCX: 0000000000000000
RDX: 00000000000003f8 RSI: ffffffff82a076c5 RDI: ffffffff936356a0
RBP: ffffffff93635660 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 000000000000002e R14: ffffffff82a07660 R15: 0000000000000000
FS:  00007f1bc5156740(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f42725dd0d8 CR3: 0000000115d0c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 serial_out drivers/tty/serial/8250/8250.h:142 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3322 [inline]
 serial8250_console_write+0xf9e/0x17c0 drivers/tty/serial/8250/8250_port.c:3393
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
RIP: 0010:trace_lock_release include/trace/events/lock.h:69 [inline]
RIP: 0010:lock_release+0xb1/0x6f0 kernel/locking/lockdep.c:5836
Code: 07 0f 87 21 05 00 00 89 ed be 08 00 00 00 48 89 e8 48 c1 e8 06 48 8d 3c c5 88 41 56 8a e8 07 23 7b 00 48 0f a3 2d 87 f9 22 09 <0f> 82 3a 04 00 00 48 c7 c5 38 51 56 8a 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc900019dfb00 EFLAGS: 00000247
RAX: 0000000000000001 RBX: 1ffff9200033bf62 RCX: ffffffff813347f9
RDX: fffffbfff14ac832 RSI: 0000000000000008 RDI: ffffffff8a564188
RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff14ac831
R10: ffffffff8a56418f R11: 0000000000000000 R12: ffffffff88ebb100
R13: 0000000000000000 R14: 000000000003c40c R15: ffff88811b1140d8
 rcu_lock_release include/linux/rcupdate.h:347 [inline]
 rcu_read_unlock include/linux/rcupdate.h:880 [inline]
 dput.part.0+0xd3/0x9b0 fs/dcache.c:852
 dput+0x1f/0x30 fs/dcache.c:847
 __fsnotify_parent+0x776/0xa30 fs/notify/fsnotify.c:265
 fsnotify_parent include/linux/fsnotify.h:96 [inline]
 fsnotify_file include/linux/fsnotify.h:131 [inline]
 fsnotify_access include/linux/fsnotify.h:380 [inline]
 vfs_read+0x465/0xbd0 fs/read_write.c:573
 ksys_read+0x1fa/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1bc5220b6a
Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffcee68bf08 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055d62d138380 RCX: 00007f1bc5220b6a
RDX: 0000000000000018 RSI: 00007ffcee68bf10 RDI: 000000000000000b
RBP: 0000000000000007 R08: 0000000000000000 R09: 000055d62d138360
R10: 0000000000000008 R11: 0000000000000246 R12: 000000000000000b
R13: 00007ffcee68bf10 R14: 0000000000000001 R15: 000000000000000b
 </TASK>
 add_hwgenerator_randomness+0xff/0x190 drivers/char/random.c:968
 hwrng_fillfn+0x1f9/0x380 drivers/char/hw_random/core.c:508
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/u8:5    state:I stack:26592 pid:209   tgid:209   ppid:2      flags:0x00004000
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
task:scsi_eh_0       state:S stack:30176 pid:225   tgid:225   ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 scsi_error_handler+0x532/0xef0 drivers/scsi/scsi_error.c:2312
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-scsi_ state:I stack:29712 pid:226   tgid:226   ppid:2      flags:0x00004000
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
task:kworker/R-targe state:I stack:30832 pid:250   tgid:250   ppid:2      flags:0x00004000
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
task:kworker/R-targe state:I stack:30080 pid:252   tgid:252   ppid:2      flags:0x00004000
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
task:kworker/R-xcopy state:I stack:30080 pid:253   tgid:253   ppid:2      flags:0x00004000
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
task:kworker/1:1H    state:I stack:27568 pid:296   tgid:296   ppid:2      flags:0x00004000
Workqueue:  0x0 (kblockd)
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
task:kworker/R-liber state:I stack:29040 pid:335   tgid:335   ppid:2      flags:0x00004000
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
task:kworker/R-zd121 state:I stack:30080 pid:365   tgid:365   ppid:2      flags:0x00004000
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
task:kworker/R-uas   state:I stack:30080 pid:446   tgid:446   ppid:2      flags:0x00004000
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
task:kworker/R-usbip state:I stack:30832 pid:742   tgid:742   ppid:2      flags:0x00004000
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
task:kworker/1:2     state:I stack:29680 pid:845   tgid:845   ppid:2      flags:0x00004000
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
task:pvrusb2-context state:S stack:29344 pid:988   tgid:988   ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 pvr2_context_thread_func+0x631/0x970 drivers/media/usb/pvrusb2/pvrusb2-context.c:160
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-kvub3 state:I stack:30080 pid:1025  tgid:1025  ppid:2      flags:0x00004000
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
task:kworker/R-kvub3 state:I stack:30080 pid:1026  tgid:1026  ppid:2      flags:0x00004000
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
task:kworker/R-kvub3 state:I stack:30080 pid:1027  tgid:1027  ppid:2      flags:0x00004000
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
task:kworker/R-kmems state:I stack:30080 pid:1031  tgid:1031  ppid:2      flags:0x00004000
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
task:kworker/R-elous state:I stack:30832 pid:1063  tgid:1063  ppid:2      flags:0x00004000
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
task:kworker/R-mld   state:I stack:30080 pid:1246  tgid:1246  ppid:2      flags:0x00004000
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
task:kworker/R-ipv6_ state:I stack:30080 pid:1247  tgid:1247  ppid:2      flags:0x00004000
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
task:jbd2/sda1-8     state:S stack:25760 pid:2507  tgid:2507  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 kjournald2+0x5c7/0x760 fs/jbd2/journal.c:230
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-ext4- state:I stack:30080 pid:2508  tgid:2508  ppid:2      flags:0x00004000
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
task:kworker/0:2     state:I stack:22352 pid:2509  tgid:2509  ppid:2      flags:0x00004000
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
task:syslogd         state:S stack:25408 pid:2528  tgid:2528  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 __skb_wait_for_more_packets+0x36c/0x5e0 net/core/datagram.c:121
 __unix_dgram_recvmsg+0x243/0xdd0 net/unix/af_unix.c:2448
 unix_dgram_recvmsg+0xd0/0x110 net/unix/af_unix.c:2537
 sock_recvmsg_nosec net/socket.c:1051 [inline]
 sock_recvmsg+0x1f6/0x250 net/socket.c:1073
 sock_read_iter+0x2bb/0x3b0 net/socket.c:1143
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0xa3b/0xbd0 fs/read_write.c:569
 ksys_read+0x1fa/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb37ae18b6a
RSP: 002b:00007ffd3dd5bb18 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fb37ae18b6a
RDX: 00000000000000ff RSI: 000055d4d8be9300 RDI: 0000000000000000
RBP: 000055d4d8be92c0 R08: 0000000000000001 R09: 0000000000000000
R10: 00007fb37afb73a3 R11: 0000000000000246 R12: 000055d4d8be933a
R13: 000055d4d8be9300 R14: 0000000000000000 R15: 00007fb37affba80
 </TASK>
task:acpid           state:R  running task     stack:25600 pid:2531  tgid:2531  ppid:1      flags:0x00000008
Call Trace:
 <IRQ>
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
RIP: 0010:trace_lock_release include/trace/events/lock.h:69 [inline]
RIP: 0010:lock_release+0xb1/0x6f0 kernel/locking/lockdep.c:5836
Code: 07 0f 87 21 05 00 00 89 ed be 08 00 00 00 48 89 e8 48 c1 e8 06 48 8d 3c c5 88 41 56 8a e8 07 23 7b 00 48 0f a3 2d 87 f9 22 09 <0f> 82 3a 04 00 00 48 c7 c5 38 51 56 8a 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc900019dfb00 EFLAGS: 00000247
RAX: 0000000000000001 RBX: 1ffff9200033bf62 RCX: ffffffff813347f9
RDX: fffffbfff14ac832 RSI: 0000000000000008 RDI: ffffffff8a564188
RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff14ac831
R10: ffffffff8a56418f R11: 0000000000000000 R12: ffffffff88ebb100
R13: 0000000000000000 R14: 000000000003c40c R15: ffff88811b1140d8
 rcu_lock_release include/linux/rcupdate.h:347 [inline]
 rcu_read_unlock include/linux/rcupdate.h:880 [inline]
 dput.part.0+0xd3/0x9b0 fs/dcache.c:852
 dput+0x1f/0x30 fs/dcache.c:847
 __fsnotify_parent+0x776/0xa30 fs/notify/fsnotify.c:265
 fsnotify_parent include/linux/fsnotify.h:96 [inline]
 fsnotify_file include/linux/fsnotify.h:131 [inline]
 fsnotify_access include/linux/fsnotify.h:380 [inline]
 vfs_read+0x465/0xbd0 fs/read_write.c:573
 ksys_read+0x1fa/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1bc5220b6a
Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffcee68bf08 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055d62d138380 RCX: 00007f1bc5220b6a
RDX: 0000000000000018 RSI: 00007ffcee68bf10 RDI: 000000000000000b
RBP: 0000000000000007 R08: 0000000000000000 R09: 000055d62d138360
R10: 0000000000000008 R11: 0000000000000246 R12: 000000000000000b
R13: 00007ffcee68bf10 R14: 0000000000000001 R15: 000000000000000b
 </TASK>
task:klogd           state:S stack:25344 pid:2535  tgid:2535  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 syslog_print+0x214/0x5d0 kernel/printk/printk.c:1614
 do_syslog+0x3be/0x6a0 kernel/printk/printk.c:1766
 __do_sys_syslog kernel/printk/printk.c:1858 [inline]
 __se_sys_syslog kernel/printk/printk.c:1856 [inline]
 __x64_sys_syslog+0x74/0xb0 kernel/printk/printk.c:1856
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbf8a427fa7
RSP: 002b:00007ffcae150d88 EFLAGS: 00000206 ORIG_RAX: 0000000000000067
RAX: ffffffffffffffda RBX: 00007fbf8a5c64a0 RCX: 00007fbf8a427fa7
RDX: 00000000000003ff RSI: 00007fbf8a5c64a0 RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000000000007 R09: c8637c4b94a81d5c
R10: 0000000000004000 R11: 0000000000000206 R12: 00007fbf8a5c64a0
R13: 00007fbf8a5b6212 R14: 00007fbf8a5c651f R15: 00007fbf8a5c651f
 </TASK>
task:udevd           state:S stack:25744 pid:2546  tgid:2546  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_hrtimeout_range_clock+0x272/0x3b0 kernel/time/hrtimer.c:2281
 ep_poll fs/eventpoll.c:2062 [inline]
 do_epoll_wait+0x139b/0x1a90 fs/eventpoll.c:2459
 __do_sys_epoll_wait fs/eventpoll.c:2471 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2466 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f869caa3457
RSP: 002b:00007ffe3ffc78b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007ffe3ffc79b8 RCX: 00007f869caa3457
RDX: 0000000000000008 RSI: 00007ffe3ffc79b8 RDI: 000000000000000b
RBP: 0000562d38ea0750 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000bb8 R11: 0000000000000246 R12: 0000000000000bb8
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:dbus-daemon     state:S stack:26848 pid:2568  tgid:2568  ppid:1      flags:0x00000002
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
RIP: 0033:0x7fc2a0f9e457
RSP: 002b:00007ffefbdd13b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007ffefbdd13c8 RCX: 00007fc2a0f9e457
RDX: 0000000000000040 RSI: 00007ffefbdd13c8 RDI: 0000000000000003
RBP: 00007ffefbdd1758 R08: 00000000000007c0 R09: 00007fc2a1113080
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007ffefbdd1758 R15: 00007ffefbdd1a68
 </TASK>
task:dhcpcd          state:S stack:25984 pid:2583  tgid:2583  ppid:1      flags:0x00000002
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
RIP: 0033:0x7f3846d25ad5
RSP: 002b:00007ffe80205fc0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00005649eb81bee0 RCX: 00007f3846d25ad5
RDX: 00007ffe80205fe0 RSI: 0000000000000004 RDI: 00005649eb825e70
RBP: 00007ffe80206310 R08: 0000000000000008 R09: 00007f3846e0e080
R10: 00007ffe80206310 R11: 0000000000000246 R12: 00007ffe80206008
R13: 00005649b3212610 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:dhcpcd          state:S stack:23552 pid:2584  tgid:2584  ppid:2583   flags:0x00000002
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
RIP: 0033:0x7f3846d25ad5
RSP: 002b:00007ffe80205fc0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00005649eb81bee0 RCX: 00007f3846d25ad5
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00005649eb81bec0
RBP: 00007ffe80206310 R08: 0000000000000008 R09: d92a8178b2e83299
R10: 00007ffe80206310 R11: 0000000000000246 R12: 0000000000000000
R13: 00005649b3212610 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:dhcpcd          state:S stack:27520 pid:2585  tgid:2585  ppid:2583   flags:0x00000002
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
RIP: 0033:0x7f3846d25ad5
RSP: 002b:00007ffe80205fc0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00005649eb81bee0 RCX: 00007f3846d25ad5
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 00005649eb824fe0
RBP: 00007ffe80206310 R08: 0000000000000008 R09: 00005649b32123d0
R10: 00007ffe80206310 R11: 0000000000000246 R12: 0000000000000000
R13: 00005649b3212610 R14: 0000000000000003 R15: 0000000000000000
 </TASK>
task:dhcpcd          state:S stack:26928 pid:2586  tgid:2586  ppid:2583   flags:0x00000002
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
RIP: 0033:0x7f3846d25ad5
RSP: 002b:00007ffe80205fc0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00005649eb81bee0 RCX: 00007f3846d25ad5
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 00005649eb824fe0
RBP: 00007ffe80206310 R08: 0000000000000008 R09: 00005649b32123d0
R10: 00007ffe80206310 R11: 0000000000000246 R12: 0000000000000000
R13: 00005649b3212610 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:sshd            state:S stack:27344 pid:2602  tgid:2602  ppid:1      flags:0x00000002
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
RIP: 0033:0x7f459e0e1ad5
RSP: 002b:00007ffd46cb5db0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00005650b52a5ab0 RCX: 00007f459e0e1ad5
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00005650b52ab490
RBP: 0000000000000064 R08: 0000000000000008 R09: 0000000000000000
R10: 00007ffd46cb5f68 R11: 0000000000000246 R12: 00005650b52ab490
R13: 00007ffd46cb5f68 R14: 0000000000000002 R15: 00005650b52a6b0c
 </TASK>
task:getty           state:S stack:25408 pid:2604  tgid:2604  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 wait_woken+0x175/0x1c0 kernel/sched/wait.c:423
 n_tty_read+0x10fb/0x1480 drivers/tty/n_tty.c:2277
 iterate_tty_read drivers/tty/tty_io.c:856 [inline]
 tty_read+0x30e/0x5b0 drivers/tty/tty_io.c:931
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x86e/0xbd0 fs/read_write.c:569
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6dc831eb6a
RSP: 002b:00007ffdc4021318 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000557343bdb2c0 RCX: 00007f6dc831eb6a
RDX: 0000000000000001 RSI: 00007ffdc4021330 RDI: 0000000000000000
RBP: 0000557343bdb320 R08: 0000000000000000 R09: eef90111b7981c2f
R10: 0000000000000010 R11: 0000000000000246 R12: 0000557343bdb35c
R13: 00007ffdc4021330 R14: 0000000000000000 R15: 0000557343bdb35c
 </TASK>
task:dhcpcd          state:S stack:25904 pid:2606  tgid:2606  ppid:2584   flags:0x00000002
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
RIP: 0033:0x7f3846d25ad5
RSP: 002b:00007ffe80205fc0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00005649eb81bee0 RCX: 00007f3846d25ad5
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00005649eb826d50
RBP: 00007ffe80206310 R08: 0000000000000008 R09: 0000000000000000
R10: 00007ffe80206310 R11: 0000000000000246 R12: 0000000000000000
R13: 00005649b3212610 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:sshd            state:S stack:25408 pid:2645  tgid:2645  ppid:2602   flags:0x00000002
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
RIP: 0033:0x7f56a9744ad5
RSP: 002b:00007ffe2e073a40 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00000000000668a0 RCX: 00007f56a9744ad5
RDX: 00007ffe2e073a60 RSI: 0000000000000004 RDI: 0000555d27a357e0
RBP: 0000555d27a343b0 R08: 0000000000000008 R09: 0000000000000000
R10: 00007ffe2e073b48 R11: 0000000000000246 R12: 0000555d0007daa4
R13: 0000000000000001 R14: 0000555d0007e3e8 R15: 00007ffe2e073ac8
 </TASK>
task:syz-executor423 state:S stack:25408 pid:2647  tgid:2647  ppid:2645   flags:0x00000002
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
RIP: 0033:0x7f4272677903
RSP: 002b:00007ffe75d755e8 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: ffffffffffffffb0 RCX: 00007f4272677903
RDX: 00007ffe75d75600 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000550038343632
R10: 00007ffe75d75600 R11: 0000000000000202 R12: 00007ffe75d75660
R13: 00007ffe75d75740 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
task:syz-executor423 state:S stack:27216 pid:2649  tgid:2649  ppid:2647   flags:0x00000002
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
RIP: 0033:0x7f4272677903
RSP: 002b:00007ffe75d753f8 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000000a89 RCX: 00007f4272677903
RDX: 00007ffe75d75410 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffe75d75454 R08: 00000000000028aa R09: 00007f4272601080
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
R13: 431bde82d7b634db R14: 00000000000357fd R15: 00007ffe75d754b0
 </TASK>
task:syz-executor423 state:S stack:27344 pid:2651  tgid:2651  ppid:2647   flags:0x00000002
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
RIP: 0033:0x7f4272677903
RSP: 002b:00007ffe75d753f8 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000000a86 RCX: 00007f4272677903
RDX: 00007ffe75d75410 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffe75d75454 R08: 00000000000028aa R09: 00007f4272601080
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
R13: 431bde82d7b634db R14: 00000000000357ea R15: 00007ffe75d754b0
 </TASK>
task:syz-executor423 state:S stack:27344 pid:2652  tgid:2652  ppid:2647   flags:0x00000002
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
RIP: 0033:0x7f4272677903
RSP: 002b:00007ffe75d753f8 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000000a87 RCX: 00007f4272677903
RDX: 00007ffe75d75410 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffe75d75454 R08: 00000000000028aa R09: 00007f4272601080
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
R13: 431bde82d7b634db R14: 00000000000357de R15: 00007ffe75d754b0
 </TASK>
task:syz-executor423 state:S stack:26688 pid:2653  tgid:2653  ppid:2647   flags:0x00000002
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
RIP: 0033:0x7f4272677903
RSP: 002b:00007ffe75d753f8 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000000a88 RCX: 00007f4272677903
RDX: 00007ffe75d75410 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffe75d75454 R08: 00000000000028aa R09: 00007f4272601080
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
R13: 431bde82d7b634db R14: 00000000000357f0 R15: 00007ffe75d754b0
 </TASK>
task:syz-executor423 state:S stack:27360 pid:2654  tgid:2654  ppid:2647   flags:0x00000002
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
RIP: 0033:0x7f4272677903
RSP: 002b:00007ffe75d753f8 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000000a85 RCX: 00007f4272677903
RDX: 00007ffe75d75410 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffe75d75454 R08: 00000000000028aa R09: 00007f4272601080
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
R13: 431bde82d7b634db R14: 00000000000357e6 R15: 00007ffe75d754b0
 </TASK>
task:udevd           state:S stack:27280 pid:2659  tgid:2659  ppid:2546   flags:0x00000002
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
RIP: 0033:0x7f869caa3457
RSP: 002b:00007ffe3ffc7708 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f869caa3457
RDX: 0000000000000004 RSI: 00007ffe3ffc7748 RDI: 0000000000000004
RBP: 0000562d38e34d30 R08: 0000000000000007 R09: 59ffd5dd027e9719
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000562d38e0b310
R13: 00007ffe3ffc7748 R14: 00000000ffffffff R15: 0000562d38dfe2c0
 </TASK>
task:udevd           state:S stack:27232 pid:2664  tgid:2664  ppid:2546   flags:0x00000002
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
RIP: 0033:0x7f869caa3457
RSP: 002b:00007ffe3ffc7708 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f869caa3457
RDX: 0000000000000004 RSI: 00007ffe3ffc7748 RDI: 0000000000000004
RBP: 0000562d38e2a810 R08: 0000000000000007 R09: 59ffd5dd027e9719
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000562d38e0aaf0
R13: 00007ffe3ffc7748 R14: 00000000ffffffff R15: 0000562d38dfe2c0
 </TASK>
task:udevd           state:S stack:26240 pid:2665  tgid:2665  ppid:2546   flags:0x00000002
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
RIP: 0033:0x7f869caa3457
RSP: 002b:00007ffe3ffc7708 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f869caa3457
RDX: 0000000000000004 RSI: 00007ffe3ffc7748 RDI: 0000000000000004
RBP: 0000562d38e34d30 R08: 0000000000000007 R09: 59ffd5dd027e9719
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000562d38ee5e50
R13: 00007ffe3ffc7748 R14: 00000000ffffffff R15: 0000562d38dfe2c0
 </TASK>
task:udevd           state:S stack:25744 pid:2667  tgid:2667  ppid:2546   flags:0x00000002
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
RIP: 0033:0x7f869caa3457
RSP: 002b:00007ffe3ffc7708 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f869caa3457
RDX: 0000000000000004 RSI: 00007ffe3ffc7748 RDI: 0000000000000004
RBP: 0000562d38e2a810 R08: 0000000000000007 R09: 59ffd5dd027e9719
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000562d38e37c40
R13: 00007ffe3ffc7748 R14: 00000000ffffffff R15: 0000562d38dfe2c0
 </TASK>
task:kworker/0:3     state:S stack:22496 pid:2668  tgid:2668  ppid:2      flags:0x00004000
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
 input_register_device+0x98a/0x1110 drivers/input/input.c:2463
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
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3675
 hid_add_device+0x37f/0xa70 drivers/hid/hid-core.c:2882
 usbhid_probe+0xd3b/0x1410 drivers/hid/usbhid/hid-core.c:1431
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3675
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3675
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
task:kworker/0:4     state:I stack:29680 pid:2669  tgid:2669  ppid:2      flags:0x00004000
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
task:kworker/0:5     state:I stack:29504 pid:2670  tgid:2670  ppid:2      flags:0x00004000
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
task:udevd           state:S stack:27472 pid:2671  tgid:2671  ppid:2546   flags:0x00000002
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
RIP: 0033:0x7f869caa3457
RSP: 002b:00007ffe3ffc7708 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f869caa3457
RDX: 0000000000000004 RSI: 00007ffe3ffc7748 RDI: 0000000000000004
RBP: 0000562d38e37c40 R08: 0000000000000007 R09: 59ffd5dd027e9719
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000562d38e32d80
R13: 00007ffe3ffc7748 R14: 00000000ffffffff R15: 0000562d38dfe2c0
 </TASK>
task:kworker/1:3     state:D stack:27680 pid:2673  tgid:2673  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 ___down_common+0x2d7/0x460 kernel/locking/semaphore.c:225
 __down_common kernel/locking/semaphore.c:246 [inline]
 __down+0x20/0x30 kernel/locking/semaphore.c:254
 down+0x74/0xa0 kernel/locking/semaphore.c:63
 hid_device_remove+0x29/0x260 drivers/hid/hid-core.c:2749
 device_remove+0xc8/0x170 drivers/base/dd.c:567
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
 device_del+0x396/0x9f0 drivers/base/core.c:3864
 hid_remove_device drivers/hid/hid-core.c:2939 [inline]
 hid_destroy_device+0xe5/0x150 drivers/hid/hid-core.c:2959
 usbhid_disconnect+0xa0/0xe0 drivers/hid/usbhid/hid-core.c:1458
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
 device_del+0x396/0x9f0 drivers/base/core.c:3864
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

