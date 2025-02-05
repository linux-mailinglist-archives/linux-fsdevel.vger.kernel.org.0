Return-Path: <linux-fsdevel+bounces-40901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFCFA284DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 08:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44901887E8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 07:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490852288E4;
	Wed,  5 Feb 2025 07:18:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3158C21D5AE
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738739911; cv=none; b=HkAXD9uGQ9mJmj4/Nd9ckk67Q1F+Rc4ofn532q5lfFXp7ICoG/18wdXrW+oXCl3DFL6AP/P1XIUJKgBIFADiRKkvPw4AvcYMBNkta7dvqEgaP/MAxdov7D37sGX0uvvs0wA13Y78gKhrz+IW05A/nB5fCafNdkg+1CjFBceLpFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738739911; c=relaxed/simple;
	bh=c31GOFHmUOs+019a78t78hIBV/TSKrtiyoQf0m5l2B0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R++co776nXwGQiAFdS5j0lQB+LJ/jN4/wK4F5oe9xwA5REEeKijZ70+JS09H4tIbB5Sth3+hg25dMZh+tlNWRnFLehxu0OR0czC2eILfE+Fj6PnAjnJ57KWX1iPIRpaGrYx48gVzr8QHslNhWpMNMdyw4BpFf4QXOHawxBeaM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a9d4ea9e0cso53732695ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 23:18:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738739909; x=1739344709;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SRVdUExgpTeP2D/23IgvlLTBI1qzhVp7H8YiBe2djyw=;
        b=hyq/hWnzpfw1+4q0ZAz8JyDamhadrlcZ1oxz7iAvbNyXU0vkIuW7TKh2Aml7pavKA7
         YxOnruC5tHf6PthTCPxdc1BQbvJATQhw0FUBvJEeZ0ClQE/cJwjjMC3WHU7fJTsQNxxO
         +Gqo78L6vxNCcsH+ZXNbWPSImH34HVdt06qPvr7LOZlLWocLVu6lsUxaHLtZIu/jciy6
         Cf1gLMx+F8ypaQ659AOz92Yqts4Id+JxKZZ+tDeew2/xntScWHq8+315MUHFKBKxDjqr
         KI2FRxNp7lAxxZsXFwDVrqHO+hoIsDuRMkQYTLqwTWPejnAt3GkJp/7z2aBeeu3ll9j5
         1zsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYiJOmUUb10qPTd6Mg6OKUSoBH2YqkwcsY/UlI1YHEAvIKoM9ygG7F6zYD453kmuYZMCpm/lVf8zCQgZig@vger.kernel.org
X-Gm-Message-State: AOJu0YwYeJ89vWUDY4BaeTPoSdKZLdER13ymtB48zdbZCAmxdnDUaVc0
	VpjXupNXTrcHrlSKhdXmiH/miTPSq563DAngCaG7V3ImqEH1HNKcdlZuNQ2lYXsFJJmGg5PyaKJ
	kInefEXpHNINqAVkVhj43NWor4AwOlgFtgmZ7IB3igJeNM52wkvjQjxM=
X-Google-Smtp-Source: AGHT+IFTJhegFm9qBv+JshkaQ3AZLd/L7Cun/mAeyLkUkbORCFqEdyre+eeDBAaZLnsFJ3HWbsBV6uluYT2n079mZcpVbmO1lnVf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1547:b0:3d0:2314:26e5 with SMTP id
 e9e14a558f8ab-3d04f8f6f3bmr15673695ab.18.1738739909291; Tue, 04 Feb 2025
 23:18:29 -0800 (PST)
