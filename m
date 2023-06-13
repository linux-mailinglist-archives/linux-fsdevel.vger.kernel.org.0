Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515AA72D989
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 07:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbjFMFv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 01:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjFMFvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:51:55 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549FAE7C
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 22:51:53 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-77afe663503so256828039f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 22:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686635512; x=1689227512;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iIIvNRHGInh0V1rLHDMRkP46gOzXSc4Fwlexp1Z4DFU=;
        b=FpzBI4ef23r4BnKwXSbhWYjKVfbA2cQ5lu0vJzkGAi75+Jz9jgFw9hj4UwUcuw2bep
         496PWpiO7549pyrBAGknJ+ZhEOZdKAEdrKp51RdufNNppyNK2Fc1+z23fhfTmB1gqAFx
         QkPewN1EP6KpckFJ0e8z8j0CB7kuBL9xcUB9aSTTBZmMgbVEFO9LBazH5Yd1I8DD5Kkt
         mRdGwhx6X6uj4kd1t0wr8EBU+uw/Dv+bs7AVUE6iIYMqrwsqn+EiQzASoHDP3ZVa7uWF
         Z+VNnFoCS/zaBjr1vbw2vrdQSTDy7BuqlQTq02l4K1mIDyKPzrjmjYnI+viN//bJ6wox
         +Gqg==
X-Gm-Message-State: AC+VfDzY/MxFoZsNg0dmtE9U948c5S1OLCQCoRsOtm0WpZtWAB6yJRLC
        VqV9igCzBGs0bzVGEzp0FBd4Nd9r1iWtxMZISI8qdiNuSIRm
X-Google-Smtp-Source: ACHHUZ4EwqR7Pqd0bWpBxeaYIjc4YZgoNYIKqJUvtF11Er3AjklexZoxYa7Bdh/RTE0mK+VvZCK7W0tDnVHaH0W+eLkH/7hafw8A
MIME-Version: 1.0
X-Received: by 2002:a92:d250:0:b0:33f:d125:799c with SMTP id
 v16-20020a92d250000000b0033fd125799cmr3736240ilg.6.1686635512692; Mon, 12 Jun
 2023 22:51:52 -0700 (PDT)
Date:   Mon, 12 Jun 2023 22:51:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099887f05fdfc6e10@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_split_extent_at (2)
From:   syzbot <syzbot+0f4d9f68fb6632330c6c@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    25041a4c02c7 Merge tag 'net-6.4-rc6' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12801759280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=0f4d9f68fb6632330c6c
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b3bc8d280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/164bca6d1fd9/disk-25041a4c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7522d0748e33/vmlinux-25041a4c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b32318c9ea13/bzImage-25041a4c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4bcaa768d65c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0f4d9f68fb6632330c6c@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/ext4_extents.h:200!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5141 Comm: syz-executor.2 Not tainted 6.4.0-rc5-syzkaller-00133-g25041a4c02c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:ext4_ext_mark_unwritten fs/ext4/ext4_extents.h:200 [inline]
RIP: 0010:ext4_split_extent_at+0x10f0/0x1100 fs/ext4/extents.c:3221
Code: 4e ac ff 48 8b 54 24 70 48 8b 74 24 60 e9 3b fa ff ff e8 13 77 54 ff 0f 0b e8 0c 77 54 ff 0f 0b e8 c5 85 78 08 e8 00 77 54 ff <0f> 0b e8 f9 76 54 ff 0f 0b e8 f2 76 54 ff 0f 0b 55 41 57 41 56 41
RSP: 0018:ffffc9000432eec0 EFLAGS: 00010293

RAX: ffffffff82370830 RBX: 0000000000000000 RCX: ffff88807d9a9dc0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000432f028 R08: ffffffff8236fc0c R09: ffffed100eff1db4
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
R13: ffff88801e655d00 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f6fc7dd5700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002003f000 CR3: 000000007416c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_split_extent+0x370/0x4e0 fs/ext4/extents.c:3384
 ext4_split_convert_extents fs/ext4/extents.c:3713 [inline]
 ext4_ext_handle_unwritten_extents fs/ext4/extents.c:3875 [inline]
 ext4_ext_map_blocks+0x22c9/0x7210 fs/ext4/extents.c:4167
 ext4_map_blocks+0xa4c/0x1cf0 fs/ext4/inode.c:623
 ext4_iomap_alloc fs/ext4/inode.c:3298 [inline]
 ext4_iomap_begin+0x8e4/0xd30 fs/ext4/inode.c:3348
 iomap_iter+0x677/0xec0 fs/iomap/iter.c:91
 __iomap_dio_rw+0xe1b/0x22e0 fs/iomap/direct-io.c:597
 iomap_dio_rw+0x46/0xa0 fs/iomap/direct-io.c:688
 ext4_dio_write_iter fs/ext4/file.c:597 [inline]
 ext4_file_write_iter+0x1509/0x1930 fs/ext4/file.c:708
 call_write_iter include/linux/fs.h:1868 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x790/0xb20 fs/read_write.c:584
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6fc708c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6fc7dd5168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f6fc71ac050 RCX: 00007f6fc708c169
RDX: 0000000000000012 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007f6fc70e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcf37a297f R14: 00007f6fc7dd5300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_ext_mark_unwritten fs/ext4/ext4_extents.h:200 [inline]
RIP: 0010:ext4_split_extent_at+0x10f0/0x1100 fs/ext4/extents.c:3221
Code: 4e ac ff 48 8b 54 24 70 48 8b 74 24 60 e9 3b fa ff ff e8 13 77 54 ff 0f 0b e8 0c 77 54 ff 0f 0b e8 c5 85 78 08 e8 00 77 54 ff <0f> 0b e8 f9 76 54 ff 0f 0b e8 f2 76 54 ff 0f 0b 55 41 57 41 56 41
RSP: 0018:ffffc9000432eec0 EFLAGS: 00010293
RAX: ffffffff82370830 RBX: 0000000000000000 RCX: ffff88807d9a9dc0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000432f028 R08: ffffffff8236fc0c R09: ffffed100eff1db4
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000000
R13: ffff88801e655d00 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f6fc7dd5700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb7c1906000 CR3: 000000007416c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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
