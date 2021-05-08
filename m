Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6F73771FA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 May 2021 15:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhEHNIW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 May 2021 09:08:22 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:52740 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhEHNIW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 May 2021 09:08:22 -0400
Received: by mail-io1-f71.google.com with SMTP id o6-20020a05660213c6b0290438e33a3335so2544343iov.19
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 May 2021 06:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Hql9TVq6OPSMTMoFG3sFcDAWlXsoJAmMRkpUPWkkuqY=;
        b=diV8QmPJHYCFOhqeJvM83EwaiJYAfXryMP99RGdOLITom9Uti/FZagQ+EhjtCZsQu1
         1igpdaqrZU/6EYpBufYD+qaPPbs1gqdmgP5r/4gPt1mhgG5Bz7Zi1yUFxJ4czYbrkfWQ
         YxwpHW+OxSWH4E58HkyrllTh8iRfxiCoMZ8LZXb8ioIYBt5/d2c+NT5Qnb6rwyV4l9+y
         jTbp8+4uyEgAuI3tVhG0QSk3hQ/NMuTFqgUEzGFRnn7nDjxxXSFklDlSlemGaZQuTfyZ
         8rwval63szAVcNqRR06F0lMzclDeqC+oxzaJBqgkO/PbaUlt3gwyJhU0Z+sFZMEVdFIu
         Tkdw==
X-Gm-Message-State: AOAM533AVrHogxreUjZvWQmaghVvYP/lqLCJyVD0dH+Kc99t5pmmyItz
        KiSsCutj9oc1PtsrpivOPb/akZ9973HLl1LeocZgmSWozEpd
X-Google-Smtp-Source: ABdhPJwL9N5sYzC+7Sk3Cm2Uvyr1SYweBLtkLnOJr9Z7AaYajELdY3/lTnjIIdsP3h886VHH8tNxdq31FeDMkyXJwiiYJQxswxa5
MIME-Version: 1.0
X-Received: by 2002:a02:6654:: with SMTP id l20mr13454172jaf.55.1620479238784;
 Sat, 08 May 2021 06:07:18 -0700 (PDT)
Date:   Sat, 08 May 2021 06:07:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064cde105c1d1397b@google.com>
Subject: [syzbot] possible deadlock in pipe_lock (4)
From:   syzbot <syzbot+86cae0697c35c6294c32@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9a9aa07a Add linux-next specific files for 20210504
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12ec3fa9d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acf3aa1c9f3e62f8
dashboard link: https://syzkaller.appspot.com/bug?extid=86cae0697c35c6294c32

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+86cae0697c35c6294c32@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.12.0-next-20210504-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.4/12393 is trying to acquire lock:
ffff88801f433068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_lock_nested fs/pipe.c:66 [inline]
ffff88801f433068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_lock+0x5a/0x70 fs/pipe.c:74

but task is already holding lock:
ffff8881448a8460 (sb_writers#5){.+.+}-{0:0}, at: __do_splice+0x134/0x250 fs/splice.c:1144

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_writers#5){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1763 [inline]
       sb_start_write include/linux/fs.h:1833 [inline]
       mnt_want_write+0x6e/0x3e0 fs/namespace.c:375
       ovl_setattr+0x63/0x860 fs/overlayfs/inode.c:31
       notify_change+0xb28/0x10f0 fs/attr.c:398
       do_truncate+0x13c/0x200 fs/open.c:64
       handle_truncate fs/namei.c:3017 [inline]
       do_open fs/namei.c:3365 [inline]
       path_openat+0x20e4/0x27e0 fs/namei.c:3494
       do_filp_open+0x190/0x3d0 fs/namei.c:3521
       do_sys_openat2+0x16d/0x420 fs/open.c:1187
       do_sys_open fs/open.c:1203 [inline]
       __do_sys_openat fs/open.c:1219 [inline]
       __se_sys_openat fs/open.c:1214 [inline]
       __x64_sys_openat+0x13f/0x1f0 fs/open.c:1214
       do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
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
       do_splice+0xb7e/0x1940 fs/splice.c:1079
       __do_splice+0x134/0x250 fs/splice.c:1144
       __do_sys_splice fs/splice.c:1350 [inline]
       __se_sys_splice fs/splice.c:1332 [inline]
       __x64_sys_splice+0x198/0x250 fs/splice.c:1332
       do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&pipe->mutex/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2938 [inline]
       check_prevs_add kernel/locking/lockdep.c:3061 [inline]
       validate_chain kernel/locking/lockdep.c:3676 [inline]
       __lock_acquire+0x2a17/0x5230 kernel/locking/lockdep.c:4902
       lock_acquire kernel/locking/lockdep.c:5512 [inline]
       lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5477
       __mutex_lock_common kernel/locking/mutex.c:949 [inline]
       __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1096
       pipe_lock_nested fs/pipe.c:66 [inline]
       pipe_lock+0x5a/0x70 fs/pipe.c:74
       iter_file_splice_write+0x183/0xc70 fs/splice.c:635
       do_splice_from fs/splice.c:767 [inline]
       do_splice+0xb7e/0x1940 fs/splice.c:1079
       __do_splice+0x134/0x250 fs/splice.c:1144
       __do_sys_splice fs/splice.c:1350 [inline]
       __se_sys_splice fs/splice.c:1332 [inline]
       __x64_sys_splice+0x198/0x250 fs/splice.c:1332
       do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
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

1 lock held by syz-executor.4/12393:
 #0: ffff8881448a8460 (sb_writers#5){.+.+}-{0:0}, at: __do_splice+0x134/0x250 fs/splice.c:1144

stack backtrace:
CPU: 0 PID: 12393 Comm: syz-executor.4 Not tainted 5.12.0-next-20210504-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2129
 check_prev_add kernel/locking/lockdep.c:2938 [inline]
 check_prevs_add kernel/locking/lockdep.c:3061 [inline]
 validate_chain kernel/locking/lockdep.c:3676 [inline]
 __lock_acquire+0x2a17/0x5230 kernel/locking/lockdep.c:4902
 lock_acquire kernel/locking/lockdep.c:5512 [inline]
 lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5477
 __mutex_lock_common kernel/locking/mutex.c:949 [inline]
 __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1096
 pipe_lock_nested fs/pipe.c:66 [inline]
 pipe_lock+0x5a/0x70 fs/pipe.c:74
 iter_file_splice_write+0x183/0xc70 fs/splice.c:635
 do_splice_from fs/splice.c:767 [inline]
 do_splice+0xb7e/0x1940 fs/splice.c:1079
 __do_splice+0x134/0x250 fs/splice.c:1144
 __do_sys_splice fs/splice.c:1350 [inline]
 __se_sys_splice fs/splice.c:1332 [inline]
 __x64_sys_splice+0x198/0x250 fs/splice.c:1332
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd13741d188 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 00000000004665f9
RDX: 0000000000000006 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00000000004bfce1 R08: 00000000088000cc R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007ffcaf06e7ef R14: 00007fd13741d300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
