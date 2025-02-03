Return-Path: <linux-fsdevel+bounces-40571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C31A25476
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C0C3A304F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 08:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315F61FC7DC;
	Mon,  3 Feb 2025 08:35:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265CB1D7E50
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738571727; cv=none; b=d1C46Y1GsgyIEP/Z4Kc4P6wk8crMU8vPzvvzHBzx3Tm8kzV2Me7X/ecrPbrBj9ORGzRTLr9sIW4e7NjGyg4Yd4uvOWgy3UX6YUfHfU6X19+XyN/TGwDf61/wOmNHUSFnHm+2Tr+GTjQ/p7By72ezhiBrGNR4O8cYhX73Y/IFRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738571727; c=relaxed/simple;
	bh=EHnwANqNamMaKJ6W3YtVX272maY5h1vi4o7M+jI65lk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=puwgeS6b1ReFYcxNYZQ6QBxIZamNoXeKXRzA6Pw+brpHc8wfCp9Eskb/i24+m55zxifnq9gF0bv6HNaJzlDDHLn7hl7GM5HqSvpOIIsR9YL8rNaWUFPROaQA2DW5vsy1DmFqvclAKGS12Qpn1JXu9jrp+LU5LVAI3vrVGQTNosE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3cde3591dbfso25425325ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 00:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738571725; x=1739176525;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xBOfIDS8eiWkbnwi9Kq/cPkeY/6X3NUer7sfRzD49VY=;
        b=vJULizpCfHjR7w6uCa5D07G7PjMulf2OU5JFOBdIrcPKaOkE3LtGUUhvLf3SPqeagj
         9Cc1piOt/+vX08ifh4Mw/oZbmW995THj8r/qtce0HuJLE4FIrDgkmw360XuJ1Vbi/mmr
         zq6IpHPZtQyuhI7YBmVixG6h4F1pOhUc6K50MW9Rmpf3yI0cI4wiYHTNTPaxZcV6By4B
         CzwO34zScaLFGV3/GMzqSXgR5Vu/gQlQc7NV1DvS0loItbPcrlxW3LNP95wc/r8F1Yrf
         1vDt+0wBMkX6AArKBE8gp2zBVYPcQEGi/7YwYQCdIHzgSeX2aLxwPrjQcPhRQN9L++3C
         tQVA==
X-Forwarded-Encrypted: i=1; AJvYcCWErSO8yeryvtD9exdYef39PqWT0GP3v4Ccm708g0gpdyCxNcUozFzBj4SFEB8LjTnY/w50jCpDliMPcXKZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwCxHN71SXFwaXVHZX9iIifSKfj3hT15MeCk85Xbv9Ee7dy2qyK
	QjE+cmlC5Qi5wtS7z3ZjksTKF+MpBVp8LKeQn2CnxLlT2YtMtunu0r3DDNEs+tuvO7IcuHhir/O
	7snhCr8AL0RPA5ZvTeDwmYZR86jQxXkB8SI0tuuWBSlc/TiC59Syb+UI=
X-Google-Smtp-Source: AGHT+IFwvMLRPQ1qayp5vgSncK6ENL6M2EOuvp6628WQB4hXQIjdRW0YH0vexXtJSCFT1N9IL/I6NGtVJd2PTKhrX3yd77zoaepQ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda7:0:b0:3ce:34fb:fdac with SMTP id
 e9e14a558f8ab-3d012a51707mr96949135ab.5.1738571725315; Mon, 03 Feb 2025
 00:35:25 -0800 (PST)
Date: Mon, 03 Feb 2025 00:35:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a07fcd.050a0220.163cdc.003c.GAE@google.com>
Subject: [syzbot] [fs?] upstream test error: BUG: unable to handle kernel
 paging request in put_links
