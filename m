Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F3E10E619
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 07:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfLBGpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 01:45:09 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:47120 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfLBGpJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 01:45:09 -0500
Received: by mail-il1-f199.google.com with SMTP id d4so26449037ile.14
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Dec 2019 22:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=l0AnzQZ5Rm4/1GtZwjBpGVXk3mcbUlEcruCq1JhhvsA=;
        b=GvzPpU6iFu5h4Is9VmSXsT8E9HMnKobw1l3+zxyVzzy9yvVrjRAOXifFZlIx0LH259
         T7Wbh+PuG7z2V6HyyctYUxLaZWu8+FH25tnk+ACL3c73HbqxUBQQuaPBpr9Z5cJcjFq8
         RBDclXcPvyR+2MEc3hb1CjejzQ3y6LsXzWBgH9aIYmQJ+qOiM2/6N6RQfpLfayL7IJpQ
         havNgPzlUr9m6q5d+yzOOg1o0Hrhp7KgGQZdlq/TyeddVm29hKBqpQ6xPuRy1ttoT57x
         QNO7MN5mnQu+ScM0I8ND1+iD5IYj80BUY4nYOx1qr2p3JfW0gbk5kdERx7dqwTlnBhkD
         cRYA==
X-Gm-Message-State: APjAAAUczD1LK7mhDWHIR0S9QucNEFAsIngbqsHL7S+p5CXnv9HPtDMC
        pCDQ8A8us4v2MaMFBN/CACaCUViziN/sdh+e+vYRyO2Ks+wm
X-Google-Smtp-Source: APXvYqzgWJktcUTZbH6cKyWqv3rGaKB1JpQ4hsrh5P8wA7hj6vizCCqdktv+p9IPWRzvr17NCjAnrp/HCKHRLXvUn58jvn2BuUIZ
MIME-Version: 1.0
X-Received: by 2002:a6b:e90b:: with SMTP id u11mr12564454iof.14.1575269108510;
 Sun, 01 Dec 2019 22:45:08 -0800 (PST)
Date:   Sun, 01 Dec 2019 22:45:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a376820598b2eb97@google.com>
Subject: kernel BUG at fs/pipe.c:LINE!
From:   syzbot <syzbot+d37abaade33a934f16f2@syzkaller.appspotmail.com>
To:     amit@kernel.org, arnd@arndb.de, dhowells@redhat.com,
        gregkh@linuxfoundation.org, jannh@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        virtualization@lists.linux-foundation.org, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1387ab12e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
dashboard link: https://syzkaller.appspot.com/bug?extid=d37abaade33a934f16f2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12945c41e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161e202ee00000

The bug was bisected to:

commit 8cefc107ca54c8b06438b7dc9cc08bc0a11d5b98
Author: David Howells <dhowells@redhat.com>
Date:   Fri Nov 15 13:30:32 2019 +0000

     pipe: Use head and tail pointers for the ring, not cursor and length

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=118cce96e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=138cce96e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=158cce96e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d37abaade33a934f16f2@syzkaller.appspotmail.com
Fixes: 8cefc107ca54 ("pipe: Use head and tail pointers for the ring, not  
cursor and length")

------------[ cut here ]------------
kernel BUG at fs/pipe.c:582!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9433 Comm: syz-executor802 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:pipe_poll+0x37f/0x400 fs/pipe.c:582
Code: ff 85 db 75 09 e8 b1 ee b5 ff 41 83 ce 08 e8 a8 ee b5 ff 44 89 f0 48  
83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 91 ee b5 ff <0f> 0b e8 ca 40  
f3 ff e9 ed fc ff ff e8 c0 40 f3 ff e9 b3 fd ff ff
RSP: 0018:ffff888093e3f698 EFLAGS: 00010293
RAX: ffff8880a96083c0 RBX: ffff88809af6e800 RCX: ffffffff81beed8a
RDX: 0000000000000000 RSI: ffffffff81beefaf RDI: 0000000000000004
RBP: ffff888093e3f6d0 R08: ffff8880a96083c0 R09: ffff8880a9608c50
R10: fffffbfff146e220 R11: ffffffff8a371107 R12: ffff88809c770d40
R13: 00000000fffffffa R14: 0000000000000010 R15: 00000000000001f6
FS:  00007fc5aa3cb700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020200000 CR3: 000000009b5a1000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  vfs_poll include/linux/poll.h:90 [inline]
  do_select+0x922/0x16f0 fs/select.c:534
  core_sys_select+0x53c/0x8c0 fs/select.c:677
  do_pselect.constprop.0+0x199/0x1e0 fs/select.c:759
  __do_sys_pselect6 fs/select.c:784 [inline]
  __se_sys_pselect6 fs/select.c:769 [inline]
  __x64_sys_pselect6+0x1fc/0x2e0 fs/select.c:769
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44a629
Code: e8 5c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b cc fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fc5aa3cada8 EFLAGS: 00000246 ORIG_RAX: 000000000000010e
RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 000000000044a629
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000040
RBP: 00000000006dbc30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000140 R11: 0000000000000246 R12: 00000000006dbc3c
R13: 00007fffcaf6d1bf R14: 00007fc5aa3cb9c0 R15: 20c49ba5e353f7cf
Modules linked in:
---[ end trace 1c441dd64ff48137 ]---
RIP: 0010:pipe_poll+0x37f/0x400 fs/pipe.c:582
Code: ff 85 db 75 09 e8 b1 ee b5 ff 41 83 ce 08 e8 a8 ee b5 ff 44 89 f0 48  
83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 91 ee b5 ff <0f> 0b e8 ca 40  
f3 ff e9 ed fc ff ff e8 c0 40 f3 ff e9 b3 fd ff ff
RSP: 0018:ffff888093e3f698 EFLAGS: 00010293
RAX: ffff8880a96083c0 RBX: ffff88809af6e800 RCX: ffffffff81beed8a
RDX: 0000000000000000 RSI: ffffffff81beefaf RDI: 0000000000000004
RBP: ffff888093e3f6d0 R08: ffff8880a96083c0 R09: ffff8880a9608c50
R10: fffffbfff146e220 R11: ffffffff8a371107 R12: ffff88809c770d40
R13: 00000000fffffffa R14: 0000000000000010 R15: 00000000000001f6
FS:  00007fc5aa3cb700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020200000 CR3: 000000009b5a1000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
