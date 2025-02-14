Return-Path: <linux-fsdevel+bounces-41749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65458A36699
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 20:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD23E7A4D24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 19:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8381C8634;
	Fri, 14 Feb 2025 19:58:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C892E1C84C6
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739563106; cv=none; b=VI7gtYd0U2yDvKwsvxUDCbpgczXQg7B5NqoD8NvS/bQBccVCuD8M18ZbXMC1WwCeTotHXwbOyjnhGfsUgn/Frbz2offlQlH4JRApVqJ6ofAhFckL3UExWKM0o9q1SAzvnKG2LAdLX+NsYDVIlQ/I6FqGQIzMX5LsgAJh4VnNMTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739563106; c=relaxed/simple;
	bh=/gvLMjNcFaFz6dSz0rcCsU90lvPIvHm6x7oqcQQ33LE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rnMWNQ7Lg30ZSJ99jTuqa25zuk0+d+ZQPrmwwnKK0f1MUi361XlC+RMJQbOidNqAHvKUKVtX9Cz13bb3S/ko7ymJt3vYpORr6XSbtE7NOhsL7n+JpiAgoELHzIlzHuyheop74dmqRafwYlBEQkU0yOvWeoTpogGFFch8MtMxNh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-8556ce3d4ceso303311439f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 11:58:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739563104; x=1740167904;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDKODr4MuLZ3lyXb732mvfwv2AIo0qNyeX+9y10itI0=;
        b=L0zBXnX+eBN1q9GPWe3CDX0jugwcRp+4JDzUWE7pEbQIpJ9C854eSsS+mw+RYlcDTI
         iQiA6718iLo9ggxbVXuzWVY1yoIWwacYY7d+jyuOJOQXUUKjb37Lcfm3nVTxh59t4cwe
         H4WEl31WeWBsIGEpWjwXYFwBYt5aM75qXc+sP6hP2t0bNWProygYUsBQZE/pABtFMh5s
         foCIWxNXSrk/DXaWcoU+OXC3scgoJTVGVWHhtv0BZKdXMuZugu5yBFXkgNtHvfV2REEC
         1mR90q2emKe7HPk3xSKHnmMy6YIwZKZN5Dmtl93FzBNM6udSGlX6Vezt4zU7w6WWWZs9
         V0kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkwEceD3+/V8P6NxFGffkDRQ3F1/aF1I9/gh8nBvxrpTGLwBDlcfIccr5u+Xd5QSq8UaMWjiHP5EopQ3d1@vger.kernel.org
X-Gm-Message-State: AOJu0YwiG4uLquK1gqcXJ9UI405L5x4LJNi8wrFhLaqfiAPI3ELZk/bM
	YOEeRfZSAFq2IjWg+upOVN2/qZFSJD1w1m6JDklNKfWQvEUw6Ogdd28q4WvJdkYT4rgrrjdfLGr
	ksQuNinuHWiz93xquFQPn9W77FFN1zy1JMBNTOharBxP3HpsUeGNGZZk=
X-Google-Smtp-Source: AGHT+IHPEHBkcThOnyMELL0sTNAQVybE1JUAN60KrS4NfXcaUpqP+6td3DDS5uFItpcG8I/oH6uW5Ggq//Z8vhI6nZlfZpZpk5BR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8c:b0:3d0:21aa:a756 with SMTP id
 e9e14a558f8ab-3d2807aba07mr6590265ab.5.1739563103999; Fri, 14 Feb 2025
 11:58:23 -0800 (PST)
Date: Fri, 14 Feb 2025 11:58:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67afa05f.050a0220.21dd3.0050.GAE@google.com>
Subject: [syzbot] [udf?] BUG: unable to handle kernel paging request in lookup_one_qstr_excl
From: syzbot <syzbot+2d18bb4b8a11cab7ab13@syzkaller.appspotmail.com>
To: anna@kernel.org, brauner@kernel.org, jack@suse.com, jack@suse.cz, 
	linkinjeon@kernel.org, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, neilb@suse.de, senozhatsky@chromium.org, 
	sfrench@samba.org, syzkaller-bugs@googlegroups.com, tom@talpey.com, 
	trondmy@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b7a883c7f4d Add linux-next specific files for 20250213
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=116913f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fce2f4fd0c881e1
dashboard link: https://syzkaller.appspot.com/bug?extid=2d18bb4b8a11cab7ab13
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f8fbdf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156913f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f96ca702937a/disk-7b7a883c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/901577be06a5/vmlinux-7b7a883c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/61175f206a2f/bzImage-7b7a883c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/31908970193f/mount_0.gz

The issue was bisected to:

commit 22d9d5e93d0eaf7e8662602713b24e9b6171759f
Author: NeilBrown <neilb@suse.de>
Date:   Fri Feb 7 03:36:48 2025 +0000

    VFS: add common error checks to lookup_one_qstr_excl()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=114ba1a4580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=134ba1a4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=154ba1a4580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2d18bb4b8a11cab7ab13@syzkaller.appspotmail.com
