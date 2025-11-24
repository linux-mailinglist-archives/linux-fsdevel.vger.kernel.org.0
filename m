Return-Path: <linux-fsdevel+bounces-69612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A38F1C7EA75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 01:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FEDA4E18D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 00:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956B170808;
	Mon, 24 Nov 2025 00:01:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C95C2E0
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 00:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763942493; cv=none; b=p479dRcedgqqx9u0FZV1aHxELcLMn1Pbst2dItSYS/JwrhhGiHqiKXNnSwuXyfz6Y7C8AIHAtVzwLyRtl/RxpofCknPHnV4p+vF620pf3jp3JIPrKSnYjLd0mmuNkZ4PmTlFIgYPLrtfZREVpQxAvIuOSo/bS46hI2EGkm7aS28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763942493; c=relaxed/simple;
	bh=hkmlAZN14RWTJJKJOjA72+yOxxBYpyV18otFeTNH4W4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DR2WRysjG8V3ATBWR/PBERByW17IjzPY+6ee6EJp69UVpFQg2WdDvrkxK2RHjCvQJ7lj0GmSeXWIcnyFHXRDnomKlxy0jjCgI02UzQPIYF2KS9XhWEakjOYGT8+DCrjj05oSsN+x6BsBMh8/1tmJi2TRaYSxityJ/gHGj7PFCp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-94880a46eaeso276422939f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:01:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763942491; x=1764547291;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5jTt5tWoNPtzD6/wOudojqqEJEkXgAW9wqUd4ayLG0=;
        b=tPs+3cfoeK7CtMMYwc9dzNOCleUS3p8jLPHIsPRCRW4cvja7IZH/jx70C5D/6nn25+
         Vq3HaOTrrOlQxk99smDZmngT7ArZXLOL03T6emG3RaF/rYELRyFCoksFp6ItEUeGZQRY
         d3P9qouTSjZKDAg/ZfbsY/KjgttbS/rUsxwixdtiYcrbvyf4NCGG0My7rgcI+Z+PiE5q
         xD2JB2MhrCuHLlIlGCY/pthaabhGzK7h5OuGE3mcaFRfpobVcOOjLK2HQ4c6tpmxJvic
         JO2Fieam5rPJTj5Ati9VoXk/+ZFzS+v2Xb50yFAupn29dOdEmLBgNqNsJW1lUimtvlih
         0rXg==
X-Forwarded-Encrypted: i=1; AJvYcCW50QA18E4QRIsZhHTh8lWCqo4zd0z93mGguhdR2WhnmL6U3oH/Y52VBJRc+4O4Y/I416KZX00rDktGRsLO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5mQzoGSgJj+VErQFhQBjB1WxvtKOZ+vMu6jWYICgr/2FV0jEw
	eIMRiUhCn/ZX86e2uA7s8lE6Q1PzzAYFxhepPG30heVGMlh7vgLvNUdODg5Ns8tynBpEbO5l5Oh
	SEpHlfI8W0AKjaLK4lAEa/W3ULAcrcAjF23x/eNoKKYSyg4B4gyzepzn2sus=
X-Google-Smtp-Source: AGHT+IHvjl/QyuFxDRTYWf4jPVTWtpTBnU+dwLC1u0ta2o/LYfdGncT7IpPF0C3C0iZpn/LSJD6l6GpSzavgzOMCbigc+P3m9nOY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3809:b0:434:a847:68e1 with SMTP id
 e9e14a558f8ab-435b9845c1cmr81030565ab.9.1763942490771; Sun, 23 Nov 2025
 16:01:30 -0800 (PST)
