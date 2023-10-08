Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC837BCF0D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Oct 2023 17:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344830AbjJHPO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Oct 2023 11:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjJHPO5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Oct 2023 11:14:57 -0400
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BC394
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Oct 2023 08:14:55 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3ae5ac8de14so6201907b6e.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Oct 2023 08:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696778095; x=1697382895;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2DHDDUtctSCqtMBQ2VyhSBX6FAyheiTLePTjZGIw1w=;
        b=CMwz5tnBG4On7QG1aSO2tTm2/otu/JBr/42ufGfqkso4oQOSKqUvzJ8v4Dkkbv1X8e
         aNc8g2Z9HeuB1A6bgciBLdO1SiOUyTZmS4O7MEhL7tMZueVDfxDneps7ZeM9VNm5hBS9
         Yp4lMJ0CdKZYecVwjzUJryr+67dLFuIb1DKMDC4qVfBRC76l0lKMA1YeB8f0WjUmsflf
         5KM4YfSDuKEBsaiZplE/3f+AZmzGIw5RgqAK+Xt16onJx4NVEjJoZK02NC2XLOPcAb6H
         wrLfPy6g6n0LUkbW3Z/OegUCy+yqU45n5B7XfhNPmBziFqwReN+3rdbbK7CcQ3Vahqty
         r9oQ==
X-Gm-Message-State: AOJu0YzgAwUu19iBFrJG52F7hSlmknFmfMZODyz5UyLBIT4okbdryPCT
        d3Fsy6GqctuHT0cE+btbzn7ZDcK3UdBftDHCHOR0Dpr6LXLk
X-Google-Smtp-Source: AGHT+IHE8AI0usO+B36Eq4atL4szUnnGaud+yd+4gTI/lyVZ+p5zavEblfDupESWFZtTFtrjfh+vR+1OnvMb/LoVkqBWd8HeU7hu
MIME-Version: 1.0
X-Received: by 2002:a05:6808:201c:b0:3a7:7e66:2197 with SMTP id
 q28-20020a056808201c00b003a77e662197mr6743245oiw.2.1696778094870; Sun, 08 Oct
 2023 08:14:54 -0700 (PDT)
Date:   Sun, 08 Oct 2023 08:14:54 -0700
In-Reply-To: <0000000000001825ce06047bf2a6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b8520060735ef76@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in super_lock
From:   syzbot <syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com>
To:     chao@kernel.org, hdanton@sina.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        terrelln@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    19af4a4ed414 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1627a911680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80eedef55cd21fa4
dashboard link: https://syzkaller.appspot.com/bug?extid=062317ea1d0a6d5e29e7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13deb1c9680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1006a759680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/702d996331e0/disk-19af4a4e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a48ce0aeb32/vmlinux-19af4a4e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/332eb4a803d2/Image-19af4a4e.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/97d89134ed25/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc4-syzkaller-g19af4a4ed414 #0 Not tainted
------------------------------------------------------
syz-executor254/6025 is trying to acquire lock:
ffff0000db54a0e0 (&type->s_umount_key#25){++++}-{3:3}, at: __super_lock fs/super.c:58 [inline]
ffff0000db54a0e0 (&type->s_umount_key#25){++++}-{3:3}, at: super_lock+0x160/0x328 fs/super.c:117

but task is already holding lock:
ffff0000c1540c88 (&bdev->bd_holder_lock){+.+.}-{3:3}, at: blkdev_flushbuf block/ioctl.c:370 [inline]
ffff0000c1540c88 (&bdev->bd_holder_lock){+.+.}-{3:3}, at: blkdev_common_ioctl+0x7fc/0x2884 block/ioctl.c:502

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&bdev->bd_holder_lock){+.+.}-{3:3}:
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
       bd_finish_claiming+0x218/0x3dc block/bdev.c:566
       blkdev_get_by_dev+0x3f4/0x55c block/bdev.c:799
       setup_bdev_super+0x68/0x51c fs/super.c:1484
       mount_bdev+0x1a0/0x2b4 fs/super.c:1626
       get_super_block+0x44/0x58 fs/reiserfs/super.c:2601
       legacy_get_tree+0xd4/0x16c fs/fs_context.c:638
       vfs_get_tree+0x90/0x288 fs/super.c:1750
       do_new_mount+0x25c/0x8c8 fs/namespace.c:3335
       path_mount+0x590/0xe04 fs/namespace.c:3662
       init_mount+0xe4/0x144 fs/init.c:25
       do_mount_root+0x104/0x3e4 init/do_mounts.c:166
       mount_root_generic+0x1f0/0x594 init/do_mounts.c:205
       mount_block_root+0x6c/0x7c init/do_mounts.c:378
       mount_root+0xb4/0xe4 init/do_mounts.c:405
       prepare_namespace+0xdc/0x11c init/do_mounts.c:489
       kernel_init_freeable+0x35c/0x474 init/main.c:1560
       kernel_init+0x24/0x29c init/main.c:1437
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

-> #2 (bdev_lock
){+.+.}-{3:3}:
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
       bd_finish_claiming+0x84/0x3dc block/bdev.c:557
       blkdev_get_by_dev+0x3f4/0x55c block/bdev.c:799
       setup_bdev_super+0x68/0x51c fs/super.c:1484
       mount_bdev+0x1a0/0x2b4 fs/super.c:1626
       get_super_block+0x44/0x58 fs/reiserfs/super.c:2601
       legacy_get_tree+0xd4/0x16c fs/fs_context.c:638
       vfs_get_tree+0x90/0x288 fs/super.c:1750
       do_new_mount+0x25c/0x8c8 fs/namespace.c:3335
       path_mount+0x590/0xe04 fs/namespace.c:3662
       init_mount+0xe4/0x144 fs/init.c:25
       do_mount_root+0x104/0x3e4 init/do_mounts.c:166
       mount_root_generic+0x1f0/0x594 init/do_mounts.c:205
       mount_block_root+0x6c/0x7c init/do_mounts.c:378
       mount_root+0xb4/0xe4 init/do_mounts.c:405
       prepare_namespace+0xdc/0x11c init/do_mounts.c:489
       kernel_init_freeable+0x35c/0x474 init/main.c:1560
       kernel_init+0x24/0x29c init/main.c:1437
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

