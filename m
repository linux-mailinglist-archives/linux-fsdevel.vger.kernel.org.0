Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C170F63C13A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 14:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiK2Nig (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 08:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiK2Nie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:38:34 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017635A6F9
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 05:38:33 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id h10-20020a056e021b8a00b00302671bb5fdso12146565ili.21
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 05:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TPnTe42zy/jnT6/qC6RYHMNGDyTdL0bg73rkgIcSSx8=;
        b=z+3W+tL9FYsAwvIuu8hwbwsDhSNsARqz36CsrTfQl0C7TbjM1LN7yN1eddzWKqOTOw
         2/oEfUT22plYXKN2JfcHnIPK5ziH01+mU339F7hmKJ81L/8Ohxwo7rbp7btvk3o9HITk
         2zxj/UfUXOCK8iEvlPVeyyB+VEqKa+HQUGsZAxcbtnNMc7ETFcnOAGucaCERQiMQM1iM
         4rueJ/5qq8dTsD8BMAHr9OsRqNovTupaYuMULjJ/pXusYiZ8yPfVPIdaai7NDFAlbpJz
         t6nvCYtN6+Jp3yuvjcE5WXP2n5eEZzUeinNOu9NtOxe+CxwYclq9l6vneM6JXoE6vKDO
         Nf3g==
X-Gm-Message-State: ANoB5plqwTvmuc59CcMw1Ei+FHrE0kqjLfSQtw6P10GFaXFuK6Sm95Dy
        h+T6s+3DKgyp+klSfUjNTF+TE3U6GFCIqqj+qlyWzY2MbIMU
X-Google-Smtp-Source: AA0mqf7aECI+fOhCYLnVIEpqsQ/aI4XWF+Z69lJHi2il4w7U3xBJuKHuKJP6p7N7kI4BazAYTj2Kvq5oV2Of9luVlN8k/LME9tGm
MIME-Version: 1.0
X-Received: by 2002:a02:942a:0:b0:373:d769:bc14 with SMTP id
 a39-20020a02942a000000b00373d769bc14mr18417638jai.264.1669729112303; Tue, 29
 Nov 2022 05:38:32 -0800 (PST)
Date:   Tue, 29 Nov 2022 05:38:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c31e605ee9c1a13@google.com>
Subject: [syzbot] possible deadlock in hfsplus_block_allocate
From:   syzbot <syzbot+b6ccd31787585244a855@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, fmdefrancesco@gmail.com,
        ira.weiny@intel.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, slava@dubeyko.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6d464646530f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12cf5fed880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54b747d981acc7b7
dashboard link: https://syzkaller.appspot.com/bug?extid=b6ccd31787585244a855
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d75f5f77b3a3/disk-6d464646.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9382f86e4d95/vmlinux-6d464646.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cf2b5f0d51dd/Image-6d464646.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6ccd31787585244a855@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc6-syzkaller-32662-g6d464646530f #0 Not tainted
------------------------------------------------------
syz-executor.1/11346 is trying to acquire lock:
ffff0000fce298f8 (&sbi->alloc_mutex){+.+.}-{3:3}, at: hfsplus_block_allocate+0x60/0x5e4 fs/hfsplus/bitmap.c:35

but task is already holding lock:
ffff0000fd681b08 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_extend+0x8c/0x88c fs/hfsplus/extents.c:457

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}:
       __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
       hfsplus_get_block+0x17c/0x8a4 fs/hfsplus/extents.c:260
       block_read_full_folio+0x188/0x8c0 fs/buffer.c:2271
       hfsplus_read_folio+0x28/0x38 fs/hfsplus/inode.c:28
       filemap_read_folio+0xc4/0x468 mm/filemap.c:2407
       do_read_cache_folio+0x1c8/0x588 mm/filemap.c:3534
       do_read_cache_page mm/filemap.c:3576 [inline]
       read_cache_page+0x40/0x174 mm/filemap.c:3585
       read_mapping_page include/linux/pagemap.h:756 [inline]
       hfsplus_block_allocate+0x80/0x5e4 fs/hfsplus/bitmap.c:37
       hfsplus_file_extend+0x560/0x88c fs/hfsplus/extents.c:468
       hfsplus_get_block+0x1c0/0x8a4 fs/hfsplus/extents.c:245
       __block_write_begin_int+0x23c/0x9d4 fs/buffer.c:1991
       __block_write_begin fs/buffer.c:2041 [inline]
       block_write_begin+0x74/0x14c fs/buffer.c:2102
       cont_write_begin+0xf4/0x11c fs/buffer.c:2456
       hfsplus_write_begin+0x64/0xac fs/hfsplus/inode.c:52
       generic_perform_write+0xf0/0x2cc mm/filemap.c:3753
       __generic_file_write_iter+0xd8/0x21c mm/filemap.c:3881
       generic_file_write_iter+0x6c/0x168 mm/filemap.c:3913
       call_write_iter include/linux/fs.h:2191 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x2dc/0x46c fs/read_write.c:584
       ksys_write+0xb4/0x160 fs/read_write.c:637
       __do_sys_write fs/read_write.c:649 [inline]
       __se_sys_write fs/read_write.c:646 [inline]
       __arm64_sys_write+0x24/0x34 fs/read_write.c:646
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #0 (&sbi->alloc_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
       hfsplus_block_allocate+0x60/0x5e4 fs/hfsplus/bitmap.c:35
       hfsplus_file_extend+0x560/0x88c fs/hfsplus/extents.c:468
       hfsplus_bmap_reserve+0x6c/0x120 fs/hfsplus/btree.c:358
       hfsplus_create_cat+0xa4/0x38c fs/hfsplus/catalog.c:272
       hfsplus_fill_super+0x758/0x864 fs/hfsplus/super.c:560
       mount_bdev+0x1b8/0x210 fs/super.c:1401
       hfsplus_mount+0x44/0x58 fs/hfsplus/super.c:641
       legacy_get_tree+0x30/0x74 fs/fs_context.c:610
       vfs_get_tree+0x40/0x140 fs/super.c:1531
       do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
       path_mount+0x358/0x890 fs/namespace.c:3370
       do_mount fs/namespace.c:3383 [inline]
       __do_sys_mount fs/namespace.c:3591 [inline]
       __se_sys_mount fs/namespace.c:3568 [inline]
       __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&HFSPLUS_I(inode)->extents_lock);
                               lock(&sbi->alloc_mutex);
                               lock(&HFSPLUS_I(inode)->extents_lock);
  lock(&sbi->alloc_mutex);

 *** DEADLOCK ***

