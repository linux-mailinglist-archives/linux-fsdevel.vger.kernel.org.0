Return-Path: <linux-fsdevel+bounces-30453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1FB98B7DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5B81F22E1B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 09:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BD819D88B;
	Tue,  1 Oct 2024 09:04:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2E319D887
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773482; cv=none; b=AsW+eA2l1ETmmiK0njd/QEHtqShnYqo4m4O5/8bl1SyACu0uewOFdDbNIwTYECAdoc4EklQVidJs4fsiCx2sV2CqBKtNViYTbgszabUG2Dl/UlQiIvtzRyY4h2qiowbYVBaVb80HJZlQUx6u3hlaIJWhM/Ir+BqQP6Y6cCebunY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773482; c=relaxed/simple;
	bh=ObxWkqgZ+4vSjbqb8PCKrdZTAviynstzpVyZHSWq1ds=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PYbkmCABLlg09+BmJhjqAwUE1328UK/VmUk2k0j9UcN0BmESWkbYVk0h2gUnMZzFgwlDrOm4xP8cPw+uu09bIMij2sbeFM0vRyx3dDVDLWSeOpBj3npYY3MFyyhlWcwqpydQhByugrB8BHH153+G4VNFf1XEnXZihrYheNeqHSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82d0daa1b09so701874939f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 02:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727773478; x=1728378278;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZiClJEhfxH6faxyegcU8quMFeUKXAjJ/+PCzjgRHxuM=;
        b=VJGzSBPQY3zO7otRDQWpxiS8WZTDc3yAMUcwmCfEMWTjAl8//3WuzGvSJVDquO993F
         /GrFfAfryvjvhuWRsJ9XlK8DLbjAjEtmqIljyC7OectYFN7jBay9GgjLZB7kPPZp2w4r
         mKj9nWZQAN4NE3HFBVSr6m7p3h+jgEVUAR6fkDcNfuxbHCQRVeO8BZwE+DWFL7bCfH0U
         sElNYA+kLUjPGgNL8+/PZlcrIKajrX6BtF7xp50LZNSz88wSRhIJm1kN9X7d4M4nQhD2
         JWUUR/sfGgDikd8an7YhqKTUDPZ6aKVnELX3KnAd+7diQ4rHAGH8d36VRXebyTNnyWrr
         Ea3w==
X-Forwarded-Encrypted: i=1; AJvYcCWVyxiAXlyQmVxF/BVLRbr/Y5ipHFJs/bapeCx+vDSdSRnNfrWamtRXPdZKO50CxDYY2UEVz/bgMI4TJkkG@vger.kernel.org
X-Gm-Message-State: AOJu0Yycq5RmDDKdTQDAb/FSk8Bj5AHMS+LlfsKEdaNpr1GRmLSh1LuC
	vgvCqVV23S/FV2FeF5fVzrnaPo8w0/1bYgB6RLS5UIlpdfHf+c3Ck9LxSHz23jThtURaEeu/kK6
	bLrBKh6lIs6z7AUtuOKq0B4ySACaIrUaC9jMyuaYsxV053lZWtn3xcig=
X-Google-Smtp-Source: AGHT+IG7c0xE8Mwq7/ECgV7gdXQwnWmSM8Nt9rahsOnogZWGWRrGyu45q/6bBNOaVeoTIRlwvUPmlFcklLEC12qzDzmK1UkuyrKB
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1686:b0:3a0:b471:9651 with SMTP id
 e9e14a558f8ab-3a3451c3a08mr148893575ab.24.1727773478270; Tue, 01 Oct 2024
 02:04:38 -0700 (PDT)
Date: Tue, 01 Oct 2024 02:04:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fbbb26.050a0220.aab67.0043.GAE@google.com>
Subject: [syzbot] [usb?] [ext4?] [input?] INFO: rcu detected stall in
 sys_pselect6 (2)