-> #1 (&disk->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
       blkdev_get_by_dev+0x114/0x55c block/bdev.c:786
       journal_init_dev fs/reiserfs/journal.c:2626 [inline]
       journal_init+0xa60/0x1e44 fs/reiserfs/journal.c:2786
       reiserfs_fill_super+0xd50/0x2028 fs/reiserfs/super.c:2022
       mount_bdev+0x1e8/0x2b4 fs/super.c:1629
       get_super_block+0x44/0x58 fs/reiserfs/super.c:2601
       legacy_get_tree+0xd4/0x16c fs/fs_context.c:638
       vfs_get_tree+0x90/0x288 fs/super.c:1750
       do_new_mount+0x25c/0x8c8 fs/namespace.c:3335
       path_mount+0x590/0xe04 fs/namespace.c:3662
       do_mount fs/namespace.c:3675 [inline]
       __do_sys_mount fs/namespace.c:3884 [inline]
       __se_sys_mount fs/namespace.c:3861 [inline]
       __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3861
       __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
       el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

-> #0 (&type->s_umount_key#25){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x3370/0x75e8 kernel/locking/lockdep.c:5136
       lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
       down_read+0x58/0x2fc kernel/locking/rwsem.c:1520
       __super_lock fs/super.c:58 [inline]
       super_lock+0x160/0x328 fs/super.c:117
       super_lock_shared fs/super.c:146 [inline]
       super_lock_shared_active fs/super.c:1431 [inline]
       fs_bdev_sync+0xa4/0x168 fs/super.c:1466
       blkdev_flushbuf block/ioctl.c:372 [inline]
       blkdev_common_ioctl+0x848/0x2884 block/ioctl.c:502
       blkdev_ioctl+0x35c/0xae4 block/ioctl.c:624
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:871 [inline]
       __se_sys_ioctl fs/ioctl.c:857 [inline]
       __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
       __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
       el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

other info that might help us debug this:

Chain exists of:
  &type->s_umount_key#25 --> bdev_lock --> &bdev->bd_holder_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&bdev->bd_holder_lock);
                               lock(bdev_lock);
                               lock(&bdev->bd_holder_lock);
  rlock(&type->s_umount_key#25);

 *** DEADLOCK ***

1 lock held by syz-executor254/6025:
 #0: ffff0000c1540c88 (&bdev->bd_holder_lock){+.+.}-{3:3}, at: blkdev_flushbuf block/ioctl.c:370 [inline]
 #0: ffff0000c1540c88 (&bdev->bd_holder_lock){+.+.}-{3:3}, at: blkdev_common_ioctl+0x7fc/0x2884 block/ioctl.c:502

stack backtrace:
CPU: 0 PID: 6025 Comm: syz-executor254 Not tainted 6.6.0-rc4-syzkaller-g19af4a4ed414 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2060
 check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x3370/0x75e8 kernel/locking/lockdep.c:5136
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
 down_read+0x58/0x2fc kernel/locking/rwsem.c:1520
 __super_lock fs/super.c:58 [inline]
 super_lock+0x160/0x328 fs/super.c:117
 super_lock_shared fs/super.c:146 [inline]
 super_lock_shared_active fs/super.c:1431 [inline]
 fs_bdev_sync+0xa4/0x168 fs/super.c:1466
 blkdev_flushbuf block/ioctl.c:372 [inline]
 blkdev_common_ioctl+0x848/0x2884 block/ioctl.c:502
 blkdev_ioctl+0x35c/0xae4 block/ioctl.c:624
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
