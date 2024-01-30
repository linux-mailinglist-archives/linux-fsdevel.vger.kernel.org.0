Return-Path: <linux-fsdevel+bounces-9541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 468E684272F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 15:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA6A1C244EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 14:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E15B823B3;
	Tue, 30 Jan 2024 14:52:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABEE7E77B
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626343; cv=none; b=k6vwr5zuiTeVh5tJHiLILGZ8TCRXW48mFOqM2JnSL934EEBog5z+C7GqUpAIB/4prr1L5joK2Ky+P/6grSOb5YafCQ2G7+tZedZwcnTZAsjKzmWY4yxRUZO8QAmHUkbHLXtOz/rsctuY9zQBlgxnDvPir/abYhyjlmrilGmWUu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626343; c=relaxed/simple;
	bh=e0CfQZ8YFGEVA5V7+49yYz6Cpb4V7oQVAB3Hm82Uz8Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VsCfpt/J4YQZCJUcoCku07fE7zip3HNdOEsx0KBuWeXRli66UkyUo7R6tCQiMUMcKFe8jK4C13l+WKE3DQaC6BGmYcqK4eyLOVzXlM01A3KPscN3nPH118vTWqU2irLTqJaIo1DWhDbfIPar8uvKgm/U2vwwztdSQKoj0zsxLdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c00a026be0so64570039f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 06:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706626341; x=1707231141;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQrPOJ4R4lUto4+AtoXSmJrCPbGvajCz9YCiNgKzlFk=;
        b=oxxefxMVSI3K//VGrZiBhgnlnoHXl3ZV7xvK3ZJSlaKv1b48X2g7rkAXZXg9UbyNoc
         qxBEMJXWlrMLqw1vqV+EXW+KH4OkSDCQdm9Kr7C40sv6uQhKFcUM5ncF78GjLsRZnSza
         D00YFMfJidWHsaHuH2etKsbKCH6m22XekThv6+BuRrmTU+9GPK20qxYgJK0OLfE8m6EW
         uCN1p5Os771d1is8Jzknc/baGa2eCIkz7LMwuhuIh7WIDvfDI3ZAfNVX1lm9uv/iyFrZ
         Oo2P2MV64dttEn18CoNodZlxjSxMwqjjqsomNMzQUzHUBZ1Ounn/qt+XjVeirkiuBuTD
         tBwg==
X-Gm-Message-State: AOJu0Yxi4zRgr3MC7yYlTLDhVnEA/0jZD0pgZQ/DaV/uIFc2yBblKJ6t
	IathI4G2MNobOltVBaofmtmpDht797agzSJpH7S/F4Kup7FPLiAoISoTHxkMpeLOwkUeR6wypPo
	plbiXKAawqC/xQnj2oQcsXJDHU7QSVKFTdhnpm+werw4pgPbSVoG7qJQ=
X-Google-Smtp-Source: AGHT+IEAI3Lu4ZbX+WQ7MIFiaoMBd50Y0in0tvC9HrcSpaumbuT7JoXeP1SBzqg4M+G3iC9C9iJpOIALDKEO5G8VMeKu8ptJxpm9
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170a:b0:363:820f:72b8 with SMTP id
 u10-20020a056e02170a00b00363820f72b8mr526779ill.1.1706626341328; Tue, 30 Jan
 2024 06:52:21 -0800 (PST)
Date: Tue, 30 Jan 2024 06:52:21 -0800
In-Reply-To: <000000000000e98460060fd59831@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6e06d06102ae80b@google.com>
Subject: Re: [syzbot] [xfs?] [ext4?] general protection fault in jbd2__journal_start
From: syzbot <syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, chandan.babu@oracle.com, jack@suse.com, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    861c0981648f Merge tag 'jfs-6.8-rc3' of github.com:kleikam..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ca8d97e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0b9993d7d6d1990
dashboard link: https://syzkaller.appspot.com/bug?extid=cdee56dbcdf0096ef605
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104393efe80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1393b90fe80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c6cc521298d/disk-861c0981.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6203c94955db/vmlinux-861c0981.xz
kernel image: https://storage.googleapis.com/syzbot-assets/17e76e12b58c/bzImage-861c0981.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d31d4eed2912/mount_3.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000a8a4829: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000054524148-0x000000005452414f]
CPU: 1 PID: 5065 Comm: syz-executor260 Not tainted 6.8.0-rc2-syzkaller-00031-g861c0981648f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:jbd2__journal_start+0x87/0x5d0 fs/jbd2/transaction.c:496
Code: 74 63 48 8b 1b 48 85 db 74 79 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 63 4d 8f ff 48 8b 2b 48 89 e8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 ef e8 4a 4d 8f ff 4c 39 65 00 0f 85 1a
RSP: 0018:ffffc900043265c8 EFLAGS: 00010203
RAX: 000000000a8a4829 RBX: ffff8880205fa3a8 RCX: ffff8880235dbb80
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88801c1a6000
RBP: 000000005452414e R08: 0000000000000c40 R09: 0000000000000001
R10: dffffc0000000000 R11: ffffed1003834871 R12: ffff88801c1a6000
R13: dffffc0000000000 R14: 0000000000000c40 R15: 0000000000000002
FS:  0000555556f90380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020020000 CR3: 0000000021fed000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __ext4_journal_start_sb+0x215/0x5b0 fs/ext4/ext4_jbd2.c:112
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_dirty_inode+0x92/0x110 fs/ext4/inode.c:5969
 __mark_inode_dirty+0x305/0xda0 fs/fs-writeback.c:2452
 generic_update_time fs/inode.c:1905 [inline]
 inode_update_time fs/inode.c:1918 [inline]
 __file_update_time fs/inode.c:2106 [inline]
 file_update_time+0x39b/0x3e0 fs/inode.c:2136
 ext4_page_mkwrite+0x207/0xdf0 fs/ext4/inode.c:6090
 do_page_mkwrite+0x197/0x470 mm/memory.c:2966
 wp_page_shared mm/memory.c:3353 [inline]
 do_wp_page+0x20e3/0x4c80 mm/memory.c:3493
 handle_pte_fault mm/memory.c:5160 [inline]
 __handle_mm_fault+0x26a3/0x72b0 mm/memory.c:5285
 handle_mm_fault+0x27e/0x770 mm/memory.c:5450
 do_user_addr_fault arch/x86/mm/fault.c:1415 [inline]
 handle_page_fault arch/x86/mm/fault.c:1507 [inline]
 exc_page_fault+0x2ad/0x870 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:rep_movs_alternative+0x4a/0x70 arch/x86/lib/copy_user_64.S:71
