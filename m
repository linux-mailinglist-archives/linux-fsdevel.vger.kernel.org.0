Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B722612FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 16:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgIHOvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 10:51:09 -0400
Received: from mail-pf1-f205.google.com ([209.85.210.205]:34598 "EHLO
        mail-pf1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbgIHO0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 10:26:07 -0400
Received: by mail-pf1-f205.google.com with SMTP id g6so10778670pfi.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2020 07:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=D/csrweqGrVkpEAZ5pplUNZ1TOwhSVEWpZDLuH0vrCo=;
        b=sp5/YL8rSr/fEoKSjue2IKtgo8kcBkZ40j+5RGjLbdRX8KHc7tH+flflq9ust/O+Lq
         +nlVIwhqiCYVb2jZkoRobtwzomav48l7lX7+xQM3Wjqphn4FOaQuQ5AQ3w1ZiFa35hTm
         mYCSRUQVIQb9UkNLs1yAyTYw6C2eOO48D9ftKlA/7ZcBeAIXLUayV4JanfwkL2DPmNni
         jyOG4X4zSB8EAPIRgPo4SCwr60LXBus8gNTG2PZB6Bb4ySn73xEwud70tI/6gu9O0n1a
         OQoJs6/z3OYI1sFkJQoQGsbDMhAt7phKJ6H1TVYEPf05KcUuSd/Li5EBDCGabhZ5fvYG
         2KiQ==
X-Gm-Message-State: AOAM531kMdXdrAea/8IPbCFHs+t6lSyPoj2HDhLp3pUZ3yN/GK3rxIZl
        GwH7ozWkqd293Rank27fdlaFmXPBRG0MUeQAABdu4BBXehC3
X-Google-Smtp-Source: ABdhPJzrA5qcyYQg4o7/Izr1PNFz2CRZvSjZXQ0hheFIG88YJDqhJlLXftQMRM+cTsAhyWpq9Medsh/P1HjMX4PRpb8AIQS1cVl9
MIME-Version: 1.0
X-Received: by 2002:a6b:2b07:: with SMTP id r7mr21194679ior.181.1599574756014;
 Tue, 08 Sep 2020 07:19:16 -0700 (PDT)
Date:   Tue, 08 Sep 2020 07:19:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fc64e05aece0537@google.com>
Subject: BUG: unable to handle kernel paging request in __sb_start_write
From:   syzbot <syzbot+4d428ef55ad3356698bf@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e28f0104 Merge tag 'fixes-2020-09-03' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a6b859900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
dashboard link: https://syzkaller.appspot.com/bug?extid=4d428ef55ad3356698bf
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13949019900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14fe9e3e900000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b6a5ae900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11b6a5ae900000
console output: https://syzkaller.appspot.com/x/log.txt?x=16b6a5ae900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d428ef55ad3356698bf@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffe8ffffc33c70
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 77000000000000 P4D 77000000000000 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 10445 Comm: syz-executor899 Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:percpu_down_read_trylock include/linux/percpu-rwsem.h:82 [inline]
RIP: 0010:__sb_start_write+0x16e/0x470 fs/super.c:1674
Code: 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 e3 02 00 00 41 bd 01 00 00 00 bd 01 00 00 00 48 8b 43 68 <65> ff 00 e8 aa 6b b4 ff bf 01 00 00 00 e8 e0 d5 8f ff 31 ff 65 44
RSP: 0018:ffffc9000a0bfab8 EFLAGS: 00010246
RAX: 0000607f51633c70 RBX: ffff888098be2380 RCX: ffffffff81bfdf07
RDX: 1ffff1101317c47d RSI: 0000000000000001 RDI: ffff888098be23e8
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000000 R15: ffff8880854bc0b0
FS:  00007fa632ef6700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffe8ffffc33c70 CR3: 000000000011b000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 sb_start_write_trylock include/linux/fs.h:1648 [inline]
 touch_atime+0x152/0x370 fs/inode.c:1831
 file_accessed include/linux/fs.h:2206 [inline]
 splice_direct_to_actor+0x762/0x980 fs/splice.c:989
 do_splice_direct+0x1b3/0x280 fs/splice.c:1059
 do_sendfile+0x55f/0xd40 fs/read_write.c:1540
 __do_sys_sendfile64 fs/read_write.c:1601 [inline]
 __se_sys_sendfile64 fs/read_write.c:1587 [inline]
 __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1587
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446ac9
Code: Bad RIP value.
RSP: 002b:00007fa632ef5d18 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000006dbc58 RCX: 0000000000446ac9
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00000000006dbc50 R08: 65732f636f72702f R09: 65732f636f72702f
R10: 0800000080004101 R11: 0000000000000246 R12: 00000000006dbc5c
R13: 00007fa632ef5d20 R14: 00007fa632ef5d20 R15: 20c49ba5e353f7cf
Modules linked in:
CR2: ffffe8ffffc33c70
---[ end trace 641e2e487fb96738 ]---
RIP: 0010:percpu_down_read_trylock include/linux/percpu-rwsem.h:82 [inline]
RIP: 0010:__sb_start_write+0x16e/0x470 fs/super.c:1674
Code: 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 e3 02 00 00 41 bd 01 00 00 00 bd 01 00 00 00 48 8b 43 68 <65> ff 00 e8 aa 6b b4 ff bf 01 00 00 00 e8 e0 d5 8f ff 31 ff 65 44
RSP: 0018:ffffc9000a0bfab8 EFLAGS: 00010246
RAX: 0000607f51633c70 RBX: ffff888098be2380 RCX: ffffffff81bfdf07
RDX: 1ffff1101317c47d RSI: 0000000000000001 RDI: ffff888098be23e8
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000000 R15: ffff8880854bc0b0
FS:  00007fa632ef6700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000446a9f CR3: 000000000011b000 CR4: 00000000001506f0
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
