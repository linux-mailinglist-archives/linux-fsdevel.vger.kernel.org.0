Return-Path: <linux-fsdevel+bounces-42349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B551A40C84
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 02:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B91189EBF7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 01:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6AE134AB;
	Sun, 23 Feb 2025 01:59:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E5CA4E
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 01:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740275965; cv=none; b=uKAvft9uN2fbC+my1GYaN4vN7/AFnRICc5IwDfPuxdPhCl1h7IW8c0VLVTSHXmf7OrIx1IYPN+ChbDD0PSCn1FG5u9/K+/KdqUFF6x8c3gcv6hX9+aXECrgK0HeSarSLyWffv+L/9LVwjJBrjHP2UwK2AvZu1/tD5bxjAb6m564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740275965; c=relaxed/simple;
	bh=C6NexCZcmMBXF1Jgmbz8maJzkIwlOfq8MmCLJlGbj4s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YMJX386WU520dZ4lZSnghtIE0fcsKbgwGBzjpxyyoxDfCvWXvRLApm7A/JrkUcFn2gWPgGqQ0UwWL4pLjtfb+qnWaUu1ws5hVx5BLqeIutTE4Hpz+uf+qGXfJuVTLZ85Qu7C0Oy4IOAWkVJsiIi1v20REUiG8lseGYn8Zk4Yw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d054d79dacso66132065ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2025 17:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740275963; x=1740880763;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5BWa4yWbtHsKBQe7Hktc25pO5o4y3nqP4mnMPyY5UZw=;
        b=R0dfdJSntqtazjHO7YD8zRx8CQiU0hpTVzLXFnWt7mqzr8yKNdUe/2I6lR+BT4wzaM
         nvvVSKLrH2be8uK84fgmKIQerATAm+QpTfokF5JizJ3oQQYf5a8lUVzO2S8C6AAQ1q0C
         Ilfy+9ZeI56so9vJhkJD0XWQyF2xpj7qPzzLzfnBBqTxY48xMw0RMuFwWTVHVRhyinDn
         UpmuVIBxYZ9oHGJgWzh4oYjFqpCtiTCWYpgqlxmMdbAoUpcXOp4rtoJB/a8zSfOOCzE2
         PsQ9Iii1+AXApPTVgFeNVWSzK0tz5HOz880g4u+rFFXVyLcBh19QYpVHaHl6z3X9fCHj
         YwWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW77nJgM3+mIadq72d2+Hw3RShpboreOJyzGrt/SBNRc08uXL+qlJWpX747X4GLJiFuyFXv+vA51uURxjcq@vger.kernel.org
X-Gm-Message-State: AOJu0YyeHftUrcPXB3zlsn88Pb53vgCGVsFPIhvr7Kmdumnc0FyKuduh
	KC1fKIx3c15o0ZPf9P/6JeIkYqnc2FjGPTQr14ksDIHxVHCt1Nj4R1920THyNEGJP4D5FQqxE9B
	b47+d0EWNm9nxktNnpEz7ZWcMB9+H6bHym4DbInlYRAAlnGWZMTtmlWM=
X-Google-Smtp-Source: AGHT+IEeOI+IM75q6/FYF1DBx04ARhKshPmrLepbleVxxId8JaawXB95tKyxAQvuUJC2bxH+DSjeBtFs5tUIeb3+TdTX5l6DvXZ6
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:23c1:b0:3cf:fb97:c313 with SMTP id
 e9e14a558f8ab-3d2caf01835mr103968455ab.18.1740275963092; Sat, 22 Feb 2025
 17:59:23 -0800 (PST)
Date: Sat, 22 Feb 2025 17:59:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ba80fb.050a0220.bbfd1.000a.GAE@google.com>
Subject: [syzbot] [bcachefs?] INFO: trying to register non-static key in d_splice_alias
From: syzbot <syzbot+099785fe1f1da3e8a1cb@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6537cfb395f3 Merge tag 'sound-6.14-rc4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c1a498580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=099785fe1f1da3e8a1cb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1080fbf8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-6537cfb3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f0fee59b531/vmlinux-6537cfb3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ebf361d1fa57/bzImage-6537cfb3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/79ce9b36e5f4/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+099785fe1f1da3e8a1cb@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 4732 Comm: udevd Not tainted 6.14.0-rc3-syzkaller-00060-g6537cfb395f3 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 assign_lock_key+0x241/0x280 kernel/locking/lockdep.c:983
 register_lock_class+0x1cf/0x980 kernel/locking/lockdep.c:1297
 __lock_acquire+0xf3/0x2100 kernel/locking/lockdep.c:5103
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 lockref_get+0x15/0x60 lib/lockref.c:50
 __d_find_any_alias fs/dcache.c:970 [inline]
 d_splice_alias+0xdf/0x330 fs/dcache.c:3020
 __lookup_slow+0x296/0x400 fs/namei.c:1793
 lookup_slow+0x53/0x70 fs/namei.c:1810
 walk_component fs/namei.c:2114 [inline]
 link_path_walk+0x99b/0xea0 fs/namei.c:2479
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
RIP: 0033:0x7f3f5f3169a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffe3a832a00 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f3f5f3169a4
RDX: 0000000000080000 RSI: 00007ffe3a832b38 RDI: 00000000ffffff9c
RBP: 00007ffe3a832b38 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 000055a830a2db42 R14: 0000000000000001 R15: 0000000000000000
 </TASK>
