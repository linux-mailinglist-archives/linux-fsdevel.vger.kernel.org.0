Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 676E3B7FDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 19:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389883AbfISRTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 13:19:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45001 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731387AbfISRTI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:19:08 -0400
Received: by mail-io1-f69.google.com with SMTP id m3so6172433ion.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2019 10:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HwRTRU2Wjj8KRJJIeSysNSucj+CZRmWal4KKTF7zgrU=;
        b=NZ7LuhtZ4fxrTwFy5x2ltWwbw1ZCId/bLcZRHWX1gkzhs/zJN/2x0Ji/n41M3gLsYX
         ml1Zx+iMiZobPiRvJ6Ez5v+ZKwtPetf6teH4zuBZasOKbQrvYYQXkCZLsaJw10p0SKHq
         cwEsfmVi4YPgebdK89D6VeG51awZKc+bdqG9tdJbqicmJv3Iz/osDufoQQFDnCfFQAgX
         0z72LO+u9DWkUW4ykIWUC+cvuufxY2yzz+AU2suWUb7WC5+Q7m1n417cYdITZ7Vo20l2
         2UlBLbCa2HTpvsbadE7F4BJSaY7akL2s7g4XTSFyKtjTvH3mQ3Ztcp71875Boeez3Alh
         psBw==
X-Gm-Message-State: APjAAAXheC8J1362BxLfQMWwYOphCwGsw5GZxnxqbwr222AZvSK4dLGP
        FZJKHQhrwLVnknWOgE/G0CGFzAez8IKq6VEW0EnXsTWWyprU
X-Google-Smtp-Source: APXvYqyis5rSh2SvgEiwig9CNxWCRm6jNI4dEZ0AMuY2gZ4gi+MuAFeAHrdcDi6hZhSEh3uyTGcKjsAogrUF3r8gEzDfmZVgiBDd
MIME-Version: 1.0
X-Received: by 2002:a6b:f40f:: with SMTP id i15mr6054783iog.244.1568913547354;
 Thu, 19 Sep 2019 10:19:07 -0700 (PDT)
Date:   Thu, 19 Sep 2019 10:19:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac6a360592eb26c1@google.com>
Subject: INFO: task hung in pipe_write (2)
From:   syzbot <syzbot+3c01db6025f26530cf8d@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, darrick.wong@oracle.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    288b9117 Add linux-next specific files for 20190918
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17e86645600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6126e51304ef1c3
dashboard link: https://syzkaller.appspot.com/bug?extid=3c01db6025f26530cf8d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11855769600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143580a1600000

The bug was bisected to:

