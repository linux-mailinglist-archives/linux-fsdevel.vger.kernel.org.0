Return-Path: <linux-fsdevel+bounces-40519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5F7A24435
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 21:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735F23A5B11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 20:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC7F1F3D3B;
	Fri, 31 Jan 2025 20:47:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC2C1EF080
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 20:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738356444; cv=none; b=mKdyuozXDpJV5dGJu1k51EpG4sXXqbyFhrZ16SXaDe3QpF8g1tzBmXE+WmRHuQFn0CZ3IL7tH6lk6Ux518xYtn9scOBCDxb2gUovJ8/K373Iji6YzfdvkQh4liVZtTBB2tsMcGO3yXtKPgGpVyFNX6p8lMHRPOjhrPOxoQwFQK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738356444; c=relaxed/simple;
	bh=e/gTZxss4LxFBPZREY81yf8aC1f/c+paHFt3OUCRlDg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kUu7u3ftNJ6uoNTnonjOvpSF7sjLEThssRt0nEaq8p5++gj1XjB7zpBlyKZo/12qWscuKPWzGbv0SQuEri+57WPc7aVNynxBsaqGT5alhtajxza4oQfDbzMqHR3ETv1n1RJk7HddbFkeisMIlkOUvEWvNlTHVuFhVGa/OtjdJQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3cfba354f79so50375065ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 12:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738356442; x=1738961242;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8F2G+r7aSpY8YLQ53HheMpEmxlRLaQjCaOK6PM0IEPI=;
        b=wp/hnuc5tMnyBZ8ilaA2hxPXo3bNgNE79p70+2bjurUEJoaFurmvC0AUmIoq/WvHG9
         RgzY8xeRvbQ2toX1ysu30fH5m01ibVk9EblQ0NzEbeuxNeyiYZ+0sYBOxH3vjZPVQdyT
         AdRs6xuj48zqhVbtSSVZjB4KiqXFpjVFn2ArFgC5mOY7rAgPEkHRDsMJPcfdHjiN9qlP
         O/35lS/VB142/QWTDnxkLUiHC4Dk6OvucXBNXUZKqJuRbWswxbCP90lKb+m2PZCxTnsF
         yrZQdR4Zs50W1Yg19np+XuqDktCriAOo3qOSxW7x+rirLLqA6h58HAk93FQyqsxP6UQg
         FW/g==
X-Forwarded-Encrypted: i=1; AJvYcCVPBvkyEqCyVfONfLymujDLxxF8UzbsjELbVkKAb7ktKsvcGwGdxIP56w/xtVyLcZYYISnYfSb5C3LmKmng@vger.kernel.org
X-Gm-Message-State: AOJu0YzO+fB4Z55+TeXnYWp8znTVUuumW/XNaywQdt5KDc7QSXo82zTf
	NjRWIQIUjo+iNIaMtt0RVKVUJqcZ8dzZoxcUdTaBngdXJ6ZToUzrCxb13l30NNZn97Klve4O2gK
	YKq4d4pKxAGfaR101YPshywn/v59JSUaji7t+P9upAHHxsP24sINpyLw=
X-Google-Smtp-Source: AGHT+IHZGhYVvjPWoqMaEiB6SXO1q6VGhKzy4Ig3Jl2OirK+HgSDg3JVRl3NMkFePJ7TyOO6CLOKOSfasR6hQJDrCYZ/OcWvIGxi
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160b:b0:3cf:cdb6:ce3d with SMTP id
 e9e14a558f8ab-3cffe3d42bbmr107020475ab.8.1738356442308; Fri, 31 Jan 2025
 12:47:22 -0800 (PST)
Date: Fri, 31 Jan 2025 12:47:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <679d36da.050a0220.163cdc.0010.GAE@google.com>
Subject: [syzbot] [fs?] WARNING: bad unlock balance in seq_read_iter
From: syzbot <syzbot+c041985778e4069e1ce3@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127f4518580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d83cc1742b7377
dashboard link: https://syzkaller.appspot.com/bug?extid=c041985778e4069e1ce3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1493f6b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c2dddf980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3d07b0558b0e/disk-69e858e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e5e2250eb3b1/vmlinux-69e858e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e676d17effc/bzImage-69e858e0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c041985778e4069e1ce3@syzkaller.appspotmail.com

Code: 48 83 c4 28 c3 e8 17 1a 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe566caee8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007ffe566caef0 RCX: 00007f1f6401a2e9
RDX: 0000000000006c64 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007ffe566cac87 R09: 00007f1f64080032
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f1f64085618
R13: 00007ffe566cb0c8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
=====================================
WARNING: bad unlock balance detected!
6.13.0-syzkaller-09760-g69e858e0b8b2 #0 Not tainted
-------------------------------------
syz-executor359/5828 is trying to release lock (event_mutex) at:
[<ffffffff8239231f>] seq_read_iter+0x5ff/0x12b0 fs/seq_file.c:251
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz-executor359/5828:
 #0: ffff88802fd120a0 (&p->lock){+.+.}-{4:4}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182

stack backtrace:
CPU: 0 UID: 0 PID: 5828 Comm: syz-executor359 Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_unlock_imbalance_bug kernel/locking/lockdep.c:5289 [inline]
 print_unlock_imbalance_bug+0x1aa/0x1f0 kernel/locking/lockdep.c:5263
 __lock_release kernel/locking/lockdep.c:5528 [inline]
 lock_release+0x525/0x6f0 kernel/locking/lockdep.c:5872
 __mutex_unlock_slowpath+0xa3/0x6a0 kernel/locking/mutex.c:891
 seq_read_iter+0x5ff/0x12b0 fs/seq_file.c:251
 seq_read+0x39f/0x4e0 fs/seq_file.c:162
 vfs_read+0x1df/0xbf0 fs/read_write.c:563
 ksys_read+0x12b/0x250 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1f6401a2e9
Code: 48 83 c4 28 c3 e8 17 1a 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe566caee8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007ffe566caef0 RCX: 00007f1f6401a2e9
RDX: 0000000000006c64 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00007ffe566cac87 R09: 00007f1f64080032
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f1f64085618
R13: 00007ffe566
----------------
Code disassembly (best guess):
   0:	48 83 c4 28          	add    $0x28,%rsp
   4:	c3                   	ret
   5:	e8 17 1a 00 00       	call   0x1a21
   a:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
* 2a:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax <-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 c7 c1 b8 ff ff ff 	mov    $0xffffffffffffffb8,%rcx
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W


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