Date: Sun, 23 Nov 2025 16:01:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6923a05a.a70a0220.2ea503.0075.GAE@google.com>
Subject: [syzbot] [iomap?] general protection fault in iomap_dio_bio_end_io
From: syzbot <syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com>
To: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe4d0dea039f Add linux-next specific files for 20251119
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16bd7692580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f20a6db7594dcad7
dashboard link: https://syzkaller.appspot.com/bug?extid=a2b9a4ed0d61b1efb3f5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12db68b4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107c0514580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce4f26d91a01/disk-fe4d0dea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c9b53acf521/vmlinux-fe4d0dea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/64d37d01cd64/bzImage-fe4d0dea.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/004457158842/mount_1.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=133a1a12580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000038: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000001c0-0x00000000000001c7]
CPU: 1 UID: 0 PID: 23 Comm: ksoftirqd/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:__queue_work+0xa4/0xf90 kernel/workqueue.c:2250
Code: 10 31 ff 89 ee e8 ac 24 37 00 85 ed 0f 85 9d 0c 00 00 e8 5f 20 37 00 4d 8d b5 c0 01 00 00 4c 89 f0 48 c1 e8 03 48 89 44 24 30 <0f> b6 04 18 84 c0 0f 85 c4 0c 00 00 4c 89 34 24 41 8b 2e 89 ee 81
RSP: 0018:ffffc900001d7868 EFLAGS: 00010002
RAX: 0000000000000038 RBX: dffffc0000000000 RCX: ffff88801d2d5b80
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff8880777ed647 R09: 1ffff1100eefdac8
R10: dffffc0000000000 R11: ffffed100eefdac9 R12: 0000000000000008
R13: 0000000000000000 R14: 00000000000001c0 R15: 0000000000000200
FS:  0000000000000000(0000) GS:ffff888125fbc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000073fc0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 queue_work_on+0x181/0x270 kernel/workqueue.c:2386
 iomap_dio_bio_end_io+0xf4/0x1c0 fs/iomap/direct-io.c:222
 blk_update_request+0x57e/0xe60 block/blk-mq.c:1006
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1168
 blk_complete_reqs block/blk-mq.c:1243 [inline]
 blk_done_softirq+0x10a/0x160 block/blk-mq.c:1248
 handle_softirqs+0x27d/0x880 kernel/softirq.c:626
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1067
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__queue_work+0xa4/0xf90 kernel/workqueue.c:2250
Code: 10 31 ff 89 ee e8 ac 24 37 00 85 ed 0f 85 9d 0c 00 00 e8 5f 20 37 00 4d 8d b5 c0 01 00 00 4c 89 f0 48 c1 e8 03 48 89 44 24 30 <0f> b6 04 18 84 c0 0f 85 c4 0c 00 00 4c 89 34 24 41 8b 2e 89 ee 81
RSP: 0018:ffffc900001d7868 EFLAGS: 00010002
RAX: 0000000000000038 RBX: dffffc0000000000 RCX: ffff88801d2d5b80
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff8880777ed647 R09: 1ffff1100eefdac8
R10: dffffc0000000000 R11: ffffed100eefdac9 R12: 0000000000000008
R13: 0000000000000000 R14: 00000000000001c0 R15: 0000000000000200
FS:  0000000000000000(0000) GS:ffff888125fbc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000073fc0000 CR4: 00000000003526f0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	31 ff                	xor    %edi,%edi
   2:	89 ee                	mov    %ebp,%esi
   4:	e8 ac 24 37 00       	call   0x3724b5
   9:	85 ed                	test   %ebp,%ebp
   b:	0f 85 9d 0c 00 00    	jne    0xcae
  11:	e8 5f 20 37 00       	call   0x372075
  16:	4d 8d b5 c0 01 00 00 	lea    0x1c0(%r13),%r14
  1d:	4c 89 f0             	mov    %r14,%rax
  20:	48 c1 e8 03          	shr    $0x3,%rax
  24:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
* 29:	0f b6 04 18          	movzbl (%rax,%rbx,1),%eax <-- trapping instruction
  2d:	84 c0                	test   %al,%al
  2f:	0f 85 c4 0c 00 00    	jne    0xcf9
  35:	4c 89 34 24          	mov    %r14,(%rsp)
  39:	41 8b 2e             	mov    (%r14),%ebp
  3c:	89 ee                	mov    %ebp,%esi
  3e:	81                   	.byte 0x81


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

