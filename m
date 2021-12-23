Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A66A47DEBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 06:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346427AbhLWFc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 00:32:26 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:57124 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346405AbhLWFcZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 00:32:25 -0500
Received: by mail-io1-f71.google.com with SMTP id d187-20020a6bb4c4000000b00601c0b8532aso2533791iof.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 21:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3CLZiLFF405jT2WdEAO9CtD0OFkbBGpKriTt/oxie+4=;
        b=lVmrqB24/1l/3fEcg9JUc1YnXQUPz49IXTU9Wv+6TPPbQ4qaUAfT/HantkRbaXfHI8
         Iz8gcY8KxvDjfITOmvo0VAz/3H/L6JLDBP6fmg5ll7GKZYdVh39k2kvEkMY8Te6feSC5
         PjbMPxA2lOXN+zIoRsyVyigzYbHez8x3AauMYE7TUWBIUB6UJsXJprAG7LTlW7OYlfY3
         StoLys/AFpkDQO2UQYuWPBb6y5lEJFhUKkM6+YAWqns9wKF2ziUtqnicmfwpHA8P+JnA
         KU8dj+SppNlFJea1CTyjKGTz8Tq+Fh18VUp8TJ4FIc4BUVABS4druuiSOSOcUZoRVQW3
         ajOA==
X-Gm-Message-State: AOAM532ECxIrVKuimiro9qfgyfiN2eA47u/rl8yPi6pmvXYRfkFfMIWx
        EFnBlqGGyOQR2TMp77RUUdb3JhkOb9vWfHcfgjhUQdAUKigQ
X-Google-Smtp-Source: ABdhPJwA7db+Pvu3SL7oFifrFuZ1GKT1pJ1+LA++nXSqBQmu1BNUQOJfDjOZGhU9UQymRPV4WOX8TuClNub+A83TPCi1/vMYItPv
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b23:: with SMTP id e3mr313922ilu.32.1640237544994;
 Wed, 22 Dec 2021 21:32:24 -0800 (PST)
Date:   Wed, 22 Dec 2021 21:32:24 -0800
In-Reply-To: <00000000000032992d05d370f75f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000377ea405d3c9906d@google.com>
Subject: Re: [syzbot] INFO: task hung in jbd2_journal_commit_transaction (3)
From:   syzbot <syzbot+9c3fb12e9128b6e1d7eb@syzkaller.appspotmail.com>
To:     hdanton@sina.com, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    3f066e882bf1 Merge tag 'for-5.16/parisc-7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13aeaedbb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6104739ac5f067ea
dashboard link: https://syzkaller.appspot.com/bug?extid=9c3fb12e9128b6e1d7eb
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130e8ea5b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b3620db00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c3fb12e9128b6e1d7eb@syzkaller.appspotmail.com

INFO: task jbd2/sda1-8:2935 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:jbd2/sda1-8     state:D stack:24688 pid: 2935 ppid:     2 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xb72/0x1460 kernel/sched/core.c:6253
 schedule+0x12b/0x1f0 kernel/sched/core.c:6326
 jbd2_journal_commit_transaction+0xc24/0x5c00 fs/jbd2/commit.c:496
 kjournald2+0x4b4/0x940 fs/jbd2/journal.c:213
 kthread+0x468/0x490 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/27:
 #0: ffffffff8cb1de00 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
2 locks held by getty/3281:
 #0: ffff88814b4a6098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffffc90002b962e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6c5/0x1c60 drivers/tty/n_tty.c:2113
2 locks held by syz-executor272/3690:
 #0: ffff88806d05dda8 (&type->i_mutex_dir_key#4){++++}-{3:3}, at: iterate_dir+0x124/0x640 fs/readdir.c:55
 #1: ffff88814b6d0460 (sb_writers#5){.+.+}-{0:0}, at: file_accessed include/linux/fs.h:2505 [inline]
 #1: ffff88814b6d0460 (sb_writers#5){.+.+}-{0:0}, at: iterate_dir+0x552/0x640 fs/readdir.c:70
2 locks held by syz-executor272/3689:
 #0: ffff88806d0349b8 (&type->i_mutex_dir_key#4){++++}-{3:3}, at: iterate_dir+0x124/0x640 fs/readdir.c:55
 #1: ffff88814b6d0460 (sb_writers#5){.+.+}-{0:0}, at: file_accessed include/linux/fs.h:2505 [inline]
 #1: ffff88814b6d0460 (sb_writers#5){.+.+}-{0:0}, at: iterate_dir+0x552/0x640 fs/readdir.c:70
3 locks held by syz-executor272/3691:
 #0: ffff88814b6d0460 (sb_writers#5){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:376
 #1: ffff888074dcf198 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:818 [inline]
 #1: ffff888074dcf198 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at: filename_create+0x1da/0x4e0 fs/namei.c:3654
 #2: ffff88814b6d4990 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x136d/0x1630 fs/jbd2/transaction.c:466
