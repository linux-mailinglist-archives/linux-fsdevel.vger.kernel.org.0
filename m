Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BAE73C5C5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jun 2023 03:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjFXBO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jun 2023 21:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjFXBOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jun 2023 21:14:52 -0400
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60D726BD
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 18:14:50 -0700 (PDT)
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-39ecef7a101so1064119b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jun 2023 18:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687569290; x=1690161290;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7PyQKurHCJE/uC1oMG5etBoAcnflEGjb/6C6sV4i/OA=;
        b=XR9SJioIKmoWxaWOhEsBF6/1cBQXoZApBScrw9J3M/13Q4neRfLFw92OJEp2zZX4vD
         MPgp+/1ryvbpfSgpmn+Kj6v5sAw2F1S1YqrO3mv8MexNMBOlrEpQtyl4YJbH4WA+L0V9
         olUravX0U0p655U/VUzJYXeFnbLOjytX1fm3/haetENGmTdAIY3DqX7WdTeJLM4kBJhr
         ugBuy1qVEt8S6/8tMcv5Rvg9fV7+uNUcfKBRcFjwtMNbJUHdbgo/shXXB0ernzn3MgRW
         59WVBc3/XdCOPVmKHSymlsYNEGtXf85LgodYT3ipbf9j+Naj6rwRYGmPnylP8d+jyqqi
         k4Ig==
X-Gm-Message-State: AC+VfDwaRQl66Pmx4ZSUTkfPeEiT776kwIz6pIMkhwovI0lGcYXxAEsL
        hU69Ze5nNo05gnr2CQIUBDkPQ2I758qPGtKk73SfNCrEG4/r
X-Google-Smtp-Source: ACHHUZ7V23mNNHKiZk8IiUsr2ju2MM6HnB6VLbLyv7p2C6H+uRyfPwJlAOLJhxR63bAXEVdd22CelXroF3bkA1IY/LsJvaYJRlfI
MIME-Version: 1.0
X-Received: by 2002:aca:e184:0:b0:39c:edc0:202b with SMTP id
 y126-20020acae184000000b0039cedc0202bmr3942828oig.11.1687569289997; Fri, 23
 Jun 2023 18:14:49 -0700 (PDT)
Date:   Fri, 23 Jun 2023 18:14:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010719b05fed5d82f@google.com>
Subject: [syzbot] [reiserfs?] [fat?] BUG: corrupted list in __mark_inode_dirty
From:   syzbot <syzbot+4a16683f5520de8e47c4@syzkaller.appspotmail.com>
To:     brauner@kernel.org, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    45a3e24f65e9 Linux 6.4-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12848413280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=24ce1b2abaee24cc
dashboard link: https://syzkaller.appspot.com/bug?extid=4a16683f5520de8e47c4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bd1013280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101d4adf280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/90ee4ebebbf0/disk-45a3e24f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/01569690e4bb/vmlinux-45a3e24f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/19f38d7ce866/bzImage-45a3e24f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/245a7035bcde/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4a16683f5520de8e47c4@syzkaller.appspotmail.com

list_add corruption. next->prev should be prev (ffffffff91dfe878), but was 0000060100040048. (next=ffff888070e8fc38).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:27!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 4986 Comm: udevd Not tainted 6.4.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:__list_add_valid+0xa5/0x100 lib/list_debug.c:27
Code: c7 c7 00 f8 a6 8a e8 8a df 50 fd 0f 0b 48 c7 c7 a0 f8 a6 8a e8 7c df 50 fd 0f 0b 4c 89 e1 48 c7 c7 00 f9 a6 8a e8 6b df 50 fd <0f> 0b 48 89 f1 48 c7 c7 80 f9 a6 8a 4c 89 e6 e8 57 df 50 fd 0f 0b
RSP: 0018:ffffc900033cfa20 EFLAGS: 00010286
RAX: 0000000000000075 RBX: ffff88802068ee08 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8167dd6c RDI: 0000000000000005
RBP: ffff88802068efa0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000001 R12: ffff888070e8fc38
R13: ffff88802068efa0 R14: ffff88802068efa0 R15: ffff888070e8fc38
FS:  00007fc75aad2c80(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000060100040048 CR3: 0000000028d93000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_add include/linux/list.h:69 [inline]
 list_add include/linux/list.h:88 [inline]
 list_move include/linux/list.h:218 [inline]
 inode_io_list_move_locked+0x1fa/0x3f0 fs/fs-writeback.c:126
 __mark_inode_dirty+0x522/0xd60 fs/fs-writeback.c:2505
 generic_update_time fs/inode.c:1859 [inline]
 inode_update_time fs/inode.c:1872 [inline]
 touch_atime+0x687/0x740 fs/inode.c:1944
 file_accessed include/linux/fs.h:2198 [inline]
 filemap_read+0xa5a/0xc70 mm/filemap.c:2765
 blkdev_read_iter+0x3eb/0x760 block/fops.c:606
 call_read_iter include/linux/fs.h:1862 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x4b1/0x8a0 fs/read_write.c:470
 ksys_read+0x12b/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc75a716b6a
Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffdb3cd93f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00000000003f0000 RCX: 00007fc75a716b6a
RDX: 0000000000000040 RSI: 000055c536a3f038 RDI: 0000000000000009
RBP: 0000000000000040 R08: 000055c536a3f010 R09: 0000000000002000
R10: 0000000000000015 R11: 0000000000000246 R12: 000055c536a3f010
R13: 000055c536a3f028 R14: 000055c536a58bc8 R15: 000055c536a58b70
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid+0xa5/0x100 lib/list_debug.c:27
Code: c7 c7 00 f8 a6 8a e8 8a df 50 fd 0f 0b 48 c7 c7 a0 f8 a6 8a e8 7c df 50 fd 0f 0b 4c 89 e1 48 c7 c7 00 f9 a6 8a e8 6b df 50 fd <0f> 0b 48 89 f1 48 c7 c7 80 f9 a6 8a 4c 89 e6 e8 57 df 50 fd 0f 0b
RSP: 0018:ffffc900033cfa20 EFLAGS: 00010286

RAX: 0000000000000075 RBX: ffff88802068ee08 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8167dd6c RDI: 0000000000000005
RBP: ffff88802068efa0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000001 R12: ffff888070e8fc38
R13: ffff88802068efa0 R14: ffff88802068efa0 R15: ffff888070e8fc38
FS:  00007fc75aad2c80(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000060100040048 CR3: 0000000028d93000 CR4: 00000000003506e0
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
