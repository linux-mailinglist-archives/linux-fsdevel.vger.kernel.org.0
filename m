Return-Path: <linux-fsdevel+bounces-7058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E91C8213AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jan 2024 13:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FFB281B8F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jan 2024 12:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA2C3D71;
	Mon,  1 Jan 2024 12:06:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DDD23AD
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jan 2024 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fc70bd879so87391095ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jan 2024 04:06:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704110781; x=1704715581;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=53Pb5CeqIXJeHNJ+8UaYnsfD0jt31nkDn8D1hLApyeY=;
        b=cdFsS6eFptCkE2MAfIf9BU2QhqmLjKb0tS0D/6ZynZLN55onftUmW8uLn+IwHYTmuL
         iMTCh4saDS3izTQrOEv0q6mkyT/da9Gdjl8bQdXC8gqttyLGLfJH+q5bN/FW/VT/hk7i
         x7vmL8o057VyTMqKKYkD6x+VwQ1Fcj11kSCjIXbMnDcOU8RiQWA7zi5s3XAmZhncBAzz
         ePDdnsWs01bVKKj4o4nuaZ0iPasR2tom4/DqTU4/nxcAZ50ubfFirScRYcjzJBKUmmY9
         VNM69NHkvDtoIESMqbukYw0bFt0//TmWf0THfqiiCxqDNgoELKA54qsb1xyeUX+QpkF0
         ncgw==
X-Gm-Message-State: AOJu0YxRINEefWfONgvn7rBbd7fY+kOEW/ICU2MugUIuScz577jCLYis
	7MHzvcvSHUlrdTubWLOuMJKq8ntpBibMnylrlWK6MZ48KUfn
X-Google-Smtp-Source: AGHT+IH/jiId/5WfHRbtSh3/vils7PMse8le5A5EZVnCpvkVaV6ktO6+XPEKJ+JMLiji5Q1OeuhJUDGZj99HVOxkZ+y7lD5I8E9C
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bcb:b0:35f:f65e:c33 with SMTP id
 x11-20020a056e021bcb00b0035ff65e0c33mr2001101ilv.4.1704110781406; Mon, 01 Jan
 2024 04:06:21 -0800 (PST)
Date: Mon, 01 Jan 2024 04:06:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c8a56a060de13553@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in ext4_quota_write
From: syzbot <syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f5837722ffec Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=126518f9e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
dashboard link: https://syzkaller.appspot.com/bug?extid=a43d4f48b8397d0e41a9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ca19a1e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13177855e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82ead61bb986/disk-f5837722.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3f5c4dfe98d4/vmlinux-f5837722.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0522c559ed12/bzImage-f5837722.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/dae235506b29/mount_1.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ed91c9e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11ed91c9e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=16ed91c9e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com

INFO: task syz-executor323:5064 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc7-syzkaller-00016-gf5837722ffec #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor323 state:D stack:19696 pid:5064  tgid:5064  ppid:5062   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1961/0x4ab0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6778
 io_schedule+0x8c/0x100 kernel/sched/core.c:8998
 bit_wait_io+0x12/0xc0 kernel/sched/wait_bit.c:209
 __wait_on_bit_lock+0xd1/0x530 kernel/sched/wait_bit.c:90
 out_of_line_wait_on_bit_lock+0x1d4/0x250 kernel/sched/wait_bit.c:117
 lock_buffer include/linux/buffer_head.h:404 [inline]
 ext4_quota_write+0x37c/0x580 fs/ext4/super.c:7251
 qtree_write_dquot+0x243/0x530 fs/quota/quota_tree.c:431
 v2_write_dquot+0x120/0x190 fs/quota/quota_v2.c:358
 dquot_commit+0x3c4/0x520 fs/quota/dquot.c:512
 ext4_write_dquot+0x1f2/0x2c0 fs/ext4/super.c:6877
 mark_dquot_dirty fs/quota/dquot.c:372 [inline]
 mark_all_dquot_dirty fs/quota/dquot.c:410 [inline]
 dquot_alloc_inode+0x69f/0xb70 fs/quota/dquot.c:1780
 ext4_xattr_inode_alloc_quota fs/ext4/xattr.c:932 [inline]
 ext4_xattr_set_entry+0xaf3/0x3fc0 fs/ext4/xattr.c:1715
 ext4_xattr_block_set+0x6a2/0x35e0 fs/ext4/xattr.c:1970
 ext4_xattr_set_handle+0xcdf/0x1570 fs/ext4/xattr.c:2456
 ext4_xattr_set+0x241/0x3d0 fs/ext4/xattr.c:2558
 __vfs_setxattr+0x460/0x4a0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x12e/0x5e0 fs/xattr.c:235
 vfs_setxattr+0x221/0x420 fs/xattr.c:322
 do_setxattr fs/xattr.c:630 [inline]
 setxattr+0x25d/0x2f0 fs/xattr.c:653
 path_setxattr+0x1c0/0x2a0 fs/xattr.c:672
 __do_sys_setxattr fs/xattr.c:688 [inline]
 __se_sys_setxattr fs/xattr.c:684 [inline]
 __x64_sys_setxattr+0xbb/0xd0 fs/xattr.c:684
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7faba3ffbd99
RSP: 002b:00007ffea2f3e548 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007faba3ffbd99
RDX: 0000000020000380 RSI: 0000000020000340 RDI: 00000000200002c0
RBP: 00007faba40705f0 R08: 0000000000000000 R09: 00005555570644c0
R10: 000000000000ffed R11: 0000000000000246 R12: 00007ffea2f3e570
R13: 00007ffea2f3e798 R14: 431bde82d7b634db R15: 00007faba404503b
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8d92dae0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8d92dae0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8d92dae0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by getty/4822:
 #0: ffff88814b3dc0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002efe2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b4/0x1e10 drivers/tty/n_tty.c:2201
