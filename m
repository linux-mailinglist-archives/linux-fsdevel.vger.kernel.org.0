Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B254656725
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Dec 2022 04:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiL0Dmj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 22:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiL0Dmh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 22:42:37 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69326178
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Dec 2022 19:42:35 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id e9-20020a056e020b2900b003036757d5caso8051243ilu.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Dec 2022 19:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HT6NQ6ZRebuvpIly3+Uy5dHIc3hJIKXVu5Ccu6rq1p0=;
        b=dVbSBDiq2RkwQuFa/+Ul6EeJBlVgUEEtPei+HmQz5qt926jX75fML32hxkokdpzKXQ
         8bjTyRkaxbUzt3GmFRzOsKnKVSl/RM7T2OiXmkOMXd9wcdInj61r1bGktL3K/xHfd4A9
         B4Sp/8Nlii3ifT+kmu2zdqjGhpC02GB1eH9kERvyty4+vvL9aBP084vO4JBTzu99L+rg
         Iprm9cfrwz64qZkjkxFZ22/5GdfryFu1wSctjreyfvLdXkrihzZQ+GJ1SU2nPr1iBsQU
         sfaHEJ+2/9SpY4nP4xF0ovUkEnlpQuNXVbY6OAyiN+Vv9UOglErVHqGo20VBuAaexwLd
         Rm9g==
X-Gm-Message-State: AFqh2kqp2MGfCfrwZY//7Dcd4mJ+3SX2KiQRzuNNL3WYoJlXlVJathnW
        nB6NwVvGz/VVTQ06OvIWcVrE4uG+KzHaM5+JlTaea0nIJ62x
X-Google-Smtp-Source: AMrXdXvEBUw/+j92DS13gGV1YYD8pfVnt1DDN1C+6fGvxMOtNoH67qiCOWXbqOO6jJk3Q4Xggs0aQqVHRKyEDMp0Ip8nP86GqhOt
MIME-Version: 1.0
X-Received: by 2002:a92:7a03:0:b0:303:395:7359 with SMTP id
 v3-20020a927a03000000b0030303957359mr1670658ilc.253.1672112554932; Mon, 26
 Dec 2022 19:42:34 -0800 (PST)
Date:   Mon, 26 Dec 2022 19:42:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc83d605f0c70a11@google.com>
Subject: [syzbot] [nilfs2?] kernel BUG in folio_end_writeback
From:   syzbot <syzbot+7e5cf1d80677ec185e63@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, konishi.ryusuke@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    0a924817d2ed Merge tag '6.2-rc-smb3-client-fixes-part2' of..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16228274480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e2d7bfa2d6d5a76
dashboard link: https://syzkaller.appspot.com/bug?extid=7e5cf1d80677ec185e63
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14494888480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c189f8480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b0959a409a79/disk-0a924817.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/388daa76797b/vmlinux-0a924817.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b9d2d406c075/bzImage-0a924817.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/166e13821ab4/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7e5cf1d80677ec185e63@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/filemap.c:1615!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.1.0-syzkaller-14321-g0a924817d2ed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:folio_end_writeback+0x34d/0x530 mm/filemap.c:1615
Code: 84 87 00 00 00 e8 13 5a d2 ff e9 36 fd ff ff e8 09 5a d2 ff 4c 89 f7 48 c7 c6 20 84 f8 8a e8 ca 3a 10 00 0f 0b e8 f3 59 d2 ff <0f> 0b e8 ec 59 d2 ff 4c 89 f7 48 c7 c6 60 86 f8 8a e8 ad 3a 10 00
RSP: 0018:ffffc90000147b88 EFLAGS: 00010246
RAX: ffffffff81b9813d RBX: 0000000000000082 RCX: ffff88813fefba80
RDX: 0000000080000100 RSI: ffffffff8aedcc60 RDI: ffffffff8b4bbfe0
RBP: 1ffffd40000ed426 R08: dffffc0000000000 R09: fffffbfff1d2cabe
R10: fffffbfff1d2cabe R11: 1ffffffff1d2cabd R12: ffffea000076a134
R13: dffffc0000000000 R14: ffffea000076a100 R15: 1ffffd40000ed420
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff727105718 CR3: 00000000291ab000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 end_bio_bh_io_sync+0xb1/0x110 fs/buffer.c:2655
 req_bio_endio block/blk-mq.c:794 [inline]
 blk_update_request+0x51c/0x1040 block/blk-mq.c:926
 blk_mq_end_request+0x39/0x70 block/blk-mq.c:1053
 blk_complete_reqs block/blk-mq.c:1131 [inline]
 blk_done_softirq+0x119/0x160 block/blk-mq.c:1136
 __do_softirq+0x277/0x738 kernel/softirq.c:571
 run_ksoftirqd+0xa2/0x100 kernel/softirq.c:934
 smpboot_thread_fn+0x533/0xa10 kernel/smpboot.c:164
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_end_writeback+0x34d/0x530 mm/filemap.c:1615
Code: 84 87 00 00 00 e8 13 5a d2 ff e9 36 fd ff ff e8 09 5a d2 ff 4c 89 f7 48 c7 c6 20 84 f8 8a e8 ca 3a 10 00 0f 0b e8 f3 59 d2 ff <0f> 0b e8 ec 59 d2 ff 4c 89 f7 48 c7 c6 60 86 f8 8a e8 ad 3a 10 00
RSP: 0018:ffffc90000147b88 EFLAGS: 00010246
RAX: ffffffff81b9813d RBX: 0000000000000082 RCX: ffff88813fefba80
RDX: 0000000080000100 RSI: ffffffff8aedcc60 RDI: ffffffff8b4bbfe0
RBP: 1ffffd40000ed426 R08: dffffc0000000000 R09: fffffbfff1d2cabe
R10: fffffbfff1d2cabe R11: 1ffffffff1d2cabd R12: ffffea000076a134
R13: dffffc0000000000 R14: ffffea000076a100 R15: 1ffffd40000ed420
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff727105718 CR3: 00000000291ab000 CR4: 00000000003506f0
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