Date: Tue, 04 Feb 2025 23:18:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a310c5.050a0220.50516.0011.GAE@google.com>
Subject: [syzbot] [bcachefs?] general protection fault in inode_permission (3)
From: syzbot <syzbot+1facc65919790d188467@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69b8923f5003 Merge tag 'for-linus-6.14-ofs4' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117c3ddf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57ab43c279fa614d
dashboard link: https://syzkaller.appspot.com/bug?extid=1facc65919790d188467
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149d95f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea84ac864e92/disk-69b8923f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a465997b4e0/vmlinux-69b8923f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d72b67b2bd15/bzImage-69b8923f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/16b90949171c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1facc65919790d188467@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 6297 Comm: syz.0.44 Not tainted 6.13.0-syzkaller-09793-g69b8923f5003 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:do_inode_permission fs/namei.c:523 [inline]
RIP: 0010:inode_permission+0x62/0x460 fs/namei.c:592
Code: e3 02 48 89 5c 24 10 89 6c 24 0c 0f 85 cf 00 00 00 4d 89 e5 e8 ef c7 87 ff 4c 89 f5 4d 8d 66 02 4c 89 e3 48 c1 eb 03 4d 89 fe <42> 0f b6 04 3b 84 c0 0f 85 16 03 00 00 45 0f b7 3c 24 44 89 fe 83
RSP: 0018:ffffc900034379c0 EFLAGS: 00010246
RAX: ffffffff82379481 RBX: 0000000000000000 RCX: ffff88804d699e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8237945b R09: ffffffff8238fda6
R10: 0000000000000002 R11: ffff88804d699e00 R12: 0000000000000002
R13: ffffffff8ea8dbc0 R14: dffffc0000000000 R15: dffffc0000000000
FS:  00007f4ad8e416c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4acfbff000 CR3: 000000004c82c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 may_lookup fs/namei.c:1821 [inline]
 link_path_walk+0x204/0xea0 fs/namei.c:2427
 path_parentat fs/namei.c:2683 [inline]
 __filename_parentat+0x2a7/0x740 fs/namei.c:2707
 filename_parentat fs/namei.c:2725 [inline]
 filename_create+0xf6/0x540 fs/namei.c:4063
 do_mkdirat+0xbd/0x3a0 fs/namei.c:4328
 __do_sys_mkdirat fs/namei.c:4351 [inline]
 __se_sys_mkdirat fs/namei.c:4349 [inline]
 __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4349
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4ad7f8b617
Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 02 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4ad8e40e68 EFLAGS: 00000202 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f4ad8e40ef0 RCX: 00007f4ad7f8b617
RDX: 00000000000001ff RSI: 0000000020000040 RDI: 00000000ffffff9c
RBP: 0000000020000000 R08: 0000000000000000 R09: 0000000000005939
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000040
R13: 00007f4ad8e40eb0 R14: 000000000000593f R15: 0000000020000380
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:do_inode_permission fs/namei.c:523 [inline]
RIP: 0010:inode_permission+0x62/0x460 fs/namei.c:592
Code: e3 02 48 89 5c 24 10 89 6c 24 0c 0f 85 cf 00 00 00 4d 89 e5 e8 ef c7 87 ff 4c 89 f5 4d 8d 66 02 4c 89 e3 48 c1 eb 03 4d 89 fe <42> 0f b6 04 3b 84 c0 0f 85 16 03 00 00 45 0f b7 3c 24 44 89 fe 83
RSP: 0018:ffffc900034379c0 EFLAGS: 00010246
RAX: ffffffff82379481 RBX: 0000000000000000 RCX: ffff88804d699e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8237945b R09: ffffffff8238fda6
R10: 0000000000000002 R11: ffff88804d699e00 R12: 0000000000000002
R13: ffffffff8ea8dbc0 R14: dffffc0000000000 R15: dffffc0000000000
FS:  00007f4ad8e416c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
----------------
Code disassembly (best guess):
   0:	e3 02                	jrcxz  0x4
   2:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
   7:	89 6c 24 0c          	mov    %ebp,0xc(%rsp)
   b:	0f 85 cf 00 00 00    	jne    0xe0
  11:	4d 89 e5             	mov    %r12,%r13
  14:	e8 ef c7 87 ff       	call   0xff87c808
  19:	4c 89 f5             	mov    %r14,%rbp
  1c:	4d 8d 66 02          	lea    0x2(%r14),%r12
  20:	4c 89 e3             	mov    %r12,%rbx
  23:	48 c1 eb 03          	shr    $0x3,%rbx
  27:	4d 89 fe             	mov    %r15,%r14
* 2a:	42 0f b6 04 3b       	movzbl (%rbx,%r15,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 16 03 00 00    	jne    0x34d
  37:	45 0f b7 3c 24       	movzwl (%r12),%r15d
  3c:	44 89 fe             	mov    %r15d,%esi
  3f:	83                   	.byte 0x83


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

