Return-Path: <linux-fsdevel+bounces-70079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E290DC90191
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 21:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 156B84E4C43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 20:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CC630E82C;
	Thu, 27 Nov 2025 20:14:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691E30E0C8
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 20:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764274467; cv=none; b=M7W/3G4ShyGvX/1ZfTH4x/r+Wgmlxd4F9uRMhHrw+0xjhmK3a3zJ91nNNee7pFQll/h4ldBmwB6JBzY0MU0zME7vslRxbuiVywufoFrdi2hFAKlj1jVtYAiCn6fnR5AxJrsVYJaHSDC1D6bmuAvCD2LoO624L259nDz7kFHUze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764274467; c=relaxed/simple;
	bh=1aRLhJ8xWhMIgFB8ZJGaKKmm5CP11NkIBosM+UE+pMM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DFvjcMYlSRFZq5zzd8LWHetBnCTpUBykQiWLiaroa5NiSN/oJR1o///V+v1OT8QsNw8M0ZzgVDhXCZE3aavxpNxxarLcHrzuMjR/1/XGeoXHFkNePJouj1LG/mkTnKSVIKyiph4VF2/GJ5GlK4KabdXFGpNqQw7b5AMVlRqXzt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-9490387e016so60864139f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 12:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764274465; x=1764879265;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RyXk+JdJrjfAQyLVEA0XFGH9gSEcLDHPMaGhabbDzwo=;
        b=F67EkHnQktO+9Zqw4cGQMOSBnMeTME1baNFbsJmg0MgyXeQn7d7fL4i2d0jCCmnVTT
         fzpTd8cPctm/r3emMkAURiG/ji366t0tlU72qnX1Zwih8xc4nNrlvZ/g1mH9y0cI42jI
         1qtM62sS/BXJErOw+m7t4srjf5iEsnL6hEerVjGd42iQnPsSLzZU+sLW+QSSjTRIXq2j
         SpbmPWqsx4AYsjwevaRjATxpE1Fv/riown3b1om9wEeTWBGPgMyJATojHQeyyp+Im5+F
         6dzShqNz77VDeMInLoo21nB4xWd+YsDVE5GbYypfI2Xxpdft8ssdD1kvZu1P+ppgNxzV
         rLSw==
X-Forwarded-Encrypted: i=1; AJvYcCWFbmuDYsxkqNISAiiYpzM7Ba8o4JDn5Xx7kMyN0UQ5BYa5GvP3HBPY12BfybfsYxFICT8D3jlFsQ+zxvuI@vger.kernel.org
X-Gm-Message-State: AOJu0YxP2uVXFrwBPZf0szkt5LfHcLhWoPBjjPqDEIPfsqJI/r7SpzMM
	/8wbl8/nHen+DGShHpDBiJprQBC40yCucTgbWsGogE50+Nu8tCb57S7Cmjaixs/7+RAeE29PRwh
	YJ3arShvZtaE96JDKdg5YQETT5jZxICBSEJI2I/Bjtc4V4eBQ8tw59uywWB0=
X-Google-Smtp-Source: AGHT+IEIfyUy18A1ohFy6qX7VITQlkwTqVgmShBIeaKAopcBBZGZh3EU3JX5Vq9ZA7VsZ6cdI/tRbW3eDwYsv+zCjLpvczUJrTXP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3108:b0:433:2c76:4e1b with SMTP id
 e9e14a558f8ab-435dd0e0232mr95458005ab.25.1764274465317; Thu, 27 Nov 2025
 12:14:25 -0800 (PST)
Date: Thu, 27 Nov 2025 12:14:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6928b121.a70a0220.d98e3.0110.GAE@google.com>
Subject: [syzbot] [fs?] general protection fault in fsnotify_destroy_group
From: syzbot <syzbot+321168dfa622eda99689@syzkaller.appspotmail.com>
To: amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, repnop@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    92fd6e84175b Add linux-next specific files for 20251125
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13226e92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf77a4e0e3514deb
dashboard link: https://syzkaller.appspot.com/bug?extid=321168dfa622eda99689
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f9c57c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13537612580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bee2604d495b/disk-92fd6e84.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b12aade49e2c/vmlinux-92fd6e84.xz
kernel image: https://storage.googleapis.com/syzbot-assets/286fd34158cb/bzImage-92fd6e84.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+321168dfa622eda99689@syzkaller.appspotmail.com

RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000f00
RBP: 00007ffd8b6be440 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f09c35e5fa0 R14: 00007f09c35e5fa0 R15: 0000000000000002
 </TASK>
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 UID: 0 PID: 6016 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:210
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 e9 40 01 33 09 cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc90003147c10 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffffffff8b5a8b4e RCX: 707d8ea8101f1b00
RDX: 0000000000000000 RSI: ffffffff8b5a8b4e RDI: 0000000000000003
RBP: ffffffff824e37fd R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1c0c6f3 R12: 0000000000000000
R13: 000000000000001c R14: 000000000000001c R15: 0000000000000001
FS:  000055556de07500(0000) GS:ffff888125f8b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f09c332b5a0 CR3: 00000000750b0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __kasan_check_byte+0x12/0x40 mm/kasan/common.c:572
 kasan_check_byte include/linux/kasan.h:401 [inline]
 lock_acquire+0x84/0x340 kernel/locking/lockdep.c:5842
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 fsnotify_group_stop_queueing fs/notify/group.c:39 [inline]
 fsnotify_destroy_group+0x8d/0x320 fs/notify/group.c:58
 class_fsnotify_group_destructor fs/notify/fanotify/fanotify_user.c:1600 [inline]
 __do_sys_fanotify_init fs/notify/fanotify/fanotify_user.c:1759 [inline]
 __se_sys_fanotify_init+0x991/0xbc0 fs/notify/fanotify/fanotify_user.c:1607
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f09c338f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8b6be3e8 EFLAGS: 00000246 ORIG_RAX: 000000000000012c
RAX: ffffffffffffffda RBX: 00007f09c35e5fa0 RCX: 00007f09c338f749
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000f00
RBP: 00007ffd8b6be440 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f09c35e5fa0 R14: 00007f09c35e5fa0 R15: 0000000000000002
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:210
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 e9 40 01 33 09 cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc90003147c10 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffffffff8b5a8b4e RCX: 707d8ea8101f1b00
RDX: 0000000000000000 RSI: ffffffff8b5a8b4e RDI: 0000000000000003
RBP: ffffffff824e37fd R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1c0c6f3 R12: 0000000000000000
R13: 000000000000001c R14: 000000000000001c R15: 0000000000000001
FS:  000055556de07500(0000) GS:ffff888125f8b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f09c332b5a0 CR3: 00000000750b0000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   7:	00
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
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
  18:	0f 1f 40 d6          	nopl   -0x2a(%rax)
  1c:	48 c1 ef 03          	shr    $0x3,%rdi
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	0f b6 04 07          	movzbl (%rdi,%rax,1),%eax <-- trapping instruction
  2e:	3c 08                	cmp    $0x8,%al
  30:	0f 92 c0             	setb   %al
  33:	e9 40 01 33 09       	jmp    0x9330178
  38:	cc                   	int3
  39:	66                   	data16
  3a:	66                   	data16
  3b:	66                   	data16
  3c:	66                   	data16
  3d:	66                   	data16
  3e:	66                   	data16
  3f:	2e                   	cs


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

