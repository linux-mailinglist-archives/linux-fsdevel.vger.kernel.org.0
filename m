Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961E66F7D7E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 09:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjEEHKK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 03:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjEEHKJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 03:10:09 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86BA8685
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 00:10:07 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-76371bc5167so201746339f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 May 2023 00:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683270607; x=1685862607;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eNTge60mhkv7VMoNAp38G1CzXS5rE2ER7GKmR9pmR+A=;
        b=eobn12zmehevfk8doZasgjvaJd/dxjv0L4h+9SXG1d1QeT9g2AXenW5SEg+uKc72+L
         VwKU+8B4iQTOEQQoU3a6QFoRIV6t7DXbP5pzExfOqwtufNviG0JNJPS51mbYRhetlSL/
         l2GHp0rC3bIBPlF/ArTaR4CKkSYmL7u6Xf1w6XZ9amjydDv7DSgbQeEQ9Z4968XHeWxl
         rdGOUmr6rzlC/ZzF0/wwiHfnuM8XMVIla44TtUawNZQ7TV9lni/MF2bdrFX7G2po2v7L
         W5uN2waqqiXY+i1711dd5xybsSiPwvJzi4Q7IZ8enbYiWQMwzN0KD5AmJOupoUzbbXKp
         KzXw==
X-Gm-Message-State: AC+VfDypwHe9oQPGt0sYr5bS9o0nzhNbSNXz7W2G7bhwboWRxkmg2OTL
        bnPQqro7mAAHl3Ap8NMcr2MTaV6yRk/kQKliR2w83Mj0rNhkQpegJA==
X-Google-Smtp-Source: ACHHUZ4SVBJKNTRuYam+EqdTCIWZkmnchQBEbN86BBO+mW3Dc/q9B98EHOO9U+UJk7JKPZDkN9sP5xrnogtn5ZVMMixcy+rHNGTy
MIME-Version: 1.0
X-Received: by 2002:a6b:e70e:0:b0:745:70d7:4962 with SMTP id
 b14-20020a6be70e000000b0074570d74962mr122419ioh.0.1683270606885; Fri, 05 May
 2023 00:10:06 -0700 (PDT)
