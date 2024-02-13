Return-Path: <linux-fsdevel+bounces-11381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFA7853480
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0735A283536
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 15:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E065DF1F;
	Tue, 13 Feb 2024 15:23:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5A25A7B7
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837806; cv=none; b=RwZuGQdgAB1gdQ8xFDIgftCBWTwFnK0PHeOr0aRHhLKqMIxLq57JYg2CLH3SjUq5duD2q+VzgYDdFthJoESU796n0W5yUbG3gYqxjoFflVJhPnm1QZwL2G3uX/xIw+o/wjzD3+xKaFnSMm41sDBsYixRhH17PIUtm2Zjpi6h32E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837806; c=relaxed/simple;
	bh=w1nEHu8/7BhoNOH5imUiZwijYz+dn13e4D8t5oDhRTY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fm/k9hvIDz4RA79YJ93JylmrSliSOW4UrdZEeHfBlN7eRHLFh3f6/N6v6tY/91Hb1ArajPQRTuShig+GU8EW+gifNghRHDgPsmouPWt+TYhuldyAjUDtKO/M3+NpoNLtxDuxqFWQyYU0nNi9IdOIRhlufJ/n5ACqx6y0kfWJpQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-364278061caso745795ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 07:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707837803; x=1708442603;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eapGd85XQdiWlRnkbXZfY0yyjZ9t+mu9JVAVS/ftg5M=;
        b=l832y7Ng9YUyfO963Du6Am7VlZ1/BS3XB14aF76Tts0aOOTzeWvAaHZ0C78qF+Ib7C
         mROrq8fAz3+eq2AizosEaxIzpB2xE1ImEbRwXxnfU2wyyyb7moMzn34gBJF0xh7yqRpm
         LrEGzRrOubCb6V1PVMBU+PlWMAjENdcdQOQZoiib+pN1ePp0FgSkC/VYOjxENkQUU8Bx
         L7wz+y+cfIOhinoh//akjJY674D1znemmzW8Q6zapuiQmLrq2RB85MjxI+c3BLdfZYET
         c7rRl6O2zxIemZyw+sUooGVWHPZ81vxq+wsRFzw2g52RWh+dnnGvU5ZYMqoezLyFPmOv
         zyPA==
X-Forwarded-Encrypted: i=1; AJvYcCWk2jfYlxSR5mlpf2nyDZgE8171X5to6lE/pH1z4NpRhD4kdGgFUZXeOmGjzh4omms/t40+w72oXf0VtnYGd0nPxsBEbtczW4V1muKGYQ==
X-Gm-Message-State: AOJu0YyzBY5NARkT+5EOc+00xBareopC3kF8fZ/kUB8Z+u0GoS0pRofy
	3euCMfKyUhlDrZNRUN4En/KV0zpHzSrZr36Q73PXweQW5VnjDMFZTO4tRtFLPNiXTW7zI7dEM3w
	vtvTqIhZAoOmcjjjf0VlrsBTsXjcegsBFrVY9wBsp8cZeWYPm6BPdyGU=
X-Google-Smtp-Source: AGHT+IETxxHxna1NhDp9HAg/10qyCuxdqS5uMJEpwTr8NT/LnQAaJuOhQqt2ABrFOFWu+iFGB7jpYj7GOSTB0wtx9cTpYWaBR7Re
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca8:b0:363:c919:eec7 with SMTP id
 x8-20020a056e021ca800b00363c919eec7mr837257ill.6.1707837803797; Tue, 13 Feb
 2024 07:23:23 -0800 (PST)
Date: Tue, 13 Feb 2024 07:23:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a12738061144f9d1@google.com>
Subject: [syzbot] [jfs?] kernel BUG in txEnd (2)
From: syzbot <syzbot+776b5fc6c99745aa7860@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c664e16bb1ba Merge tag 'docs-6.8-fixes2' of git://git.lwn...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1576f862180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25b2f1c52b0610fa
dashboard link: https://syzkaller.appspot.com/bug?extid=776b5fc6c99745aa7860
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-c664e16b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/81393e4e8960/vmlinux-c664e16b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3048b480feed/bzImage-c664e16b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+776b5fc6c99745aa7860@syzkaller.appspotmail.com

bread failed!
read_mapping_page failed!
bread failed!
BUG at fs/jfs/jfs_txnmgr.c:528 assert(tblk->next == 0)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_txnmgr.c:528!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 2 PID: 30987 Comm: syz-executor.0 Not tainted 6.8.0-rc4-syzkaller-00005-gc664e16bb1ba #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:txEnd+0x583/0x5a0 fs/jfs/jfs_txnmgr.c:528
Code: e9 59 fb ff ff e8 dd 70 88 fe 48 c7 c1 00 ee 29 8b ba 10 02 00 00 48 c7 c6 80 e8 29 8b 48 c7 c7 c0 e8 29 8b e8 8e 83 6a fe 90 <0f> 0b 48 89 ef e8 f3 00 e3 fe e9 40 fd ff ff e8 b9 00 e3 fe e9 2e
RSP: 0018:ffffc9000ff0fa50 EFLAGS: 00010286
RAX: 0000000000000036 RBX: ffffc900020c7600 RCX: ffffc900065fa000
RDX: 0000000000000000 RSI: ffffffff816e9616 RDI: 0000000000000005
RBP: 0000000000000060 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000006 R12: ffff888021b79800
R13: 00000000000000c0 R14: ffffffff8db27f60 R15: ffffc900020c7602
FS:  0000000000000000(0000) GS:ffff88802c400000(0063) knlGS:00000000f5e30b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020ca3000 CR3: 00000000007a0000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jfs_truncate_nolock+0x1f5/0x2f0 fs/jfs/inode.c:391
 jfs_truncate+0xeb/0x170 fs/jfs/inode.c:412
 jfs_write_failed fs/jfs/inode.c:289 [inline]
 jfs_write_begin+0xbe/0xe0 fs/jfs/inode.c:301
 generic_perform_write+0x273/0x620 mm/filemap.c:3930
 __generic_file_write_iter+0x1fd/0x240 mm/filemap.c:4025
 generic_file_write_iter+0xe7/0x350 mm/filemap.c:4051
 call_write_iter include/linux/fs.h:2085 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6de/0x1110 fs/read_write.c:590
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x7c/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x33/0x80 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x7c/0x86
RIP: 0023:0xf7257579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5e305ac EFLAGS: 00000292 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 0000000020000100
RDX: 00000000fffffd9d RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:txEnd+0x583/0x5a0 fs/jfs/jfs_txnmgr.c:528
Code: e9 59 fb ff ff e8 dd 70 88 fe 48 c7 c1 00 ee 29 8b ba 10 02 00 00 48 c7 c6 80 e8 29 8b 48 c7 c7 c0 e8 29 8b e8 8e 83 6a fe 90 <0f> 0b 48 89 ef e8 f3 00 e3 fe e9 40 fd ff ff e8 b9 00 e3 fe e9 2e
RSP: 0018:ffffc9000ff0fa50 EFLAGS: 00010286
RAX: 0000000000000036 RBX: ffffc900020c7600 RCX: ffffc900065fa000
RDX: 0000000000000000 RSI: ffffffff816e9616 RDI: 0000000000000005
RBP: 0000000000000060 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000006 R12: ffff888021b79800
R13: 00000000000000c0 R14: ffffffff8db27f60 R15: ffffc900020c7602
FS:  0000000000000000(0000) GS:ffff88802c400000(0063) knlGS:00000000f5e30b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020ca3000 CR3: 00000000007a0000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

