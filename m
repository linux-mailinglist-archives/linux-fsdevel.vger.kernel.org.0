Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFAA75783F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 11:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjGRJlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 05:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjGRJlF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:41:05 -0400
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DADE55
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 02:41:00 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-3a4074304faso7904115b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 02:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689673260; x=1692265260;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xJMY7bvWAYdU6O3eGDxNQhf1psfm1b+PBbS6BsoR+Ng=;
        b=Sga5DawIJRZU1ri+aluqoI3051CTPitRwykoisnxOJjHE/xK+fZ+Js7rZ6wnmnQGgf
         BNKSxSi+eTJ/MTOAE2eJOv4qqvrjI5cLvvJ5t/zS7UvGZ0yiBB6CABobPySFnu5l/xfo
         CpzCUB/+fKTXimRIErjDJDVeGBQ6Hb1qCTky1u/aQOppzaJmi6wET6f0Vyv1xQhkHwOQ
         aQthuVz1j7jpOfOAk/ZO03jea9d6swvGptJmXHHu43Co0fwFcAj3PakH2H6KAVftQc/o
         dkJMYZDKTeDtFlEoeJR5Beh/20ycGXlfJWu32q8nEEA+5k/N8NjDByUM3YVeX0AIewyi
         3d3w==
X-Gm-Message-State: ABy/qLbSHNzv0umVszTtcs9AcYNtfFbuTXF37KjfAaiUDCl1qKJ1QRl+
        HB5p1TkZobNrUNEE8cGTSxRWO2L41zhIwoWAl6+Gu5G4G9SH
X-Google-Smtp-Source: APBJJlEdlu0amfKkTIacGWwj0b+X3YTqj1tJhQXfnkwYJykpxO8dDNB+mo3Zul/u2pjbnE+SKdzhMPf3amMEiGNZxgoAnsp9G8lZ
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b0c:b0:3a3:8cf6:5edf with SMTP id
 bx12-20020a0568081b0c00b003a38cf65edfmr20328422oib.9.1689673260245; Tue, 18
 Jul 2023 02:41:00 -0700 (PDT)
Date:   Tue, 18 Jul 2023 02:41:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076a7840600bfb6e8@google.com>
Subject: [syzbot] [fs?] possible deadlock in inode_add_bytes
From:   syzbot <syzbot+440ff8cca06ee7a1d4db@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, cem@kernel.org, cmaiolino@redhat.com,
        jack@suse.com, jack@suse.cz, lczerner@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7c2878be5732 Add linux-next specific files for 20230714
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14c7fea2a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3baff2936ac3cefa
dashboard link: https://syzkaller.appspot.com/bug?extid=440ff8cca06ee7a1d4db
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145a2b64a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117bacb6a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bfdfa043f096/disk-7c2878be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf7a97f69e2a/vmlinux-7c2878be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8366b63af2c6/bzImage-7c2878be.xz

The issue was bisected to:

commit 1a93dd24f1bee98ca121e68ce5c0de4a60a0a0b6
Author: Carlos Maiolino <cem@kernel.org>
Date:   Thu Jul 13 13:48:47 2023 +0000

    shmem: quota support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f5143aa80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17f5143aa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f5143aa80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+440ff8cca06ee7a1d4db@syzkaller.appspotmail.com
Fixes: 1a93dd24f1be ("shmem: quota support")

