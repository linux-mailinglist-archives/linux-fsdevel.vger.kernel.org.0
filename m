Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E553D496C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 21:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhGXS0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 14:26:50 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:38538 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhGXS0t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 14:26:49 -0400
Received: by mail-il1-f198.google.com with SMTP id h27-20020a056e021d9bb02902021736bb95so2725753ila.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jul 2021 12:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Nhx8s0EBlKvOlq6K8KW7JBccMJs52n0P8yNkQwHXeXI=;
        b=Bzs6ARtV2zrYGTvMY/eU9ans/Hg4uFvEH+DI3gPXV3hbfW1aLyBQ0Tz5nNj5y5CTSM
         iWu5etNFvLk6Fzjn3jk6ArNGN3/ly0TXAwl7NftsWnXUiASDJXyTtazcVvF72vhEzn7o
         4ura1q97kNO9Eyhq9DkhMhNLEEXEHWhH+ECXb69xJyQe8OFcxRCzIF0rNhiuZY7iF1z1
         o1ZAR3V8LZVDWKoEfZQ0arQm8r87fpWhLxlJnIiQVbIrMaty/8chqbC1/HZANWWHEYHN
         kn5XliRTwKThWkQtmkVsB6scwu3yARHBNZ5MMPzyTTjjubm9vyE2Vd3aVU8xeU+6DJ3+
         TL/Q==
X-Gm-Message-State: AOAM531MHY3V29fxdqbFlbDfR5YTgPSh6+hkMfE8ZBB++NDHJeGskqKj
        owu0RN7OD4+7FtCCLsRUaZqDAzCZG988M2FZfnW4zPiLY9DC
X-Google-Smtp-Source: ABdhPJyEsgUrO2v+LMpJrxE3We3Er4ntaUcuM/wqaYH69fBBYu8tBclY5KMicZjgAV1JpxqTAbIWOfvVVDyZE1Moud5K40Grw3QC
MIME-Version: 1.0
X-Received: by 2002:a02:a999:: with SMTP id q25mr9663122jam.16.1627153640927;
 Sat, 24 Jul 2021 12:07:20 -0700 (PDT)
Date:   Sat, 24 Jul 2021 12:07:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3366805c7e33a92@google.com>
Subject: [syzbot] possible deadlock in pipe_lock (5)
From:   syzbot <syzbot+579885d1a9a833336209@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        mszeredi@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8cae8cd89f05 seq_file: disallow extremely large seq buffer..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1083e8cc300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7273c75708b55890
dashboard link: https://syzkaller.appspot.com/bug?extid=579885d1a9a833336209
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163905f2300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165bd0ea300000

The issue was bisected to:

commit 82a763e61e2b601309d696d4fa514c77d64ee1be
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon Dec 14 14:26:14 2020 +0000

    ovl: simplify file splice

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13440c82300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10c40c82300000
console output: https://syzkaller.appspot.com/x/log.txt?x=17440c82300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+579885d1a9a833336209@syzkaller.appspotmail.com
Fixes: 82a763e61e2b ("ovl: simplify file splice")

======================================================
WARNING: possible circular locking dependency detected
5.14.0-rc2-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor005/9173 is trying to acquire lock:
ffff888027e98468 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_lock_nested fs/pipe.c:66 [inline]
ffff888027e98468 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_lock+0x5a/0x70 fs/pipe.c:74

