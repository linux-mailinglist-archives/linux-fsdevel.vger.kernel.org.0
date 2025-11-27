Return-Path: <linux-fsdevel+bounces-70084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D39C90384
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 22:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B6604E125D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 21:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671EA32AAB0;
	Thu, 27 Nov 2025 21:42:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2528432861D
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764279750; cv=none; b=iQNHvj0Q46EC50RpLvZwtDd7cliEL4Q4eIxJxxBhviciP8x4pTqC6ztdnc9WFNdlCsRC91OTnkMB7miKMRcAfHp1kWyWaV5MuaZkg1RECCii1F9mRj3WLKM5LRQpYg+7swFgGSADSLTZPUK/cDT7jD5mseH7sz0XCl8VdO95qL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764279750; c=relaxed/simple;
	bh=VRb29Zfkk7Z6km9AbZOepCWPVPS5/jShh4rFJBcqIpg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Hqc7tbuO5v8qnrZYgVuhjJgERN2qHVcaVTfb6yd+h54JDYLhjimm3j5EMv//pljtF40NoIl3RhuwW3Fzu9byjcoAKDbelhrNnHoNIXexJPcURgZCBRCl8/QjqU64fjujdJYBGWNreMdNGaYmUW0EFw6h83qXX1xXCuXZhwJatYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-4330f62ef60so9179515ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 13:42:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764279747; x=1764884547;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G83nfTE4SNLh2IU5IogCa97jCg78w7cvpuDNkTzfkf8=;
        b=V4NfGZSRjWDURgLzfT8AuzUv0aaSfAhpVvmJ9z+w4ga6fQxKVEuzyn4hZ2lDVNYRyB
         QNBBt5RGTHBi0Ctrk5Gn12bIsPbtZBuV1uss0Sz28FRRCRjMYltNwOiAmeGg+fCUaDHY
         9BEsVH71cO40OSOf07gw475MkAWbf8tyLWz4r/5HhrYSPU6gR8zngJV1YlKMGLjNZLgy
         l+PKS2XNsLGxxAEzv22mgRxm5HIp/kGs16NMBE/Dnqd2DEeJTjf5Mh5QOrDBI35aH3aJ
         7PJNjYMduo/nx1jWvBZ4lh5N/5ngLDR6Q1ai+s7/SEpavSkxbop4gcKiqF+WKiGQ1Prh
         SeZA==
X-Forwarded-Encrypted: i=1; AJvYcCX7MZdI5dkVr429QgQFgN6HNw2cyf6zZgqTLiIwkO/L5hMgHiUqqsqz/Jbq4FNDbHCEzSjq2DBYsIUuhlql@vger.kernel.org
X-Gm-Message-State: AOJu0YzB8dN8BiFn83QOrv8GoD0StLU2GXpb5jGx9BB+2Gjf8wVtOR0J
	NPOvGt7CrJYwJtntWUR2FsNtzgr5HPjVmqDYJ9EI+uhA/eUW5ccLBjbAGDxnoG5Ag6+ETPt6tLR
	I3T24Xjm0iyW2KVYJRrh9sFLpKlS4UELdvw0DfVgB/yHT++1zg7jN+3rFBNo=
X-Google-Smtp-Source: AGHT+IGvyH8CEXkBdFB4JzNpK1eelslDd70ahqIzqsAsyfrB7/61m+XVa9JJzCXVfbtFj/GufI4EK3lcDtQMekVqphL7gFye/f0j
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:220b:b0:433:2dbd:e93c with SMTP id
 e9e14a558f8ab-435b8e3d746mr205040265ab.4.1764279747289; Thu, 27 Nov 2025
 13:42:27 -0800 (PST)
