Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B1B638685
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 10:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiKYJrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 04:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiKYJqm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:46:42 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A043C6C8
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 01:45:42 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id c20-20020a5d9754000000b006dbd4e6a5abso1846563ioo.17
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 01:45:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TyTObUbvHROomfZHrrlMZAPaJD3o9TopOofHcDq060Q=;
        b=0V0eMpe+0Ckqm+pNL1nfCCJEkcpl/QHmNeJkDxp7r4YsvgvzZdrUd8Hn7mDqrqJ2Pi
         j82gy9LDK0fdqCZjctJ+OmrakqLph3JMpYNHgQoka+UU7/zcfGF3i9fbLN/ov49UDue7
         O9aB4SyPUyDTWaBFds1nQRAja42X7bb+jxOeSFt3G6Py150T+WoVLBWgYtIJDESCiH9z
         hIZFX0CkdibP3oveUXW84PTHnFDGewVbCHeNM4rGL8PpNOSR/L2iYuaikIUIboeIzAaZ
         9jIrsD+yw+WUaCpgZH7CU7QYBikdal+PelgDLj+MI6mtErmdikkNHK5OWZFAVfgEMT1s
         jWPg==
X-Gm-Message-State: ANoB5pnbGcRQ5Ev0g7je/INRKryfy+BAppoKiIAgbgoG3hUZymy7aRR9
        m0kC/5GwmDyt9nKl9lJh3jBlr+dZR6lTS0gdGwTAjkUpJFfB
X-Google-Smtp-Source: AA0mqf4o24n/Orx4YC0DHhmvarfVZCFeOWmEwqaYid9ZdvpmqLg6HCHxNJ0x2z6CJbpyaQZM/GuBpKmXcC96BFZ/o/nP/MOLsg4E
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2814:b0:6de:ca95:45d8 with SMTP id
 d20-20020a056602281400b006deca9545d8mr10997199ioe.26.1669369541410; Fri, 25
 Nov 2022 01:45:41 -0800 (PST)
Date:   Fri, 25 Nov 2022 01:45:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083c82605ee486236@google.com>
Subject: [syzbot] possible deadlock in hfsplus_get_block
From:   syzbot <syzbot+b7ef7c0c8d8098686ae2@syzkaller.appspotmail.com>
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

HEAD commit:    4312098baf37 Merge tag 'spi-fix-v6.1-rc6' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=121367e5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122d9403880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1150559b880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7073d20a37/disk-4312098b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/36a0367a5593/vmlinux-4312098b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/265bedb3086b/bzImage-4312098b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1a892c1e3bf7/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7ef7c0c8d8098686ae2@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.1.0-rc6-syzkaller-00012-g4312098baf37 #0 Not tainted
--------------------------------------------
syz-executor378/3638 is trying to acquire lock:
ffff888023aa1548 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_get_block+0x3a3/0x1560 fs/hfsplus/extents.c:260

but task is already holding lock:
ffff888023aa3048 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_extend+0x1af/0x19d0 fs/hfsplus/extents.c:457

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&HFSPLUS_I(inode)->extents_lock);
  lock(&HFSPLUS_I(inode)->extents_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by syz-executor378/3638:
 #0: ffff888026644460 (sb_writers#9){.+.+}-{0:0}, at: do_sys_ftruncate+0x24f/0x380 fs/open.c:190
 #1: ffff888023aa3240 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff888023aa3240 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: do_truncate+0x1e7/0x2e0 fs/open.c:63
 #2: ffff888023aa3048 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_extend+0x1af/0x19d0 fs/hfsplus/extents.c:457
 #3: ffff88807743d8f8 (&sbi->alloc_mutex){+.+.}-{3:3}, at: hfsplus_block_allocate+0x9f/0x900 fs/hfsplus/bitmap.c:35

stack backtrace:
CPU: 1 PID: 3638 Comm: syz-executor378 Not tainted 6.1.0-rc6-syzkaller-00012-g4312098baf37 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_deadlock_bug kernel/locking/lockdep.c:2990 [inline]
 check_deadlock kernel/locking/lockdep.c:3033 [inline]
 validate_chain+0x4843/0x6ae0 kernel/locking/lockdep.c:3818
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 hfsplus_get_block+0x3a3/0x1560 fs/hfsplus/extents.c:260
 block_read_full_folio+0x3b3/0xfa0 fs/buffer.c:2271
 filemap_read_folio+0x187/0x7d0 mm/filemap.c:2407
 do_read_cache_folio+0x2d3/0x790 mm/filemap.c:3534
 do_read_cache_page mm/filemap.c:3576 [inline]
 read_cache_page+0x56/0x270 mm/filemap.c:3585
 read_mapping_page include/linux/pagemap.h:756 [inline]
 hfsplus_block_allocate+0xf9/0x900 fs/hfsplus/bitmap.c:37
 hfsplus_file_extend+0x9d4/0x19d0 fs/hfsplus/extents.c:468
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
 notify_change+0xe38/0x10f0 fs/attr.c:420
 do_truncate+0x1fb/0x2e0 fs/open.c:65
 do_sys_ftruncate+0x2eb/0x380 fs/open.c:193
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f838df947c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb8a18448 EFLAGS: 00000246 ORIG


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
