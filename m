Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD677C04C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 21:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343936AbjJJTir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 15:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343885AbjJJTiq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:38:46 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792439E
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 12:38:43 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3ae5ac8de14so10087344b6e.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 12:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696966723; x=1697571523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyVaqlX6OagJqZRcmPYALwnKUIfCaD9oKeX/SFNHo7Q=;
        b=tS6hNm7Aaj0wHf6PuuVq2boUj72RZC7ttJR6jAnKgWtJLUk96k+cQpGum1sPs8Si7l
         tJ8gbqrLGAzT91sKgGwt3NKGbX2RKy4L9OWcBFr8HKJZ8wAm21dKTEgmmQuRVzfeSde5
         WIcBFsZOYsqhuyMaXXLuMtucdFJn/mekv0T2k1KxYZifp+WB3XtraIUmh4juqwIf/hKL
         GJ/fo9xUeBMVDaXXPSxiwF51aqs8nElBkp1X3wI5nWPH9CoPyhMnXJpQk1aD7UElkObo
         vHElwHgF5+L27jT7nAuPCdTgs7RXp6g8Y+V/SsAgZhk5IXGfDMQj3YzXslwU635yCutr
         p3/Q==
X-Gm-Message-State: AOJu0Yx8M7qDV7dikZ3MYg1tCw94lQl3XgpzsgupciHtiXKXscCpK44P
        i3Q7r2AM3Eb6NRKqwoJRcEmfgopjD3BJjIQaOIrNDk3L4ATSPCLppw==
X-Google-Smtp-Source: AGHT+IEBEfxxJ6eHhBGa9pXZ2nwIOCfyK/amQ/eC4kdaZM0L2vuzz1YFUICrlFQBwWX1pHcCO+vU+N6gjjwEJIndGyXJGKfK54dG
MIME-Version: 1.0
X-Received: by 2002:a05:6808:208a:b0:3ae:11ee:b66f with SMTP id
 s10-20020a056808208a00b003ae11eeb66fmr10438498oiw.3.1696966722911; Tue, 10
 Oct 2023 12:38:42 -0700 (PDT)
Date:   Tue, 10 Oct 2023 12:38:42 -0700
In-Reply-To: <000000000000cc15ee05ed0ca085@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b70395060761da97@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in filename_create
From:   syzbot <syzbot+95cb07e3840546a4827b@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    19af4a4ed414 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15da0ec9680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80eedef55cd21fa4
dashboard link: https://syzkaller.appspot.com/bug?extid=95cb07e3840546a4827b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11957c65680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1304e6ba680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/702d996331e0/disk-19af4a4e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a48ce0aeb32/vmlinux-19af4a4e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/332eb4a803d2/Image-19af4a4e.gz.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/a4536cf3a09f/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/88a36e03ffba/mount_3.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+95cb07e3840546a4827b@syzkaller.appspotmail.com

REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc4-syzkaller-g19af4a4ed414 #0 Not tainted
------------------------------------------------------
syz-executor324/6098 is trying to acquire lock:
ffff0000dd376640 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:837 [inline]
ffff0000dd376640 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: filename_create+0x204/0x468 fs/namei.c:3889

but task is already holding lock:
ffff0000d494e410 (sb_writers#8){.+.+}-{0:0}, at: mnt_want_write+0x44/0x9c fs/namespace.c:403

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_writers#8){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1571 [inline]
       sb_start_write+0x60/0x2ec include/linux/fs.h:1646
       mnt_want_write_file+0x64/0x1e8 fs/namespace.c:447
       reiserfs_ioctl+0x188/0x42c fs/reiserfs/ioctl.c:103
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

-> #1 (&sbi->lock){+.+.}-{3:3}:
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
       reiserfs_write_lock+0x7c/0xe8 fs/reiserfs/lock.c:27
       reiserfs_lookup+0x128/0x45c fs/reiserfs/namei.c:364
       lookup_one_qstr_excl+0x108/0x230 fs/namei.c:1608
       filename_create+0x230/0x468 fs/namei.c:3890
       do_mkdirat+0xac/0x610 fs/namei.c:4135
       __do_sys_mkdirat fs/namei.c:4158 [inline]
       __se_sys_mkdirat fs/namei.c:4156 [inline]
       __arm64_sys_mkdirat+0x90/0xa8 fs/namei.c:4156
       __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
       el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

-> #0 (
&type->i_mutex_dir_key#6/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x3370/0x75e8 kernel/locking/lockdep.c:5136
       lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
       down_write_nested+0x58/0xcc kernel/locking/rwsem.c:1689
       inode_lock_nested include/linux/fs.h:837 [inline]
       filename_create+0x204/0x468 fs/namei.c:3889
       do_mkdirat+0xac/0x610 fs/namei.c:4135
       __do_sys_mkdirat fs/namei.c:4158 [inline]
       __se_sys_mkdirat fs/namei.c:4156 [inline]
       __arm64_sys_mkdirat+0x90/0xa8 fs/namei.c:4156
       __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
       el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

other info that might help us debug this:

Chain exists of:
  &type->i_mutex_dir_key#6/1 --> &sbi->lock --> sb_writers#8

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_writers#8);
                               lock(&sbi->lock);
                               lock(sb_writers#8);
  lock(&type->i_mutex_dir_key#6/1);

 *** DEADLOCK ***

1 lock held by syz-executor324/6098:
 #0: ffff0000d494e410 (sb_writers#8){.+.+}-{0:0}, at: mnt_want_write+0x44/0x9c fs/namespace.c:403

stack backtrace:
CPU: 1 PID: 6098 Comm: syz-executor324 Not tainted 6.6.0-rc4-syzkaller-g19af4a4ed414 #0
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
 down_write_nested+0x58/0xcc kernel/locking/rwsem.c:1689
 inode_lock_nested include/linux/fs.h:837 [inline]
 filename_create+0x204/0x468 fs/namei.c:3889
 do_mkdirat+0xac/0x610 fs/namei.c:4135
 __do_sys_mkdirat fs/namei.c:4158 [inline]
 __se_sys_mkdirat fs/namei.c:4156 [inline]
 __arm64_sys_mkdirat+0x90/0xa8 fs/namei.c:4156
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