Date: Thu, 27 Nov 2025 13:42:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6928c5c3.a70a0220.d98e3.011a.GAE@google.com>
Subject: [syzbot] [fs?] general protection fault in mntput
From: syzbot <syzbot+94048264da5715c251f9@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    92fd6e84175b Add linux-next specific files for 20251125
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13a55612580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf77a4e0e3514deb
dashboard link: https://syzkaller.appspot.com/bug?extid=94048264da5715c251f9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1215f612580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17082f42580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bee2604d495b/disk-92fd6e84.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b12aade49e2c/vmlinux-92fd6e84.xz
kernel image: https://storage.googleapis.com/syzbot-assets/286fd34158cb/bzImage-92fd6e84.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+94048264da5715c251f9@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000023: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
CPU: 0 UID: 0 PID: 6414 Comm: syz.3.69 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:mntput+0x31/0xc0 fs/namespace.c:1430
Code: 41 56 41 54 53 48 89 fb e8 1c da 7e ff 48 85 db 74 47 49 bf 00 00 00 00 00 fc ff df 4c 8d b3 24 01 00 00 4d 89 f4 49 c1 ec 03 <43> 0f b6 04 3c 84 c0 75 50 48 83 c3 e0 41 8b 2e 31 ff 89 ee e8 26
RSP: 0018:ffffc9000462fd90 EFLAGS: 00010202
RAX: ffffffff8242c664 RBX: fffffffffffffff4 RCX: ffff888077aa5b80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: fffffffffffffff4
RBP: ffffc9000462fed0 R08: ffff888077aa5b87 R09: 1ffff1100ef54b70
R10: dffffc0000000000 R11: ffffed100ef54b71 R12: 0000000000000023
R13: dffffc0000000000 R14: 0000000000000118 R15: dffffc0000000000
FS:  00007fdf2c77f6c0(0000) GS:ffff888125e8b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555575df7808 CR3: 0000000076002000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __do_sys_fsmount fs/namespace.c:4380 [inline]
 __se_sys_fsmount+0x893/0xa90 fs/namespace.c:4279
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdf2b98f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdf2c77f038 EFLAGS: 00000246 ORIG_RAX: 00000000000001b0
RAX: ffffffffffffffda RBX: 00007fdf2bbe6180 RCX: 00007fdf2b98f749
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007fdf2ba13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdf2bbe6218 R14: 00007fdf2bbe6180 R15: 00007ffd8048bbc8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mntput+0x31/0xc0 fs/namespace.c:1430
Code: 41 56 41 54 53 48 89 fb e8 1c da 7e ff 48 85 db 74 47 49 bf 00 00 00 00 00 fc ff df 4c 8d b3 24 01 00 00 4d 89 f4 49 c1 ec 03 <43> 0f b6 04 3c 84 c0 75 50 48 83 c3 e0 41 8b 2e 31 ff 89 ee e8 26
RSP: 0018:ffffc9000462fd90 EFLAGS: 00010202
RAX: ffffffff8242c664 RBX: fffffffffffffff4 RCX: ffff888077aa5b80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: fffffffffffffff4
RBP: ffffc9000462fed0 R08: ffff888077aa5b87 R09: 1ffff1100ef54b70
R10: dffffc0000000000 R11: ffffed100ef54b71 R12: 0000000000000023
R13: dffffc0000000000 R14: 0000000000000118 R15: dffffc0000000000
FS:  00007fdf2c77f6c0(0000) GS:ffff888125f8b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd4a51d5e8 CR3: 0000000076002000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	41 56                	push   %r14
   2:	41 54                	push   %r12
   4:	53                   	push   %rbx
   5:	48 89 fb             	mov    %rdi,%rbx
   8:	e8 1c da 7e ff       	call   0xff7eda29
   d:	48 85 db             	test   %rbx,%rbx
  10:	74 47                	je     0x59
  12:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  19:	fc ff df
  1c:	4c 8d b3 24 01 00 00 	lea    0x124(%rbx),%r14
  23:	4d 89 f4             	mov    %r14,%r12
  26:	49 c1 ec 03          	shr    $0x3,%r12
* 2a:	43 0f b6 04 3c       	movzbl (%r12,%r15,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	75 50                	jne    0x83
  33:	48 83 c3 e0          	add    $0xffffffffffffffe0,%rbx
  37:	41 8b 2e             	mov    (%r14),%ebp
  3a:	31 ff                	xor    %edi,%edi
  3c:	89 ee                	mov    %ebp,%esi
  3e:	e8                   	.byte 0xe8
  3f:	26                   	es


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

