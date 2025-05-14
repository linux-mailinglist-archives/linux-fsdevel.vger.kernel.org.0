Return-Path: <linux-fsdevel+bounces-48994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B55AB7304
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 19:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C1A4C6881
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 17:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80472283FD9;
	Wed, 14 May 2025 17:39:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371622820C7
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244377; cv=none; b=SamI/U9nJar1KGUDu/zlH4Q506Fd0LKhB5CGkxck39QF40KnMCKegDRlmzAbmatPy3BGho+S1Lec7JsWPXu9rcAc8Fa60Y7AGwZVp+k+0iVaxzyq8JC/EXshjr+gVw1+QTiA93+w9zwKoCMG9zoBOGcN7MocqwVKRwS63bHhjv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244377; c=relaxed/simple;
	bh=P60oCLcDrdUwtGdNHayln3q6TmR6kM8Yph3/LG9T5W4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uFUuM+ALLgXJyEvRQyDJTOnuBqFBhHJ1t6muYOJ5PMhf0RTpW3GikSriSK3z1nLTmL33LOmQBNZR+hCh8vjuS2VpN5OdZMl+TijVXPjFP9ihHfdI6/ATQXFNMElUobFOLubzkdOPKdYUXZwvJYddjGAnKH6SSFeG5e0pIbiMf1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3db6dc76193so568275ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 10:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244374; x=1747849174;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4td5ZvB12f4GIO9XjioyIOmoiX2OFM6YxSWuLsZQPe0=;
        b=Mo30+aWDRMiNSNQnmQGYPuv/mASany5EyiYjXQ8HJHdnFh/KRGGF/em8T1LT3aVbB3
         Z0mFZyQToRYd4L3sNSJ1sQlp2WF7HJmMq+R7qeHh+v0FN+i/in0hl39srvXP8K6o4Y6m
         JDFvA+U3Rl6BqYXIC7CJMkG/ixc5sUpzJ1Up5uscQjj8xmXnHfMX6wl5G6+M9n60GmlJ
         FTwQ1t3wf/+HZEkw6Bb0a6rID4NWcWVsSioq2cA6LRhwPmt/yebbAz44+CfkxCQuGK3R
         fpI7YKfnpSAT/DdpWmApSGEbrMzSDDcDPcL2ahdFAZFBnZa46T4Ezvi9sh4Fg7oOE5MN
         Zm+A==
X-Forwarded-Encrypted: i=1; AJvYcCXBAZxLlc5sByKMoJ0yLDLRbKpA4yRMDutQceZIhBcN7LdkWc1GFXCWo/2h5nrmKnD9kSDAVNJ1Nng0xkFn@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZjPN81El8Rv9ShHLPe3b7x996n+cmAkEk41yx3/wmb/mAXVQ
	132uLdzvAbMBvQBxL3hDBPIA3AIscCf+GmLWSWBGGFJfzeFDf+3XU8/w2eJ0GaLGB1FMEVkxDxm
	rvi+ry7IfRJLw9/pracyZkxSzsLlZk3/sHuayHM/roG3D9GHXk7PNCW4=
X-Google-Smtp-Source: AGHT+IHZm4fZcliofXwf/INTb7fvK7RjZwaMLifmbJTjLC4LeFAtW/nzNy/5AKHw2k5CvzKYCobhF4GhtXBqmvoFeeWTz7v0tuBq
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4414:10b0:3db:72f7:d7be with SMTP id
 e9e14a558f8ab-3db72f7dbdcmr19492295ab.3.1747244374281; Wed, 14 May 2025
 10:39:34 -0700 (PDT)
Date: Wed, 14 May 2025 10:39:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6824d556.a00a0220.104b28.0012.GAE@google.com>
Subject: [syzbot] [xfs?] general protection fault in do_move_mount (3)
From: syzbot <syzbot+799d4cf78a7476483ba2@syzkaller.appspotmail.com>
To: brauner@kernel.org, cem@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bec6f00f120e Merge tag 'usb-6.15-rc6' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1030b4d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9683d529ec1b880
dashboard link: https://syzkaller.appspot.com/bug?extid=799d4cf78a7476483ba2
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17eb1670580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17794cf4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f0524618260b/disk-bec6f00f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/130c881068f0/vmlinux-bec6f00f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cb7c13b37bb0/bzImage-bec6f00f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/291441c6276e/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=13eb1670580000)