Fixes: 22d9d5e93d0e ("VFS: add common error checks to lookup_one_qstr_excl()")

UDF-fs: error (device loop0): udf_read_tagged: tag checksum failed, block 99: 0x27 != 0x4d
UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
UDF-fs: error (device loop0): udf_verify_fi: directory (ino 1376) has entry where CRC length (63772) does not match entry length (28)
BUG: unable to handle page fault for address: ffffffffffffff8b
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD e93c067 P4D e93c067 PUD e93e067 PMD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5835 Comm: syz-executor196 Not tainted 6.14.0-rc2-next-20250213-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:__d_entry_type include/linux/dcache.h:416 [inline]
RIP: 0010:d_is_miss include/linux/dcache.h:421 [inline]
RIP: 0010:d_is_negative include/linux/dcache.h:467 [inline]
RIP: 0010:lookup_one_qstr_excl+0x162/0x370 fs/namei.c:1696
Code: d3 66 90 48 85 c0 0f 85 58 01 00 00 e8 17 dd 84 ff 4c 89 f0 48 c1 e8 03 42 0f b6 04 28 84 c0 0f 85 57 01 00 00 bb 00 00 38 00 <41> 23 1e 44 89 fd 81 e5 00 00 02 00 89 de 09 ee 31 ff e8 27 e1 84
RSP: 0018:ffffc90003f2fcb8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000380000 RCX: ffff888034c01e00
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffff888074918164 R08: ffff88807ab8fe1b R09: 1ffff1100f571fc3
R10: dffffc0000000000 R11: ffffed100f571fc4 R12: ffff88807ab8fd60
R13: dffffc0000000000 R14: ffffffffffffff8b R15: 0000000000060000
FS:  0000555565c15380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffff8b CR3: 00000000776ac000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 filename_create+0x282/0x480 fs/namei.c:4091
 do_mkdirat+0xbd/0x3a0 fs/namei.c:4322
 __do_sys_mkdir fs/namei.c:4350 [inline]
 __se_sys_mkdir fs/namei.c:4348 [inline]
 __x64_sys_mkdir+0x6c/0x80 fs/namei.c:4348
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd68a577a57
Code: ff ff 77 07 31 c0 c3 0f 1f 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc24c81108 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd68a577a57
RDX: 0000000000000000 RSI: 00000000000001ff RDI: 0000400000000080
RBP: 0000400000000080 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc24c811a0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: ffffffffffffff8b
---[ end trace 0000000000000000 ]---
RIP: 0010:__d_entry_type include/linux/dcache.h:416 [inline]
RIP: 0010:d_is_miss include/linux/dcache.h:421 [inline]
RIP: 0010:d_is_negative include/linux/dcache.h:467 [inline]
RIP: 0010:lookup_one_qstr_excl+0x162/0x370 fs/namei.c:1696
Code: d3 66 90 48 85 c0 0f 85 58 01 00 00 e8 17 dd 84 ff 4c 89 f0 48 c1 e8 03 42 0f b6 04 28 84 c0 0f 85 57 01 00 00 bb 00 00 38 00 <41> 23 1e 44 89 fd 81 e5 00 00 02 00 89 de 09 ee 31 ff e8 27 e1 84
RSP: 0018:ffffc90003f2fcb8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000380000 RCX: ffff888034c01e00
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffff888074918164 R08: ffff88807ab8fe1b R09: 1ffff1100f571fc3
R10: dffffc0000000000 R11: ffffed100f571fc4 R12: ffff88807ab8fd60
R13: dffffc0000000000 R14: ffffffffffffff8b R15: 0000000000060000
FS:  0000555565c15380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffff8b CR3: 00000000776ac000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	d3 66 90             	shll   %cl,-0x70(%rsi)
   3:	48 85 c0             	test   %rax,%rax
   6:	0f 85 58 01 00 00    	jne    0x164
   c:	e8 17 dd 84 ff       	call   0xff84dd28
  11:	4c 89 f0             	mov    %r14,%rax
  14:	48 c1 e8 03          	shr    $0x3,%rax
  18:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax
  1d:	84 c0                	test   %al,%al
  1f:	0f 85 57 01 00 00    	jne    0x17c
  25:	bb 00 00 38 00       	mov    $0x380000,%ebx
* 2a:	41 23 1e             	and    (%r14),%ebx <-- trapping instruction
  2d:	44 89 fd             	mov    %r15d,%ebp
  30:	81 e5 00 00 02 00    	and    $0x20000,%ebp
  36:	89 de                	mov    %ebx,%esi
  38:	09 ee                	or     %ebp,%esi
  3a:	31 ff                	xor    %edi,%edi
  3c:	e8                   	.byte 0xe8
  3d:	27                   	(bad)
  3e:	e1 84                	loope  0xffffffc4


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