Oops: general protection fault, probably for non-canonical address 0xdffffc0020000017: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: probably user-memory-access in range [0x00000001000000b8-0x00000001000000bf]
CPU: 0 UID: 0 PID: 4732 Comm: udevd Not tainted 6.14.0-rc3-syzkaller-00060-g6537cfb395f3 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
RIP: 0010:do_raw_spin_lock+0x7f/0x370 kernel/locking/spinlock_debug.c:115
Code: 48 8d 74 24 40 48 c1 ee 03 48 b8 f1 f1 f1 f1 04 f3 f3 f3 48 89 f1 48 89 74 24 38 48 89 04 16 48 8d 5f 04 48 89 d8 48 c1 e8 03 <0f> b6 04 10 84 c0 0f 85 f6 01 00 00 8b 03 3d ad 4e ad de 0f 85 62
RSP: 0018:ffffc900026df5e0 EFLAGS: 00010206
RAX: 0000000020000017 RBX: 00000001000000bb RCX: 1ffff920004dbec4
RDX: dffffc0000000000 RSI: 1ffff920004dbec4 RDI: 00000001000000b7
RBP: ffffc900026df6a8 R08: ffffffff903ce777 R09: 1ffffffff2079cee
R10: dffffc0000000000 R11: fffffbfff2079cef R12: 00000001000000b7
R13: ffff888031f23028 R14: ffff888031fa4758 R15: dffffc0000000000
FS:  00007f3f5f78f280(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7bf01e4270 CR3: 000000001f28c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 spin_lock include/linux/spinlock.h:351 [inline]
 lockref_get+0x15/0x60 lib/lockref.c:50
 dget include/linux/dcache.h:352 [inline]
 d_splice_alias+0x1bb/0x330 fs/dcache.c:3036
 __lookup_slow+0x296/0x400 fs/namei.c:1793
 lookup_slow+0x53/0x70 fs/namei.c:1810
 walk_component fs/namei.c:2114 [inline]
 link_path_walk+0x99b/0xea0 fs/namei.c:2479
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
RIP: 0033:0x7f3f5f3169a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffe3a832a00 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f3f5f3169a4
RDX: 0000000000080000 RSI: 00007ffe3a832b38 RDI: 00000000ffffff9c
RBP: 00007ffe3a832b38 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 000055a830a2db42 R14: 0000000000000001 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
RIP: 0010:do_raw_spin_lock+0x7f/0x370 kernel/locking/spinlock_debug.c:115
Code: 48 8d 74 24 40 48 c1 ee 03 48 b8 f1 f1 f1 f1 04 f3 f3 f3 48 89 f1 48 89 74 24 38 48 89 04 16 48 8d 5f 04 48 89 d8 48 c1 e8 03 <0f> b6 04 10 84 c0 0f 85 f6 01 00 00 8b 03 3d ad 4e ad de 0f 85 62
RSP: 0018:ffffc900026df5e0 EFLAGS: 00010206
RAX: 0000000020000017 RBX: 00000001000000bb RCX: 1ffff920004dbec4
RDX: dffffc0000000000 RSI: 1ffff920004dbec4 RDI: 00000001000000b7
RBP: ffffc900026df6a8 R08: ffffffff903ce777 R09: 1ffffffff2079cee
R10: dffffc0000000000 R11: fffffbfff2079cef R12: 00000001000000b7
R13: ffff888031f23028 R14: ffff888031fa4758 R15: dffffc0000000000
FS:  00007f3f5f78f280(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7bf01e4270 CR3: 000000001f28c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
   5:	48 c1 ee 03          	shr    $0x3,%rsi
   9:	48 b8 f1 f1 f1 f1 04 	movabs $0xf3f3f304f1f1f1f1,%rax
  10:	f3 f3 f3
  13:	48 89 f1             	mov    %rsi,%rcx
  16:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
  1b:	48 89 04 16          	mov    %rax,(%rsi,%rdx,1)
  1f:	48 8d 5f 04          	lea    0x4(%rdi),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 f6 01 00 00    	jne    0x22c
  36:	8b 03                	mov    (%rbx),%eax
  38:	3d ad 4e ad de       	cmp    $0xdead4ead,%eax
  3d:	0f                   	.byte 0xf
  3e:	85                   	.byte 0x85
  3f:	62                   	.byte 0x62


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