4 locks held by syz-executor.1/11346:
 #0: ffff0001056de0e0 (&type->s_umount_key#53/1){+.+.}-{3:3}, at: alloc_super+0xf8/0x430 fs/super.c:228
 #1: ffff0000fce29998 (&sbi->vh_mutex){+.+.}-{3:3}, at: hfsplus_fill_super+0x72c/0x864 fs/hfsplus/super.c:553
 #2: ffff0001056dc0b0 (&tree->tree_lock){+.+.}-{3:3}, at: hfsplus_find_init+0xac/0xc8
 #3: ffff0000fd681b08 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_extend+0x8c/0x88c fs/hfsplus/extents.c:457

stack backtrace:
CPU: 1 PID: 11346 Comm: syz-executor.1 Not tainted 6.1.0-rc6-syzkaller-32662-g6d464646530f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_circular_bug+0x2c4/0x2c8 kernel/locking/lockdep.c:2055
 check_noncircular+0x14c/0x154 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 hfsplus_block_allocate+0x60/0x5e4 fs/hfsplus/bitmap.c:35
 hfsplus_file_extend+0x560/0x88c fs/hfsplus/extents.c:468
 hfsplus_bmap_reserve+0x6c/0x120 fs/hfsplus/btree.c:358
 hfsplus_create_cat+0xa4/0x38c fs/hfsplus/catalog.c:272
 hfsplus_fill_super+0x758/0x864 fs/hfsplus/super.c:560
 mount_bdev+0x1b8/0x210 fs/super.c:1401
 hfsplus_mount+0x44/0x58 fs/hfsplus/super.c:641
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1531
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x890 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
hfsplus: b-tree write err: -5, ino 4


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
