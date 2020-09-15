Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB27E269D9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 06:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgIOE7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 00:59:23 -0400
Received: from mail-io1-f78.google.com ([209.85.166.78]:54086 "EHLO
        mail-io1-f78.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgIOE7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 00:59:21 -0400
Received: by mail-io1-f78.google.com with SMTP id r16so1381479iot.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 21:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ddGtd3+Sz9+XwdJwsR/LnYm1C3I3CJ47y3f44n/RKmM=;
        b=i59k3sYhxCPCVH6MVSgPlKd+uvC0d0FKaIwKOKWaUD0YuXTUvV2W53R2X9dOvzvAYL
         bNzwmseyulyDiksV+a2hrbvf5wwZkash/W37aSXgTCsNbLb0HPzkP++gZ8wTep6FaH95
         uLt7MwzTviULZn+V7y5qPpaGxzDQeu+dkbmXnDiK9r7+TAMlE3+evwJZgAIVyLCQtyuk
         wdsphsJKI7Lwtd98LV60Nx9HwtNdMHbuxjhpPPQ+2aRrdC/nz9KWaTuulv2M7QBq4fcP
         PUGRMI2Qyg0tbqZDHm7TqrAtoJCK26k9k6MqfthF/6uvWQffYz6WhowEOlAbZa1b4knc
         O6DA==
X-Gm-Message-State: AOAM533uc6lQUKzFnczX2vt5ypl0LeXA7rf7UguVRHaQNT5FghhqZJDE
        1BPKXOyUJTPKrgDTfDEdkwVlHVuksYhLU/L5frTxEFvERj3n
X-Google-Smtp-Source: ABdhPJxcc/oRX47trpq7nPKnxBdMo7rZoAdZBhDPsiH3qO8s+RQlmvJNgcnnyPFkfNdb0Hcp9vfzTKOjlOu6SempdVe0FNhCpdIl
MIME-Version: 1.0
X-Received: by 2002:a92:9f4d:: with SMTP id u74mr13828930ili.134.1600145960098;
 Mon, 14 Sep 2020 21:59:20 -0700 (PDT)
Date:   Mon, 14 Sep 2020 21:59:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a633505af53038f@google.com>
Subject: INFO: task hung in vfs_setxattr (3)
From:   syzbot <syzbot+738cca7d7d9754493513@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nborisov@suse.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7fe10096 Merge branch 'linus' of git://git.kernel.org/pub/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=140b0853900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
dashboard link: https://syzkaller.appspot.com/bug?extid=738cca7d7d9754493513
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108d45a5900000

The issue was bisected to:

commit 6a3c7f5c87854e948c3c234e5f5e745c7c553722
Author: Nikolay Borisov <nborisov@suse.com>
Date:   Thu May 28 08:05:13 2020 +0000

    btrfs: don't balance btree inode pages from buffered write path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14884d21900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16884d21900000
console output: https://syzkaller.appspot.com/x/log.txt?x=12884d21900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+738cca7d7d9754493513@syzkaller.appspotmail.com
Fixes: 6a3c7f5c8785 ("btrfs: don't balance btree inode pages from buffered write path")

INFO: task syz-executor.2:9042 blocked for more than 143 seconds.
      Not tainted 5.9.0-rc4-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:29136 pid: 9042 ppid:  6892 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:3778 [inline]
 __schedule+0xea9/0x2230 kernel/sched/core.c:4527
 schedule+0xd0/0x2a0 kernel/sched/core.c:4602
 rwsem_down_write_slowpath+0x603/0xc60 kernel/locking/rwsem.c:1235
 __down_write kernel/locking/rwsem.c:1389 [inline]
 down_write+0x137/0x150 kernel/locking/rwsem.c:1532
 inode_lock include/linux/fs.h:779 [inline]
 vfs_setxattr+0xc7/0x270 fs/xattr.c:282
 setxattr+0x23d/0x330 fs/xattr.c:548
 path_setxattr+0x170/0x190 fs/xattr.c:567
 __do_sys_setxattr fs/xattr.c:582 [inline]
 __se_sys_setxattr fs/xattr.c:578 [inline]
 __x64_sys_setxattr+0xc0/0x160 fs/xattr.c:578
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5b9
Code: Bad RIP value.
RSP: 002b:00007f37140efc78 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00000000000324c0 RCX: 000000000045d5b9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 00000000200000c0
RBP: 000000000118d0d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118d08c
R13: 00007ffda389b2af R14: 00007f37140f09c0 R15: 000000000118d08c

Showing all locks held in the system:
1 lock held by khungtaskd/1170:
 #0: ffffffff89bd6a40 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:5829
1 lock held by in:imklog/6526:
 #0: ffff88809a802630 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:930
1 lock held by syz-executor.2/6892:
 #0: ffff8880ae735e18 (&rq->lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1292 [inline]
 #0: ffff8880ae735e18 (&rq->lock){-.-.}-{2:2}, at: __schedule+0x270/0x2230 kernel/sched/core.c:4445
2 locks held by syz-executor.3/8619:
 #0: ffff88809d79a450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff88809d79a450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888088e4b2d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888088e4b2d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.2/9017:
 #0: ffff88808fbaa450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff88808fbaa450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888078d40790 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888078d40790 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.2/9042:
 #0: ffff88808fbaa450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff88808fbaa450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888078d40790 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888078d40790 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.0/9486:
 #0: ffff888076092450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff888076092450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888078d2b450 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888078d2b450 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.3/9622:
 #0: ffff88809e782450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff88809e782450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888078d9f850 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888078d9f850 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.0/9913:
 #0: ffff88808ebfa450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff88808ebfa450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888078e06390 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888078e06390 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.0/10432:
 #0: ffff888068e02450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff888068e02450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888078e7e950 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888078e7e950 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.0/10443:
 #0: ffff888068e02450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff888068e02450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888078e7e950 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888078e7e950 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.1/10731:
 #0: ffff88808dadc450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff88808dadc450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888087b46150 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888087b46150 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.5/11612:
 #0: ffff88809f5c4450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff88809f5c4450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888078fcc890 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888078fcc890 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.5/12306:
 #0: ffff888075c50450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff888075c50450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888078e98990 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888078e98990 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.4/12782:
 #0: ffff888076d84450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff888076d84450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888084b6a450 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888084b6a450 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.0/14244:
 #0: ffff88808ee8e450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff88808ee8e450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888054cd1210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888054cd1210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.4/15284:
 #0: ffff888073912450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff888073912450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888054d377d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888054d377d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.5/15419:
 #0: ffff8880935d4450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff8880935d4450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff88803586f810 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff88803586f810 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.0/15659:
 #0: ffff8880a1c3c450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff8880a1c3c450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888054f75290 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888054f75290 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.5/16372:
 #0: ffff8880886f8450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff8880886f8450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff8880358f67d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff8880358f67d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.3/16634:
 #0: ffff888098182450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff888098182450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888035849410 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888035849410 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.0/17172:
 #0: ffff88809da2a450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff88809da2a450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888035b51810 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888035b51810 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.3/17649:
 #0: ffff888023504450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff888023504450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888035ba5290 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888035ba5290 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.5/18338:
 #0: ffff8880217a0450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff8880217a0450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888054ede2d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888054ede2d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.1/18583:
 #0: ffff88809f09c450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff88809f09c450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888035a4a9d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888035a4a9d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.4/19575:
 #0: ffff888055606450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff888055606450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff88801cea8210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff88801cea8210 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.4/19695:
 #0: ffff8880934d6450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff8880934d6450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888035bf43d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888035bf43d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.0/19828:
 #0: ffff888036c7e450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff888036c7e450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888035a91790 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff888035a91790 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282
2 locks held by syz-executor.0/20224:
 #0: ffff8880a1e14450 (sb_writers#16){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1643 [inline]
 #0: ffff8880a1e14450 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff8880008003d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:779 [inline]
 #1: ffff8880008003d0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0xc7/0x270 fs/xattr.c:282

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1170 Comm: khungtaskd Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x70/0xb1 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x1b3/0x223 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd7d/0x1000 kernel/hung_task.c:295
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 3911 Comm: systemd-udevd Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:lockdep_recursion_finish kernel/locking/lockdep.c:398 [inline]
RIP: 0010:lockdep_hardirqs_on_prepare kernel/locking/lockdep.c:3698 [inline]
RIP: 0010:lockdep_hardirqs_on_prepare+0x21c/0x530 kernel/locking/lockdep.c:3649
Code: fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 c9 01 00 00 8b 83 e4 08 00 00 83 e8 01 66 85 c0 <89> 83 e4 08 00 00 0f 85 31 01 00 00 5b 5d c3 48 c7 c0 40 3c b6 89
RSP: 0018:ffffc900016276e0 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffff888099824280 RCX: 0000000000000006
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888099824b64
RBP: ffff888099824280 R08: 0000000000000000 R09: ffffffff8c5f59f7
R10: fffffbfff18beb3e R11: 0000000000000001 R12: 0000000000000282
R13: ffffffff81b3f5e9 R14: ffff8880aa06f500 R15: 0000000000000200
FS:  00007f9a3eb638c0(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ea5e261280 CR3: 00000000a74cf000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 trace_hardirqs_on+0x5f/0x220 kernel/trace/trace_preemptirq.c:49
 slab_alloc mm/slab.c:3305 [inline]
 kmem_cache_alloc+0x269/0x3a0 mm/slab.c:3482
 vm_area_dup+0x88/0x2b0 kernel/fork.c:355
 dup_mmap kernel/fork.c:531 [inline]
 dup_mm+0x508/0x1300 kernel/fork.c:1354
 copy_mm kernel/fork.c:1410 [inline]
 copy_process+0x28e4/0x6920 kernel/fork.c:2069
 _do_fork+0xe8/0xb10 kernel/fork.c:2428
 __do_sys_clone+0xc8/0x110 kernel/fork.c:2545
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f9a3d9b338b
Code: db 45 85 f6 0f 85 95 01 00 00 64 4c 8b 04 25 10 00 00 00 31 d2 4d 8d 90 d0 02 00 00 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 de 00 00 00 85 c0 41 89 c5 0f 85 e5 00 00
RSP: 002b:00007ffd4929fc40 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffd4929fc40 RCX: 00007f9a3d9b338b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffd4929fc90 R08: 00007f9a3eb638c0 R09: 0000000000000210
R10: 00007f9a3eb63b90 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000020 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
