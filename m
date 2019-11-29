Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0AA10D018
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 01:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfK2AFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 19:05:08 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:49216 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfK2AFH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 19:05:07 -0500
Received: by mail-io1-f70.google.com with SMTP id w12so19059547ioa.16
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 16:05:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VDTR1lCTWksadLk3KUYhETZt2C7oIh39QbXFeN5+0Z0=;
        b=qgewfaVwLPaU/y43bki+FIVyJL2J1DIDvLO3jyWE7Guwvs+S5ESmoCckPrvK3uUjKh
         oteuuz7a/a7gm6OLiN25hHMuL+NyXPQEDbKNMDeS16W+8clb/4+hdBPatiOABORKJSAR
         s9GA5HAtZNkxhpCdsHZ1eXMNSaJgQEaDwoK+8QNSYQQVLqDafnIlOI0sV5g+v2o4+q6b
         2F3YRg/6qsYsiOLPE88wy3er9LOJBjRS6DQUezC+Ozxa7RqFHqBjPWH6YPNXL88l9rS6
         kMSd2cLUc5iaesDBRegikGmxV90FP8dXHX7JFmHZ4schT/Bv/Mj0BnDTWJxR2A5tMbE1
         blcA==
X-Gm-Message-State: APjAAAX62tlG4MwNfUopZoXzbKjK0R5evSWoQSS08UpmgxvUyEYMReNW
        dLMNVNUvXUXfHv3paGPGLo/1bTn2l/73VEW9kB8eGnXssv0O
X-Google-Smtp-Source: APXvYqxqpZ2cmRSwqqjgQbImoIAu/Pl1tWYO9+5LfpduBx2n2kFEinHnK9d2wagm7RVurL1x+KyqRNZMk6XtpDvjsNcaqm9kr8g+
MIME-Version: 1.0
X-Received: by 2002:a02:a0cf:: with SMTP id i15mr12391279jah.95.1574985906107;
 Thu, 28 Nov 2019 16:05:06 -0800 (PST)
