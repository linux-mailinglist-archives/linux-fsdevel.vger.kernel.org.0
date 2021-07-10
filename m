Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4DE3C3443
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jul 2021 13:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhGJLEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jul 2021 07:04:06 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:37464 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhGJLEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jul 2021 07:04:06 -0400
Received: by mail-il1-f200.google.com with SMTP id o18-20020a92d3920000b02901ee901c30f3so7793719ilo.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jul 2021 04:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+FcDO2zOq13VzQYFsm3JgNyCt0LszFez/T4skcJUOkY=;
        b=Le5X8n7i8K6tNlxr61CALY+L7d1t/YnfUNUKV2ZjyFDJRQQCHk8y0B+8+PEM/7sO5Z
         sh6pk+pEZA4IGwjdVRBKTJpdFkGGDQSwQcsdO7a89qBxFXCvgmzxYB652UleVpMeaYGE
         rXL7jSjcP3JgB7JmDY+HvgyFqkFhrLvPys8gYUsHQckU6QifTi/X6/wylRT1irFsfm3n
         Kg9x2BoUwS4CZWcqGA9u6n7FZmzqsHTPoDEg287YpvyPUS74cmzqJCSjkQIKV63fFZI4
         CWF8HzO/rFy3lmKaTIly6ms7YKQ54giyXS38h6bSEkKsliaItaBF+lFWEhp3g3KZG65L
         iW7g==
X-Gm-Message-State: AOAM532RCYOO8GZbNAGzKl/dXp2qCHCGNyLYXx8QcXKZz0CaQoGTnYF+
        qdgouPHNdtOlxWMRciyGFXvbwnsFL/pm08j/frXsqzVk/0do
X-Google-Smtp-Source: ABdhPJxRdBUdD5MFGHv/t6NV7ztbcmaZ6T/HtQ72FN68KckmLwOvQxHT58AKrnV7YAIo2zBZlVWXcpaGATVAbB8f4CLvmV/ANErq
MIME-Version: 1.0
X-Received: by 2002:a02:a913:: with SMTP id n19mr6111996jam.7.1625914881080;
 Sat, 10 Jul 2021 04:01:21 -0700 (PDT)
Date:   Sat, 10 Jul 2021 04:01:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec01e405c6c2cee3@google.com>
Subject: [syzbot] possible deadlock in loop_add
From:   syzbot <syzbot+118992efda475c16dfb0@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bp@alien8.de, christian.brauner@ubuntu.com,
        corbet@lwn.net, hch@lst.de, hpa@zytor.com, jmattson@google.com,
        johannes.thumshirn@wdc.com, joro@8bytes.org, josef@toxicpanda.com,
        kvm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, seanjc@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ee268dee Add linux-next specific files for 20210707
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12c39ae2300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59e1e3bbc3afca75
dashboard link: https://syzkaller.appspot.com/bug?extid=118992efda475c16dfb0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14698794300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e25ee4300000

The issue was bisected to:

commit 0f00b82e5413571ed225ddbccad6882d7ea60bc7
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Mar 8 07:45:50 2021 +0000

    block: remove the revalidate_disk method

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14bb406c300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16bb406c300000
console output: https://syzkaller.appspot.com/x/log.txt?x=12bb406c300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+118992efda475c16dfb0@syzkaller.appspotmail.com
Fixes: 0f00b82e5413 ("block: remove the revalidate_disk method")

======================================================
WARNING: possible circular locking dependency detected
5.13.0-next-20210707-syzkaller #0 Not tainted
------------------------------------------------------
systemd-udevd/8674 is trying to acquire lock:
ffffffff8c4875c8 (loop_ctl_mutex){+.+.}-{3:3}, at: loop_add+0x9c/0x8c0 drivers/block/loop.c:2250

