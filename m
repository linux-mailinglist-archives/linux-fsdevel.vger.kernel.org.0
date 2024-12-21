Return-Path: <linux-fsdevel+bounces-37995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D069F9DE2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2024 03:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A21F1886AA6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2024 02:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309FD7CF16;
	Sat, 21 Dec 2024 02:14:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC27225D7
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Dec 2024 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734747266; cv=none; b=Uv2rc5iCRw4Cex6emx6EjTX5LJfy47RvO5hlFFDkgmTKFUZPcP6zCUjvFQE4VpNAvKW21EZErSrQziUh+waaqmbE6ZdlDjY+tTZgsgSvsRvtg8SZSBiYNdYE8eoXRQwvno7m45g1VW4pUOsyERX+Auc/838542vozVeXyIAFUlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734747266; c=relaxed/simple;
	bh=e/4c+pA3HWh5hHsxKL7zU+bWoUv02OXMBNzotPc8S8g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XjSgvcxo7VwNeIzSKiI+//DMeewg5DlffHf15xml23iZIkYWAhdGARKqImLqYp+TqNcnx2kH3oYLE6cz7CrynLekxOKaWqROgvSAkBGnajmRNemZE7Ti+R4xaTrbcCmTi0lC1SH4f3OOHbjFOhGL//T07rKMEc1lEJ9zmBT2mE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so47896735ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 18:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734747264; x=1735352064;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7Z6Db8UcMPD9tVeG8l2Tt12DDejWp5FKTuKz4O8F2Q=;
        b=sgp76Cd0xH7HmXCkT32uunTNAJv8taeUwe5yWCkHuuSuDVIGTSeoI0u+H0hjwPrdN3
         ox9msUXyCYmQDa7HGg/E/mdo7YFeUijqb4oso41nxgrX5nKx5l5dXB6t/x9jFlPGMrBx
         Qi4puBJwH3CW7y89Q6YWc0AysduhUqzMCDy5tSCObH+8UOzyFBwGwzcaPc6agNpuAoDP
         YWte09eYBA4pwqTwCaKZt5zWNuPYmX65wMVhAxO08fbXgHYuXk5eqRBb07/PwWt6+NOR
         KqGvTMhGtrKUdFKT/dyGZOx3FHamNgav9V4jMMuWA8b1tyAZsTssusNEtONjcvhW4fjt
         rx9A==
X-Forwarded-Encrypted: i=1; AJvYcCUJZaz+tRB+obrO5+ucqbVjnqUaBDdFndgBgRDSNtfgqIjVRAngj4Q3h7GSFBDJs+p6+v95x5AYSUXv04Yo@vger.kernel.org
X-Gm-Message-State: AOJu0YwTTXBXQxgfwfR+u7JVCagVWb4LQx7ZmBcYJojKZuCe9oWghqFr
	feb4kt77OU0KTX5CVCriZICKuvTQuxK9kudUMYHLJNQh1775zYwIDmRPwLhF3STzwGjdGXsmoI1
	zotpwPmvTwcpS0wBCsp9kR6ntsV2HN62slUrM8I5FpTpldZeMlm2Shm0=
X-Google-Smtp-Source: AGHT+IESpRsz06Zzq8rINS80JC2u7d4pql4bYtGj0FBm4zNASzwJpI+V/m7CmUzSYIigwPXU/uKiHQsowJW4VBO1Zlm82QWFipOj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174d:b0:3a7:dd45:bca1 with SMTP id
 e9e14a558f8ab-3c2d514f31bmr42978455ab.17.1734747264307; Fri, 20 Dec 2024
 18:14:24 -0800 (PST)
Date: Fri, 20 Dec 2024 18:14:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67662480.050a0220.25abdd.0123.GAE@google.com>
Subject: [syzbot] [exfat?] general protection fault in exfat_find_empty_entry
From: syzbot <syzbot+8941485e471cec199c9e@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e9b8ffafd20a Merge tag 'usb-6.13-rc4' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=120d5cf8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a2b862bf4a5409f
dashboard link: https://syzkaller.appspot.com/bug?extid=8941485e471cec199c9e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13edd2df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1182af30580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e9b8ffaf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ad411c12e636/vmlinux-e9b8ffaf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/61fac154060e/bzImage-e9b8ffaf.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/8fae9ce0ef68/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/8fa8077be4fc/mount_8.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8941485e471cec199c9e@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 5363 Comm: syz-executor144 Not tainted 6.13.0-rc3-syzkaller-00193-ge9b8ffafd20a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:exfat_find_empty_entry+0x16c9/0x1a10 fs/exfat/namei.c:398
Code: 46 8b ff 48 8b 1b 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 f5 45 8b ff 48 8b 1b 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 d8 45 8b ff 4c 8b 33 48 8b 54 24
RSP: 0018:ffffc9000d2af120 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: ffff88800068c880
RDX: 0000000000000000 RSI: 00000000fffffffb RDI: 00000000fffffffb
RBP: ffffc9000d2af370 R08: ffffffff827a8268 R09: 1ffff110089f4c63
R10: dffffc0000000000 R11: ffffed10089f4c64 R12: 00000000fffffffb
R13: ffffc9000d2af820 R14: ffff888044f981a8 R15: dffffc0000000000
FS:  00007f746cfe96c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f746cfe9d58 CR3: 000000004287a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 exfat_add_entry+0x409/0xaa0 fs/exfat/namei.c:496
 exfat_create+0x1c7/0x570 fs/exfat/namei.c:565
 lookup_open fs/namei.c:3649 [inline]
 open_last_lookups fs/namei.c:3748 [inline]
 path_openat+0x1c03/0x3590 fs/namei.c:3984
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1428
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f746d074ed9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f746cfe9218 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f746d0fe6e8 RCX: 00007f746d074ed9
RDX: 000000000000275a RSI: 0000000020000000 RDI: 00000000ffffff9c
RBP: 0000000000000000 R08: 00007fff65f63967 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f746d0fe6e0
R13: 00007f746d0cab00 R14: 0030656c69662f2e R15: 00303636396f7369
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:exfat_find_empty_entry+0x16c9/0x1a10 fs/exfat/namei.c:398
Code: 46 8b ff 48 8b 1b 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 f5 45 8b ff 48 8b 1b 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 d8 45 8b ff 4c 8b 33 48 8b 54 24
RSP: 0018:ffffc9000d2af120 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: ffff88800068c880
RDX: 0000000000000000 RSI: 00000000fffffffb RDI: 00000000fffffffb
RBP: ffffc9000d2af370 R08: ffffffff827a8268 R09: 1ffff110089f4c63
R10: dffffc0000000000 R11: ffffed10089f4c64 R12: 00000000fffffffb
R13: ffffc9000d2af820 R14: ffff888044f981a8 R15: dffffc0000000000
FS:  00007f746cfe96c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7464a14000 CR3: 000000004287a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	46 8b ff             	rex.RX mov %edi,%r15d
   3:	48 8b 1b             	mov    (%rbx),%rbx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 f5 45 8b ff       	call   0xff8b4611
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 18          	add    $0x18,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 d8 45 8b ff       	call   0xff8b4611
  39:	4c 8b 33             	mov    (%rbx),%r14
  3c:	48                   	rex.W
  3d:	8b                   	.byte 0x8b
  3e:	54                   	push   %rsp
  3f:	24                   	.byte 0x24


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

