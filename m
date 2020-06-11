Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC9F1F6112
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 06:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgFKEsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 00:48:18 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:43519 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgFKEsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 00:48:16 -0400
Received: by mail-io1-f71.google.com with SMTP id c17so3099585ioi.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2020 21:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uR7SVPRTO+boWnHF45d0VbduZ0eviEhyUtZjIrwS6+I=;
        b=TmVLAFJPFVI7YCfB8ta9IOawhYpT3gBDHRqOeZMTt2Hd2W6hp5PD+3XDUtOp6+G/n9
         +d8Sw0UIoNEZTJinZRpHNqcm8LVUx9hFC3zCa2/4xi4PKxdMGvz5Xej23S4lKqdDSKGR
         xrvKN4xT2bt9eNZGV8eoYB80NyWVJkBbRjJ4u0QseyECiSSqoYgmCOsTpGkF9g5LgyEB
         yc9eIU/PBM6cUwRVKKia3N7zEEA3ymtHrvJyMclv2fYspQoTiZOh9czNGePCw0cC1Im/
         HYIGM/JPLxsM9tGvm85Ui10+u2f5SJSYBip755fDPDokJCBXlUL2JgE+R+MwNSPSi8dl
         67hA==
X-Gm-Message-State: AOAM533rQltEuARatIOaVUEcvVoBIpLNnEZN6/4YWE0cp1fRJHz3aqfg
        ICVU3GyCsGzdg71lFvpHVJocAcZs8SxqhkkHHf4HWr+TVN1W
X-Google-Smtp-Source: ABdhPJwPSv/Dr9O0bZCb5tx+CFRrUYO95moaJpBD93D8XaehdedfWCzl0XYKMTV/kdNh+11kDdcvOYUn87MlaCGT7Y6WFVvRJBMI
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1242:: with SMTP id j2mr6195897ilq.303.1591850894922;
 Wed, 10 Jun 2020 21:48:14 -0700 (PDT)
Date:   Wed, 10 Jun 2020 21:48:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000209d7205a7c7ab09@google.com>
Subject: INFO: task hung in do_truncate (2)
From:   syzbot <syzbot+18b2ab4c697021ee8369@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150f2961100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
dashboard link: https://syzkaller.appspot.com/bug?extid=18b2ab4c697021ee8369
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cec296100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153a741e100000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1111e2c1100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1311e2c1100000
console output: https://syzkaller.appspot.com/x/log.txt?x=1511e2c1100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+18b2ab4c697021ee8369@syzkaller.appspotmail.com