From: syzbot <syzbot+310c88228172bcf54bef@syzkaller.appspotmail.com>
To: amir73il@gmail.com, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    075dbe9f6e3c Merge tag 'soc-ep93xx-dt-6.12' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=13a57d9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d9e1c0225f14ccc
dashboard link: https://syzkaller.appspot.com/bug?extid=310c88228172bcf54bef
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f38127980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/47c253223330/disk-075dbe9f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f66e6e6c457a/vmlinux-075dbe9f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3580fe941737/bzImage-075dbe9f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+310c88228172bcf54bef@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-...D
 } 2638 jiffies s: 3113 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):

Sending NMI from CPU 1 to CPUs 0:
 might_resched include/linux/kernel.h:73 [inline]
 down_read+0x78/0x330 kernel/locking/rwsem.c:1525
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 2534 Comm: acpid Not tainted 6.11.0-syzkaller-11558-g075dbe9f6e3c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:vsnprintf+0x9a3/0x1880 lib/vsprintf.c:2836
Code: 00 00 e8 b0 35 6f fa 83 fb 2f 0f 87 44 0b 00 00 e8 62 33 6f fa 49 8d 7e 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 7d 0d 00 00 8d 43 08 41 89 dd 4d 03 6e 10 41 89
RSP: 0018:ffffc90000006bb0 EFLAGS: 00000806
RAX: dffffc0000000000 RBX: 0000000000000018 RCX: ffffffff86e68220
RDX: 1ffff92000000d95 RSI: ffffffff86e6822e RDI: ffffc90000006ca8
RBP: ffffc90000006e67 R08: 0000000000000005 R09: 000000000000002f
R10: 0000000000000018 R11: 0000000000261150 R12: ffffffff8728c6cb
R13: 0000000000000005 R14: ffffc90000006c98 R15: 0000000000000009
FS:  00007f64f14d5740(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7b6c825440 CR3: 0000000115d80000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
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
RSP: 0018:ffffc90001cef570 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff9200039deb0 RCX: 0000000000000001
RDX: 0000000000000001 RSI: ffffffff8727f4c0 RDI: ffffffff8746eb20
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff1f547c4
R10: ffffffff8faa3e27 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: ffff888100eb6028 R15: 0000000000000000
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 inotify_poll+0x9c/0x170 fs/notify/inotify/inotify_user.c:145
 vfs_poll include/linux/poll.h:84 [inline]
 do_select+0xc9a/0x17b0 fs/select.c:535
 core_sys_select+0x459/0xb80 fs/select.c:678
 do_pselect.constprop.0+0x1a0/0x1f0 fs/select.c:760
 __do_sys_pselect6 fs/select.c:803 [inline]
 __se_sys_pselect6 fs/select.c:794 [inline]
 __x64_sys_pselect6+0x183/0x240 fs/select.c:794
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f64f15a4591
Code: 89 44 24 20 4c 8d 64 24 20 48 89 54 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2d 45 31 c9 4d 89 e0 4c 89 f2 b8 0e 01 00 00 0f 05 <48> 89 c3 48 3d 00 f0 ff ff 76 69 48 8b 05 65 58 0d 00 f7 db 64 89
RSP: 002b:00007fffe36305e0 EFLAGS: 00000246 ORIG_RAX: 000000000000010e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f64f15a4591
RDX: 0000000000000000 RSI: 00007fffe36306d8 RDI: 000000000000000b
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000560f94e54178 R14: 0000000000000000 R15: 000000000000000a
 </TASK>
 </TASK>
task:kworker/u8:8    state:R  running task     stack:32568 pid:21400 tgid:21400 ppid:3763   flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:udevd           state:R  running task     stack:32592 pid:21407 tgid:21407 ppid:2549   flags:0x00004002
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21412 tgid:21412 ppid:46     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 exit_to_user_mode_loop kernel/entry/common.c:102 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0xdb/0x240 kernel/entry/common.c:231
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7fe101c8fbb7
RSP: 002b:00007ffc0c637738 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fe101b96860 RCX: 00007fe101aa5a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fe101b96860 R08: 0000000000000001 R09: 574ed0a2e5add132
R10: 00007ffc0c6375f0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fe101b9a658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24688 pid:21415 tgid:21415 ppid:281    flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:21423 tgid:21423 ppid:281    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21427 tgid:21427 ppid:281    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21434 tgid:21434 ppid:1285   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24688 pid:21437 tgid:21437 ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8e26b04a90
RSP: 002b:00007ffff1ddd5a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f8e26bf5860 RCX: 00007f8e26b04a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f8e26bf5860 R08: 0000000000000001 R09: 2d2ecd88753d4659
R10: 00007ffff1ddd460 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f8e26bf9658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21443 tgid:21443 ppid:1285   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4a919cfa90
RSP: 002b:00007fffa7bd07a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f4a91ac0860 RCX: 00007f4a919cfa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f4a91ac0860 R08: 0000000000000001 R09: 41c22d6ae327918c
R10: 00007fffa7bd0660 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f4a91ac4658 R15: 0000000000000001
 </TASK>
task:kworker/u8:2    state:R  running task     stack:28784 pid:21445 tgid:21445 ppid:2696   flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6854
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7192
 _cond_resched include/linux/sched.h:2031 [inline]
 stop_one_cpu+0x112/0x190 kernel/stop_machine.c:151
 sched_exec+0x1db/0x270 kernel/sched/core.c:5446
 bprm_execve fs/exec.c:1838 [inline]
 bprm_execve+0x46c/0x1950 fs/exec.c:1821
 kernel_execve+0x2ef/0x3b0 fs/exec.c:2012
 call_usermodehelper_exec_async+0x255/0x4c0 kernel/umh.c:110
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21458 tgid:21458 ppid:281    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa38665ba90
RSP: 002b:00007ffdeb48aa78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fa38674c860 RCX: 00007fa38665ba90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fa38674c860 R08: 0000000000000001 R09: f3c19952373ac98b
R10: 00007ffdeb48a930 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fa386750658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21466 tgid:21466 ppid:3763   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6854
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7192
 </TASK>
task:modprobe        state:R  running task     stack:25120 pid:21470 tgid:21470 ppid:3763   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd94b287a90
RSP: 002b:00007ffe6073a2b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fd94b378860 RCX: 00007fd94b287a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fd94b378860 R08: 0000000000000001 R09: 10544131b88b4d3e
R10: 00007ffe6073a170 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fd94b37c658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21478 tgid:21478 ppid:3763   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6854
 </TASK>
task:modprobe        state:R  running task     stack:24416 pid:21482 tgid:21482 ppid:1285   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:24688 pid:21491 tgid:21491 ppid:1285   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9ef0666a90
RSP: 002b:00007ffebe60acb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f9ef0757860 RCX: 00007f9ef0666a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f9ef0757860 R08: 0000000000000001 R09: 4412c0bd0a118a4b
R10: 00007ffebe60ab70 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f9ef075b658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21498 tgid:21498 ppid:3763   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21506 tgid:21506 ppid:3763   flags:0x00000002
Call Trace:
 <TASK>
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0x42/0x60 kernel/locking/spinlock.c:162
 </TASK>
task:modprobe        state:R  running task     stack:25120 pid:21513 tgid:21513 ppid:281    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5c7edbfa90
RSP: 002b:00007ffeee92c5d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f5c7eeb0860 RCX: 00007f5c7edbfa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f5c7eeb0860 R08: 0000000000000001 R09: 7dd4ef16feca764a
R10: 00007ffeee92c490 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f5c7eeb4658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24688 pid:21520 tgid:21520 ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21530 tgid:21530 ppid:281    flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f45f8848a90
RSP: 002b:00007ffe3f254478 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f45f8939860 RCX: 00007f45f8848a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f45f8939860 R08: 0000000000000001 R09: e300259c86a5d3ec
R10: 00007ffe3f254330 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f45f893d658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21535 tgid:21535 ppid:1285   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7ca28b8a90
RSP: 002b:00007fff90785c58 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f7ca29a9860 RCX: 00007f7ca28b8a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f7ca29a9860 R08: 0000000000000001 R09: b45cf301264a8229
R10: 00007fff90785b10 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f7ca29ad658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21543 tgid:21543 ppid:1285   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4e05b47a90
RSP: 002b:00007ffe1360e158 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f4e05c38860 RCX: 00007f4e05b47a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f4e05c38860 R08: 0000000000000001 R09: 7fa41d5443bf8713
R10: 00007ffe1360e010 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f4e05c3c658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21550 tgid:21550 ppid:281    flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24416 pid:21556 tgid:21556 ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24688 pid:21562 tgid:21562 ppid:281    flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24688 pid:21570 tgid:21570 ppid:281    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4d8c1ada90
RSP: 002b:00007fffc24f82d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f4d8c29e860 RCX: 00007f4d8c1ada90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f4d8c29e860 R08: 0000000000000001 R09: d05c0e72154d33dc
R10: 00007fffc24f8190 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f4d8c2a2658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21576 tgid:21576 ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:23984 pid:21586 tgid:21586 ppid:3763   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24416 pid:21590 tgid:21590 ppid:3763   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21598 tgid:21598 ppid:281    flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:24416 pid:21610 tgid:21610 ppid:3763   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21616 tgid:21616 ppid:281    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 </TASK>
task:modprobe        state:R  running task     stack:25120 pid:21619 tgid:21619 ppid:1285   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5268c03a90
RSP: 002b:00007ffc4a541938 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f5268cf4860 RCX: 00007f5268c03a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f5268cf4860 R08: 0000000000000001 R09: b6f743a404356424
R10: 00007ffc4a5417f0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f5268cf8658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21626 tgid:21626 ppid:3763   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21629 tgid:21629 ppid:281    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1300006a90
RSP: 002b:00007ffe61736f98 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f13000f7860 RCX: 00007f1300006a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f13000f7860 R08: 0000000000000001 R09: 922d8a7256dcce3e
R10: 00007ffe61736e50 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f13000fb658 R15: 0000000000000001
 </TASK>
task:kworker/u8:8    state:R  running task     stack:32568 pid:21635 tgid:21635 ppid:3763   flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21637 tgid:21637 ppid:281    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9206d98a90
RSP: 002b:00007fff04a89b78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f9206e89860 RCX: 00007f9206d98a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f9206e89860 R08: 0000000000000001 R09: 1a1a804d422a89ca
R10: 00007fff04a89a30 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f9206e8d658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21644 tgid:21644 ppid:281    flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:23984 pid:21654 tgid:21654 ppid:1285   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd4ef72fa90
RSP: 002b:00007ffd3b32dc08 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fd4ef820860 RCX: 00007fd4ef72fa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fd4ef820860 R08: 0000000000000001 R09: 1042bf1790298e02
R10: 00007ffd3b32dac0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fd4ef824658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25120 pid:21660 tgid:21660 ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3aebcc6a90
RSP: 002b:00007ffe78a06c68 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f3aebdb7860 RCX: 00007f3aebcc6a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f3aebdb7860 R08: 0000000000000001 R09: 098105724ab202c1
R10: 00007ffe78a06b20 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f3aebdbb658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21668 tgid:21668 ppid:281    flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21678 tgid:21678 ppid:2696   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6afcc3da90
RSP: 002b:00007ffd4f3cb9a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f6afcd2e860 RCX: 00007f6afcc3da90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f6afcd2e860 R08: 0000000000000001 R09: 3c2ee2b14363bacb
R10: 00007ffd4f3cb860 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f6afcd32658 R15: 0000000000000001
 </TASK>
task:kworker/u8:5    state:R  running task     stack:32568 pid:21683 tgid:21683 ppid:281    flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:24688 pid:21686 tgid:21686 ppid:1285   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21689 tgid:21689 ppid:1285   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8b8c6dba90
RSP: 002b:00007ffd906220a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f8b8c7cc860 RCX: 00007f8b8c6dba90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f8b8c7cc860 R08: 0000000000000001 R09: fec84684996c45ab
R10: 00007ffd90621f60 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f8b8c7d0658 R15: 0000000000000001
 </TASK>
task:kworker/u8:5    state:R  running task     stack:32568 pid:21697 tgid:21697 ppid:281    flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:24688 pid:21700 tgid:21700 ppid:3763   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb17e0f8a90
RSP: 002b:00007ffdd0185fe8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fb17e1e9860 RCX: 00007fb17e0f8a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fb17e1e9860 R08: 0000000000000001 R09: 5c7b63708d2ff386
R10: 00007ffdd0185ea0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fb17e1ed658 R15: 0000000000000001
 </TASK>
task:kworker/u8:6    state:R  running task     stack:32568 pid:21704 tgid:21704 ppid:1285   flags:0x00004000
Call Trace:
 <TASK>
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:modprobe        state:R  running task     stack:25120 pid:21708 tgid:21708 ppid:3763   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21711 tgid:21711 ppid:281    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:modprobe        state:R  running task     stack:24688 pid:21715 tgid:21715 ppid:281    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 </TASK>
task:kworker/u8:8    state:R  running task     stack:32568 pid:21725 tgid:21725 ppid:3763   flags:0x00004000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21726 tgid:21726 ppid:1285   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:kworker/u8:5    state:R  running task     stack:32568 pid:21729 tgid:21729 ppid:281    flags:0x00004000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24688 pid:21733 tgid:21733 ppid:1285   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24688 pid:21736 tgid:21736 ppid:1285   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24688 pid:21743 tgid:21743 ppid:1285   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fad308f9a90
RSP: 002b:00007ffd3848e528 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fad309ea860 RCX: 00007fad308f9a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007fad309ea860 R08: 0000000000000001 R09: 7790b6d87736c85e
R10: 00007ffd3848e3e0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fad309ee658 R15: 0000000000000001
 </TASK>
task:kworker/u8:2    state:R  running task     stack:32568 pid:21749 tgid:21749 ppid:2696   flags:0x00004000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21753 tgid:21753 ppid:281    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 </TASK>
task:modprobe        state:R  running task     stack:24720 pid:21755 tgid:21755 ppid:1285   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7f3ded1a90
RSP: 002b:00007ffd2111f038 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f7f3dfc2860 RCX: 00007f7f3ded1a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f7f3dfc2860 R08: 0000000000000001 R09: 09eda0babcac31ce
R10: 00007ffd2111eef0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f7f3dfc6658 R15: 0000000000000001
 </TASK>
task:kworker/u8:6    state:R  running task     stack:28784 pid:21759 tgid:21759 ppid:1285   flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6854
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7192
 </TASK>
task:modprobe        state:R  running task     stack:24688 pid:21767 tgid:21767 ppid:281    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9137126a90
RSP: 002b:00007ffd3da7d108 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f9137217860 RCX: 00007f9137126a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f9137217860 R08: 0000000000000001 R09: e2553460df8fb3b6
R10: 00007ffd3da7cfc0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f913721b658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21774 tgid:21774 ppid:3763   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 do_task_dead+0xd6/0x110 kernel/sched/core.c:6691
 do_exit+0x1d73/0x2c50 kernel/exit.c:990
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faa52a5fa90
RSP: 002b:00007ffd1e4a3a88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007faa52b50860 RCX: 00007faa52a5fa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007faa52b50860 R08: 0000000000000001 R09: 151060a2bb3848b7
R10: 00007ffd1e4a3940 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007faa52b54658 R15: 0000000000000001
 </TASK>
task:kworker/u8:8    state:R  running task     stack:32568 pid:21781 tgid:21781 ppid:3763   flags:0x00004000
Call Trace:
 <TASK>
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21782 tgid:21782 ppid:2696   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:26128 pid:21785 tgid:21785 ppid:281    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 </TASK>
task:kworker/u8:2    state:R  running task     stack:32568 pid:21786 tgid:21786 ppid:2696   flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:21789 tgid:21789 ppid:281    flags:0x00000000
Call Trace:


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

