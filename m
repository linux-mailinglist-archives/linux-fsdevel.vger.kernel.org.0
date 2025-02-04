Return-Path: <linux-fsdevel+bounces-40775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4986A27608
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 16:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED193A8DC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 15:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5210B215195;
	Tue,  4 Feb 2025 15:34:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFD5215073
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683268; cv=none; b=A3FB6XE89Gi38ZRDrgulKrfkSn9ifdsAo/DTsILnhH9UQXEnEjV4LXajY7Tt4JFRizVwThUdr75/7k08C+VkJGRVJYYYdOc3EMnjQSv/ZF0IOaR05IQdjbH9poItJoNZDxiZhaJVosoyh6+DzFKJk+ZDlj3yYWN01RUuJGHtS/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683268; c=relaxed/simple;
	bh=4O1FsDojpmfWjY3WXrQieUlwr4UUfuJRs3UYxALeDjo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VxsQlK1G4psnJn89f1TZYBi7y8vJU1nSB19QLkrI74PfzCWyi8OGY5EA46BAe1PyReW9R8N1PHaWNyqOF+j5Z6ovvDyTghiJ0TqhH64mJCgjM33AjsP5D3A7jGFdwnZtYoQiQ8kRFVr4slSL7/v+jewqpeCvRhEU4TZ9bsyFoUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d04d797364so1089915ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 07:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738683266; x=1739288066;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UktX2izZCIdhzJfOdw8iYvm6hREofXu1ApMqtiVM9OU=;
        b=XJJYABLY4/stTFG/jwvrpVdN6JxrLU2cQNU39byfsDMcNaLsxBTM5D5AFY7obpe0DT
         dc1P3qYgvD7HKoQIiPeu5PavwBKPkzwdt788b2jdsjmbM7/ydSWrtL03Rz9HzNeRL7OR
         V8oDmG6+9j1gHZ98xtnpKe1HCIkOyVwoXR7b1Rtgm5Y0Vke8tIuieKWEtKL0qVXeiGoS
         RJEPfEdXSUUYP+9f1h8v7FOODKMHWU7R1PiCgty9/d/iYswj2+UDjRHhDAL9aDrQG3s2
         cEPtMUtq2z5vv0BTC2zpTe90/znZbazjISP8Q0Hje3g42iQNWFo8Q/xBzoqIh6elF708
         z9rA==
X-Forwarded-Encrypted: i=1; AJvYcCUgGMdDrsXdRbotGDGzy1sDtGwM+yAmVKx1mZk6tiY5XmKYAkBAglrWAjw3laxBjKkj3D70kcXy3FEz9C1H@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZzRlit7PHPn2TWD6HtLaAKTXl3Hbpb0AHM17qzrLEXrLlVng
	gKlLYrQ5jlUc3UO2jUdCqOy+x3iV7N/eBuBuhUvAFZaK3womf7ret6PQlWgOWjwtGrt8qijjHm7
	nKkniFkEq14RdiP5sYRNsK0J+anbsiEK+7Sm8teqfROSeOm7tpb2wfdM=
X-Google-Smtp-Source: AGHT+IFYShaFOAjMWO6XMEvZA5S8N0X644DEhFtK5kfvMkGAEPC0c48fmIm0G1cZZzqGug/8HQrX/U4oz5OuL1rCx3TOXgg0K6SG
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:220e:b0:3d0:235b:4810 with SMTP id
 e9e14a558f8ab-3d0235b48e5mr126081905ab.2.1738683266249; Tue, 04 Feb 2025
 07:34:26 -0800 (PST)
