Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99FC1F37A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 19:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfKGSyL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 13:54:11 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:51113 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfKGSyL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:54:11 -0500
Received: by mail-il1-f199.google.com with SMTP id z12so3562366ilm.17
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2019 10:54:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=m2Qa1E1MJM3JwHE0ZbVyKXnicQ++QYA8NZNL8xEGd0k=;
        b=k5QOhvfLYkmEuhUtm65HL4ht9yXzZUHOWhX2HtbTzGxr0zXmQ1DizV2vqH1wwByFjN
         a7UBxWSd6nov6EuxfaO1XzIhzwv9+vxNKqE55f1pp3nDNqDlwxM6OGLH9AWJvjbmiYoE
         b4PG3LczleM16qMou82+ygAJSnJ6oofmfQZL6RLGdbRDPv1N1I5YowugrZy2IvmHShAJ
         PGeo64wNIJOkQRrvEVfYCLORvTfNC9EIc65Lj4KNk2IMQZK6wpH0GkIm3QiRpHan8dTA
         1Ni1Vc+iqAT3BQ15rSpFlu8y95D0jVhnS+S+O0umW7aGLuyEOgoGSt3jSH5M0N8W9fKK
         2AyA==
X-Gm-Message-State: APjAAAVuGNK8r8QxRCQbWapYw+ZMQocFimDGLnRJ0I/JHWpl/y/RmSLE
        dtBQDoNnL6btG6vFAEcH573pjeEJ85Z9WR4F1GUh0B2xKJJX
X-Google-Smtp-Source: APXvYqyEE3VyCBIcL7gUe9uBCXoJUzB4GHP/i130evFYgnvcyekpRWdvKhZjT4ksDss52iO6eeW/umQvYPF63zDyDa+CTIC1S2/t
MIME-Version: 1.0
X-Received: by 2002:a92:c08c:: with SMTP id h12mr6144591ile.183.1573152850575;
 Thu, 07 Nov 2019 10:54:10 -0800 (PST)
Date:   Thu, 07 Nov 2019 10:54:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d60aa50596c63063@google.com>
Subject: WARNING in iov_iter_pipe
From:   syzbot <syzbot+991400e8eba7e00a26e1@syzkaller.appspotmail.com>
To:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mbobrowski@mbobrowski.org,
        riteshh@linux.ibm.com, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c68c5373 Add linux-next specific files for 20191107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13d6bcfce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=742545dcdea21726
dashboard link: https://syzkaller.appspot.com/bug?extid=991400e8eba7e00a26e1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1529829ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a55c0ce00000

The bug was bisected to:

commit b1b4705d54abedfd69dcdf42779c521aa1e0fbd3
Author: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date:   Tue Nov 5 12:01:37 2019 +0000

     ext4: introduce direct I/O read using iomap infrastructure

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1176cffae00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1376cffae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1576cffae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+991400e8eba7e00a26e1@syzkaller.appspotmail.com
Fixes: b1b4705d54ab ("ext4: introduce direct I/O read using iomap  
infrastructure")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8715 at lib/iov_iter.c:1162 iov_iter_pipe+0x25b/0x2f0  
lib/iov_iter.c:1162
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 8715 Comm: syz-executor719 Not tainted 5.4.0-rc6-next-20191107  
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  panic+0x2e3/0x75c kernel/panic.c:221
  __warn.cold+0x2f/0x35 kernel/panic.c:582
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  fixup_bug arch/x86/kernel/traps.c:169 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:iov_iter_pipe+0x25b/0x2f0 lib/iov_iter.c:1162
Code: 83 c0 03 38 d0 7c 04 84 d2 75 33 44 89 63 24 48 83 c4 10 5b 41 5c 41  
5d 41 5e 41 5f 5d c3 e8 ac ba 2e fe 0f 0b e8 a5 ba 2e fe <0f> 0b e9 53 fe  
ff ff 4c 89 f7 e8 46 e5 6a fe e9 f5 fd ff ff e8 dc
RSP: 0018:ffff8880a0b4f988 EFLAGS: 00010293
RAX: ffff88808f1602c0 RBX: ffff8880a0b4fa18 RCX: ffffffff8344ac89
RDX: 0000000000000000 RSI: ffffffff8344ae3b RDI: 0000000000000004
RBP: ffff8880a0b4f9c0 R08: ffff88808f1602c0 R09: 0000000000000000
R10: fffffbfff1390168 R11: ffffffff89c80b47 R12: ffff88808f121c00
R13: 0000000000000010 R14: ffff88808f121cc8 R15: ffff88808f121cd0
  generic_file_splice_read+0xa7/0x800 fs/splice.c:303
  do_splice_to+0x127/0x180 fs/splice.c:877
  splice_direct_to_actor+0x2d3/0x970 fs/splice.c:955
  do_splice_direct+0x1da/0x2a0 fs/splice.c:1064
  do_sendfile+0x597/0xd00 fs/read_write.c:1464
  __do_sys_sendfile64 fs/read_write.c:1525 [inline]
  __se_sys_sendfile64 fs/read_write.c:1511 [inline]
  __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1511
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446969
Code: e8 4c b4 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f05c41b8ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000006dbc58 RCX: 0000000000446969
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000005
RBP: 00000000006dbc50 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00000000006dbc5c
R13: 00007fffb77353df R14: 00007f05c41b99c0 R15: 20c49ba5e353f7cf
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
