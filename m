Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49F8F12EA49
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 20:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgABTVK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 14:21:10 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:42922 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgABTVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 14:21:10 -0500
Received: by mail-io1-f71.google.com with SMTP id e7so25849264iog.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jan 2020 11:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FRfPvVAcYNlxGYRGcqUKekQKbPa/NXPujZppts6t3J8=;
        b=rzqMHwx5W7XJVcC9TNmCocPLohMqAAND+Yyrq3/ugPIAGLkp5DoANKxvy4PUnwmQss
         kMbtywYt9dfW4skZOssbVCW/7aBqi1Ukqb+pH4xKsgCiM18wAzSJuMQcy2Y1Ms0v6fxZ
         vR33nsHtZds8wM2fX3oGTBkJRQI9zRHw/g19YmwxIenPVZyPcgNWOXX2hb/SfTvknHDI
         ycMjAPrSbm81HG5aKHxlAdgc0G8xPRMZtDay24NfK/tpssWeIvrePTrbCGwTm+E115WL
         8bGP+RNP9pxWSphBQRc1bq4DZgkvPL4RAcYUE7T8GkK95yM9MnxsPrr70h6ap/y20z3u
         agyw==
X-Gm-Message-State: APjAAAUP1IZWljintVJwSr168j3vjofSffbE7BE4/tO9FPe5eqxvwTn9
        odGE1F8tlSUc5iuRG0+2t56ad1UL6qy3s5RRvw6t/fer0wP7
X-Google-Smtp-Source: APXvYqzdv5pj8G25vHrpUCrtXdvNgIqltG+j+sQzjfmP8ihm/W3n5NcIOqfcSVL1tFTJJe5LfFSYTj0aQAEFFyyqNY7yOilaZ1Nu
MIME-Version: 1.0
X-Received: by 2002:a6b:b504:: with SMTP id e4mr13121926iof.222.1577992869205;
 Thu, 02 Jan 2020 11:21:09 -0800 (PST)
Date:   Thu, 02 Jan 2020 11:21:09 -0800
In-Reply-To: <000000000000a0f82805867fb67e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d62f4059b2d1893@google.com>
Subject: Re: possible deadlock in seq_read (2)
From:   syzbot <syzbot+5378878b09e052edef7f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    7ddd09fc Add linux-next specific files for 20191220
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1648763ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f183b01c3088afc6
dashboard link: https://syzkaller.appspot.com/bug?extid=5378878b09e052edef7f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e706e1e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14478885e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5378878b09e052edef7f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.5.0-rc2-next-20191220-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor877/11363 is trying to acquire lock:
ffff8880920b8520 (&p->lock){+.+.}, at: seq_read+0x71/0x1170  
fs/seq_file.c:161