commit cfb864757d8690631aadf1c4b80022c18ae865b3
Author: Darrick J. Wong <darrick.wong@oracle.com>
Date:   Tue Sep 17 16:05:22 2019 +0000

     splice: only read in as much information as there is pipe buffer space

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=150a7455600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=170a7455600000
console output: https://syzkaller.appspot.com/x/log.txt?x=130a7455600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3c01db6025f26530cf8d@syzkaller.appspotmail.com
Fixes: cfb864757d86 ("splice: only read in as much information as there is  
pipe buffer space")

INFO: task syz-executor623:8754 can't die for more than 143 seconds.
syz-executor623 D26888  8754   8751 0x00004004
Call Trace:
  context_switch kernel/sched/core.c:3384 [inline]
  __schedule+0x828/0x1c20 kernel/sched/core.c:4065
  schedule+0xd9/0x260 kernel/sched/core.c:4132
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4191
  __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
  __mutex_lock+0x7b0/0x13c0 kernel/locking/mutex.c:1103
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
  pipe_lock_nested fs/pipe.c:63 [inline]
  pipe_lock fs/pipe.c:71 [inline]
  pipe_wait+0x1ce/0x1f0 fs/pipe.c:119
  pipe_write+0x5fa/0xf40 fs/pipe.c:497
  call_write_iter include/linux/fs.h:1902 [inline]
  new_sync_write+0x4d3/0x770 fs/read_write.c:483
  __vfs_write+0xe1/0x110 fs/read_write.c:496
  vfs_write+0x268/0x5d0 fs/read_write.c:558
  ksys_write+0x14f/0x290 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445909
Code: ff 11 7a fd ff 11 7a fd ff 11 7a fd ff 11 7a fd ff 11 7a fd ff 11 7a  
fd ff 11 7a fd ff 11 7a fd ff 11 7a fd ff 11 7a fd ff 11 <7a> fd ff 11 7a  
fd ff 11 7a fd ff 11 7a fd ff 11 7a fd ff 11 7a fd
RSP: 002b:00007f9271abddb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000006dac68 RCX: 0000000000445909
RDX: 00000000fffffc8f RSI: 0000000020000140 RDI: 0000000000000007
RBP: 00000000006dac60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac6c
R13: 00007ffc2974a61f R14: 00007f9271abe9c0 R15: 20c49ba5e353f7cf
INFO: task syz-executor623:8754 blocked for more than 143 seconds.
       Not tainted 5.3.0-next-20190918 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor623 D26888  8754   8751 0x00004004
Call Trace:
  context_switch kernel/sched/core.c:3384 [inline]
  __schedule+0x828/0x1c20 kernel/sched/core.c:4065
  schedule+0xd9/0x260 kernel/sched/core.c:4132
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4191
  __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
  __mutex_lock+0x7b0/0x13c0 kernel/locking/mutex.c:1103
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
  pipe_lock_nested fs/pipe.c:63 [inline]
  pipe_lock fs/pipe.c:71 [inline]
  pipe_wait+0x1ce/0x1f0 fs/pipe.c:119
  pipe_write+0x5fa/0xf40 fs/pipe.c:497
  call_write_iter include/linux/fs.h:1902 [inline]
  new_sync_write+0x4d3/0x770 fs/read_write.c:483
  __vfs_write+0xe1/0x110 fs/read_write.c:496
  vfs_write+0x268/0x5d0 fs/read_write.c:558
  ksys_write+0x14f/0x290 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445909
Code: ff 11 7a fd ff 11 7a fd ff 11 7a fd ff 11 7a fd ff 11 7a fd ff 11 7a  
fd ff 11 7a fd ff 11 7a fd ff 11 7a fd ff 11 7a fd ff 11 <7a> fd ff 11 7a  
fd ff 11 7a fd ff 11 7a fd ff 11 7a fd ff 11 7a fd
RSP: 002b:00007f9271abddb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000006dac68 RCX: 0000000000445909
RDX: 00000000fffffc8f RSI: 0000000020000140 RDI: 0000000000000007
RBP: 00000000006dac60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac6c
R13: 00007ffc2974a61f R14: 00007f9271abe9c0 R15: 20c49ba5e353f7cf
INFO: task syz-executor623:8755 can't die for more than 143 seconds.
syz-executor623 R  running task    24984  8755   8751 0x00004006
Call Trace:

Showing all locks held in the system:
1 lock held by khungtaskd/1053:
  #0: ffffffff88fa9e80 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x27e kernel/locking/lockdep.c:5337
3 locks held by rs:main Q:Reg/8635:
  #0: ffff8880ae8348d8 (&rq->lock){-.-.}, at: rq_lock  
kernel/sched/sched.h:1211 [inline]
  #0: ffff8880ae8348d8 (&rq->lock){-.-.}, at: __schedule+0x269/0x1c20  
kernel/sched/core.c:4017
  #1: ffff888215ea0420 (sb_writers#3){.+.+}, at: file_start_write  
include/linux/fs.h:2886 [inline]
  #1: ffff888215ea0420 (sb_writers#3){.+.+}, at: vfs_write+0x485/0x5d0  
fs/read_write.c:557
  #2: ffff8880a29e44c8 (&sb->s_type->i_mutex_key#11){+.+.}, at:  
inode_trylock include/linux/fs.h:811 [inline]
  #2: ffff8880a29e44c8 (&sb->s_type->i_mutex_key#11){+.+.}, at:  
ext4_file_write_iter+0x220/0x13c0 fs/ext4/file.c:234
1 lock held by rsyslogd/8637:
  #0: ffff888095eac360 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by getty/8727:
  #0: ffff8880a16fa090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f1d2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8728:
  #0: ffff8880a2fbc090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f2d2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8729:
  #0: ffff888099709090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f252e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8730:
  #0: ffff888097c40090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f292e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8731:
  #0: ffff888092f46090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f212e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8732:
  #0: ffff8880a1ee2090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f312e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8733:
  #0: ffff88809259e090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005ef92e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
1 lock held by syz-executor623/8754:
  #0: ffff8880a9010c60 (&pipe->mutex/1){+.+.}, at: pipe_lock_nested  
fs/pipe.c:63 [inline]
  #0: ffff8880a9010c60 (&pipe->mutex/1){+.+.}, at: pipe_lock fs/pipe.c:71  
[inline]
  #0: ffff8880a9010c60 (&pipe->mutex/1){+.+.}, at: pipe_wait+0x1ce/0x1f0  
fs/pipe.c:119
3 locks held by syz-executor623/8755:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1053 Comm: khungtaskd Not tainted 5.3.0-next-20190918 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x70/0xb2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x23b/0x28b lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:269 [inline]
  watchdog+0xc99/0x1360 kernel/hung_task.c:353
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 8755 Comm: syz-executor623 Not tainted 5.3.0-next-20190918 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:write_comp_data+0x1e/0x70 kernel/kcov.c:123
Code: 48 89 34 d1 48 89 11 5d c3 0f 1f 00 65 4c 8b 04 25 40 fe 01 00 65 8b  
05 38 28 8f 7e a9 00 01 1f 00 75 51 41 8b 80 00 13 00 00 <83> f8 03 75 45  
49 8b 80 08 13 00 00 45 8b 80 04 13 00 00 4c 8b 08
RSP: 0018:ffff88809497f350 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83402d29
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffff88809497f358 R08: ffff88808d88e4c0 R09: ffffffff81f9dca0
R10: ffff88809497f730 R11: ffff888095581297 R12: 0000000000000000
R13: 000000000000f000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f9271a9d700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 000000008db14000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  bvec_iter_advance include/linux/bvec.h:96 [inline]
  bvec_iter_advance include/linux/bvec.h:87 [inline]
  iov_iter_alignment+0x5d9/0x830 lib/iov_iter.c:1200
  do_blockdev_direct_IO+0x1dd/0x8420 fs/direct-io.c:1181
  __blockdev_direct_IO+0xa1/0xca fs/direct-io.c:1413
  ext4_direct_IO_write fs/ext4/inode.c:3742 [inline]
  ext4_direct_IO+0xd60/0x1c30 fs/ext4/inode.c:3871
  generic_file_direct_write+0x20a/0x4a0 mm/filemap.c:3207
  __generic_file_write_iter+0x2ee/0x630 mm/filemap.c:3390
  ext4_file_write_iter+0x317/0x13c0 fs/ext4/file.c:268
  call_write_iter include/linux/fs.h:1902 [inline]
  do_iter_readv_writev+0x5f8/0x8f0 fs/read_write.c:693
  do_iter_write fs/read_write.c:970 [inline]
  do_iter_write+0x184/0x610 fs/read_write.c:951
  vfs_iter_write+0x77/0xb0 fs/read_write.c:983
  iter_file_splice_write+0x66d/0xbe0 fs/splice.c:746
  do_splice_from fs/splice.c:848 [inline]
  do_splice+0x785/0x1540 fs/splice.c:1161
  __do_sys_splice fs/splice.c:1436 [inline]
  __se_sys_splice fs/splice.c:1416 [inline]
  __x64_sys_splice+0x2c6/0x330 fs/splice.c:1416
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445909
Code: e8 bc b7 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9271a9cda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00000000006dac78 RCX: 0000000000445909
RDX: 0000000000000008 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00000000006dac70 R08: 000100000000ffe0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac7c
R13: 00007ffc2974a61f R14: 00007f9271a9d9c0 R15: 20c49ba5e353f7cf


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
