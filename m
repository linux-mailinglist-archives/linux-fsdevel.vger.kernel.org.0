Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2A25979F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 01:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbiHQXCa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 19:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbiHQXC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:02:28 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE745AB4C6
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 16:02:27 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id c7-20020a056e020bc700b002e59be6ce85so46927ilu.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 16:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=c/rQLSmXLwRKxJTLqW1KzsFCcUKlOv5n8qILVlbyfVg=;
        b=ZWz2CdwZN0fIjSmyGQiRo212xYToCKaFAWYgX8f54MTMVZk1znzFwI8hzW+WOz2bgb
         VfRBKwxebI9rFUZJq+r5SH14fK96uQHvsMe0SW5myNPjyYeZm0x/UFkx3Kqet/pPBmsG
         XbAdu0EbLRElOb+ozRSQ72GvDfB3AG6W00gpnOkVEO6hBmRU/IUaqXwXwLgXY2Exn+Xk
         /RF+rhc8eZY7HA6bvMtDH3wb3aZpjYUn71l9atpWY8auK9BqTe4pisg9nS0pTqo2G3WC
         cKyfJ3FNYImgWFkNJ0ui7yuL29KmjbVIz8novNlHeFHpZUFL8ynZ+Glad7LaudCx4vyk
         m3Vg==
X-Gm-Message-State: ACgBeo2MmsAlDqciWwG+wljG4ozW/TkbFv/1LQI2vYPvKeEQLSkmwW4Y
        M8fHL5YBUgJTmTDWJ9wX+xn8LtKYYKzyX+/rFYwkwboKtiam
X-Google-Smtp-Source: AA6agR5iI2f9Ufx/WobvSwWnDRuUxAfNpxSjHbC2yunNdq7MP8Dy2WrZ+eDs3x31Qas+d6XryP9vkzYcVbvR8CifII9S78th+LZx
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1522:b0:2e5:9e3c:a7c8 with SMTP id
 i2-20020a056e02152200b002e59e3ca7c8mr177092ilu.237.1660777347272; Wed, 17 Aug
 2022 16:02:27 -0700 (PDT)
Date:   Wed, 17 Aug 2022 16:02:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5d86405e677dbd2@google.com>
Subject: [syzbot] KASAN: vmalloc-out-of-bounds Write in find_lock_entries
From:   syzbot <syzbot+e498ebacfd2fd78cf7b2@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hverkuil-cisco@xs4all.nl,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mchehab@kernel.org, ming.qian@nxp.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6c8f479764eb Add linux-next specific files for 20220809
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11b5b2f3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5ae8cfa8d7075d1
dashboard link: https://syzkaller.appspot.com/bug?extid=e498ebacfd2fd78cf7b2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127f650d080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1290f485080000

The issue was bisected to:

commit 39ad84e911c5c0e1593f3652325d279692817188
Author: Ming Qian <ming.qian@nxp.com>
Date:   Wed Apr 27 09:25:58 2022 +0000

    media: imx-jpeg: Don't fill the description field in struct v4l2_fmtdesc

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e8bd97080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16e8bd97080000
console output: https://syzkaller.appspot.com/x/log.txt?x=12e8bd97080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e498ebacfd2fd78cf7b2@syzkaller.appspotmail.com
Fixes: 39ad84e911c5 ("media: imx-jpeg: Don't fill the description field in struct v4l2_fmtdesc")

ntfs3: loop0: RAW NTFS volume: Filesystem size 0.00 Gb > volume size 0.00 Gb. Mount in read-only
==================================================================
BUG: KASAN: vmalloc-out-of-bounds in find_lock_entries+0xb75/0xc50 mm/filemap.c:2114
Write of size 8 at addr ffffc9000acd0160 by task syz-executor364/6015

CPU: 0 PID: 6015 Comm: syz-executor364 Not tainted 5.19.0-next-20220809-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x59/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 find_lock_entries+0xb75/0xc50 mm/filemap.c:2114
 truncate_inode_pages_range+0x185/0x1510 mm/truncate.c:364
 ntfs_evict_inode+0x16/0xa0 fs/ntfs3/inode.c:1741
 evict+0x2ed/0x6b0 fs/inode.c:665
 iput_final fs/inode.c:1748 [inline]
 iput.part.0+0x55d/0x810 fs/inode.c:1774
 iput+0x58/0x70 fs/inode.c:1764
 ntfs_fill_super+0x2309/0x37f0 fs/ntfs3/super.c:1278
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa8608bbffa
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc2b8551a8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc2b855200 RCX: 00007fa8608bbffa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffc2b8551c0
RBP: 00007ffc2b8551c0 R08: 00007ffc2b855200 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000020000e78
R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000085
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc9000acc8000, ffffc9000acd1000) created by:
 kernel_clone+0xe7/0xab0 kernel/fork.c:2675

Memory state around the buggy address:
 ffffc9000acd0000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000acd0080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc9000acd0100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                                                       ^
 ffffc9000acd0180: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000acd0200: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
