Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D92F62EE96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 08:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241066AbiKRHoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 02:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiKRHoB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:44:01 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367DC8B103;
        Thu, 17 Nov 2022 23:44:00 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id i10so11020854ejg.6;
        Thu, 17 Nov 2022 23:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cGdiTgTnTaS+gRylZczJAYJ3Q+QyE4zG+5ns9XGhwVs=;
        b=Bdms4FkuQrhXYzbpvRrtAo+J7Z3HSOyj0goDzVmQsaykXQrG/V2yIU8fbP3XewsUv/
         BD5Uqwd/0m7kmXnI+e6vc2MMWZZor5CxcVvbpF8N1FxLenYK3W02qRqoP1u1hnFUPrwI
         juoYEFPSisJm/sceksaKAfIhVxSlz8DmvZlnNUn5Gcei9c/pYB9gE/ah6GuZXAu01a8A
         lL8XH0d1ln6C7Re16IHFgw0tzJHjcdGmiQB35Mp0RnpClXVI4PXojCHMrPmTWgUIyswe
         UdoMn7Hf7ZyEpT/K3W6Bu8WUxPSxQq/4C1XJPmh9zQfL8Ao3td/ocTKnY+0D1Wsq4NtE
         HqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGdiTgTnTaS+gRylZczJAYJ3Q+QyE4zG+5ns9XGhwVs=;
        b=W4Jl6HQiCi2EkBVqx/MABlu3vKmDLzXZAlrxjRTndaZtA1w0nHLebTk37aDknaYg20
         7MgbXI9rfHeqZJ3Np9UM35AdaEV5N36cb0VgUJStGuEZjdx6FD1hp+UofaqOwugb3cBN
         gCbgfnJz8ZJQIWfnyZ7Q++PgR8mQrJPOfby0aRg5HBVayYI7Ix4Uj3eoxqY1DfDCRJ1/
         6FlnNbldv7XBg3F/R/aHJdqx+6uAKQnEuLjAzw7ataD8kAMgDqFlgIt5E0dH3hXtaaXN
         nYO9UaH1kvPYRnxF+58xx4wDv0y7Vl4v/U5TMaDnARzkpUv4EVhgExjzkM1YAMlwKrVc
         udjQ==
X-Gm-Message-State: ANoB5pk01+D/LVEnkXURVfKbe/m4bWfTReLMXc+k8qeyGXbR8vuWRGi7
        ASkxgNDvlemZytwvPkvsnt2Z+zJtpMRfyOlNiTA=
X-Google-Smtp-Source: AA0mqf4u+NAtiiiEICruJibu8kuxcLdGjXoD2lfEjHfFtdxkAQk88VgqOLNdofAv7IFPXODOouM7f3UxDll2FoqoWS0=
X-Received: by 2002:a17:906:50f:b0:78d:ad5d:75e with SMTP id
 j15-20020a170906050f00b0078dad5d075emr4996514eja.172.1668757438441; Thu, 17
 Nov 2022 23:43:58 -0800 (PST)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Fri, 18 Nov 2022 15:43:25 +0800
Message-ID: <CAO4mrfcdN+hhFZ2Vi=hOUMx3s5hLzGJ6vTJjjkbCy3GSrtecmg@mail.gmail.com>
Subject: possible deadlock in ext4_file_read_iter
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        hch@infradead.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: 4fe89d07 Linux v6.0
git tree: upstream
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/1xryzmZ5xIuxzLyGxjgIBEcCequ085c5y/view?usp=share_link
kernel config: https://drive.google.com/file/d/1ZHRxVTXHL9mENdAPmQYS1DtgbflZ9XsD/view?usp=sharing

Unfortunately, I didn't have a reproducer for this bug yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

