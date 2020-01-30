Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 567F914D50B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 02:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgA3BrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 20:47:12 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:41751 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbgA3BrM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 20:47:12 -0500
Received: by mail-il1-f197.google.com with SMTP id k9so1424039ili.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2020 17:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=F4bji5GdhK95wNNVWADN1HJupnGDRiuCcmsdc/Vpn0Q=;
        b=F0gR1jO507lIk9dhL3GDFOn7geY+TUkFEluKZjGRTrlOHUaqrLBk9zy3r7YJ3rMvJ5
         UuCQv09xHAvrZN+m5jzvtLLseNRNX+NhM9/KdyQOWnR3khPeSW50b2uZnhmBe6AFKFC0
         dY1B/llqyzc2hDcRk8/Bj05ydWwXdYhVgNNvmibVsBX1wZD8yxUlRKX808kYZEijYVAU
         i+2fcpJtFX7cthvGsl079nUUZHFqB0d5skJfOL+Ltssv2JXfIUog5sKIBuTr+LpPweOk
         pRMBfuzT0T/L54E/YaYwzquVQJSvMVpEC9iSE2F2ZaP5eG8dxRk6y8tnUQxT4IStGbbX
         hVhQ==
X-Gm-Message-State: APjAAAUyFT8zH8tM3p3fDRQzDLT7O9STW0A4aLjEd/inEoEv6g+ORWjC
        ldsBexZd5gBOf3nIeeKCx3UiHIUET5U5n3pwKCkWuOola2xW
X-Google-Smtp-Source: APXvYqxX01BiBspsdSIy8XnmIziiqk/ld5G8KJh9pTxlEPBdoMmv8sWirtkNUMCU8fI355W7hMUQcZl35So1wP8eyP2SvapAIqI0
MIME-Version: 1.0
X-Received: by 2002:a92:8307:: with SMTP id f7mr2238138ild.73.1580348829848;
 Wed, 29 Jan 2020 17:47:09 -0800 (PST)
Date:   Wed, 29 Jan 2020 17:47:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fdd42059d51a2d6@google.com>
Subject: possible deadlock in lookup_one_len_unlocked
From:   syzbot <syzbot+d674d1894d2be4fa3168@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b3a60822 Merge branch 'for-v5.6' of git://git.kernel.org:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160090e9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5766bb49c0bc43b9
dashboard link: https://syzkaller.appspot.com/bug?extid=d674d1894d2be4fa3168
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d674d1894d2be4fa3168@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.5.0-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.2/5677 is trying to acquire lock:
ffff8880325571a0 (&ovl_i_mutex_dir_key[depth]){++++}, at: inode_lock_shared include/linux/fs.h:801 [inline]
ffff8880325571a0 (&ovl_i_mutex_dir_key[depth]){++++}, at: lookup_slow fs/namei.c:1681 [inline]
ffff8880325571a0 (&ovl_i_mutex_dir_key[depth]){++++}, at: lookup_one_len_unlocked+0xd2/0x1d0 fs/namei.c:2559