From: syzbot <syzbot+be35ef678b99e18dae51@syzkaller.appspotmail.com>
To: joel.granados@kernel.org, kees@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    05dbaf8dd8bf Merge tag 'x86-urgent-2025-01-28' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=168d3918580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccb9b8c423893ece
dashboard link: https://syzkaller.appspot.com/bug?extid=be35ef678b99e18dae51
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05c0efec0249/disk-05dbaf8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fcabe68eb297/vmlinux-05dbaf8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/15bb26e810d5/bzImage-05dbaf8d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be35ef678b99e18dae51@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: 00006c656e72656b
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.13.0-syzkaller-09338-g05dbaf8dd8bf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: events free_ipc
RIP: 0010:strlen+0x38/0x90 lib/string.c:413
Code: 41 54 53 48 89 fb 49 c7 c6 ff ff ff ff e8 d0 68 5c f2 49 89 c7 41 b4 01 eb 0b 48 ff c3 49 ff c6 45 84 ed 74 31 45 84 e4 74 23 <44> 0f b6 2b 48 89 df e8 6c 5a 5c f2 0f b6 00 84 c0 74 dd f6 d0 44
RSP: 0018:ffff888100273858 EFLAGS: 00010202
RAX: ffff88810025ac08 RBX: 00006c656e72656b RCX: 0000000000000000
RDX: ffff88801d513538 RSI: ffff88813fffaaf0 RDI: 00006c656e72656b
RBP: ffff888100273880 R08: ffffea000000000f R09: ffffffff82d145f0
R10: 0000000000000002 R11: ffff88810025a0c0 R12: 0000000000000001
R13: 0000000000000000 R14: ffffffffffffffff R15: ffff88810025ac08
FS:  0000000000000000(0000) GS:ffff88813fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00006c656e72656b CR3: 00000000134c8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 put_links+0x226/0x9d0 fs/proc/proc_sysctl.c:1490
 drop_sysctl_table+0x10d/0x4f0 fs/proc/proc_sysctl.c:1512
 drop_sysctl_table+0x4b6/0x4f0 fs/proc/proc_sysctl.c:1520
 unregister_sysctl_table+0x48/0x70 fs/proc/proc_sysctl.c:1538
 retire_ipc_sysctls+0x67/0xc0 ipc/ipc_sysctl.c:310
 free_ipc_ns ipc/namespace.c:160 [inline]
 free_ipc+0x1d6/0x4c0 ipc/namespace.c:181
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3317
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3398
 kthread+0x6b9/0xef0 kernel/kthread.c:464
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
CR2: 00006c656e72656b
---[ end trace 0000000000000000 ]---
RIP: 0010:strlen+0x38/0x90 lib/string.c:413
Code: 41 54 53 48 89 fb 49 c7 c6 ff ff ff ff e8 d0 68 5c f2 49 89 c7 41 b4 01 eb 0b 48 ff c3 49 ff c6 45 84 ed 74 31 45 84 e4 74 23 <44> 0f b6 2b 48 89 df e8 6c 5a 5c f2 0f b6 00 84 c0 74 dd f6 d0 44
RSP: 0018:ffff888100273858 EFLAGS: 00010202
RAX: ffff88810025ac08 RBX: 00006c656e72656b RCX: 0000000000000000
RDX: ffff88801d513538 RSI: ffff88813fffaaf0 RDI: 00006c656e72656b
RBP: ffff888100273880 R08: ffffea000000000f R09: ffffffff82d145f0
R10: 0000000000000002 R11: ffff88810025a0c0 R12: 0000000000000001
R13: 0000000000000000 R14: ffffffffffffffff R15: ffff88810025ac08
FS:  0000000000000000(0000) GS:ffff88813fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00006c656e72656b CR3: 00000000134c8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	41 54                	push   %r12
   2:	53                   	push   %rbx
   3:	48 89 fb             	mov    %rdi,%rbx
   6:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
   d:	e8 d0 68 5c f2       	call   0xf25c68e2
  12:	49 89 c7             	mov    %rax,%r15
  15:	41 b4 01             	mov    $0x1,%r12b
  18:	eb 0b                	jmp    0x25
  1a:	48 ff c3             	inc    %rbx
  1d:	49 ff c6             	inc    %r14
  20:	45 84 ed             	test   %r13b,%r13b
  23:	74 31                	je     0x56
  25:	45 84 e4             	test   %r12b,%r12b
  28:	74 23                	je     0x4d
* 2a:	44 0f b6 2b          	movzbl (%rbx),%r13d <-- trapping instruction
  2e:	48 89 df             	mov    %rbx,%rdi
  31:	e8 6c 5a 5c f2       	call   0xf25c5aa2
  36:	0f b6 00             	movzbl (%rax),%eax
  39:	84 c0                	test   %al,%al
  3b:	74 dd                	je     0x1a
  3d:	f6 d0                	not    %al
  3f:	44                   	rex.R


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