Date: Tue, 04 Feb 2025 07:34:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a23382.050a0220.d7c5a.00bc.GAE@google.com>
Subject: [syzbot] [bcachefs?] general protection fault in __d_lookup
From: syzbot <syzbot+c97005be42b5040dfb21@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69b8923f5003 Merge tag 'for-linus-6.14-ofs4' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c2dddf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57ab43c279fa614d
dashboard link: https://syzkaller.appspot.com/bug?extid=c97005be42b5040dfb21
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bf4518580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea84ac864e92/disk-69b8923f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a465997b4e0/vmlinux-69b8923f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d72b67b2bd15/bzImage-69b8923f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/dc476a9a4569/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c97005be42b5040dfb21@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xfbd5a5d5a0000003: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4ead0000001f]
CPU: 0 UID: 0 PID: 5866 Comm: udevd Not tainted 6.13.0-syzkaller-09793-g69b8923f5003 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:__d_lookup+0x20f/0x7b0 fs/dcache.c:2352
Code: 89 44 24 48 49 8d 45 04 48 89 44 24 20 49 8d 45 08 48 89 44 24 50 4c 89 7c 24 30 48 89 2c 24 48 83 c5 18 48 89 e8 48 c1 e8 03 <0f> b6 04 18 84 c0 0f 85 37 03 00 00 8b 6d 00 89 ef 44 89 f6 e8 d8
RSP: 0018:ffffc9000406f870 EFLAGS: 00010a06
RAX: 1bd5a9d5a0000003 RBX: dffffc0000000000 RCX: ffff8880319d0000
RDX: 0000000000000000 RSI: 00000000426c562e RDI: 000000009a43dfa0
RBP: dead4ead00000018 R08: ffffffff823bcc58 R09: 1ffff920000826c5
R10: dffffc0000000000 R11: fffff520000826c6 R12: ffffffff823bca94
R13: ffffc9000406fab0 R14: 00000000426c562e R15: ffff888011b42eb0
FS:  00007f8465f7dc80(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005590437eb9a8 CR3: 0000000032560000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lookup_fast+0x79/0x590 fs/namei.c:1751
 walk_component+0x57/0x410 fs/namei.c:2110
 lookup_last fs/namei.c:2612 [inline]
 path_lookupat+0x16f/0x450 fs/namei.c:2636
 filename_lookup+0x2a3/0x670 fs/namei.c:2665
 vfs_statx+0x103/0x490 fs/stat.c:344
 vfs_fstatat+0xe5/0x130 fs/stat.c:366
 __do_sys_newfstatat fs/stat.c:530 [inline]
 __se_sys_newfstatat fs/stat.c:524 [inline]
 __x64_sys_newfstatat+0x11d/0x1a0 fs/stat.c:524
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8465b165f4
Code: 64 c7 00 09 00 00 00 83 c8 ff c3 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff ff ff e9 00 00 00 00 41 89 ca b8 06 01 00 00 0f 05 <45> 31 c0 3d 00 f0 ff ff 76 10 48 8b 15 03 a8 0d 00 f7 d8 41 83 c8
RSP: 002b:00007ffd3486bbe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 00005590437a4e50 RCX: 00007f8465b165f4
RDX: 00007ffd3486bbf8 RSI: 00007ffd3486c088 RDI: 00000000ffffff9c
RBP: 00007ffd3486bc88 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd3486c088
R13: 00007ffd3486bbf8 R14: 0000559043794910 R15: 000055903b3dda04
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__d_lookup+0x20f/0x7b0 fs/dcache.c:2352
Code: 89 44 24 48 49 8d 45 04 48 89 44 24 20 49 8d 45 08 48 89 44 24 50 4c 89 7c 24 30 48 89 2c 24 48 83 c5 18 48 89 e8 48 c1 e8 03 <0f> b6 04 18 84 c0 0f 85 37 03 00 00 8b 6d 00 89 ef 44 89 f6 e8 d8
----------------
Code disassembly (best guess):
   0:	89 44 24 48          	mov    %eax,0x48(%rsp)
   4:	49 8d 45 04          	lea    0x4(%r13),%rax
   8:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   d:	49 8d 45 08          	lea    0x8(%r13),%rax
  11:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
  16:	4c 89 7c 24 30       	mov    %r15,0x30(%rsp)
  1b:	48 89 2c 24          	mov    %rbp,(%rsp)
  1f:	48 83 c5 18          	add    $0x18,%rbp
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 04 18          	movzbl (%rax,%rbx,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 37 03 00 00    	jne    0x36d
  36:	8b 6d 00             	mov    0x0(%rbp),%ebp
  39:	89 ef                	mov    %ebp,%edi
  3b:	44 89 f6             	mov    %r14d,%esi
  3e:	e8                   	.byte 0xe8
  3f:	d8                   	.byte 0xd8


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

