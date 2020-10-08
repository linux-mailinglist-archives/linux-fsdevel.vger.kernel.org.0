Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B862876BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 17:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbgJHPJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 11:09:23 -0400
Received: from mail-io1-f79.google.com ([209.85.166.79]:49169 "EHLO
        mail-io1-f79.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730854AbgJHPJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:09:22 -0400
Received: by mail-io1-f79.google.com with SMTP id 140so3899799iou.16
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2020 08:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lwlZa6GlCbQUtVGYMHOGvKJiVSeJrwxW3m1iHSqUm5A=;
        b=WoELP4s2iH0Ww2+AwcMNq5NNTWUWHf5fCgpoexGv/bV1rp2ipJ0ve0kV4B0lkOSQr4
         4oyiek83f39OfnpNgF/Ew5PM1+WoB6Czz5dyILS396l5aZ5BD2JY2rO2cg4Ta+mhohP2
         A3+AQAyEsf1rHbFH/IszklPDeZCC1Knee9N/SHEO/V1fdio6cBBdkQpzc1YV7acj0Z3e
         +I2J7pFxcQ0/5yk8q/Xkadroxt2cXV1SnGEkrmRbrG/RTvrJNhaijWOvavYQCMcV3b3J
         eo4aOrEfvD9gzisJhvTLxjBIZjCyx97ZYr+cp6SR2WvQ7kY1kD2J2aUYA8CXzKRD2vPt
         w0Sg==
X-Gm-Message-State: AOAM531ApistanHwfTUviP53zCfGlvtckL0TiGueEaz9fWQLSiS4C7/O
        GPM3ZT39RWe9PPTqnZQprvwhbqLDZOutd1tlCQBwMmpqImSZ
X-Google-Smtp-Source: ABdhPJyCZY06ekrb7Et4O7OJko9Xq0vZpa+ASrQ3b2nTG9et5cbjBQUC9qUp0FtMX8nZp2yNCI+R4ZAtwpU7Dn0KzIOUHTMimwJB
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:44d:: with SMTP id a13mr7248306ils.273.1602169761748;
 Thu, 08 Oct 2020 08:09:21 -0700 (PDT)
Date:   Thu, 08 Oct 2020 08:09:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084dcbd05b12a3736@google.com>
Subject: general protection fault in percpu_ref_exit
From:   syzbot <syzbot+fd15ff734dace9e16437@syzkaller.appspotmail.com>
To:     bcrl@kvack.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8b787da7 Add linux-next specific files for 20201007
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15b6734f900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aac055e9c8fbd2b8
dashboard link: https://syzkaller.appspot.com/bug?extid=fd15ff734dace9e16437
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119a0568500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106c0a8b900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd15ff734dace9e16437@syzkaller.appspotmail.com

RDX: 0000000000000001 RSI: 0000000020000140 RDI: 000000000000f501
RBP: 00000000006dbc20 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffe36a84a0f R14: 00007f51c77e59c0 R15: 0000000000000000
general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 PID: 6924 Comm: syz-executor821 Not tainted 5.9.0-rc8-next-20201007-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__percpu_ref_exit lib/percpu-refcount.c:112 [inline]
RIP: 0010:percpu_ref_exit+0x7f/0x210 lib/percpu-refcount.c:133
Code: e5 fc 48 89 ee e8 01 42 b9 fd 48 85 ed 74 60 e8 77 45 b9 fd 49 8d 7c 24 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 26 01 00 00 49 83 7c 24 10 00 0f 85 01 01 00 00
RSP: 0018:ffffc900054b7de0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88802feb1658 RCX: ffffffff83bc130f
RDX: 0000000000000002 RSI: ffffffff83bc1319 RDI: 0000000000000010
RBP: 0000607f51875180 R08: 0000000000000001 R09: ffff88802feb1807
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88802feb1660 R14: ffff88802feb1800 R15: ffff88802feb1670
FS:  00007f51c77e5700(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000140 CR3: 0000000012424000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ioctx_alloc+0x2d2/0x1d60 fs/aio.c:804
 __do_sys_io_setup fs/aio.c:1326 [inline]
 __se_sys_io_setup fs/aio.c:1309 [inline]
 __x64_sys_io_setup+0xe9/0x230 fs/aio.c:1309
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446769
Code: e8 bc b5 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 ab 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f51c77e4db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ce
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446769
RDX: 0000000000000001 RSI: 0000000020000140 RDI: 000000000000f501
RBP: 00000000006dbc20 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffe36a84a0f R14: 00007f51c77e59c0 R15: 0000000000000000
Modules linked in:
---[ end trace 000c19ea8a5922ba ]---
RIP: 0010:__percpu_ref_exit lib/percpu-refcount.c:112 [inline]
RIP: 0010:percpu_ref_exit+0x7f/0x210 lib/percpu-refcount.c:133
Code: e5 fc 48 89 ee e8 01 42 b9 fd 48 85 ed 74 60 e8 77 45 b9 fd 49 8d 7c 24 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 26 01 00 00 49 83 7c 24 10 00 0f 85 01 01 00 00
RSP: 0018:ffffc900054b7de0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88802feb1658 RCX: ffffffff83bc130f
RDX: 0000000000000002 RSI: ffffffff83bc1319 RDI: 0000000000000010
RBP: 0000607f51875180 R08: 0000000000000001 R09: ffff88802feb1807
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88802feb1660 R14: ffff88802feb1800 R15: ffff88802feb1670
FS:  00007f51c77e5700(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000140 CR3: 0000000012424000 CR4: 00000000001506e0
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
