Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7B54A7DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 19:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfFRRHG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 13:07:06 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:47111 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbfFRRHF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:07:05 -0400
Received: by mail-io1-f72.google.com with SMTP id r27so16929717iob.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jun 2019 10:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=s/tCv7ORrW73a2psUexWQSgK0fyQJua02afP9zd5sIs=;
        b=pDTGMAmwwgQeJSiyo/R0RMdczVPU/S4H4nvehGbJMtGb4wy5Zm99VbIXn+YVFScggt
         xMEEwtvYF4fiZ5fvrXRv++xZVWY2l+Mv6pAfi0iymQ3Acfh5Kdlf6Fuogl8hdxzCtDpW
         7TlkHyxhhBtftCrxMeCCAM0N0vPtJiYZeO3S4ZE3FgI5YAyLDnJzuRW+7F0DyDs4fThk
         K+Zb969cMY+QQMsye6jvj0SUzatswTZaEiYaF9EGWhfqqKSFj8b8c/fVxi/0lG8/I5uZ
         +hlnn8ntv0QsdWYnfS3X7cr3IhZmA+fodHHY+jqTzxYRx+QrROP1edzk7N7EOIXNN3PG
         z1dw==
X-Gm-Message-State: APjAAAWkhGwpu1xlpJaZRoCTNwav7MFT46H19MPFiS984GKK5eMjNlKQ
        rgKHHQKhQ0ryBZh4TwH5X62PXst0dzxkxwTK7T/64KaMRlU9
X-Google-Smtp-Source: APXvYqxfTGq8SSC9uNyzZexUavfJbP8V9+mDisuId9rK+m0vzwPmIbZh0qjUsip47AujUnOsLrMwZoBUlzHqWT9PYekTzUvP75Qw
MIME-Version: 1.0
X-Received: by 2002:a6b:14c2:: with SMTP id 185mr428045iou.69.1560877625127;
 Tue, 18 Jun 2019 10:07:05 -0700 (PDT)
Date:   Tue, 18 Jun 2019 10:07:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000623c45058b9c2479@google.com>
Subject: WARNING in fanotify_handle_event
From:   syzbot <syzbot+c277e8e2f46414645508@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    963172d9 Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c090eaa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9f7e1b6a8bb586
dashboard link: https://syzkaller.appspot.com/bug?extid=c277e8e2f46414645508
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a32f46a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a7dc9ea00000

The bug was bisected to:

commit 77115225acc67d9ac4b15f04dd138006b9cd1ef2
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Thu Jan 10 17:04:37 2019 +0000

     fanotify: cache fsid in fsnotify_mark_connector

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12bfcb66a00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11bfcb66a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16bfcb66a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c277e8e2f46414645508@syzkaller.appspotmail.com
Fixes: 77115225acc6 ("fanotify: cache fsid in fsnotify_mark_connector")

WARNING: CPU: 0 PID: 8994 at fs/notify/fanotify/fanotify.c:359  
fanotify_get_fsid fs/notify/fanotify/fanotify.c:359 [inline]
WARNING: CPU: 0 PID: 8994 at fs/notify/fanotify/fanotify.c:359  
fanotify_handle_event+0x5ff/0xc6d fs/notify/fanotify/fanotify.c:418
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8994 Comm: rs:main Q:Reg Not tainted 5.2.0-rc4+ #27
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x744 kernel/panic.c:219
  __warn.cold+0x20/0x4d kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:fanotify_get_fsid fs/notify/fanotify/fanotify.c:359 [inline]
RIP: 0010:fanotify_handle_event+0x5ff/0xc6d  
fs/notify/fanotify/fanotify.c:418
Code: 06 00 00 8b 5b 40 31 ff 8b b5 fc fe ff ff 09 de 89 b5 f0 fe ff ff e8  
f0 64 ab ff 8b b5 f0 fe ff ff 85 f6 75 55 e8 61 63 ab ff <0f> 0b e8 5a 63  
ab ff 41 83 c6 01 bf 03 00 00 00 44 89 f6 e8 c9 64
RSP: 0018:ffff8880a66dfb80 EFLAGS: 00010293
RAX: ffff888087bf0640 RBX: 0000000000000000 RCX: ffffffff81c55df0
RDX: 0000000000000000 RSI: ffffffff81c55dff RDI: 0000000000000005
RBP: ffff8880a66dfcc8 R08: ffff888087bf0640 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
R13: 0000000000000000 R14: 0000000000000002 R15: dffffc0000000000
  send_to_group fs/notify/fsnotify.c:271 [inline]
  fsnotify+0x71f/0xbc0 fs/notify/fsnotify.c:409
  fsnotify_path include/linux/fsnotify.h:54 [inline]
  fsnotify_path include/linux/fsnotify.h:47 [inline]
  fsnotify_modify include/linux/fsnotify.h:230 [inline]
  vfs_write+0x4dc/0x580 fs/read_write.c:560
  ksys_write+0x14f/0x290 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f4cdf18519d
Code: d1 20 00 00 75 10 b8 01 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48  
83 ec 08 e8 be fa ff ff 48 89 04 24 b8 01 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 07 fb ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007f4cdd726000 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000155 RCX: 00007f4cdf18519d
RDX: 0000000000000155 RSI: 00000000008bda90 RDI: 0000000000000001
RBP: 00000000008bda90 R08: 6573753a725f7463 R09: 745f656d6f685f72
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007f4cdd726480 R14: 0000000000000001 R15: 00000000008bd890
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
