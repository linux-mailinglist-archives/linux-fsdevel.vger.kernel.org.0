Return-Path: <linux-fsdevel+bounces-32345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931389A3D44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 13:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334F6283D18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 11:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522FA20262A;
	Fri, 18 Oct 2024 11:28:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A3418CBF1
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729250910; cv=none; b=DmZIdXL3iHxkUauy7nYeWnHGLO9wMFKDikjX5sgDxT2/KrceKWzDU3Hsqlk1Q5KApWT9z5gOCPadi3EL8coLTiSfmijM/Orv4NEhcUzJ5pZkFE8dVLkZtI7tdKfc8ZDAhkLn4m4rJ4TGjxI0mMzJOrp9vGbAXx/Qw7DMSpEoFEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729250910; c=relaxed/simple;
	bh=z+L95hBhUjGfvvxpUU44gLQ3i9efZbv5q0YLoMPDxN8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=U9MUWo6XdRguuSpWtFA5C6GP8T/hkyxrnxBiD3c9LITTqPedWWJn/cqqPAaR16AuR7VY/TRh7NFR8z5pMRQc5/FikO6J4gHVKHo9wgTTXt6ueDvCzGiDmnHPmMvb7TcFANdKglg/q+th1F1R12iYRcByRiCfIiwLaqP6pKGCdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b7d1e8a0so19668365ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 04:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729250907; x=1729855707;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffX1hM0sLaL1DU5jT+e3D8C1ipLWzelCz2a07EQkwcE=;
        b=nnxZA9gA5BWCGSuJHOu/8TNWK3Hq+EurVrJDBNqko3gF+9N5YIOCpy4l4KkknQ+rOv
         7J3qr2p9HtfHZYkph8HnmrBQnQoEGcnef3cRgIomQ8xEPsATCIq4afo5nG5HVnRbUJs1
         Y+h2v0ecrxGlhdIOsF0z4nNrBzrwVbMMwZ6dIf22C88DSaDnSNZSrKE2XReFD6+68Do/
         ZP7hb4PCGGCHqT3f9MLyUi1JO9XIZdLLJ2qXEB0mIrjsLZKcZEoJIVP/mqQRVmyGmO9D
         /TiOHNGl+ohPj0oxsCinYMd34qcGJYUoFlPwtmGLKBbnPg9F8QuFRn9hJH43pjJtxnHF
         zSvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWqiZB0mxaqU4omU46opZrVdr0p4XsPfx1Ys+suiWZYEEEXJlMDMqsnygmL50UoNRahBCF6UtmNGpA2exV@vger.kernel.org
X-Gm-Message-State: AOJu0YwPID9JZVInozIpisZ0o0Kq4RrZP+6SInYspxYgF8Rd1hqRlwRL
	+oWwlBm7bha5f9QU1XvG0bCfBuH4jn1udKPO25PVAcFAQMjTSTQowGzc3i/BeW1+sE/6VmfcZgz
	wsNWi7LlMTuC6FZhFLRZu0ECupfxQiS+g6bU+GYLGLtcUlkXw1T+GWfw=
X-Google-Smtp-Source: AGHT+IFH2AoUJp6KvAlocOOjj6R8V/NJL+35cGheYHpO2/HdbKAtkpjz1tKAtcyweTyvIPDsSZEnejpB7jPYLbCCEBzj2x2sLi8s
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca7:b0:3a0:9f85:d74f with SMTP id
 e9e14a558f8ab-3a3f40a7c50mr21806795ab.16.1729250906780; Fri, 18 Oct 2024
 04:28:26 -0700 (PDT)
