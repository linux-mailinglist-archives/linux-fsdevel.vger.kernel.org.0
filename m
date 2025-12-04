Return-Path: <linux-fsdevel+bounces-70641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DFACA314B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 10:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6116E300BADA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 09:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E93337BA3;
	Thu,  4 Dec 2025 09:49:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1224C230BDF
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764841773; cv=none; b=d7Ss2YiQv9a3Abja2S3nh6LdIjugtCUbX1LBkRL0AUTLVerfzFO3PazoqHo17k/D5U4mgiFYrdPO6cd5B/cxJJX5FEd2AGgImUX5cagOtvDqcCWnhjWCz/lQ89Pjhwue3M/zFMH4g1X/bID3hZAQ+jiKxPO6SVwSzGA7HFexazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764841773; c=relaxed/simple;
	bh=w2EuvL7M8qcsXaA7mq7HY43KhRFgpVzKxzxaXxL+Dn4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WhBQ6vz2efD2GBjfZff6IjXFqyk0x+Vy7oJHuQ4DOE9k7SZRYD2xE1CgGSHQGlIo3VeZdq3WvADEHBOi7X/sjprL/8fnkcnHIkciUNJIxY7Dd0SYtbRzn7uNjeJovrnd6VsDZ+5P5N4hKD8hioeNT62T4Y/V4MKC0Bsg3BsUk/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7c6ce3b9fa0so769247a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 01:49:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764841769; x=1765446569;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=owWvP/T/PddnTdJJSmAeIPDNzdMFBeWkzi/pWhzCSgg=;
        b=ZvGGdj+j/mUpNoRlYCvV2afPa+eJCiPw+SQZymuA4kvAUYCv2cxJMhwlwv+JRsO6F5
         J+m9AU0QFC/tdTwmQxaNkwZJEn9Yv92xzKFFJWaBnuNhfvhk6Fmal9XsBWWWIzJ1DDMA
         w28nvvRSX0T/dIt4CsKgxpAzNgQ6RsetrDteCoyT4fdjBMW0WrHQ0bW6HhX/gPoZu7Gi
         GhTYIRRKkmigm6VpJyJ70oFqhRPxOO+qv+9uw/QPWg5uoy+8JhIyGvJ/Yyu3bHX1OFn/
         tdhsRviR55gCaXefmSa4VwJRX+78xgzvi1keyLM+jP5SRjkcziq+fBtRD/IIMlU6h3gw
         nuhg==
X-Forwarded-Encrypted: i=1; AJvYcCXyGiJeF7PMn5xwzX3u1tL/+K9njRIznYSBz4a5RoNnF9t2zI+btRCxWfLuIAacCp6JE2aOUz0RXJcdIt4g@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7CnXaeqUfcBWp1yCVVTZB6TJHDwTwGkSldihtNsyLpyg/LPAf
	dzbPhaO/W/0SSML6PNPVZE/qxNpMZpSCvtTXtzanHL+HXMvDyqTRu4Jp3FqI40ckNxo3w7XI0JQ
	UR2Q5wFxyfU0jZbNwzshDxjzxVv2kAqDzt8iao/KGubUy8yXVHgqkPtyaKig=
X-Google-Smtp-Source: AGHT+IHNtXP22LZDc/YN2tZgFXBXqFukaiSuqWpONhBuW7/WfbI7BMLZ/uNaI00Ai4CAVKzXSG8p8++zcHbKNco2tJ0jtl4V/Bj8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:124e:b0:451:4c7e:4657 with SMTP id
 5614622812f47-4536e41cf4amr3120710b6e.26.1764841769296; Thu, 04 Dec 2025
 01:49:29 -0800 (PST)
