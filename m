Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB205E9231
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Sep 2022 12:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiIYKrm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Sep 2022 06:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiIYKrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Sep 2022 06:47:40 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1182EF03
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Sep 2022 03:47:38 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id a8-20020a92c548000000b002f6440ff96bso3342379ilj.22
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Sep 2022 03:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=aeFDslDbeN/sdlaghzABmXmbk9CO2jZ/ZNvXiaw3gj8=;
        b=C0+SmeI/BK5YN2ndMer8qdJLuYxKz1psD2vkF4Yv8XyhfsoZOAy1NIaGElbjLBe7e1
         ZSiFGynfKHnYpmkwRVshHQ3/rhMd+PFQ4KeZaKNU40LUYvM8KJUqLfLuHcUrkikXkx27
         ZytxSXZtn0lSUFJd+jZ4iAMqBU5VnbC+agdlATBmQPdf1JGlRgHM0X4aEQueLv7j08M4
         SEOh5UL0jJ5aKleEt3fBXBKAMJP52tGMDWLgeXM8MW63USkN35NwliQsTki/XPNzJw6i
         0n+HJrfhXkKmJ6m1m7YKvxoRys5ZWkfqapNIZwJD3MXb5mXSptKj5Bm/Whj5m+QJTUh8
         daGA==
X-Gm-Message-State: ACrzQf0o2eNmA2QBI+UzcmQaNXYoRT96wXcGanLn0WU4AT/SQxhb8Ezp
        GK+/nqw+Vdi08FJnTiOpc3141sAY7rURIt78BCeP3zkCTUfe
X-Google-Smtp-Source: AMsMyM5953B5jFu38cPPTq8xCVCqwW/VfSMiHzzN8+aZr3hnuSQ3+O+dOwy+ZP0iCZMwZiwBZ1cuCZN/++gO2G7y30mOipsgT2JT
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1242:b0:2f6:8aac:3b1f with SMTP id
 j2-20020a056e02124200b002f68aac3b1fmr8168238ilq.68.1664102858097; Sun, 25 Sep
 2022 03:47:38 -0700 (PDT)
Date:   Sun, 25 Sep 2022 03:47:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba0dcb05e97e239b@google.com>
Subject: [syzbot] kernel panic: stack is corrupted in lock_release (3)
From:   syzbot <syzbot+4353c86db4e58720cd11@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    3db61221f4e8 Merge tag 'io_uring-6.0-2022-09-23' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10135a88880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c221af36f6d1d811
dashboard link: https://syzkaller.appspot.com/bug?extid=4353c86db4e58720cd11
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1792e6e4880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1059fcdf080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4353c86db4e58720cd11@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 264192
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: lock_release+0x7f4/0x820
CPU: 0 PID: 9489 Comm: syz-executor322 Not tainted 6.0.0-rc6-syzkaller-00291-g3db61221f4e8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 panic+0x2d6/0x715 kernel/panic.c:274
 __stack_chk_fail+0x12/0x20 kernel/panic.c:706
 lock_release+0x7f4/0x820
 __raw_spin_unlock include/linux/spinlock_api_smp.h:141 [inline]
 _raw_spin_unlock+0x12/0x40 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:389 [inline]
 inode_wait_for_writeback+0x242/0x2c0 fs/fs-writeback.c:1474
 evict+0x277/0x620 fs/inode.c:662
 ntfs_fill_super+0x3af3/0x42a0 fs/ntfs3/super.c:1190
 get_tree_bdev+0x400/0x620 fs/super.c:1323
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe603d0835a
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 08 01 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd6ef632a8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd6ef63300 RCX: 00007fe603d0835a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffd6ef632c0
RBP: 00007ffd6ef632c0 R08: 00007ffd6ef63300 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000020000bc0
R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000068
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