but task is already holding lock:
ffff888147cfc460 (sb_writers#5){.+.+}-{0:0}, at: __do_splice+0x134/0x250 fs/splice.c:1144

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_writers#5){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1763 [inline]
       sb_start_write include/linux/fs.h:1833 [inline]
       file_start_write include/linux/fs.h:3040 [inline]
       ovl_write_iter+0x1015/0x17f0 fs/overlayfs/file.c:357
       call_write_iter include/linux/fs.h:2114 [inline]
       do_iter_readv_writev+0x46f/0x740 fs/read_write.c:740
       do_iter_write+0x188/0x670 fs/read_write.c:866
       vfs_iter_write+0x70/0xa0 fs/read_write.c:907
       iter_file_splice_write+0x723/0xc70 fs/splice.c:689
       do_splice_from fs/splice.c:767 [inline]
       do_splice+0xb7e/0x1960 fs/splice.c:1079
       __do_splice+0x134/0x250 fs/splice.c:1144
       __do_sys_splice fs/splice.c:1350 [inline]
       __se_sys_splice fs/splice.c:1332 [inline]
       __x64_sys_splice+0x198/0x250 fs/splice.c:1332
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&ovl_i_mutex_key[depth]){+.+.}-{3:3}:
       down_write+0x92/0x150 kernel/locking/rwsem.c:1406
       inode_lock include/linux/fs.h:774 [inline]
       ovl_write_iter+0x17d/0x17f0 fs/overlayfs/file.c:341
       call_write_iter include/linux/fs.h:2114 [inline]
       do_iter_readv_writev+0x46f/0x740 fs/read_write.c:740
       do_iter_write+0x188/0x670 fs/read_write.c:866
       vfs_iter_write+0x70/0xa0 fs/read_write.c:907
       iter_file_splice_write+0x723/0xc70 fs/splice.c:689
       do_splice_from fs/splice.c:767 [inline]
       do_splice+0xb7e/0x1960 fs/splice.c:1079
       __do_splice+0x134/0x250 fs/splice.c:1144
       __do_sys_splice fs/splice.c:1350 [inline]
       __se_sys_splice fs/splice.c:1332 [inline]
       __x64_sys_splice+0x198/0x250 fs/splice.c:1332
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&pipe->mutex/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add kernel/locking/lockdep.c:3174 [inline]
       validate_chain kernel/locking/lockdep.c:3789 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
       lock_acquire kernel/locking/lockdep.c:5625 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
       __mutex_lock_common kernel/locking/mutex.c:959 [inline]
       __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
       pipe_lock_nested fs/pipe.c:66 [inline]
       pipe_lock+0x5a/0x70 fs/pipe.c:74
       iter_file_splice_write+0x183/0xc70 fs/splice.c:635
       do_splice_from fs/splice.c:767 [inline]
       do_splice+0xb7e/0x1960 fs/splice.c:1079
       __do_splice+0x134/0x250 fs/splice.c:1144
       __do_sys_splice fs/splice.c:1350 [inline]
       __se_sys_splice fs/splice.c:1332 [inline]
       __x64_sys_splice+0x198/0x250 fs/splice.c:1332
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  &pipe->mutex/1 --> &ovl_i_mutex_key[depth] --> sb_writers#5

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_writers#5);
                               lock(&ovl_i_mutex_key[depth]);
                               lock(sb_writers#5);
  lock(&pipe->mutex/1);

 *** DEADLOCK ***

1 lock held by syz-executor005/9173:
 #0: ffff888147cfc460 (sb_writers#5){.+.+}-{0:0}, at: __do_splice+0x134/0x250 fs/splice.c:1144

stack backtrace:
CPU: 0 PID: 9173 Comm: syz-executor005 Not tainted 5.14.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2131
 check_prev_add kernel/locking/lockdep.c:3051 [inline]
 check_prevs_add kernel/locking/lockdep.c:3174 [inline]
 validate_chain kernel/locking/lockdep.c:3789 [inline]
 __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 __mutex_lock_common kernel/locking/mutex.c:959 [inline]
 __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
 pipe_lock_nested fs/pipe.c:66 [inline]
 pipe_lock+0x5a/0x70 fs/pipe.c:74
 iter_file_splice_write+0x183/0xc70 fs/splice.c:635
 do_splice_from fs/splice.c:767 [inline]
 do_splice+0xb7e/0x1960 fs/splice.c:1079
 __do_splice+0x134/0x250 fs/splice.c:1144
 __do_sys_splice fs/splice.c:1350 [inline]
 __se_sys_splice fs/splice.c:1332 [inline]
 __x64_sys_splice+0x198/0x250 fs/splice.c:1332
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x446219
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1d5746e2e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00000000004cb4e0 RCX: 0000000000446219
RDX: 0000000000000006 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 000000000049b06c R08: 000000000004ffdc R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 3d72696472657070
R13: 0079616c7265766f R14: 69662f7375622f2e R15: 00000000004cb4e8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
