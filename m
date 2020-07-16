Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7CD221CD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 08:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgGPGtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 02:49:22 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:42449 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgGPGtV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:49:21 -0400
Received: by mail-io1-f72.google.com with SMTP id l18so2993696ion.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 23:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Jb66gF5TU/5G0RQu96O7sxpWsrW4mYp2swVpVG+8PLQ=;
        b=trzUDfA/vnMVNHM2aOivYXFJMEWRQDuKft6H1s3HxuBDjiV0zcJK14JhQoyYI5k22o
         J9j9EebD89PdWUQ5CFX0+jh7qalT9JlMujiEDM/yEdoLG3audgch0zKXv3X4r0j6hHwB
         Lyv5Qkelt1eHpk9tO//d8hErHcCrhUWxtgDU1PkAXn0Mw1wIEykR4le2HqQIqlsdYdp5
         h/6MGCv6hKQAwygyB8LvAXftsvs/0kxwOUFhOEDc2I+m8Mud5wHqeIc38IKqXg2Rzh+i
         58gTIAsPAZ/ggEzUqXnU6PmP/izbLAo0CIwR0xLj1Ti1mwdzDB0ZEJZWFNMIM8UZlYVD
         2x6A==
X-Gm-Message-State: AOAM531ZPO46pjVFw1CnCGtGwtIrgNBxic+/aNvZhK7+ub3L3GPAHSWs
        PDlsvdAkcSrRZcyaCSzJ5aQwxxgOj3lQAi8pVQE0T/xZoq3S
X-Google-Smtp-Source: ABdhPJx25uyIgSwV9oiD3qZEmSnsqUaWzZ4i3gAqzxYixj++WyS0bT5dhEynXbtVsWXRz6JzdgIZqwA4GA4mxkvDycbXlHETAQxe
MIME-Version: 1.0
X-Received: by 2002:a02:854a:: with SMTP id g68mr3561329jai.24.1594882160593;
 Wed, 15 Jul 2020 23:49:20 -0700 (PDT)
Date:   Wed, 15 Jul 2020 23:49:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4189005aa8970c7@google.com>
Subject: BUG: corrupted list in evict
From:   syzbot <syzbot+2677e2f48b47153e3838@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d31958b3 Add linux-next specific files for 20200710
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1050b2af100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fe4fccb94cbc1a6
dashboard link: https://syzkaller.appspot.com/bug?extid=2677e2f48b47153e3838
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2677e2f48b47153e3838@syzkaller.appspotmail.com

list_del corruption. next->prev should be ffff88808970f818, but was 0000000000000000
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:54!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7059 Comm: syz-executor.3 Not tainted 5.8.0-rc4-next-20200710-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__list_del_entry_valid.cold+0x48/0x55 lib/list_debug.c:54
Code: e8 a1 71 c0 fd 0f 0b 4c 89 e2 48 89 ee 48 c7 c7 e0 db 93 88 e8 8d 71 c0 fd 0f 0b 48 89 ee 48 c7 c7 a0 dc 93 88 e8 7c 71 c0 fd <0f> 0b cc cc cc cc cc cc cc cc cc cc cc 41 57 41 56 41 55 41 54 55
RSP: 0018:ffffc90003ed7958 EFLAGS: 00010282
RAX: 0000000000000054 RBX: ffff88808970f818 RCX: 0000000000000000
RDX: ffff88805e3401c0 RSI: ffffffff815d7e07 RDI: fffff520007daf1d
RBP: ffff88808970f818 R08: 0000000000000054 R09: ffff8880ae6318e7
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880494b5c60
R13: ffff88800082e290 R14: ffffffff88598f60 R15: ffff88808970f728
FS:  0000000001ce5940(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000ca3b72 CR3: 00000000a1033000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __list_del_entry include/linux/list.h:132 [inline]
 list_del_init include/linux/list.h:204 [inline]
 inode_sb_list_del fs/inode.c:471 [inline]
 evict+0x181/0x750 fs/inode.c:565
 iput_final fs/inode.c:1652 [inline]
 iput.part.0+0x424/0x850 fs/inode.c:1678
 iput+0x58/0x70 fs/inode.c:1668
 proc_invalidate_siblings_dcache+0x28d/0x600 fs/proc/inode.c:160
 release_task+0xc63/0x14d0 kernel/exit.c:221
 wait_task_zombie kernel/exit.c:1088 [inline]
 wait_consider_task+0x2fb3/0x3b20 kernel/exit.c:1315
 do_wait_thread kernel/exit.c:1378 [inline]
 do_wait+0x36a/0x9e0 kernel/exit.c:1449
 kernel_wait4+0x14c/0x260 kernel/exit.c:1604
 __do_sys_wait4+0x13f/0x150 kernel/exit.c:1616
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4169ca
Code: Bad RIP value.
RSP: 002b:00007ffc79eed098 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 00000000000f83dc RCX: 00000000004169ca
RDX: 0000000040000001 RSI: 00007ffc79eed0d0 RDI: ffffffffffffffff
RBP: 00000000000018e5 R08: 0000000000000001 R09: 0000000001ce5940
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007ffc79eed0d0 R14: 00000000000f838e R15: 00007ffc79eed0e0
Modules linked in:
---[ end trace 532812e394e0dae0 ]---
RIP: 0010:__list_del_entry_valid.cold+0x48/0x55 lib/list_debug.c:54
Code: e8 a1 71 c0 fd 0f 0b 4c 89 e2 48 89 ee 48 c7 c7 e0 db 93 88 e8 8d 71 c0 fd 0f 0b 48 89 ee 48 c7 c7 a0 dc 93 88 e8 7c 71 c0 fd <0f> 0b cc cc cc cc cc cc cc cc cc cc cc 41 57 41 56 41 55 41 54 55
RSP: 0018:ffffc90003ed7958 EFLAGS: 00010282
RAX: 0000000000000054 RBX: ffff88808970f818 RCX: 0000000000000000
RDX: ffff88805e3401c0 RSI: ffffffff815d7e07 RDI: fffff520007daf1d
RBP: ffff88808970f818 R08: 0000000000000054 R09: ffff8880ae6318e7
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880494b5c60
R13: ffff88800082e290 R14: ffffffff88598f60 R15: ffff88808970f728
FS:  0000000001ce5940(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000ca3b72 CR3: 00000000a1033000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