Code: 75 f1 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb c9 <f3> a4 c3 48 89 c8 48 c1 e9 03 83 e0 07 f3 48 a5 89 c1 85 c9 75 b3
RSP: 0018:ffffc900043270f8 EFLAGS: 00050202
RAX: ffffffff848cda01 RBX: 0000000020020040 RCX: 0000000000000040
RDX: 0000000000000000 RSI: ffff8880131873b0 RDI: 0000000020020000
RBP: 1ffff92000864f26 R08: ffff8880131873ef R09: 1ffff11002630e7d
R10: dffffc0000000000 R11: ffffed1002630e7e R12: 00000000000000c0
R13: dffffc0000000000 R14: 000000002001ff80 R15: ffff888013187330
 copy_user_generic arch/x86/include/asm/uaccess_64.h:112 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:133 [inline]
 _copy_to_user+0x86/0xa0 lib/usercopy.c:41
 copy_to_user include/linux/uaccess.h:191 [inline]
 xfs_bulkstat_fmt+0x4f/0x120 fs/xfs/xfs_ioctl.c:744
 xfs_bulkstat_one_int+0xd8b/0x12e0 fs/xfs/xfs_itable.c:161
 xfs_bulkstat_iwalk+0x72/0xb0 fs/xfs/xfs_itable.c:239
 xfs_iwalk_ag_recs+0x4c3/0x820 fs/xfs/xfs_iwalk.c:220
 xfs_iwalk_run_callbacks+0x25b/0x490 fs/xfs/xfs_iwalk.c:376
 xfs_iwalk_ag+0xad6/0xbd0 fs/xfs/xfs_iwalk.c:482
 xfs_iwalk+0x360/0x6f0 fs/xfs/xfs_iwalk.c:584
 xfs_bulkstat+0x4f8/0x6c0 fs/xfs/xfs_itable.c:308
 xfs_ioc_bulkstat+0x3d0/0x450 fs/xfs/xfs_ioctl.c:867
 xfs_file_ioctl+0x6a5/0x1980 fs/xfs/xfs_ioctl.c:1994
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f02d4018b59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdbe0deb98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f02d4018b59
RDX: 000000002001fc40 RSI: 000000008040587f RDI: 0000000000000004
RBP: 00000000000116e3 R08: 0000000000000000 R09: 0000555556f914c0
R10: 0000000020000300 R11: 0000000000000246 R12: 00007ffdbe0debc0
R13: 00007ffdbe0debac R14: 431bde82d7b634db R15: 00007f02d406103b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:jbd2__journal_start+0x87/0x5d0 fs/jbd2/transaction.c:496
Code: 74 63 48 8b 1b 48 85 db 74 79 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 63 4d 8f ff 48 8b 2b 48 89 e8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 ef e8 4a 4d 8f ff 4c 39 65 00 0f 85 1a
RSP: 0018:ffffc900043265c8 EFLAGS: 00010203
RAX: 000000000a8a4829 RBX: ffff8880205fa3a8 RCX: ffff8880235dbb80
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88801c1a6000
RBP: 000000005452414e R08: 0000000000000c40 R09: 0000000000000001
R10: dffffc0000000000 R11: ffffed1003834871 R12: ffff88801c1a6000
R13: dffffc0000000000 R14: 0000000000000c40 R15: 0000000000000002
FS:  0000555556f90380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020020000 CR3: 0000000021fed000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	74 63                	je     0x65
   2:	48 8b 1b             	mov    (%rbx),%rbx
   5:	48 85 db             	test   %rbx,%rbx
   8:	74 79                	je     0x83
   a:	48 89 d8             	mov    %rbx,%rax
   d:	48 c1 e8 03          	shr    $0x3,%rax
  11:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  16:	74 08                	je     0x20
  18:	48 89 df             	mov    %rbx,%rdi
  1b:	e8 63 4d 8f ff       	call   0xff8f4d83
  20:	48 8b 2b             	mov    (%rbx),%rbp
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 ef             	mov    %rbp,%rdi
  34:	e8 4a 4d 8f ff       	call   0xff8f4d83
  39:	4c 39 65 00          	cmp    %r12,0x0(%rbp)
  3d:	0f                   	.byte 0xf
  3e:	85 1a                	test   %ebx,(%rdx)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

