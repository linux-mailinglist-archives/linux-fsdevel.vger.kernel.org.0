Return-Path: <linux-fsdevel+bounces-66354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58793C1CA90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 19:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DD714E2270
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C594E355022;
	Wed, 29 Oct 2025 17:59:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615535470C
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760772; cv=none; b=TuQf8/pxxonh/KGnWfe3wqLQ8osTTl/f3HrZ8ApxVBzv3T3T7UEsArhc+Tp8pQ7BIQlDjmpyCr0Y7qikdU1vlcyJjme4A5Ws4Es9NAESkGzrqT4AJ9BXouAat3jWmPx6iencSTnI/t7sjHTnCZx8bheTL92khNCFYDB61AQJQ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760772; c=relaxed/simple;
	bh=Ol4R7q45Dof5qeZblWAc9NcOphWskOxj+hFs+8GzIfY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fr59+XXsCZiU6oONO5Juf7V+pGNrZN41XDt3tpRUoUV/YnALvbACQ58k1QyIzTWjdI1kzvUim0ugZz5Q6J5a8qkhS1EuVeWoBSj9wzaoTzttIUoR28j6j/ux/HRj3cY6gKXb91r4cCdGN4Akg493R7Xn9In6ogLwkIfaC/GLmAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-432fb58f876so1695935ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 10:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761760767; x=1762365567;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0mfO4AUVtUNaslHQlnN9Noi7qHI+LCieT2isRfktoA=;
        b=muvfyk3pKdUa1I3luKPpT3UWZYRwjmTAiGCccUO5TGcr/YM9VDPn2AKA2R9odce0kX
         ak2EQpoF7iPHAhaSrY3H6/NX/q7ge8BHL/7V7bffhs5aF6GuczMfMCAYJuYJlFJrxES2
         /vHmegfrkwVpevaFCJxVZX1PcCd2/8JyzVxbuXpsreuxtduTSvvY5CbFfdWzD1kpQt1q
         jd1tk1t0x+lHOWcY7jFn35aZuVAv3Q6NPrBiJq1na3clYc8JVNEKJz/RC8M1Mie3EP71
         NNZaCVJ3VvKxSdwJFNNjySbgTuaD4WEb9pDtiTwZwjmQ+4dXxOrTK0Ssp+UWcWezJU9X
         zlmw==
X-Forwarded-Encrypted: i=1; AJvYcCWCHW9EEqXSNISjqd24DryAOLvkxMxXDaikBOWB8LztXC2I2/0jb5AjVT0U8AiggyWXuxU0z/R0zOYX0lo5@vger.kernel.org
X-Gm-Message-State: AOJu0YxxiKGKs6z5ZSuLngMuLtTXVQfRNKTR0R5XtEZBtd0NUdo2go6H
	q1ozKo9tgDj+TZVnwWsxp2NW2Ejn+fduqZ0vn3GY4YNR4CkSbFGpKPEDZraTSfkffmrapNJBX+v
	guXsLfRBZkVBXzfYyYgM+zTCqip97hEDVLoY4Lanpa6jaYESn/+C2YBEHQwE=
X-Google-Smtp-Source: AGHT+IHWHTapYXwG+QZsDG9gOligy56lMRNZxNzacUMpU0A/f+8QUABCo3xjrySms6k9ScgYzR4O69cW2l8fDAIkmC2lkrykLPyM
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1609:b0:42d:b5d0:1930 with SMTP id
 e9e14a558f8ab-4330154fb44mr4660275ab.23.1761760767655; Wed, 29 Oct 2025
 10:59:27 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:59:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690255ff.050a0220.32483.0218.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in filemap_fault (3)
From: syzbot <syzbot+85cfa48c1a69a20ba5ed@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    72761a7e3122 Merge tag 'driver-core-6.18-rc3' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10241e7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd5b960ad8a33100
dashboard link: https://syzkaller.appspot.com/bug?extid=85cfa48c1a69a20ba5ed
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7340e06c0904/disk-72761a7e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0391e601c303/vmlinux-72761a7e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7744957ba534/bzImage-72761a7e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+85cfa48c1a69a20ba5ed@syzkaller.appspotmail.com

 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
