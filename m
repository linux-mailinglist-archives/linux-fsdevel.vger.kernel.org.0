Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92507461C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 20:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjGCSDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 14:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjGCSDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:03:01 -0400
Received: from mail-pg1-f205.google.com (mail-pg1-f205.google.com [209.85.215.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAE6E5F
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 11:02:59 -0700 (PDT)
Received: by mail-pg1-f205.google.com with SMTP id 41be03b00d2f7-55b9ed8275aso1387849a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jul 2023 11:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688407378; x=1690999378;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8z80RBhj8pIWxUsoYhQZS8OsYGwN6pTmTjWk7DRU9Ao=;
        b=eaTIkHBVdzLTe9GPTtk8YlzRv9KbD5Cv1j9A2vWsuLazPTDWtVvBdS9c8q5WnRo4fE
         8Ilh7RF7SrFqDhbvyXsDdKZNL3WBrtEODA76Q/JWLiZQEliFUxqFZ1yiFf32wm3/4A8c
         OVfbdbWD4dFd7K7F8hfiuhysYe0RzlGv4xSBwMPRC3XKS9fvvqmOpUQeBxGeg4jJ1iq6
         Zw42xA++Mt67ngb+U7y31JllEctR4ObcB2yOsyPCcLecmynkRyCxVrZlwoKoGa1vvXfY
         Mwf4w7G77NN/d58wpkmNzlC3mVuvv6aapgeS8QpaCPY2ajchtYPyvbSAyN9DhkCnHUuV
         utjQ==
X-Gm-Message-State: ABy/qLb8wXSwzBCf4ceTocAqL/SckaNdsGE1Zl11TjbYVM0eDsLRW+eP
        g2N0Oy2XgfYCkZ3hZAl7atFEi6pxTVvUbYOwBjE5qDyP1nKz
X-Google-Smtp-Source: APBJJlFNystmhZrwKagAPFOuVGkBZnpd0lpPVQoeN1hhfjwUddTY/W4cUj/oqffTo16roztSY6y3wt4Nhk0zx4kPcq3WESyBEeZi
MIME-Version: 1.0
X-Received: by 2002:a63:4c51:0:b0:55b:603b:4a5b with SMTP id
 m17-20020a634c51000000b0055b603b4a5bmr5879166pgl.9.1688407378545; Mon, 03 Jul
 2023 11:02:58 -0700 (PDT)
Date:   Mon, 03 Jul 2023 11:02:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008d0f405ff98fa21@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in merge_reloc_roots
From:   syzbot <syzbot+adac949c4246513f0dc6@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, fdmanana@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b19edac5992d Merge tag 'nolibc.2023.06.22a' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e0cfe0a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=33c8c2baba1cfc7e
dashboard link: https://syzkaller.appspot.com/bug?extid=adac949c4246513f0dc6
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1562a47f280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e1a4f239105a/disk-b19edac5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/25776c3e9785/vmlinux-b19edac5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca7e959d451d/bzImage-b19edac5.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/2926fe9a4819/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/da38c75be578/mount_17.gz

The issue was bisected to:

commit 751a27615ddaaf95519565d83bac65b8aafab9e8
Author: Filipe Manana <fdmanana@suse.com>
Date:   Thu Jun 8 10:27:49 2023 +0000

    btrfs: do not BUG_ON() on tree mod log failures at btrfs_del_ptr()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15196068a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17196068a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=13196068a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+adac949c4246513f0dc6@syzkaller.appspotmail.com
Fixes: 751a27615dda ("btrfs: do not BUG_ON() on tree mod log failures at btrfs_del_ptr()")

assertion failed: 0, in fs/btrfs/relocation.c:2011
------------[ cut here ]------------
kernel BUG at fs/btrfs/relocation.c:2011!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7243 Comm: syz-executor.3 Not tainted 6.4.0-syzkaller-01312-gb19edac5992d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:merge_reloc_roots+0x98b/0x9a0 fs/btrfs/relocation.c:2011
Code: cb d1 10 07 0f 0b e8 84 9d ed fd 48 c7 c7 60 45 2b 8b 48 c7 c6 c0 50 2b 8b 48 c7 c2 e0 45 2b 8b b9 db 07 00 00 e8 a5 d1 10 07 <0f> 0b e8 7e 12 13 07 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 41
RSP: 0018:ffffc9000656f760 EFLAGS: 00010246
RAX: 0000000000000032 RBX: ffff88806a59a030 RCX: a7b6d3c4bc715b00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000656f870 R08: ffffffff816efd9c R09: fffff52000cadea1
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff888079e16558
R13: ffff888079e16000 R14: ffff88806a59a000 R15: dffffc0000000000
FS:  00007f62d8f56700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7ba56f1000 CR3: 000000001a7d0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 relocate_block_group+0xa68/0xcd0 fs/btrfs/relocation.c:3751
 btrfs_relocate_block_group+0x7ab/0xd70 fs/btrfs/relocation.c:4087
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3283
 __btrfs_balance+0x1b06/0x2690 fs/btrfs/volumes.c:4018
 btrfs_balance+0xbdb/0x1120 fs/btrfs/volumes.c:4402
 btrfs_ioctl_balance+0x496/0x7c0 fs/btrfs/ioctl.c:3604
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f62d828c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f62d8f56168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f62d83abf80 RCX: 00007f62d828c389
RDX: 00000000200003c0 RSI: 00000000c4009420 RDI: 0000000000000006
RBP: 00007f62d82d7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffedd8614bf R14: 00007f62d8f56300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:merge_reloc_roots+0x98b/0x9a0 fs/btrfs/relocation.c:2011
Code: cb d1 10 07 0f 0b e8 84 9d ed fd 48 c7 c7 60 45 2b 8b 48 c7 c6 c0 50 2b 8b 48 c7 c2 e0 45 2b 8b b9 db 07 00 00 e8 a5 d1 10 07 <0f> 0b e8 7e 12 13 07 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 41
RSP: 0018:ffffc9000656f760 EFLAGS: 00010246
RAX: 0000000000000032 RBX: ffff88806a59a030 RCX: a7b6d3c4bc715b00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000656f870 R08: ffffffff816efd9c R09: fffff52000cadea1
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff888079e16558
R13: ffff888079e16000 R14: ffff88806a59a000 R15: dffffc0000000000
FS:  00007f62d8f56700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f83ebdff000 CR3: 000000001a7d0000 CR4: 00000000003506f0
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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
