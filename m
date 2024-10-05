Return-Path: <linux-fsdevel+bounces-31051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869979914CC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 08:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91EE1C22009
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 06:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CC54D8CB;
	Sat,  5 Oct 2024 06:07:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4973F380
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728108443; cv=none; b=T6qd1K8iQ15EVbicWyPLWrdLPjjiuqCDeqWJIuevHna/T7cnBykP6WXZobACTsS1d/QVXVtkjDe5a9lrNcIDlY7Gi63XcD/eenj7qLHwqmN3rUWODJkM0021VD4dvsvqCsH1AwzZxXkfGLN8T5wTKQNFJPmdhqEBZOKIiKLf8cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728108443; c=relaxed/simple;
	bh=gONovUP7gKAFRYGOqQseh1xM+X2PLsk0KbDjNHYRmZU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PgSeFbrfmUS60bpFQLjEvcSozrvy6BVXDxJOxLX5xquhvenut8mPjYMkQntFcsA2QUNZboNiR5gWziz8Mnye2cvhxcRfI7eNotb5x0wX1ZCphVdpwr1tDw+ZtArPheSI6SL8vbkczyqCFs0KqG2+A319ilp6oaJ7I649//nBCxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0cadb1536so32128985ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Oct 2024 23:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728108441; x=1728713241;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EFodhiVlq4+O7me1WVkauzyh9TXZODm22YdIvxpWN4Y=;
        b=BL4Y1RXd/f36VCoR3VqwOqYTZPLTG06hg7pE3U3ColYDCIcUEmofC0SL44Zhrq3pLV
         i88ANeGyckb3hxHYPV99XV3vGDkRgwQ9kIfSujkRkHmetDJ5akP9mFLkeLdEEFC9fbCy
         YgB2p6iXeh/jPQqS8yxEGYyAZNRLfcsp2B7z7yAuHhdsDniqFJs5U6oxyog+zFnKIo0h
         92KDXRTv8kQSFvTzPJo08Z/MseB/nvFzsDeQXVzHdQBguCC54Osj3BLcXKoPYd/FE0uk
         vF4/zE2g9ZwoPhsc3SMiN2pTWJ3ExCTOkkZDS3ekgLF0+HNBsMtwwbzksAND9FopW4mQ
         edNQ==
X-Gm-Message-State: AOJu0YxDDGDoS0BDzDIX3G941iWJWbTxLJ9XujmsWrW2alhfnCU9Qosr
	IxJYjSurONGKC+qjbTNcWms+ChpjFVYeKBWneMQFG4R4ZU1/xgEyWauQ6WGjntx8eP9NH1XeWpE
	vV6jO9vzDWOvXTmoPkH6/Tj06GuLfVDKPP5WlyP3kWTvQZ0lAzNg+12s=
X-Google-Smtp-Source: AGHT+IEWto7aa75v+J7jTZq/XV6o9wg1kCf5LxVcNd+r9xMQwnMzb9j2ssR4vqklZiXYA3cNrQwssHDGsBz4IuImngo4c3kwJ9y+
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24f:0:b0:3a2:74f8:675d with SMTP id
 e9e14a558f8ab-3a375bd1be9mr58741775ab.20.1728108441388; Fri, 04 Oct 2024
 23:07:21 -0700 (PDT)
Date: Fri, 04 Oct 2024 23:07:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6700d799.050a0220.49194.04b3.GAE@google.com>
Subject: [syzbot] [hfs?] general protection fault in hfs_mdb_commit
From: syzbot <syzbot+5cfa9ffce7cc5744fe24@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c02d24a5af66 Add linux-next specific files for 20241003
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=111f2b9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94f9caf16c0af42d
dashboard link: https://syzkaller.appspot.com/bug?extid=5cfa9ffce7cc5744fe24
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114be307980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bef527980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/641e642c9432/disk-c02d24a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/98aaf20c29e0/vmlinux-c02d24a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c23099f2d86b/bzImage-c02d24a5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d12a33e3e104/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5cfa9ffce7cc5744fe24@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc00000000c7: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000638-0x000000000000063f]
CPU: 1 UID: 0 PID: 116 Comm: kworker/1:2 Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_long flush_mdb
RIP: 0010:hfs_mdb_commit+0x37/0xfd0 fs/hfs/mdb.c:266
Code: 53 48 83 ec 48 48 89 fb 49 bd 00 00 00 00 00 fc ff df e8 dc 45 0a ff 48 89 5c 24 08 4c 8d a3 38 06 00 00 4c 89 e3 48 c1 eb 03 <42> 80 3c 2b 00 74 08 4c 89 e7 e8 0a 2b 74 ff 4d 8b 34 24 49 8d 6e
RSP: 0018:ffffc90002d0fb40 EFLAGS: 00010202
RAX: ffffffff828a89e4 RBX: 00000000000000c7 RCX: ffff88801ef68000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffffc90002d0fdc0 R08: ffff88802e32d1eb R09: 1ffff11005c65a3d
R10: dffffc0000000000 R11: ffffed1005c65a3e R12: 0000000000000638
R13: dffffc0000000000 R14: 0000000000000001 R15: 0000000001800000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055fc5eb2fb50 CR3: 00000000786e8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfs_mdb_commit+0x37/0xfd0 fs/hfs/mdb.c:266
Code: 53 48 83 ec 48 48 89 fb 49 bd 00 00 00 00 00 fc ff df e8 dc 45 0a ff 48 89 5c 24 08 4c 8d a3 38 06 00 00 4c 89 e3 48 c1 eb 03 <42> 80 3c 2b 00 74 08 4c 89 e7 e8 0a 2b 74 ff 4d 8b 34 24 49 8d 6e
RSP: 0018:ffffc90002d0fb40 EFLAGS: 00010202
RAX: ffffffff828a89e4 RBX: 00000000000000c7 RCX: ffff88801ef68000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffffc90002d0fdc0 R08: ffff88802e32d1eb R09: 1ffff11005c65a3d
R10: dffffc0000000000 R11: ffffed1005c65a3e R12: 0000000000000638
R13: dffffc0000000000 R14: 0000000000000001 R15: 0000000001800000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055fc5eb2fb50 CR3: 00000000786e8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	53                   	push   %rbx
   1:	48 83 ec 48          	sub    $0x48,%rsp
   5:	48 89 fb             	mov    %rdi,%rbx
   8:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
   f:	fc ff df
  12:	e8 dc 45 0a ff       	call   0xff0a45f3
  17:	48 89 5c 24 08       	mov    %rbx,0x8(%rsp)
  1c:	4c 8d a3 38 06 00 00 	lea    0x638(%rbx),%r12
  23:	4c 89 e3             	mov    %r12,%rbx
  26:	48 c1 eb 03          	shr    $0x3,%rbx
* 2a:	42 80 3c 2b 00       	cmpb   $0x0,(%rbx,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 e7             	mov    %r12,%rdi
  34:	e8 0a 2b 74 ff       	call   0xff742b43
  39:	4d 8b 34 24          	mov    (%r12),%r14
  3d:	49                   	rex.WB
  3e:	8d                   	.byte 0x8d
  3f:	6e                   	outsb  %ds:(%rsi),(%dx)


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

