Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDF1642226
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Dec 2022 05:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiLEEBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Dec 2022 23:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiLEEBr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Dec 2022 23:01:47 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19686FD29
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Dec 2022 20:01:45 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id j20-20020a056e02219400b00300a22a7fe0so11233327ila.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Dec 2022 20:01:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJhuugiufUiVSBE8bfTAcxgO0Dy3ttVVyszsfrNlcdM=;
        b=0UDe1A1iAhayy94gUTsXXCrTGPM42hmMKEyehlNtcA1SArqq3an8N2vhsfdy85G5BG
         hLIMGCtFoMYXxevJOc453NT6tknq6h9iHLp1qAShzLsNaiZc5nbbJZugyx2YxPYiqiTm
         U6gQOjzaM3qoaG063DYtFuUFYLdwNX55kc7BbKBiiRB/wHmnuy9pmaGx1gwsqeuWPurc
         HJQi2ZLXJKnrlrqYxbNs5CIL2w5JbVoOvXwvm01Kq6/zK8zWJxqabdo0jOtZxfIm3poP
         OjXnT4abkIC4+NxzwmFVBler/xJ5Gpe2OLTfjFO8+Nlrwy9XYLAJCyNe4Vuw9MoJ+cJF
         hvRg==
X-Gm-Message-State: ANoB5pn5EulA3ItuUYWNf6xVj0huQOfDpX0u/Fsc1UTg7GU3u2bddyph
        9PxKFYzbXPiN1WW2X5kwqLtHBZpxHKzmF3l/RIxxH5zsXntV
X-Google-Smtp-Source: AA0mqf6MTnIM7goxYepJ13+JlmclDcWXRC5IyI2s1gcPioS6KJL819454V0FyJLuy9wNJ4hhWYY8x4WpzBQCGFIP/fXa+gzJ1Qks
MIME-Version: 1.0
X-Received: by 2002:a02:c492:0:b0:375:c128:72a6 with SMTP id
 t18-20020a02c492000000b00375c12872a6mr38261968jam.151.1670212904457; Sun, 04
 Dec 2022 20:01:44 -0800 (PST)
Date:   Sun, 04 Dec 2022 20:01:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de9b9d05ef0cbe7c@google.com>
Subject: [syzbot] kernel BUG in hfs_bnode_put
From:   syzbot <syzbot+5b04b49a7ec7226c7426@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, fmdefrancesco@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        slava@dubeyko.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    97ee9d1c1696 Merge tag 'block-6.1-2022-12-02' of git://git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1669637b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=5b04b49a7ec7226c7426
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109e8647880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ecd229880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6a6a9ff34dfa/disk-97ee9d1c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a01a4182c2b/vmlinux-97ee9d1c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4371158e8c25/bzImage-97ee9d1c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1fa884667612/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b04b49a7ec7226c7426@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/hfs/bnode.c:466!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3634 Comm: kworker/u4:5 Not tainted 6.1.0-rc7-syzkaller-00190-g97ee9d1c1696 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: writeback wb_workfn (flush-7:0)
RIP: 0010:hfs_bnode_put+0x46f/0x480 fs/hfs/bnode.c:466
Code: 8a 80 ff e9 73 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c a0 fe ff ff 48 89 df e8 db 8a 80 ff e9 93 fe ff ff e8 a1 68 2c ff <0f> 0b e8 9a 68 2c ff 0f 0b 0f 1f 84 00 00 00 00 00 55 41 57 41 56
RSP: 0018:ffffc90003b4f258 EFLAGS: 00010293
RAX: ffffffff825e318f RBX: 0000000000000000 RCX: ffff8880739dd7c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003b4f430 R08: ffffffff825e2d9b R09: ffffed10045157d1
R10: ffffed10045157d1 R11: 1ffff110045157d0 R12: ffff8880228abe80
R13: ffff88807016c000 R14: dffffc0000000000 R15: ffff8880228abe00
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa6ebe88718 CR3: 000000001e93d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hfs_write_inode+0x1bc/0xb40
 write_inode fs/fs-writeback.c:1440 [inline]
 __writeback_single_inode+0x4d6/0x670 fs/fs-writeback.c:1652
 writeback_sb_inodes+0xb3b/0x18f0 fs/fs-writeback.c:1878
 __writeback_inodes_wb+0x125/0x420 fs/fs-writeback.c:1949
 wb_writeback+0x440/0x7b0 fs/fs-writeback.c:2054
 wb_check_start_all fs/fs-writeback.c:2176 [inline]
 wb_do_writeback fs/fs-writeback.c:2202 [inline]
 wb_workfn+0x827/0xef0 fs/fs-writeback.c:2235
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfs_bnode_put+0x46f/0x480 fs/hfs/bnode.c:466
Code: 8a 80 ff e9 73 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c a0 fe ff ff 48 89 df e8 db 8a 80 ff e9 93 fe ff ff e8 a1 68 2c ff <0f> 0b e8 9a 68 2c ff 0f 0b 0f 1f 84 00 00 00 00 00 55 41 57 41 56
RSP: 0018:ffffc90003b4f258 EFLAGS: 00010293
RAX: ffffffff825e318f RBX: 0000000000000000 RCX: ffff8880739dd7c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003b4f430 R08: ffffffff825e2d9b R09: ffffed10045157d1
R10: ffffed10045157d1 R11: 1ffff110045157d0 R12: ffff8880228abe80
R13: ffff88807016c000 R14: dffffc0000000000 R15: ffff8880228abe00
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa6ebe88718 CR3: 000000001e93d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
