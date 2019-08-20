Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF67796C93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 00:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfHTW6H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 18:58:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:36685 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfHTW6H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 18:58:07 -0400
Received: by mail-io1-f70.google.com with SMTP id i6so500595ioi.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 15:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=96tDGWwwRLUJuc8ZLUttwZP0NNSrENPZkHRRK+Wfi44=;
        b=ABRt7ECqV6l5aytk6uLIzkT1b2t1/6Iw/v2369boVq/tvQzVvLD9PpL9qd9rKoMgk7
         OnuGqJC0AIKHE9nRa2wqGadYRQ+WB760LoyRtMhIXhwOXNFUkakYIWStS+HYv7P8PrMS
         nOfqinAzJENLFK8ZjeLy1Iaqm0GVZYM+96nekMjJ3D6GdNsNbClD7T95yHnY5IG10tqo
         BwCnwnuS6+1vZqaIySlF57FpQKkdlEhifdiLMy7NFd0pPIFSb/2wi9sqpJM7JnqFm3l1
         raDLSO4HHBqV06o47lBr5zrh8sCMGe0SjxHWJtGuR13LD6wzwZ4jCr/tmDruG8rkihrl
         GYQA==
X-Gm-Message-State: APjAAAVMmEQTPRXbhhqg9q2bxWz3wGU5k7uXWZ7UUxi62VurnsUSirul
        DvrS4+4VN5zdi8izN0XjrqdeZ1G1RfqJmwq91XyBaZE0cLbD
X-Google-Smtp-Source: APXvYqz5NCXreIdnYQdGhBkGQdho4Cjw9M7clGtOieGpTNyO+v/kCngHgT18s6Ee+84CHbD/K3d+HpY/brmlpOl2ap/3VTur9qP5
MIME-Version: 1.0
X-Received: by 2002:a02:a492:: with SMTP id d18mr6795099jam.27.1566341886589;
 Tue, 20 Aug 2019 15:58:06 -0700 (PDT)
Date:   Tue, 20 Aug 2019 15:58:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf410005909463ff@google.com>
Subject: WARNING: refcount bug in cdev_get
From:   syzbot <syzbot+82defefbbd8527e1c2cb@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2d63ba3e Merge tag 'pm-5.3-rc5' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165d3302600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ff364e429585cf2
dashboard link: https://syzkaller.appspot.com/bug?extid=82defefbbd8527e1c2cb
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c8ab3c600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16be0c4c600000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11de3622600000
console output: https://syzkaller.appspot.com/x/log.txt?x=15de3622600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+82defefbbd8527e1c2cb@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: increment on 0; use-after-free.
WARNING: CPU: 1 PID: 11828 at lib/refcount.c:156 refcount_inc_checked  
lib/refcount.c:156 [inline]
WARNING: CPU: 1 PID: 11828 at lib/refcount.c:156  
refcount_inc_checked+0x61/0x70 lib/refcount.c:154
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 11828 Comm: syz-executor746 Not tainted 5.3.0-rc4+ #112
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2dc/0x755 kernel/panic.c:219
  __warn.cold+0x20/0x4c kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:refcount_inc_checked lib/refcount.c:156 [inline]
RIP: 0010:refcount_inc_checked+0x61/0x70 lib/refcount.c:154
Code: 1d 8e c6 64 06 31 ff 89 de e8 ab 9c 35 fe 84 db 75 dd e8 62 9b 35 fe  
48 c7 c7 00 05 c6 87 c6 05 6e c6 64 06 01 e8 67 26 07 fe <0f> 0b eb c1 90  
90 90 90 90 90 90 90 90 90 90 55 48 89 e5 41 57 41
RSP: 0018:ffff8880907d78b8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815c2466 RDI: ffffed10120faf09
RBP: ffff8880907d78c8 R08: ffff8880a771a200 R09: fffffbfff134ae48
R10: fffffbfff134ae47 R11: ffffffff89a5723f R12: ffff88809ea2bb80
R13: 0000000000000000 R14: ffff88809ff6cd40 R15: ffff8880a1c56480
  kref_get include/linux/kref.h:45 [inline]
  kobject_get+0x66/0xc0 lib/kobject.c:644
  cdev_get+0x60/0xb0 fs/char_dev.c:355
  chrdev_open+0xb0/0x6b0 fs/char_dev.c:400
  do_dentry_open+0x4df/0x1250 fs/open.c:797
  vfs_open+0xa0/0xd0 fs/open.c:906
  do_last fs/namei.c:3416 [inline]
  path_openat+0x10e9/0x4630 fs/namei.c:3533
  do_filp_open+0x1a1/0x280 fs/namei.c:3563
  do_sys_open+0x3fe/0x5d0 fs/open.c:1089
  __do_sys_open fs/open.c:1107 [inline]
  __se_sys_open fs/open.c:1102 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1102
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x406311
Code: 75 14 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 a4 18 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007f047e1c0960 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000406311
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f047e1c0970
RBP: 6666666666666667 R08: 000000000000000f R09: 00007f047e1c1700
R10: 00007f047e1c19d0 R11: 0000000000000293 R12: 00000000006dbc3c
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