Date: Fri, 18 Oct 2024 04:28:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6712465a.050a0220.1e4b4d.0012.GAE@google.com>
Subject: [syzbot] [fs?] INFO: rcu detected stall in sys_readlink (5)
From: syzbot <syzbot+23e14ec82f3c8692eaa9@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    64f3b5a6bc49 Merge 6.12-rc3 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=11d7d85f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9878fe11046ea2c6
dashboard link: https://syzkaller.appspot.com/bug?extid=23e14ec82f3c8692eaa9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11db9440580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/03a93e9d384d/disk-64f3b5a6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/966f6ee7b5f9/vmlinux-64f3b5a6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bebec9f43b90/bzImage-64f3b5a6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+23e14ec82f3c8692eaa9@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 1-...D
 } 2655 jiffies s: 1461 root: 0x2/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 10005 Comm: udevd Not tainted 6.12.0-rc3-syzkaller-00029-g64f3b5a6bc49 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:check_kcov_mode kernel/kcov.c:183 [inline]
RIP: 0010:write_comp_data+0x38/0x90 kernel/kcov.c:246
Code: e4 ad 7e 65 8b 05 50 e4 ad 7e a9 00 01 ff 00 74 1d f6 c4 01 74 67 a9 00 00 0f 00 75 60 a9 00 00 f0 00 75 59 8b 82 54 15 00 00 <85> c0 74 4f 8b 82 30 15 00 00 83 f8 03 75 44 48 8b 82 38 15 00 00
RSP: 0018:ffffc900001b7c70 EFLAGS: 00000046
RAX: 0000000000000000 RBX: 0000000000000008 RCX: ffffffff86e67f92
RDX: ffff888118e9ba80 RSI: 0000000000000073 RDI: 0000000000000001
RBP: ffffffff8810b7c0 R08: 0000000000000001 R09: 0000000000000073
R10: 0000000000000075 R11: 0000000000098390 R12: 0000000000000075
R13: 0000000000000001 R14: 000000000000000a R15: 0000000000000005
FS:  00007fce4e490c80(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f32443d38e5 CR3: 0000000118582000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __sanitizer_cov_trace_switch+0x54/0x90 kernel/kcov.c:351
 format_decode+0x472/0xba0 lib/vsprintf.c:2613
 vsnprintf+0x13d/0x1880 lib/vsprintf.c:2755
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
 sched_show_task kernel/sched/core.c:7589 [inline]
 sched_show_task+0x3f0/0x5f0 kernel/sched/core.c:7564
 show_state_filter+0xee/0x320 kernel/sched/core.c:7634
 k_spec drivers/tty/vt/keyboard.c:667 [inline]
 k_spec+0xed/0x150 drivers/tty/vt/keyboard.c:656
 kbd_keycode drivers/tty/vt/keyboard.c:1522 [inline]
 kbd_event+0xcbd/0x17a0 drivers/tty/vt/keyboard.c:1541
 input_handler_events_default+0x116/0x1b0 drivers/input/input.c:2549
 input_pass_values+0x777/0x8e0 drivers/input/input.c:126
 input_event_dispose drivers/input/input.c:341 [inline]
 input_handle_event+0xf0b/0x14d0 drivers/input/input.c:369
 input_event drivers/input/input.c:398 [inline]
 input_event+0x83/0xa0 drivers/input/input.c:390
 input_sync include/linux/input.h:451 [inline]
 hidinput_report_event+0xb2/0x100 drivers/hid/hid-input.c:1736
 hid_report_raw_event+0x274/0x11c0 drivers/hid/hid-core.c:2047
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
RIP: 0010:lock_acquire.part.0+0x155/0x380 kernel/locking/lockdep.c:5790
Code: b8 ff ff ff ff 65 0f c1 05 30 32 cf 7e 83 f8 01 0f 85 d0 01 00 00 9c 58 f6 c4 02 0f 85 e5 01 00 00 48 85 ed 0f 85 b6 01 00 00 <48> b8 00 00 00 00 00 fc ff df 48 01 c3 48 c7 03 00 00 00 00 48 c7
RSP: 0018:ffffc9000380f9a0 EFLAGS: 00000206
RAX: 0000000000000046 RBX: 1ffff92000701f35 RCX: 0000000000000001
RDX: 0000000000000001 RSI: ffffffff8727f4c0 RDI: ffffffff8746ea80
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff1f55db5
R10: ffffffff8faaedaf R11: 0000000000000000 R12: 0000000000000000
R13: ffff888100abc1e0 R14: 0000000000000000 R15: 0000000000000000
 down_read+0x9a/0x330 kernel/locking/rwsem.c:1524
 kernfs_iop_permission+0xba/0x120 fs/kernfs/inode.c:287
 do_inode_permission fs/namei.c:468 [inline]
 inode_permission fs/namei.c:535 [inline]
 inode_permission+0x388/0x5f0 fs/namei.c:510
 may_lookup fs/namei.c:1760 [inline]
 link_path_walk.part.0.constprop.0+0x1d7/0xd40 fs/namei.c:2366
 link_path_walk fs/namei.c:2349 [inline]
 path_lookupat+0x93/0x770 fs/namei.c:2579
 filename_lookup+0x1e5/0x5b0 fs/namei.c:2609
 do_readlinkat+0xcf/0x390 fs/stat.c:537
 __do_sys_readlink fs/stat.c:574 [inline]
 __se_sys_readlink fs/stat.c:571 [inline]
 __x64_sys_readlink+0x78/0xc0 fs/stat.c:571
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fce4e5bcd47
Code: 73 01 c3 48 8b 0d e1 90 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 59 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b1 90 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd38dc15b8 EFLAGS: 00000202 ORIG_RAX: 0000000000000059
RAX: ffffffffffffffda RBX: 0000559cfe1909b0 RCX: 00007fce4e5bcd47
RDX: 0000000000000400 RSI: 00007ffd38dc19c8 RDI: 00007ffd38dc15c8
RBP: 00007ffd38dc1e08 R08: 0000559cd91101fd R09: 0000000000000000
R10: 0000000000000010 R11: 0000000000000202 R12: 0000000000000200
R13: 00007ffd38dc19c8 R14: 00007ffd38dc15c8 R15: 0000559cd910aa04
 </TASK>
 </TASK>
task:kworker/u8:5    state:R  running task     stack:32568 pid:11335 tgid:11335 ppid:265    flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11369 tgid:11369 ppid:46     flags:0x00000000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11372 tgid:11372 ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efe67ab9a90
RSP: 002b:00007fffd34967f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007efe67baa860 RCX: 00007efe67ab9a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007efe67baa860 R08: 0000000000000001 R09: ea806687bba3ba73
R10: 00007fffd34966b0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007efe67bae658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24416 pid:11376 tgid:11376 ppid:294    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:11381 tgid:11381 ppid:46     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11387 tgid:11387 ppid:46     flags:0x00004002
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
RIP: 0033:0x7f6ba9925a90
RSP: 002b:00007fffc0294348 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f6ba9a16860 RCX: 00007f6ba9925a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f6ba9a16860 R08: 0000000000000001 R09: 1b9cdc5427f5519a
R10: 00007fffc0294200 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f6ba9a1a658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11393 tgid:11393 ppid:1126   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11396 tgid:11396 ppid:1126   flags:0x00000000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:11405 tgid:11405 ppid:294    flags:0x00000000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:11415 tgid:11415 ppid:265    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:kworker/u8:3    state:R  running task     stack:32568 pid:11423 tgid:11423 ppid:46     flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11426 tgid:11426 ppid:265    flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11429 tgid:11429 ppid:265    flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24416 pid:11444 tgid:11444 ppid:294    flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:23984 pid:11453 tgid:11453 ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:kworker/u8:5    state:R  running task     stack:32568 pid:11459 tgid:11459 ppid:265    flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:11464 tgid:11464 ppid:46     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:kworker/u8:8    state:R  running task     stack:32568 pid:11468 tgid:11468 ppid:1126   flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11471 tgid:11471 ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:modprobe        state:R  running task     stack:23984 pid:11475 tgid:11475 ppid:294    flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11484 tgid:11484 ppid:46     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11497 tgid:11497 ppid:1126   flags:0x00000000
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
RIP: 0033:0x7f47f3e45a90
RSP: 002b:00007ffeb8060278 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f47f3f36860 RCX: 00007f47f3e45a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f47f3f36860 R08: 0000000000000001 R09: 351fa3daeee7c7f1
R10: 00007ffeb8060130 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f47f3f3a658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:11504 tgid:11504 ppid:1126   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:kworker/u8:5    state:R  running task     stack:32568 pid:11507 tgid:11507 ppid:265    flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25136 pid:11509 tgid:11509 ppid:294    flags:0x00000000
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
RIP: 0033:0x7f9d1230fa90
RSP: 002b:00007ffca91563f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f9d12400860 RCX: 00007f9d1230fa90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f9d12400860 R08: 0000000000000001 R09: afd0c8902c591a26
R10: 00007ffca91562b0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f9d12404658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:23984 pid:11515 tgid:11515 ppid:46     flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11522 tgid:11522 ppid:46     flags:0x00000000
Call Trace:
 <TASK>
 </TASK>
task:kworker/u8:8    state:R  running task     stack:32568 pid:11528 tgid:11528 ppid:1126   flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:24704 pid:11532 tgid:11532 ppid:294    flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6861
 </TASK>
task:kworker/u8:6    state:R  running task     stack:32568 pid:11535 tgid:11535 ppid:294    flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11539 tgid:11539 ppid:1126   flags:0x00000000
Call Trace:
 <TASK>
 __pfx_user_statfs+0x10/0x10 fs/statfs.c:405
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f06eac40a90
RSP: 002b:00007ffdaafa1a48 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f06ead31860 RCX: 00007f06eac40a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f06ead31860 R08: 0000000000000001 R09: 92b5fa4b7167cbe8
R10: 00007ffdaafa1900 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f06ead35658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11545 tgid:11545 ppid:28     flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:kworker/u8:1    state:R  running task     stack:28784 pid:11550 tgid:11550 ppid:28     flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6861
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7199
 _cond_resched include/linux/sched.h:2031 [inline]
 stop_one_cpu+0x112/0x190 kernel/stop_machine.c:151
 </TASK>
task:kworker/u8:3    state:R  running task     stack:28784 pid:11558 tgid:11558 ppid:46     flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11562 tgid:11562 ppid:294    flags:0x00000002
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
RIP: 0033:0x7f23d35eda90
RSP: 002b:00007ffe53b79838 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f23d36de860 RCX: 00007f23d35eda90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007f23d36de860 R08: 0000000000000001 R09: 5c9f6e761b5f2ecc
R10: 00007ffe53b796f0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f23d36e2658 R15: 0000000000000001
 </TASK>
task:kworker/u8:1    state:R  running task     stack:32568 pid:11563 tgid:11563 ppid:28     flags:0x00004000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11572 tgid:11572 ppid:1126   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:24416 pid:11581 tgid:11581 ppid:46     flags:0x00000002
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
RIP: 0033:0x7ff38e917a90
RSP: 002b:00007ffcccd34238 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007ff38ea08860 RCX: 00007ff38e917a90
RDX: 00000000000000e7 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00007ff38ea08860 R08: 0000000000000001 R09: cfa29951be980679
R10: 00007ffcccd340f0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007ff38ea0c658 R15: 0000000000000001
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11583 tgid:11583 ppid:294    flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:kworker/u8:8    state:R  running task     stack:32568 pid:11597 tgid:11597 ppid:1126   flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:23984 pid:11599 tgid:11599 ppid:294    flags:0x00000000
Call Trace:
 <TASK>
 </TASK>
task:kworker/u8:6    state:R  running task     stack:32568 pid:11606 tgid:11606 ppid:294    flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11609 tgid:11609 ppid:46     flags:0x00000002
Call Trace:
 <TASK>
 deref_stack_reg arch/x86/kernel/unwind_orc.c:406 [inline]
 unwind_next_frame+0xadb/0x20c0 arch/x86/kernel/unwind_orc.c:585
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11614 tgid:11614 ppid:1126   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6861
 __cond_resched+0x1b/0x30 kernel/sched/core.c:7199
 _cond_resched include/linux/sched.h:2031 [inline]
 zap_pmd_range mm/memory.c:1742 [inline]
 zap_pud_range mm/memory.c:1768 [inline]
 zap_p4d_range mm/memory.c:1789 [inline]
 unmap_page_range+0x4b8/0x2fa0 mm/memory.c:1810
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 hlock_class+0x4e/0x130 kernel/locking/lockdep.c:228
 lookup_chain_cache_add kernel/locking/lockdep.c:3816 [inline]
 validate_chain kernel/locking/lockdep.c:3872 [inline]
 __lock_acquire+0x163e/0x3ce0 kernel/locking/lockdep.c:5202
 </TASK>
task:kworker/u8:1    state:R  running task     stack:32568 pid:11624 tgid:11624 ppid:28     flags:0x00004000
Call Trace:
 <TASK>
 </TASK>
task:modprobe        state:R  running task     stack:25408 pid:11629 tgid:11629 ppid:1126   flags:0x00000002
Call Trace:
 <TASK>
 </TASK>
task:kworker/u8:5    state:R  running task     stack:32568 pid:11631 tgid:11631 ppid:265    flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 </TASK>
task:kworker/u8:5    state:R  running task     stack:32568 pid:11645 tgid:11645 ppid:265    flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:kworker/u8:8    state:R  running task     stack:32568 pid:11646 tgid:11646 ppid:1126   flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:kworker/u8:6    state:R  running task     stack:32568 pid:11647 tgid:11647 ppid:294    flags:0x00004000
Call Trace:
 <TASK>
 __switch_to_asm+0x70/0x70
 </TASK>
task:modprobe        state:R  running task     stack:27808 pid:11655 tgid:11655 ppid:46     flags:0x00004000
Call Trace:
 <TASK>
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u8:1/28:
2 locks held by kworker/u8:3/46:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000517d80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:5/265:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90001a0fd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:6/294:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90001affd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/0:1H/295:
 #0: ffff8881026e7d48 ((wq_completion)kblockd){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90001b5fd80 ((work_completion)(&q->timeout_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:8/1126:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900026ffd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by getty/2608:
 #0: ffff8881146590a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
6 locks held by kworker/1:2/2640:
3 locks held by syz-executor/2658:
 #0: ffff888113d2f4a8 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:704 [inline]
 #0: ffff888113d2f4a8 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x13e/0x980 mm/memory.c:6228
 #1: ffff8881146ce4f0 (sb_pagefaults){.+.+}-{0:0}, at: do_page_mkwrite+0x177/0x380 mm/memory.c:3162
 #2: ffff8881146da958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xf6c/0x1430 fs/jbd2/transaction.c:448
5 locks held by udevd/10005:
 #0: ffff888100abc1e0 (&root->kernfs_iattr_rwsem){++++}-{3:3}, at: kernfs_iop_permission+0xba/0x120 fs/kernfs/inode.c:287
 #1: ffff88811beb9230 (&dev->event_lock){..-.}-{2:2}, at: input_event drivers/input/input.c:397 [inline]
 #1: ffff88811beb9230 (&dev->event_lock){..-.}-{2:2}, at: input_event+0x70/0xa0 drivers/input/input.c:390
 #2: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #2: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: input_pass_values+0x8b/0x8e0 drivers/input/input.c:118
 #3: ffffffff893879d8 (kbd_event_lock){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #3: ffffffff893879d8 (kbd_event_lock){..-.}-{2:2}, at: kbd_event+0x8a/0x17a0 drivers/tty/vt/keyboard.c:1535
 #4: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #4: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #4: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
1 lock held by udevd/10091:
 #0: ffffffff88ec69f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x282/0x3b0 kernel/rcu/tree_exp.h:297
1 lock held by syz.1.30/10112:
 #0: ffffffff88ec69f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:329
1 lock held by modprobe/11671:

=============================================



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

