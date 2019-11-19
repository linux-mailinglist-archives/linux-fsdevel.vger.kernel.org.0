Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D69F81023AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 12:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfKSLzJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 06:55:09 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:49488 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfKSLzI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:55:08 -0500
Received: by mail-il1-f200.google.com with SMTP id c2so19140944ilj.16
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2019 03:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=r1iyYZx86LfIf4jbtuaMKzNihWQlbKEsBXxuEuik3S8=;
        b=ogHY1gVLt4GePDwxpaFgRZWDKJUn56G3KF7XAWEddlMixC9JBiothTq5IrqAOy4G0w
         HOC2msxVpGmcMby2SefQPUZ37nMo6Xw919PQWkcMFZN8QHmrpBE9O/xYe0D0HZxDQzq6
         5ql3Ys+3xNZ9ZMmAqItxipb74k+gWTygJ3RY61Z+6oJBcJy8RPiSFeM34ZZNritEul/P
         I0UDz7tQR4lANp2CSbqweSyewilAdimZwAs1ggmwv9lkr3dsnvfqBOdIb3NlmR1M4Vv1
         CMe3jenieQKJta1ElriidkjVIPJ8ikOLRtpBhKSiQ2BdNxraPTYAUeLgDdrd2ml7iX8a
         IA2Q==
X-Gm-Message-State: APjAAAU8X73i8VtjtnxA+Hza/g+NxYiXltHVyHASUx6TEy38BzGpNhV3
        lKAtGRZMJtlYAMmTg7DCJ+6UkxBjvQg65NxI3HAyFSMBl1xe
X-Google-Smtp-Source: APXvYqwOVjZraiu/bXvxqfcYwS8bHzLHwuk0vgPTgMZ8k/zdZyL5hvymZ/xlheETkg167jAZ/yS82Zt8HP6q+Z20P3/TKRKcZD3z
MIME-Version: 1.0
X-Received: by 2002:a6b:18c1:: with SMTP id 184mr18151342ioy.40.1574164505748;
 Tue, 19 Nov 2019 03:55:05 -0800 (PST)
Date:   Tue, 19 Nov 2019 03:55:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ef1120597b1bc92@google.com>
Subject: possible deadlock in lock_trace (3)
From:   syzbot <syzbot+985c8a3c7f3668d31a49@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        casey@schaufler-ca.com, christian@brauner.io, guro@fb.com,
        kent.overstreet@gmail.com, khlebnikov@yandex-team.ru,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5a6fcbea Add linux-next specific files for 20191115
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=127ba426e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8eac90e6ae4ab399
dashboard link: https://syzkaller.appspot.com/bug?extid=985c8a3c7f3668d31a49
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+985c8a3c7f3668d31a49@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.4.0-rc7-next-20191115 #0 Not tainted
------------------------------------------------------
syz-executor.3/3829 is trying to acquire lock:
ffff888096981810 (&sig->cred_guard_mutex){+.+.}, at: lock_trace+0x4a/0xe0  
fs/proc/base.c:406

