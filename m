Return-Path: <linux-fsdevel+bounces-6899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBF881DE1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 05:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B6D1F21458
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 04:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B70E110B;
	Mon, 25 Dec 2023 04:44:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732A1EC5
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Dec 2023 04:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fcbe27a7fso40673515ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 20:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703479457; x=1704084257;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zHAHAys+JUJZvJw3AwM1+L/Jwh91xc407CsAuZW1dK4=;
        b=n6vKqGYNogrbSU92KA8HAgS/ftZn46P5P80ozSYy4SKjSGZ9+yMhTU4D3muyixeLz3
         e2vWvl7YfE10akEierS7Uhgi3eljTJt/Rp2rFadv3GzRyEgjdmf2JMN8xE7lY6LqwQly
         ILhnA0SDsn3T5ASLQBoPENxQwz1Kdbr76nzSbD/uE/fQKW8nnp6DiXZ1TivJtobD5Vho
         0TNG5SBWV+NI9DCE+y+0C6cgGy3/u+laJA0HGuYMkqmDFa1AnDKmq1IjhXpaNtVu3/uY
         q09OPAt2TrUdzxVbRA4d5Rzv7aiyC1ZDFkaYqIJpxR7FrIWGULrZj9gmFh80crqk2QHC
         shhA==
X-Gm-Message-State: AOJu0YytSq57lVNGn0EbqvSHFieimqmo3JhKDZtK2Iqc3+05TAODTG39
	yl+snn+lt2nH1xXY8VjOFrVrE6vTfYqP3dBng/vshCzZmkN2DhM=
X-Google-Smtp-Source: AGHT+IGSKiHB+b5xavYA26vEqNBlSY9KQgLm84ifjVN+qAx5+aRCggqtsVminwlLB1La0DeG5bb6Bcg2sx9nyJLFXdwVY09Znv9a
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c243:0:b0:35f:e976:3283 with SMTP id
 k3-20020a92c243000000b0035fe9763283mr501174ilo.2.1703479457679; Sun, 24 Dec
 2023 20:44:17 -0800 (PST)
Date: Sun, 24 Dec 2023 20:44:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f52642060d4e3750@google.com>
Subject: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer dereference
 in do_pagemap_scan
From: syzbot <syzbot+f9238a0a31f9b5603fef@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    861deac3b092 Linux 6.7-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12bf6e26e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=298e57794135adf0
dashboard link: https://syzkaller.appspot.com/bug?extid=f9238a0a31f9b5603fef
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f4fc81e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15997e81e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b1f4e427f08b/disk-861deac3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/81317757e796/vmlinux-861deac3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f9d2dcfac209/bzImage-861deac3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f9238a0a31f9b5603fef@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc00000000fe: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000007f0-0x00000000000007f7]
CPU: 0 PID: 5068 Comm: syz-executor316 Not tainted 6.7.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:mm_has_notifiers include/linux/mmu_notifier.h:282 [inline]
RIP: 0010:mmu_notifier_invalidate_range_start include/linux/mmu_notifier.h:455 [inline]
RIP: 0010:do_pagemap_scan+0xa89/0xcd0 fs/proc/task_mmu.c:2438
Code: 8d 41 b8 01 00 00 00 e8 c5 0b 57 ff 48 8b 5c 24 78 58 48 b8 00 00 00 00 00 fc ff df 48 8d bb f0 07 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 f8 01 00 00 48 83 bb f0 07 00 00 00 0f 85 1d 01
RSP: 0018:ffffc9000425fcf0 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8167148e
RDX: 00000000000000fe RSI: ffffffff8accb1a0 RDI: 00000000000007f0
RBP: 0000000020ffc000 R08: 0000000000000000 R09: fffffbfff23e37d2
R10: ffffffff91f1be97 R11: 0000000000000000 R12: 000000000000230e
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
FS:  00005555564df380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 00000000740db000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 do_pagemap_cmd+0x5e/0x80 fs/proc/task_mmu.c:2494
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f0993b4dbf9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe8cc5b718 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0993b4dbf9
RDX: 0000000020000180 RSI: 00000000c0606610 RDI: 0000000000000004
RBP: 00007f0993bc05f0 R08: 00007ffe8cc5b3c4 R09: 0000000000000006
R10: 0000000000000014 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mm_has_notifiers include/linux/mmu_notifier.h:282 [inline]
RIP: 0010:mmu_notifier_invalidate_range_start include/linux/mmu_notifier.h:455 [inline]
RIP: 0010:do_pagemap_scan+0xa89/0xcd0 fs/proc/task_mmu.c:2438
Code: 8d 41 b8 01 00 00 00 e8 c5 0b 57 ff 48 8b 5c 24 78 58 48 b8 00 00 00 00 00 fc ff df 48 8d bb f0 07 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 f8 01 00 00 48 83 bb f0 07 00 00 00 0f 85 1d 01
RSP: 0018:ffffc9000425fcf0 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8167148e
RDX: 00000000000000fe RSI: ffffffff8accb1a0 RDI: 00000000000007f0
RBP: 0000000020ffc000 R08: 0000000000000000 R09: fffffbfff23e37d2
R10: ffffffff91f1be97 R11: 0000000000000000 R12: 000000000000230e
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
FS:  00005555564df380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0993b80b00 CR3: 00000000740db000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	8d 41 b8             	lea    -0x48(%rcx),%eax
   3:	01 00                	add    %eax,(%rax)
   5:	00 00                	add    %al,(%rax)
   7:	e8 c5 0b 57 ff       	call   0xff570bd1
   c:	48 8b 5c 24 78       	mov    0x78(%rsp),%rbx
  11:	58                   	pop    %rax
  12:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  19:	fc ff df
  1c:	48 8d bb f0 07 00 00 	lea    0x7f0(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 f8 01 00 00    	jne    0x22c
  34:	48 83 bb f0 07 00 00 	cmpq   $0x0,0x7f0(%rbx)
  3b:	00
  3c:	0f                   	.byte 0xf
  3d:	85                   	.byte 0x85
  3e:	1d                   	.byte 0x1d
  3f:	01                   	.byte 0x1


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