Date: Thu, 04 Dec 2025 01:49:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69315929.a70a0220.2ea503.00d8.GAE@google.com>
Subject: [syzbot] [fs?] general protection fault in fd_install
From: syzbot <syzbot+40f42779048f7476e2e0@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a26e7032d7d Merge tag 'core-bugs-2025-12-01' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15321512580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=553f3db6410d5a82
dashboard link: https://syzkaller.appspot.com/bug?extid=40f42779048f7476e2e0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d76192580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bfb8c2580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4a26e703.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bf3025099b65/vmlinux-4a26e703.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9e022e7e7365/bzImage-4a26e703.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+40f42779048f7476e2e0@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
CPU: 0 UID: 0 PID: 5517 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:fd_install+0x57/0x3d0 fs/file.c:685
Code: 48 81 c3 48 09 00 00 48 89 d8 48 c1 e8 03 80 3c 28 00 74 08 48 89 df e8 c7 4c e6 ff 4c 8b 3b 49 8d 5e 40 48 89 d8 48 c1 e8 03 <0f> b6 04 28 84 c0 0f 85 29 03 00 00 8b 1b 89 de 81 e6 00 00 00 01
RSP: 0018:ffffc9000cb27ca0 EFLAGS: 00010202
RAX: 0000000000000008 RBX: 0000000000000041 RCX: ffff888035b14980
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000006
RBP: dffffc0000000000 R08: ffff88801c0af0e3 R09: 1ffff11003815e1c
R10: dffffc0000000000 R11: ffffed1003815e1d R12: 0000000000000006
R13: 0000000000000006 R14: 0000000000000001 R15: ffff88801f408f00
FS:  000055557b0dc500(0000) GS:ffff88808d6ba000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe4967bb43c CR3: 000000001c158000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 do_mq_open+0x5a0/0x770 ipc/mqueue.c:932
 __do_sys_mq_open ipc/mqueue.c:945 [inline]
 __se_sys_mq_open ipc/mqueue.c:938 [inline]
 __x64_sys_mq_open+0x16a/0x1c0 ipc/mqueue.c:938
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7cfa38f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8f2c3568 EFLAGS: 00000246 ORIG_RAX: 00000000000000f0
RAX: ffffffffffffffda RBX: 00007f7cfa5e5fa0 RCX: 00007f7cfa38f7c9
RDX: 0000000000000110 RSI: 0000000000000040 RDI: 00002000000004c0
RBP: 00007f7cfa413f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7cfa5e5fa0 R14: 00007f7cfa5e5fa0 R15: 0000000000000004
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:fd_install+0x57/0x3d0 fs/file.c:685
Code: 48 81 c3 48 09 00 00 48 89 d8 48 c1 e8 03 80 3c 28 00 74 08 48 89 df e8 c7 4c e6 ff 4c 8b 3b 49 8d 5e 40 48 89 d8 48 c1 e8 03 <0f> b6 04 28 84 c0 0f 85 29 03 00 00 8b 1b 89 de 81 e6 00 00 00 01
RSP: 0018:ffffc9000cb27ca0 EFLAGS: 00010202
RAX: 0000000000000008 RBX: 0000000000000041 RCX: ffff888035b14980
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000006
RBP: dffffc0000000000 R08: ffff88801c0af0e3 R09: 1ffff11003815e1c
R10: dffffc0000000000 R11: ffffed1003815e1d R12: 0000000000000006
R13: 0000000000000006 R14: 0000000000000001 R15: ffff88801f408f00
FS:  000055557b0dc500(0000) GS:ffff88808d6ba000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0a4abe2fe8 CR3: 000000001c158000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	48 81 c3 48 09 00 00 	add    $0x948,%rbx
   7:	48 89 d8             	mov    %rbx,%rax
   a:	48 c1 e8 03          	shr    $0x3,%rax
   e:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 c7 4c e6 ff       	call   0xffe64ce3
  1c:	4c 8b 3b             	mov    (%rbx),%r15
  1f:	49 8d 5e 40          	lea    0x40(%r14),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 04 28          	movzbl (%rax,%rbp,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 29 03 00 00    	jne    0x35f
  36:	8b 1b                	mov    (%rbx),%ebx
  38:	89 de                	mov    %ebx,%esi
  3a:	81 e6 00 00 00 01    	and    $0x1000000,%esi


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

