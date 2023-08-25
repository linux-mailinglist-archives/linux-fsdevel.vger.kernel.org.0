Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D17788F66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 21:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjHYTvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 15:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjHYTuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:50:54 -0400
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0DC2689
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 12:50:49 -0700 (PDT)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1c093862623so15093705ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Aug 2023 12:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692993048; x=1693597848;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o7e1vWies/DOaZ3ASWipIdAkVy48iy3yEqiHzcJn1bQ=;
        b=QC5GHABKC/y7Fnt2P/1wz/ZYIroKt6E0DiDgJzCqwZ9WTEEaauIR5mBPvoKtF82obP
         EMCvA/MhMD9u+JK2OzuPHZHNCwYysq/yh7CK0XjoEE+5XpxBBjhTx4Ti2GFoonpeAjfO
         ykYaHSJOU/5qksE0sI2Y/usdy4DCn6wypnoEqwv/671Gg9rpulZ83CY1wP3Cw5s7/Cd2
         pOSDx5tpp6uA2neIKQ8h2FrG9egL6y91VpxoImzISAY8Bsg3MsX9EuuAEYNQw+fM70oM
         xcT1FTCFmJpbuFlAgswLdP03jmjn5ydqcG7x5k7IaAIJSE0MYB+N4PCZ/PfBc/gDnux2
         pIYA==
X-Gm-Message-State: AOJu0Yx+72Z9uGnwlV5h0S/C+qxNzF+OpNIMA/c9AjM2lSRwezG2hVcd
        6GbKAQo4wVWILC3S8ZJ+35SKJg+bylB6RJa8tuf2XoBKO4z9
X-Google-Smtp-Source: AGHT+IFLqTA9q5/x/vpyoJaI5CoNdPUW0LdQYmCBBE4S12+neVrz/DqAKvnxXY+7ui7xqh/hGZJytBeMRYEKxcWgFvnbM762rp4r
MIME-Version: 1.0
X-Received: by 2002:a17:903:1248:b0:1b8:a552:c8c9 with SMTP id
 u8-20020a170903124800b001b8a552c8c9mr7390745plh.13.1692993048670; Fri, 25 Aug
 2023 12:50:48 -0700 (PDT)
Date:   Fri, 25 Aug 2023 12:50:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045fa140603c4a969@google.com>
Subject: [syzbot] [btrfs?] possible deadlock in btrfs_search_slot (2)
From:   syzbot <syzbot+bf66ad948981797d2f1d@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f7757129e3de Merge tag 'v6.5-p3' of git://git.kernel.org/p..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16f597efa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b32f62c755c3a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=bf66ad948981797d2f1d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f91660680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b3a25ba80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e974b38a90bd/disk-f7757129.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fdc5c90820c9/vmlinux-f7757129.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b21384bf7402/bzImage-f7757129.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/404dc73f5fcc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bf66ad948981797d2f1d@syzkaller.appspotmail.com

BTRFS info (device loop0): enabling ssd optimizations
BTRFS info (device loop0): using spread ssd allocation scheme
BTRFS info (device loop0): turning on sync discard
BTRFS info (device loop0): using free space tree
======================================================
WARNING: possible circular locking dependency detected
6.5.0-rc7-syzkaller-00004-gf7757129e3de #0 Not tainted
------------------------------------------------------
syz-executor277/5012 is trying to acquire lock:
ffff88802df41710 (btrfs-tree-01){++++}-{3:3}, at: __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136