The issue was bisected to:

commit 267fc3a06a37bec30cc5b4d97fb8409102bc7a9d
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue Apr 29 01:43:23 2025 +0000

    do_move_mount(): don't leak MNTNS_PROPAGATING on failures

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16979670580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15979670580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11979670580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+799d4cf78a7476483ba2@syzkaller.appspotmail.com
Fixes: 267fc3a06a37 ("do_move_mount(): don't leak MNTNS_PROPAGATING on failures")

XFS (loop0): Ending clean mount
XFS (loop0): Quotacheck needed: Please wait.
XFS (loop0): Quotacheck: Done.
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 1 UID: 0 PID: 5821 Comm: syz-executor358 Not tainted 6.15.0-rc5-syzkaller-00275-gbec6f00f120e #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:is_anon_ns fs/mount.h:165 [inline]
RIP: 0010:do_move_mount+0x27d/0xb10 fs/namespace.c:3725
Code: e8 98 53 85 ff 41 be ea ff ff ff 49 bd 00 00 00 00 00 fc ff df 48 8b 6c 24 18 4c 8b 7c 24 08 48 8d 5d 48 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 54 22 e5 ff 48 8b 1b 31 ff 48 89
RSP: 0018:ffffc90004197d50 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000032 RCX: ffff888034268000
RDX: 0000000000000000 RSI: ffffffff8d9214e1 RDI: ffff88801b2d77b8
RBP: ffffffffffffffea R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8238eb99 R12: ffffffff8dde9718
R13: dffffc0000000000 R14: 00000000ffffffea R15: ffff88803401e480
FS:  0000555582a39380(0000) GS:ffff888126200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 000000003414c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __do_sys_move_mount fs/namespace.c:4678 [inline]
 __se_sys_move_mount+0x41e/0x580 fs/namespace.c:4616
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7effb3efc739
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcb2b585e8 EFLAGS: 00000246 ORIG_RAX: 00000000000001ad
RAX: ffffffffffffffda RBX: 00007ffcb2b587b8 RCX: 00007effb3efc739
RDX: 00000000ffffff9c RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007effb3f78610 R08: 0000000000000224 R09: 00007ffcb2b587b8
R10: 0000200000000040 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffcb2b587a8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:is_anon_ns fs/mount.h:165 [inline]
RIP: 0010:do_move_mount+0x27d/0xb10 fs/namespace.c:3725
Code: e8 98 53 85 ff 41 be ea ff ff ff 49 bd 00 00 00 00 00 fc ff df 48 8b 6c 24 18 4c 8b 7c 24 08 48 8d 5d 48 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 54 22 e5 ff 48 8b 1b 31 ff 48 89
RSP: 0018:ffffc90004197d50 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000032 RCX: ffff888034268000
RDX: 0000000000000000 RSI: ffffffff8d9214e1 RDI: ffff88801b2d77b8
RBP: ffffffffffffffea R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8238eb99 R12: ffffffff8dde9718
R13: dffffc0000000000 R14: 00000000ffffffea R15: ffff88803401e480
FS:  0000555582a39380(0000) GS:ffff888126200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 000000003414c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 98 53 85 ff       	call   0xff85539d
   5:	41 be ea ff ff ff    	mov    $0xffffffea,%r14d
   b:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  12:	fc ff df
  15:	48 8b 6c 24 18       	mov    0x18(%rsp),%rbp
  1a:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
  1f:	48 8d 5d 48          	lea    0x48(%rbp),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 54 22 e5 ff       	call   0xffe5228d
  39:	48 8b 1b             	mov    (%rbx),%rbx
  3c:	31 ff                	xor    %edi,%edi
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89


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

