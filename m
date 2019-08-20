Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD30196A0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 22:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbfHTUSL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 16:18:11 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:39574 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfHTUSL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:18:11 -0400
Received: by mail-io1-f70.google.com with SMTP id g12so99456iok.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 13:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DX21hV2sHb8qnB6xf7xKFRXeU6pY2wJxsDPsJKyNCmo=;
        b=beDht/SWU0ualeiOt5yRuZ6IwQsSrOfj1U34bCdwupxNIAB/s5wat5Vtwet2f/izJF
         JxnJ6BKxS6uOJVqzZ864ap5IhEBr1tGa224SGcFvVTAmOmTP+RiUhaLD46UtktkwmMg+
         U8cW37RhT+N3sAl6hW+co5/PJbU/MJp9iNvPhgDdF5l3kCayPWIaeJEXgcLmsUB1GFZw
         KQcPppM0PyHPSrw/OinUKGY/gmft8dZef5ohWpryqh8a+Q0BodAYQeoAbvGyw8F/aGY8
         9apc0R2y53I9Zhp9nygVxtfOj5x+kx9NbCNJXgkut8B6c1Bb962mbyUSbKQqwf5J4cJK
         V9HQ==
X-Gm-Message-State: APjAAAVtB/ityZ7E9HuNdwnCuUXJKu3SGqJDeVi3uzuCno425FUE2B0V
        2QCszVw0Es0oyVG5/ML9QfP6xAM8jO6vAJaHpFPme8Xnj03b
X-Google-Smtp-Source: APXvYqzT+lMwz6G0NA9p2ytCEk0WHlGbAH1wNj2zq1Z2cy59kWzfKnesMO3MKJONVcQpN7OamRxo8QYbHUDG6yolWDVeY8iEr/bq
MIME-Version: 1.0
X-Received: by 2002:a02:29ca:: with SMTP id p193mr5669638jap.88.1566332286772;
 Tue, 20 Aug 2019 13:18:06 -0700 (PDT)
Date:   Tue, 20 Aug 2019 13:18:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008dcde00590922713@google.com>
Subject: WARNING: refcount bug in chrdev_open
From:   syzbot <syzbot+1c85a21f1c6bc88eb388@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a69e9051 Merge tag 'xfs-5.3-fixes-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1450b25a600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d7eaed8496da4da
dashboard link: https://syzkaller.appspot.com/bug?extid=1c85a21f1c6bc88eb388
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1088edba600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10477772600000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d7389c600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1437389c600000
console output: https://syzkaller.appspot.com/x/log.txt?x=1037389c600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1c85a21f1c6bc88eb388@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: increment on 0; use-after-free.
WARNING: CPU: 1 PID: 12599 at lib/refcount.c:156  
refcount_inc_checked+0x4b/0x50 lib/refcount.c:156
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 12599 Comm: syz-executor314 Not tainted 5.3.0-rc4+ #78
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  panic+0x25c/0x799 kernel/panic.c:219
  __warn+0x22f/0x230 kernel/panic.c:576
  report_bug+0x190/0x290 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  do_error_trap+0xd7/0x440 arch/x86/kernel/traps.c:272
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:refcount_inc_checked+0x4b/0x50 lib/refcount.c:156
Code: 3d 2e 8b 68 05 01 75 08 e8 52 53 21 fe 5b 5d c3 e8 4a 53 21 fe c6 05  
18 8b 68 05 01 48 c7 c7 34 4b 45 88 31 c0 e8 85 3a f4 fd <0f> 0b eb df 90  
55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 ec 10
RSP: 0018:ffff88808cb579b0 EFLAGS: 00010246
RAX: cd29ce2624bf4d00 RBX: ffff8880934dcc00 RCX: ffff88809eec65c0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff88808cb579b8 R08: ffffffff815cf524 R09: ffffed1015d640d2
R10: ffffed1015d640d2 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880934dcbc8 R14: ffff8880934dcc04 R15: ffff8880934dcbc8
  kref_get include/linux/kref.h:45 [inline]
  kobject_get+0x91/0xc0 lib/kobject.c:644
  cdev_get fs/char_dev.c:355 [inline]
  chrdev_open+0x17e/0x590 fs/char_dev.c:400
  do_dentry_open+0x73b/0xf90 fs/open.c:797
  vfs_open+0x73/0x80 fs/open.c:906
  do_last fs/namei.c:3416 [inline]
  path_openat+0x1397/0x4460 fs/namei.c:3533
  do_filp_open+0x192/0x3d0 fs/namei.c:3563
  do_sys_open+0x29f/0x560 fs/open.c:1089
  __do_sys_open fs/open.c:1107 [inline]
  __se_sys_open fs/open.c:1102 [inline]
  __x64_sys_open+0x87/0x90 fs/open.c:1102
  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x406311
Code: 75 14 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 a4 18 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fb29f268960 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000406311
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fb29f268970
RBP: 6666666666666667 R08: 000000000000000f R09: 00007fb29f269700
R10: 00007fb29f2699d0 R11: 0000000000000293 R12: 00000000006dbc3c
R13: 0000000000000000 R14: 0000000000000000 R15: 00000000317a7973
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
