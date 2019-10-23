Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9BBE1305
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 09:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389733AbfJWHZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 03:25:08 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:46027 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389118AbfJWHZI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:25:08 -0400
Received: by mail-io1-f72.google.com with SMTP id x8so6486431ion.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 00:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+ke/5pvEZ1OCG2Pj/p3NXXUgpoPPR+2t9C0yTNu8RM8=;
        b=CBPWE3T8oF5XPe1H/jplLVLViG7RuR00/AsuhjSDZV96X18p4NPl4q0UtB2jy/Hb5L
         yVEZq2KSVh9UhHk14XJIatLluRDpv/NSxQPQj/fCPoyrFt6j0dxHj1Buj6D204/8Rd/o
         lmd3pi0GESyCrZ07EkluJ0U6ewM2IFzdSC4kcVWHhCNCWhsW6nYWFLKCxiKZGiXS0Pp8
         5J2sIQRF5xUpT8ZG1HoJhXE7/A4N4Qt0WCs6hzItYwKObBpkl0NkxF8bD/8k+XiZ8/1L
         OkJp3Hh6sFx+67XCwevc2wdfN+vktstx17LnS0jQCuVAvN20IdrW+DmzZCXJZwtdC5HU
         oGRg==
X-Gm-Message-State: APjAAAWDpd5CTbU8weVJnszlbuW/e6ChRkCHsvP9ZAw8XI5Dy4pf2ZIB
        45AhnAUDSP/stMDxcC+hCxp0BXes+X/pFmFhvyQ9DHLyFFID
X-Google-Smtp-Source: APXvYqzpIp4kGf1aRpUorR51KAQ2Zs+q2Tupp7uReCAp1RJlOApjo41O4e/A008ukgL8gSs4cuEGuQxdqgATEumHqKpOKqG/rofw
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c8e:: with SMTP id b14mr37551168ile.16.1571815507310;
 Wed, 23 Oct 2019 00:25:07 -0700 (PDT)
Date:   Wed, 23 Oct 2019 00:25:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f74fa005958ed0fa@google.com>
Subject: INFO: task hung in vfs_unlink
From:   syzbot <syzbot+36feff43582f1f97716a@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d72e90f3 Linux 4.18-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104dc658400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68af3495408deac5
dashboard link: https://syzkaller.appspot.com/bug?extid=36feff43582f1f97716a
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+36feff43582f1f97716a@syzkaller.appspotmail.com

binder: 12679:12746 ioctl 40046207 0 returned -16
binder: 12679:12746 unknown command -565157109
binder: 12679:12746 ioctl c0306201 204edfd0 returned -22
binder: 12679:12743 unknown command 0
binder: 12679:12743 ioctl c0306201 20007000 returned -22
INFO: task syz-executor7:12738 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc6+ #160
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor7   D25832 12738   4599 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  __rwsem_down_write_failed_common+0x95d/0x1630  
kernel/locking/rwsem-xadd.c:566
  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0xaa/0x130 kernel/locking/rwsem.c:72
  inode_lock include/linux/fs.h:715 [inline]
  vfs_unlink+0xd1/0x510 fs/namei.c:4001
  do_unlinkat+0x6cc/0xa30 fs/namei.c:4073
  __do_sys_unlink fs/namei.c:4120 [inline]
  __se_sys_unlink fs/namei.c:4118 [inline]
  __x64_sys_unlink+0x42/0x50 fs/namei.c:4118
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455ab9
Code: e0 1f 48 89 04 24 e8 b6 6f fd ff e8 81 6a fd ff e8 5c 68 fd ff 48 8d  
05 23 cd 48 00 48 89 04 24 48 c7 44 24 08 1d 00 00 00 e8 <13> 5e fd ff 0f  
0b e8 8c 44 00 00 e9 07 f0 ff ff cc cc cc cc cc cc
RSP: 002b:00007f2301e2cc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007f2301e2d6d4 RCX: 0000000000455ab9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000300
RBP: 000000000072bf48 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c0088 R14: 00000000004d4350 R15: 0000000000000001
INFO: task syz-executor7:12740 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc6+ #160
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor7   D24216 12740   4599 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  __rwsem_down_write_failed_common+0x95d/0x1630  
kernel/locking/rwsem-xadd.c:566
  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0xaa/0x130 kernel/locking/rwsem.c:72
  inode_lock include/linux/fs.h:715 [inline]
  lock_mount+0x8c/0x2e0 fs/namespace.c:2088
  do_add_mount+0x27/0x370 fs/namespace.c:2465
  do_new_mount fs/namespace.c:2532 [inline]
  do_mount+0x193f/0x30e0 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455ab9
