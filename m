Return-Path: <linux-fsdevel+bounces-33277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D539B6B3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 18:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF981F22204
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 17:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019E21CBE89;
	Wed, 30 Oct 2024 17:45:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EB84369A
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310331; cv=none; b=jdgcbSVGt+5/pWy5lX8H5JUwBfaT5OP5/390s6sIiankuwph4pbixGfOOJxKgB8NiFEo9tzpVxBzHXgBpEHpQrbwSThioa4vq3u0pLih9I+v02Q5gpRJzit6R3n7lmNZHIhMeEyr0vH63MQ+kA9ZIap2iUnVTA5dtZjjcyCgbEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310331; c=relaxed/simple;
	bh=JwLRf7gXUO7qvVEU44N4S6/fcBhhOfM2qun4eiCTp+o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qdEbrGJLl5Q2VRlTJXRNCR2nFrUjCOooPx25Kkgs1Rwt2F/6DPJimz510/tDd7CESddZLn6CIAmJ40Z5Qwrql8i4h4xPdQF+my2QuvyctD6vIJr0qNX933I/MDRWavHXd+5kL+CGT7Wxev0pNwPDtDJGx6xHUh9TGAwNvX9oA3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b7d1e8a0so922245ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 10:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730310326; x=1730915126;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KSNdgr02ACwdKeKPLaA2MH3OaFQPUzSFCsPdKxuynYo=;
        b=JsD6OOS1OVuWpTSKB+hCW8HIrnkxsZfVNT0tax5EA/DGO64Zvz0aGsolw1eEyGHStI
         VN4wgNlm0QTa3H6De+08NiGNA+1/OWROV+AqiRXGK8bf2DPE+0ZRv0rnl3vze7PvM1bn
         IelUfpiD7ppybq7ciMtqQ4+t9ZPAw18ThYaBZbLYuv1YY05aNf4LjUmFTZH2tqpkfAkZ
         HMkC2VTyPfeshGhD+VxeNnZqhwaPXtcg4QDDyzMatvKbz59LMIm9nvLURWDw0bZ/NJ7j
         1uFw8pT/rHAXejWiiETIHrvt/g1Nzm6oT3LV35+pRgsfD8Db9d3Jenbxm1AAQWBOQkyv
         Z9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0eK+VZE2CWntb8d1Fe0Y9V4oX3hysdpJqQCSp87dAtx8rbFYUScxFeL9/tuHGeHLlcgEiKpHZNvXJdc5+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhr1swG6Vn+t6q8DLaf2ekrOm/o4AJO/WRDY9sXBPGmDSNohcO
	ByrkjU9IMWcujHCOQyhNigYJGt3bIqtNg3W+6CuqvsQsY+ahr8ArvmTTUKyUeA9xCCbxm0F7qyX
	JXDslA2cV7QmCuCYzG4ozZnu0UtdcNplHg0n+48OwuGYDp+k4gDBQ+Vc=
X-Google-Smtp-Source: AGHT+IEzFUmFZseDqaUh1/90jbIDjd8wbXESn18wwoIdzd4osJDFHGfwS70uS00EegZ5PcNCJReHMbnwGGTjbBdtuYBMPNGi4Iwr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcb:b0:3a0:a311:6773 with SMTP id
 e9e14a558f8ab-3a4ed34fbcfmr150608155ab.21.1730310325691; Wed, 30 Oct 2024
 10:45:25 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:45:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672270b5.050a0220.3c8d68.052b.GAE@google.com>