======================================================
WARNING: possible circular locking dependency detected
6.0.0+ #39 Not tainted
------------------------------------------------------
syz-executor.0/934 is trying to acquire lock:
ffff88804501ce28 (&mm->mmap_lock#2){++++}-{3:3}, at:
__might_fault+0x8f/0x110 mm/memory.c:5582

but task is already holding lock:
ffff88804673ca38 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at:
inode_lock_shared include/linux/fs.h:766 [inline]
ffff88804673ca38 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at:
ext4_dio_read_iter fs/ext4/file.c:63 [inline]
ffff88804673ca38 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at:
ext4_file_read_iter+0x26c/0x770 fs/ext4/file.c:130

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&sb->s_type->i_mutex_key#8){++++}-{3:3}:
       lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5666
       down_read+0x39/0x50 kernel/locking/rwsem.c:1499
       inode_lock_shared include/linux/fs.h:766 [inline]
       ext4_bmap+0x55/0x410 fs/ext4/inode.c:3157
       bmap+0xa1/0xd0 fs/inode.c:1799
       jbd2_journal_bmap fs/jbd2/journal.c:971 [inline]
       __jbd2_journal_erase fs/jbd2/journal.c:1784 [inline]
       jbd2_journal_flush+0x5bc/0xc70 fs/jbd2/journal.c:2490
       ext4_ioctl_checkpoint fs/ext4/ioctl.c:1082 [inline]
       __ext4_ioctl fs/ext4/ioctl.c:1586 [inline]
       ext4_ioctl+0x3208/0x5230 fs/ext4/ioctl.c:1606
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (&journal->j_checkpoint_mutex){+.+.}-{3:3}:
       lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5666
       __mutex_lock_common+0x1b7/0x26d0 kernel/locking/mutex.c:603
       mutex_lock_io_nested+0x43/0x60 kernel/locking/mutex.c:833
       __jbd2_log_wait_for_space+0x21d/0x6f0 fs/jbd2/checkpoint.c:110
       add_transaction_credits+0x916/0xbd0 fs/jbd2/transaction.c:298
       start_this_handle+0x733/0x16f0 fs/jbd2/transaction.c:422
       jbd2__journal_start+0x2ca/0x5b0 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x111/0x1d0 fs/ext4/ext4_jbd2.c:105
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_dirty_inode+0x8a/0x100 fs/ext4/inode.c:5963
       __mark_inode_dirty+0xb6/0x600 fs/fs-writeback.c:2381
       generic_update_time+0x1c7/0x1e0 fs/inode.c:1860
       inode_update_time fs/inode.c:1873 [inline]
       __file_update_time fs/inode.c:2089 [inline]
       file_update_time+0x3b3/0x430 fs/inode.c:2120
       ext4_page_mkwrite+0x1c5/0x1410 fs/ext4/inode.c:6084
       do_page_mkwrite+0x1a4/0x5f0 mm/memory.c:2971
       do_shared_fault mm/memory.c:4589 [inline]
       do_fault+0x441/0x9c0 mm/memory.c:4657
       handle_pte_fault+0x6eb/0x1660 mm/memory.c:4917
       __handle_mm_fault mm/memory.c:5059 [inline]
       handle_mm_fault+0xdd3/0x1630 mm/memory.c:5157
       do_user_addr_fault+0x896/0x10e0 arch/x86/mm/fault.c:1397
       handle_page_fault arch/x86/mm/fault.c:1488 [inline]
       exc_page_fault+0xa1/0x1e0 arch/x86/mm/fault.c:1544
       asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570

-> #1 (sb_pagefaults){.+.+}-{0:0}:
       lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5666
       percpu_down_read+0x44/0x190 include/linux/percpu-rwsem.h:51
       __sb_start_write include/linux/fs.h:1826 [inline]
       sb_start_pagefault include/linux/fs.h:1930 [inline]
       ext4_page_mkwrite+0x1ae/0x1410 fs/ext4/inode.c:6083
       do_page_mkwrite+0x1a4/0x5f0 mm/memory.c:2971
       do_shared_fault mm/memory.c:4589 [inline]
       do_fault+0x441/0x9c0 mm/memory.c:4657
       handle_pte_fault+0x6eb/0x1660 mm/memory.c:4917
       __handle_mm_fault mm/memory.c:5059 [inline]
       handle_mm_fault+0xdd3/0x1630 mm/memory.c:5157
       do_user_addr_fault+0x896/0x10e0 arch/x86/mm/fault.c:1397
       handle_page_fault arch/x86/mm/fault.c:1488 [inline]
       exc_page_fault+0xa1/0x1e0 arch/x86/mm/fault.c:1544
       asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570

-> #0 (&mm->mmap_lock#2){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add+0x4f5/0x5d30 kernel/locking/lockdep.c:3214
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x4432/0x6080 kernel/locking/lockdep.c:5053
       lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5666
       __might_fault+0xb2/0x110 mm/memory.c:5583
       __clear_user arch/x86/lib/usercopy_64.c:20 [inline]
       clear_user+0xbf/0x150 arch/x86/lib/usercopy_64.c:52
       iov_iter_zero+0x48a/0x1450 lib/iov_iter.c:795
       iomap_dio_hole_iter fs/iomap/direct-io.c:390 [inline]
       iomap_dio_iter fs/iomap/direct-io.c:438 [inline]
       __iomap_dio_rw+0x14e1/0x2170 fs/iomap/direct-io.c:602
       iomap_dio_rw+0x42/0xa0 fs/iomap/direct-io.c:690
       ext4_dio_read_iter fs/ext4/file.c:79 [inline]
       ext4_file_read_iter+0x5bc/0x770 fs/ext4/file.c:130
       call_read_iter include/linux/fs.h:2181 [inline]
       do_iter_readv_writev fs/read_write.c:733 [inline]
       do_iter_read+0x710/0xc30 fs/read_write.c:796
       vfs_readv fs/read_write.c:916 [inline]
       do_readv+0x219/0x410 fs/read_write.c:953
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock#2 --> &journal->j_checkpoint_mutex -->
&sb->s_type->i_mutex_key#8

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#8);
                               lock(&journal->j_checkpoint_mutex);
                               lock(&sb->s_type->i_mutex_key#8);
  lock(&mm->mmap_lock#2);

 *** DEADLOCK ***

2 locks held by syz-executor.0/934:
 #0: ffff8880188000e8 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0x23a/0x2d0 fs/file.c:1036
 #1: ffff88804673ca38 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at:
inode_lock_shared include/linux/fs.h:766 [inline]
 #1: ffff88804673ca38 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at:
ext4_dio_read_iter fs/ext4/file.c:63 [inline]
 #1: ffff88804673ca38 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at:
ext4_file_read_iter+0x26c/0x770 fs/ext4/file.c:130

stack backtrace:
CPU: 1 PID: 934 Comm: syz-executor.0 Not tainted 6.0.0+ #39
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_circular_bug+0xa95/0xd40 kernel/locking/lockdep.c:2053
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add+0x4f5/0x5d30 kernel/locking/lockdep.c:3214
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x4432/0x6080 kernel/locking/lockdep.c:5053
 lock_acquire+0x17f/0x430 kernel/locking/lockdep.c:5666
 __might_fault+0xb2/0x110 mm/memory.c:5583
 __clear_user arch/x86/lib/usercopy_64.c:20 [inline]
 clear_user+0xbf/0x150 arch/x86/lib/usercopy_64.c:52
 iov_iter_zero+0x48a/0x1450 lib/iov_iter.c:795
 iomap_dio_hole_iter fs/iomap/direct-io.c:390 [inline]
 iomap_dio_iter fs/iomap/direct-io.c:438 [inline]
 __iomap_dio_rw+0x14e1/0x2170 fs/iomap/direct-io.c:602
 iomap_dio_rw+0x42/0xa0 fs/iomap/direct-io.c:690
 ext4_dio_read_iter fs/ext4/file.c:79 [inline]
 ext4_file_read_iter+0x5bc/0x770 fs/ext4/file.c:130
 call_read_iter include/linux/fs.h:2181 [inline]
 do_iter_readv_writev fs/read_write.c:733 [inline]
 do_iter_read+0x710/0xc30 fs/read_write.c:796
 vfs_readv fs/read_write.c:916 [inline]
 do_readv+0x219/0x410 fs/read_write.c:953
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f020068bded
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f020182cc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000013
RAX: ffffffffffffffda RBX: 00007f02007abf80 RCX: 00007f020068bded
RDX: 0000000000000001 RSI: 0000000020001440 RDI: 0000000000000004
RBP: 00007f02006f8ce0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f02007abf80
R13: 00007ffcd43c130f R14: 00007ffcd43c14b0 R15: 00007f020182cdc0
 </TASK>

Best,
Wei
