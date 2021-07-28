Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361863D903E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 16:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbhG1OT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 10:19:26 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:41722 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbhG1OTZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:19:25 -0400
Received: by mail-il1-f199.google.com with SMTP id m18-20020a924b120000b02901ee102ac952so1581819ilg.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jul 2021 07:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fs8at5oxIJu2qv6y8JFLJwnQelXth8O42Fo8cTG83tQ=;
        b=ecHznblM6o5MI79IDZPcg23pRi8whhH3VBG98FtAyIiIkmJLVWnrUJL3Atn90XFq/h
         WGhGs+SPPIy0kEsUyTR+EySqDjsk5ZDgrlOEF9iEA1oZfIo1Z0apQpBBEpaKHE8CWobB
         cDIjZk/724S4Ga+V2r7S6VtitFiECL8A286FRMVWynrKHTc4AzJXC8M4ZEo7EHkovBGU
         +Z+imXlfGQ8P0pd1EytuDEs0jnCIv7KhdYlBiWoInTBTWVUz5JY/a/rOSRgbOhsB/sgF
         gZrNiwsd8X6P8peSoPcgkk9e7pep7jxbF2B7IXFjS/gzqe6Nit1LBkGn6zNRyyUBQ8Pa
         yfWw==
X-Gm-Message-State: AOAM531H3ri02Ku+ZUSBNqAYTkg5bIzun6GTobc7969yMFSVo/jn5nw2
        23mpFuuKC773WTcK7LiJtHbpyH7bd6I5HkoPloFJ3hnMDEeH
X-Google-Smtp-Source: ABdhPJxugm15dJxuNz+7LufAybSBhpDUJf25KlY9mICr9CgQ3WN6psVD5E+CG6AFG9MY16XItr6LD+s4AIrLFlPkJ2S3XzfSu9pY
MIME-Version: 1.0
X-Received: by 2002:a6b:e60f:: with SMTP id g15mr23353424ioh.48.1627481963666;
 Wed, 28 Jul 2021 07:19:23 -0700 (PDT)
Date:   Wed, 28 Jul 2021 07:19:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052a12105c82facde@google.com>
Subject: [syzbot] possible deadlock in iter_file_splice_write (2)
From:   syzbot <syzbot+4bdbcaa79e8ee36fe6af@syzkaller.appspotmail.com>
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

HEAD commit:    f0fddcec6b62 Merge tag 'for-5.14-rc2-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a13312300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5dc0e3202ae2f574
dashboard link: https://syzkaller.appspot.com/bug?extid=4bdbcaa79e8ee36fe6af
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a68b12300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1226e6ca300000

The issue was bisected to:

commit 82a763e61e2b601309d696d4fa514c77d64ee1be
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon Dec 14 14:26:14 2020 +0000

    ovl: simplify file splice

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1324e8fc300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a4e8fc300000
console output: https://syzkaller.appspot.com/x/log.txt?x=1724e8fc300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4bdbcaa79e8ee36fe6af@syzkaller.appspotmail.com
Fixes: 82a763e61e2b ("ovl: simplify file splice")

======================================================
WARNING: possible circular locking dependency detected
5.14.0-rc2-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor919/8626 is trying to acquire lock:
ffff8880141ed068 (&pipe->mutex/1){+.+.}-{3:3}, at: iter_file_splice_write+0x257/0xf30 fs/splice.c:635

