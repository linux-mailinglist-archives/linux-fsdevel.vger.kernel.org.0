Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3452C75A5EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 07:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjGTF5B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 01:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGTF5A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:57:00 -0400
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F431726
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 22:56:59 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3a3df1d46e5so803945b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 22:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689832619; x=1690437419;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+rxMduQ95oYDVUMxmZJ5uvrCoIqem721VwhSpjD4Vo=;
        b=D4JGyzZx/c3pxRu7SJz/bGwQCN9LpwHLJhhr9bIs8NMKSlYCbsgCWrS8YQn5cp+xXe
         QufnRoHXpURRLK2tiBanwdpL4O0Ne5zhQ14s52edbxP8Pw/cv+00/x7zk5KCENb4oapZ
         PMs29UgQfBlKh6lBiaOLHsl38oyDFNO9mV3T9TyNGxIjymtTZHGqLd/x/fW0oB6PALnl
         ofhK+1BoaHPruqmKp6/jfp/6utt5eoLwM9+8ZVQ0fE4laogq43Fiq/QuSt2vdAU22Ayr
         3vMVUUbARM+vMwrSde7DyhU8MjvDonaWPQ5Sbhnur72IOLPlOsqyU5cfOlHU0bC6Iirn
         TqHg==
X-Gm-Message-State: ABy/qLYWMz0302+6lVEIlcDkzZOZ/X6MV5Alo2ZPLyY+ocUHKR0XS4Y6
        U/7LzwB+ExK4Oxrnz74Li9tzFW9x3OnnXKaGG9AYIpIa/tQ/
X-Google-Smtp-Source: APBJJlGeL4MGARAFxfmvcasWtUWLz/bh24gbE4GHdzC3qvhaohlci0IifcDP87jin2emHRKmgFzlCS9BkqGUxyCYTfi+YcnpcDwr
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2189:b0:3a4:915f:4032 with SMTP id
 be9-20020a056808218900b003a4915f4032mr941991oib.4.1689832619043; Wed, 19 Jul
 2023 22:56:59 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:56:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fcf0690600e4d04d@google.com>
Subject: [syzbot] [f2fs?] UBSAN: array-index-out-of-bounds in f2fs_iget
From:   syzbot <syzbot+601018296973a481f302@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, terrelln@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    831fe284d827 Merge tag 'spi-fix-v6.5-rc1' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=141f4b7ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d0f369ef5fb88c9
dashboard link: https://syzkaller.appspot.com/bug?extid=601018296973a481f302
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158c0fa2a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151ccab6a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/39d3caef3826/disk-831fe284.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3fe7a2f8d904/vmlinux-831fe284.xz
kernel image: https://storage.googleapis.com/syzbot-assets/35ec390bfc7b/bzImage-831fe284.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/246fb1ccbc0b/mount_0.gz

The issue was bisected to:

commit d48a7b3a72f121655d95b5157c32c7d555e44c05
Author: Chao Yu <chao@kernel.org>
Date:   Mon Jan 9 03:49:20 2023 +0000

    f2fs: fix to do sanity check on extent cache correctly

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1647d396a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1547d396a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1147d396a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+601018296973a481f302@syzkaller.appspotmail.com
Fixes: d48a7b3a72f1 ("f2fs: fix to do sanity check on extent cache correctly")

F2FS-fs (loop0): Mismatch start address, segment0(512) cp_blkaddr(605)
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
F2FS-fs (loop0): invalid crc value
F2FS-fs (loop0): Found nat_bits in checkpoint
================================================================================
UBSAN: array-index-out-of-bounds in fs/f2fs/f2fs.h:3275:19
index 1409 is out of range for type '__le32[923]' (aka 'unsigned int[923]')
CPU: 1 PID: 5015 Comm: syz-executor425 Not tainted 6.5.0-rc1-syzkaller-00259-g831fe284d827 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
 inline_data_addr fs/f2fs/f2fs.h:3275 [inline]
 __recover_inline_status fs/f2fs/inode.c:113 [inline]
 do_read_inode fs/f2fs/inode.c:480 [inline]
 f2fs_iget+0x4730/0x48b0 fs/f2fs/inode.c:604
 f2fs_fill_super+0x640e/0x80c0 fs/f2fs/super.c:4601
 mount_bdev+0x276/0x3b0 fs/super.c:1391
 legacy_get_tree+0xef/0x190 fs/fs_context.c:611
 vfs_get_tree+0x8c/0x270 fs/super.c:1519
 do_new_mount+0x28f/0xae0 fs/namespace.c:3335
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9cb156f8ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd13318458 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd13318470 RCX: 00007f9cb156f8ba
RDX: 0000000020000000 RSI: 0000000020000040 RDI: 00007ffd13318470
RBP: 0000000000000004 R08: 00007ffd133184b0 R09: 0000000000007e87
R10: 0000000000000010 R11: 0000000000000286 R12: 0000000000000010
R13: 00007ffd133184b0 R14: 0000000000000003 R15: 0000000001ee4e54
 </TASK>
================================================================================


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
