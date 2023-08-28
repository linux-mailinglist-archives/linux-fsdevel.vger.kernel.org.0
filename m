Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF6B78BB55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 01:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbjH1XEU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 19:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjH1XED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 19:04:03 -0400
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C1B13E
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 16:04:00 -0700 (PDT)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-68a3d6ce18cso4294638b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 16:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693263839; x=1693868639;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3EyD6GCV33sbZCnmHBElQNnpDXQGgPdQoSKWur56f0=;
        b=NFkax8jsMs95f68+YE9DJcCusTSBYlyqRqaPA5dnC/jZBj/Hk8ih3pBoEalLz8kWw8
         HeSadepOKpNHWybsA2gItKaNd9R21L0s3uoBIZlILwkq6wwYjh3wO++gczNvasXAyTrP
         a1O1KLg1zQSoS73VPiMK48kl5E5t+pL5UKAu8ITVhCg2ZoFzF0nL3XbCjSLz+0raYK5L
         NNZTFfOXKdKIRNj7AMqFxaPwVkxR2wlvlYQvWa3VocH9I4Y5W2m/GR/t9VeYdN23pp6N
         /TebFCaNh34nlmChBuGYpO1QnAnqhD8swkZYNq6Z7qotiWtn1OJcSZUW8JK9c3jYWJew
         BAQw==
X-Gm-Message-State: AOJu0YwrpouLHYukNd5QOhYp/YWlrOeilRmREp8guhJufmLUM6vZJmhX
        HGN6gE+doqWGKIYsrsSVhNs8t9Mzbe25KsVBGe2gvFUXKsO6
X-Google-Smtp-Source: AGHT+IG0HW+vNihFOqgV4qEIL6QZcE4QeLNSfjjxp/5WphEN9H4NozDr6k9hpYRP0Dre90e1eu6RQxMFW9N501mHJOvW7IGCpeyQ
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:4a12:b0:68a:6787:8413 with SMTP id
 do18-20020a056a004a1200b0068a67878413mr216060pfb.3.1693263839604; Mon, 28 Aug
 2023 16:03:59 -0700 (PDT)
Date:   Mon, 28 Aug 2023 16:03:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000abba27060403b5bd@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in __btrfs_release_delayed_node (3)
From:   syzbot <syzbot+a379155f07c134ea9879@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    93f5de5f648d Merge tag 'acpi-6.5-rc8' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f71340680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=a379155f07c134ea9879
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12684fa7a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9f3fa40677fd/disk-93f5de5f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1aa00d4d7c58/vmlinux-93f5de5f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/361b7a3f46b3/bzImage-93f5de5f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/696d28540778/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a379155f07c134ea9879@syzkaller.appspotmail.com

BTRFS info (device loop2): enabling ssd optimizations
======================================================
WARNING: possible circular locking dependency detected
6.5.0-rc7-syzkaller-00024-g93f5de5f648d #0 Not tainted
------------------------------------------------------
syz-executor.2/13257 is trying to acquire lock:
ffff88801835c0c0 (&delayed_node->mutex){+.+.}-{3:3}, at: __btrfs_release_delayed_node+0x9a/0xaa0 fs/btrfs/delayed-inode.c:256

but task is already holding lock:
ffff88802a5ab8e8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_lock+0x3c/0x2a0 fs/btrfs/locking.c:198

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (btrfs-tree-00){++++}-{3:3}:
       __lock_release kernel/locking/lockdep.c:5475 [inline]
       lock_release+0x36f/0x9d0 kernel/locking/lockdep.c:5781
       up_write+0x79/0x580 kernel/locking/rwsem.c:1625
       btrfs_tree_unlock_rw fs/btrfs/locking.h:189 [inline]
       btrfs_unlock_up_safe+0x179/0x3b0 fs/btrfs/locking.c:239
       search_leaf fs/btrfs/ctree.c:1986 [inline]
       btrfs_search_slot+0x2511/0x2f80 fs/btrfs/ctree.c:2230
       btrfs_insert_empty_items+0x9c/0x180 fs/btrfs/ctree.c:4376
       btrfs_insert_delayed_item fs/btrfs/delayed-inode.c:746 [inline]
       btrfs_insert_delayed_items fs/btrfs/delayed-inode.c:824 [inline]
       __btrfs_commit_inode_delayed_items+0xd24/0x2410 fs/btrfs/delayed-inode.c:1111
       __btrfs_run_delayed_items+0x1db/0x430 fs/btrfs/delayed-inode.c:1153
       flush_space+0x269/0xe70 fs/btrfs/space-info.c:723
       btrfs_async_reclaim_metadata_space+0x106/0x350 fs/btrfs/space-info.c:1078
       process_one_work+0x92c/0x12c0 kernel/workqueue.c:2600
       worker_thread+0xa63/0x1210 kernel/workqueue.c:2751
       kthread+0x2b8/0x350 kernel/kthread.c:389
       ret_from_fork+0x2e/0x60 arch/x86/kernel/process.c:145
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

