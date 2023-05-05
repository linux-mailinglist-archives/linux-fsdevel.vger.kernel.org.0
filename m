Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2762D6F8B90
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 23:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjEEVtA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 17:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjEEVs6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 17:48:58 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662EE123
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 14:48:49 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-331632be774so114728995ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 May 2023 14:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683323328; x=1685915328;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7jMC4Y/MwtJxVB+XvqmNFutBQ5y0DuObCQpShWAyDA=;
        b=JqIcSXK/8nLilbEfl4gJGQqhY1hcIQf2Q3+99/E1WlvvniKzI2zk7F6rIliUOy6l61
         VKgXpucmCpinJQumTEeAReJTAvUdLuIZQ3ueC8YAnaVvRSEc9BPLDIpPeC/1eJS3hkFA
         +ictTgVXqtJcHuuYgtCLMLEHChqsOfrfsNbAPQOn74vp2Npr9+ycJrBemHyYDB0HDzT7
         sl/VXlKXwtaW70mpFZXneg7iZK68E/0GXOKB/tTsYpsMTIZvT2fuK9+0L92lPaWlG1ds
         bUEvNeFsRxe/1HmCV9IAMDvr7oJ0ODRcefJN5KWEw0tv2oex3gqp6hbagW4598nVdoRj
         BFHw==
X-Gm-Message-State: AC+VfDyc8OGpWi8SlES4Po20oiztvNU/OS5ptcjzfNynfBFmXo2LOP+3
        EVC7R7ydCgeU6innjdPPkSLC0HEwtuUiNTkDo3A5CnvjIyT5
X-Google-Smtp-Source: ACHHUZ7h14GTayDuTiT+XMTh6z11amG7pXwUsJRviZHTEdjTameaV5/XU2zTTT1SV3oExcG3icb7qrbArROQKHALD+LoIRDmIrp6
MIME-Version: 1.0
X-Received: by 2002:a92:7c04:0:b0:32b:fc:52b1 with SMTP id x4-20020a927c04000000b0032b00fc52b1mr2179768ilc.0.1683323328678;
 Fri, 05 May 2023 14:48:48 -0700 (PDT)
Date:   Fri, 05 May 2023 14:48:48 -0700
In-Reply-To: <000000000000f6540d05f30bb23f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c53dd05faf94183@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_xattr_set_handle (3)
From:   syzbot <syzbot+edce54daffee36421b4c@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, dvyukov@google.com, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    14f8db1c0f9a Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1663f338280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a837a8ba7e88bb45
dashboard link: https://syzkaller.appspot.com/bug?extid=edce54daffee36421b4c
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17595ed4280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e85322280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ad6ce516eed3/disk-14f8db1c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f38c2cc7667/vmlinux-14f8db1c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d795115eee39/Image-14f8db1c.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/092c100a5922/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+edce54daffee36421b4c@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 512
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: writeback.
======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc7-syzkaller-g14f8db1c0f9a #0 Not tainted
------------------------------------------------------
syz-executor392/5925 is trying to acquire lock:
ffff0000e0dbb2f0 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
ffff0000e0dbb2f0 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x1e0/0x12d8 fs/ext4/xattr.c:2373

but task is already holding lock:
ffff0000e0dbb628 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:758 [inline]
ffff0000e0dbb628 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: vfs_setxattr+0x17c/0x344 fs/xattr.c:323

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}:
       down_write+0x50/0xc0 kernel/locking/rwsem.c:1573
       inode_lock include/linux/fs.h:758 [inline]
       ext4_xattr_inode_create fs/ext4/xattr.c:1525 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1608 [inline]
       ext4_xattr_set_entry+0x2394/0x2c3c fs/ext4/xattr.c:1737
       ext4_xattr_block_set+0x8e0/0x2cc4 fs/ext4/xattr.c:2043
       ext4_xattr_set_handle+0xb2c/0x12d8 fs/ext4/xattr.c:2458
       ext4_xattr_set+0x1e0/0x354 fs/ext4/xattr.c:2560
       ext4_xattr_trusted_set+0x4c/0x64 fs/ext4/xattr_trusted.c:38
       __vfs_setxattr+0x3d8/0x400 fs/xattr.c:203
       __vfs_setxattr_noperm+0x110/0x528 fs/xattr.c:237
       __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:298
       vfs_setxattr+0x1a8/0x344 fs/xattr.c:324
       do_setxattr fs/xattr.c:609 [inline]
       setxattr+0x208/0x29c fs/xattr.c:632
       path_setxattr+0x17c/0x258 fs/xattr.c:651
       __do_sys_setxattr fs/xattr.c:667 [inline]
       __se_sys_setxattr fs/xattr.c:663 [inline]
       __arm64_sys_setxattr+0xbc/0xd8 fs/xattr.c:663
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
       el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
       el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