INFO: task syz-executor283:6874 blocked for more than 143 seconds.
      Not tainted 5.7.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor283 D28400  6874   6804 0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3430 [inline]
 __schedule+0x8f3/0x1fc0 kernel/sched/core.c:4156
 schedule+0xd0/0x2a0 kernel/sched/core.c:4231
 rwsem_down_write_slowpath+0x706/0xf90 kernel/locking/rwsem.c:1235
 __down_write kernel/locking/rwsem.c:1389 [inline]
 down_write+0x137/0x150 kernel/locking/rwsem.c:1532
 inode_lock include/linux/fs.h:799 [inline]
 do_truncate+0x125/0x1f0 fs/open.c:62
 handle_truncate fs/namei.c:2887 [inline]
 do_open fs/namei.c:3233 [inline]
 path_openat+0x1f28/0x27d0 fs/namei.c:3346
 do_filp_open+0x192/0x260 fs/namei.c:3373
 do_sys_openat2+0x585/0x7d0 fs/open.c:1179
 do_sys_open+0xc3/0x140 fs/open.c:1195
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x4468f9
Code: Bad RIP value.
RSP: 002b:00007f3df9c40db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 00000000004468f9
RDX: 000000000000275a RSI: 00000000200001c0 RDI: 00000000ffffff9c
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffe3e295ecf R14: 00007f3df9c419c0 R15: 0000000000000000
INFO: task syz-executor283:6877 blocked for more than 143 seconds.
      Not tainted 5.7.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor283 D28400  6877   6805 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3430 [inline]
 __schedule+0x8f3/0x1fc0 kernel/sched/core.c:4156
 schedule+0xd0/0x2a0 kernel/sched/core.c:4231
 rwsem_down_write_slowpath+0x706/0xf90 kernel/locking/rwsem.c:1235
 __down_write kernel/locking/rwsem.c:1389 [inline]
 down_write+0x137/0x150 kernel/locking/rwsem.c:1532
 inode_lock include/linux/fs.h:799 [inline]
 process_measurement+0x15ec/0x1750 security/integrity/ima/ima_main.c:228
 ima_file_check+0xb9/0x100 security/integrity/ima/ima_main.c:440
 do_open fs/namei.c:3231 [inline]
 path_openat+0x1997/0x27d0 fs/namei.c:3346
 do_filp_open+0x192/0x260 fs/namei.c:3373
 do_sys_openat2+0x585/0x7d0 fs/open.c:1179
 do_sys_open+0xc3/0x140 fs/open.c:1195
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x4468f9
Code: Bad RIP value.
RSP: 002b:00007f3df9c40db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 00000000004468f9
RDX: 000000000000275a RSI: 00000000200001c0 RDI: 00000000ffffff9c
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffe3e295ecf R14: 00007f3df9c419c0 R15: 0000000000000000
INFO: task syz-executor283:6880 blocked for more than 144 seconds.
      Not tainted 5.7.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor283 D28400  6880   6803 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3430 [inline]
 __schedule+0x8f3/0x1fc0 kernel/sched/core.c:4156
 schedule+0xd0/0x2a0 kernel/sched/core.c:4231
 rwsem_down_write_slowpath+0x706/0xf90 kernel/locking/rwsem.c:1235
 __down_write kernel/locking/rwsem.c:1389 [inline]
 down_write+0x137/0x150 kernel/locking/rwsem.c:1532
 inode_lock include/linux/fs.h:799 [inline]
 process_measurement+0x15ec/0x1750 security/integrity/ima/ima_main.c:228
 ima_file_check+0xb9/0x100 security/integrity/ima/ima_main.c:440
 do_open fs/namei.c:3231 [inline]
 path_openat+0x1997/0x27d0 fs/namei.c:3346
 do_filp_open+0x192/0x260 fs/namei.c:3373
 do_sys_openat2+0x585/0x7d0 fs/open.c:1179
 do_sys_open+0xc3/0x140 fs/open.c:1195
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x4468f9
Code: Bad RIP value.
RSP: 002b:00007f3df9c40db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 00000000004468f9
RDX: 000000000000275a RSI: 00000000200001c0 RDI: 00000000ffffff9c
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffe3e295ecf R14: 00007f3df9c419c0 R15: 0000000000000000
INFO: task syz-executor283:6882 blocked for more than 144 seconds.
      Not tainted 5.7.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor283 D28400  6882   6800 0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3430 [inline]
 __schedule+0x8f3/0x1fc0 kernel/sched/core.c:4156
 schedule+0xd0/0x2a0 kernel/sched/core.c:4231
 rwsem_down_write_slowpath+0x706/0xf90 kernel/locking/rwsem.c:1235
 __down_write kernel/locking/rwsem.c:1389 [inline]
 down_write+0x137/0x150 kernel/locking/rwsem.c:1532
 inode_lock include/linux/fs.h:799 [inline]
 process_measurement+0x15ec/0x1750 security/integrity/ima/ima_main.c:228
 ima_file_check+0xb9/0x100 security/integrity/ima/ima_main.c:440
 do_open fs/namei.c:3231 [inline]
 path_openat+0x1997/0x27d0 fs/namei.c:3346
 do_filp_open+0x192/0x260 fs/namei.c:3373
 do_sys_openat2+0x585/0x7d0 fs/open.c:1179
 do_sys_open+0xc3/0x140 fs/open.c:1195
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x4468f9
Code: Bad RIP value.
RSP: 002b:00007f3df9c40db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 00000000004468f9
RDX: 000000000000275a RSI: 00000000200001c0 RDI: 00000000ffffff9c
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffe3e295ecf R14: 00007f3df9c419c0 R15: 0000000000000000
INFO: task syz-executor283:6889 blocked for more than 144 seconds.
      Not tainted 5.7.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor283 D28400  6889   6807 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3430 [inline]
 __schedule+0x8f3/0x1fc0 kernel/sched/core.c:4156
 schedule+0xd0/0x2a0 kernel/sched/core.c:4231
 rwsem_down_write_slowpath+0x706/0xf90 kernel/locking/rwsem.c:1235
 __down_write kernel/locking/rwsem.c:1389 [inline]
 down_write+0x137/0x150 kernel/locking/rwsem.c:1532
 inode_lock include/linux/fs.h:799 [inline]
 process_measurement+0x15ec/0x1750 security/integrity/ima/ima_main.c:228
 ima_file_check+0xb9/0x100 security/integrity/ima/ima_main.c:440
 do_open fs/namei.c:3231 [inline]
 path_openat+0x1997/0x27d0 fs/namei.c:3346
 do_filp_open+0x192/0x260 fs/namei.c:3373
 do_sys_openat2+0x585/0x7d0 fs/open.c:1179
 do_sys_open+0xc3/0x140 fs/open.c:1195
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x4468f9
Code: Bad RIP value.
RSP: 002b:00007f3df9c40db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 00000000004468f9
RDX: 000000000000275a RSI: 00000000200001c0 RDI: 00000000ffffff9c
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffe3e295ecf R14: 00007f3df9c419c0 R15: 0000000000000000
INFO: task syz-executor283:6890 blocked for more than 145 seconds.
      Not tainted 5.7.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor283 D28400  6890   6801 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3430 [inline]
 __schedule+0x8f3/0x1fc0 kernel/sched/core.c:4156
 schedule+0xd0/0x2a0 kernel/sched/core.c:4231
 rwsem_down_write_slowpath+0x706/0xf90 kernel/locking/rwsem.c:1235
 __down_write kernel/locking/rwsem.c:1389 [inline]
 down_write+0x137/0x150 kernel/locking/rwsem.c:1532
 inode_lock include/linux/fs.h:799 [inline]
 process_measurement+0x15ec/0x1750 security/integrity/ima/ima_main.c:228
 ima_file_check+0xb9/0x100 security/integrity/ima/ima_main.c:440
 do_open fs/namei.c:3231 [inline]
 path_openat+0x1997/0x27d0 fs/namei.c:3346
 do_filp_open+0x192/0x260 fs/namei.c:3373
 do_sys_openat2+0x585/0x7d0 fs/open.c:1179
 do_sys_open+0xc3/0x140 fs/open.c:1195
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x4468f9
Code: Bad RIP value.
RSP: 002b:00007f3df9c40db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 00000000004468f9
RDX: 000000000000275a RSI: 00000000200001c0 RDI: 00000000ffffff9c
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffe3e295ecf R14: 00007f3df9c419c0 R15: 0000000000000000

