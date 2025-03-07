Return-Path: <linux-fsdevel+bounces-43400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6E3A55DD1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 03:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62286175D2B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 02:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29125188904;
	Fri,  7 Mar 2025 02:45:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE1E322A
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315538; cv=none; b=l5PfMYF89zkEf4wIHkLpVaCEisvH3Er1/+r/hMfLfQZNOE5TROH9/zeY+D6TISPKpP6EjOCbd46p7aGZpuQ/A5DvsoqLVvEaqIEkdLsizO5isAvfrxafZus8s2KZTQlLwgsNQgp8vW+wqGt052dAz0cqh2N3TBoVW3OosmzLjg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315538; c=relaxed/simple;
	bh=0rW4E4oxORNr9fiFjEuTAoqcJcj/49TSyVzDYrAEf2k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Wp+kPkx361I3GV/e82aPIvPsjNI7wG+6GgHDRg7oUIjs2QzuLUVKS8GabMwSFCFfSnqvzS9uNua3q8Z1eDxYDZuuqhcWk/L8+/TfGbwkPW6eYP4Xg3mpNx5D53aHluo/LbqPYgl3wMHI66hErPjSNNy4HRryS+HHe6OJ7Sfxy30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-8521d7980beso116598339f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Mar 2025 18:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741315536; x=1741920336;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0KL3oQoobIW/c2UWrVqSahci7G33eLWDEPMRjEh3dw=;
        b=Cys7yKbkWetjKqP3uD/kjMk5ya1HiFUYloaZAyFYNxAoaPipV+26XzChe47Jhr4PV8
         1FBdTIhSA7baKcTPxE7Wi9w7lim5P3a7a7TudLwxlgJ0fb94bsxgG0QXHTBqEyllyI6D
         v+8VcWYcHhYc1K/tfojUYjOI38x8W3qgz35rc/ZP35T0prRVgch233HGW7O8igeAYyda
         hdpkDH6iAplaO4cwDiIjYohe+Q+aNDbN/H7bJDdrE5+/Q7S5FiJyJXWixGOanD1VaJTE
         g5Bq15fSTFxwzcDDFaRxjgQZ1fPwOyjabGV/rXWo8OPm+slSjjhTuJPPjVFsA7n97wOt
         WcbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUakp+T0E3AN9Ey/MmCf/79wsKt2bFrZsJyYq7Z/Ld4fN5m5a8AP48H7nEpkjKtx+t8YMSXGgcaDtrX0al7@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3ezEMDuCRb18JMzQRnMsp2kZYmrEVcx5/2aefbgxr60juUZE
	42BJRV/0WEkjXL68Ldh9CqbAnKbDn61FmNoUeCxVgqQCWx5Zn940tql0zprdPSUO94Ho95Ep98v
	tYK5sDOR0hRHV3txfvqcJtx/iOIDmAkckYfO7Ft1jfCZbTFM7KUltx6U=
X-Google-Smtp-Source: AGHT+IG1Qy4g7vhpFLL3Hrz86OkT+Qd6INMTs1zBNiL6BZjj/jnHmMzgiq9KTYHsiqxOKgRfIMhhaZTNnv1m4ajNNDNSqgo43qSu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a83:b0:3d3:e29c:a1a5 with SMTP id
 e9e14a558f8ab-3d4419ff14fmr27394875ab.18.1741315536274; Thu, 06 Mar 2025
 18:45:36 -0800 (PST)
Date: Thu, 06 Mar 2025 18:45:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ca5dd0.050a0220.15b4b9.0076.GAE@google.com>
Subject: [syzbot] [bcachefs?] general protection fault in proc_sys_compare
From: syzbot <syzbot+4364ec1693041cad20de@syzkaller.appspotmail.com>
To: broonie@kernel.org, joel.granados@kernel.org, kees@kernel.org, 
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, marcan@marcan.st, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b91872c56940 Merge tag 'dmaengine-fix-6.14' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1485e8b7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8de9cc84d5960254
dashboard link: https://syzkaller.appspot.com/bug?extid=4364ec1693041cad20de
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149d55a8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b855669df70/disk-b91872c5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e44f3c546271/vmlinux-b91872c5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b106e670346a/bzImage-b91872c5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/68b26fa478ee/mount_0.gz

The issue was bisected to:

commit 579cd64b9df8a60284ec3422be919c362de40e41
Author: Hector Martin <marcan@marcan.st>
Date:   Sat Feb 8 00:54:35 2025 +0000

    ASoC: tas2770: Fix volume scale

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14aa03a8580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16aa03a8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12aa03a8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4364ec1693041cad20de@syzkaller.appspotmail.com
Fixes: 579cd64b9df8 ("ASoC: tas2770: Fix volume scale")

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 5490 Comm: dhcpcd Not tainted 6.14.0-rc4-syzkaller-00295-gb91872c56940 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:sysctl_is_seen fs/proc/proc_sysctl.c:907 [inline]
RIP: 0010:proc_sys_compare+0x1ba/0x260 fs/proc/proc_sysctl.c:932
Code: 09 89 c5 31 ff 89 c6 e8 04 b2 5e ff 85 ed 74 56 80 3d d2 ae c2 0d 01 75 6f e8 b2 ad 5e ff e9 74 ff ff ff 48 89 e8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 ef e8 d7 61 c3 ff 48 8b 5d 00 48 85 db
RSP: 0018:ffffc90003547718 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffff8c3b6218 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffffc900035476a0
RBP: 0000000000000000 R08: 0000000000000003 R09: fffff520006a8ed4
R10: dffffc0000000000 R11: fffff520006a8ed4 R12: 0000000000000004
R13: dffffc0000000000 R14: ffff88806c232c30 R15: ffff88806c040020
FS:  00007f2e2350e740(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056042d48d000 CR3: 000000001e6d2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 d_same_name fs/dcache.c:2137 [inline]
 __d_lookup+0x533/0x7b0 fs/dcache.c:2361
 lookup_fast+0x79/0x590 fs/namei.c:1751
 walk_component fs/namei.c:2110 [inline]
 link_path_walk+0x672/0xea0 fs/namei.c:2479
 path_openat+0x266/0x3590 fs/namei.c:3985
 do_filp_open+0x27f/0x4e0 fs/namei.c:4016
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1428
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_openat fs/open.c:1459 [inline]
 __se_sys_openat fs/open.c:1454 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1454
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2e235d89a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffcef5bc920 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000000100a0 RCX: 00007f2e235d89a4
RDX: 0000000000000000 RSI: 00007ffcef5ccbb8 RDI: 00000000ffffff9c
RBP: 00007ffcef5ccbb8 R08: 0000000000000000 R09: 00007ffcef5ccb28
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcef5bca38 R14: 00007ffcef5bca38 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:sysctl_is_seen fs/proc/proc_sysctl.c:907 [inline]
RIP: 0010:proc_sys_compare+0x1ba/0x260 fs/proc/proc_sysctl.c:932
Code: 09 89 c5 31 ff 89 c6 e8 04 b2 5e ff 85 ed 74 56 80 3d d2 ae c2 0d 01 75 6f e8 b2 ad 5e ff e9 74 ff ff ff 48 89 e8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 ef e8 d7 61 c3 ff 48 8b 5d 00 48 85 db
RSP: 0018:ffffc90003547718 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffff8c3b6218 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffffc900035476a0
RBP: 0000000000000000 R08: 0000000000000003 R09: fffff520006a8ed4
R10: dffffc0000000000 R11: fffff520006a8ed4 R12: 0000000000000004
R13: dffffc0000000000 R14: ffff88806c232c30 R15: ffff88806c040020
FS:  00007f2e2350e740(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056042d48d000 CR3: 000000001e6d2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	89 c5                	mov    %eax,%ebp
   2:	31 ff                	xor    %edi,%edi
   4:	89 c6                	mov    %eax,%esi
   6:	e8 04 b2 5e ff       	call   0xff5eb20f
   b:	85 ed                	test   %ebp,%ebp
   d:	74 56                	je     0x65
   f:	80 3d d2 ae c2 0d 01 	cmpb   $0x1,0xdc2aed2(%rip)        # 0xdc2aee8
  16:	75 6f                	jne    0x87
  18:	e8 b2 ad 5e ff       	call   0xff5eadcf
  1d:	e9 74 ff ff ff       	jmp    0xffffff96
  22:	48 89 e8             	mov    %rbp,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 ef             	mov    %rbp,%rdi
  33:	e8 d7 61 c3 ff       	call   0xffc3620f
  38:	48 8b 5d 00          	mov    0x0(%rbp),%rbx
  3c:	48 85 db             	test   %rbx,%rbx


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

