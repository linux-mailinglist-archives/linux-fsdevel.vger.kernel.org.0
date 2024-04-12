Return-Path: <linux-fsdevel+bounces-16788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C38ED8A2A49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 11:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78AE21F22AF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 09:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F04955C2A;
	Fri, 12 Apr 2024 09:00:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A991554273
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712912434; cv=none; b=IUUfXarGvat+mftrNaGqEvS5/61Or0jMsUbmjiv3BMp+24C4Jdr+D2CW3253GlFYRIeL5qJ4kf5KS9jEPemfIEVfQs/qu4LrYd/QGsV0LhrzN1cXMtgeLg0oIVH5N41IpBSYw+qy2sl4NRhZlr42oKkQdWcW9dAwGAICZj0AHxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712912434; c=relaxed/simple;
	bh=4Q+IBaepZiLCsdOavyELBxZMYWyPvtABKlt5WpGdbyI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FKpBz1paopRlYMJ6MWhh+kJA1x/2GeAXBQHOBrGL1FfFAtygYH3XityYK2Ngl5WMb9twPekCYFVHa04FxqAnmmoTvwyBXN9Dm8NAhA/ljwiccDbhWtWTLx9P83UHEBK8CTXIn2U9n/SITld7SMHMkgiqTFqG0p0axqQTXCk4EhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc7a6a043bso88625339f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 02:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712912432; x=1713517232;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y2eLb6SWzHPU4Thv2aZRk7fEazck4gWQG7xSVSBwIcg=;
        b=Gv/zsXPxmxkDChZiLjqAfW9al81noRIOCTCvJInJg1tbW1u60pfa0rCiefFeuEfIvJ
         zkom515+EDBp3Im2bbvvg+2CpOf95i9L70pRlfBqeZewmv+N3xeXVbBjsasanv/CIoNS
         cnuwR0uwBF04V77fMIK0WPi7oKSozVf14YfnTe5dAqNVfOiCJ+ljOMG87lIvk9zdaSfX
         aNtctRrqalTXbS2qT6iplOVvrkNWTdZwQUdnXzRrZGwbWeVh8w+LS3j+BK9DCTCSL47M
         yYPBsq59RUR6fN2toztQpHcA9rTwEpINTCFQiGWB5my6MyzQyRZKujPziZHssSUTdCZO
         Y4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVsQk0VKRQJGmUbewWkcNf/KlocnaR/qBDX2S/z4YAn7wL8Jk51iKU0eTA4TRFWIshs+zHkfxajnwx8cxEZ5C8vQNEo93gL3NLx692zZQ==
X-Gm-Message-State: AOJu0YwLN8Z8bGi4rDR0xp8+suSKpsOQ9JqwGfGlxlWAmdyIeP/9reNd
	9qu566jxNb6ft8WbMsk9ZkrZXVjSopunayPbk7yY3/4T4NrYcxNgz+6WBvQiUQLawGE571F7k4F
	PkfsKbrE4eyu6YkmocRu6GmdwjKsaYIOHVT674qUhasBFeCP2GcZ3Zqg=
X-Google-Smtp-Source: AGHT+IFUQrGsvXeelHT3hR2H1+SFhCcmND1ddFgQcrnerRqeGhQD1VgHzz4BUgjNzWevePw42HumUBdRdkmjISGuwLNxYDMrLWxW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d11:b0:36a:3ee8:b9f9 with SMTP id
 i17-20020a056e021d1100b0036a3ee8b9f9mr163547ila.2.1712912431927; Fri, 12 Apr
 2024 02:00:31 -0700 (PDT)
