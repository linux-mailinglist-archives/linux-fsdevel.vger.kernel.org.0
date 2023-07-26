Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBF4763924
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbjGZOax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbjGZOaw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:30:52 -0400
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC17C19A1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:30:47 -0700 (PDT)
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-6b9ef9cd887so1717152a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381847; x=1690986647;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BLnveNQNUeRMV9+8/gX2nx7OCERcD8PiCFgXgd8INio=;
        b=GK3e96CflGxVX0XbQ4uUv22feVa4tG3zLcyeVEhkWwAJfOuw1g4PKDf2cJc5zh/M43
         jtaHyk0iNjRgnv9/GUnxQFk7poydsMCLhJTT9ZZkLW5xTTsR1lQ7uRBhwwjclA4g+VWw
         tMvucny08ioJSajNiDoUBUaZyNP9GtFU+SFsdT/ObRnHlUaUFyp+PijUAFHq+JH0ZLnC
         vlqliyYyXw2UOBqthX6l7pECqvZyFVR+awBfDHNC8Z4tSgsoxHG0ZMp3cdnCQrsIfXp0
         SVS1AJX2BqettPXKs1s+ToaWNLMtzf/U/mqgpOCZNqTWENKNQxGf6oxRIKVgP1Jkq4Au
         mHNw==
X-Gm-Message-State: ABy/qLaV8hgidPJmPsGIP1vXeWCFt26FzDXYMWeuG4c7mFcMfiqfZs2y
        o5AF9w4TIFfSvgQznCynfDIeYANVZH3y4oxvntOKPWRI/NCq
X-Google-Smtp-Source: APBJJlF94a7aZPlBEEnkqliCoEGpJ7HkuzLH8OrGyYMoZf3TnyszHLvpYBOhSf3vWG9YPVHulH/EgwVJaG3uzLk7VgPFQ/GhsUTa
MIME-Version: 1.0
X-Received: by 2002:a05:6830:30b1:b0:6b8:70f3:fd36 with SMTP id
 g49-20020a05683030b100b006b870f3fd36mr3643946ots.2.1690381847267; Wed, 26 Jul
 2023 07:30:47 -0700 (PDT)
Date:   Wed, 26 Jul 2023 07:30:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a91fe060164b11f@google.com>
Subject: [syzbot] [fs?] WARNING in __brelse (3)
From:   syzbot <syzbot+ce3af36144a13b018cc7@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liushixin2@huawei.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d192f5382581 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16ef7c6aa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28e257d54f02de1a
dashboard link: https://syzkaller.appspot.com/bug?extid=ce3af36144a13b018cc7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15302152a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12771152a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5646cedb4f1a/disk-d192f538.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14060d990196/vmlinux-d192f538.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f58a09eb6b40/bzImage-d192f538.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b412a33c80f2/mount_0.gz

The issue was bisected to:

commit f6e2c20ca7604e6a267c93a511d19dda72573be1
Author: Liu Shixin <liushixin2@huawei.com>
Date:   Fri Apr 29 21:38:04 2022 +0000

    fs: sysv: check sbi->s_firstdatazone in complete_read_super

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=167a02bea80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=157a02bea80000
console output: https://syzkaller.appspot.com/x/log.txt?x=117a02bea80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ce3af36144a13b018cc7@syzkaller.appspotmail.com
Fixes: f6e2c20ca760 ("fs: sysv: check sbi->s_firstdatazone in complete_read_super")

------------[ cut here ]------------
VFS: brelse: Trying to free free buffer
WARNING: CPU: 1 PID: 5011 at fs/buffer.c:1257 __brelse fs/buffer.c:1257 [inline]
WARNING: CPU: 1 PID: 5011 at fs/buffer.c:1257 __brelse+0x6b/0xa0 fs/buffer.c:1251
Modules linked in:
CPU: 1 PID: 5011 Comm: syz-executor104 Not tainted 6.5.0-rc2-syzkaller-00307-gd192f5382581 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:__brelse fs/buffer.c:1257 [inline]
RIP: 0010:__brelse+0x6b/0xa0 fs/buffer.c:1251
Code: 7c 04 84 d2 75 4e 44 8b 63 60 31 ff 44 89 e6 e8 1b 29 8d ff 45 85 e4 75 1c e8 a1 2d 8d ff 48 c7 c7 20 a7 7c 8a e8 65 f6 53 ff <0f> 0b 5b 5d 41 5c e9 8a 2d 8d ff e8 85 2d 8d ff be 04 00 00 00 48
RSP: 0018:ffffc900033cf8c8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffff88807135a2b8 RCX: 0000000000000000
RDX: ffff88807e0da000 RSI: ffffffff814c5346 RDI: 0000000000000001
RBP: ffff88807135a318 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff88807135a2b8 R14: dffffc0000000000 R15: ffffffff81f85b70
FS:  0000555555653380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 000000007cf88000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 brelse include/linux/buffer_head.h:339 [inline]
 __invalidate_bh_lrus fs/buffer.c:1492 [inline]
 invalidate_bh_lru+0xa2/0x190 fs/buffer.c:1505
 csd_do_func kernel/smp.c:131 [inline]
 smp_call_function_many_cond+0x122a/0x1570 kernel/smp.c:826
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1003
 invalidate_bdev+0x9b/0xd0 block/bdev.c:85
 invalidate_disk+0x41/0x110 block/genhd.c:734
 __loop_clr_fd+0x259/0x900 drivers/block/loop.c:1164
 loop_clr_fd drivers/block/loop.c:1257 [inline]
 lo_ioctl+0x5d8/0x1a50 drivers/block/loop.c:1563
 blkdev_ioctl+0x2f9/0x770 block/ioctl.c:621
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f986153247b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007ffd9d3fbdc0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000016 RCX: 00007f986153247b
RDX: 0000000000000000 RSI: 0000000000004c01 RDI: 0000000000000004
RBP: 0000000000000004 R08: 00007ffd9d3fbe60 R09: 0000000000009df6
R10: 0000000000008003 R11: 0000000000000246 R12: 00007ffd9d3fbe60
R13: 0000000000000003 R14: 0000000000010000 R15: 0000000000000001
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
