Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BDA768A5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 05:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjGaDfC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jul 2023 23:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGaDfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:35:01 -0400
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F02E6F
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 20:34:58 -0700 (PDT)
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-3a5ad6088f8so7315616b6e.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 20:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690774497; x=1691379297;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eNn46kxg48m+Q5oWGr+r8mpJ1OOx1r1wF8Gt6l4ZDzw=;
        b=PHrXjLw7bij+GYF6RYKDJkILQ6QyaPikGTcMnT63ow7lxeabmznxXQmR9fE1ukhZu1
         Sieigug6u61Sv/SIKvAE97WU7TpRDPwnPLYL+x/A1ZuDamQA56WoRQaMthOIbood0Ja9
         8zAL+aZDu2MmcklLjAaz4UMg8SHHZrxDR+RUEoyDKRtIfkaTzze0+eivwjSDX8xfUuXD
         KAvzb3nhtAV+uj2VawWpAPUaasV28MRcYWOQqiU8uLt/Ubh1E0vb2GLC760ZRNSJ0lgm
         Q05TRFuFOI/jV5UMe39rjWFSyC342D61LJT3q4/HjWPFpiJn2BtWWIfnz3TGM2eoApae
         j6Hw==
X-Gm-Message-State: ABy/qLawXQRtm0dzuZVIs/TDxIn+qO20/p8GbQA6f2fuVrDmd1bahel1
        8MxgO9OZmkJXPHjYK0vupcAALXSq4wsmx5Ju4pRj+dF/Qbq5
X-Google-Smtp-Source: APBJJlEZebHKiiADqjSYSifoPxsJOxzd9K6nGEmHSsFY8PSZQvn/2D2VpKn+ESfRoYFYgPIMFC4LcL0doQYHFZBfAR+leFnYYTEG
MIME-Version: 1.0
X-Received: by 2002:a05:6808:158c:b0:3a4:1f25:7508 with SMTP id
 t12-20020a056808158c00b003a41f257508mr17127033oiw.0.1690774497775; Sun, 30
 Jul 2023 20:34:57 -0700 (PDT)
Date:   Sun, 30 Jul 2023 20:34:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055d5e90601c01dee@google.com>
Subject: [syzbot] [ext4?] WARNING: locking bug in ext4_xattr_inode_update_ref (2)
From:   syzbot <syzbot+6699abaff302165de416@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
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

HEAD commit:    0ba5d0720577 Add linux-next specific files for 20230726
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1747a881a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f33fb77ef67a25e1
dashboard link: https://syzkaller.appspot.com/bug?extid=6699abaff302165de416
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1217c65ea80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2fa09c6312ae/disk-0ba5d072.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7361000a4380/vmlinux-0ba5d072.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48a015458a58/bzImage-0ba5d072.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/405ee39c557d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6699abaff302165de416@syzkaller.appspotmail.com

------------[ cut here ]------------
Looking for class "&ea_inode->i_rwsem" with key ext4_fs_type, but found a different class "&sb->s_type->i_mutex_key" with the same key
WARNING: CPU: 0 PID: 5364 at kernel/locking/lockdep.c:940 look_up_lock_class+0xad/0x120 kernel/locking/lockdep.c:940
Modules linked in:
CPU: 0 PID: 5364 Comm: syz-executor.3 Not tainted 6.5.0-rc3-next-20230726-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:look_up_lock_class+0xad/0x120 kernel/locking/lockdep.c:940
Code: 59 49 8b 14 24 48 81 fa a0 d9 49 90 74 4c 80 3d 43 17 60 04 00 75 43 48 c7 c7 00 82 6c 8a c6 05 33 17 60 04 01 e8 03 f2 16 f7 <0f> 0b eb 2c 89 74 24 04 e8 36 ae e7 f9 8b 74 24 04 48 c7 c7 40 81
RSP: 0018:ffffc90004a4f008 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffffffff918a53c0 RCX: 0000000000000000
RDX: ffff88802a8ebb80 RSI: ffffffff814d5b56 RDI: 0000000000000001
RBP: ffffffff8cc46c78 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888066815e00
R13: ffff888066815e00 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f046301d6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002000 CR3: 000000002a7c9000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_lock_class+0xbd/0x1320 kernel/locking/lockdep.c:1292
 __lock_acquire+0x13c/0x5de0 kernel/locking/lockdep.c:5021
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5726
 down_write+0x93/0x200 kernel/locking/rwsem.c:1573
 inode_lock include/linux/fs.h:771 [inline]
 ext4_xattr_inode_update_ref+0xa6/0x5c0 fs/ext4/xattr.c:1042
 ext4_xattr_inode_inc_ref fs/ext4/xattr.c:1088 [inline]
 ext4_xattr_inode_inc_ref_all fs/ext4/xattr.c:1115 [inline]
 ext4_xattr_block_set+0x2305/0x30e0 fs/ext4/xattr.c:2159
 ext4_xattr_set_handle+0xd6e/0x1420 fs/ext4/xattr.c:2456
 ext4_xattr_set+0x149/0x370 fs/ext4/xattr.c:2558
 __vfs_setxattr+0x173/0x1d0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x127/0x5e0 fs/xattr.c:235
 __vfs_setxattr_locked+0x17e/0x250 fs/xattr.c:296
 vfs_setxattr+0x146/0x350 fs/xattr.c:322
 do_setxattr+0x142/0x170 fs/xattr.c:630
 setxattr+0x159/0x170 fs/xattr.c:653
 path_setxattr+0x1a3/0x1d0 fs/xattr.c:672
 __do_sys_setxattr fs/xattr.c:688 [inline]
 __se_sys_setxattr fs/xattr.c:684 [inline]
 __x64_sys_setxattr+0xc4/0x160 fs/xattr.c:684
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f046c07cb29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f046301d0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007f046c19c050 RCX: 00007f046c07cb29
RDX: 00000000200005c0 RSI: 0000000020000180 RDI: 00000000200000c0
RBP: 00007f046c0c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000002000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f046c19c050 R15: 00007ffd0e4f6698
 </TASK>


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
