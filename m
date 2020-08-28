Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C081F255B12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 15:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgH1NSt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 09:18:49 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:41222 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbgH1NS0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:18:26 -0400
Received: by mail-io1-f72.google.com with SMTP id j4so869594iob.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2020 06:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iDPByw2KCkmB2dqdYQKNtmzV2Di4FyFUua38hXPB5cE=;
        b=rUp3YhMR6Jf5FRCD2af4hkgOu9qKCVzRqI658UhMJmccwzHdxervt5BDxBi906xBZk
         9AhOr9w7+XRtkoPjYKd7SRxMOh1NEMhH6QvQBCjgEIyf5ikQKLYhNy0YQw7Ikn2RBeOR
         Ged7ckIGfqs3Kd4n6gu5K1bY36Ylp/nJROWlk7mc1WrnaywWkeL9UW8MVoWI2qy32FQ2
         ttTI884L5IzbOlzxEzfaWTvTqWIAJreUIZXaeYV3SA70OJ5+N/lKkKYg+LBCd/cyh6dP
         WBl/UBprCe5IArqJ4ZO9diyqPOKkWlQaKi3Z6B7+vncrfRM+wPmXtJoA2qpGD5zLJqpY
         z/Ew==
X-Gm-Message-State: AOAM531HWx+V24daJgiDjmFbcgwJZ/BGCntdO+E5U9CtWN/+OB9ZdpLP
        X4MuCgJGZptIfvQNCXLYxKlKjj59SKee3iTJQDOKELk42Z/0
X-Google-Smtp-Source: ABdhPJxRFmiBdnwHGuc1MqyYLVqQooGrzl2/2LFdz46AqW4m54hHj4oPRW0yTVDHF3nseYoBOjugV5hGPKLJYIGpDMVMmHaS4gTU
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1616:: with SMTP id x22mr1280258iow.65.1598620697163;
 Fri, 28 Aug 2020 06:18:17 -0700 (PDT)
Date:   Fri, 28 Aug 2020 06:18:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c8fcd905adefe24b@google.com>
Subject: kernel BUG at fs/inode.c:LINE! (2)
From:   syzbot <syzbot+c92c93d1f1aaaacdb9db@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, oleg@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d012a719 Linux 5.9-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15aa650e900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
dashboard link: https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ecb939900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140a19a9900000

The issue was bisected to:

commit a9ed4a6560b8562b7e2e2bed9527e88001f7b682
Author: Marc Zyngier <maz@kernel.org>
Date:   Wed Aug 19 16:12:17 2020 +0000

    epoll: Keep a reference on files added to the check list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a50519900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15a50519900000
console output: https://syzkaller.appspot.com/x/log.txt?x=11a50519900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c92c93d1f1aaaacdb9db@syzkaller.appspotmail.com
Fixes: a9ed4a6560b8 ("epoll: Keep a reference on files added to the check list")

------------[ cut here ]------------
kernel BUG at fs/inode.c:1668!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 29571 Comm: syz-executor709 Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:iput+0x6d8/0x6e0 fs/inode.c:1668
Code: ef ff e9 1a fc ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c c8 fe ff ff 4c 89 ef e8 a2 51 ef ff e9 bb fe ff ff e8 68 77 af ff <0f> 0b 66 0f 1f 44 00 00 55 41 57 41 56 53 48 89 f5 48 89 fb 49 bf
RSP: 0018:ffffc9000e25fda8 EFLAGS: 00010293
RAX: ffffffff81c580b8 RBX: ffff888085112600 RCX: ffff8880a6eea200
RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000000000000
RBP: 0000000000000040 R08: ffffffff81c57a40 R09: ffffed10116fe44d
R10: ffffed10116fe44d R11: 0000000000000000 R12: 1ffff11010a224ac
R13: dffffc0000000000 R14: ffff888085112600 R15: ffff888085112560
FS:  0000000001665880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 000000008f752000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __sock_release net/socket.c:608 [inline]
 sock_close+0x1c3/0x260 net/socket.c:1277
 __fput+0x34f/0x7b0 fs/file_table.c:281
 task_work_run+0x137/0x1c0 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:140 [inline]
 exit_to_user_mode_prepare+0xfa/0x1b0 kernel/entry/common.c:167
 syscall_exit_to_user_mode+0x5e/0x1a0 kernel/entry/common.c:242
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4058e1
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 19 00 00 c3 48 83 ec 08 e8 6a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 b3 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffc7ca575a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000006 RCX: 00000000004058e1
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000000007 R08: 0000000120080522 R09: 0000000120080522
R10: 0000000120080522 R11: 0000000000000293 R12: 00000000006dbc5c
R13: 0000000000000001 R14: 00000000006dbc50 R15: 0000000000000064
Modules linked in:
---[ end trace 35240c511479d576 ]---
RIP: 0010:iput+0x6d8/0x6e0 fs/inode.c:1668
Code: ef ff e9 1a fc ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c c8 fe ff ff 4c 89 ef e8 a2 51 ef ff e9 bb fe ff ff e8 68 77 af ff <0f> 0b 66 0f 1f 44 00 00 55 41 57 41 56 53 48 89 f5 48 89 fb 49 bf
RSP: 0018:ffffc9000e25fda8 EFLAGS: 00010293
RAX: ffffffff81c580b8 RBX: ffff888085112600 RCX: ffff8880a6eea200
RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000000000000
RBP: 0000000000000040 R08: ffffffff81c57a40 R09: ffffed10116fe44d
R10: ffffed10116fe44d R11: 0000000000000000 R12: 1ffff11010a224ac
R13: dffffc0000000000 R14: ffff888085112600 R15: ffff888085112560
FS:  0000000001665880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 000000008f752000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