Showing all locks held in the system:
1 lock held by khungtaskd/1149:
 #0: ffffffff899bdd80 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:5779
1 lock held by in:imklog/6461:
 #0: ffff88809231e0f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:826
2 locks held by syz-executor283/6874:
 #0: ffff88809950a450 (sb_writers#3){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1661 [inline]
 #0: ffff88809950a450 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888086683a48 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
 #1: ffff888086683a48 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: do_truncate+0x125/0x1f0 fs/open.c:62
2 locks held by syz-executor283/6877:
 #0: ffff88809950a450 (sb_writers#3){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1661 [inline]
 #0: ffff88809950a450 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888086683a48 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
 #1: ffff888086683a48 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: process_measurement+0x15ec/0x1750 security/integrity/ima/ima_main.c:228
2 locks held by syz-executor283/6880:
 #0: ffff88809950a450 (sb_writers#3){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1661 [inline]
 #0: ffff88809950a450 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888086683a48 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
 #1: ffff888086683a48 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: process_measurement+0x15ec/0x1750 security/integrity/ima/ima_main.c:228
2 locks held by syz-executor283/6882:
 #0: ffff88809950a450 (sb_writers#3){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1661 [inline]
 #0: ffff88809950a450 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888086683a48 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
 #1: ffff888086683a48 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: process_measurement+0x15ec/0x1750 security/integrity/ima/ima_main.c:228
3 locks held by syz-executor283/6881:
 #0: ffff88809ef500f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:826
 #1: ffff88809950a450 (sb_writers#3){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2930 [inline]
 #1: ffff88809950a450 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x4cf/0x5d0 fs/read_write.c:558
 #2: ffff888086683a48 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
 #2: ffff888086683a48 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: ext4_buffered_write_iter+0xb3/0x450 fs/ext4/file.c:264
2 locks held by syz-executor283/6889:
 #0: ffff88809950a450 (sb_writers#3){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1661 [inline]
 #0: ffff88809950a450 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888086683a48 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
 #1: ffff888086683a48 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: process_measurement+0x15ec/0x1750 security/integrity/ima/ima_main.c:228
2 locks held by syz-executor283/6890:
 #0: ffff88809950a450 (sb_writers#3){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1661 [inline]
 #0: ffff88809950a450 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x3a/0xb0 fs/namespace.c:354
 #1: ffff888086683a48 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
 #1: ffff888086683a48 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: process_measurement+0x15ec/0x1750 security/integrity/ima/ima_main.c:228

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1149 Comm: khungtaskd Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x70/0xb1 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x1e6/0x221 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
 watchdog+0xa8c/0x1010 kernel/hung_task.c:289
 kthread+0x388/0x470 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:351
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:60


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