-> #0 (&delayed_node->mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3142 [inline]
       check_prevs_add kernel/locking/lockdep.c:3261 [inline]
       validate_chain kernel/locking/lockdep.c:3876 [inline]
       __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5144
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
       __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
       __btrfs_release_delayed_node+0x9a/0xaa0 fs/btrfs/delayed-inode.c:256
       btrfs_release_delayed_node fs/btrfs/delayed-inode.c:281 [inline]
       __btrfs_run_delayed_items+0x2b5/0x430 fs/btrfs/delayed-inode.c:1156
       btrfs_commit_transaction+0x859/0x2ff0 fs/btrfs/transaction.c:2276
       btrfs_sync_file+0xf56/0x1330 fs/btrfs/file.c:1988
       vfs_fsync_range fs/sync.c:188 [inline]
       vfs_fsync fs/sync.c:202 [inline]
       do_fsync fs/sync.c:212 [inline]
       __do_sys_fsync fs/sync.c:220 [inline]
       __se_sys_fsync fs/sync.c:218 [inline]
       __x64_sys_fsync+0x196/0x1e0 fs/sync.c:218
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-tree-00);
                               lock(&delayed_node->mutex);
                               lock(btrfs-tree-00);
  lock(&delayed_node->mutex);

 *** DEADLOCK ***

3 locks held by syz-executor.2/13257:
 #0: ffff88802c1ee370 (btrfs_trans_num_writers){++++}-{0:0}, at: spin_unlock include/linux/spinlock.h:391 [inline]
 #0: ffff88802c1ee370 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0xb87/0xe00 fs/btrfs/transaction.c:287
 #1: ffff88802c1ee398 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0xbb2/0xe00 fs/btrfs/transaction.c:288
 #2: ffff88802a5ab8e8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_lock+0x3c/0x2a0 fs/btrfs/locking.c:198

stack backtrace:
CPU: 0 PID: 13257 Comm: syz-executor.2 Not tainted 6.5.0-rc7-syzkaller-00024-g93f5de5f648d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x375/0x4a0 kernel/locking/lockdep.c:2195
 check_prev_add kernel/locking/lockdep.c:3142 [inline]
 check_prevs_add kernel/locking/lockdep.c:3261 [inline]
 validate_chain kernel/locking/lockdep.c:3876 [inline]
 __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5144
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
 __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
 __btrfs_release_delayed_node+0x9a/0xaa0 fs/btrfs/delayed-inode.c:256
 btrfs_release_delayed_node fs/btrfs/delayed-inode.c:281 [inline]
 __btrfs_run_delayed_items+0x2b5/0x430 fs/btrfs/delayed-inode.c:1156
 btrfs_commit_transaction+0x859/0x2ff0 fs/btrfs/transaction.c:2276
 btrfs_sync_file+0xf56/0x1330 fs/btrfs/file.c:1988
 vfs_fsync_range fs/sync.c:188 [inline]
 vfs_fsync fs/sync.c:202 [inline]
 do_fsync fs/sync.c:212 [inline]
 __do_sys_fsync fs/sync.c:220 [inline]
 __se_sys_fsync fs/sync.c:218 [inline]
 __x64_sys_fsync+0x196/0x1e0 fs/sync.c:218
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3ad047cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3ad12510c8 EFLAGS: 00000246 ORIG_RAX: 000000000000004a
RAX: ffffffffffffffda RBX: 00007f3ad059bf80 RCX: 00007f3ad047cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f3ad04c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f3ad059bf80 R15: 00007ffe56af92f8
 </TASK>
------------[ cut here ]------------
BTRFS: Transaction aborted (error -17)
WARNING: CPU: 1 PID: 13257 at fs/btrfs/delayed-inode.c:1158 __btrfs_run_delayed_items+0x3d3/0x430 fs/btrfs/delayed-inode.c:1158
Modules linked in:
CPU: 1 PID: 13257 Comm: syz-executor.2 Not tainted 6.5.0-rc7-syzkaller-00024-g93f5de5f648d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:__btrfs_run_delayed_items+0x3d3/0x430 fs/btrfs/delayed-inode.c:1158
Code: fe c1 38 c1 0f 8c b5 fc ff ff 48 89 ef e8 55 66 43 fe e9 a8 fc ff ff e8 9b 94 ea fd 48 c7 c7 60 93 4b 8b 89 de e8 0d ae b1 fd <0f> 0b e9 69 ff ff ff f3 0f 1e fa e8 7d 94 ea fd 48 8b 44 24 10 42
RSP: 0018:ffffc9000c68f950 EFLAGS: 00010246
RAX: 326a4566d401f400 RBX: 00000000ffffffef RCX: ffff888023010000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff888075a44ca0 R08: ffffffff8152d442 R09: 1ffff920018d1ea0
R10: dffffc0000000000 R11: fffff520018d1ea1 R12: dffffc0000000000
R13: ffff888075a44c78 R14: 0000000000000000 R15: ffff888075a44ca0
FS:  00007f3ad12516c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa51c7f8290 CR3: 0000000022fbc000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_commit_transaction+0x859/0x2ff0 fs/btrfs/transaction.c:2276
 btrfs_sync_file+0xf56/0x1330 fs/btrfs/file.c:1988
 vfs_fsync_range fs/sync.c:188 [inline]
 vfs_fsync fs/sync.c:202 [inline]
 do_fsync fs/sync.c:212 [inline]
 __do_sys_fsync fs/sync.c:220 [inline]
 __se_sys_fsync fs/sync.c:218 [inline]
 __x64_sys_fsync+0x196/0x1e0 fs/sync.c:218
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3ad047cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3ad12510c8 EFLAGS: 00000246 ORIG_RAX: 000000000000004a
RAX: ffffffffffffffda RBX: 00007f3ad059bf80 RCX: 00007f3ad047cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f3ad04c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f3ad059bf80 R15: 00007ffe56af92f8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
