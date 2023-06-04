Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A48C7213E8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jun 2023 02:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjFDAgA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jun 2023 20:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFDAf6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jun 2023 20:35:58 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BE51A7
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Jun 2023 17:35:56 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-33b7a468d14so28307995ab.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Jun 2023 17:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685838955; x=1688430955;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1+Fa1Sb0xRcOOP/IGgofEUyl/eChZL4ZfhofxtA5tw8=;
        b=Gt4S21rrb+QFEg3QWo8NfO4hpiDetWj/478TQqaMdGIi986tjPLCAcYm8nqMyjVbZA
         VlvlwRJ+xIek2+SepUvkjF8jrcZ9ZV3kH6qUVtu6xaG3CIalShwyubXAXiekJ/Oo51S+
         26rdmuQRnyyCCP3o7AasKDHuAlJlzuqRPO09l9FeQ9txDFdQY8xPHKhYMyXWFEwdFJrc
         iERuJUHUzfR8X9mRud/cu/2gYPKBGqFqOE2DzurE5kOjJSmI2+7weK8v8LbDt1u6BvBF
         rMnYfxCW65tDRALGdJre6PqXEXbTNVXoRQy+7u+AzJLISV4fyRDXTwngOkUtAfzgH9D4
         Nx7g==
X-Gm-Message-State: AC+VfDwcAmmAi6JFWGe/9uT8e3nbE0VYVkZv7RHpQX8URYAQObk/7aBJ
        2jEpuzmdJo5sEgZ1GfYZxTWoGuWxyZpvwWjqt675/svqKGjZ
X-Google-Smtp-Source: ACHHUZ78vzo3Rjc2DmT9M5pPpJ7gIXkQ9GfaWQgicZ9pV2vu8oZhESAYQC3ATZIBM5OZietck5Y0Xx5Vjq3qaQ32aYKeQX9aqA8y
MIME-Version: 1.0
X-Received: by 2002:a92:d405:0:b0:331:ac80:cca0 with SMTP id
 q5-20020a92d405000000b00331ac80cca0mr5642267ilm.6.1685838955651; Sat, 03 Jun
 2023 17:35:55 -0700 (PDT)
Date:   Sat, 03 Jun 2023 17:35:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019a97c05fd42f8c8@google.com>
Subject: [syzbot] [nilfs?] kernel BUG in end_buffer_async_write
From:   syzbot <syzbot+5c04210f7c7f897c1e7f@syzkaller.appspotmail.com>
To:     brauner@kernel.org, konishi.ryusuke@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    51f269a6ecc7 Merge tag 'probes-fixes-6.4-rc4' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ed0e7d280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3da6c5d3e0a6c932
dashboard link: https://syzkaller.appspot.com/bug?extid=5c04210f7c7f897c1e7f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1336c6b5280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c0a5a5280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8a8c8e41a6b0/disk-51f269a6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ffc3737b4233/vmlinux-51f269a6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d49888e5beb1/bzImage-51f269a6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/99d35f050c12/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c04210f7c7f897c1e7f@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/buffer.c:391!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.4.0-rc4-syzkaller-00268-g51f269a6ecc7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:end_buffer_async_write+0x2db/0x340 fs/buffer.c:391
Code: 65 00 fe 4c 89 ff e8 d4 a3 ff ff be 08 00 00 00 48 89 c7 48 89 c3 e8 b4 31 e0 ff f0 80 4b 01 01 e9 07 fe ff ff e8 45 62 8d ff <0f> 0b e8 3e 62 8d ff 0f 0b 48 89 df e8 34 2b e0 ff e9 d9 fe ff ff
RSP: 0018:ffffc90000147c98 EFLAGS: 00010246

RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000100
RDX: ffff88801664bb80 RSI: ffffffff81f6e3fb RDI: 0000000000000001
RBP: ffff88806fbde570 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffffffff81f6e120 R14: ffff88801e24ee00 R15: ffff88802a45a788
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f42b45b0000 CR3: 000000007b04a000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 end_bio_bh_io_sync+0xde/0x130 fs/buffer.c:2730
 bio_endio+0x5af/0x6c0 block/bio.c:1608
 req_bio_endio block/blk-mq.c:761 [inline]
 blk_update_request+0x5c5/0x1620 block/blk-mq.c:906
 blk_mq_end_request+0x59/0x4c0 block/blk-mq.c:1023
 lo_complete_rq+0x1c6/0x280 drivers/block/loop.c:370
 blk_complete_reqs+0xad/0xe0 block/blk-mq.c:1101
 __do_softirq+0x1d4/0x905 kernel/softirq.c:571
 run_ksoftirqd kernel/softirq.c:939 [inline]
 run_ksoftirqd+0x31/0x60 kernel/softirq.c:931
 smpboot_thread_fn+0x659/0x9e0 kernel/smpboot.c:164
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:end_buffer_async_write+0x2db/0x340 fs/buffer.c:391
Code: 65 00 fe 4c 89 ff e8 d4 a3 ff ff be 08 00 00 00 48 89 c7 48 89 c3 e8 b4 31 e0 ff f0 80 4b 01 01 e9 07 fe ff ff e8 45 62 8d ff <0f> 0b e8 3e 62 8d ff 0f 0b 48 89 df e8 34 2b e0 ff e9 d9 fe ff ff
RSP: 0018:ffffc90000147c98 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000100
RDX: ffff88801664bb80 RSI: ffffffff81f6e3fb RDI: 0000000000000001
RBP: ffff88806fbde570 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffffffff81f6e120 R14: ffff88801e24ee00 R15: ffff88802a45a788
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f42b45b0000 CR3: 000000007b04a000 CR4: 0000000000350ef0


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