Subject: [syzbot] [fs?] [usb?] [input?] INFO: rcu detected stall in __virt_addr_valid
From: syzbot <syzbot+c715f8def980884717e1@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c6d9e43954bf Merge 6.12-rc4 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14b244a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5aceb1f10131390c
dashboard link: https://syzkaller.appspot.com/bug?extid=c715f8def980884717e1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fa1230580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fe53e83da4bf/disk-c6d9e439.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a9135a278859/vmlinux-c6d9e439.xz
kernel image: https://storage.googleapis.com/syzbot-assets/72fb7499fd06/bzImage-c6d9e439.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c715f8def980884717e1@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
 0-...D
 } 2664 jiffies s: 1781 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):

Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 12683 Comm: udevd Not tainted 6.12.0-rc4-syzkaller-00052-gc6d9e43954bf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:io_serial_out+0x8f/0xb0 drivers/tty/serial/8250/8250_port.c:413
Code: 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 1c 66 03 5d 40 44 89 e8 89 da ee <5b> 5d 41 5c 41 5d c3 cc cc cc cc e8 31 f0 0d ff eb a0 e8 ba f0 0d
RSP: 0018:ffffc90000006f58 EFLAGS: 00000002
RAX: 0000000000000034 RBX: 00000000000003f8 RCX: 0000000000000000
RDX: 00000000000003f8 RSI: ffffffff82a08975 RDI: ffffffff93637660
RBP: ffffffff93637620 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000034 R14: ffffffff82a08910 R15: 0000000000000000
FS:  00007f9720401c80(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f971fd9fcf8 CR3: 000000012f9b2000 CR4: 00000000003506f0
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
RIP: 0010:lock_acquire+0x6/0xb0 kernel/locking/lockdep.c:5793
Code: d0 0d 7b 00 e9 6e ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 57 <4d> 89 cf 41 56 45 89 c6 41 55 41 89 cd 41 54 41 89 d4 55 89 f5 53
RSP: 0018:ffffc900034bfd60 EFLAGS: 00000246
RAX: ffffffff8116aff4 RBX: 0000000113f9e2c0 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff88ebb080
RBP: 0000000000000440 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000022 R11: 0000000000000000 R12: ffff88823fff1240
R13: 0000000000000000 R14: ffffea000466fc80 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock_sched include/linux/rcupdate.h:941 [inline]
 pfn_valid include/linux/mmzone.h:2043 [inline]
 __virt_addr_valid+0x1aa/0x590 arch/x86/mm/physaddr.c:65
 kasan_addr_to_slab+0xd/0x80 mm/kasan/common.c:37
 __kasan_record_aux_stack+0xe/0xb0 mm/kasan/generic.c:526
 __call_rcu_common.constprop.0+0x99/0x7a0 kernel/rcu/tree.c:3086
 slab_free_hook mm/slub.c:2306 [inline]
 slab_free mm/slub.c:4579 [inline]
 kmem_cache_free+0x2fe/0x480 mm/slub.c:4681
 file_free fs/file_table.c:73 [inline]
 __fput+0x684/0xb60 fs/file_table.c:444
 __fput_sync+0x45/0x50 fs/file_table.c:516
 __do_sys_close fs/open.c:1565 [inline]
 __se_sys_close fs/open.c:1550 [inline]
 __x64_sys_close+0x86/0x100 fs/open.c:1550
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f972052d0a8
Code: 48 8b 05 83 9d 0d 00 64 c7 00 16 00 00 00 83 c8 ff 48 83 c4 20 5b c3 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 5b 48 8b 15 51 9d 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffcd772e0a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f972052d0a8
RDX: 0000000000001000 RSI: 00007ffcd772e548 RDI: 0000000000000008
RBP: 000055be1a52ebf5 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000008
R13: 000055be1a5bb990 R14: 00007ffcd772e548 R15: 000055bde171fa04
 </TASK>
 </TASK>
task:kworker/u8:4    state:R  running task     stack:32568 pid:13272 tgid:13272 ppid:49     flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:13296 tgid:13296 ppid:1083   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:13301 tgid:13301 ppid:1660   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13304 tgid:13304 ppid:1660   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13306 tgid:13306 ppid:37     flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13307 tgid:13307 ppid:1660   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2d9230fa90
RSP: 002b:00007ffe792ff9a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f2d92400860 RCX: 00007f2d9230fa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f2d92400860 R08: 0000000000000001 R09: 62f7fb99d1dd2acb
R10: 00007ffe792ff860 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f2d92404658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13312 tgid:13312 ppid:37     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fea87dfea90
RSP: 002b:00007ffee9764cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fea87eef860 RCX: 00007fea87dfea90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fea87eef860 R08: 0000000000000001 R09: 818c2885a8da89ae
R10: 00007ffee9764bb0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fea87ef3658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13316 tgid:13316 ppid:1083   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f396d07ba90
RSP: 002b:00007ffc8412f7d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f396d16c860 RCX: 00007f396d07ba90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f396d16c860 R08: 0000000000000001 R09: 8cfa47c2e24a60c1
R10: 00007ffc8412f690 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f396d170658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:13323 tgid:13323 ppid:1083   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa1283caa90
RSP: 002b:00007ffff56b8a18 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fa1284bb860 RCX: 00007fa1283caa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fa1284bb860 R08: 0000000000000001 R09: 6ff5f21dde2a2f63
R10: 00007ffff56b88d0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fa1284bf658 R15: 0000000000000001
 </TASK>
task:kworker/u8:7    state:R  running task     stack:32568 pid:13325 tgid:13325 ppid:1660   flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:13331 tgid:13331 ppid:37     flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:27680 pid:13341 tgid:13341 ppid:28     flags:0x00004000
Call Trace:
 <TASK>
 </TASK>
task:kworker/u8:4    state:R  running task     stack:32568 pid:13349 tgid:13349 ppid:49     flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13353 tgid:13353 ppid:37     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fabaaa6aa90
RSP: 002b:00007ffe6440b978 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fabaab5b860 RCX: 00007fabaaa6aa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fabaab5b860 R08: 0000000000000001 R09: d5edf3e2e2b56a57
R10: 00007ffe6440b830 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fabaab5f658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13358 tgid:13358 ppid:1083   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb57f53ea90
RSP: 002b:00007ffe025ff438 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fb57f62f860 RCX: 00007fb57f53ea90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fb57f62f860 R08: 0000000000000001 R09: 1db62142b9186e29
R10: 00007ffe025ff2f0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fb57f633658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:26144 pid:13364 tgid:13364 ppid:37     flags:0x00000000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:13375 tgid:13375 ppid:49     flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4775306a90
RSP: 002b:00007ffed81e9548 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f47753f7860 RCX: 00007f4775306a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f47753f7860 R08: 0000000000000001 R09: 5a38249b650f34fe
R10: 00007ffed81e9400 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f47753fb658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13384 tgid:13384 ppid:49     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0e48313a90
RSP: 002b:00007ffd58d3e878 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f0e48404860 RCX: 00007f0e48313a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f0e48404860 R08: 0000000000000001 R09: 1e106a406203c9f2
R10: 00007ffd58d3e730 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f0e48408658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13386 tgid:13386 ppid:28     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 </TASK>
task:kworker/u8:5    state:R  running task     stack:32568 pid:13399 tgid:13399 ppid:1083   flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:24000 pid:13400 tgid:13400 ppid:37     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb37a113a90
RSP: 002b:00007ffce2d1b598 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fb37a204860 RCX: 00007fb37a113a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fb37a204860 R08: 0000000000000001 R09: bd46429acf907b78
R10: 00007ffce2d1b450 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fb37a208658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:13406 tgid:13406 ppid:28     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0d14571a90
RSP: 002b:00007ffc64355b58 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f0d14662860 RCX: 00007f0d14571a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f0d14662860 R08: 0000000000000001 R09: f5e51417c1155544
R10: 00007ffc64355a10 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f0d14666658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13407 tgid:13407 ppid:37     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6869
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7214
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13420 tgid:13420 ppid:1083   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 </TASK>
task:kworker/u8:4    state:R  running task     stack:32568 pid:13430 tgid:13430 ppid:49     flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13433 tgid:13433 ppid:1083   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 </TASK>
task:kworker/u8:4    state:R  running task     stack:32568 pid:13439 tgid:13439 ppid:49     flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13444 tgid:13444 ppid:1083   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f67b6581a90
RSP: 002b:00007ffcc12d17a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f67b6672860 RCX: 00007f67b6581a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f67b6672860 R08: 0000000000000001 R09: 8898a54f3943aeed
R10: 00007ffcc12d1660 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f67b6676658 R15: 0000000000000001
 </TASK>
task:kworker/u8:1    state:R  running task     stack:32568 pid:13451 tgid:13451 ppid:28     flags:0x00004000
Call Trace:
 <TASK>
 </TASK>
task:kworker/u8:1    state:R  running task     stack:28784 pid:13458 tgid:13458 ppid:28     flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6869
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7214
 _cond_resched include/linux/sched.h:2031 [inline]
 stop_one_cpu+0x112/0x190 kernel/stop_machine.c:151
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13465 tgid:13465 ppid:28     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13466 tgid:13466 ppid:37     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 </TASK>
task:kworker/u8:1    state:R  running task     stack:32568 pid:13476 tgid:13476 ppid:28     flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:13479 tgid:13479 ppid:1083   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f578ccc5a90
RSP: 002b:00007ffff39dea88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f578cdb6860 RCX: 00007f578ccc5a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f578cdb6860 R08: 0000000000000001 R09: 0fba4ed9679c90fc
R10: 00007ffff39de940 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f578cdba658 R15: 0000000000000001
 </TASK>
task:kworker/u8:2    state:R  running task     stack:32568 pid:13483 tgid:13483 ppid:37     flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:13486 tgid:13486 ppid:1083   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 </TASK>
task:modprobe        state:R  running task     stack:24416 pid:13489 tgid:13489 ppid:28     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 </TASK>
task:kworker/u8:5    state:R  running task     stack:28784 pid:13496 tgid:13496 ppid:1083   flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __pfx___lock_acquire+0x10/0x10 kernel/locking/lockdep.c:4387
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13508 tgid:13508 ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5822265a90
RSP: 002b:00007ffdfb9c1418 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f5822356860 RCX: 00007f5822265a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f5822356860 R08: 0000000000000001 R09: c12ea49cfe43e2eb
R10: 00007ffdfb9c12d0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f582235a658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:27680 pid:13514 tgid:13514 ppid:49     flags:0x00004000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:13526 tgid:13526 ppid:37     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:13535 tgid:13535 ppid:1083   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3dcb152a90
RSP: 002b:00007fff7d08bc18 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f3dcb243860 RCX: 00007f3dcb152a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f3dcb243860 R08: 0000000000000001 R09: 1360b7a454a437d9
R10: 00007fff7d08bad0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f3dcb247658 R15: 0000000000000001
 </TASK>
task:kworker/u8:0    state:R  running task     stack:28656 pid:13536 tgid:13536 ppid:11     flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6869
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7214
 _cond_resched include/linux/sched.h:2031 [inline]
 stop_one_cpu+0x112/0x190 kernel/stop_machine.c:151
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:13548 tgid:13548 ppid:37     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1d58804a90
RSP: 002b:00007fffbbc55d98 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f1d588f5860 RCX: 00007f1d58804a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f1d588f5860 R08: 0000000000000001 R09: fa583e7af9fc8444
R10: 00007fffbbc55c50 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f1d588f9658 R15: 0000000000000001
 </TASK>
task:kworker/u8:5    state:R  running task     stack:32568 pid:13556 tgid:13556 ppid:1083   flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13557 tgid:13557 ppid:37     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13559 tgid:13559 ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2f45426a90
RSP: 002b:00007ffd02b8d838 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f2f45517860 RCX: 00007f2f45426a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f2f45517860 R08: 0000000000000001 R09: fe35d7674ccd1900
R10: 00007ffd02b8d6f0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f2f4551b658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13564 tgid:13564 ppid:1083   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd9117faa90
RSP: 002b:00007fff5e3249b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fd9118eb860 RCX: 00007fd9117faa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fd9118eb860 R08: 0000000000000001 R09: 3a76611e285e268b
R10: 00007fff5e324870 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fd9118ef658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13571 tgid:13571 ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae63d6ba90
RSP: 002b:00007ffddcaf5968 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fae63e5c860 RCX: 00007fae63d6ba90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fae63e5c860 R08: 0000000000000001 R09: 54732f706bfa0a02
R10: 00007ffddcaf5820 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fae63e60658 R15: 0000000000000001
 </TASK>
task:kworker/u8:2    state:R  running task     stack:32568 pid:13577 tgid:13577 ppid:37     flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6869
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7214
 _cond_resched include/linux/sched.h:2031 [inline]
 stop_one_cpu+0x112/0x190 kernel/stop_machine.c:151
 sched_exec+0x1dc/0x270 kernel/sched/core.c:5459
 </TASK>
task:kworker/u8:0    state:R  running task     stack:32568 pid:13585 tgid:13585 ppid:11     flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:13586 tgid:13586 ppid:49     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13587 tgid:13587 ppid:37     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5cb2147a90
RSP: 002b:00007ffd84eef618 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f5cb2238860 RCX: 00007f5cb2147a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f5cb2238860 R08: 0000000000000001 R09: 7dcc8d5dc511ad04
R10: 00007ffd84eef4d0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f5cb223c658 R15: 0000000000000001
 </TASK>
task:kworker/u8:4    state:R  running task     stack:28784 pid:13589 tgid:13589 ppid:49     flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6869
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7214
 _cond_resched include/linux/sched.h:2031 [inline]
 stop_one_cpu+0x112/0x190 kernel/stop_machine.c:151
 </TASK>
task:modprobe        state:R  running task     stack:24416 pid:13599 tgid:13599 ppid:37     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd0e321fa90
RSP: 002b:00007fff19f3f6d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fd0e3310860 RCX: 00007fd0e321fa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fd0e3310860 R08: 0000000000000001 R09: bc69d94be04e9d32
R10: 00007fff19f3f590 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fd0e3314658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13606 tgid:13606 ppid:1083   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24000 pid:13613 tgid:13613 ppid:1083   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:13620 tgid:13620 ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:kworker/u8:5    state:R  running task     stack:32568 pid:13632 tgid:13632 ppid:1083   flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:13635 tgid:13635 ppid:37     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13638 tgid:13638 ppid:11     flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:kworker/u8:2    state:R  running task     stack:32568 pid:13639 tgid:13639 ppid:37     flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13642 tgid:13642 ppid:1083   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:kworker/u8:4    state:R  running task     stack:32568 pid:13652 tgid:13652 ppid:49     flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25424 pid:13654 tgid:13654 ppid:37     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6690
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6706
 do_exit+0x1de7/0x2ce0 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1311861a90
RSP: 002b:00007ffd49e66878 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f1311952860 RCX: 00007f1311861a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f1311952860 R08: 0000000000000001 R09: 0125b0c056cedf8b
R10: 00007ffd49e66730 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f1311956658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:13659 tgid:13659 ppid:1083   flags:0x00000002
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

