Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1A7736BB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 14:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjFTMNz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 08:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjFTMNy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:13:54 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33945B7
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 05:13:53 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-77e2ed41b7aso291284239f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 05:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687263232; x=1689855232;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eqk0IFa6B4okjEk+S5qNQ7XkCUn70fMmtjcbPGRTCss=;
        b=X5WEU3Z/IzLL3FEjxr/N6vfPzjKx5EuFw9Ro+qrkW6b+OazRuNeTWIcW5lUvmomw5v
         IsCfyBsmtBn9Hn+mXwO5ScfjTFShryVWuxSeHhis4R/c5GhUdu3jglSTvngdM4P6rm86
         GsePR5D6CEHjtH1c/30omv9B7KH9qbgFHfuF5G2wm2j+IEBdDruI6AZdB+IexBihqbML
         6fIIXIb/N3/tcjFmlVffpZIo7U/4PiU0mUh8M4uxfATt8v/aQiIs6+4pMs1HRvIGAy3k
         vb+F2g+EhvPr4qs5bVTyRQLF99/U7AXX3VbsHo/Hqo/u/vatZtPpILJl3a8q65sUA3yI
         TFzg==
X-Gm-Message-State: AC+VfDyjywvO1dYFQiQiOpstWBhwNiqXptHfw9TreVUXCzFFPHmfJnAe
        2fHZft037k9JCaLnl5lH5N/cfS/ZdhyXcV5JAa1ELtO7yN31
X-Google-Smtp-Source: ACHHUZ5/5SzzuUV9SpYtFuEmQLaTXqeeApLe191WLkupF6kj/jG62R/cCyiIg8IdxduOOmL/A+5WA0KDWRD+Xp3Onmh4gVvlk2LF
MIME-Version: 1.0
X-Received: by 2002:a02:b147:0:b0:423:1c61:b08f with SMTP id
 s7-20020a02b147000000b004231c61b08fmr3697104jah.2.1687263232553; Tue, 20 Jun
 2023 05:13:52 -0700 (PDT)
Date:   Tue, 20 Jun 2023 05:13:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e798305fe8e95ac@google.com>
Subject: [syzbot] [jfs?] kernel BUG in txEnd
From:   syzbot <syzbot+3699edf4da1e736b317b@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    692b7dc87ca6 Merge tag 'hyperv-fixes-signed-20230619' of g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=110bb2df280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e74b395fe4978721
dashboard link: https://syzkaller.appspot.com/bug?extid=3699edf4da1e736b317b
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b373a7280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1749e8f3280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/38d2d82cb73f/disk-692b7dc8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2933a370148/vmlinux-692b7dc8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ae0615062569/bzImage-692b7dc8.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7ffba913af27/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3699edf4da1e736b317b@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
ERROR: (device loop0): xtTruncate: XT_GETPAGE: xtree page corrupt
ERROR: (device loop0): remounting filesystem as read-only
BUG at fs/jfs/jfs_txnmgr.c:523 assert(tblk->next == 0)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_txnmgr.c:523!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 4995 Comm: syz-executor157 Not tainted 6.4.0-rc7-syzkaller-00014-g692b7dc87ca6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:txEnd+0x556/0x560 fs/jfs/jfs_txnmgr.c:523
Code: fe e9 cd fe ff ff e8 e9 71 80 fe 48 c7 c7 00 81 21 8b 48 c7 c6 39 7d 21 8b ba 0b 02 00 00 48 c7 c1 40 81 21 8b e8 4a a0 a2 07 <0f> 0b 0f 1f 84 00 00 00 00 00 66 0f 1f 00 55 41 57 41 56 41 55 41
RSP: 0018:ffffc90003a1f5b0 EFLAGS: 00010246
RAX: 0000000000000036 RBX: 0000000000000001 RCX: 41752a4d4c338600
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 1ffff920004ce227 R08: ffffffff816f00ac R09: fffff52000743e2d
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: 0000000000000001 R14: ffffc90002671138 R15: 0000000000000110
FS:  0000555555bc0300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdb3a73ff8 CR3: 000000007d1a7000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jfs_truncate_nolock+0x2f3/0x390 fs/jfs/inode.c:391
 jfs_truncate+0xcb/0x140 fs/jfs/inode.c:412
 jfs_setattr+0x526/0x780 fs/jfs/file.c:119
 notify_change+0xc8b/0xf40 fs/attr.c:483
 do_truncate+0x220/0x300 fs/open.c:66
 handle_truncate fs/namei.c:3295 [inline]
 do_open fs/namei.c:3640 [inline]
 path_openat+0x294e/0x3170 fs/namei.c:3791
 do_filp_open+0x234/0x490 fs/namei.c:3818
 do_sys_openat2+0x13f/0x500 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_open fs/open.c:1380 [inline]
 __se_sys_open fs/open.c:1376 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1376
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faa7bec2769
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd6b116f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007faa7bec2769
RDX: 0000000000000000 RSI: 000000000014527e RDI: 0000000020000040
RBP: 00007faa7be82000 R08: 0000000000005dea R09: 0000000000000000
R10: 00007ffcd6b115c0 R11: 0000000000000246 R12: 00007faa7be82090
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:txEnd+0x556/0x560 fs/jfs/jfs_txnmgr.c:523
Code: fe e9 cd fe ff ff e8 e9 71 80 fe 48 c7 c7 00 81 21 8b 48 c7 c6 39 7d 21 8b ba 0b 02 00 00 48 c7 c1 40 81 21 8b e8 4a a0 a2 07 <0f> 0b 0f 1f 84 00 00 00 00 00 66 0f 1f 00 55 41 57 41 56 41 55 41
RSP: 0018:ffffc90003a1f5b0 EFLAGS: 00010246
RAX: 0000000000000036 RBX: 0000000000000001 RCX: 41752a4d4c338600
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 1ffff920004ce227 R08: ffffffff816f00ac R09: fffff52000743e2d
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: 0000000000000001 R14: ffffc90002671138 R15: 0000000000000110
FS:  0000555555bc0300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdb3a73ff8 CR3: 000000007d1a7000 CR4: 00000000003506e0
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
