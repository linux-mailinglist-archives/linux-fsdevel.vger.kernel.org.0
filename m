Return-Path: <linux-fsdevel+bounces-42729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE90A46D85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 22:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 132B67A070C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 21:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2AB25D534;
	Wed, 26 Feb 2025 21:31:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6F025B672
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605488; cv=none; b=M5t1bPZ8OiYkxfyQmHjXY4zdyNfkERWDdMiqGAF5Jczgaa7lFv+lf+CrdbVZ+WXkfXjtTl31RGqunMCkU//pqI8/EFT2H4q+qSAes5Wb8gmzqKENV0cLf/qwLTefPLiBP4K7Tok0Y6NZT7oG+OlFXJT08a66epJFQbGXpmu6sDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605488; c=relaxed/simple;
	bh=vSbZ1lPOoxuzg5lFT8+PpZWymmTjFZjRf042CFA1t2w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c6nUODFyY0FCvpn9rKlXdcFGzC8VZXd8/2Lf9qov2STNIdZN2Yqn6XwaLCXG5vNsqd4tR53mVzy37dHBY/QqwI36FrCPJp4nW2cdVEKSEHFGKfYE73NfOIYjNPgYuqLCqpajJWYQXnzGJbAEL4Urqap8MRXYOI8ziCbrdpHH3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d2abf829dfso2849125ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 13:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740605486; x=1741210286;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMg9TKcK2cdynHcTZsurS/dwdlNwTi87E4QCDwHb/EE=;
        b=gW/Kv4PimYTZSuD9yyg2KNMClcVvnh+EGNQ1uZvZe6iqVtOoo7f2Cf9emkIoLVdYxu
         gLlBI4qMD3oJ8lfVgUZfO+M5vDPBLcCYuJDVglw4M1sPcimwpfkFCgYnfp1z3/6/gOsl
         Odk3mmuhrF5AFompBF/ku0iTQv3ajEdRsYx4n479C/5vNdBFdcU8uCurbDlQtt/MpqwD
         wsY53b7siyL3LsUrff4cEewA2HxnySyfWaedCY11ohW9Yy/al+IeGp1RpeuJCg4aTN2J
         5Rw942eyOelV2qndo0T7u5DATsEqpwQSuaQuWgFTjtaC/Nm3ZspJkYNIbUpXycntzxUE
         LgiA==
X-Forwarded-Encrypted: i=1; AJvYcCVnHDqPYoWPeSGMTSBGAFPwyp80Xwbnz7zNxDHauJ4UXXZ/xxXouW7CS6GpFHqClDWcKHGLPQX59mRxSWW4@vger.kernel.org
X-Gm-Message-State: AOJu0YxHZW04QjgJ73DGcy0R1mG+Uu4TEJp7ooCP2yDILRNO8/AU6jFg
	KZ0XtvTwJfzwRgij53HN2nWgxGFykEpT5vQwBrGgUacyuZKwEedb3XPhMiuelhfuDa7acZ3Jp+8
	gsQUkwrOnjRf3+GHUtHhUxc3mioGHc8O8hc2L2wxkNw4+lPlg/TFUmvw=
X-Google-Smtp-Source: AGHT+IGYhbAVzVS3Ypz1KgMy51SCImn3S/MXG2pbnx+AyQusLkCGLdiV6Fc3oPnWxO3rkSqPQHQ5oljoOePqXoUInwhBCWT93Xvn
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d08:b0:3cf:bac5:d90c with SMTP id
 e9e14a558f8ab-3d30487a1abmr95952345ab.18.1740605486114; Wed, 26 Feb 2025
 13:31:26 -0800 (PST)
Date: Wed, 26 Feb 2025 13:31:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bf882e.050a0220.1ebef.008f.GAE@google.com>
Subject: [syzbot] [fs?] WARNING: bad unlock balance in traverse
From: syzbot <syzbot+0b16dd9bd622c40b2bbe@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ac9c34d1e45a Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165b9c98580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1635bf4c5557b92
dashboard link: https://syzkaller.appspot.com/bug?extid=0b16dd9bd622c40b2bbe
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152b003f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ed21c75da715/disk-ac9c34d1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f51096fe566c/vmlinux-ac9c34d1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e6a27961fbbe/bzImage-ac9c34d1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b16dd9bd622c40b2bbe@syzkaller.appspotmail.com

Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdab0827c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000011
RAX: ffffffffffffffda RBX: 00007f06103a5fa0 RCX: 00007f061018d169
RDX: 0000000000000400 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007ffdab082820 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000009871 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f06103a5fa0 R14: 00007f06103a5fa0 R15: 0000000000000004
 </TASK>
=====================================
WARNING: bad unlock balance detected!
6.14.0-rc4-syzkaller-00052-gac9c34d1e45a #0 Not tainted
-------------------------------------
syz.0.17/6067 is trying to release lock (event_mutex) at:
[<ffffffff82399e2d>] traverse.part.0.constprop.0+0x2bd/0x640 fs/seq_file.c:131
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz.0.17/6067:
 #0: ffff888032e872f0 (&p->lock){+.+.}-{4:4}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182

stack backtrace:
CPU: 1 UID: 0 PID: 6067 Comm: syz.0.17 Not tainted 6.14.0-rc4-syzkaller-00052-gac9c34d1e45a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_unlock_imbalance_bug kernel/locking/lockdep.c:5289 [inline]
 print_unlock_imbalance_bug+0x1aa/0x1f0 kernel/locking/lockdep.c:5263
 __lock_release kernel/locking/lockdep.c:5528 [inline]
 lock_release+0x525/0x6f0 kernel/locking/lockdep.c:5872
 __mutex_unlock_slowpath+0xa3/0x6a0 kernel/locking/mutex.c:891
 traverse.part.0.constprop.0+0x2bd/0x640 fs/seq_file.c:131
 traverse fs/seq_file.c:98 [inline]
 seq_read_iter+0x934/0x12b0 fs/seq_file.c:195
 seq_read+0x39f/0x4e0 fs/seq_file.c:162
 vfs_read+0x1df/0xbf0 fs/read_write.c:563
 ksys_pread64 fs/read_write.c:756 [inline]
 __do_sys_pread64 fs/read_write.c:764 [inline]
 __se_sys_pread64 fs/read_write.c:761 [inline]
 __x64_sys_pread64+0x1f6/0x250 fs/read_write.c:761
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f061018d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdab0827c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000011
RAX: ffffffffffffffda RBX: 00007f06103a5fa0 RCX: 00007f061018d169
RDX: 0000000000000400 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007ffdab082820 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000009871 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f06103a5fa0 R14: 00007f06103a5fa0 R15: 0000000000000004
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	ff c3                	inc    %ebx
   2:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00
   c:	0f 1f 40 00          	nopl   0x0(%rax)
  10:	48 89 f8             	mov    %rdi,%rax
  13:	48 89 f7             	mov    %rsi,%rdi
  16:	48 89 d6             	mov    %rdx,%rsi
  19:	48 89 ca             	mov    %rcx,%rdx
  1c:	4d 89 c2             	mov    %r8,%r10
  1f:	4d 89 c8             	mov    %r9,%r8
  22:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  27:	0f 05                	syscall
* 29:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax <-- trapping instruction
  2f:	73 01                	jae    0x32
  31:	c3                   	ret
  32:	48 c7 c1 a8 ff ff ff 	mov    $0xffffffffffffffa8,%rcx
  39:	f7 d8                	neg    %eax
  3b:	64 89 01             	mov    %eax,%fs:(%rcx)
  3e:	48                   	rex.W


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

