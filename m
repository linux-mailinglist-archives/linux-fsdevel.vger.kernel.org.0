Return-Path: <linux-fsdevel+bounces-32667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E8C9ACB54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 15:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946C828446A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 13:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E924A1B4F24;
	Wed, 23 Oct 2024 13:36:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F1E1ADFF9
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690591; cv=none; b=MXh/lKKv4w97WvmkV/FQO6PYiqBCeBwevGyNwV2v+LiQeBWN5o5zKsJHTfm1TIamGsPSbirVHH/LrzNQ0sGzCp1JxHJzS60Qq8g4eikZkI3NEAgogEwmXs9FYW75Y9r7t3b3cQtdxxwbqSLC5K5DxlwNngGCDd3TvYTizkW3/VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690591; c=relaxed/simple;
	bh=K7Tv8N6eepUWRL7UNh+cBHAoPSJH0W8ucN+75YwwUlE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UxgmOpmcwjrCK4YQu8Psg7vK+6ju6RnNci08zkJydHyK4XowMDoaxWayixWAIa3LweOJnKR8lPVnFm1aTXDvFX35m5c3LYrIssp4pieQEThX5kM6EYCGjAtxHbKcDS/iST34vUBnllirSBchBG/R5/g5L1YazOw8d5SJJpTGMz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3bcae85a5so6810355ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 06:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729690587; x=1730295387;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sj6ASEPrv/r0HEc/zmMSGShTFkj2d1cYTcq5SxO15x8=;
        b=viqtX4f0jmWwoUwLx5UIztXZtrSDBQit/qg9O/9xwxagaUlOlS9rZlEC2iHfdubOjz
         I/7ZMbWx/I6rmMb6QwQdm+rEJ5NypEaguvShM3Xne46srBNo+HWjV982RFMyIdLT/cxU
         yxNh63JB3m5f85jVUk36+Uup/EJJy4ORkM3wGDozxfM+hvfMbBSFC1pnrRxAIWaLNd6m
         c+Yaju+wKF0nZedUqx/mwmnh5VCYmQeiNv+Je6svYn5fewXQStiTlJ44Qa4ypSvwT7w2
         FTXkdPz93mUl6NL0V92uW5Pi6BILc+PBU1+Yd0mMGGA6hqGoS0cs7nxagyYERDbbJswe
         THOw==
X-Forwarded-Encrypted: i=1; AJvYcCXWmfAlt85ysPkhJ11bD2ke1yQTIrL162NUEuUJXn5Z3HX4l9yrHQidmuQ7VDSPnOsNz5KpoM7/IhTNlQ0k@vger.kernel.org
X-Gm-Message-State: AOJu0YwG4+ZFKjGw2EViCygRN1WpoWaG/YaR+iSYM64rOLHELEQZgw5k
	As1krB/I0zvZefJACMN98ec668wRdfkeo51qs9BLknk4wTJngulKhZOoJ4qTLpZNwJipw85Esi/
	uEbE7PgIUwjRcI9UcE9u4vQT+l9v00/aIV8dQT/0EkEjzzLfclvp9Nok=
X-Google-Smtp-Source: AGHT+IGQCDZAxNGMn7cywQ/DUhL4eeQAL1Z9jezy1TmIVOqMxnK5HjvikkBWNsmtfaA2N+cl0BARvPXPeTwY2n2nrqeougopUyMy
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda9:0:b0:39d:3c87:1435 with SMTP id
 e9e14a558f8ab-3a4cc00cdfamr42925745ab.1.1729690587221; Wed, 23 Oct 2024
 06:36:27 -0700 (PDT)
Date: Wed, 23 Oct 2024 06:36:27 -0700
In-Reply-To: <66fbbb26.050a0220.aab67.0043.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6718fbdb.050a0220.1e4b4d.008c.GAE@google.com>
Subject: Re: [syzbot] [usb?] [ext4?] [input?] INFO: rcu detected stall in
 sys_pselect6 (2)
