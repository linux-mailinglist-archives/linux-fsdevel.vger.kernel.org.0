Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E3613B508
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 23:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgANWEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 17:04:16 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:48445 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgANWEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 17:04:14 -0500
Received: by mail-il1-f199.google.com with SMTP id u14so11681483ilq.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2020 14:04:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3S9j3uq36gpvrhnH3ydXwg7I0WRc5NPGZffM/xDaOQ4=;
        b=HxQC+92dUVS8CnhYua3ozA+g2tGsEB6EhV2vX4HTd2N25RcKaVFTcwaJ5xo9Iu2Uoi
         n2PULSkQpcrLJh++55h8Oc7dhlyuC02iMcC7/3XzGgQ7zgFddcTjYJGwp2iGjw21suOc
         Uk8R0hAi1+PWO3ddxK4aGnTq+egdec/8Hwo/wn/wyJjwynVJSXgBMu+GasI6ODYSnAaN
         FKCqXXf+SLnrg/dAfhsPIhuUUXz/fxpr1H2l2zw+3l08no5YqWFuVmcJj1hdBtPbOeYP
         fo4QZiPnBt2GiD0zfu4oMeXktzj0U1dbejP873dsyRxO7Pa1WrSw8scdvutc1Sf2IUsD
         TDMA==
X-Gm-Message-State: APjAAAUGxACntrzG3bMONh/1BT3ifoitQBXHH6hNBoL6tGj9htpAxBUd
        w/RUzeNo4FM0UhnBLt1n82/hZuZh0m4ogmwqURFsptYml6fP
X-Google-Smtp-Source: APXvYqzGw7+E4Qb4MFTi8sqavJrANCW76Yc3mrQOOUjOJMiwlkeR/2ZHwvrF7c5DaAm/QvZ3i/RyhWMP5QoadwAoM6b53ReBqQpX
MIME-Version: 1.0
X-Received: by 2002:a92:d18a:: with SMTP id z10mr663613ilz.48.1579039453602;
 Tue, 14 Jan 2020 14:04:13 -0800 (PST)
Date:   Tue, 14 Jan 2020 14:04:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7f160059c20c5a9@google.com>
Subject: possible deadlock in proc_pid_stack
From:   syzbot <syzbot+c84a45dcab486e41c053@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        christian@brauner.io, guro@fb.com, kent.overstreet@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e033e7d4 Merge branch 'dhowells' (patches from DavidH)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1499533ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbb8fa33f49f9f3
dashboard link: https://syzkaller.appspot.com/bug?extid=c84a45dcab486e41c053
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/  
c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c84a45dcab486e41c053@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.5.0-rc6-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.5/21564 is trying to acquire lock:
ffff8880a29cdf10 (&sig->cred_guard_mutex){+.+.}, at: lock_trace  
fs/proc/base.c:406 [inline]
ffff8880a29cdf10 (&sig->cred_guard_mutex){+.+.}, at:  
proc_pid_stack+0xd9/0x200 fs/proc/base.c:450