-> #0 (&ei->xattr_sem){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x3338/0x764c kernel/locking/lockdep.c:5056
       lock_acquire+0x238/0x718 kernel/locking/lockdep.c:5669
       down_write+0x50/0xc0 kernel/locking/rwsem.c:1573
       ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
       ext4_xattr_set_handle+0x1e0/0x12d8 fs/ext4/xattr.c:2373
       ext4_xattr_set+0x1e0/0x354 fs/ext4/xattr.c:2560
       ext4_xattr_trusted_set+0x4c/0x64 fs/ext4/xattr_trusted.c:38
       __vfs_setxattr+0x3d8/0x400 fs/xattr.c:203
       __vfs_setxattr_noperm+0x110/0x528 fs/xattr.c:237
       __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:298
       vfs_setxattr+0x1a8/0x344 fs/xattr.c:324
       do_setxattr fs/xattr.c:609 [inline]
       setxattr+0x208/0x29c fs/xattr.c:632
       path_setxattr+0x17c/0x258 fs/xattr.c:651
       __do_sys_setxattr fs/xattr.c:667 [inline]
       __se_sys_setxattr fs/xattr.c:663 [inline]
       __arm64_sys_setxattr+0xbc/0xd8 fs/xattr.c:663
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
       el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
       el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ea_inode->i_rwsem#8/1);
                               lock(&ei->xattr_sem);
                               lock(&ea_inode->i_rwsem#8/1);
  lock(&ei->xattr_sem);

 *** DEADLOCK ***

2 locks held by syz-executor392/5925:
 #0: ffff0000d80e6460 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x44/0x9c fs/namespace.c:394
 #1: ffff0000e0dbb628 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:758 [inline]
 #1: ffff0000e0dbb628 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: vfs_setxattr+0x17c/0x344 fs/xattr.c:323

stack backtrace:
CPU: 1 PID: 5925 Comm: syz-executor392 Not tainted 6.3.0-rc7-syzkaller-g14f8db1c0f9a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2056
 check_noncircular+0x2cc/0x378 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3098 [inline]
 check_prevs_add kernel/locking/lockdep.c:3217 [inline]
 validate_chain kernel/locking/lockdep.c:3832 [inline]
 __lock_acquire+0x3338/0x764c kernel/locking/lockdep.c:5056
 lock_acquire+0x238/0x718 kernel/locking/lockdep.c:5669
 down_write+0x50/0xc0 kernel/locking/rwsem.c:1573
 ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 ext4_xattr_set_handle+0x1e0/0x12d8 fs/ext4/xattr.c:2373
 ext4_xattr_set+0x1e0/0x354 fs/ext4/xattr.c:2560
 ext4_xattr_trusted_set+0x4c/0x64 fs/ext4/xattr_trusted.c:38
 __vfs_setxattr+0x3d8/0x400 fs/xattr.c:203
 __vfs_setxattr_noperm+0x110/0x528 fs/xattr.c:237
 __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:298
 vfs_setxattr+0x1a8/0x344 fs/xattr.c:324
 do_setxattr fs/xattr.c:609 [inline]
 setxattr+0x208/0x29c fs/xattr.c:632
 path_setxattr+0x17c/0x258 fs/xattr.c:651
 __do_sys_setxattr fs/xattr.c:667 [inline]
 __se_sys_setxattr fs/xattr.c:663 [inline]
 __arm64_sys_setxattr+0xbc/0xd8 fs/xattr.c:663
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
