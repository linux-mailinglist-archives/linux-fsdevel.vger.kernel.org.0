Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A43733FCE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 11:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjFQJBK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jun 2023 05:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbjFQJBJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jun 2023 05:01:09 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE612113
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jun 2023 02:01:08 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-77e2421ee83so82873439f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jun 2023 02:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686992467; x=1689584467;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kCZf97Eox4u67Klmj8lmXvnCId2RnzbotAfmTDKMiNg=;
        b=JYI0EWeCOso1EJRrS64nD1XalLPUmvDbrOfMjOn+BClP6lc5LfjjpPK62NyqSbIvWX
         26mO9rCK4u1dl+OkDoL6IPJ7QszHh2OMIR2O2NB/E8hByHu5Ln/00BqL7uTCto11IuDg
         cToM42O8ik5QHX785PXKeHvQeW8n1d/DdvTHez1LFr23yK9PSOcDZBjzCSBVt/spRV6T
         uNG7Bj9xApzxIL9GzXuzVoUcCp0t5eyQJJaXjpocJSpT5TABxiUhkEV7kpOQTPanVIdx
         VhnhIqXx0uPbhzbzqJjn3J2Y4J7ofn00EMELUC+ReFUFnwSOdPcPZFfduRRRI9qMt/od
         2kZA==
X-Gm-Message-State: AC+VfDyTiCho+xMROfvi2PEDfDDle/HdRUEsD1iptIYO2IOVT8TWbNtu
        9gsNgW0P5USNMoBUiiCVvopl6rnA/2zjM4/Y54ouEfpqiDKh
X-Google-Smtp-Source: ACHHUZ7cft+FCmnH2pEaVea26oLExDWClBt0nq4LlTvkudLqcfpayVBixd6cQrP8GJx3Xh/TEnyWRwL+ojZSl47nFVcoJ39KXwiF
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:790:b0:335:ba2a:c3d with SMTP id
 q16-20020a056e02079000b00335ba2a0c3dmr1097467ils.5.1686992467471; Sat, 17 Jun
 2023 02:01:07 -0700 (PDT)
Date:   Sat, 17 Jun 2023 02:01:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3329c05fe4f8aa0@google.com>
Subject: [syzbot] [f2fs?] possible deadlock in f2fs_file_mmap
From:   syzbot <syzbot+c0e3db4f9cd6e05cadd3@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b16049b21162 Add linux-next specific files for 20230614
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=134b968d280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d103d5f9125e9fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=c0e3db4f9cd6e05cadd3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1620a663280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1327629b280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a21dda01fc71/disk-b16049b2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f31e3fc32b7a/vmlinux-b16049b2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3967bcf93010/bzImage-b16049b2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8deff423ac75/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c0e3db4f9cd6e05cadd3@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc6-next-20230614-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor407/5033 is trying to acquire lock:
ffff888076c40a28 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:768 [inline]
ffff888076c40a28 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: f2fs_file_mmap+0x154/0x290 fs/f2fs/file.c:527

but task is already holding lock:
ffff8880787d3768 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:110 [inline]
ffff8880787d3768 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x158/0x3b0 mm/util.c:541

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       down_read+0x9c/0x480 kernel/locking/rwsem.c:1520
       mmap_read_lock include/linux/mmap_lock.h:142 [inline]
       do_user_addr_fault+0xb3d/0x1210 arch/x86/mm/fault.c:1391
       handle_page_fault arch/x86/mm/fault.c:1534 [inline]
       exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1590
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
       fault_in_readable+0x129/0x210 mm/gup.c:1928
       fault_in_iov_iter_readable+0x252/0x2c0 lib/iov_iter.c:216
       f2fs_preallocate_blocks fs/f2fs/file.c:4508 [inline]
       f2fs_file_write_iter+0x516/0x2500 fs/f2fs/file.c:4744
       call_write_iter include/linux/fs.h:1865 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x960/0xd70 fs/read_write.c:584
       ksys_write+0x122/0x250 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3142 [inline]
       check_prevs_add kernel/locking/lockdep.c:3261 [inline]
       validate_chain kernel/locking/lockdep.c:3876 [inline]
       __lock_acquire+0x2e9d/0x5e20 kernel/locking/lockdep.c:5144
       lock_acquire.part.0+0x11c/0x370 kernel/locking/lockdep.c:5761
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       inode_lock include/linux/fs.h:768 [inline]
       f2fs_file_mmap+0x154/0x290 fs/f2fs/file.c:527
       call_mmap include/linux/fs.h:1870 [inline]
       mmap_region+0x99c/0x2770 mm/mmap.c:2675
       do_mmap+0x850/0xee0 mm/mmap.c:1367
       vm_mmap_pgoff+0x1a2/0x3b0 mm/util.c:543
       ksys_mmap_pgoff+0x42b/0x5b0 mm/mmap.c:1413
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#15);
                               lock(&mm->mmap_lock);
  lock(&sb->s_type->i_mutex_key#15);

 *** DEADLOCK ***

1 lock held by syz-executor407/5033:
 #0: ffff8880787d3768 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:110 [inline]
 #0: ffff8880787d3768 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x158/0x3b0 mm/util.c:541

stack backtrace:
CPU: 1 PID: 5033 Comm: syz-executor407 Not tainted 6.4.0-rc6-next-20230614-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x2df/0x3b0 kernel/locking/lockdep.c:2195
 check_prev_add kernel/locking/lockdep.c:3142 [inline]
 check_prevs_add kernel/locking/lockdep.c:3261 [inline]
 validate_chain kernel/locking/lockdep.c:3876 [inline]
 __lock_acquire+0x2e9d/0x5e20 kernel/locking/lockdep.c:5144
 lock_acquire.part.0+0x11c/0x370 kernel/locking/lockdep.c:5761
 down_write+0x92/0x200 kernel/locking/rwsem.c:1573
 inode_lock include/linux/fs.h:768 [inline]
 f2fs_file_mmap+0x154/0x290 fs/f2fs/file.c:527
 call_mmap include/linux/fs.h:1870 [inline]
 mmap_region+0x99c/0x2770 mm/mmap.c:2675
 do_mmap+0x850/0xee0 mm/mmap.c:1367
 vm_mmap_pgoff+0x1a2/0x3b0 mm/util.c:543
 ksys_mmap_pgoff+0x42b/0x5b0 mm/mmap.c:1413
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5f44cdf4d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5f3dc292f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f5f44d696f8 RCX: 00007f5f44cdf4d9
RDX: 000000000000000b RSI: 0000000000b36000 RDI: 0000000020000000
RBP: 00007f5f44d696f0 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000028011 R11: 0000000000000246 R12: 00007f5f44d696fc
R13: 656d6974797a616c R14: 746e657478656f6e R15: 0000000000022000
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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
