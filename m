Return-Path: <linux-fsdevel+bounces-56243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1837B14CF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 13:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB61C18A0C02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 11:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060F928C846;
	Tue, 29 Jul 2025 11:24:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF03528981D
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753788269; cv=none; b=cA6+LW5OlrdiC3d89sq+zhzfZGIwMX3Rg94SgqN5RcVvpCxIjhduBN2In8sQpzfASKQrtdo4vZiDhW+3/om62s12q8lyOyowVdQC7p2dba3YW8IDrhviiJjyFroFAOgsLv9ng6GevYX4S/fOAohE5r5E4CQbUFmRBwhlaNX8sg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753788269; c=relaxed/simple;
	bh=DL8qFxfg1HgtxcEXO/rQrJ8vfPWfRFgxAS9jXwTpXvk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qglOjdobGAsR3GlfNt+arEttSJew3qoR/kX+bolLp3JkvaUV1R7An/g4jdZUFClXKDH8XPfONO45wSWxymUx6oOsQcOnbEJLDfBcipRyXFsxJU7pvLks0DRDm0lL7Y0/n3ww3BtuXd4M615HJE1KFv+z3VOm+v0G9X0CbPJFQm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ddc5137992so66621885ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 04:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753788267; x=1754393067;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BppeKnpvFey3CG6RIsc+Nsp8dEZmLVpIsqZ5XIEsLHs=;
        b=IbMxhFPeSF5OotBtrLQNW9pnupAgsVgDb9LxsXV9Miqjj37UM32Nsg+sMY5J5PUOeb
         LlqlHL8xLGFwS0+j9F1Ua5+8LGzb95abT8qD96WtDZXi25ar/dsBXY0EnpRI5b8LfLbd
         +IQUmEXduaH1qB3VO11sTuGkiI/l2ngHCdK5QBlch5bf3kQ6ccoJm8xZAVnkYhBfvyH6
         YnJR2VG+xc9m/+qpjHNGOwjNVX+6q98u/SWenRDniqrPd0zjGBd+Qi60UZYrtpVwvdWy
         QUvIm2Ajv+VgqGMdds6ar+86fAajK6rEKn8qtT0zzgbjJuBmyuzY0UWX3b0si0UJI2S7
         QStg==
X-Forwarded-Encrypted: i=1; AJvYcCXgCTJxvLZkxZzgF0DikT1nWk7C0AMCvDilIq4/1oDzNUuO+wfaQu5W5eT3EKSAWzwfJ1bUwiHfa65hsO7S@vger.kernel.org
X-Gm-Message-State: AOJu0YxWmlesTUzK2O0KmNeoyQNSVVi2BYFPInf4BoSiPI2Zx8ZxSmp1
	hhHc0rDNdp2E+HAafmpU3/Q6/Jx/7KR4jX8jBKJi30VNQmHViZ6CXFkRCOPaRY65Ouj2Y+LX1oj
	n3zNrjljcE4N5qwMt15Y5JLM+a7Nu/EjTB4OvkHmNrzzft6kJIah5b7/0owM=
X-Google-Smtp-Source: AGHT+IHDvmXudWs7JSQ0RGX2DxbYOn3vwdsH9V0p+YADluQgHr4eiK0vWXrvXu1eW6HWc8QVZ5dDmUNB6aKChLFJB9QKoHtrBhZF
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd86:0:b0:3e3:e78e:4e0a with SMTP id
 e9e14a558f8ab-3e3e78eb647mr52083895ab.1.1753788267124; Tue, 29 Jul 2025
 04:24:27 -0700 (PDT)