From: syzbot <syzbot+310c88228172bcf54bef@syzkaller.appspotmail.com>
To: amir73il@gmail.com, jack@suse.com, jack@suse.cz, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c6d9e43954bf Merge 6.12-rc4 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=11efd640580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a2bb21f91d75c65
dashboard link: https://syzkaller.appspot.com/bug?extid=310c88228172bcf54bef
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cec287980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118a4c30580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3bf4a453ec2f/disk-c6d9e439.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e4a2db2a5d95/vmlinux-c6d9e439.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8eb8e481b288/bzImage-c6d9e439.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+310c88228172bcf54bef@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 1-...D
 } 2685 jiffies s: 1981 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):

Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 2533 Comm: acpid Not tainted 6.12.0-rc4-syzkaller-00052-gc6d9e43954bf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:io_serial_out+0x8f/0xb0 drivers/tty/serial/8250/8250_port.c:413
Code: 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 1c 66 03 5d 40 44 89 e8 89 da ee <5b> 5d 41 5c 41 5d c3 cc cc cc cc e8 31 f0 0d ff eb a0 e8 ba f0 0d
RSP: 0018:ffffc900001b7f58 EFLAGS: 00000002
RAX: 0000000000000020 RBX: 00000000000003f8 RCX: 0000000000000000
RDX: 00000000000003f8 RSI: ffffffff82a08975 RDI: ffffffff93637660
RBP: ffffffff93637620 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000020 R14: ffffffff82a08910 R15: 0000000000000000
FS:  00007f7b6d838740(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005584b4747cb8 CR3: 00000001165a0000 CR4: 00000000003506f0
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
 sched_show_task kernel/sched/core.c:7604 [inline]
 sched_show_task+0x3f0/0x5f0 kernel/sched/core.c:7579
 show_state_filter+0xee/0x320 kernel/sched/core.c:7649
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
 dummy_timer+0x17f0/0x3930 drivers/usb/gadget/udc/dummy_hcd.c:1993
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x20a/0xae0 kernel/time/hrtimer.c:1755
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1772
 handle_softirqs+0x206/0x8d0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xac/0x110 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 f6 82 42 fa 48 89 df e8 0e 00 43 fa f7 c5 00 02 00 00 75 23 9c 58 f6 c4 02 75 37 <bf> 01 00 00 00 e8 b5 2f 37 fa 65 8b 05 56 ed 12 79 85 c0 74 16 5b
RSP: 0018:ffffc900014ff638 EFLAGS: 00000246
RAX: 0000000000000006 RBX: ffff88811ad39050 RCX: 1ffffffff14ac291
RDX: 0000000000000000 RSI: ffffffff8727f220 RDI: ffffffff8746ebc0
RBP: 0000000000000282 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8a564d8f R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc900014ff7f0 R14: ffffc900014ff9e0 R15: ffffc900014ff820
 free_poll_entry fs/select.c:132 [inline]
 poll_freewait+0xd5/0x250 fs/select.c:141
 do_select+0xeb6/0x17b0 fs/select.c:609
 core_sys_select+0x459/0xb80 fs/select.c:678
 do_pselect.constprop.0+0x1a0/0x1f0 fs/select.c:760
 __do_sys_pselect6 fs/select.c:803 [inline]
 __se_sys_pselect6 fs/select.c:794 [inline]
 __x64_sys_pselect6+0x183/0x240 fs/select.c:794
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7b6d907591
Code: 89 44 24 20 4c 8d 64 24 20 48 89 54 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2d 45 31 c9 4d 89 e0 4c 89 f2 b8 0e 01 00 00 0f 05 <48> 89 c3 48 3d 00 f0 ff ff 76 69 48 8b 05 65 58 0d 00 f7 db 64 89
RSP: 002b:00007ffd9bb719a0 EFLAGS: 00000246 ORIG_RAX: 000000000000010e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7b6d907591
RDX: 0000000000000000 RSI: 00007ffd9bb71a98 RDI: 000000000000000c
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000563905a4d178 R14: 0000000000000000 R15: 000000000000000b
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 4.698 msecs
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-kvub3 state:I stack:30048 pid:1028  tgid:1028  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-kmems state:I stack:30144 pid:1032  tgid:1032  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-elous state:I stack:30144 pid:1064  tgid:1064  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:1H    state:I stack:27536 pid:1250  tgid:1250  ppid:2      flags:0x00004000
Workqueue:  0x0 (kblockd)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-mld   state:I stack:30048 pid:1251  tgid:1251  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-ipv6_ state:I stack:30048 pid:1252  tgid:1252  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/u8:7    state:I stack:27200 pid:1406  tgid:1406  ppid:2      flags:0x00004000
Workqueue:  0x0 (ipv6_addrconf)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:jbd2/sda1-8     state:D stack:25760 pid:2510  tgid:2510  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 io_schedule+0xbf/0x130 kernel/sched/core.c:7574
 bit_wait_io+0x15/0xe0 kernel/sched/wait_bit.c:209
 __wait_on_bit+0x62/0x180 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0xda/0x110 kernel/sched/wait_bit.c:64
 wait_on_bit_io include/linux/wait_bit.h:101 [inline]
 __wait_on_buffer+0x64/0x70 fs/buffer.c:123
 wait_on_buffer include/linux/buffer_head.h:414 [inline]
 jbd2_journal_commit_transaction+0x3864/0x65b0 fs/jbd2/commit.c:814
 kjournald2+0x1f8/0x760 fs/jbd2/journal.c:201
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-ext4- state:I stack:30048 pid:2511  tgid:2511  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 rescuer_thread+0x946/0xe20 kernel/workqueue.c:3541
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:syslogd         state:S stack:25184 pid:2530  tgid:2530  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
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
RIP: 0033:0x7f41b3afeb6a
RSP: 002b:00007ffc4da2f278 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f41b3afeb6a
RDX: 00000000000000ff RSI: 00005581fd751300 RDI: 0000000000000000
RBP: 00005581fd7512c0 R08: 0000000000000001 R09: 0000000000000000
R10: 00007f41b3c9d3a3 R11: 0000000000000246 R12: 00005581fd751381
R13: 00005581fd751300 R14: 0000000000000000 R15: 00007f41b3ce1a80
 </TASK>
task:acpid           state:R  running task     stack:25344 pid:2533  tgid:2533  ppid:1      flags:0x0000400a
Call Trace:
 <IRQ>
 sched_show_task kernel/sched/core.c:7604 [inline]
 sched_show_task+0x3f0/0x5f0 kernel/sched/core.c:7579
 show_state_filter+0xee/0x320 kernel/sched/core.c:7649
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
 dummy_timer+0x17f0/0x3930 drivers/usb/gadget/udc/dummy_hcd.c:1993
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x20a/0xae0 kernel/time/hrtimer.c:1755
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1772
 handle_softirqs+0x206/0x8d0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xac/0x110 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 f6 82 42 fa 48 89 df e8 0e 00 43 fa f7 c5 00 02 00 00 75 23 9c 58 f6 c4 02 75 37 <bf> 01 00 00 00 e8 b5 2f 37 fa 65 8b 05 56 ed 12 79 85 c0 74 16 5b
RSP: 0018:ffffc900014ff638 EFLAGS: 00000246
RAX: 0000000000000006 RBX: ffff88811ad39050 RCX: 1ffffffff14ac291
RDX: 0000000000000000 RSI: ffffffff8727f220 RDI: ffffffff8746ebc0
RBP: 0000000000000282 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8a564d8f R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc900014ff7f0 R14: ffffc900014ff9e0 R15: ffffc900014ff820
 free_poll_entry fs/select.c:132 [inline]
 poll_freewait+0xd5/0x250 fs/select.c:141
 do_select+0xeb6/0x17b0 fs/select.c:609
 core_sys_select+0x459/0xb80 fs/select.c:678
 do_pselect.constprop.0+0x1a0/0x1f0 fs/select.c:760
 __do_sys_pselect6 fs/select.c:803 [inline]
 __se_sys_pselect6 fs/select.c:794 [inline]
 __x64_sys_pselect6+0x183/0x240 fs/select.c:794
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7b6d907591
Code: 89 44 24 20 4c 8d 64 24 20 48 89 54 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2d 45 31 c9 4d 89 e0 4c 89 f2 b8 0e 01 00 00 0f 05 <48> 89 c3 48 3d 00 f0 ff ff 76 69 48 8b 05 65 58 0d 00 f7 db 64 89
RSP: 002b:00007ffd9bb719a0 EFLAGS: 00000246 ORIG_RAX: 000000000000010e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7b6d907591
RDX: 0000000000000000 RSI: 00007ffd9bb71a98 RDI: 000000000000000c
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000563905a4d178 R14: 0000000000000000 R15: 000000000000000b
 </TASK>
task:klogd           state:S stack:25424 pid:2537  tgid:2537  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 syslog_print+0x214/0x5d0 kernel/printk/printk.c:1614
 do_syslog+0x3be/0x6a0 kernel/printk/printk.c:1766
 __do_sys_syslog kernel/printk/printk.c:1858 [inline]
 __se_sys_syslog kernel/printk/printk.c:1856 [inline]
 __x64_sys_syslog+0x74/0xb0 kernel/printk/printk.c:1856
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0e12689fa7
RSP: 002b:00007ffe9dfbacf8 EFLAGS: 00000206 ORIG_RAX: 0000000000000067
RAX: ffffffffffffffda RBX: 00007f0e128284a0 RCX: 00007f0e12689fa7
RDX: 00000000000003ff RSI: 00007f0e128284a0 RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000000000007 R09: fe98f61bd6ba14f5
R10: 0000000000004000 R11: 0000000000000206 R12: 00007f0e128284a0
R13: 00007f0e12818212 R14: 00007f0e1282875a R15: 00007f0e1282875a
 </TASK>
task:udevd           state:S stack:25744 pid:2548  tgid:2548  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 ep_poll fs/eventpoll.c:2062 [inline]
 do_epoll_wait+0x139b/0x1a90 fs/eventpoll.c:2459
 __do_sys_epoll_wait fs/eventpoll.c:2471 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2466 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3e5ad0c457
RSP: 002b:00007fff642e03f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007fff642e04f8 RCX: 00007f3e5ad0c457
RDX: 0000000000000008 RSI: 00007fff642e04f8 RDI: 000000000000000b
RBP: 00005584b46f3f10 R08: 0000000000000007 R09: 3efa47ad885c3bd2
R10: 00000000ffffffff R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:dbus-daemon     state:S stack:28048 pid:2570  tgid:2570  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_hrtimeout_range_clock+0x369/0x3b0 kernel/time/hrtimer.c:2272
 ep_poll fs/eventpoll.c:2062 [inline]
 do_epoll_wait+0x139b/0x1a90 fs/eventpoll.c:2459
 __do_sys_epoll_wait fs/eventpoll.c:2471 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2466 [inline]
 __x64_sys_epoll_wait+0x194/0x290 fs/eventpoll.c:2466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe7bc23e457
RSP: 002b:00007ffddd1bb198 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 00007ffddd1bb1a8 RCX: 00007fe7bc23e457
RDX: 0000000000000040 RSI: 00007ffddd1bb1a8 RDI: 0000000000000003
RBP: 00007ffddd1bb538 R08: 0000000000000748 R09: 00007fe7bc3b3080
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007ffddd1bb538 R15: 00007ffddd1bb848
 </TASK>
task:dhcpcd          state:S stack:26000 pid:2585  tgid:2585  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
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
RIP: 0033:0x7fc626e88ad5
RSP: 002b:00007fffdc295bc0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 000056463fdc4ee0 RCX: 00007fc626e88ad5
RDX: 00007fffdc295be0 RSI: 0000000000000004 RDI: 000056463fdcee70
RBP: 00007fffdc295f10 R08: 0000000000000008 R09: 00007fc626f71080
R10: 00007fffdc295f10 R11: 0000000000000246 R12: 00007fffdc295c08
R13: 0000564602b74610 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:dhcpcd          state:S stack:23728 pid:2586  tgid:2586  ppid:2585   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
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
RIP: 0033:0x7fc626e88ad5
RSP: 002b:00007fffdc295bc0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 000056463fdc4ee0 RCX: 00007fc626e88ad5
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 000056463fdc4ec0
RBP: 00007fffdc295f10 R08: 0000000000000008 R09: fa430fcd5a972710
R10: 00007fffdc295f10 R11: 0000000000000246 R12: 0000000000000000
R13: 0000564602b74610 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:dhcpcd          state:S stack:27984 pid:2587  tgid:2587  ppid:2585   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
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
RIP: 0033:0x7fc626e88ad5
RSP: 002b:00007fffdc295bc0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 000056463fdc4ee0 RCX: 00007fc626e88ad5
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 000056463fdcdfe0
RBP: 00007fffdc295f10 R08: 0000000000000008 R09: 0000564602b743d0
R10: 00007fffdc295f10 R11: 0000000000000246 R12: 0000000000000000
R13: 0000564602b74610 R14: 0000000000000003 R15: 0000000000000000
 </TASK>
task:dhcpcd          state:S stack:26704 pid:2588  tgid:2588  ppid:2585   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
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
RIP: 0033:0x7fc626e88ad5
RSP: 002b:00007fffdc295bc0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 000056463fdc4ee0 RCX: 00007fc626e88ad5
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 000056463fdcdfe0
RBP: 00007fffdc295f10 R08: 0000000000000008 R09: 0000564602b743d0
R10: 00007fffdc295f10 R11: 0000000000000246 R12: 0000000000000000
R13: 0000564602b74610 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:sshd            state:S stack:27360 pid:2604  tgid:2604  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
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
RIP: 0033:0x7f2651847ad5
RSP: 002b:00007ffc9d7ea7e0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00005627b4e65520 RCX: 00007f2651847ad5
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00005627b4e65a00
RBP: 0000000000000064 R08: 0000000000000008 R09: 0000000000000000
R10: 00007ffc9d7ea998 R11: 0000000000000246 R12: 00005627b4e65a00
R13: 00007ffc9d7ea998 R14: 0000000000000002 R15: 00005627b4e659ec
 </TASK>
task:getty           state:S stack:25072 pid:2606  tgid:2606  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
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
RIP: 0033:0x7f86d62b3b6a
RSP: 002b:00007ffeb928d258 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000556d1a7332c0 RCX: 00007f86d62b3b6a
RDX: 0000000000000001 RSI: 00007ffeb928d270 RDI: 0000000000000000
RBP: 0000556d1a733320 R08: 0000000000000000 R09: c07ffa83b51da5fe
R10: 0000000000000010 R11: 0000000000000246 R12: 0000556d1a73335c
R13: 00007ffeb928d270 R14: 0000000000000000 R15: 0000556d1a73335c
 </TASK>
task:dhcpcd          state:S stack:27424 pid:2608  tgid:2608  ppid:2586   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
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
RIP: 0033:0x7fc626e88ad5
RSP: 002b:00007fffdc295bc0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 000056463fdc4ee0 RCX: 00007fc626e88ad5
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 000056463fdcfd50
RBP: 00007fffdc295f10 R08: 0000000000000008 R09: 0000000000000000
R10: 00007fffdc295f10 R11: 0000000000000246 R12: 0000000000000000
R13: 0000564602b74610 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
task:sshd            state:S stack:24064 pid:2647  tgid:2647  ppid:2604   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
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
RIP: 0033:0x7f2af0c0dad5
RSP: 002b:00007fff08545950 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00000000000668a0 RCX: 00007f2af0c0dad5
RDX: 00007fff08545970 RSI: 0000000000000004 RDI: 000055ea8fda2b00
RBP: 000055ea8fda15c0 R08: 0000000000000008 R09: 0000000000000000
R10: 00007fff08545a58 R11: 0000000000000246 R12: 000055ea6c311aa4
R13: 0000000000000001 R14: 000055ea6c3123e8 R15: 00007fff085459d8
 </TASK>
task:syz-executor126 state:S stack:25424 pid:2649  tgid:2649  ppid:2647   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 do_nanosleep+0x216/0x510 kernel/time/hrtimer.c:2032
 hrtimer_nanosleep+0x146/0x370 kernel/time/hrtimer.c:2080
 common_nsleep+0xa1/0xd0 kernel/time/posix-timers.c:1365
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1411 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1388 [inline]
 __x64_sys_clock_nanosleep+0x344/0x4a0 kernel/time/posix-timers.c:1388
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff8a12dff03
RSP: 002b:00007ffcf8b84088 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: ffffffffffffffb0 RCX: 00007ff8a12dff03
RDX: 00007ffcf8b840a0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffcf8b840a0 R11: 0000000000000202 R12: 0000000000000001
R13: 00007ffcf8b842b8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
task:syz-executor126 state:S stack:26192 pid:2650  tgid:2650  ppid:2649   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 do_nanosleep+0x216/0x510 kernel/time/hrtimer.c:2032
 hrtimer_nanosleep+0x146/0x370 kernel/time/hrtimer.c:2080
 common_nsleep+0xa1/0xd0 kernel/time/posix-timers.c:1365
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1411 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1388 [inline]
 __x64_sys_clock_nanosleep+0x344/0x4a0 kernel/time/posix-timers.c:1388
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff8a12dff03
RSP: 002b:00007ffcf8b83e98 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000000aea RCX: 00007ff8a12dff03
RDX: 00007ffcf8b83eb0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffcf8b83ef4 R08: 0000000000008596 R09: 00007ff8a126a080
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000008
R13: 431bde82d7b634db R14: 000000000004a83d R15: 00007ffcf8b83f50
 </TASK>
task:syz-executor126 state:S stack:27152 pid:2652  tgid:2652  ppid:2649   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 do_nanosleep+0x216/0x510 kernel/time/hrtimer.c:2032
 hrtimer_nanosleep+0x146/0x370 kernel/time/hrtimer.c:2080
 common_nsleep+0xa1/0xd0 kernel/time/posix-timers.c:1365
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1411 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1388 [inline]
 __x64_sys_clock_nanosleep+0x344/0x4a0 kernel/time/posix-timers.c:1388
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff8a12dff03
RSP: 002b:00007ffcf8b83e98 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000000ae7 RCX: 00007ff8a12dff03
RDX: 00007ffcf8b83eb0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffcf8b83ef4 R08: 0000000000008596 R09: 00007ff8a126a080
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000008
R13: 431bde82d7b634db R14: 000000000004a825 R15: 00007ffcf8b83f50
 </TASK>
task:syz-executor126 state:S stack:26688 pid:2653  tgid:2653  ppid:2649   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 do_nanosleep+0x216/0x510 kernel/time/hrtimer.c:2032
 hrtimer_nanosleep+0x146/0x370 kernel/time/hrtimer.c:2080
 common_nsleep+0xa1/0xd0 kernel/time/posix-timers.c:1365
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1411 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1388 [inline]
 __x64_sys_clock_nanosleep+0x344/0x4a0 kernel/time/posix-timers.c:1388
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff8a12dff03
RSP: 002b:00007ffcf8b83e98 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000000ae4 RCX: 00007ff8a12dff03
RDX: 00007ffcf8b83eb0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffcf8b83ef4 R08: 0000000000008598 R09: 00007ff8a126a080
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000008
R13: 431bde82d7b634db R14: 000000000004a7f2 R15: 00007ffcf8b83f50
 </TASK>
task:syz-executor126 state:S stack:26592 pid:2654  tgid:2654  ppid:2649   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 do_nanosleep+0x216/0x510 kernel/time/hrtimer.c:2032
 hrtimer_nanosleep+0x146/0x370 kernel/time/hrtimer.c:2080
 common_nsleep+0xa1/0xd0 kernel/time/posix-timers.c:1365
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1411 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1388 [inline]
 __x64_sys_clock_nanosleep+0x344/0x4a0 kernel/time/posix-timers.c:1388
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff8a12dff03
RSP: 002b:00007ffcf8b83e98 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000000aee RCX: 00007ff8a12dff03
RDX: 00007ffcf8b83eb0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffcf8b83ef4 R08: 0000000000008598 R09: 00007ff8a126a080
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000009
R13: 431bde82d7b634db R14: 000000000004a85e R15: 00007ffcf8b83f50
 </TASK>
task:syz-executor126 state:S stack:26592 pid:2655  tgid:2655  ppid:2649   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 do_nanosleep+0x216/0x510 kernel/time/hrtimer.c:2032
 hrtimer_nanosleep+0x146/0x370 kernel/time/hrtimer.c:2080
 common_nsleep+0xa1/0xd0 kernel/time/posix-timers.c:1365
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1411 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1388 [inline]
 __x64_sys_clock_nanosleep+0x344/0x4a0 kernel/time/posix-timers.c:1388
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff8a12dff03
RSP: 002b:00007ffcf8b83e98 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000000ae9 RCX: 00007ff8a12dff03
RDX: 00007ffcf8b83eb0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffcf8b83ef4 R08: 0000000000008596 R09: 00007ff8a126a080
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000008
R13: 431bde82d7b634db R14: 000000000004a83d R15: 00007ffcf8b83f50
 </TASK>
task:kworker/0:2     state:I stack:22352 pid:2666  tgid:2666  ppid:2      flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:3     state:I stack:21728 pid:2667  tgid:2667  ppid:2      flags:0x00004000
Workqueue:  0x0 (events_power_efficient)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:4     state:I stack:29424 pid:2668  tgid:2668  ppid:2      flags:0x00004000
Workqueue:  0x0 (events)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:5     state:S stack:21520 pid:2672  tgid:2672  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
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
task:kworker/1:3     state:I stack:30928 pid:2688  tgid:2688  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 worker_thread+0x2de/0xf00 kernel/workqueue.c:3406
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:syz-executor126 state:D stack:28992 pid:2806  tgid:2788  ppid:2653   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:329
 synchronize_rcu_expedited+0x290/0x450 kernel/rcu/tree_exp.h:976
 module_remove_driver+0x2e/0x260 drivers/base/module.c:106
 bus_remove_driver+0x143/0x2c0 drivers/base/bus.c:745
 driver_unregister+0x76/0xb0 drivers/base/driver.c:274
 usb_gadget_register_driver_owner+0x20f/0x330 drivers/usb/gadget/udc/core.c:1722
 raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:595 [inline]
 raw_ioctl+0x1731/0x2b90 drivers/usb/gadget/legacy/raw_gadget.c:1306
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18f/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff8a12b2d5b
RSP: 002b:00007ff8a1246130 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007ff8a12b2d5b
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000005
RBP: 00007ff8a12471f0 R08: 0000000000000010 R09: 00322e6364755f79
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007ff8a12461c0 R14: 00007ffcf8b83d10 R15: 00007ff8a133a500
 </TASK>
task:syz-executor126 state:S stack:27856 pid:2791  tgid:2791  ppid:2652   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 futex_wait_queue+0xfc/0x1f0 kernel/futex/waitwake.c:370
 __futex_wait+0x291/0x3c0 kernel/futex/waitwake.c:669
 futex_wait+0xe9/0x380 kernel/futex/waitwake.c:697
 do_futex+0x22b/0x350 kernel/futex/syscalls.c:102
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex kernel/futex/syscalls.c:160 [inline]
 __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff8a12b2ec9
RSP: 002b:00007ffcf8b83ed8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 000000000000015e RCX: 00007ff8a12b2ec9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007ff8a133a3ec
RBP: 000000000004ad84 R08: 00007ff8a126a080 R09: 00007ffcf8b83f00
R10: 00007ffcf8b83f00 R11: 0000000000000246 R12: 00007ff8a133a3ec
R13: 000000000004aee2 R14: 00007ff8a127aff0 R15: 00007ffcf8b83f20
 </TASK>
task:syz-executor126 state:S stack:28224 pid:2792  tgid:2791  ppid:2652   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
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
RIP: 0033:0x7ff8a12b2d5b
RSP: 002b:00007ff8a12681b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff8a133a3e8 RCX: 00007ff8a12b2d5b
RDX: 00007ff8a1268220 RSI: 0000000040085507 RDI: 0000000000000003
RBP: 00007ff8a133a3e0 R08: 00000000ffffff81 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff8a1307100
R13: 0000000000000016 R14: 00007ffcf8b83d10 R15: 00007ffcf8b83df8
 </TASK>
task:syz-executor126 state:D stack:28992 pid:2805  tgid:2793  ppid:2655   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 synchronize_rcu_expedited+0x392/0x450 kernel/rcu/tree_exp.h:991
 module_remove_driver+0x2e/0x260 drivers/base/module.c:106
 bus_remove_driver+0x143/0x2c0 drivers/base/bus.c:745
 driver_unregister+0x76/0xb0 drivers/base/driver.c:274
 usb_gadget_register_driver_owner+0x20f/0x330 drivers/usb/gadget/udc/core.c:1722
 raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:595 [inline]
 raw_ioctl+0x1731/0x2b90 drivers/usb/gadget/legacy/raw_gadget.c:1306
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18f/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff8a12b2d5b
RSP: 002b:00007ff8a1246130 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007ff8a12b2d5b
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000005
RBP: 00007ff8a12471f0 R08: 0000000000000010 R09: 00342e6364755f79
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007ff8a12461c0 R14: 00007ffcf8b83d10 R15: 00007ff8a133a500
 </TASK>
task:syz-executor126 state:D stack:28992 pid:2807  tgid:2794  ppid:2650   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 exp_funnel_lock+0x344/0x3b0 kernel/rcu/tree_exp.h:320
 synchronize_rcu_expedited+0x290/0x450 kernel/rcu/tree_exp.h:976
 module_remove_driver+0x2e/0x260 drivers/base/module.c:106
 bus_remove_driver+0x143/0x2c0 drivers/base/bus.c:745
 driver_unregister+0x76/0xb0 drivers/base/driver.c:274
 usb_gadget_register_driver_owner+0x20f/0x330 drivers/usb/gadget/udc/core.c:1722
 raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:595 [inline]
 raw_ioctl+0x1731/0x2b90 drivers/usb/gadget/legacy/raw_gadget.c:1306
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18f/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff8a12b2d5b
RSP: 002b:00007ff8a1246130 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007ff8a12b2d5b
RDX: 0000000000000000 RSI: 0000000000005501 RDI: 0000000000000005
RBP: 00007ff8a12471f0 R08: 0000000000000010 R09: 00302e6364755f79
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007ff8a12461c0 R14: 00007ffcf8b83d10 R15: 00007ff8a133a500
 </TASK>
task:syz-executor126 state:S stack:27856 pid:2798  tgid:2798  ppid:2654   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 futex_wait_queue+0xfc/0x1f0 kernel/futex/waitwake.c:370
 __futex_wait+0x291/0x3c0 kernel/futex/waitwake.c:669
 futex_wait+0xe9/0x380 kernel/futex/waitwake.c:697
 do_futex+0x22b/0x350 kernel/futex/syscalls.c:102
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex kernel/futex/syscalls.c:160 [inline]
 __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff8a12b2ec9
RSP: 002b:00007ffcf8b83ed8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 000000000000015e RCX: 00007ff8a12b2ec9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007ff8a133a3ec
RBP: 000000000004adb3 R08: 00007ff8a126a080 R09: 00007ffcf8b83f00
R10: 00007ffcf8b83f00 R11: 0000000000000246 R12: 00007ff8a133a3ec
R13: 000000000004af11 R14: 00007ff8a127aff0 R15: 00007ffcf8b83f20
 </TASK>
task:syz-executor126 state:S stack:28352 pid:2800  tgid:2798  ppid:2654   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
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
RIP: 0033:0x7ff8a12b2d5b
RSP: 002b:00007ff8a12681b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff8a133a3e8 RCX: 00007ff8a12b2d5b
RDX: 00007ff8a1268220 RSI: 0000000040085507 RDI: 0000000000000003
RBP: 00007ff8a133a3e0 R08: 00000000ffffff81 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff8a1307100
R13: 0000000000000016 R14: 00007ffcf8b83d10 R15: 00007ffcf8b83df8
 </TASK>

Showing all locks held in the system:
7 locks held by kworker/0:0/8:
 #0: ffff888105adf548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000008fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888109fa0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888109fa0190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88811aa81190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88811aa81190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff88811a9ef160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88811a9ef160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffff888118abda20 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #5: ffff888118abda20 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #6: ffffffff89bd7648 (input_mutex){+.+.}-{3:3}, at: input_register_device+0x98a/0x1110 drivers/input/input.c:2463
8 locks held by kworker/1:2/804:
2 locks held by kworker/0:1H/1250:
 #0: ffff8881026e7d48 ((wq_completion)kblockd){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90002a8fd80 ((work_completion)(&q->timeout_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
4 locks held by acpid/2533:
 #0: ffff888119d04230 (&dev->event_lock){..-.}-{2:2}, at: input_event drivers/input/input.c:397 [inline]
 #0: ffff888119d04230 (&dev->event_lock){..-.}-{2:2}, at: input_event+0x70/0xa0 drivers/input/input.c:390
 #1: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #1: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: input_pass_values+0x8b/0x8e0 drivers/input/input.c:118
 #2: ffffffff89387a58 (kbd_event_lock){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffffffff89387a58 (kbd_event_lock){..-.}-{2:2}, at: kbd_event+0x8a/0x17a0 drivers/tty/vt/keyboard.c:1535
 #3: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #3: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #3: ffffffff88ebb140 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
2 locks held by getty/2606:
 #0: ffff8881146a00a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
7 locks held by kworker/0:5/2672:
 #0: ffff888105adf548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000156fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888109f00190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888109f00190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88811aa80190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88811aa80190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff88811a9ed160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88811a9ed160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffff88811a429a20 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #5: ffff88811a429a20 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #6: ffffffff89bd7648 (input_mutex){+.+.}-{3:3}, at: input_register_device+0x98a/0x1110 drivers/input/input.c:2463
1 lock held by syz-executor126/2806:
 #0: ffffffff88ec6a38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:329
1 lock held by syz-executor126/2805:
 #0: ffffffff88ec6a38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x282/0x3b0 kernel/rcu/tree_exp.h:297

=============================================



---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

