Return-Path: <linux-fsdevel+bounces-38294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243249FEF82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 14:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06C6162321
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 13:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F0619D880;
	Tue, 31 Dec 2024 13:10:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713B817BA1
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735650629; cv=none; b=TPus5dqk3VUWScThq4yfYvkEFgyl+NBCYG+yigYH9wZAdwfFqgmRLqPMG8dXxdLNyVJK1zcNZ/IVNWSqOewU6WGG17LH1zHwsgHgL5BwJqtP/GI0r0Ie1qtFL5rJUOTJPPcX4w2dqjBI6IlwM/L2jXMLmA3RrLPrV22BohjY/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735650629; c=relaxed/simple;
	bh=AjCqaO/c2C/1RVEwiGokVYVRzXvQ/dPY0ku/Xu31DRI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QYxb4IKYLqN/kaDLB++D133m0Up2jq9jvBk0f2Zktfrbqu0uay5IcqUiZrXxvcRmO3lXlNa6/Gr6P6GTHcC3Yeybd/uys74bFL07/+MPETnyYjb/jd7UoQHxkhl57pNn40DNh/H81ZNsWlfKekVl9Qi7r9Iwlx6mVooKkIhTato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a9cbe8fea1so104282395ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 05:10:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735650625; x=1736255425;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7TiVZTCLlQn31lb/WNkxKEnOV/dYgmRGEbigOHLfObQ=;
        b=iv9ZFfJ1HSiMHqoHAzV4I7QI9R+Dl38fvhFZvCKZoedYPizeyIo252hs1DPcY4x3xu
         OnyqK+UjZP68lAimvTaUhCfiMWIWb5bDUuQivHMpQAl20sS26wKznQrttYdbqRbM26V0
         WGdVHQi9sChGEreuHxKf15ErmMYQ8cxnCgpP5hNR4yLFBn+omyh1rWV/XPPp2bKmqh/S
         3/COklrA06eLDGOTwECGNL0HbKzEryRKNxn+ju+U24EVvZeL5wq3PeKBjTnWP/96HoFs
         DRKbW6Fl9FHW2BT/K5TKbfVhdQFAb/ggl3Z/+wHfijpw875HLahLaC+CVKj9uL2Ru8or
         Em6w==
X-Gm-Message-State: AOJu0YxbtwkV744PomjmB7q2v4M79LzRjRfk7la9V7aNFfGvNQFiTlf1
	9Xri3pLzVscR8EzoAAZOVL2sGThmR4aEWKZa3zdJIqSucy42Z42VYQpXOTciG/UePLtkmQP3IfW
	4aIAH/Gb6AoQQYbOSjyKh3o7AlhDqWRORQKMyMoQhaxgD4QJ1dsj/m7Jr2A==
X-Google-Smtp-Source: AGHT+IE6OzQorZvdhq+z5mFvPRoea3wmFwX5FM+x7wOva8whmvhvOdYWo3EKlGyqef48YR3LVabgPYdqr41ea5ijB0qtFj6Pe0gR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1685:b0:3a7:6e59:33ad with SMTP id
 e9e14a558f8ab-3c2d4e6c573mr255226405ab.17.1735650625403; Tue, 31 Dec 2024
 05:10:25 -0800 (PST)
Date: Tue, 31 Dec 2024 05:10:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6773ed41.050a0220.25abdd.08f6.GAE@google.com>
Subject: [syzbot] [fuse?] BUG: unable to handle kernel NULL pointer
 dereference in fuse_copy_one
From: syzbot <syzbot+43f6243d6c4946b26405@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ccb98ccef0e5 Merge tag 'platform-drivers-x86-v6.13-4' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d4f50f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86dd15278dbfe19f
dashboard link: https://syzkaller.appspot.com/bug?extid=43f6243d6c4946b26405
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ccb98cce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/75a6223b351c/vmlinux-ccb98cce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/beea89d50f58/bzImage-ccb98cce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+43f6243d6c4946b26405@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 6a754067 P4D 6a754067 PUD 68142067 PMD 0 
Oops: Oops: 0002 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 7523 Comm: syz.2.395 Not tainted 6.13.0-rc5-syzkaller-00004-gccb98ccef0e5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:memcpy+0xc/0x20 arch/x86/lib/memcpy_64.S:38
Code: e9 44 fd ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 48 89 f8 48 89 d1 <f3> a4 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90
RSP: 0018:ffffc9000370f8b0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000370fc50 RCX: 0000000000000004
RDX: 0000000000000004 RSI: ffff88804ef5d710 RDI: 0000000000000000
RBP: 0000000000000004 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000004 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88802b400000(0063) knlGS:00000000f5080b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000006ba72000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fuse_copy_do fs/fuse/dev.c:809 [inline]
 fuse_copy_one+0x1cc/0x230 fs/fuse/dev.c:1065
 fuse_copy_args+0x109/0x690 fs/fuse/dev.c:1083
 copy_out_args fs/fuse/dev.c:1966 [inline]
 fuse_dev_do_write+0x1b0a/0x3100 fs/fuse/dev.c:2052
 fuse_dev_write+0x160/0x1f0 fs/fuse/dev.c:2087
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf708e579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5080500 EFLAGS: 00000293 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000020000700
RDX: 0000000000000014 RSI: 00000000f73c3ff4 RDI: 0000000000000000
RBP: 0000000020008380 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:memcpy+0xc/0x20 arch/x86/lib/memcpy_64.S:38
Code: e9 44 fd ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 48 89 f8 48 89 d1 <f3> a4 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90
RSP: 0018:ffffc9000370f8b0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc9000370fc50 RCX: 0000000000000004
RDX: 0000000000000004 RSI: ffff88804ef5d710 RDI: 0000000000000000
RBP: 0000000000000004 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000004 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88802b400000(0063) knlGS:00000000f5080b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000006ba72000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e9 44 fd ff ff       	jmp    0xfffffd49
   5:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   c:	00 00
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	f3 0f 1e fa          	endbr64
  22:	66 90                	xchg   %ax,%ax
  24:	48 89 f8             	mov    %rdi,%rax
  27:	48 89 d1             	mov    %rdx,%rcx
* 2a:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi) <-- trapping instruction
  2c:	c3                   	ret
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	cc                   	int3
  31:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  38:	00 00 00 00
  3c:	66 90                	xchg   %ax,%ax
  3e:	90                   	nop
  3f:	90                   	nop


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