Date:   Thu, 28 Nov 2019 16:05:06 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075c6e5059870fb7d@google.com>
Subject: possible deadlock in lookup_slow (2)
From:   syzbot <syzbot+4821b50cc2e4bd1d0d10@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    89d57ddd Merge tag 'media/v5.5-1' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=172becbce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=595c15c951695d1b
dashboard link: https://syzkaller.appspot.com/bug?extid=4821b50cc2e4bd1d0d10
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4821b50cc2e4bd1d0d10@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.4.0-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.3/23269 is trying to acquire lock:
ffff888092b3e6d0 (&ovl_i_mutex_dir_key[depth]#2){++++}, at:  
inode_lock_shared include/linux/fs.h:801 [inline]
ffff888092b3e6d0 (&ovl_i_mutex_dir_key[depth]#2){++++}, at:  
lookup_slow+0x4a/0x80 fs/namei.c:1679

but task is already holding lock:
ffff88805aa057d0 (&sig->cred_guard_mutex){+.+.}, at:  
__do_sys_perf_event_open+0xeaa/0x2c70 kernel/events/core.c:11257

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&sig->cred_guard_mutex){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:959 [inline]
        __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1106
        mutex_lock_killable_nested+0x16/0x20 kernel/locking/mutex.c:1136
        do_io_accounting+0x1f4/0x820 fs/proc/base.c:2773
        proc_tgid_io_accounting+0x23/0x30 fs/proc/base.c:2822
        proc_single_show+0xfd/0x1c0 fs/proc/base.c:756
        seq_read+0x4ca/0x1110 fs/seq_file.c:229
        do_loop_readv_writev fs/read_write.c:714 [inline]
        do_loop_readv_writev fs/read_write.c:701 [inline]
        do_iter_read+0x4a4/0x660 fs/read_write.c:935
        vfs_readv+0xf0/0x160 fs/read_write.c:997
        kernel_readv fs/splice.c:359 [inline]
        default_file_splice_read+0x482/0x8a0 fs/splice.c:414
        do_splice_to+0x127/0x180 fs/splice.c:877
        splice_direct_to_actor+0x2d2/0x970 fs/splice.c:954
        do_splice_direct+0x1da/0x2a0 fs/splice.c:1063
        do_sendfile+0x597/0xd00 fs/read_write.c:1464
        __do_sys_sendfile64 fs/read_write.c:1525 [inline]
        __se_sys_sendfile64 fs/read_write.c:1511 [inline]
        __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1511
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #3 (&p->lock){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:959 [inline]
        __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1106
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1121
        seq_read+0x71/0x1110 fs/seq_file.c:161
        proc_reg_read+0x1fc/0x2c0 fs/proc/inode.c:223
        do_loop_readv_writev fs/read_write.c:714 [inline]
        do_loop_readv_writev fs/read_write.c:701 [inline]
        do_iter_read+0x4a4/0x660 fs/read_write.c:935
        vfs_readv+0xf0/0x160 fs/read_write.c:997
        kernel_readv fs/splice.c:359 [inline]
        default_file_splice_read+0x482/0x8a0 fs/splice.c:414
        do_splice_to+0x127/0x180 fs/splice.c:877
        splice_direct_to_actor+0x2d2/0x970 fs/splice.c:954
        do_splice_direct+0x1da/0x2a0 fs/splice.c:1063
        do_sendfile+0x597/0xd00 fs/read_write.c:1464
        __do_sys_sendfile64 fs/read_write.c:1525 [inline]
        __se_sys_sendfile64 fs/read_write.c:1511 [inline]
        __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1511
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (sb_writers#4){.+.+}:
        percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
        __sb_start_write+0x241/0x460 fs/super.c:1672
        sb_start_write include/linux/fs.h:1650 [inline]
        mnt_want_write+0x3f/0xc0 fs/namespace.c:354
        ovl_want_write+0x76/0xa0 fs/overlayfs/util.c:21
        ovl_create_object+0xb3/0x2c0 fs/overlayfs/dir.c:596
        ovl_create+0x28/0x30 fs/overlayfs/dir.c:627
        lookup_open+0x12d5/0x1a90 fs/namei.c:3224
        do_last fs/namei.c:3314 [inline]
        path_openat+0x14a7/0x46d0 fs/namei.c:3525
        do_filp_open+0x1a1/0x280 fs/namei.c:3555
        do_sys_open+0x3fe/0x5d0 fs/open.c:1097
        ksys_open include/linux/syscalls.h:1385 [inline]
        __do_sys_creat fs/open.c:1155 [inline]
        __se_sys_creat fs/open.c:1153 [inline]
        __x64_sys_creat+0x61/0x80 fs/open.c:1153
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&ovl_i_mutex_dir_key[depth]){++++}:
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

-> #0 (&ovl_i_mutex_dir_key[depth]#2){++++}:
        check_prev_add kernel/locking/lockdep.c:2476 [inline]
        check_prevs_add kernel/locking/lockdep.c:2581 [inline]
        validate_chain kernel/locking/lockdep.c:2971 [inline]
        __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3955
        lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
        down_read+0x95/0x430 kernel/locking/rwsem.c:1495
        inode_lock_shared include/linux/fs.h:801 [inline]
        lookup_slow+0x4a/0x80 fs/namei.c:1679
        walk_component+0x747/0x1ff0 fs/namei.c:1800
        lookup_last fs/namei.c:2263 [inline]
        path_lookupat.isra.0+0x1f5/0x8d0 fs/namei.c:2308
        filename_lookup+0x1b0/0x3f0 fs/namei.c:2338
        kern_path+0x36/0x40 fs/namei.c:2424
        create_local_trace_uprobe+0x87/0x4a0 kernel/trace/trace_uprobe.c:1542
        perf_uprobe_init+0x131/0x210 kernel/trace/trace_event_perf.c:323
        perf_uprobe_event_init+0x106/0x1a0 kernel/events/core.c:9162
        perf_try_init_event+0x135/0x590 kernel/events/core.c:10462
        perf_init_event kernel/events/core.c:10514 [inline]
        perf_event_alloc.part.0+0x1571/0x3720 kernel/events/core.c:10794
        perf_event_alloc kernel/events/core.c:10676 [inline]
        __do_sys_perf_event_open+0x6f8/0x2c70 kernel/events/core.c:11277
        __se_sys_perf_event_open kernel/events/core.c:11151 [inline]
        __x64_sys_perf_event_open+0xbe/0x150 kernel/events/core.c:11151
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   &ovl_i_mutex_dir_key[depth]#2 --> &p->lock --> &sig->cred_guard_mutex

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&sig->cred_guard_mutex);
                                lock(&p->lock);
                                lock(&sig->cred_guard_mutex);
   lock(&ovl_i_mutex_dir_key[depth]#2);

  *** DEADLOCK ***

2 locks held by syz-executor.3/23269:
  #0: ffff88805aa057d0 (&sig->cred_guard_mutex){+.+.}, at:  
__do_sys_perf_event_open+0xeaa/0x2c70 kernel/events/core.c:11257
  #1: ffffffff8ad0e3e8 (&pmus_srcu){....}, at:  
perf_event_alloc.part.0+0xede/0x3720 kernel/events/core.c:10790

stack backtrace:
CPU: 0 PID: 23269 Comm: syz-executor.3 Not tainted 5.4.0-syzkaller #0
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
  down_read+0x95/0x430 kernel/locking/rwsem.c:1495
  inode_lock_shared include/linux/fs.h:801 [inline]
  lookup_slow+0x4a/0x80 fs/namei.c:1679
  walk_component+0x747/0x1ff0 fs/namei.c:1800
  lookup_last fs/namei.c:2263 [inline]
  path_lookupat.isra.0+0x1f5/0x8d0 fs/namei.c:2308
  filename_lookup+0x1b0/0x3f0 fs/namei.c:2338
  kern_path+0x36/0x40 fs/namei.c:2424
  create_local_trace_uprobe+0x87/0x4a0 kernel/trace/trace_uprobe.c:1542
  perf_uprobe_init+0x131/0x210 kernel/trace/trace_event_perf.c:323
  perf_uprobe_event_init+0x106/0x1a0 kernel/events/core.c:9162
  perf_try_init_event+0x135/0x590 kernel/events/core.c:10462
  perf_init_event kernel/events/core.c:10514 [inline]
  perf_event_alloc.part.0+0x1571/0x3720 kernel/events/core.c:10794
  perf_event_alloc kernel/events/core.c:10676 [inline]
  __do_sys_perf_event_open+0x6f8/0x2c70 kernel/events/core.c:11277
  __se_sys_perf_event_open kernel/events/core.c:11151 [inline]
  __x64_sys_perf_event_open+0xbe/0x150 kernel/events/core.c:11151
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a649
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff838acbc78 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 000000000045a649
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 00007ff838acc6d4
R13: 00000000004c7bb1 R14: 00000000004ddb90 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