Date: Tue, 29 Jul 2025 04:24:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6888af6b.050a0220.73271.0002.GAE@google.com>
Subject: [syzbot] [fs?] kernel BUG in mpage_readahead
From: syzbot <syzbot+fdba5cca73fee92c69d6@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    25fae0b93d1d Merge tag 'drm-fixes-2025-07-24' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152d70a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=859f36d9ccbeaa3e
dashboard link: https://syzkaller.appspot.com/bug?extid=fdba5cca73fee92c69d6
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dc00f98ff419/disk-25fae0b9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/05e43f05893a/vmlinux-25fae0b9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3b079c14e6b9/bzImage-25fae0b9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fdba5cca73fee92c69d6@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at ./include/linux/pagemap.h:1379!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 10369 Comm: syz.3.1129 Not tainted 6.16.0-rc7-syzkaller-00034-g25fae0b93d1d #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__readahead_folio include/linux/pagemap.h:1379 [inline]
RIP: 0010:readahead_folio include/linux/pagemap.h:1405 [inline]
RIP: 0010:mpage_readahead+0x637/0x650 fs/mpage.c:367
Code: c6 a0 d9 99 8b e8 69 13 c1 ff 90 0f 0b e8 b1 e6 7c ff 4c 89 ef 48 c7 c6 00 da 99 8b e8 52 13 c1 ff 90 0f 0b e8 9a e6 7c ff 90 <0f> 0b e8 92 e6 7c ff 90 0f 0b 66 66 66 66 66 66 2e 0f 1f 84 00 00
RSP: 0018:ffffc90003876f40 EFLAGS: 00010246
RAX: ffffffff82433f16 RBX: 0000000000000001 RCX: 0000000000080000
RDX: ffffc90010f1f000 RSI: 000000000007ffff RDI: 0000000000080000
RBP: ffffc90003877130 R08: ffffea00016fac07 R09: 1ffffd40002df580
R10: dffffc0000000000 R11: fffff940002df581 R12: dffffc0000000000
R13: ffffc900038773a8 R14: 0000000000000010 R15: ffffc900038773c0
FS:  00007f969af276c0(0000) GS:ffff888125c57000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe3f14b6fe0 CR3: 0000000030d80000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 read_pages+0x177/0x580 mm/readahead.c:160
 page_cache_ra_unbounded+0x346/0x7b0 mm/readahead.c:264
 do_sync_mmap_readahead+0x370/0x5f0 mm/filemap.c:3247
 filemap_fault+0x62a/0x1200 mm/filemap.c:3412
 __do_fault+0x135/0x390 mm/memory.c:5169
 do_read_fault mm/memory.c:5590 [inline]
 do_fault mm/memory.c:5724 [inline]
 do_pte_missing mm/memory.c:4251 [inline]
 handle_pte_fault mm/memory.c:6069 [inline]
 __handle_mm_fault+0x37ed/0x5620 mm/memory.c:6212
 handle_mm_fault+0x2d5/0x7f0 mm/memory.c:6381
 do_user_addr_fault+0x764/0x1390 arch/x86/mm/fault.c:1387
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:rep_movs_alternative+0x30/0x90 arch/x86/lib/copy_user_64.S:60
Code: 83 f9 08 73 25 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 <48> 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 db 83 f9 08
RSP: 0018:ffffc90003877a18 EFLAGS: 00050206
RAX: 00007ffffffff001 RBX: 0000000000000038 RCX: 0000000000000038
RDX: 0000000000000001 RSI: 0000200000391000 RDI: ffffc90003877aa0
RBP: ffffc90003877c30 R08: ffffc90003877ad7 R09: 1ffff9200070ef5a
R10: dffffc0000000000 R11: fffff5200070ef5b R12: 0000000000000002
R13: dffffc0000000000 R14: ffffc90003877aa0 R15: 0000200000391000
 copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
 raw_copy_from_user arch/x86/include/asm/uaccess_64.h:141 [inline]
 _inline_copy_from_user include/linux/uaccess.h:178 [inline]
 _copy_from_user+0x7a/0xb0 lib/usercopy.c:18
 copy_from_user include/linux/uaccess.h:212 [inline]
 copy_msghdr_from_user net/socket.c:2496 [inline]
 recvmsg_copy_msghdr net/socket.c:2752 [inline]
 ___sys_recvmsg+0x12e/0x510 net/socket.c:2824
 do_recvmmsg+0x307/0x770 net/socket.c:2923
 __sys_recvmmsg net/socket.c:2997 [inline]
 __do_sys_recvmmsg net/socket.c:3020 [inline]
 __se_sys_recvmmsg net/socket.c:3013 [inline]
 __x64_sys_recvmmsg+0x190/0x240 net/socket.c:3013
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f969a18e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f969af27038 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007f969a3b6080 RCX: 00007f969a18e9a9
RDX: 0000000000010106 RSI: 00002000000000c0 RDI: 0000000000000003
RBP: 00007f969a210d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f969a3b6080 R15: 00007ffd46031bf8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__readahead_folio include/linux/pagemap.h:1379 [inline]
RIP: 0010:readahead_folio include/linux/pagemap.h:1405 [inline]
RIP: 0010:mpage_readahead+0x637/0x650 fs/mpage.c:367
Code: c6 a0 d9 99 8b e8 69 13 c1 ff 90 0f 0b e8 b1 e6 7c ff 4c 89 ef 48 c7 c6 00 da 99 8b e8 52 13 c1 ff 90 0f 0b e8 9a e6 7c ff 90 <0f> 0b e8 92 e6 7c ff 90 0f 0b 66 66 66 66 66 66 2e 0f 1f 84 00 00
RSP: 0018:ffffc90003876f40 EFLAGS: 00010246
RAX: ffffffff82433f16 RBX: 0000000000000001 RCX: 0000000000080000
RDX: ffffc90010f1f000 RSI: 000000000007ffff RDI: 0000000000080000
RBP: ffffc90003877130 R08: ffffea00016fac07 R09: 1ffffd40002df580
R10: dffffc0000000000 R11: fffff940002df581 R12: dffffc0000000000
R13: ffffc900038773a8 R14: 0000000000000010 R15: ffffc900038773c0
FS:  00007f969af276c0(0000) GS:ffff888125d57000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe3f1497d58 CR3: 0000000030d80000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	83 f9 08             	cmp    $0x8,%ecx
   3:	73 25                	jae    0x2a
   5:	85 c9                	test   %ecx,%ecx
   7:	74 0f                	je     0x18
   9:	8a 06                	mov    (%rsi),%al
   b:	88 07                	mov    %al,(%rdi)
   d:	48 ff c7             	inc    %rdi
  10:	48 ff c6             	inc    %rsi
  13:	48 ff c9             	dec    %rcx
  16:	75 f1                	jne    0x9
  18:	c3                   	ret
  19:	cc                   	int3
  1a:	cc                   	int3
  1b:	cc                   	int3
  1c:	cc                   	int3
  1d:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  24:	00 00 00
  27:	0f 1f 00             	nopl   (%rax)
* 2a:	48 8b 06             	mov    (%rsi),%rax <-- trapping instruction
  2d:	48 89 07             	mov    %rax,(%rdi)
  30:	48 83 c6 08          	add    $0x8,%rsi
  34:	48 83 c7 08          	add    $0x8,%rdi
  38:	83 e9 08             	sub    $0x8,%ecx
  3b:	74 db                	je     0x18
  3d:	83 f9 08             	cmp    $0x8,%ecx


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

