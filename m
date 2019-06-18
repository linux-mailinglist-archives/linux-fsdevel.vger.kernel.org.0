Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7334D49E84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 12:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfFRKrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 06:47:11 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:38402 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbfFRKrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:47:11 -0400
Received: by mail-io1-f71.google.com with SMTP id h4so15742533iol.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jun 2019 03:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hoLr0UvVJh2R0CN6GGC4wDkNCoMgWtaDmFKyFu1Ktzc=;
        b=Q9/xgyDISHw1aVCNqXGRujqjG1r5lRQwesJev9L1uAA6heqQLw6cT6KGRcOZ+M5ZGm
         8tCEfv+c9uTF76cFvr1ba539bOQKXuqmtBGf/dcO2wIdSmpzmteJBKnJ0vN0VJeJihEG
         tgNaX2k/1o5y04PbZJlAYRref0Bi+plmIsyO4XSRDgWI+LNVR30/TpJta8Znpb7HWIh/
         U/zszBkp5tOq7YEO8D8cY8vPopqCc1dsT3pSYvNDpxcvtNIwHS0i34nj3GasakVvJR/K
         9XEWKfySWtOx4dS0Kb2s2xYE465QnG/1cK9cwTznbk+YSDHDBHfyn+7xDlqywRhf1HiR
         R/sw==
X-Gm-Message-State: APjAAAUdn8nmsrdSzzmUQe+q9J2Avm17NsNOq9qPqUUmcJYKpfOHBefE
        T0MlABGZ/EXiOyPThco/F94W+eWaIqvXlInsFLd2NWU6gN+g
X-Google-Smtp-Source: APXvYqx2Lh7Gl03zYLM35CvMUovtwJypF0pUIg1lbS9UVOrOZeGrk45uq8egfvxiQMh36+bl1pHBrqLwPL5/FlNGsX8sKEnmTOTp
MIME-Version: 1.0
X-Received: by 2002:a6b:b593:: with SMTP id e141mr70560056iof.203.1560854830723;
 Tue, 18 Jun 2019 03:47:10 -0700 (PDT)
Date:   Tue, 18 Jun 2019 03:47:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb362d058b96d54d@google.com>
Subject: general protection fault in do_move_mount (2)
From:   syzbot <syzbot+6004acbaa1893ad013f0@syzkaller.appspotmail.com>
To:     arnd@arndb.de, axboe@kernel.dk, bp@alien8.de,
        catalin.marinas@arm.com, christian@brauner.io, dhowells@redhat.com,
        geert@linux-m68k.org, hare@suse.com, heiko.carstens@de.ibm.com,
        hpa@zytor.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9e0babf2 Linux 5.2-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138b310aa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d16883d6c7f0d717
dashboard link: https://syzkaller.appspot.com/bug?extid=6004acbaa1893ad013f0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154e8c2aa00000

The bug was bisected to:

commit 9c8ad7a2ff0bfe58f019ec0abc1fb965114dde7d
Author: David Howells <dhowells@redhat.com>
Date:   Thu May 16 11:52:27 2019 +0000

     uapi, x86: Fix the syscall numbering of the mount API syscalls [ver #2]

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14fa8411a00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16fa8411a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12fa8411a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6004acbaa1893ad013f0@syzkaller.appspotmail.com
Fixes: 9c8ad7a2ff0b ("uapi, x86: Fix the syscall numbering of the mount API  
syscalls [ver #2]")

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9133 Comm: syz-executor.0 Not tainted 5.2.0-rc5 #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:do_move_mount.isra.0+0x5fe/0xe10 fs/namespace.c:2602
Code: ff ff 00 0f 84 7a fb ff ff e8 de a4 b5 ff 48 8b 85 50 ff ff ff 48 8d  
78 48 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 6d 07 00 00 48 8b 85 50 ff ff ff 31 ff 4c 8b 78
RSP: 0018:ffff888097117d58 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff888097117ea8 RCX: 1ffff11015330137
RDX: 0000000000000006 RSI: ffffffff81bb1c82 RDI: 0000000000000032
RBP: ffff888097117e38 R08: ffff88808971c5c0 R09: ffffed1015d06be0
R10: ffffed1015d06bdf R11: ffff8880ae835efb R12: ffff88809f377f00
R13: ffff88821baa2420 R14: ffff888097117e90 R15: ffff8880a99809a0
FS:  00007f0eb2bcd700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa3553c2000 CR3: 00000000a8a61000 CR4: 00000000001406f0
Call Trace:
  __do_sys_move_mount fs/namespace.c:3524 [inline]
  __se_sys_move_mount fs/namespace.c:3483 [inline]
  __x64_sys_move_mount+0x355/0x440 fs/namespace.c:3483
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4592c9
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0eb2bccc78 EFLAGS: 00000246 ORIG_RAX: 00000000000001ad
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00000000004592c9
RDX: ffffffffffffff9c RSI: 0000000020000040 RDI: 0000000000000003
RBP: 000000000075c070 R08: 0000000000000066 R09: 0000000000000000
R10: 0000000020000100 R11: 0000000000000246 R12: 00007f0eb2bcd6d4
R13: 00000000004c5706 R14: 00000000004d9ba8 R15: 00000000ffffffff
Modules linked in:
---[ end trace 9c2a9754ccc962c7 ]---
RIP: 0010:do_move_mount.isra.0+0x5fe/0xe10 fs/namespace.c:2602
Code: ff ff 00 0f 84 7a fb ff ff e8 de a4 b5 ff 48 8b 85 50 ff ff ff 48 8d  
78 48 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 6d 07 00 00 48 8b 85 50 ff ff ff 31 ff 4c 8b 78
RSP: 0018:ffff888097117d58 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff888097117ea8 RCX: 1ffff11015330137
RDX: 0000000000000006 RSI: ffffffff81bb1c82 RDI: 0000000000000032
RBP: ffff888097117e38 R08: ffff88808971c5c0 R09: ffffed1015d06be0
R10: ffffed1015d06bdf R11: ffff8880ae835efb R12: ffff88809f377f00
R13: ffff88821baa2420 R14: ffff888097117e90 R15: ffff8880a99809a0
FS:  00007f0eb2bcd700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa3553c2000 CR3: 00000000a8a61000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
