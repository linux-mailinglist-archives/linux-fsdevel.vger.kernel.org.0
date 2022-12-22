Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015DD653C84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 08:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiLVHbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 02:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiLVHbm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 02:31:42 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A712B23EA6
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 23:31:39 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id y24-20020a5ec818000000b006e2c0847835so427290iol.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 23:31:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mnVqi3txO1OeQ2GzgVrxhdgFk3QtXdH8vq8vR+kzpJ0=;
        b=lpgwVi21U4MAgTBHNCnC+vwLvR4hKI77sfab+FaIvOM7HuSQKLE9BYr14foAWhjDhy
         Io0Ox6aO9xb6YxFNicwRGlEqrMCPz7RM1qQyouifa6raQUu6rWpUrypiKvRlZhG+o+yL
         fqgm6DBs0rsoodZsd2eXskEHgFUZRfVmmIlAiFenq3WdPsCA+NoB07HxdxZxzZXd01r9
         imNN44idl41271TOCGjfBfIoKSdLrorZg3yLVy7sZq96h6VX+P0jwE95BcjodF8g2vI0
         8zQ3yVHTmkWZgViKkVTL4a+kxixrjZVF5k7iMvtUoMWP36mFU2vx0TrHSjYCwE08sr3Y
         UUXw==
X-Gm-Message-State: AFqh2kqjbWmbdYtNwhlpPdiB/S8rEDjd7CXRX6aJR29Dded52Y/ZPbAD
        05gmlmX4r5MtsU3H5G2OzxW+AJ/cCzMzNuuIEznxgTSeFliO
X-Google-Smtp-Source: AMrXdXuKqqHYyJ/TnPnD6LTacc0+vSFbpWb/vQdyy9FcT4IUdnLhcLiT3qdhdkUoEZHqvaRRKyUHFG15sDldMbdKc/uW3XB2FwtR
MIME-Version: 1.0
X-Received: by 2002:a02:5d84:0:b0:38a:4c12:94ce with SMTP id
 w126-20020a025d84000000b0038a4c1294cemr378048jaa.50.1671694299061; Wed, 21
 Dec 2022 23:31:39 -0800 (PST)
Date:   Wed, 21 Dec 2022 23:31:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de66b105f065a847@google.com>
Subject: [syzbot] [hfsplus?] possible deadlock in hfsplus_find_init
From:   syzbot <syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b6bb9676f216 Merge tag 'm68knommu-for-v6.2' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=167bb2c8480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3fb546de56fbf8d
dashboard link: https://syzkaller.appspot.com/bug?extid=f8ce6c197125ab9d72ce
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105f5464480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13994073880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2f703f794500/disk-b6bb9676.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0cca7cdd545b/vmlinux-b6bb9676.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0ce2560b7652/bzImage-b6bb9676.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8ddb7c2fc877/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-syzkaller-13872-gb6bb9676f216 #0 Not tainted
------------------------------------------------------
syz-executor156/5069 is trying to acquire lock:
ffff88802b6920b0 (&tree->tree_lock/1){+.+.}-{3:3}, at: hfsplus_find_init+0x143/0x1b0

but task is already holding lock:
ffff88802953b048 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_truncate+0x280/0xbb0 fs/hfsplus/extents.c:576

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       hfsplus_file_extend+0x1af/0x19d0 fs/hfsplus/extents.c:457
       hfsplus_bmap_reserve+0x123/0x500 fs/hfsplus/btree.c:358
       __hfsplus_ext_write_extent+0x28e/0x590 fs/hfsplus/extents.c:104
       __hfsplus_ext_cache_extent+0x8d/0x810 fs/hfsplus/extents.c:186
       hfsplus_ext_read_extent fs/hfsplus/extents.c:218 [inline]
       hfsplus_file_extend+0x3cc/0x19d0 fs/hfsplus/extents.c:461
       hfsplus_get_block+0x415/0x1560 fs/hfsplus/extents.c:245
       __block_write_begin_int+0x54c/0x1a80 fs/buffer.c:1991
       __block_write_begin fs/buffer.c:2041 [inline]
       block_write_begin+0x93/0x1e0 fs/buffer.c:2102
       cont_write_begin+0x606/0x860 fs/buffer.c:2456
       hfsplus_write_begin+0x86/0xd0 fs/hfsplus/inode.c:52
       cont_expand_zero fs/buffer.c:2383 [inline]
       cont_write_begin+0x2cf/0x860 fs/buffer.c:2446
       hfsplus_write_begin+0x86/0xd0 fs/hfsplus/inode.c:52
       generic_cont_expand_simple+0x151/0x250 fs/buffer.c:2347
       hfsplus_setattr+0x168/0x280 fs/hfsplus/inode.c:263
       notify_change+0xe50/0x1100 fs/attr.c:482
       do_truncate+0x200/0x2f0 fs/open.c:65
       do_sys_ftruncate+0x2b0/0x350 fs/open.c:193
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&tree->tree_lock/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       hfsplus_find_init+0x143/0x1b0
       hfsplus_file_truncate+0x3d1/0xbb0 fs/hfsplus/extents.c:582
       hfsplus_setattr+0x1b8/0x280 fs/hfsplus/inode.c:269
       notify_change+0xe50/0x1100 fs/attr.c:482
       do_truncate+0x200/0x2f0 fs/open.c:65
       do_sys_ftruncate+0x2b0/0x350 fs/open.c:193
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&HFSPLUS_I(inode)->extents_lock);
                               lock(&tree->tree_lock/1);
                               lock(&HFSPLUS_I(inode)->extents_lock);
  lock(&tree->tree_lock/1);

 *** DEADLOCK ***

3 locks held by syz-executor156/5069:
 #0: ffff88802b690460 (sb_writers#9){.+.+}-{0:0}, at: do_sys_ftruncate+0x243/0x350 fs/open.c:190
 #1: ffff88802953b240 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff88802953b240 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: do_truncate+0x1ec/0x2f0 fs/open.c:63
 #2: ffff88802953b048 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_truncate+0x280/0xbb0 fs/hfsplus/extents.c:576

stack backtrace:
CPU: 0 PID: 5069 Comm: syz-executor156 Not tainted 6.1.0-syzkaller-13872-gb6bb9676f216 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 hfsplus_find_init+0x143/0x1b0
 hfsplus_file_truncate+0x3d1/0xbb0 fs/hfsplus/extents.c:582
 hfsplus_setattr+0x1b8/0x280 fs/hfsplus/inode.c:269
 notify_change+0xe50/0x1100 fs/attr.c:482
 do_truncate+0x200/0x2f0 fs/open.c:65
 do_sys_ftruncate+0x2b0/0x350 fs/open.c:193
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0cadd0a239
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffccf2763a8 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0cadd0a239
RDX: 00007f0cadd0a239 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000000000 R08: 00007f0cadd78ec0 R09: 00007f0cadd78ec0
R10: 00007f0cadd78ec0 R11: 0000000000000246 R12: 00007ffccf2763d0
R13: 0000000000000000 R14: 431bde82d7b634db R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