======================================================
WARNING: possible circular locking dependency detected
6.5.0-rc1-next-20230714-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor340/5089 is trying to acquire lock:
ffff888075decae0 (&sb->s_type->i_lock_key){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff888075decae0 (&sb->s_type->i_lock_key){+.+.}-{2:2}, at: inode_add_bytes+0x24/0xf0 fs/stat.c:794

but task is already holding lock:
ffff888075decca0 (&xa->xa_lock#7){..-.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
ffff888075decca0 (&xa->xa_lock#7){..-.}-{2:2}, at: collapse_file+0x1ccc/0x5530 mm/khugepaged.c:1962

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&xa->xa_lock#7){..-.}-{2:2}:
       __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
       _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
       spin_lock_irq include/linux/spinlock.h:376 [inline]
       filemap_remove_folio+0xbf/0x250 mm/filemap.c:259
       truncate_inode_folio+0x49/0x70 mm/truncate.c:195
       shmem_undo_range+0x363/0x1190 mm/shmem.c:1004
       shmem_truncate_range mm/shmem.c:1120 [inline]
       shmem_evict_inode+0x334/0xb10 mm/shmem.c:1250
       evict+0x2ed/0x6b0 fs/inode.c:665
       iput_final fs/inode.c:1791 [inline]
       iput.part.0+0x55e/0x7a0 fs/inode.c:1817
       iput+0x5c/0x80 fs/inode.c:1807
       dentry_unlink_inode+0x292/0x430 fs/dcache.c:401
       __dentry_kill+0x3b8/0x640 fs/dcache.c:607
       dentry_kill fs/dcache.c:745 [inline]
       dput+0x703/0xfd0 fs/dcache.c:913
       do_renameat2+0xc4c/0xdc0 fs/namei.c:5011
       __do_sys_rename fs/namei.c:5055 [inline]
       __se_sys_rename fs/namei.c:5053 [inline]
       __x64_sys_rename+0x81/0xa0 fs/namei.c:5053
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&sb->s_type->i_lock_key){+.+.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3142 [inline]
       check_prevs_add kernel/locking/lockdep.c:3261 [inline]
       validate_chain kernel/locking/lockdep.c:3876 [inline]
       __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5144
       lock_acquire kernel/locking/lockdep.c:5761 [inline]
       lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       spin_lock include/linux/spinlock.h:351 [inline]
       inode_add_bytes+0x24/0xf0 fs/stat.c:794
       __dquot_alloc_space+0x730/0xb60 fs/quota/dquot.c:1682
       dquot_alloc_space_nodirty include/linux/quotaops.h:300 [inline]
       dquot_alloc_block_nodirty include/linux/quotaops.h:327 [inline]
       shmem_inode_acct_block mm/shmem.c:226 [inline]
       shmem_charge+0x152/0x500 mm/shmem.c:429
       collapse_file+0x20ad/0x5530 mm/khugepaged.c:1831
       hpage_collapse_scan_file+0xc8e/0x1650 mm/khugepaged.c:2285
       madvise_collapse+0x52c/0xb50 mm/khugepaged.c:2729
       madvise_vma_behavior+0x200/0x1e60 mm/madvise.c:1094
       madvise_walk_vmas+0x1cf/0x2c0 mm/madvise.c:1268
       do_madvise+0x333/0x660 mm/madvise.c:1448
       __do_sys_madvise mm/madvise.c:1461 [inline]
       __se_sys_madvise mm/madvise.c:1459 [inline]
       __x64_sys_madvise+0xaa/0x110 mm/madvise.c:1459
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&xa->xa_lock#7);
                               lock(&sb->s_type->i_lock_key);
                               lock(&xa->xa_lock#7);
  lock(&sb->s_type->i_lock_key);

 *** DEADLOCK ***

1 lock held by syz-executor340/5089:
 #0: ffff888075decca0 (&xa->xa_lock#7){..-.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
 #0: ffff888075decca0 (&xa->xa_lock#7){..-.}-{2:2}, at: collapse_file+0x1ccc/0x5530 mm/khugepaged.c:1962

stack backtrace:
CPU: 1 PID: 5089 Comm: syz-executor340 Not tainted 6.5.0-rc1-next-20230714-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x311/0x3f0 kernel/locking/lockdep.c:2195
 check_prev_add kernel/locking/lockdep.c:3142 [inline]
 check_prevs_add kernel/locking/lockdep.c:3261 [inline]
 validate_chain kernel/locking/lockdep.c:3876 [inline]
 __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5144
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 inode_add_bytes+0x24/0xf0 fs/stat.c:794
 __dquot_alloc_space+0x730/0xb60 fs/quota/dquot.c:1682
 dquot_alloc_space_nodirty include/linux/quotaops.h:300 [inline]
 dquot_alloc_block_nodirty include/linux/quotaops.h:327 [inline]
 shmem_inode_acct_block mm/shmem.c:226 [inline]
 shmem_charge+0x152/0x500 mm/shmem.c:429
 collapse_file+0x20ad/0x5530 mm/khugepaged.c:1831
 hpage_collapse_scan_file+0xc8e/0x1650 mm/khugepaged.c:2285
 madvise_collapse+0x52c/0xb50 mm/khugepaged.c:2729
 madvise_vma_behavior+0x200/0x1e60 mm/madvise.c:1094
 madvise_walk_vmas+0x1cf/0x2c0 mm/madvise.c:1268
 do_madvise+0x333/0x660 mm/madvise.c:1448
 __do_sys_madvise mm/madvise.c:1461 [inline]
 __se_sys_madvise mm/madvise.c:1459 [inline]
 __x64_sys_madvise+0xaa/0x110 mm/madvise.c:1459
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa09783a5f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa0977ad178 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007fa0978c31c8 RCX: 00007fa09783a5f9
RDX: 0000000000000019 RSI: 0000000000400000 RDI: 0000000020000000
RBP: 00007fa0978c31c0 R08: 00007ffc2e84b837 R09: 00007fa0977ad6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa0978c31cc
R13: 000000000000006e R14: 00007ffc2e84b750 R15: 00007ffc2e84b838
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