but task is already holding lock:
ffff8880a8bb30a0 (&p->lock){+.+.}, at: seq_read+0x6b/0xdb0 fs/seq_file.c:161

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&p->lock){+.+.}:
        lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4485
        __mutex_lock_common+0x16e/0x2f30 kernel/locking/mutex.c:956
        __mutex_lock kernel/locking/mutex.c:1103 [inline]
        mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:1118
        seq_read+0x6b/0xdb0 fs/seq_file.c:161
        proc_reg_read+0x1d5/0x2e0 fs/proc/inode.c:223
        do_loop_readv_writev fs/read_write.c:714 [inline]
        do_iter_read+0x4a2/0x5b0 fs/read_write.c:935
        vfs_readv+0xc2/0x120 fs/read_write.c:997
        kernel_readv fs/splice.c:365 [inline]
        default_file_splice_read+0x579/0xa40 fs/splice.c:422
        do_splice_to fs/splice.c:892 [inline]
        splice_direct_to_actor+0x3c9/0xb90 fs/splice.c:971
        do_splice_direct+0x200/0x330 fs/splice.c:1080
        do_sendfile+0x7e4/0xfd0 fs/read_write.c:1464
        __do_sys_sendfile64 fs/read_write.c:1525 [inline]
        __se_sys_sendfile64 fs/read_write.c:1511 [inline]
        __x64_sys_sendfile64+0x176/0x1b0 fs/read_write.c:1511
        do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (sb_writers#3){.+.+}:
        lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4485
        percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
        __sb_start_write+0x189/0x420 fs/super.c:1674
        sb_start_write include/linux/fs.h:1650 [inline]
        mnt_want_write+0x4a/0xa0 fs/namespace.c:354
        ovl_want_write+0x77/0x80 fs/overlayfs/util.c:21
        ovl_create_object+0xaf/0x2d0 fs/overlayfs/dir.c:596
        ovl_create+0x29/0x30 fs/overlayfs/dir.c:627
        lookup_open fs/namei.c:3241 [inline]
        do_last fs/namei.c:3331 [inline]
        path_openat+0x234d/0x4250 fs/namei.c:3537
        do_filp_open+0x192/0x3d0 fs/namei.c:3567
        do_sys_open+0x29f/0x560 fs/open.c:1097
        ksys_open include/linux/syscalls.h:1383 [inline]
        __do_sys_creat fs/open.c:1155 [inline]
        __se_sys_creat fs/open.c:1153 [inline]
        __x64_sys_creat+0x65/0x70 fs/open.c:1153
        do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&ovl_i_mutex_dir_key[depth]#2){++++}:
        lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4485
        down_read+0x39/0x50 kernel/locking/rwsem.c:1495
        inode_lock_shared include/linux/fs.h:801 [inline]
        do_last fs/namei.c:3330 [inline]
        path_openat+0xa7a/0x4250 fs/namei.c:3537
        do_filp_open+0x192/0x3d0 fs/namei.c:3567
        do_open_execat+0xff/0x620 fs/exec.c:856
        __do_execve_file+0x758/0x1cc0 fs/exec.c:1761
        do_execveat_common fs/exec.c:1867 [inline]
        do_execve fs/exec.c:1884 [inline]
        __do_sys_execve fs/exec.c:1960 [inline]
        __se_sys_execve fs/exec.c:1955 [inline]
        __x64_sys_execve+0x94/0xb0 fs/exec.c:1955
        do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&sig->cred_guard_mutex){+.+.}:
        check_prev_add kernel/locking/lockdep.c:2476 [inline]
        check_prevs_add kernel/locking/lockdep.c:2581 [inline]
        validate_chain+0x1507/0x7be0 kernel/locking/lockdep.c:2971
        __lock_acquire+0xc5a/0x1bc0 kernel/locking/lockdep.c:3955
        lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4485
        __mutex_lock_common+0x16e/0x2f30 kernel/locking/mutex.c:956
        __mutex_lock kernel/locking/mutex.c:1103 [inline]
        mutex_lock_killable_nested+0x1b/0x30 kernel/locking/mutex.c:1133
        lock_trace fs/proc/base.c:406 [inline]
        proc_pid_stack+0xd9/0x200 fs/proc/base.c:450
        proc_single_show+0xe7/0x180 fs/proc/base.c:756
        seq_read+0x4d8/0xdb0 fs/seq_file.c:229
        do_loop_readv_writev fs/read_write.c:714 [inline]
        do_iter_read+0x4a2/0x5b0 fs/read_write.c:935
        vfs_readv fs/read_write.c:997 [inline]
        do_preadv+0x178/0x290 fs/read_write.c:1089
        __do_sys_preadv fs/read_write.c:1139 [inline]
        __se_sys_preadv fs/read_write.c:1134 [inline]
        __x64_sys_preadv+0x9e/0xb0 fs/read_write.c:1134
        do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
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

1 lock held by syz-executor.5/21564:
  #0: ffff8880a8bb30a0 (&p->lock){+.+.}, at: seq_read+0x6b/0xdb0  
fs/seq_file.c:161

stack backtrace:
CPU: 1 PID: 21564 Comm: syz-executor.5 Not tainted 5.5.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1fb/0x318 lib/dump_stack.c:118
  print_circular_bug+0xc3f/0xe70 kernel/locking/lockdep.c:1685
  check_noncircular+0x206/0x3a0 kernel/locking/lockdep.c:1809
  check_prev_add kernel/locking/lockdep.c:2476 [inline]
  check_prevs_add kernel/locking/lockdep.c:2581 [inline]
  validate_chain+0x1507/0x7be0 kernel/locking/lockdep.c:2971
  __lock_acquire+0xc5a/0x1bc0 kernel/locking/lockdep.c:3955
  lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4485
  __mutex_lock_common+0x16e/0x2f30 kernel/locking/mutex.c:956
  __mutex_lock kernel/locking/mutex.c:1103 [inline]
  mutex_lock_killable_nested+0x1b/0x30 kernel/locking/mutex.c:1133
  lock_trace fs/proc/base.c:406 [inline]
  proc_pid_stack+0xd9/0x200 fs/proc/base.c:450
  proc_single_show+0xe7/0x180 fs/proc/base.c:756
  seq_read+0x4d8/0xdb0 fs/seq_file.c:229
  do_loop_readv_writev fs/read_write.c:714 [inline]
  do_iter_read+0x4a2/0x5b0 fs/read_write.c:935
  vfs_readv fs/read_write.c:997 [inline]
  do_preadv+0x178/0x290 fs/read_write.c:1089
  __do_sys_preadv fs/read_write.c:1139 [inline]
  __se_sys_preadv fs/read_write.c:1134 [inline]
  __x64_sys_preadv+0x9e/0xb0 fs/read_write.c:1134
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45af49
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f893d1e0c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000000045af49
RDX: 0000000000000332 RSI: 00000000200017c0 RDI: 0000000000000004
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f893d1e16d4
R13: 00000000004c954e R14: 00000000004e2220 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
