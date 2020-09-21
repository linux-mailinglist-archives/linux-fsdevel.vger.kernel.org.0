Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F40271EF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 11:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgIUJcX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 05:32:23 -0400
Received: from mail-io1-f80.google.com ([209.85.166.80]:33444 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgIUJcX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:32:23 -0400
Received: by mail-io1-f80.google.com with SMTP id l22so9481167iol.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2020 02:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xhOKhclXS6SCCXE9CyYDtCu9rGB/IQltkOt4LhUGfHM=;
        b=eUfh9yj/+Q4UgVlyPdTjGSHKO/8ueiySoCTT6rsn8HfSM6GUHHjlywhy9Yp7adIrBi
         B24FtpZ6gmcSSwJmEuee2UgU3OgsDZLnJ6WgYrysraRLvHA+1PG/UAX0zR/5GU9bj30V
         MpOBBaKQ1eyD+vjRS1EHAI4xuotYyo2IorqSyue6snD6uGjOXp73B4zUxEHU+Rq0IlTV
         NQmn5Gz+fGW9iYamt8ucZlJLhk7Obfehw/GhFkUwrjwovrrTCGYzoixnt4S1u0z56ylu
         h1vjlXVUBP66bE8vNxEH9sGECbbIouKpH1Ykl7AAQuyz0T7t5Nz3YqsAczpD1dmUrNqo
         6TDQ==
X-Gm-Message-State: AOAM532djvxygU2sVWAhF0+Ywvq471lTf/T0xevGTrghMMrSG+P+7Lr0
        6YGsF/L3DVdwWSemBQc3JH0lytIXQlA3wf+2JULze3oTmhIo
X-Google-Smtp-Source: ABdhPJzF/Qmccplo3rrXpK4OJvvk/clqQZdjeFJpBIKSxsW18eqlTxJgS4V8sy3jKvtDRSxC1ZjvzBCWg324Ln7woufBuXdveAun
MIME-Version: 1.0
X-Received: by 2002:a92:d40c:: with SMTP id q12mr26446396ilm.169.1600680741305;
 Mon, 21 Sep 2020 02:32:21 -0700 (PDT)
Date:   Mon, 21 Sep 2020 02:32:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc04d105afcf86d7@google.com>
Subject: possible deadlock in blkdev_put
From:   syzbot <syzbot+84a0634dc5d21d488419@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    325d0eab Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102425d9900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b12e84189082991c
dashboard link: https://syzkaller.appspot.com/bug?extid=84a0634dc5d21d488419
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+84a0634dc5d21d488419@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.9.0-rc5-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.0/6878 is trying to acquire lock:
ffff88804c17d780 (&bdev->bd_mutex){+.+.}-{3:3}, at: blkdev_put+0x30/0x520 fs/block_dev.c:1804

but task is already holding lock:
ffff8880908cfce0 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: close_fs_devices.part.0+0x2e/0x800 fs/btrfs/volumes.c:1159

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x134/0x10e0 kernel/locking/mutex.c:1103
       btrfs_finish_chunk_alloc+0x281/0xf90 fs/btrfs/volumes.c:5255
       btrfs_create_pending_block_groups+0x2f3/0x700 fs/btrfs/block-group.c:2109
       __btrfs_end_transaction+0xf5/0x690 fs/btrfs/transaction.c:916
       find_free_extent_update_loop fs/btrfs/extent-tree.c:3807 [inline]
       find_free_extent+0x23b7/0x2e60 fs/btrfs/extent-tree.c:4127
       btrfs_reserve_extent+0x166/0x460 fs/btrfs/extent-tree.c:4206
       cow_file_range+0x3de/0x9b0 fs/btrfs/inode.c:1063
       btrfs_run_delalloc_range+0x2cf/0x1410 fs/btrfs/inode.c:1838
       writepage_delalloc+0x150/0x460 fs/btrfs/extent_io.c:3439
       __extent_writepage+0x441/0xd00 fs/btrfs/extent_io.c:3653
       extent_write_cache_pages.constprop.0+0x69d/0x1040 fs/btrfs/extent_io.c:4249
       extent_writepages+0xcd/0x2b0 fs/btrfs/extent_io.c:4370
       do_writepages+0xec/0x290 mm/page-writeback.c:2352
       __writeback_single_inode+0x125/0x1400 fs/fs-writeback.c:1461
       writeback_sb_inodes+0x53d/0xf40 fs/fs-writeback.c:1721
       wb_writeback+0x2ad/0xd40 fs/fs-writeback.c:1894
       wb_do_writeback fs/fs-writeback.c:2039 [inline]
       wb_workfn+0x2dc/0x13e0 fs/fs-writeback.c:2080
       process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
       worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
       kthread+0x3b5/0x4a0 kernel/kthread.c:292
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

-> #3 (sb_internal#2){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write+0x234/0x470 fs/super.c:1672
       sb_start_intwrite include/linux/fs.h:1690 [inline]
       start_transaction+0xbe7/0x1170 fs/btrfs/transaction.c:624
       find_free_extent_update_loop fs/btrfs/extent-tree.c:3789 [inline]
       find_free_extent+0x25e1/0x2e60 fs/btrfs/extent-tree.c:4127
       btrfs_reserve_extent+0x166/0x460 fs/btrfs/extent-tree.c:4206
       cow_file_range+0x3de/0x9b0 fs/btrfs/inode.c:1063
       btrfs_run_delalloc_range+0x2cf/0x1410 fs/btrfs/inode.c:1838
       writepage_delalloc+0x150/0x460 fs/btrfs/extent_io.c:3439
       __extent_writepage+0x441/0xd00 fs/btrfs/extent_io.c:3653
       extent_write_cache_pages.constprop.0+0x69d/0x1040 fs/btrfs/extent_io.c:4249
       extent_writepages+0xcd/0x2b0 fs/btrfs/extent_io.c:4370
       do_writepages+0xec/0x290 mm/page-writeback.c:2352
       __writeback_single_inode+0x125/0x1400 fs/fs-writeback.c:1461
       writeback_sb_inodes+0x53d/0xf40 fs/fs-writeback.c:1721
       wb_writeback+0x2ad/0xd40 fs/fs-writeback.c:1894
       wb_do_writeback fs/fs-writeback.c:2039 [inline]
       wb_workfn+0x2dc/0x13e0 fs/fs-writeback.c:2080
       process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
       worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
       kthread+0x3b5/0x4a0 kernel/kthread.c:292
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

-> #2 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}:
       __flush_work+0x60e/0xac0 kernel/workqueue.c:3041
       wb_shutdown+0x180/0x220 mm/backing-dev.c:355
       bdi_unregister+0x174/0x590 mm/backing-dev.c:872
       del_gendisk+0x820/0xa10 block/genhd.c:933
       loop_remove drivers/block/loop.c:2192 [inline]
       loop_control_ioctl drivers/block/loop.c:2291 [inline]
       loop_control_ioctl+0x3b1/0x480 drivers/block/loop.c:2257
       vfs_ioctl fs/ioctl.c:48 [inline]
       __do_sys_ioctl fs/ioctl.c:753 [inline]
       __se_sys_ioctl fs/ioctl.c:739 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #1 (loop_ctl_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x134/0x10e0 kernel/locking/mutex.c:1103
       lo_open+0x19/0xd0 drivers/block/loop.c:1893
       __blkdev_get+0x759/0x1aa0 fs/block_dev.c:1507
       blkdev_get fs/block_dev.c:1639 [inline]
       blkdev_open+0x227/0x300 fs/block_dev.c:1753
       do_dentry_open+0x4b9/0x11b0 fs/open.c:817
       do_open fs/namei.c:3251 [inline]
       path_openat+0x1b9a/0x2730 fs/namei.c:3368
       do_filp_open+0x17e/0x3c0 fs/namei.c:3395
       do_sys_openat2+0x16d/0x420 fs/open.c:1168
       do_sys_open fs/open.c:1184 [inline]
       __do_sys_open fs/open.c:1192 [inline]
       __se_sys_open fs/open.c:1188 [inline]
       __x64_sys_open+0x119/0x1c0 fs/open.c:1188
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (&bdev->bd_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2496 [inline]
       check_prevs_add kernel/locking/lockdep.c:2601 [inline]
       validate_chain kernel/locking/lockdep.c:3218 [inline]
       __lock_acquire+0x2a96/0x5780 kernel/locking/lockdep.c:4426
       lock_acquire+0x1f3/0xae0 kernel/locking/lockdep.c:5006
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x134/0x10e0 kernel/locking/mutex.c:1103
       blkdev_put+0x30/0x520 fs/block_dev.c:1804
       btrfs_close_bdev fs/btrfs/volumes.c:1117 [inline]
       btrfs_close_bdev fs/btrfs/volumes.c:1107 [inline]
       btrfs_close_one_device fs/btrfs/volumes.c:1133 [inline]
       close_fs_devices.part.0+0x1a4/0x800 fs/btrfs/volumes.c:1161
       close_fs_devices fs/btrfs/volumes.c:1193 [inline]
       btrfs_close_devices+0x95/0x1f0 fs/btrfs/volumes.c:1179
       close_ctree+0x688/0x6cb fs/btrfs/disk-io.c:4149
       generic_shutdown_super+0x144/0x370 fs/super.c:464
       kill_anon_super+0x36/0x60 fs/super.c:1108
       btrfs_kill_super+0x38/0x50 fs/btrfs/super.c:2265
       deactivate_locked_super+0x94/0x160 fs/super.c:335
       deactivate_super+0xad/0xd0 fs/super.c:366
       cleanup_mnt+0x3a3/0x530 fs/namespace.c:1118
       task_work_run+0xdd/0x190 kernel/task_work.c:141
       tracehook_notify_resume include/linux/tracehook.h:188 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:163 [inline]
       exit_to_user_mode_prepare+0x1e1/0x200 kernel/entry/common.c:190
       syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:265
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

Chain exists of:
  &bdev->bd_mutex --> sb_internal#2 --> &fs_devs->device_list_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&fs_devs->device_list_mutex);
                               lock(sb_internal#2);
                               lock(&fs_devs->device_list_mutex);
  lock(&bdev->bd_mutex);

 *** DEADLOCK ***

3 locks held by syz-executor.0/6878:
 #0: ffff88809070c0e0 (&type->s_umount_key#70){++++}-{3:3}, at: deactivate_super+0xa5/0xd0 fs/super.c:365
 #1: ffffffff8a5b37a8 (uuid_mutex){+.+.}-{3:3}, at: btrfs_close_devices+0x23/0x1f0 fs/btrfs/volumes.c:1178
 #2: ffff8880908cfce0 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: close_fs_devices.part.0+0x2e/0x800 fs/btrfs/volumes.c:1159

stack backtrace:
CPU: 0 PID: 6878 Comm: syz-executor.0 Not tainted 5.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 check_noncircular+0x324/0x3e0 kernel/locking/lockdep.c:1827
 check_prev_add kernel/locking/lockdep.c:2496 [inline]
 check_prevs_add kernel/locking/lockdep.c:2601 [inline]
 validate_chain kernel/locking/lockdep.c:3218 [inline]
 __lock_acquire+0x2a96/0x5780 kernel/locking/lockdep.c:4426
 lock_acquire+0x1f3/0xae0 kernel/locking/lockdep.c:5006
 __mutex_lock_common kernel/locking/mutex.c:956 [inline]
 __mutex_lock+0x134/0x10e0 kernel/locking/mutex.c:1103
 blkdev_put+0x30/0x520 fs/block_dev.c:1804
 btrfs_close_bdev fs/btrfs/volumes.c:1117 [inline]
 btrfs_close_bdev fs/btrfs/volumes.c:1107 [inline]
 btrfs_close_one_device fs/btrfs/volumes.c:1133 [inline]
 close_fs_devices.part.0+0x1a4/0x800 fs/btrfs/volumes.c:1161
 close_fs_devices fs/btrfs/volumes.c:1193 [inline]
 btrfs_close_devices+0x95/0x1f0 fs/btrfs/volumes.c:1179
 close_ctree+0x688/0x6cb fs/btrfs/disk-io.c:4149
 generic_shutdown_super+0x144/0x370 fs/super.c:464
 kill_anon_super+0x36/0x60 fs/super.c:1108
 btrfs_kill_super+0x38/0x50 fs/btrfs/super.c:2265
 deactivate_locked_super+0x94/0x160 fs/super.c:335
 deactivate_super+0xad/0xd0 fs/super.c:366
 cleanup_mnt+0x3a3/0x530 fs/namespace.c:1118
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:163 [inline]
 exit_to_user_mode_prepare+0x1e1/0x200 kernel/entry/common.c:190
 syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:265
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x460027
Code: 64 89 04 25 d0 02 00 00 58 5f ff d0 48 89 c7 e8 2f be ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 fd 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff59216328 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000076035 RCX: 0000000000460027
RDX: 0000000000403188 RSI: 0000000000000002 RDI: 00007fff592163d0
RBP: 0000000000000333 R08: 0000000000000000 R09: 000000000000000b
R10: 0000000000000005 R11: 0000000000000246 R12: 00007fff59217460
R13: 0000000002df2a60 R14: 0000000000000000 R15: 00007fff59217460


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