Code: e0 1f 48 89 04 24 e8 b6 6f fd ff e8 81 6a fd ff e8 5c 68 fd ff 48 8d  
05 23 cd 48 00 48 89 04 24 48 c7 44 24 08 1d 00 00 00 e8 <13> 5e fd ff 0f  
0b e8 8c 44 00 00 e9 07 f0 ff ff cc cc cc cc cc cc
RSP: 002b:00007f2301e0bc68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f2301e0c6d4 RCX: 0000000000455ab9
RDX: 0000000020000900 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 000000000072bff0 R08: 0000000020000380 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c0201 R14: 00000000004cfe50 R15: 0000000000000002
INFO: task syz-executor7:12742 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc6+ #160
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor7   D25408 12742   4599 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  __rwsem_down_write_failed_common+0x95d/0x1630  
kernel/locking/rwsem-xadd.c:566
  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0xaa/0x130 kernel/locking/rwsem.c:72
  inode_lock include/linux/fs.h:715 [inline]
  utimes_common.isra.1+0x45c/0x8e0 fs/utimes.c:90
  do_utimes+0x1f7/0x380 fs/utimes.c:156
  do_futimesat+0x249/0x350 fs/utimes.c:212
  __do_sys_utimes fs/utimes.c:225 [inline]
  __se_sys_utimes fs/utimes.c:222 [inline]
  __x64_sys_utimes+0x59/0x80 fs/utimes.c:222
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455ab9
Code: e0 1f 48 89 04 24 e8 b6 6f fd ff e8 81 6a fd ff e8 5c 68 fd ff 48 8d  
05 23 cd 48 00 48 89 04 24 48 c7 44 24 08 1d 00 00 00 e8 <13> 5e fd ff 0f  
0b e8 8c 44 00 00 e9 07 f0 ff ff cc cc cc cc cc cc
RSP: 002b:00007f2301deac68 EFLAGS: 00000246 ORIG_RAX: 00000000000000eb
RAX: ffffffffffffffda RBX: 00007f2301deb6d4 RCX: 0000000000455ab9
RDX: 0000000000000000 RSI: 00000000200002c0 RDI: 00000000200000c0
RBP: 000000000072c098 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c2735 R14: 00000000004d4410 R15: 0000000000000003
INFO: task syz-executor7:12744 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc6+ #160
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor7   D26504 12744   4599 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  __rwsem_down_write_failed_common+0x95d/0x1630  
kernel/locking/rwsem-xadd.c:566
  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write_nested+0xae/0x130 kernel/locking/rwsem.c:194
  inode_lock_nested include/linux/fs.h:750 [inline]
  do_unlinkat+0x3d8/0xa30 fs/namei.c:4059
  __do_sys_unlink fs/namei.c:4120 [inline]
  __se_sys_unlink fs/namei.c:4118 [inline]
  __x64_sys_unlink+0x42/0x50 fs/namei.c:4118
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455ab9
Code: e0 1f 48 89 04 24 e8 b6 6f fd ff e8 81 6a fd ff e8 5c 68 fd ff 48 8d  
05 23 cd 48 00 48 89 04 24 48 c7 44 24 08 1d 00 00 00 e8 <13> 5e fd ff 0f  
0b e8 8c 44 00 00 e9 07 f0 ff ff cc cc cc cc cc cc
RSP: 002b:00007f2301dc9c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007f2301dca6d4 RCX: 0000000000455ab9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000300
RBP: 000000000072c140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c0088 R14: 00000000004d4350 R15: 0000000000000004

Showing all locks held in the system:
1 lock held by khungtaskd/902:
  #0: 00000000b4fedee0 (rcu_read_lock){....}, at:  