page last free pid 50 tgid 50 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 free_unref_folios+0xdb3/0x14f0 mm/page_alloc.c:2963
 folios_put_refs+0x584/0x670 mm/swap.c:1002
 release_pages+0x4b4/0x520 mm/swap.c:1042
 io_free_region+0xb4/0x270 io_uring/memmap.c:102
 io_rings_free io_uring/io_uring.c:2770 [inline]
 io_ring_ctx_free+0x287/0x4e0 io_uring/io_uring.c:2864
 io_ring_exit_work+0x8c4/0x930 io_uring/io_uring.c:3086
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
------------[ cut here ]------------
kernel BUG at mm/filemap.c:3519!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 9010 Comm: syz.1.736 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:filemap_fault+0x122c/0x12b0 mm/filemap.c:3519
Code: 38 c1 0f 8c 8e fc ff ff 4c 89 e7 e8 8e d8 2c 00 e9 81 fc ff ff e8 94 23 c7 ff 48 89 df 48 c7 c6 60 5b 74 8b e8 b5 0d 2f ff 90 <0f> 0b e8 7d 23 c7 ff 48 8b 3c 24 48 c7 c6 e0 61 74 8b e8 9d 0d 2f
RSP: 0018:ffffc9000ef37a60 EFLAGS: 00010246
RAX: 50465a4911af7d00 RBX: ffffea00012c8500 RCX: 50465a4911af7d00
RDX: 0000000000000000 RSI: ffffffff8d8f29fa RDI: ffff88801fba5ac0
RBP: ffffc9000ef37b98 R08: ffff8880b8924293 R09: 1ffff11017124852
R10: dffffc0000000000 R11: ffffed1017124853 R12: dffffc0000000000
R13: 1ffffd40002590a1 R14: ffffea00012c8518 R15: ffffea00012c8508
FS:  0000000000000000(0000) GS:ffff88812623e000(0063) knlGS:000000005671e440
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000080000000 CR3: 00000000301ae000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __do_fault+0x138/0x390 mm/memory.c:5280
 do_shared_fault mm/memory.c:5762 [inline]
 do_fault mm/memory.c:5836 [inline]
 do_pte_missing mm/memory.c:4361 [inline]
 handle_pte_fault mm/memory.c:6177 [inline]
 __handle_mm_fault+0x1847/0x5400 mm/memory.c:6318
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6487
 do_user_addr_fault+0xa7c/0x1380 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x82/0x100 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0023:0xf704df88
Code: f8 09 f0 74 1d 89 f0 83 f0 01 09 f8 0f 85 3c 02 00 00 8b 44 24 20 0f c8 89 44 24 20 31 c0 89 44 24 24 8b 44 24 1c 8b 4c 24 20 <89> 08 e9 39 fb ff ff 0f b6 4c 24 08 8b 5c 24 28 89 cf c1 ef 05 83
RSP: 002b:00000000f750fa70 EFLAGS: 00010246
RAX: 0000000080000000 RBX: 0000000000000000 RCX: 0000000000000007
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000f750fd98 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:filemap_fault+0x122c/0x12b0 mm/filemap.c:3519
Code: 38 c1 0f 8c 8e fc ff ff 4c 89 e7 e8 8e d8 2c 00 e9 81 fc ff ff e8 94 23 c7 ff 48 89 df 48 c7 c6 60 5b 74 8b e8 b5 0d 2f ff 90 <0f> 0b e8 7d 23 c7 ff 48 8b 3c 24 48 c7 c6 e0 61 74 8b e8 9d 0d 2f
RSP: 0018:ffffc9000ef37a60 EFLAGS: 00010246
RAX: 50465a4911af7d00 RBX: ffffea00012c8500 RCX: 50465a4911af7d00
RDX: 0000000000000000 RSI: ffffffff8d8f29fa RDI: ffff88801fba5ac0
RBP: ffffc9000ef37b98 R08: ffff8880b8924293 R09: 1ffff11017124852
R10: dffffc0000000000 R11: ffffed1017124853 R12: dffffc0000000000
R13: 1ffffd40002590a1 R14: ffffea00012c8518 R15: ffffea00012c8508
FS:  0000000000000000(0000) GS:ffff88812623e000(0063) knlGS:000000005671e440
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000080000000 CR3: 00000000301ae000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	f8                   	clc
   1:	09 f0                	or     %esi,%eax
   3:	74 1d                	je     0x22
   5:	89 f0                	mov    %esi,%eax
   7:	83 f0 01             	xor    $0x1,%eax
   a:	09 f8                	or     %edi,%eax
   c:	0f 85 3c 02 00 00    	jne    0x24e
  12:	8b 44 24 20          	mov    0x20(%rsp),%eax
  16:	0f c8                	bswap  %eax
  18:	89 44 24 20          	mov    %eax,0x20(%rsp)
  1c:	31 c0                	xor    %eax,%eax
  1e:	89 44 24 24          	mov    %eax,0x24(%rsp)
  22:	8b 44 24 1c          	mov    0x1c(%rsp),%eax
  26:	8b 4c 24 20          	mov    0x20(%rsp),%ecx
* 2a:	89 08                	mov    %ecx,(%rax) <-- trapping instruction
  2c:	e9 39 fb ff ff       	jmp    0xfffffb6a
  31:	0f b6 4c 24 08       	movzbl 0x8(%rsp),%ecx
  36:	8b 5c 24 28          	mov    0x28(%rsp),%ebx
  3a:	89 cf                	mov    %ecx,%edi
  3c:	c1 ef 05             	shr    $0x5,%edi
  3f:	83                   	.byte 0x83


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