but task is already holding lock:
ffff888029aac460 (sb_writers#5){.+.+}-{0:0}, at: __do_splice fs/splice.c:1144 [inline]
ffff888029aac460 (sb_writers#5){.+.+}-{0:0}, at: __do_sys_splice fs/splice.c:1350 [inline]
ffff888029aac460 (sb_writers#5){.+.+}-{0:0}, at: __se_sys_splice+0x32c/0x430 fs/splice.c:1332

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_writers#5){.+.+}-{0:0}:
       lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1763 [inline]
       sb_start_write include/linux/fs.h:1833 [inline]
       file_start_write+0xc7/0x230 include/linux/fs.h:3040
       ovl_write_iter+0x81d/0xdb0 fs/overlayfs/file.c:357
       do_iter_readv_writev+0x566/0x770 include/linux/fs.h:2108
       do_iter_write+0x16c/0x5f0 fs/read_write.c:866
       iter_file_splice_write+0x7c1/0xf30 fs/splice.c:689
       do_splice_from fs/splice.c:767 [inline]
       do_splice+0xe8e/0x17e0 fs/splice.c:1079
       __do_splice fs/splice.c:1144 [inline]
       __do_sys_splice fs/splice.c:1350 [inline]
       __se_sys_splice+0x32c/0x430 fs/splice.c:1332
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&ovl_i_mutex_key[depth]){+.+.}-{3:3}:
       lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
       down_write+0x97/0x170 kernel/locking/rwsem.c:1406
       inode_lock include/linux/fs.h:774 [inline]
       ovl_write_iter+0x132/0xdb0 fs/overlayfs/file.c:341
       do_iter_readv_writev+0x566/0x770 include/linux/fs.h:2108
       do_iter_write+0x16c/0x5f0 fs/read_write.c:866
       iter_file_splice_write+0x7c1/0xf30 fs/splice.c:689
       do_splice_from fs/splice.c:767 [inline]
       do_splice+0xe8e/0x17e0 fs/splice.c:1079
       __do_splice fs/splice.c:1144 [inline]
       __do_sys_splice fs/splice.c:1350 [inline]
       __se_sys_splice+0x32c/0x430 fs/splice.c:1332
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&pipe->mutex/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add+0x4f9/0x5b30 kernel/locking/lockdep.c:3174
       validate_chain kernel/locking/lockdep.c:3789 [inline]
       __lock_acquire+0x4476/0x6100 kernel/locking/lockdep.c:5015
       lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
       __mutex_lock_common+0x1ad/0x3770 kernel/locking/mutex.c:959
       __mutex_lock kernel/locking/mutex.c:1104 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
       iter_file_splice_write+0x257/0xf30 fs/splice.c:635
       do_splice_from fs/splice.c:767 [inline]
       do_splice+0xe8e/0x17e0 fs/splice.c:1079
       __do_splice fs/splice.c:1144 [inline]
       __do_sys_splice fs/splice.c:1350 [inline]
       __se_sys_splice+0x32c/0x430 fs/splice.c:1332
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
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

1 lock held by syz-executor919/8626:
 #0: ffff888029aac460 (sb_writers#5){.+.+}-{0:0}, at: __do_splice fs/splice.c:1144 [inline]
 #0: ffff888029aac460 (sb_writers#5){.+.+}-{0:0}, at: __do_sys_splice fs/splice.c:1350 [inline]
 #0: ffff888029aac460 (sb_writers#5){.+.+}-{0:0}, at: __se_sys_splice+0x32c/0x430 fs/splice.c:1332

stack backtrace:
CPU: 0 PID: 8626 Comm: syz-executor919 Not tainted 5.14.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1ae/0x29f lib/dump_stack.c:105
 print_circular_bug+0xb17/0xdc0 kernel/locking/lockdep.c:2009
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2131
 check_prev_add kernel/locking/lockdep.c:3051 [inline]
 check_prevs_add+0x4f9/0x5b30 kernel/locking/lockdep.c:3174
 validate_chain kernel/locking/lockdep.c:3789 [inline]
 __lock_acquire+0x4476/0x6100 kernel/locking/lockdep.c:5015
 lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
 __mutex_lock_common+0x1ad/0x3770 kernel/locking/mutex.c:959
 __mutex_lock kernel/locking/mutex.c:1104 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
 iter_file_splice_write+0x257/0xf30 fs/splice.c:635
 do_splice_from fs/splice.c:767 [inline]
 do_splice+0xe8e/0x17e0 fs/splice.c:1079
 __do_splice fs/splice.c:1144 [inline]
 __do_sys_splice fs/splice.c:1350 [inline]
 __se_sys_splice+0x32c/0x430 fs/splice.c:1332
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4461b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7b06be32e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00000000004cb4f0 RCX: 00000000004461b9
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 000000000049b06c R08: 000000000004ffdc R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 3d72696472657070
R13: 0079616c7265766f R14: 69662f7375622f2e R15: 00000000004cb4f8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
