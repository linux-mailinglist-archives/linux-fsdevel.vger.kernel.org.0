Return-Path: <linux-fsdevel+bounces-41825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F61A37CB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 09:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D927169617
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 08:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BC219DFAB;
	Mon, 17 Feb 2025 08:04:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F49018DB23
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739779461; cv=none; b=Cw+dAcB+0AUcg7HDSMym2d/3WnzI9oSQijQyeVSci4LpYG6tlVZED/rXAG1rfqBtnlpXRH7Ahj18LeyCaThDDI+UE8wPsOKZ+qK4UE8WPWqw642Ow5RfXfzUWdHxd8pfvDnysrOb26INAcDGETuCegfoz4SqxouM4iAoxvFCZpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739779461; c=relaxed/simple;
	bh=xahl78UwGHhfLTQW0XY26JONhI1YHBALJLvE8nXpfpc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QZpNHPTsFfNKqs+y0Dnfa71cYR5PXgzs617I2J0AN2G46KkjRpyx0pJSZd4hLuJ+OeIj8jrTMybjCOnKOeRu6/zQSNnS/dokr6V8JnpKJSDnH69LTz8hpwDC9eNRXLUsit0wBpvvbyvfswu66GzrHWmqDcB1DH7iU/X59EXWd54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d18f21d202so30281955ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 00:04:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739779458; x=1740384258;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=di4ea1GIYo6ent4pubzUydugwLVXnPHfpCjmRi93/jQ=;
        b=caPWTyvoCuuQ/Dz7YsySd+pqkwxFN/klzdMGmnov51jieAsCZvarqE5SjcQ9tkjN9O
         Bg+S2bKrljwH9ekz3ObDUTDo6t4Xz+eFDP6V61r05FdofkiRvHf7/yPeaPr3iP8pZXmw
         T4En4JBGhSLdZ59ff5PdvZpzg4aKs183JvMWc//mO3hHjloGMwlb9NsDSlDZCt4YoQSK
         mE5YzL7nRBpXe/lYXUshqrkvOvW7gxaiyb8FEtiuamMLT3AixHlYa03/xGISZnLAcySY
         AB6sgBy4yi/FnrY7QirGPwr1LGmhqylWpf+joROYvJYzUa/FGjc1G5/lvmJ5ohHjBJ3X
         bs8g==
X-Forwarded-Encrypted: i=1; AJvYcCV2gyJHh8S+n+kU8mfVzOBipWqCfC8TpOwt4fGqp+x0qP18L/qRLdKjOgSl1yMvJJ3YrTMnAgfu5iD5emHX@vger.kernel.org
X-Gm-Message-State: AOJu0YxrdYOkOoSs78BvLY4ILgBmHkVFDNUxVdLDiZc1LRLp0Hzxbolo
	jCJNUQNa/Kf+ZopFjyrwRQWtdl5F8oNiXgfzH5YfBzopZZv/lIQDbpGa4ppkEWO/hJujHaUt7wt
	vxxudJzdkbC6UOpoDiYFNxt47aXP6vfE/QcLZ1XXSra0ZjvC9CmNOPpQ=
X-Google-Smtp-Source: AGHT+IH+yPRxkMqKKbdVDSXWh/eywYMHR6OHi66+7ImypDzo8z5MiWq0C6e67IVQQ/1p6cfzDo627T8PoPk1Eza4pAzTIUb+xsDe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2686:b0:3d0:3fa2:ccfd with SMTP id
 e9e14a558f8ab-3d280771e1amr78951725ab.5.1739779458493; Mon, 17 Feb 2025
 00:04:18 -0800 (PST)