but task is already holding lock:
ffff8880998ac428 (sb_writers#3){.+.+}, at: file_start_write  
include/linux/fs.h:2880 [inline]
ffff8880998ac428 (sb_writers#3){.+.+}, at: do_sendfile+0x9b9/0xd00  
fs/read_write.c:1463

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (sb_writers#3){.+.+}:
        percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
        __sb_start_write+0x241/0x460 fs/super.c:1674
        sb_start_write include/linux/fs.h:1649 [inline]
        mnt_want_write+0x3f/0xc0 fs/namespace.c:354
        ovl_want_write+0x76/0xa0 fs/overlayfs/util.c:21
        ovl_create_object+0xb3/0x2c0 fs/overlayfs/dir.c:596
        ovl_create+0x28/0x30 fs/overlayfs/dir.c:627
        lookup_open+0x12d5/0x1a90 fs/namei.c:3374
        do_last fs/namei.c:3464 [inline]
        path_openat+0xf2a/0x34d0 fs/namei.c:3670
        do_filp_open+0x192/0x260 fs/namei.c:3700
        do_sys_openat2+0x633/0x840 fs/open.c:1152
        do_sys_open+0xfc/0x190 fs/open.c:1168
        ksys_open include/linux/syscalls.h:1385 [inline]
        __do_sys_open fs/open.c:1174 [inline]
        __se_sys_open fs/open.c:1172 [inline]
        __x64_sys_open+0x7e/0xc0 fs/open.c:1172
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (&ovl_i_mutex_dir_key[depth]){++++}:
        down_read+0x95/0x440 kernel/locking/rwsem.c:1495
        inode_lock_shared include/linux/fs.h:801 [inline]
        do_last fs/namei.c:3463 [inline]
        path_openat+0x1c60/0x34d0 fs/namei.c:3670
        do_filp_open+0x192/0x260 fs/namei.c:3700
        do_open_execat+0x13b/0x6d0 fs/exec.c:861
        __do_execve_file.isra.0+0x1702/0x22b0 fs/exec.c:1766
        do_execveat_common fs/exec.c:1872 [inline]
        do_execve fs/exec.c:1889 [inline]
        __do_sys_execve fs/exec.c:1965 [inline]
        __se_sys_execve fs/exec.c:1960 [inline]
        __x64_sys_execve+0x8f/0xc0 fs/exec.c:1960
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&sig->cred_guard_mutex){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:956 [inline]
        __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1103
        mutex_lock_killable_nested+0x16/0x20 kernel/locking/mutex.c:1133
        do_io_accounting+0x1f4/0x820 fs/proc/base.c:2772
        proc_tgid_io_accounting+0x23/0x30 fs/proc/base.c:2821
        proc_single_show+0xfd/0x1c0 fs/proc/base.c:756
        seq_read+0x4ca/0x1170 fs/seq_file.c:229
        do_loop_readv_writev fs/read_write.c:714 [inline]
        do_loop_readv_writev fs/read_write.c:701 [inline]
        do_iter_read+0x4a4/0x660 fs/read_write.c:935
        vfs_readv+0xf0/0x160 fs/read_write.c:997
        kernel_readv fs/splice.c:365 [inline]
        default_file_splice_read+0x4fb/0xa20 fs/splice.c:422
        do_splice_to+0x127/0x180 fs/splice.c:892
        splice_direct_to_actor+0x320/0xa30 fs/splice.c:971
        do_splice_direct+0x1da/0x2a0 fs/splice.c:1080
        do_sendfile+0x597/0xd00 fs/read_write.c:1464
        __do_sys_sendfile64 fs/read_write.c:1525 [inline]
        __se_sys_sendfile64 fs/read_write.c:1511 [inline]
        __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1511
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&p->lock){+.+.}:
        check_prev_add kernel/locking/lockdep.c:2476 [inline]
        check_prevs_add kernel/locking/lockdep.c:2581 [inline]
        validate_chain kernel/locking/lockdep.c:2971 [inline]
        __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3955
        lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
        __mutex_lock_common kernel/locking/mutex.c:956 [inline]
        __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1103
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
        seq_read+0x71/0x1170 fs/seq_file.c:161
        do_loop_readv_writev fs/read_write.c:714 [inline]
        do_loop_readv_writev fs/read_write.c:701 [inline]
        do_iter_read+0x4a4/0x660 fs/read_write.c:935
        vfs_readv+0xf0/0x160 fs/read_write.c:997
        kernel_readv fs/splice.c:365 [inline]
        default_file_splice_read+0x4fb/0xa20 fs/splice.c:422
        do_splice_to+0x127/0x180 fs/splice.c:892
        splice_direct_to_actor+0x320/0xa30 fs/splice.c:971
        do_splice_direct+0x1da/0x2a0 fs/splice.c:1080
        do_sendfile+0x597/0xd00 fs/read_write.c:1464
        __do_sys_sendfile64 fs/read_write.c:1525 [inline]
        __se_sys_sendfile64 fs/read_write.c:1511 [inline]
        __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1511
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   &p->lock --> &ovl_i_mutex_dir_key[depth] --> sb_writers#3

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(sb_writers#3);
                                lock(&ovl_i_mutex_dir_key[depth]);
                                lock(sb_writers#3);
   lock(&p->lock);

  *** DEADLOCK ***

1 lock held by syz-executor877/11363:
  #0: ffff8880998ac428 (sb_writers#3){.+.+}, at: file_start_write  
include/linux/fs.h:2880 [inline]
  #0: ffff8880998ac428 (sb_writers#3){.+.+}, at: do_sendfile+0x9b9/0xd00  
fs/read_write.c:1463

stack backtrace:
CPU: 0 PID: 11363 Comm: syz-executor877 Not tainted  
5.5.0-rc2-next-20191220-syzkaller #0
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
  __mutex_lock_common kernel/locking/mutex.c:956 [inline]
  __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1103
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
  seq_read+0x71/0x1170 fs/seq_file.c:161
  do_loop_readv_writev fs/read_write.c:714 [inline]
  do_loop_readv_writev fs/read_write.c:701 [inline]
  do_iter_read+0x4a4/0x660 fs/read_write.c:935
  vfs_readv+0xf0/0x160 fs/read_write.c:997
  kernel_readv fs/splice.c:365 [inline]
  default_file_splice_read+0x4fb/0xa20 fs/splice.c:422
  do_splice_to+0x127/0x180 fs/splice.c:892
  splice_direct_to_actor+0x320/0xa30 fs/splice.c:971
  do_splice_direct+0x1da/0x2a0 fs/splice.c:1080
  do_sendfile+0x597/0xd00 fs/read_write.c:1464
  __do_sys_sendfile64 fs/read_write.c:1525 [inline]
  __se_sys_sendfile64 fs/read_write.c:1511 [inline]
  __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1511
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x448dd9
Code: e8 9c e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b 05 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fc37ed06ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000006e4a08 RCX: 0000000000448dd9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
RBP: 00000000006e4a00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000209 R11: 0000000000000246 R12: 00000000006e4a0c
R13: 00007ffecbcb224f R14: 00007fc37ed079c0 R15: 20c49ba5e353f7cf

