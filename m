Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A196E593463
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 20:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiHOSBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 14:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiHOSAb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:00:31 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445D712AFC
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 11:00:30 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id v14-20020a6b5b0e000000b0067bc967a6c0so4516373ioh.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 11:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=snFhIh1XuImBPLpzgsrjx1ELv6/VHIRbucT3VBO0hl0=;
        b=5WI/lx2gBu2MWaSSv11beEWaBqA7q+A/Rs8lDyNvAt+AY0vF8GLCZO5ad5uMWCmpGz
         t74wbdTLf0md8JZxrUEbqqfgbLk5jbUtYwZiUHoxZTvjpDsAC8clXLRrhq6SPlpQQRaw
         oRjOeTsqhSonCCjVgwfrDWSd7oH2PCHIF+qwHiUNwbT2xUq2w9VkqWwT0v57uWls2YsS
         CHivkYB++cIMdmUuHuta0QQE6B2B8cpyXvXzuQfCxayANZ/wqqDKOxs/5NffuJbT/+9C
         CXzdWfsovGiSSjSmXvJRghXiP1qwhp0+K3hMuR46P15ZUqIsqnJMiD9zwLHFyra6GBCO
         4pUg==
X-Gm-Message-State: ACgBeo1TbT0D/698r105B1fKC8L4ISDE2zhAvNWUc62BObvgMnb+79cM
        X9n/rJZHBluvqLYpXaNUSnLpq7HwEMSbbNTO4E5N6liN1sug
X-Google-Smtp-Source: AA6agR4R2JwIm/NL34OWa9aoDYy0/p2AwKRBUSytfOgTko3mJzzMHUZyhcNtFYWoQwE1jpH5VehLpoGy7rTxYfcg4GUsXU+bQubK
MIME-Version: 1.0
X-Received: by 2002:a05:6602:25d7:b0:67c:9c30:49e0 with SMTP id
 d23-20020a05660225d700b0067c9c3049e0mr6641692iop.25.1660586429603; Mon, 15
 Aug 2022 11:00:29 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:00:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041678b05e64b68c6@google.com>
Subject: [syzbot] upstream boot error: BUG: corrupted list in new_inode
From:   syzbot <syzbot+24df94a8d05d5a3e68f0@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5d6a0f4da927 Merge tag 'for-linus-6.0-rc1b-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1399b2f3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6bcb425ba129b87
dashboard link: https://syzkaller.appspot.com/bug?extid=24df94a8d05d5a3e68f0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+24df94a8d05d5a3e68f0@syzkaller.appspotmail.com

list_add corruption. next->prev should be prev (ffff8881401c0a00), but was ffff000000000000. (next=ffff88801fb50308).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:27!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 24 Comm: kdevtmpfs Not tainted 5.19.0-syzkaller-14374-g5d6a0f4da927 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__list_add_valid.cold+0xf/0x58 lib/list_debug.c:27
Code: 48 c7 c6 00 ec 48 8a 48 89 ef 49 c7 c7 ea ff ff ff e8 5b 63 05 00 e9 c2 7d b6 fa 4c 89 e1 48 c7 c7 a0 f2 48 8a e8 95 f2 f0 ff <0f> 0b 48 c7 c7 40 f2 48 8a e8 87 f2 f0 ff 0f 0b 48 c7 c7 a0 f1 48
RSP: 0018:ffffc900001efc10 EFLAGS: 00010286
RAX: 0000000000000075 RBX: ffff8881401c0000 RCX: 0000000000000000
RDX: ffff888012620000 RSI: ffffffff8161f148 RDI: fffff5200003df74
RBP: ffff88801db8b588 R08: 0000000000000075 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000000 R12: ffff88801fb50308
R13: ffff88801fb50308 R14: ffff8881401c0000 R15: ffff88801db8b588
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000bc8e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __list_add include/linux/list.h:69 [inline]
 list_add include/linux/list.h:88 [inline]
 inode_sb_list_add fs/inode.c:495 [inline]
 new_inode+0x114/0x270 fs/inode.c:1049
 shmem_get_inode+0x19b/0xe00 mm/shmem.c:2306
 shmem_mknod+0x5a/0x1f0 mm/shmem.c:2873
 vfs_mknod+0x4d2/0x7e0 fs/namei.c:3892
 handle_create+0x340/0x4b3 drivers/base/devtmpfs.c:226
 handle drivers/base/devtmpfs.c:391 [inline]
 devtmpfs_work_loop drivers/base/devtmpfs.c:406 [inline]
 devtmpfsd+0x1a4/0x2a3 drivers/base/devtmpfs.c:448
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid.cold+0xf/0x58 lib/list_debug.c:27
Code: 48 c7 c6 00 ec 48 8a 48 89 ef 49 c7 c7 ea ff ff ff e8 5b 63 05 00 e9 c2 7d b6 fa 4c 89 e1 48 c7 c7 a0 f2 48 8a e8 95 f2 f0 ff <0f> 0b 48 c7 c7 40 f2 48 8a e8 87 f2 f0 ff 0f 0b 48 c7 c7 a0 f1 48
RSP: 0018:ffffc900001efc10 EFLAGS: 00010286
RAX: 0000000000000075 RBX: ffff8881401c0000 RCX: 0000000000000000
RDX: ffff888012620000 RSI: ffffffff8161f148 RDI: fffff5200003df74
RBP: ffff88801db8b588 R08: 0000000000000075 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000000 R12: ffff88801fb50308
R13: ffff88801fb50308 R14: ffff8881401c0000 R15: ffff88801db8b588
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000bc8e000 CR4: 0000000000350ef0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