Date:   Fri, 05 May 2023 00:10:06 -0700
In-Reply-To: <0000000000007bedb605f119ed9f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000959b3205faecfa72@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in open_xa_dir
From:   syzbot <syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    78b421b6a7c6 Merge tag 'linux-watchdog-6.4-rc1' of git://w..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=150c42a8280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73a06f6ef2d5b492
dashboard link: https://syzkaller.appspot.com/bug?extid=8fb64a61fdd96b50f3b8
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e2e518280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c03112280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/25168a5d3be8/disk-78b421b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f5af9f784d9d/vmlinux-78b421b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7781e4e3e606/bzImage-78b421b6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/29a59b19c7a8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.3.0-syzkaller-13164-g78b421b6a7c6 #0 Not tainted
------------------------------------------------------
syz-executor363/4996 is trying to acquire lock:
ffff888074558980 (&type->i_mutex_dir_key#6/3){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:810 [inline]
ffff888074558980 (&type->i_mutex_dir_key#6/3){+.+.}-{3:3}, at: open_xa_root fs/reiserfs/xattr.c:128 [inline]
ffff888074558980 (&type->i_mutex_dir_key#6/3){+.+.}-{3:3}, at: open_xa_dir+0x136/0x610 fs/reiserfs/xattr.c:153

but task is already holding lock:
ffff8880156f2090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock_nested+0x5f/0xd0 fs/reiserfs/lock.c:78

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sbi->lock){+.+.}-{3:3}:
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
       __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
       reiserfs_write_lock+0x7a/0xd0 fs/reiserfs/lock.c:27
       reiserfs_mkdir+0x321/0x8f0 fs/reiserfs/namei.c:829
       xattr_mkdir fs/reiserfs/xattr.c:77 [inline]
       open_xa_root fs/reiserfs/xattr.c:137 [inline]
       open_xa_dir+0x2cd/0x610 fs/reiserfs/xattr.c:153
       xattr_lookup+0x24/0x280 fs/reiserfs/xattr.c:396
       reiserfs_xattr_set_handle+0xfc/0xdc0 fs/reiserfs/xattr.c:534
       reiserfs_security_write+0x157/0x1d0 fs/reiserfs/xattr_security.c:106
       reiserfs_new_inode+0x1631/0x1d40 fs/reiserfs/inode.c:2111
       reiserfs_create+0x3e7/0x6e0 fs/reiserfs/namei.c:666
       lookup_open fs/namei.c:3492 [inline]
       open_last_lookups fs/namei.c:3560 [inline]
       path_openat+0x13df/0x3170 fs/namei.c:3788
       do_filp_open+0x234/0x490 fs/namei.c:3818
       do_sys_openat2+0x13f/0x500 fs/open.c:1356
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x247/0x290 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&type->i_mutex_dir_key#6/3){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3108 [inline]
       check_prevs_add kernel/locking/lockdep.c:3227 [inline]
       validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3842
       __lock_acquire+0x1295/0x2000 kernel/locking/lockdep.c:5074
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
       down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1689
       inode_lock_nested include/linux/fs.h:810 [inline]
       open_xa_root fs/reiserfs/xattr.c:128 [inline]
       open_xa_dir+0x136/0x610 fs/reiserfs/xattr.c:153
       xattr_lookup+0x24/0x280 fs/reiserfs/xattr.c:396
       reiserfs_xattr_get+0xfd/0x570 fs/reiserfs/xattr.c:678
       __vfs_getxattr+0x436/0x470 fs/xattr.c:424
       smk_fetch+0xb1/0x140 security/smack/smack_lsm.c:295
       smack_d_instantiate+0x6d9/0xb40 security/smack/smack_lsm.c:3475
       security_d_instantiate+0x9b/0xf0 security/security.c:3760
       d_instantiate_new+0x65/0x120 fs/dcache.c:2053
       reiserfs_create+0x5cf/0x6e0 fs/reiserfs/namei.c:692
       lookup_open fs/namei.c:3492 [inline]
       open_last_lookups fs/namei.c:3560 [inline]
       path_openat+0x13df/0x3170 fs/namei.c:3788
       do_filp_open+0x234/0x490 fs/namei.c:3818
       do_sys_openat2+0x13f/0x500 fs/open.c:1356
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x247/0x290 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->lock);
                               lock(&type->i_mutex_dir_key#6/3);
                               lock(&sbi->lock);
  lock(&type->i_mutex_dir_key#6/3);

 *** DEADLOCK ***

3 locks held by syz-executor363/4996:
 #0: ffff88807c6be460 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:394
 #1: ffff8880745582e0 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff8880745582e0 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: open_last_lookups fs/namei.c:3557 [inline]
 #1: ffff8880745582e0 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: path_openat+0x7ba/0x3170 fs/namei.c:3788
 #2: ffff8880156f2090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock_nested+0x5f/0xd0 fs/reiserfs/lock.c:78

stack backtrace:
CPU: 1 PID: 4996 Comm: syz-executor363 Not tainted 6.3.0-syzkaller-13164-g78b421b6a7c6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x2fe/0x3b0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3108 [inline]
 check_prevs_add kernel/locking/lockdep.c:3227 [inline]
 validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3842
 __lock_acquire+0x1295/0x2000 kernel/locking/lockdep.c:5074
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
 down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1689
 inode_lock_nested include/linux/fs.h:810 [inline]
 open_xa_root fs/reiserfs/xattr.c:128 [inline]
 open_xa_dir+0x136/0x610 fs/reiserfs/xattr.c:153
 xattr_lookup+0x24/0x280 fs/reiserfs/xattr.c:396
 reiserfs_xattr_get+0xfd/0x570 fs/reiserfs/xattr.c:678
 __vfs_getxattr+0x436/0x470 fs/xattr.c:424
 smk_fetch+0xb1/0x140 security/smack/smack_lsm.c:295
 smack_d_instantiate+0x6d9/0xb40 security/smack/smack_lsm.c:3475
 security_d_instantiate+0x9b/0xf0 security/security.c:3760
 d_instantiate_new+0x65/0x120 fs/dcache.c:2053
 reiserfs_create+0x5cf/0x6e0 fs/reiserfs/namei.c:692
 lookup_open fs/namei.c:3492 [inline]
 open_last_lookups fs/namei.c:3560 [inline]
 path_openat+0x13df/0x3170 fs/namei.c:3788
 do_filp_open+0x234/0x490 fs/namei.c:3818
 do_sys_openat2+0x13f/0x500 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdd867933d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdd867402f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fdd868196c0 RCX: 00007fdd867933d9
RDX: 000000000000275a RSI: 0000000020000080 RDI: 00000000ffffff9c


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
