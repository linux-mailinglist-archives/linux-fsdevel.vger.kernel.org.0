Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1140A3DC944
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Aug 2021 03:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhHABea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Jul 2021 21:34:30 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:53900 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhHABe3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Jul 2021 21:34:29 -0400
Received: by mail-io1-f69.google.com with SMTP id w3-20020a0566020343b02905393057ad92so8674410iou.20
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jul 2021 18:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+BmCLKfGbmhOmVKnJAWwYKo2JurrbhdRyr3nqkFXI6Y=;
        b=njghu4UnVw4a7D/yDX+TL7jUBMa3L2VrBfVFmSfSNGBKsdw93GS2L0M5J8kIi3EP3v
         f40Aw2+W4fbPLeQA/JDj/a2iTtz2ptQydZ72Lwr4fH1YvZTXrXGKkdWwDkimXm78rpHP
         auw/ToYyz+xHutvjuvg0CRp5dpGPH6BTzlyLrfgN44KLSp8MVy7bLNzgsq+aDOJFNP8P
         8rI7vxkLsgeQgmWDpxI3d6dDItkcdnWVW9rzEN4bjbX71taCcXZfkOIHIdK54FrtHAyP
         tPxKHm5sn+pAL3SwJ7uiMw4+A+fcZOlAxdkDnz77y8bpGEbpbJ7SQTUWJ0GyYAsKJ3U+
         bsuA==
X-Gm-Message-State: AOAM5339WCcbH174t3op4USnq0NNsJOERlIJAXc8KeFEFq+cek17bMgr
        wBU0fiNkhQaLYuME4T1srzPhMGAvnyAJOwa6BP00yFQHw59b
X-Google-Smtp-Source: ABdhPJwwonMRfk4RmD7zoeoJFgrUmOPtPcUIvzZTAWN5pYe/2CrClDB6rCoK7JxrtG8gOpsMr86G7NjXbPY3ltU+tyA4iGR/vOR0
MIME-Version: 1.0
X-Received: by 2002:a6b:c9d3:: with SMTP id z202mr4765053iof.44.1627781662413;
 Sat, 31 Jul 2021 18:34:22 -0700 (PDT)
Date:   Sat, 31 Jul 2021 18:34:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2999305c87573a6@google.com>
Subject: [syzbot] possible deadlock in seq_read_iter
From:   syzbot <syzbot+79e94c217e36db0be7ff@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7d549995d4e0 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157166b6300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1dee114394f7d2c2
dashboard link: https://syzkaller.appspot.com/bug?extid=79e94c217e36db0be7ff
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79e94c217e36db0be7ff@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.14.0-rc3-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.3/12264 is trying to acquire lock:
ffff8880359f56a8 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xdf/0x1240 fs/seq_file.c:182