but task is already holding lock:
ffffffff8c1f3e08 (major_names_lock){+.+.}-{3:3}, at: blk_request_module+0x25/0x1d0 block/genhd.c:657

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (major_names_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:959 [inline]
       __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
       __register_blkdev+0x2b/0x3e0 block/genhd.c:216
       register_mtd_blktrans+0x85/0x3c0 drivers/mtd/mtd_blkdevs.c:531
       do_one_initcall+0x103/0x650 init/main.c:1285
       do_initcall_level init/main.c:1360 [inline]
       do_initcalls init/main.c:1376 [inline]
       do_basic_setup init/main.c:1396 [inline]
       kernel_init_freeable+0x6b8/0x741 init/main.c:1598
       kernel_init+0x1a/0x1d0 init/main.c:1490
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #2 (mtd_table_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:959 [inline]
       __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
       blktrans_open+0x69/0x600 drivers/mtd/mtd_blkdevs.c:210
       blkdev_get_whole+0xa1/0x420 fs/block_dev.c:1251
       blkdev_get_by_dev.part.0+0x30c/0xdd0 fs/block_dev.c:1415
       blkdev_get_by_dev fs/block_dev.c:1504 [inline]
       blkdev_open+0x295/0x300 fs/block_dev.c:1510
       do_dentry_open+0x4c8/0x11d0 fs/open.c:826
       do_open fs/namei.c:3374 [inline]
       path_openat+0x1c23/0x27f0 fs/namei.c:3507
       do_filp_open+0x1aa/0x400 fs/namei.c:3534
       do_sys_openat2+0x16d/0x420 fs/open.c:1204
       do_sys_open fs/open.c:1220 [inline]
       __do_sys_open fs/open.c:1228 [inline]
       __se_sys_open fs/open.c:1224 [inline]
       __x64_sys_open+0x119/0x1c0 fs/open.c:1224
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&disk->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:959 [inline]
       __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
       del_gendisk+0x8b/0x770 block/genhd.c:587
       loop_remove drivers/block/loop.c:2347 [inline]
       loop_control_remove drivers/block/loop.c:2396 [inline]
       loop_control_ioctl+0x3b5/0x450 drivers/block/loop.c:2428
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:1069 [inline]
       __se_sys_ioctl fs/ioctl.c:1055 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (loop_ctl_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add kernel/locking/lockdep.c:3174 [inline]
       validate_chain kernel/locking/lockdep.c:3789 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
       lock_acquire kernel/locking/lockdep.c:5625 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
       __mutex_lock_common kernel/locking/mutex.c:959 [inline]
       __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
       loop_add+0x9c/0x8c0 drivers/block/loop.c:2250
       loop_probe+0x6a/0x80 drivers/block/loop.c:2360
       blk_request_module+0x111/0x1d0 block/genhd.c:660
       blkdev_get_no_open+0x1d5/0x250 fs/block_dev.c:1332
       blkdev_get_by_dev.part.0+0x25/0xdd0 fs/block_dev.c:1395
       blkdev_get_by_dev fs/block_dev.c:1504 [inline]
       blkdev_open+0x295/0x300 fs/block_dev.c:1510
       do_dentry_open+0x4c8/0x11d0 fs/open.c:826
       do_open fs/namei.c:3374 [inline]
       path_openat+0x1c23/0x27f0 fs/namei.c:3507
       do_filp_open+0x1aa/0x400 fs/namei.c:3534
       do_sys_openat2+0x16d/0x420 fs/open.c:1204
       do_sys_open fs/open.c:1220 [inline]
       __do_sys_open fs/open.c:1228 [inline]
       __se_sys_open fs/open.c:1224 [inline]
       __x64_sys_open+0x119/0x1c0 fs/open.c:1224
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  loop_ctl_mutex --> mtd_table_mutex --> major_names_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(major_names_lock);
                               lock(mtd_table_mutex);
                               lock(major_names_lock);
  lock(loop_ctl_mutex);

 *** DEADLOCK ***

1 lock held by systemd-udevd/8674:
 #0: ffffffff8c1f3e08 (major_names_lock){+.+.}-{3:3}, at: blk_request_module+0x25/0x1d0 block/genhd.c:657

stack backtrace:
CPU: 0 PID: 8674 Comm: systemd-udevd Not tainted 5.13.0-next-20210707-syzkaller #0
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
 loop_add+0x9c/0x8c0 drivers/block/loop.c:2250
 loop_probe+0x6a/0x80 drivers/block/loop.c:2360
 blk_request_module+0x111/0x1d0 block/genhd.c:660
 blkdev_get_no_open+0x1d5/0x250 fs/block_dev.c:1332
 blkdev_get_by_dev.part.0+0x25/0xdd0 fs/block_dev.c:1395
 blkdev_get_by_dev fs/block_dev.c:1504 [inline]
 blkdev_open+0x295/0x300 fs/block_dev.c:1510
 do_dentry_open+0x4c8/0x11d0 fs/open.c:826
 do_open fs/namei.c:3374 [inline]
 path_openat+0x1c23/0x27f0 fs/namei.c:3507
 do_filp_open+0x1aa/0x400 fs/namei.c:3534
 do_sys_openat2+0x16d/0x420 fs/open.c:1204
 do_sys_open fs/open.c:1220 [inline]
 __do_sys_open fs/open.c:1228 [inline]
 __se_sys_open fs/open.c:1224 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1224
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fb26e980840
Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24
RSP: 002b:00007fff25793e98 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000563b22a5f910 RCX: 00007fb26e980840
RDX: 0000563b21ce5fe3 RSI: 00000000000a0800 RDI: 0000563b22a5f850
RBP: 00007fff25794010 R08: 0000563b21ce5670 R09: 0000000000000010
R10: 0000563b21ce5d0c R11: 0000000000000246 R12: 00007fff25793f60
R13: 0000563b22a61030 R14: 0000000000000003 R15: 000000000000000e


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
