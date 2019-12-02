Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B57610E616
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 07:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfLBGpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 01:45:09 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:43798 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfLBGpJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 01:45:09 -0500
Received: by mail-il1-f199.google.com with SMTP id m67so7293444ill.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Dec 2019 22:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=T6F075c2AlO7kBdIl91BZLO/CgKYWJ1O7qBf3Ha1UWA=;
        b=amskhu7A7Nr061kMumhWsfn9KH7G3ydO0e1kolBDDUM+zyDPPQ9QUkiOa4C9Eq3rqr
         MR3N5g15SJ+KXWAt2XCSvaqZxUioX2eef/HYsTgYZBH2CjB1HS1jKo+Mbx6Q+22RxNGi
         il9YNCgH+uTtePQehgdkxJupfkUAD+hvl0wMzW6r8aAPj0Jtub2dEUk7Zot+wb6veePU
         D+xshzLR3zghcdXcEI0MCr5deTpyCV7hgs+YVCbH/S1D23NkkZw6GqS61lnHniLdSNhu
         Bx1R9mbyj112gCtgBOGb+kKYtI5+UPjQ5CR/p8HSfg3HjrQG4Pic+VGpXtTmuL/gj/xY
         OPWg==
X-Gm-Message-State: APjAAAWkRpB15j49x/u0BJsUZ1pTqEllTmOTBkhQkvCgpSzRbBJx0Bzl
        F6ONxdfW0AuEhcJF4JwtqrJWFo1iAmuuFqPFl7HCsgtpM+n+
X-Google-Smtp-Source: APXvYqw0QJ56YYxYAqgJf5iwMd/9ToZM16u0ZTFXZ72SR0m98bQ8IRzgsJlla2LIj04ktpigr9Mn+9MyxDA/gcZ97ZGXzXR48E9M
MIME-Version: 1.0
X-Received: by 2002:a92:79d2:: with SMTP id u201mr67821204ilc.103.1575269108688;
 Sun, 01 Dec 2019 22:45:08 -0800 (PST)
Date:   Sun, 01 Dec 2019 22:45:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6324b0598b2eb59@google.com>
Subject: KASAN: slab-out-of-bounds Write in pipe_write
From:   syzbot <syzbot+838eb0878ffd51f27c41@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=106a34a2e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
dashboard link: https://syzkaller.appspot.com/bug?extid=838eb0878ffd51f27c41
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146a9f86e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1791d82ae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+838eb0878ffd51f27c41@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in pipe_write+0xe30/0x1000 fs/pipe.c:488
Write of size 8 at addr ffff8880a8399228 by task syz-executor795/9550

CPU: 1 PID: 9550 Comm: syz-executor795 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:634
  __asan_report_store8_noabort+0x17/0x20 mm/kasan/generic_report.c:137
  pipe_write+0xe30/0x1000 fs/pipe.c:488
  call_write_iter include/linux/fs.h:1895 [inline]
  new_sync_write+0x4d3/0x770 fs/read_write.c:483
  __vfs_write+0xe1/0x110 fs/read_write.c:496
  vfs_write+0x268/0x5d0 fs/read_write.c:558
  ksys_write+0x220/0x290 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4466c9
Code: e8 5c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fbd2a7abdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 00000000004466c9
RDX: 00000000fffffef3 RSI: 00000000200001c0 RDI: 0000000000000004
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffc2fcd0f6f R14: 00007fbd2a7ac9c0 R15: 20c49ba5e353f7cf

Allocated by task 9552:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:510 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:483
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:524
  __do_kmalloc mm/slab.c:3655 [inline]
  __kmalloc+0x163/0x770 mm/slab.c:3664
  kmalloc_array include/linux/slab.h:618 [inline]
  kcalloc include/linux/slab.h:629 [inline]
  pipe_set_size fs/pipe.c:1143 [inline]
  pipe_fcntl+0x3f7/0x8e0 fs/pipe.c:1209
  do_fcntl+0x255/0x1030 fs/fcntl.c:417
  __do_sys_fcntl fs/fcntl.c:463 [inline]
  __se_sys_fcntl fs/fcntl.c:448 [inline]
  __x64_sys_fcntl+0x16d/0x1e0 fs/fcntl.c:448
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8880a8399200
  which belongs to the cache kmalloc-64 of size 64
The buggy address is located 40 bytes inside of
  64-byte region [ffff8880a8399200, ffff8880a8399240)
The buggy address belongs to the page:
page:ffffea0002a0e640 refcount:1 mapcount:0 mapping:ffff8880aa400380  
index:0x0
raw: 00fffe0000000200 ffffea0002752548 ffffea00029d3648 ffff8880aa400380
raw: 0000000000000000 ffff8880a8399000 0000000100000020 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a8399100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a8399180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8880a8399200: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
                                   ^
  ffff8880a8399280: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8880a8399300: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
