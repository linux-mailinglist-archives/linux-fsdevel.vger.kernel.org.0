Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C1579122A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 09:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345435AbjIDHaL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 03:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352436AbjIDHaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:30:10 -0400
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E830CDE
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Sep 2023 00:29:53 -0700 (PDT)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1bb29dc715bso13449015ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Sep 2023 00:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693812592; x=1694417392;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFbIYvqTnYYgKQc28cLSNWdG7PZbZN7r3uraW+UhuUE=;
        b=FVT9u5N9p//sijVqlmWxEMxD88k0I6E5+Kc3C+D+nSY7ZkRYEOsRQNkUF+96uugrMA
         qamOeYTPfEhzYR9dKfNFQXI9pQzcvJoytHJBwEBZ3DbiGQiZvpJl7sfzH78TVgeRQ+jJ
         lnHzFfJtbNOfEJMg8zzaXfgmaltrUvEY57CphqIQznoFIHLZ3Pvu1N3GRu51DIIg/hOR
         1YlDKCdfJv/3Vr1ErigbuYKbjDguKFpVW0lXrhm//rle4s4k2i98g7J4DYgGLvgDmvrz
         FeQJY83T6/2qT5lvfEce0QDcfyqnQWtC8ZPvCTIay5i0sh+DZkSxRjmtQVYdB3klYa6t
         77Fw==
X-Gm-Message-State: AOJu0YzlJkLSQ4GU8dEynKolZlEUV3LxMze2P1xm13pZZn//aHNtSzQT
        QNUTIjG85Lac2UAYh/t7/DULKvhmAZxiWoV87/oUGFywwi+A
X-Google-Smtp-Source: AGHT+IGpsze+qc1NNatHa3r/lYazlfTaMwFeemnbhbSrHVDYnRK5Y93e/3hv3+gdso5ZXDiXD8uuFVl6GosX9Mk04BeKHB7I7HCZ
MIME-Version: 1.0
X-Received: by 2002:a17:902:e808:b0:1b9:fef8:9af1 with SMTP id
 u8-20020a170902e80800b001b9fef89af1mr3416919plg.5.1693812592697; Mon, 04 Sep
 2023 00:29:52 -0700 (PDT)
Date:   Mon, 04 Sep 2023 00:29:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e76944060483798d@google.com>
Subject: [syzbot] [xfs?] [ext4?] kernel BUG in __block_write_begin_int
From:   syzbot <syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, djwong@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        song@kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        yukuai3@huawei.com, zhang_shurong@foxmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0468be89b3fa Merge tag 'iommu-updates-v6.6' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11145910680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d78b3780d210e21
dashboard link: https://syzkaller.appspot.com/bug?extid=4a08ffdf3667b36650a1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164f7a57a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143b0298680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f3914b539822/disk-0468be89.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6128b0644784/vmlinux-0468be89.xz
kernel image: https://storage.googleapis.com/syzbot-assets/349d98668c3a/bzImage-0468be89.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/75bd68910fd4/mount_0.gz

The issue was bisected to:

commit 8b0472b50bcf0f19a5119b00a53b63579c8e1e4d
Author: Zhang Shurong <zhang_shurong@foxmail.com>
Date:   Sat Jul 22 07:53:53 2023 +0000

    md: raid1: fix potential OOB in raid1_remove_disk()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e52577a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15e52577a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=11e52577a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
Fixes: 8b0472b50bcf ("md: raid1: fix potential OOB in raid1_remove_disk()")

------------[ cut here ]------------
kernel BUG at fs/buffer.c:2028!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5187 Comm: syz-executor424 Not tainted 6.5.0-syzkaller-10885-g0468be89b3fa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:iomap_to_bh fs/buffer.c:2028 [inline]
RIP: 0010:__block_write_begin_int+0x18f7/0x1a40 fs/buffer.c:2111
Code: af 0d 85 ff 48 8b 7c 24 08 48 c7 c6 20 22 18 8b e8 6e 8b c6 ff 0f 0b e8 97 0d 85 ff eb 13 e8 90 0d 85 ff eb c7 e8 89 0d 85 ff <0f> 0b e8 82 0d 85 ff 48 8b 7c 24 08 48 c7 c6 20 22 18 8b e8 41 8b
RSP: 0018:ffffc9000418f520 EFLAGS: 00010293
RAX: ffffffff82087b37 RBX: 0000000000040000 RCX: ffff888078093b80
RDX: 0000000000000000 RSI: 0000000000040000 RDI: 00000000000d0000
RBP: ffffc9000418f6b0 R08: ffffffff82086ba2 R09: 1ffff1100f27203a
R10: dffffc0000000000 R11: ffffed100f27203b R12: 00000000000d0000
R13: 0000000000000400 R14: 0000000000000000 R15: ffff8880793901d0
FS:  00007f0623ec56c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020040000 CR3: 0000000067478000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iomap_write_begin+0xaf6/0x1f00 fs/iomap/buffered-io.c:772
 iomap_write_iter fs/iomap/buffered-io.c:907 [inline]
 iomap_file_buffered_write+0x587/0x1020 fs/iomap/buffered-io.c:968
 blkdev_buffered_write block/fops.c:634 [inline]
 blkdev_write_iter+0x41d/0x5c0 block/fops.c:688
 call_write_iter include/linux/fs.h:1985 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x782/0xaf0 fs/read_write.c:584
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0623f2b6c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0623ec5218 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f0623fb9478 RCX: 00007f0623f2b6c9
RDX: 000000000208e24b RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00007f0623fb9470 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0623f7f694
R13: 00007f0623f7f1c0 R14: 0031656c69662f2e R15: 6f6f6c2f7665642f
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iomap_to_bh fs/buffer.c:2028 [inline]
RIP: 0010:__block_write_begin_int+0x18f7/0x1a40 fs/buffer.c:2111
Code: af 0d 85 ff 48 8b 7c 24 08 48 c7 c6 20 22 18 8b e8 6e 8b c6 ff 0f 0b e8 97 0d 85 ff eb 13 e8 90 0d 85 ff eb c7 e8 89 0d 85 ff <0f> 0b e8 82 0d 85 ff 48 8b 7c 24 08 48 c7 c6 20 22 18 8b e8 41 8b
RSP: 0018:ffffc9000418f520 EFLAGS: 00010293
RAX: ffffffff82087b37 RBX: 0000000000040000 RCX: ffff888078093b80
RDX: 0000000000000000 RSI: 0000000000040000 RDI: 00000000000d0000
RBP: ffffc9000418f6b0 R08: ffffffff82086ba2 R09: 1ffff1100f27203a
R10: dffffc0000000000 R11: ffffed100f27203b R12: 00000000000d0000
R13: 0000000000000400 R14: 0000000000000000 R15: ffff8880793901d0
FS:  00007f0623ec56c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0623f66850 CR3: 0000000067478000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