but task is already holding lock:
ffff888011080460 (sb_writers#3){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1325 [inline]
ffff888011080460 (sb_writers#3){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1311 [inline]
ffff888011080460 (sb_writers#3){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1311

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (sb_writers#3){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1763 [inline]
       sb_start_write include/linux/fs.h:1833 [inline]
       file_start_write include/linux/fs.h:3040 [inline]
       lo_write_bvec+0x3b6/0x6d0 drivers/block/loop.c:286
       lo_write_simple drivers/block/loop.c:309 [inline]
       do_req_filebacked drivers/block/loop.c:627 [inline]
       loop_handle_cmd drivers/block/loop.c:2138 [inline]
       loop_process_work+0xc60/0x24e0 drivers/block/loop.c:2178
       process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
       kthread+0x3e5/0x4d0 kernel/kthread.c:319
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #6 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
       process_one_work+0x8fc/0x1630 kernel/workqueue.c:2252
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
       kthread+0x3e5/0x4d0 kernel/kthread.c:319
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #5 ((wq_completion)loop2){+.+.}-{0:0}:
       flush_workqueue+0x110/0x1600 kernel/workqueue.c:2787
       drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2952
       destroy_workqueue+0x71/0x800 kernel/workqueue.c:4389
       __loop_clr_fd+0x1f8/0x1540 drivers/block/loop.c:1304
       loop_clr_fd drivers/block/loop.c:1430 [inline]
       lo_ioctl+0x3c3/0x1600 drivers/block/loop.c:1786
       blkdev_ioctl+0x2a1/0x6d0 block/ioctl.c:585
       block_ioctl+0xf9/0x140 fs/block_dev.c:1602
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:1069 [inline]
       __se_sys_ioctl fs/ioctl.c:1055 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #4 (&lo->lo_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:959 [inline]
       __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
       lo_open+0x75/0x120 drivers/block/loop.c:1976
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

-> #3 (&disk->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:959 [inline]
       __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
       blkdev_get_by_dev.part.0+0x9d/0xdd0 fs/block_dev.c:1408
       blkdev_get_by_dev+0x6b/0x80 fs/block_dev.c:1448
       swsusp_check+0x4d/0x270 kernel/power/swap.c:1525
       software_resume.part.0+0x102/0x1f0 kernel/power/hibernate.c:977
       software_resume kernel/power/hibernate.c:86 [inline]
       resume_store+0x161/0x190 kernel/power/hibernate.c:1179
       kobj_attr_store+0x50/0x80 lib/kobject.c:856
       sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
       kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
       call_write_iter include/linux/fs.h:2114 [inline]
       new_sync_write+0x426/0x650 fs/read_write.c:518
       vfs_write+0x75a/0xa40 fs/read_write.c:605
       ksys_write+0x12d/0x250 fs/read_write.c:658
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (system_transition_mutex/1){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:959 [inline]
       __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
       software_resume.part.0+0x19/0x1f0 kernel/power/hibernate.c:932
       software_resume kernel/power/hibernate.c:86 [inline]
       resume_store+0x161/0x190 kernel/power/hibernate.c:1179
       kobj_attr_store+0x50/0x80 lib/kobject.c:856
       sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
       kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
       call_write_iter include/linux/fs.h:2114 [inline]
       new_sync_write+0x426/0x650 fs/read_write.c:518
       vfs_write+0x75a/0xa40 fs/read_write.c:605
       ksys_write+0x12d/0x250 fs/read_write.c:658
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&of->mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:959 [inline]
       __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
       kernfs_seq_start+0x4b/0x260 fs/kernfs/file.c:112
       seq_read_iter+0x2c7/0x1240 fs/seq_file.c:225
       kernfs_fop_read_iter+0x44f/0x5f0 fs/kernfs/file.c:241
       call_read_iter include/linux/fs.h:2108 [inline]
       new_sync_read+0x41e/0x6e0 fs/read_write.c:415
       vfs_read+0x35c/0x570 fs/read_write.c:496
       ksys_read+0x12d/0x250 fs/read_write.c:634
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&p->lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add kernel/locking/lockdep.c:3174 [inline]
       validate_chain kernel/locking/lockdep.c:3789 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
       lock_acquire kernel/locking/lockdep.c:5625 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
       __mutex_lock_common kernel/locking/mutex.c:959 [inline]
       __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
       seq_read_iter+0xdf/0x1240 fs/seq_file.c:182
       call_read_iter include/linux/fs.h:2108 [inline]
       generic_file_splice_read+0x450/0x6c0 fs/splice.c:311
       do_splice_to+0x1bf/0x250 fs/splice.c:796
       splice_direct_to_actor+0x2c2/0x8c0 fs/splice.c:870
       do_splice_direct+0x1b3/0x280 fs/splice.c:979
       do_sendfile+0x9f0/0x1120 fs/read_write.c:1260
       __do_sys_sendfile64 fs/read_write.c:1325 [inline]
       __se_sys_sendfile64 fs/read_write.c:1311 [inline]
       __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1311
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  &p->lock --> (work_completion)(&lo->rootcg_work) --> sb_writers#3

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_writers#3);
                               lock((work_completion)(&lo->rootcg_work));
                               lock(sb_writers#3);
  lock(&p->lock);

 *** DEADLOCK ***

1 lock held by syz-executor.3/12264:
 #0: ffff888011080460 (sb_writers#3){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1325 [inline]
 #0: ffff888011080460 (sb_writers#3){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1311 [inline]
 #0: ffff888011080460 (sb_writers#3){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1311

stack backtrace:
CPU: 1 PID: 12264 Comm: syz-executor.3 Not tainted 5.14.0-rc3-syzkaller #0
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
 seq_read_iter+0xdf/0x1240 fs/seq_file.c:182
 call_read_iter include/linux/fs.h:2108 [inline]
 generic_file_splice_read+0x450/0x6c0 fs/splice.c:311
 do_splice_to+0x1bf/0x250 fs/splice.c:796
 splice_direct_to_actor+0x2c2/0x8c0 fs/splice.c:870
 do_splice_direct+0x1b3/0x280 fs/splice.c:979
 do_sendfile+0x9f0/0x1120 fs/read_write.c:1260
 __do_sys_sendfile64 fs/read_write.c:1325 [inline]
 __se_sys_sendfile64 fs/read_write.c:1311 [inline]
 __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1311
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665e9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3779708188 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665e9
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000004
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000fffffffe R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffff725d56f R14: 00007f3779708300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