but task is already holding lock:
ffff88809611df40 (&p->lock){+.+.}, at: seq_read+0x71/0x1170  
fs/seq_file.c:161

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&p->lock){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:959 [inline]
        __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1106
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1121
        seq_read+0x71/0x1170 fs/seq_file.c:161
        do_loop_readv_writev fs/read_write.c:714 [inline]
        do_loop_readv_writev fs/read_write.c:701 [inline]
        do_iter_read+0x4a4/0x660 fs/read_write.c:935
        vfs_readv+0xf0/0x160 fs/read_write.c:997
        kernel_readv fs/splice.c:359 [inline]
        default_file_splice_read+0x482/0x8a0 fs/splice.c:414
        do_splice_to+0x127/0x180 fs/splice.c:877
        splice_direct_to_actor+0x2d3/0x970 fs/splice.c:955
        do_splice_direct+0x1da/0x2a0 fs/splice.c:1064
        do_sendfile+0x597/0xd00 fs/read_write.c:1464
        __do_sys_sendfile64 fs/read_write.c:1525 [inline]
        __se_sys_sendfile64 fs/read_write.c:1511 [inline]
        __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1511
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #3 (sb_writers#3){.+.+}:
        percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
        __sb_start_write+0x241/0x460 fs/super.c:1672
        sb_start_write include/linux/fs.h:1650 [inline]
        mnt_want_write+0x3f/0xc0 fs/namespace.c:354
        ovl_want_write+0x76/0xa0 fs/overlayfs/util.c:21
        ovl_xattr_set+0x53/0x5b0 fs/overlayfs/inode.c:329
        ovl_posix_acl_xattr_set+0x33a/0x9a0 fs/overlayfs/super.c:910
        __vfs_setxattr+0x11f/0x180 fs/xattr.c:150
        __vfs_setxattr_noperm+0x11c/0x410 fs/xattr.c:181
        vfs_setxattr+0xda/0x100 fs/xattr.c:224
        setxattr+0x26f/0x380 fs/xattr.c:451
        path_setxattr+0x197/0x1b0 fs/xattr.c:470
        __do_sys_setxattr fs/xattr.c:485 [inline]
        __se_sys_setxattr fs/xattr.c:481 [inline]
        __x64_sys_setxattr+0xc4/0x150 fs/xattr.c:481
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (&ovl_i_mutex_dir_key[depth]){++++}:
        down_write_killable+0x96/0x170 kernel/locking/rwsem.c:1545
        iterate_dir+0x414/0x5e0 fs/readdir.c:57
        ovl_dir_read fs/overlayfs/readdir.c:309 [inline]
        ovl_dir_read_merged+0x199/0x500 fs/overlayfs/readdir.c:374
        ovl_cache_get fs/overlayfs/readdir.c:426 [inline]
        ovl_iterate+0x750/0xc50 fs/overlayfs/readdir.c:752
        iterate_dir+0x208/0x5e0 fs/readdir.c:67
        ksys_getdents64+0x1ce/0x320 fs/readdir.c:372
        __do_sys_getdents64 fs/readdir.c:391 [inline]
        __se_sys_getdents64 fs/readdir.c:388 [inline]
        __x64_sys_getdents64+0x73/0xb0 fs/readdir.c:388
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&ovl_i_mutex_dir_key[depth]#2){++++}:
        down_read+0x95/0x430 kernel/locking/rwsem.c:1495
        inode_lock_shared include/linux/fs.h:801 [inline]
        lookup_slow+0x4a/0x80 fs/namei.c:1683
        walk_component+0x747/0x1ff0 fs/namei.c:1804
        lookup_last fs/namei.c:2267 [inline]
        path_lookupat.isra.0+0x1f5/0x8d0 fs/namei.c:2312
        filename_lookup+0x1b0/0x3f0 fs/namei.c:2342
        kern_path+0x36/0x40 fs/namei.c:2428
        create_local_trace_uprobe+0x87/0x4a0 kernel/trace/trace_uprobe.c:1542
        perf_uprobe_init+0x131/0x210 kernel/trace/trace_event_perf.c:323
        perf_uprobe_event_init+0x106/0x1a0 kernel/events/core.c:9138
        perf_try_init_event+0x135/0x590 kernel/events/core.c:10438
        perf_init_event kernel/events/core.c:10490 [inline]
        perf_event_alloc.part.0+0x14ed/0x3600 kernel/events/core.c:10773
        perf_event_alloc kernel/events/core.c:11140 [inline]
        __do_sys_perf_event_open+0x6f8/0x2be0 kernel/events/core.c:11256
        __se_sys_perf_event_open kernel/events/core.c:11130 [inline]
        __x64_sys_perf_event_open+0xbe/0x150 kernel/events/core.c:11130
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&sig->cred_guard_mutex){+.+.}:
        check_prev_add kernel/locking/lockdep.c:2476 [inline]
        check_prevs_add kernel/locking/lockdep.c:2581 [inline]
        validate_chain kernel/locking/lockdep.c:2971 [inline]
        __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3955
        lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
        __mutex_lock_common kernel/locking/mutex.c:959 [inline]
        __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1106
        mutex_lock_killable_nested+0x16/0x20 kernel/locking/mutex.c:1136
        lock_trace+0x4a/0xe0 fs/proc/base.c:406
        proc_pid_syscall+0x8a/0x220 fs/proc/base.c:635
        proc_single_show+0xf0/0x170 fs/proc/base.c:756
        seq_read+0x4ca/0x1170 fs/seq_file.c:229
        do_loop_readv_writev fs/read_write.c:714 [inline]
        do_loop_readv_writev fs/read_write.c:701 [inline]
        do_iter_read+0x4a4/0x660 fs/read_write.c:935
        vfs_readv+0xf0/0x160 fs/read_write.c:997
        do_preadv+0x1c4/0x280 fs/read_write.c:1089
        __do_sys_preadv fs/read_write.c:1139 [inline]
        __se_sys_preadv fs/read_write.c:1134 [inline]
        __x64_sys_preadv+0x9a/0xf0 fs/read_write.c:1134
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   &sig->cred_guard_mutex --> sb_writers#3 --> &p->lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&p->lock);
                                lock(sb_writers#3);
                                lock(&p->lock);
   lock(&sig->cred_guard_mutex);

  *** DEADLOCK ***

1 lock held by syz-executor.3/3829:
  #0: ffff88809611df40 (&p->lock){+.+.}, at: seq_read+0x71/0x1170  
fs/seq_file.c:161

stack backtrace:
CPU: 0 PID: 3829 Comm: syz-executor.3 Not tainted 5.4.0-rc7-next-20191115 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_circular_bug.isra.0.cold+0x163/0x172 kernel/locking/lockdep.c:1685
  check_noncircular+0x32e/0x3e0 kernel/locking/lockdep.c:1809
  check_prev_add kernel/locking/lockdep.c:2476 [inline]
  check_prevs_add kernel/locking/lockdep.c:2581 [inline]
  validate_chain kernel/locking/lockdep.c:2971 [inline]
  __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3955
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
  __mutex_lock_common kernel/locking/mutex.c:959 [inline]
  __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1106
  mutex_lock_killable_nested+0x16/0x20 kernel/locking/mutex.c:1136
  lock_trace+0x4a/0xe0 fs/proc/base.c:406
  proc_pid_syscall+0x8a/0x220 fs/proc/base.c:635
  proc_single_show+0xf0/0x170 fs/proc/base.c:756
  seq_read+0x4ca/0x1170 fs/seq_file.c:229
  do_loop_readv_writev fs/read_write.c:714 [inline]
  do_loop_readv_writev fs/read_write.c:701 [inline]
  do_iter_read+0x4a4/0x660 fs/read_write.c:935
  vfs_readv+0xf0/0x160 fs/read_write.c:997
  do_preadv+0x1c4/0x280 fs/read_write.c:1089
  __do_sys_preadv fs/read_write.c:1139 [inline]
  __se_sys_preadv fs/read_write.c:1134 [inline]
  __x64_sys_preadv+0x9a/0xf0 fs/read_write.c:1134
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a659
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2247981c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000000045a659
RDX: 00000000000001e3 RSI: 00000000200013c0 RDI: 0000000000000004
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f22479826d4
R13: 00000000004c7ec1 R14: 00000000004dde10 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
