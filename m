Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6985E756EEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 23:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjGQVZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 17:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjGQVY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:24:59 -0400
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80ADF3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 14:24:57 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1b07f55975bso7178282fac.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 14:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689629097; x=1692221097;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8F6dYdYGyG77zeOQWkKpbjAt/23bYlsRze36LBs/pcA=;
        b=LCnH3d3X4LgVLMVBb1T6W0gdoSd3LofemI26264uOeT054GKucn0jbIPP72xM2q2ZX
         H/t2T8cwJT1SRWBM+w2btpz0xeRk3HXTQjsC23aTyYCog69xGi6R6FwLY2XaMYjOsVMu
         p6WVxnAaFfZaiIDZU5kX4ymslPow/EQ3Bqxh8Io13ioPeXWtW78HxtO50a2yglj4efwr
         b3eegXwnKo1LGfX28jj+4nePh4uIA9uQcDft7kfiQ3Htg3XAzVdIgwY/j/nZ3eRula4r
         tnAFhqXng6eV8d3hSfFHDgDgdLuINYTcgHVrV/QTXPbTon8rG1btwzefjOsxK0Nksgrf
         gSqg==
X-Gm-Message-State: ABy/qLblsKz0i9VhFyatEW65A3wuJrKKn3Bqi6V4VQD2hU96Md292ESZ
        h+bZWhgEy2PTh6kP9Qcc09w1NiH//x0+5ReuzHcOTH3TPAHlYzx2RA==
X-Google-Smtp-Source: APBJJlFfnVN0tiw5pMxMIgicNC3ThgxSDip01FdCAkF8cbx4VRdT1egGeb8LP03Vq/GGXE/fqS7cmaGtIZY6a0XvjuJxFqXIZovX
MIME-Version: 1.0
X-Received: by 2002:a05:6870:956a:b0:1a9:85e9:9376 with SMTP id
 v42-20020a056870956a00b001a985e99376mr9201371oal.0.1689629097183; Mon, 17 Jul
 2023 14:24:57 -0700 (PDT)
Date:   Mon, 17 Jul 2023 14:24:57 -0700
In-Reply-To: <0000000000001bd66b05fcec6d92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000023d0c70600b56e47@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in vfs_setxattr (2)
From:   syzbot <syzbot+c98692bac73aedb459c3@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=117c0fa2a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4a2640e4213bc2f
dashboard link: https://syzkaller.appspot.com/bug?extid=c98692bac73aedb459c3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107ec3faa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bc5646a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d87aa312c0e/disk-e40939bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/22a11d32a8b2/vmlinux-e40939bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0978b5788b52/Image-e40939bb.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/cd09072f381d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c98692bac73aedb459c3@syzkaller.appspotmail.com

REISERFS (device loop0): Using tea hash to sort names
REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc7-syzkaller-ge40939bbfc68 #0 Not tainted
------------------------------------------------------
syz-executor558/5970 is trying to acquire lock:
ffff0000e0a782e0 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
ffff0000e0a782e0 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: vfs_setxattr+0x17c/0x344 fs/xattr.c:321

but task is already holding lock:
ffff0000c67ac460 (sb_writers#8){.+.+}-{0:0}, at: mnt_want_write+0x44/0x9c fs/namespace.c:394

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_writers#8){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1494 [inline]
       sb_start_write+0x60/0x2ec include/linux/fs.h:1569
       mnt_want_write_file+0x64/0x1e8 fs/namespace.c:438
       reiserfs_ioctl+0x184/0x454 fs/reiserfs/ioctl.c:103
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

-> #1 (&sbi->lock){+.+.}-{3:3}:
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
       reiserfs_write_lock+0x7c/0xe8 fs/reiserfs/lock.c:27
       reiserfs_lookup+0x128/0x45c fs/reiserfs/namei.c:364
       __lookup_slow+0x250/0x374 fs/namei.c:1690
       lookup_one_len+0x178/0x28c fs/namei.c:2742
       reiserfs_lookup_privroot+0x8c/0x184 fs/reiserfs/xattr.c:976
       reiserfs_fill_super+0x1bc0/0x2028 fs/reiserfs/super.c:2174
       mount_bdev+0x274/0x370 fs/super.c:1380
       get_super_block+0x44/0x58 fs/reiserfs/super.c:2601
       legacy_get_tree+0xd4/0x16c fs/fs_context.c:610
       vfs_get_tree+0x90/0x274 fs/super.c:1510
       do_new_mount+0x25c/0x8c4 fs/namespace.c:3039
       path_mount+0x590/0xe04 fs/namespace.c:3369
       do_mount fs/namespace.c:3382 [inline]
       __do_sys_mount fs/namespace.c:3591 [inline]
       __se_sys_mount fs/namespace.c:3568 [inline]
       __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3568
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
       el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
       el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

-> #0 (&type->i_mutex_dir_key#6){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3113 [inline]
       check_prevs_add kernel/locking/lockdep.c:3232 [inline]
       validate_chain kernel/locking/lockdep.c:3847 [inline]
       __lock_acquire+0x3308/0x7604 kernel/locking/lockdep.c:5088
       lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5705
       down_write+0x50/0xc0 kernel/locking/rwsem.c:1573
       inode_lock include/linux/fs.h:775 [inline]
       vfs_setxattr+0x17c/0x344 fs/xattr.c:321
       do_setxattr fs/xattr.c:630 [inline]
       setxattr+0x208/0x29c fs/xattr.c:653
       path_setxattr+0x17c/0x258 fs/xattr.c:672
       __do_sys_setxattr fs/xattr.c:688 [inline]
       __se_sys_setxattr fs/xattr.c:684 [inline]
       __arm64_sys_setxattr+0xbc/0xd8 fs/xattr.c:684
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
       el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
       el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

other info that might help us debug this:

Chain exists of:
  &type->i_mutex_dir_key#6 --> &sbi->lock --> sb_writers#8

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_writers#8);
                               lock(&sbi->lock);
                               lock(sb_writers#8);
  lock(&type->i_mutex_dir_key#6);

 *** DEADLOCK ***

1 lock held by syz-executor558/5970:
 #0: ffff0000c67ac460 (sb_writers#8){.+.+}-{0:0}, at: mnt_want_write+0x44/0x9c fs/namespace.c:394

stack backtrace:
CPU: 1 PID: 5970 Comm: syz-executor558 Not tainted 6.4.0-rc7-syzkaller-ge40939bbfc68 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
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
 down_write+0x50/0xc0 kernel/locking/rwsem.c:1573
 inode_lock include/linux/fs.h:775 [inline]
 vfs_setxattr+0x17c/0x344 fs/xattr.c:321
 do_setxattr fs/xattr.c:630 [inline]
 setxattr+0x208/0x29c fs/xattr.c:653
 path_setxattr+0x17c/0x258 fs/xattr.c:672
 __do_sys_setxattr fs/xattr.c:688 [inline]
 __se_sys_setxattr fs/xattr.c:684 [inline]
 __arm64_sys_setxattr+0xbc/0xd8 fs/xattr.c:684
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
