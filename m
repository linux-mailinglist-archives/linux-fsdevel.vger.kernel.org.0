Return-Path: <linux-fsdevel+bounces-17849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC608B2E98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 04:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D8B1C224A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 02:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF98E7470;
	Fri, 26 Apr 2024 02:13:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE8863AE
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 02:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714097602; cv=none; b=Qep27Ip31V6xuEqKeUHEy8+GlgEskEEUR0QBcYvu5C4sLwVxwIIWRJCK+/wsjHB2E0oPZc/ew5fOUZbuF4ROiAIp+aww+LgfssA7RH+j9Ial/rOmIUmjGLispdTaiLoiENfvcgLCxrfg+rwRhjror+sfnngmikJIZEWmu7OyvTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714097602; c=relaxed/simple;
	bh=IKyM0RRgp91tpBkkosb3POhPoylTVEXs8xoD7G2L7I8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ah6cALoYrIeWHST58ekCq4mcpxhTSK4Ty5WYyAr2UJI2RAO1/xNo0n8MCqbCzBm95F4DNnfHavZXudOAbCBQ9IaFt9nTmK9PO4ELtDg3N0Bq8ifhBavzMSilbo2ortr8njoeTgmPiMt8J4Wmqnj5w3qcYChJl078TjXo9RMJGHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36a38d56655so18504465ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 19:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714097600; x=1714702400;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gaf9uHIX188wy87s5s0fm7jlwwFHmUIC3X8hW3n0+40=;
        b=cicYPtGLLSKpr9KDa95lXMv6prQuC1QLEcrys7TvPjM5caYG6khZMzlatGuf3DZKsI
         3ye4RvDtSXA/kmnEFasRSL9bn5K0LoYfWbxrZvNV26gPZvp6JheX1YB+q67BT1OLDvNF
         jWGtFaCRc9h3BHpi+5ai/eoPQs1USBXra9T3qvd8jvnGTVDZDre1P2kxT3YU/SYr68bL
         MYqd8rlkkpkw3xTlfj9n26oXNB+hb2BFs525k4Wf8kV+XKQysDduW2TuML2b+i3ywfyH
         J8GhjhpeL1QVJGAH/V9WWTStloK782wytsYlAlb0GvaoHDpPJGARYGNaVLQR98sdOxKu
         Navg==
X-Forwarded-Encrypted: i=1; AJvYcCU5EdTozj394tCqZlfBXplScHauuet0MfMzbkzZMOphik8Pa3W3dwiRBcuMnkMdnS4wNkXrAQnWoFEESaFrVhtSVm7/Ha/+v1eAYTmnkA==
X-Gm-Message-State: AOJu0Yytgpi6Q6ECPuBSYxLYaBpiLmzSaDXO1Zp27Ke5cBuzj+5EzhMN
	iqi4Fyr3bc8Z8s5RZPYsTdkzZfAWgp8d0thdBBFRk4aShgDmmRNc46BHJ3ElMNSC2ghQsuISxdN
	JvFHMPYZduA99rEf9IQ3jkx3Sp0ZopOA/IWve7gUgPBQO+kMsERtn7Gg=
X-Google-Smtp-Source: AGHT+IFrB3lnw6BEPuWJpIonFKpdLdEWFcYAzAtghz/5naMW7RN8TmntdUhWPuTdxTTYaEcwqVGg7p10VQzQlNX+bsuipxfOL5gW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d10:b0:36b:26df:cce4 with SMTP id
 i16-20020a056e021d1000b0036b26dfcce4mr72709ila.6.1714097600234; Thu, 25 Apr
 2024 19:13:20 -0700 (PDT)
Date: Thu, 25 Apr 2024 19:13:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009299ad0616f6727a@google.com>
Subject: [syzbot] [netfs?] WARNING in netfs_pages_written_back
From: syzbot <syzbot+dbc44fd848d570fc1526@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e33c4963bf53 Merge tag 'nfsd-6.9-5' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118f2c08980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19891bd776e81b8b
dashboard link: https://syzkaller.appspot.com/bug?extid=dbc44fd848d570fc1526
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-e33c4963.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/af334172fdbc/vmlinux-e33c4963.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9c0bfbadd1ab/bzImage-e33c4963.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dbc44fd848d570fc1526@syzkaller.appspotmail.com

------------[ cut here ]------------
bad 1 @0 page 0 0
WARNING: CPU: 0 PID: 14804 at fs/netfs/buffered_write.c:653 netfs_pages_written_back+0xe02/0x1320 fs/netfs/buffered_write.c:653
Modules linked in:
CPU: 0 PID: 14804 Comm: syz-executor.2 Not tainted 6.9.0-rc5-syzkaller-00053-ge33c4963bf53 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:netfs_pages_written_back+0xe02/0x1320 fs/netfs/buffered_write.c:653
Code: 48 c1 ee 03 80 3c 06 00 0f 85 d0 04 00 00 48 8b 44 24 18 4d 89 f0 48 c7 c7 80 54 22 8b 48 8b b0 28 01 00 00 e8 8f 0a 21 ff 90 <0f> 0b 90 90 e9 3c f4 ff ff e8 c0 35 5e ff e8 9b cc 44 ff 31 ff 41
RSP: 0018:ffffc900030a75b8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffea0001522140 RCX: ffffffff81513b29
RDX: ffff88801e1c2440 RSI: ffffffff81513b36 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000003 R12: dffffc0000000000
R13: ffff88801fa60040 R14: 0000000000000000 R15: ffff88801fa60138
FS:  0000000000000000(0000) GS:ffff88802c200000(0063) knlGS:00000000f5ed1b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000eda8fda4 CR3: 00000000468b6000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 00000000872c9164 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_cleanup_buffered_write+0x7a8/0x9b0 fs/netfs/buffered_write.c:726
 netfs_write_terminated+0x3c7/0x910 fs/netfs/output.c:121
 netfs_end_writethrough+0x1a6/0x200 fs/netfs/output.c:468
 netfs_perform_write+0x1a6c/0x26b0 fs/netfs/buffered_write.c:398
 netfs_buffered_write_iter_locked+0x213/0x2c0 fs/netfs/buffered_write.c:454
 netfs_file_write_iter+0x1e0/0x470 fs/netfs/buffered_write.c:493
 v9fs_file_write_iter+0xa1/0x100 fs/9p/vfs_file.c:407
 call_write_iter include/linux/fs.h:2110 [inline]
 do_iter_readv_writev+0x504/0x780 fs/read_write.c:741
 vfs_writev+0x36f/0xdb0 fs/read_write.c:971
 do_pwritev+0x1b2/0x260 fs/read_write.c:1072
 __do_compat_sys_pwritev2 fs/read_write.c:1218 [inline]
 __se_compat_sys_pwritev2 fs/read_write.c:1210 [inline]
 __ia32_compat_sys_pwritev2+0x121/0x1b0 fs/read_write.c:1210
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7300579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5ed15ac EFLAGS: 00000292 ORIG_RAX: 000000000000017b
RAX: ffffffffffffffda RBX: 0000000000000026 RCX: 0000000020000240
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000015 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
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

