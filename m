Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A7D7515F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 04:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjGMCBB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 22:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjGMCBA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 22:01:00 -0400
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690301BFB
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 19:00:56 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1b434c31877so306774fac.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 19:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689213655; x=1691805655;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRv+N4ss6idVrsjTU89OuW2S18JYKvB8zh+B/pD64SQ=;
        b=IBCDs/dOmJ6kYuutVOMnYxrM0opM9A02ksPgwPRYxickV8WY1z8Piyz1XKVKGvSTWC
         Mx5zVByf0OnEDxeMEhWYPJDg7Z+4ApEZFj8GHYOrx5VVbw8FO5feCEjSyKalP0mkaUQH
         TuHUp5qfpjZxjdZ5mD1Urh5MYc2hgrwkATgcM/gWXLsAFwtP6Jm07AxQ/GXhZ6eQYh+J
         CBYCgezy5tiU6aBTokTQkgCfpnIvzGQUr1U1i+4W97LKSOaBy75VG68kwJvXlAqBDLnf
         img3sbCjf5ySahQHtYLcY3eZP3X1iq3plD7fVYRtU4RybWwIWrsblcu+DfthCRBx9X0K
         excw==
X-Gm-Message-State: ABy/qLZe9bl5pWO2BpPIjNMb3pnftFurUvFjhjL4a0Gpb2NsRCG5jI7X
        5o2EuhWLy2XmVgaTCruEALXKX+L/n/xNgBjaMN/VE7UPCHYZJ0DCDw==
X-Google-Smtp-Source: APBJJlGz91PJyci96JqRqvreut/VZA/FmJ+2GqfmYvlaiHQomiz+HZpESsyrD4+yN52oaQ15yavfacHRz1ryf0B2mAOFOWswKxMO
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5a96:b0:1b0:5c0a:c047 with SMTP id
 dt22-20020a0568705a9600b001b05c0ac047mr522481oab.2.1689213655740; Wed, 12 Jul
 2023 19:00:55 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:00:55 -0700
In-Reply-To: <000000000000cfe6f305ee84ff1f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6a390060054b370@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in reiserfs_dirty_inode
From:   syzbot <syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    e40939bbfc68 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1070f4bca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c84f463eb74eab24
dashboard link: https://syzkaller.appspot.com/bug?extid=c319bb5b1014113a92cf
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112c37e2a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e4c2daa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/257596b75aaf/disk-e40939bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9c75b8d61081/vmlinux-e40939bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f0233129f4f/Image-e40939bb.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/05e314af739c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc7-syzkaller-ge40939bbfc68 #0 Not tainted
------------------------------------------------------
syz-executor365/5984 is trying to acquire lock:
ffff0000db0d17d8 (&mm->mmap_lock
){++++}-{3:3}, at: __might_fault+0x9c/0x124 mm/memory.c:5731

but task is already holding lock:
ffff0000c2367090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x7c/0xe8 fs/reiserfs/lock.c:27

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sbi->lock){+.+.}-{3:3}:
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
       reiserfs_write_lock+0x7c/0xe8 fs/reiserfs/lock.c:27
       reiserfs_dirty_inode+0xe4/0x204 fs/reiserfs/super.c:704
       __mark_inode_dirty+0x2b0/0x10f4 fs/fs-writeback.c:2424
       generic_update_time fs/inode.c:1859 [inline]
       inode_update_time fs/inode.c:1872 [inline]
       touch_atime+0x5d8/0x8d4 fs/inode.c:1944
       file_accessed include/linux/fs.h:2198 [inline]
       generic_file_mmap+0xb0/0x11c mm/filemap.c:3606
       call_mmap include/linux/fs.h:1873 [inline]
       mmap_region+0xc00/0x1aa4 mm/mmap.c:2649
       do_mmap+0xa00/0x1108 mm/mmap.c:1394
       vm_mmap_pgoff+0x198/0x3b8 mm/util.c:543
       ksys_mmap_pgoff+0x3c8/0x5b0 mm/mmap.c:1440
       __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
       __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
       __arm64_sys_mmap+0xf8/0x110 arch/arm64/kernel/sys.c:21
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
       el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
       el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3113 [inline]
       check_prevs_add kernel/locking/lockdep.c:3232 [inline]
       validate_chain kernel/locking/lockdep.c:3847 [inline]
       __lock_acquire+0x3308/0x7604 kernel/locking/lockdep.c:5088
       lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5705
       __might_fault+0xc4/0x124 mm/memory.c:5732
       reiserfs_ioctl+0x10c/0x454 fs/reiserfs/ioctl.c:96
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:856
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
       el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
       el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->lock);
                               lock(&mm->mmap_lock);
                               lock(&sbi->lock);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

1 lock held by syz-executor365/5984:
 #0: ffff0000c2367090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x7c/0xe8 fs/reiserfs/lock.c:27

stack backtrace:
CPU: 1 PID: 5984 Comm: syz-executor365 Not tainted 6.4.0-rc7-syzkaller-ge40939bbfc68 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2066
 check_noncircular+0x2cc/0x378 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3113 [inline]
 check_prevs_add kernel/locking/lockdep.c:3232 [inline]
 validate_chain kernel/locking/lockdep.c:3847 [inline]
 __lock_acquire+0x3308/0x7604 kernel/locking/lockdep.c:5088
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5705
 __might_fault+0xc4/0x124 mm/memory.c:5732
 reiserfs_ioctl+0x10c/0x454 fs/reiserfs/ioctl.c:96
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
