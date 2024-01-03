Return-Path: <linux-fsdevel+bounces-7263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE07823739
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD8F1F25AA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 21:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1921DA2A;
	Wed,  3 Jan 2024 21:41:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD31D6BC
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ba9fee55d4so1313981539f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 13:41:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704318091; x=1704922891;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/yml0s6lmW4zSt4ZKe2pWtb63/KX/2nbthztY9BlZE=;
        b=BYB0IHWawbbnOX/qu97JujAZ+GWDMX/PytLzIoBOiAFxZYbBQqSLr4J26J5YGymyAx
         nIAICN3xM2Spzx5D2Zu6JoupwPVJMDudBhJkwuc286PqS6CgLcInsR9YRJwVwF4D4p+D
         1Fc5s7/TiNMHit2xVHgoI6MOreKPfSTn5SAWRSwnaZYKd4ZM7KT+wPtbujWqUHnF7AuV
         wCsuldTT0bI3ghc6psSJWU+8yGA+mWw5uXq0MdYXZfyENdfaCQ8PU1gDFFaFtfQDnBbh
         quB52LVJEuvDJMRr9mC87nq8eOkSMg275fPD/UzL/N6G7Nq7kw/RBWjpjwMPTVUe3Qf2
         NS5A==
X-Gm-Message-State: AOJu0Yxa+K/OJ1FqHfr1QLNa5ywfsahskhJ8R0XCZ8VzS2px7k0NSysl
	5slKChKSxH1NK7ULwnryne42RoSJvhhLxqHaYA1qdW1rQ5FJgKw=
X-Google-Smtp-Source: AGHT+IFjc5O6Fkw7tLOq8W4PyeIPJSZlqEKRHvH8ftfIDiwc/w6nI+CK7lg9z5rZPvHOdloSc+JYiRGYjGpVMLEXXX5J3HbqdDL0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4bc4:b0:46d:d3dc:2505 with SMTP id
 dk4-20020a0566384bc400b0046dd3dc2505mr45503jab.3.1704318091389; Wed, 03 Jan
 2024 13:41:31 -0800 (PST)
Date: Wed, 03 Jan 2024 13:41:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006bf22a060e117a8d@google.com>
Subject: [syzbot] [fs?] [trace?] BUG: unable to handle kernel paging request
 in tracefs_apply_options
From: syzbot <syzbot+f8a023e0c6beabe2371a@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    453f5db0619e Merge tag 'trace-v6.7-rc7' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10ec3829e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
dashboard link: https://syzkaller.appspot.com/bug?extid=f8a023e0c6beabe2371a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1414af31e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e52409e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/38b92a7149e8/disk-453f5db0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4f872267133f/vmlinux-453f5db0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/587572061791/bzImage-453f5db0.xz

The issue was bisected to:

commit 7e8358edf503e87236c8d07f69ef0ed846dd5112
Author: Steven Rostedt (Google) <rostedt@goodmis.org>
Date:   Fri Dec 22 00:07:57 2023 +0000

    eventfs: Fix file and directory uid and gid ownership

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108cd519e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=128cd519e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=148cd519e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8a023e0c6beabe2371a@syzkaller.appspotmail.com
Fixes: 7e8358edf503 ("eventfs: Fix file and directory uid and gid ownership")

BUG: unable to handle page fault for address: fffffffffffffff0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD d734067 P4D d734067 PUD d736067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5056 Comm: syz-executor170 Not tainted 6.7.0-rc7-syzkaller-00049-g453f5db0619e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:set_gid fs/tracefs/inode.c:224 [inline]
RIP: 0010:tracefs_apply_options+0x4d0/0xa40 fs/tracefs/inode.c:337
Code: 24 10 49 8b 1e 48 83 c3 f0 74 3d 48 89 d8 48 c1 e8 03 48 bd 00 00 00 00 00 fc ff df 80 3c 28 00 74 08 48 89 df e8 70 ff 88 fe <48> 8b 1b 48 89 de 48 83 e6 02 31 ff e8 bf fe 2c fe 48 83 e3 02 75
RSP: 0018:ffffc900040ffca8 EFLAGS: 00010246
RAX: 1ffffffffffffffe RBX: fffffffffffffff0 RCX: ffff888014bf5940
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffc900040ffc20
RBP: dffffc0000000000 R08: 0000000000000003 R09: fffff5200081ff84
R10: dffffc0000000000 R11: fffff5200081ff84 R12: ffff88801d743888
R13: ffff88801b0c3710 R14: ffff88801d7437e8 R15: ffff88801d743810
FS:  00005555557dd480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff0 CR3: 000000001ec48000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tracefs_remount+0x78/0x80 fs/tracefs/inode.c:353
 reconfigure_super+0x440/0x870 fs/super.c:1143
 do_remount fs/namespace.c:2884 [inline]
 path_mount+0xc24/0xfa0 fs/namespace.c:3656
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3863
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fec326e8d99
Code: 48 83 c4 28 c3 e8 67 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc8103ddf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc8103de00 RCX: 00007fec326e8d99
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000000
RBP: 00007ffc8103de08 R08: 0000000020000140 R09: 00007fec326b5b80
R10: 0000000002200022 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc8103e068 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
CR2: fffffffffffffff0
---[ end trace 0000000000000000 ]---
RIP: 0010:set_gid fs/tracefs/inode.c:224 [inline]
RIP: 0010:tracefs_apply_options+0x4d0/0xa40 fs/tracefs/inode.c:337
Code: 24 10 49 8b 1e 48 83 c3 f0 74 3d 48 89 d8 48 c1 e8 03 48 bd 00 00 00 00 00 fc ff df 80 3c 28 00 74 08 48 89 df e8 70 ff 88 fe <48> 8b 1b 48 89 de 48 83 e6 02 31 ff e8 bf fe 2c fe 48 83 e3 02 75
RSP: 0018:ffffc900040ffca8 EFLAGS: 00010246
RAX: 1ffffffffffffffe RBX: fffffffffffffff0 RCX: ffff888014bf5940
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffc900040ffc20
RBP: dffffc0000000000 R08: 0000000000000003 R09: fffff5200081ff84
R10: dffffc0000000000 R11: fffff5200081ff84 R12: ffff88801d743888
R13: ffff88801b0c3710 R14: ffff88801d7437e8 R15: ffff88801d743810
FS:  00005555557dd480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff0 CR3: 000000001ec48000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	24 10                	and    $0x10,%al
   2:	49 8b 1e             	mov    (%r14),%rbx
   5:	48 83 c3 f0          	add    $0xfffffffffffffff0,%rbx
   9:	74 3d                	je     0x48
   b:	48 89 d8             	mov    %rbx,%rax
   e:	48 c1 e8 03          	shr    $0x3,%rax
  12:	48 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbp
  19:	fc ff df
  1c:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
  20:	74 08                	je     0x2a
  22:	48 89 df             	mov    %rbx,%rdi
  25:	e8 70 ff 88 fe       	call   0xfe88ff9a
* 2a:	48 8b 1b             	mov    (%rbx),%rbx <-- trapping instruction
  2d:	48 89 de             	mov    %rbx,%rsi
  30:	48 83 e6 02          	and    $0x2,%rsi
  34:	31 ff                	xor    %edi,%edi
  36:	e8 bf fe 2c fe       	call   0xfe2cfefa
  3b:	48 83 e3 02          	and    $0x2,%rbx
  3f:	75                   	.byte 0x75


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