debug_show_all_locks+0xd0/0x428 kernel/locking/lockdep.c:4461
1 lock held by rsyslogd/4458:
  #0: 00000000cd393d5f (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1bb/0x200  
fs/file.c:766
2 locks held by getty/4548:
  #0: 00000000900c6e8e (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000004ed6f2b2 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4549:
  #0: 000000004a7c6f30 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000950f14ac (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4550:
  #0: 00000000cd10982b (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000e9751603 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4551:
  #0: 000000000fcf93b3 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000fbe330db (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4552:
  #0: 00000000604559fd (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000736bec6e (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4553:
  #0: 00000000bbb8dd50 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 0000000051ed7442 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4554:
  #0: 00000000f0092d1e (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000e841c59b (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by syz-executor7/12668:
  #0: 00000000b9e8b92c (sb_writers#23){.+.+}, at: sb_start_write  
include/linux/fs.h:1554 [inline]
  #0: 00000000b9e8b92c (sb_writers#23){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:386
  #1: 000000000ea5b75f (&sb->s_type->i_mutex_key#25){++++}, at: inode_lock  
include/linux/fs.h:715 [inline]
  #1: 000000000ea5b75f (&sb->s_type->i_mutex_key#25){++++}, at:  
utimes_common.isra.1+0x45c/0x8e0 fs/utimes.c:90
3 locks held by syz-executor7/12738:
  #0: 00000000b9e8b92c (sb_writers#23){.+.+}, at: sb_start_write  
include/linux/fs.h:1554 [inline]
  #0: 00000000b9e8b92c (sb_writers#23){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:386
  #1: 000000005a55d485 (&sb->s_type->i_mutex_key#25/1){+.+.}, at:  
inode_lock_nested include/linux/fs.h:750 [inline]
  #1: 000000005a55d485 (&sb->s_type->i_mutex_key#25/1){+.+.}, at:  
do_unlinkat+0x3d8/0xa30 fs/namei.c:4059
  #2: 000000000ea5b75f (&sb->s_type->i_mutex_key#25){++++}, at: inode_lock  
include/linux/fs.h:715 [inline]
  #2: 000000000ea5b75f (&sb->s_type->i_mutex_key#25){++++}, at:  
vfs_unlink+0xd1/0x510 fs/namei.c:4001
1 lock held by syz-executor7/12740:
  #0: 000000005a55d485 (&sb->s_type->i_mutex_key#25){++++}, at: inode_lock  
include/linux/fs.h:715 [inline]
  #0: 000000005a55d485 (&sb->s_type->i_mutex_key#25){++++}, at:  
lock_mount+0x8c/0x2e0 fs/namespace.c:2088
2 locks held by syz-executor7/12742:
  #0: 00000000b9e8b92c (sb_writers#23){.+.+}, at: sb_start_write  
include/linux/fs.h:1554 [inline]
  #0: 00000000b9e8b92c (sb_writers#23){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:386
  #1: 000000000ea5b75f (&sb->s_type->i_mutex_key#25){++++}, at: inode_lock  
include/linux/fs.h:715 [inline]
  #1: 000000000ea5b75f (&sb->s_type->i_mutex_key#25){++++}, at:  
utimes_common.isra.1+0x45c/0x8e0 fs/utimes.c:90
2 locks held by syz-executor7/12744:
  #0: 00000000b9e8b92c (sb_writers#23){.+.+}, at: sb_start_write  
include/linux/fs.h:1554 [inline]
  #0: 00000000b9e8b92c (sb_writers#23){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:386
  #1: 000000005a55d485 (&sb->s_type->i_mutex_key#25/1){+.+.}, at:  
inode_lock_nested include/linux/fs.h:750 [inline]
  #1: 000000005a55d485 (&sb->s_type->i_mutex_key#25/1){+.+.}, at:  
do_unlinkat+0x3d8/0xa30 fs/namei.c:4059

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 902 Comm: khungtaskd Not tainted 4.18.0-rc6+ #160
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:196 [inline]
  watchdog+0x9c4/0xf80 kernel/hung_task.c:252
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0x6/0x10  
arch/x86/include/asm/irqflags.h:54


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
