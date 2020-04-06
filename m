Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25ED119EF72
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 05:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgDFDGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Apr 2020 23:06:14 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:38429 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgDFDGO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Apr 2020 23:06:14 -0400
Received: by mail-il1-f197.google.com with SMTP id b6so13874993iln.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Apr 2020 20:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VMyBQZO3MBfpsL5ANLi1r3ItqnA3iEERo2V/J0TmPfY=;
        b=dzVj0Qx8hEzpDDz4rSq/3d9g8q3Wxg8iKbTvXflue9ORtfRIsl6Mh3hz3fupkOAcEm
         97qMxOm3f+Ea71LOeyQtrKkj6zo5OQxuNWZdmN7uTVfDrvBytto3UAoMj97pCLuVF+0w
         +h8WA0ELJqvatR7JhvOJ00HM3MREz/feIFM3AWdMHL7hLmciguA+4Ysob4RDAUviZBAF
         INHjkxHFuA6nQiQGEZctm+EhgKVPf/koCxg8ifIcrWJVTayNNX1as1LQxlh1FNccfoC9
         QFrJCzeyGW+uzvRkOwGA9RovZAYoRsob3raVJ4dR6jGs5qFkIOUpnDqL6Vcwv5oDnSz2
         Ax/w==
X-Gm-Message-State: AGi0PuYlmhiSysblIVDoIYTx3FSrj04yWfwgv0QUkguvx9Su76LMmgFp
        ZqJecnfqTWrcjmGsC7+vOI+gKeOc+EBwwzlY87MpAxVDtavk
X-Google-Smtp-Source: APiQypIjLBv995v9Q6nngDvUzGI4SQF2mUpR1Cp8F7w6q8j5tX2m6Fy9bWbm94gXVesQIxpb3IH/1k2OJDuVocLSsrgxKtYxahfV
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d6:: with SMTP id w22mr13033959jao.72.1586142372978;
 Sun, 05 Apr 2020 20:06:12 -0700 (PDT)
Date:   Sun, 05 Apr 2020 20:06:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4684e05a2968ca6@google.com>
Subject: kernel BUG at mm/hugetlb.c:LINE!
From:   syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1a323ea5 x86: get rid of 'errret' argument to __get_user_x..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132e940be00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c1e98458335a7d1
dashboard link: https://syzkaller.appspot.com/bug?extid=d6ec23007e951dadf3de
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12921933e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172e940be00000

The bug was bisected to:

commit e950564b97fd0f541b02eb207685d0746f5ecf29
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Tue Jul 24 13:01:55 2018 +0000

    vfs: don't evict uninitialized inode

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=115cad33e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=135cad33e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=155cad33e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com
Fixes: e950564b97fd ("vfs: don't evict uninitialized inode")

overlayfs: upper fs does not support xattr, falling back to index=off and metacopy=off.
------------[ cut here ]------------
kernel BUG at mm/hugetlb.c:3416!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7036 Comm: syz-executor110 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__unmap_hugepage_range+0xa26/0xbc0 mm/hugetlb.c:3416
Code: 00 48 c7 c7 60 37 35 88 e8 57 b4 a2 ff e9 b3 fd ff ff e8 cd 90 c6 ff 0f 0b e9 c4 f7 ff ff e8 c1 90 c6 ff 0f 0b e8 ba 90 c6 ff <0f> 0b e8 b3 90 c6 ff 83 8c 24 c0 00 00 00 01 48 8d bc 24 a0 00 00
RSP: 0018:ffffc900017779b0 EFLAGS: 00010293
RAX: ffff88808cf5c2c0 RBX: ffffffff8c641c08 RCX: ffffffff81ac50b4
RDX: 0000000000000000 RSI: ffffffff81ac58a6 RDI: 0000000000000007
RBP: 0000000020000000 R08: ffff88808cf5c2c0 R09: ffffed10129d8111
R10: ffffed10129d8110 R11: ffff888094ec0887 R12: 0000000000003000
R13: 0000000000000000 R14: 0000000020003000 R15: 0000000000200000
FS:  00000000013c0880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000140 CR3: 0000000093554000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __unmap_hugepage_range_final+0x30/0x70 mm/hugetlb.c:3507
 unmap_single_vma+0x238/0x300 mm/memory.c:1296
 unmap_vmas+0x16f/0x2f0 mm/memory.c:1332
 exit_mmap+0x2aa/0x510 mm/mmap.c:3126
 __mmput kernel/fork.c:1082 [inline]
 mmput+0x168/0x4b0 kernel/fork.c:1103
 exit_mm kernel/exit.c:477 [inline]
 do_exit+0xa51/0x2dd0 kernel/exit.c:780
 do_group_exit+0x125/0x340 kernel/exit.c:891
 __do_sys_exit_group kernel/exit.c:902 [inline]
 __se_sys_exit_group kernel/exit.c:900 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:900
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x43efe8
Code: Bad RIP value.
RSP: 002b:00007ffdfe6c00f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043efe8
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004be7e8 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000040000000011 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d0180 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 2d36245d65cb52f7 ]---
RIP: 0010:__unmap_hugepage_range+0xa26/0xbc0 mm/hugetlb.c:3416
Code: 00 48 c7 c7 60 37 35 88 e8 57 b4 a2 ff e9 b3 fd ff ff e8 cd 90 c6 ff 0f 0b e9 c4 f7 ff ff e8 c1 90 c6 ff 0f 0b e8 ba 90 c6 ff <0f> 0b e8 b3 90 c6 ff 83 8c 24 c0 00 00 00 01 48 8d bc 24 a0 00 00
RSP: 0018:ffffc900017779b0 EFLAGS: 00010293
RAX: ffff88808cf5c2c0 RBX: ffffffff8c641c08 RCX: ffffffff81ac50b4
RDX: 0000000000000000 RSI: ffffffff81ac58a6 RDI: 0000000000000007
RBP: 0000000020000000 R08: ffff88808cf5c2c0 R09: ffffed10129d8111
R10: ffffed10129d8110 R11: ffff888094ec0887 R12: 0000000000003000
R13: 0000000000000000 R14: 0000000020003000 R15: 0000000000200000
FS:  00000000013c0880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8cc24dd000 CR3: 0000000093554000 CR4: 00000000001406f0
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