6 locks held by syz-executor323/5064:
 #0: ffff88801da0e418 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:404
 #1: ffff888078454000 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
 #1: ffff888078454000 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: vfs_setxattr+0x1e1/0x420 fs/xattr.c:321
 #2: ffff888078453cc8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 #2: ffff888078453cc8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x277/0x1570 fs/ext4/xattr.c:2371
 #3: ffffffff8da82710 (dquot_srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:116 [inline]
 #3: ffffffff8da82710 (dquot_srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:215 [inline]
 #3: ffffffff8da82710 (dquot_srcu){.+.+}-{0:0}, at: dquot_alloc_inode+0x1ab/0xb70 fs/quota/dquot.c:1758
 #4: ffff88807879c0a8 (&dquot->dq_lock){+.+.}-{3:3}, at: dquot_commit+0x5b/0x520 fs/quota/dquot.c:505
 #5: ffff88801da0e210 (&s->s_dquot.dqio_sem){++++}-{3:3}, at: v2_write_dquot+0x90/0x190 fs/quota/quota_v2.c:356

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.7.0-rc7-syzkaller-00016-gf5837722ffec #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x498/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x310 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfaf/0xff0 kernel/hung_task.c:379
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 48 Comm: kworker/u4:3 Not tainted 6.7.0-rc7-syzkaller-00016-gf5837722ffec #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:26 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:67 [inline]
RIP: 0010:arch_local_irq_save arch/x86/include/asm/irqflags.h:103 [inline]
RIP: 0010:lock_acquire+0x176/0x530 kernel/locking/lockdep.c:5750
Code: 8d bc 24 80 00 00 00 4c 89 fb 48 c1 eb 03 42 80 3c 2b 00 74 08 4c 89 ff e8 c7 59 7d 00 48 c7 84 24 80 00 00 00 00 00 00 00 9c <8f> 84 24 80 00 00 00 42 80 3c 2b 00 74 08 4c 89 ff e8 04 59 7d 00
RSP: 0018:ffffc90000b8f798 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 1ffff92000171f04 RCX: ffffffff816d25b4
RDX: 0000000000000000 RSI: ffffffff8bbde140 RDI: ffffffff8bbde100
RBP: ffffc90000b8f8e8 R08: ffffffff8f00c16f R09: 1ffffffff1e0182d
R10: dffffc0000000000 R11: fffffbfff1e0182e R12: 1ffff92000171efc
R13: dffffc0000000000 R14: 0000000000000000 R15: ffffc90000b8f820
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f3ecba5680 CR3: 000000000d731000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
 arch_jump_label_transform_queue+0x59/0xf0 arch/x86/kernel/jump_label.c:136
 __jump_label_update+0x177/0x3a0 kernel/jump_label.c:475
 static_key_disable_cpuslocked+0xce/0x1b0 kernel/jump_label.c:235
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
 toggle_allocation_gate+0x1b8/0x250 mm/kfence/core.c:835
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x90f/0x1420 kernel/workqueue.c:2700
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2781
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.110 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