Date: Fri, 12 Apr 2024 02:00:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000095d320615e2813f@google.com>
Subject: [syzbot] [jffs2?] kernel BUG in jffs2_sum_write_sumnode
From: syzbot <syzbot+badbb16b0a5dd4c2f676@syzkaller.appspotmail.com>
To: dwmw2@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, richard@nod.at, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    00dcf5d862e8 Merge tag 'acpi-6.9-rc4' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a98eeb180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5a8421528fe0176
dashboard link: https://syzkaller.appspot.com/bug?extid=badbb16b0a5dd4c2f676
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-00dcf5d8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/68de786626b3/vmlinux-00dcf5d8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dba6f0189428/bzImage-00dcf5d8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+badbb16b0a5dd4c2f676@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/jffs2/summary.c:865!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 3 PID: 5545 Comm: syz-executor.3 Not tainted 6.9.0-rc3-syzkaller-00189-g00dcf5d862e8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:jffs2_sum_write_sumnode+0x1cf6/0x2220 fs/jffs2/summary.c:865
Code: 0f b6 04 02 84 c0 74 08 3c 03 0f 8e d7 01 00 00 8b b3 c0 05 00 00 48 c7 c2 40 b7 44 8b 48 c7 c7 40 b3 44 8b e8 ab 09 8f fe 90 <0f> 0b e8 23 6b f1 07 e8 6e b6 0a ff e9 d9 e5 ff ff 48 89 cf 48 89
RSP: 0018:ffffc9000ca874d0 EFLAGS: 00010282
RAX: 0000000000000045 RBX: ffff88801fb6a440 RCX: ffffffff816f3829
RDX: 0000000000000000 RSI: ffffffff816fc366 RDI: 0000000000000005
RBP: ffffc9000ca87650 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88805e196898 R15: ffff888059d1a000
FS:  0000000000000000(0000) GS:ffff88802c500000(0063) knlGS:00000000f5ea1b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000c001927000 CR3: 000000005fbbe000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jffs2_do_reserve_space+0xb52/0x1030 fs/jffs2/nodemgmt.c:388
 jffs2_reserve_space+0x62e/0xba0 fs/jffs2/nodemgmt.c:197
 do_jffs2_setxattr+0x1a1/0x16c0 fs/jffs2/xattr.c:1113
 __vfs_setxattr+0x173/0x1e0 fs/xattr.c:200
 __vfs_setxattr_noperm+0x127/0x5e0 fs/xattr.c:234
 __vfs_setxattr_locked+0x182/0x260 fs/xattr.c:295
 vfs_setxattr+0x146/0x350 fs/xattr.c:321
 do_setxattr+0x146/0x170 fs/xattr.c:629
 setxattr+0x15d/0x180 fs/xattr.c:652
 path_setxattr+0x179/0x1e0 fs/xattr.c:671
 __do_sys_lsetxattr fs/xattr.c:694 [inline]
 __se_sys_lsetxattr fs/xattr.c:690 [inline]
 __ia32_sys_lsetxattr+0xbd/0x160 fs/xattr.c:690
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf72af579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5ea15ac EFLAGS: 00000292 ORIG_RAX: 00000000000000e3
RAX: ffffffffffffffda RBX: 00000000200001c0 RCX: 00000000200002c0
RDX: 0000000020002040 RSI: 0000000000001009 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:jffs2_sum_write_sumnode+0x1cf6/0x2220 fs/jffs2/summary.c:865
Code: 0f b6 04 02 84 c0 74 08 3c 03 0f 8e d7 01 00 00 8b b3 c0 05 00 00 48 c7 c2 40 b7 44 8b 48 c7 c7 40 b3 44 8b e8 ab 09 8f fe 90 <0f> 0b e8 23 6b f1 07 e8 6e b6 0a ff e9 d9 e5 ff ff 48 89 cf 48 89
RSP: 0018:ffffc9000ca874d0 EFLAGS: 00010282
RAX: 0000000000000045 RBX: ffff88801fb6a440 RCX: ffffffff816f3829
RDX: 0000000000000000 RSI: ffffffff816fc366 RDI: 0000000000000005
RBP: ffffc9000ca87650 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88805e196898 R15: ffff888059d1a000
FS:  0000000000000000(0000) GS:ffff88802c500000(0063) knlGS:00000000f5ea1b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000c001927000 CR3: 000000005fbbe000 CR4: 0000000000350ef0
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