but task is already holding lock:
ffff8880325851e0 (&ovl_i_mutex_dir_key[depth]#2){++++}, at: inode_lock_shared include/linux/fs.h:801 [inline]
ffff8880325851e0 (&ovl_i_mutex_dir_key[depth]#2){++++}, at: do_last fs/namei.c:3269 [inline]
ffff8880325851e0 (&ovl_i_mutex_dir_key[depth]#2){++++}, at: path_openat+0xb04/0x41e0 fs/namei.c:3476

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&ovl_i_mutex_dir_key[depth]#2){++++}:
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       down_read+0x39/0x50 kernel/locking/rwsem.c:1495
       inode_lock_shared include/linux/fs.h:801 [inline]
       do_last fs/namei.c:3269 [inline]
       path_openat+0xb04/0x41e0 fs/namei.c:3476
       do_filp_open+0x192/0x3d0 fs/namei.c:3506
       do_open_execat+0xff/0x620 fs/exec.c:856
       __do_execve_file+0x758/0x1cc0 fs/exec.c:1761
       do_execveat_common fs/exec.c:1867 [inline]
       do_execve fs/exec.c:1884 [inline]
       __do_sys_execve fs/exec.c:1960 [inline]
       __se_sys_execve fs/exec.c:1955 [inline]
       __x64_sys_execve+0x94/0xb0 fs/exec.c:1955
       do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #3 (&sig->cred_guard_mutex){+.+.}:
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       __mutex_lock_common+0x16e/0x2f30 kernel/locking/mutex.c:956
       __mutex_lock kernel/locking/mutex.c:1103 [inline]
       mutex_lock_killable_nested+0x1b/0x30 kernel/locking/mutex.c:1133
       do_io_accounting fs/proc/base.c:2865 [inline]
       proc_tgid_io_accounting+0x16a/0x570 fs/proc/base.c:2914
       proc_single_show+0xe7/0x180 fs/proc/base.c:758
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

-> #2 (&p->lock){+.+.}:
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       __mutex_lock_common+0x16e/0x2f30 kernel/locking/mutex.c:956
       __mutex_lock kernel/locking/mutex.c:1103 [inline]
       mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:1118
       seq_read+0x6b/0xdb0 fs/seq_file.c:161
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

-> #1 (sb_writers#3){.+.+}:
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
       __sb_start_write+0x189/0x420 fs/super.c:1674
       sb_start_write include/linux/fs.h:1650 [inline]
       mnt_want_write+0x4a/0xa0 fs/namespace.c:354
       ovl_want_write+0x77/0x80 fs/overlayfs/util.c:21
       ovl_create_object+0xaf/0x2d0 fs/overlayfs/dir.c:596
       ovl_create+0x29/0x30 fs/overlayfs/dir.c:627
       lookup_open fs/namei.c:3178 [inline]
       do_last fs/namei.c:3270 [inline]
       path_openat+0x220b/0x41e0 fs/namei.c:3476
       do_filp_open+0x192/0x3d0 fs/namei.c:3506
       do_sys_open+0x29f/0x560 fs/open.c:1097
       ksys_open include/linux/syscalls.h:1383 [inline]
       __do_sys_creat fs/open.c:1155 [inline]
       __se_sys_creat fs/open.c:1153 [inline]
       __x64_sys_creat+0x65/0x70 fs/open.c:1153
       do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&ovl_i_mutex_dir_key[depth]){++++}:
       check_prev_add kernel/locking/lockdep.c:2475 [inline]
       check_prevs_add kernel/locking/lockdep.c:2580 [inline]
       validate_chain+0x1507/0x7be0 kernel/locking/lockdep.c:2970
       __lock_acquire+0xc5a/0x1bc0 kernel/locking/lockdep.c:3954
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       down_read+0x39/0x50 kernel/locking/rwsem.c:1495
       inode_lock_shared include/linux/fs.h:801 [inline]
       lookup_slow fs/namei.c:1681 [inline]
       lookup_one_len_unlocked+0xd2/0x1d0 fs/namei.c:2559
       lookup_positive_unlocked+0x25/0xb0 fs/namei.c:2575
       ovl_lookup_single+0x67/0x830 fs/overlayfs/namei.c:203
       ovl_lookup_layer+0x3b1/0x470 fs/overlayfs/namei.c:287
       ovl_lookup+0x843/0x1c60 fs/overlayfs/namei.c:902
       lookup_open fs/namei.c:3157 [inline]
       do_last fs/namei.c:3270 [inline]
       path_openat+0x1ab1/0x41e0 fs/namei.c:3476
       do_filp_open+0x192/0x3d0 fs/namei.c:3506
       do_open_execat+0xff/0x620 fs/exec.c:856
       __do_execve_file+0x758/0x1cc0 fs/exec.c:1761
       do_execveat_common fs/exec.c:1867 [inline]
       do_execve fs/exec.c:1884 [inline]
       __do_sys_execve fs/exec.c:1960 [inline]
       __se_sys_execve fs/exec.c:1955 [inline]
       __x64_sys_execve+0x94/0xb0 fs/exec.c:1955
       do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
  &ovl_i_mutex_dir_key[depth] --> &sig->cred_guard_mutex --> &ovl_i_mutex_dir_key[depth]#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ovl_i_mutex_dir_key[depth]#2);
                               lock(&sig->cred_guard_mutex);
                               lock(&ovl_i_mutex_dir_key[depth]#2);
  lock(&ovl_i_mutex_dir_key[depth]);

 *** DEADLOCK ***

2 locks held by syz-executor.2/5677:
 #0: ffff88806078bd90 (&sig->cred_guard_mutex){+.+.}, at: prepare_bprm_creds fs/exec.c:1408 [inline]
 #0: ffff88806078bd90 (&sig->cred_guard_mutex){+.+.}, at: __do_execve_file+0x2c4/0x1cc0 fs/exec.c:1753
 #1: ffff8880325851e0 (&ovl_i_mutex_dir_key[depth]#2){++++}, at: inode_lock_shared include/linux/fs.h:801 [inline]
 #1: ffff8880325851e0 (&ovl_i_mutex_dir_key[depth]#2){++++}, at: do_last fs/namei.c:3269 [inline]
 #1: ffff8880325851e0 (&ovl_i_mutex_dir_key[depth]#2){++++}, at: path_openat+0xb04/0x41e0 fs/namei.c:3476

stack backtrace:
CPU: 1 PID: 5677 Comm: syz-executor.2 Not tainted 5.5.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fb/0x318 lib/dump_stack.c:118
 print_circular_bug+0xc3f/0xe70 kernel/locking/lockdep.c:1684
 check_noncircular+0x206/0x3a0 kernel/locking/lockdep.c:1808
 check_prev_add kernel/locking/lockdep.c:2475 [inline]
 check_prevs_add kernel/locking/lockdep.c:2580 [inline]
 validate_chain+0x1507/0x7be0 kernel/locking/lockdep.c:2970
 __lock_acquire+0xc5a/0x1bc0 kernel/locking/lockdep.c:3954
 lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
 down_read+0x39/0x50 kernel/locking/rwsem.c:1495
 inode_lock_shared include/linux/fs.h:801 [inline]
 lookup_slow fs/namei.c:1681 [inline]
 lookup_one_len_unlocked+0xd2/0x1d0 fs/namei.c:2559
 lookup_positive_unlocked+0x25/0xb0 fs/namei.c:2575
 ovl_lookup_single+0x67/0x830 fs/overlayfs/namei.c:203
 ovl_lookup_layer+0x3b1/0x470 fs/overlayfs/namei.c:287
 ovl_lookup+0x843/0x1c60 fs/overlayfs/namei.c:902
 lookup_open fs/namei.c:3157 [inline]
 do_last fs/namei.c:3270 [inline]
 path_openat+0x1ab1/0x41e0 fs/namei.c:3476
 do_filp_open+0x192/0x3d0 fs/namei.c:3506
 do_open_execat+0xff/0x620 fs/exec.c:856
 __do_execve_file+0x758/0x1cc0 fs/exec.c:1761
 do_execveat_common fs/exec.c:1867 [inline]
 do_execve fs/exec.c:1884 [inline]
 __do_sys_execve fs/exec.c:1960 [inline]
 __se_sys_execve fs/exec.c:1955 [inline]
 __x64_sys_execve+0x94/0xb0 fs/exec.c:1955
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45b349
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fbd9d4b0c78 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00007fbd9d4b16d4 RCX: 000000000045b349
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000280
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000000a2 R14: 00000000004c1e52 R15: 000000000075bf2c


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