Date: Mon, 17 Feb 2025 00:04:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b2ed82.050a0220.173698.0024.GAE@google.com>
Subject: [syzbot] [bcachefs?] BUG: unable to handle kernel paging request in __d_lookup_rcu
From: syzbot <syzbot+a3f3ed84ec8cc241ff9e@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ad1b832bf1cf Merge tag 'devicetree-fixes-for-6.14-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150197df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c776e555cfbdb82d
dashboard link: https://syzkaller.appspot.com/bug?extid=a3f3ed84ec8cc241ff9e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113ed5a4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ad1b832b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/64103cb6fc45/vmlinux-ad1b832b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9bc34ac014d0/bzImage-ad1b832b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9f5f306c6e6e/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3f3ed84ec8cc241ff9e@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffffffffffffcf
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD e93c067 P4D e93c067 PUD e93e067 PMD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5322 Comm: udevd Not tainted 6.14.0-rc2-syzkaller-00303-gad1b832bf1cf #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__seqprop_spinlock_sequence include/linux/seqlock.h:227 [inline]
RIP: 0010:__d_lookup_rcu+0x18d/0x490 fs/dcache.c:2264
Code: 00 00 00 00 89 44 24 24 4c 89 6c 24 30 4c 89 7c 24 28 48 8d 7d c8 48 89 f8 48 c1 e8 03 42 0f b6 04 20 84 c0 0f 85 bb 01 00 00 <44> 8b 75 c8 48 8d 5d 10 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08
RSP: 0018:ffffc9000d13f768 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888042a8cd88 RCX: ffff888000a10000
RDX: 0000000000000000 RSI: ffff888042a8cd78 RDI: ffffffffffffffcf
RBP: 0000000000000007 R08: ffffffff82419fdc R09: 1ffff92000076d24
R10: dffffc0000000000 R11: fffff52000076d25 R12: dffffc0000000000
R13: ffff88801d03fbe8 R14: 0000000000000000 R15: 0000000000000004
FS:  00007fd7f3eb2280(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffcf CR3: 0000000012b1a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lookup_fast+0xca/0x590 fs/namei.c:1727
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
RIP: 0033:0x7fd7f3f859a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffd67ebfd80 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007fd7f3f859a4
RDX: 0000000000080000 RSI: 00007ffd67ebfeb8 RDI: 00000000ffffff9c
RBP: 00007ffd67ebfeb8 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 0000562f3212db42 R14: 0000000000000001 R15: 0000562f32149160
 </TASK>
Modules linked in:
CR2: ffffffffffffffcf
---[ end trace 0000000000000000 ]---
RIP: 0010:__seqprop_spinlock_sequence include/linux/seqlock.h:227 [inline]
RIP: 0010:__d_lookup_rcu+0x18d/0x490 fs/dcache.c:2264
Code: 00 00 00 00 89 44 24 24 4c 89 6c 24 30 4c 89 7c 24 28 48 8d 7d c8 48 89 f8 48 c1 e8 03 42 0f b6 04 20 84 c0 0f 85 bb 01 00 00 <44> 8b 75 c8 48 8d 5d 10 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08
RSP: 0018:ffffc9000d13f768 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888042a8cd88 RCX: ffff888000a10000
RDX: 0000000000000000 RSI: ffff888042a8cd78 RDI: ffffffffffffffcf
RBP: 0000000000000007 R08: ffffffff82419fdc R09: 1ffff92000076d24
R10: dffffc0000000000 R11: fffff52000076d25 R12: dffffc0000000000
R13: ffff88801d03fbe8 R14: 0000000000000000 R15: 0000000000000004
FS:  00007fd7f3eb2280(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffcf CR3: 0000000012b1a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	89 44 24 24          	mov    %eax,0x24(%rsp)
   8:	4c 89 6c 24 30       	mov    %r13,0x30(%rsp)
   d:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
  12:	48 8d 7d c8          	lea    -0x38(%rbp),%rdi
  16:	48 89 f8             	mov    %rdi,%rax
  19:	48 c1 e8 03          	shr    $0x3,%rax
  1d:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax
  22:	84 c0                	test   %al,%al
  24:	0f 85 bb 01 00 00    	jne    0x1e5
* 2a:	44 8b 75 c8          	mov    -0x38(%rbp),%r14d <-- trapping instruction
  2e:	48 8d 5d 10          	lea    0x10(%rbp),%rbx
  32:	48 89 d8             	mov    %rbx,%rax
  35:	48 c1 e8 03          	shr    $0x3,%rax
  39:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
  3e:	74 08                	je     0x48


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