2 locks held by syz-executor272/3693:
 #0: ffff88806d0317e0 (&type->i_mutex_dir_key#4){++++}-{3:3}, at: iterate_dir+0x124/0x640 fs/readdir.c:55
 #1: ffff88814b6d0460 (sb_writers#5){.+.+}-{0:0}, at: file_accessed include/linux/fs.h:2505 [inline]
 #1: ffff88814b6d0460 (sb_writers#5){.+.+}-{0:0}, at: iterate_dir+0x552/0x640 fs/readdir.c:70
2 locks held by syz-executor272/3694:
 #0: ffff88806d0617e0 (&type->i_mutex_dir_key#4){++++}-{3:3}, at: iterate_dir+0x124/0x640 fs/readdir.c:55
 #1: ffff88814b6d0460 (sb_writers#5){.+.+}-{0:0}, at: file_accessed include/linux/fs.h:2505 [inline]
 #1: ffff88814b6d0460 (sb_writers#5){.+.+}-{0:0}, at: iterate_dir+0x552/0x640 fs/readdir.c:70
2 locks held by syz-executor272/3695:
 #0: ffff88806d035da8 (&type->i_mutex_dir_key#4){++++}-{3:3}, at: iterate_dir+0x124/0x640 fs/readdir.c:55
 #1: ffff88814b6d0460 (sb_writers#5){.+.+}-{0:0}, at: file_accessed include/linux/fs.h:2505 [inline]
 #1: ffff88814b6d0460 (sb_writers#5){.+.+}-{0:0}, at: iterate_dir+0x552/0x640 fs/readdir.c:70
2 locks held by kworker/u4:1/3719:
4 locks held by kworker/u4:4/3847:
 #0: ffff888013bf3938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x7ca/0x1140
 #1: ffffc90003167d20 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x808/0x1140 kernel/workqueue.c:2273
 #2: ffff88814b6d00e0 (&type->s_umount_key#31){++++}-{3:3}, at: trylock_super+0x1b/0xf0 fs/super.c:418
 #3: ffff88814b6d2bd8 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: ext4_writepages+0x1dd/0x4080 fs/ext4/inode.c:2655

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 27 Comm: khungtaskd Not tainted 5.16.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x45f/0x490 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x16a/0x280 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xc82/0xcd0 kernel/hung_task.c:295
 kthread+0x468/0x490 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 3719 Comm: kworker/u4:1 Not tainted 5.16.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: bat_events batadv_nc_worker
RIP: 0010:mark_lock+0x6/0x1e00 kernel/locking/lockdep.c:4566
Code: 07 80 c1 03 38 c1 0f 8c 6f ff ff ff 4c 89 ff e8 80 fb 69 00 e9 62 ff ff ff e8 26 e7 ac 08 66 0f 1f 44 00 00 55 48 89 e5 41 57 <41> 56 41 55 41 54 53 48 83 e4 e0 48 81 ec c0 01 00 00 65 48 8b 04
RSP: 0018:ffffc900029bf8e8 EFLAGS: 00000046
RAX: 0000000000000002 RBX: ffff8880217761d0 RCX: 00000000ffffffff
RDX: 0000000000000008 RSI: ffff8880217761b0 RDI: ffff888021775700
RBP: ffffc900029bf8f0 R08: dffffc0000000000 R09: fffffbfff1ff3ff8
R10: fffffbfff1ff3ff8 R11: 0000000000000000 R12: 000000000000000a
R13: ffff8880217761b0 R14: ffff888021775700 R15: ffff8880217761d0
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005621d6c67680 CR3: 000000000c88e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mark_usage kernel/locking/lockdep.c:4526 [inline]
 __lock_acquire+0xd38/0x2b00 kernel/locking/lockdep.c:4981
 lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
 rcu_lock_acquire+0x2a/0x30 include/linux/rcupdate.h:268
 rcu_read_lock include/linux/rcupdate.h:688 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:412 [inline]
 batadv_nc_worker+0xc8/0x5b0 net/batman-adv/network-coding.c:723
 process_one_work+0x853/0x1140 kernel/workqueue.c:2298
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2445
 kthread+0x468/0x490 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	80 c1 03             	add    $0x3,%cl
   3:	38 c1                	cmp    %al,%cl
   5:	0f 8c 6f ff ff ff    	jl     0xffffff7a
   b:	4c 89 ff             	mov    %r15,%rdi
   e:	e8 80 fb 69 00       	callq  0x69fb93
  13:	e9 62 ff ff ff       	jmpq   0xffffff7a
  18:	e8 26 e7 ac 08       	callq  0x8ace743
  1d:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  23:	55                   	push   %rbp
  24:	48 89 e5             	mov    %rsp,%rbp
  27:	41 57                	push   %r15
* 29:	41 56                	push   %r14 <-- trapping instruction
  2b:	41 55                	push   %r13
  2d:	41 54                	push   %r12
  2f:	53                   	push   %rbx
  30:	48 83 e4 e0          	and    $0xffffffffffffffe0,%rsp
  34:	48 81 ec c0 01 00 00 	sub    $0x1c0,%rsp
  3b:	65                   	gs
  3c:	48                   	rex.W
  3d:	8b                   	.byte 0x8b
  3e:	04                   	.byte 0x4