but task is already holding lock:
ffff88802df418e8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (btrfs-tree-00){++++}-{3:3}:
       down_read_nested+0x49/0x2f0 kernel/locking/rwsem.c:1645
       __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136
       btrfs_search_slot+0x13a4/0x2f80 fs/btrfs/ctree.c:2302
       btrfs_init_root_free_objectid+0x148/0x320 fs/btrfs/disk-io.c:4955
       btrfs_init_fs_root fs/btrfs/disk-io.c:1128 [inline]
       btrfs_get_root_ref+0x5ae/0xae0 fs/btrfs/disk-io.c:1338
       btrfs_get_fs_root fs/btrfs/disk-io.c:1390 [inline]
       open_ctree+0x29c8/0x3030 fs/btrfs/disk-io.c:3494
       btrfs_fill_super+0x1c7/0x2f0 fs/btrfs/super.c:1154
       btrfs_mount_root+0x7e0/0x910 fs/btrfs/super.c:1519
       legacy_get_tree+0xef/0x190 fs/fs_context.c:611
       vfs_get_tree+0x8c/0x270 fs/super.c:1519
       fc_mount fs/namespace.c:1112 [inline]
       vfs_kern_mount+0xbc/0x150 fs/namespace.c:1142
       btrfs_mount+0x39f/0xb50 fs/btrfs/super.c:1579
       legacy_get_tree+0xef/0x190 fs/fs_context.c:611
       vfs_get_tree+0x8c/0x270 fs/super.c:1519
       do_new_mount+0x28f/0xae0 fs/namespace.c:3335
       do_mount fs/namespace.c:3675 [inline]
       __do_sys_mount fs/namespace.c:3884 [inline]
       __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (btrfs-tree-01){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3142 [inline]
       check_prevs_add kernel/locking/lockdep.c:3261 [inline]
       validate_chain kernel/locking/lockdep.c:3876 [inline]
       __lock_acquire+0x39ff/0x7f70 kernel/locking/lockdep.c:5144
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5761
       down_read_nested+0x49/0x2f0 kernel/locking/rwsem.c:1645
       __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136
       btrfs_tree_read_lock fs/btrfs/locking.c:142 [inline]
       btrfs_read_lock_root_node+0x292/0x3c0 fs/btrfs/locking.c:281
       btrfs_search_slot_get_root fs/btrfs/ctree.c:1832 [inline]
       btrfs_search_slot+0x4ff/0x2f80 fs/btrfs/ctree.c:2154
       btrfs_lookup_inode+0xdc/0x480 fs/btrfs/inode-item.c:412
       btrfs_read_locked_inode fs/btrfs/inode.c:3892 [inline]
       btrfs_iget_path+0x2d9/0x1520 fs/btrfs/inode.c:5716
       btrfs_search_path_in_tree_user fs/btrfs/ioctl.c:1961 [inline]
       btrfs_ioctl_ino_lookup_user+0x77a/0xf50 fs/btrfs/ioctl.c:2105
       btrfs_ioctl+0xb0b/0xd40 fs/btrfs/ioctl.c:4683
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(btrfs-tree-00);
                               lock(btrfs-tree-01);
                               lock(btrfs-tree-00);
  rlock(btrfs-tree-01);

 *** DEADLOCK ***

1 lock held by syz-executor277/5012:
 #0: ffff88802df418e8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136

stack backtrace:
CPU: 1 PID: 5012 Comm: syz-executor277 Not tainted 6.5.0-rc7-syzkaller-00004-gf7757129e3de #0
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
 down_read_nested+0x49/0x2f0 kernel/locking/rwsem.c:1645
 __btrfs_tree_read_lock+0x2f/0x220 fs/btrfs/locking.c:136
 btrfs_tree_read_lock fs/btrfs/locking.c:142 [inline]
 btrfs_read_lock_root_node+0x292/0x3c0 fs/btrfs/locking.c:281
 btrfs_search_slot_get_root fs/btrfs/ctree.c:1832 [inline]
 btrfs_search_slot+0x4ff/0x2f80 fs/btrfs/ctree.c:2154
 btrfs_lookup_inode+0xdc/0x480 fs/btrfs/inode-item.c:412
 btrfs_read_locked_inode fs/btrfs/inode.c:3892 [inline]
 btrfs_iget_path+0x2d9/0x1520 fs/btrfs/inode.c:5716
 btrfs_search_path_in_tree_user fs/btrfs/ioctl.c:1961 [inline]
 btrfs_ioctl_ino_lookup_user+0x77a/0xf50 fs/btrfs/ioctl.c:2105
 btrfs_ioctl+0xb0b/0xd40 fs/btrfs/ioctl.c:4683
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0bec94ea39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcde5751e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffcde5753b8 RCX: 00007f0bec94ea39
RDX: 0000000020000040 RSI: 00000000d000943e RDI: 0000000000000004
RBP: 00007f0bec9c6610 R08:


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
