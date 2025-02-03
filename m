Return-Path: <linux-fsdevel+bounces-40657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E522AA26402
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 20:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114CD1883D15
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 19:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B234209F22;
	Mon,  3 Feb 2025 19:48:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C241D89E4
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738612109; cv=none; b=VU7gOGB7lqzqLenUhuSW8oYPvf1NuPbrIHUvQjm4uu3ij7Pzw65wLSHN38tEX0nkKuEiTAolgKo+sriHPIM8qRAaf+kHjmlWIT9I6/8gefw9tdeY5ypsv96fkCdBBGJzSvF0LeIOr5F3+JnN8FV7eL0c0KlSWERrKBw9T3sHeVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738612109; c=relaxed/simple;
	bh=VBKeXvVpxzsbDD2gzQOz5enbyWOMnGBYHhlsZ2Gq4z4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FR/mdDZUSechweBl3EArgYfvVCuecqesrxJkI+h32+nFtzi0QzQEKWXCBnjpTwnPQfwWbA/bhV69jck3G5IX+W1B/6LEaJ3F2YS72Jg5VB6pk4nO7Rm7gP63ys9n678P4Zs/MDWHFwD9wzJWIZNnXZxu8EWwY/V+C5zmqQIuDrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d0203cf90cso47112285ab.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 11:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738612106; x=1739216906;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5u+KEwvUiQ1R4lQW9YeruG6CDtjvrWJJAfql7IrJ7c=;
        b=TE/p4CW92ow9fuaj4yIcxQEtJABfFfAK/GcfmDUIiMbWvJwhoDt2pFK3mCgYRLEUBx
         J5xY+CSleqZDjV5cp+d0k8UEkksXZroDROWvjMLeRkkqPK7PSYnbIs/D/Bc20IHET2dO
         GAcOIr3G7d3tMZeRzZHiIhj2RdS6+oNVzLkt1G2jKsVohJJnnpPxG6ZhlHjpzFmsgX09
         ++/xLjlvJ48IUoQNB4kVEcQIg2s9NlBQMTVJ5bJbI2hG8pkqok5IJtlNfUpZz60vOFTP
         pHrXevH2U2jxzSLIkK6BzZF7jfJNkzyxHeqsZDGM4SNTBUO6jrbScrMI3MVtjUD0IYrt
         TyEg==
X-Forwarded-Encrypted: i=1; AJvYcCV6LxyEDkFxTz1nBHT2qFoiurDYhQdR8dymCQ8YRmDk+1/joASs5oBCVOwaU+rTsv3a+amCCuc+DOukYfF4@vger.kernel.org
X-Gm-Message-State: AOJu0YymXdU+aMqu0vp40PKbpao+knEJQF2cwzQUapk1B6xW6W5MavZY
	5NG6C+kgkkhObZ5HEw6lQTX9fYoxBgwY7dx1/T5c6UPW8S89Dfcwj6henSmNqar5szSaUT+IAEA
	BsrKpGN9Q6JElNPss3BuzWpneDxJOGe1AZgf79w/c85KidONbFb9zBhI=
X-Google-Smtp-Source: AGHT+IEmqLf94zcO652pUFeOrh1ZTBYTJK0PxvISMseIvYGnAdBDOLiaFM71kpMY2kxdhp8E2R0as2E2Zl0PXZRQ+Z2OUHHVx25V
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:221e:b0:3d0:239a:c46f with SMTP id
 e9e14a558f8ab-3d0239acd38mr94298665ab.12.1738612106568; Mon, 03 Feb 2025
 11:48:26 -0800 (PST)
Date: Mon, 03 Feb 2025 11:48:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a11d8a.050a0220.163cdc.0051.GAE@google.com>
Subject: [syzbot] [udf?] general protection fault in d_splice_alias
From: syzbot <syzbot+a9c0867e4d1dd0c7ab19@syzkaller.appspotmail.com>
To: amir73il@gmail.com, asmadeus@codewreck.org, brauner@kernel.org, 
	corbet@lwn.net, ericvh@kernel.org, jack@suse.com, jack@suse.cz, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	mjguzik@gmail.com, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11bfc518580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1a6d4df5fcc342f
dashboard link: https://syzkaller.appspot.com/bug?extid=a9c0867e4d1dd0c7ab19
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125d0eb0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a595f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a4b4612f419c/disk-69e858e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/07abf7c78a98/vmlinux-69e858e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/085b44906cce/bzImage-69e858e0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0e8d208f30b1/mount_0.gz

The issue was bisected to:

commit 30d61efe118cad1a73ad2ad66a3298e4abdf9f41
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Jan 6 02:33:17 2025 +0000

    9p: fix ->rename_sem exclusion

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1050fddf980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1250fddf980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1450fddf980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a9c0867e4d1dd0c7ab19@syzkaller.appspotmail.com
Fixes: 30d61efe118c ("9p: fix ->rename_sem exclusion")

UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
Oops: general protection fault, probably for non-canonical address 0xdffffc000000000d: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
CPU: 0 UID: 0 PID: 5832 Comm: syz-executor165 Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:__d_unalias fs/dcache.c:2969 [inline]
RIP: 0010:d_splice_alias+0x9cd/0xf30 fs/dcache.c:3037
Code: 48 c1 ea 03 80 3c 02 00 0f 85 4e 05 00 00 49 8b 85 70 ff ff ff 48 ba 00 00 00 00 00 fc ff df 48 8d 78 68 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f 85 14 05 00 00 48 8b 40 68 48 85 c0 74 31 48 89 44
RSP: 0018:ffffc90003667c18 EFLAGS: 00010212
RAX: 0000000000000000 RBX: ffff88807dbd7318 RCX: 000000000000000d
RDX: dffffc0000000000 RSI: ffffffff82348f0c RDI: 0000000000000068
RBP: ffff8880754107b8 R08: 0000000000000000 R09: ffffed100f23d67a
R10: ffff8880791eb3d3 R11: 0000000000000032 R12: ffff8880791eb318
R13: ffff8880791eafd8 R14: ffff8880791eaeb0 R15: ffff8880791eaf48
FS:  0000555581642380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe875be000 CR3: 0000000076b7a000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 udf_lookup+0x191/0x240 fs/udf/namei.c:130
 lookup_one_qstr_excl+0x120/0x190 fs/namei.c:1693
 do_rmdir+0x247/0x410 fs/namei.c:4444
 __do_sys_rmdir fs/namei.c:4474 [inline]
 __se_sys_rmdir fs/namei.c:4472 [inline]
 __x64_sys_rmdir+0xc5/0x110 fs/namei.c:4472
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9ee0142d99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe875bd248 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 6f72746e6f632f2e RCX: 00007f9ee0142d99
RDX: 00007f9ee0142d99 RSI: 00007f9ee0142d99 RDI: 0000000020000100
RBP: 00007f9ee01b75f0 R08: 00005555816434c0 R09: 00005555816434c0
R10: 00005555816434c0 R11: 0000000000000246 R12: 00007ffe875bd270
R13: 00007ffe875bd498 R14: 431bde82d7b634db R15: 00007f9ee018c03b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__d_unalias fs/dcache.c:2969 [inline]
RIP: 0010:d_splice_alias+0x9cd/0xf30 fs/dcache.c:3037
Code: 48 c1 ea 03 80 3c 02 00 0f 85 4e 05 00 00 49 8b 85 70 ff ff ff 48 ba 00 00 00 00 00 fc ff df 48 8d 78 68 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f 85 14 05 00 00 48 8b 40 68 48 85 c0 74 31 48 89 44
RSP: 0018:ffffc90003667c18 EFLAGS: 00010212
RAX: 0000000000000000 RBX: ffff88807dbd7318 RCX: 000000000000000d
RDX: dffffc0000000000 RSI: ffffffff82348f0c RDI: 0000000000000068
RBP: ffff8880754107b8 R08: 0000000000000000 R09: ffffed100f23d67a
R10: ffff8880791eb3d3 R11: 0000000000000032 R12: ffff8880791eb318
R13: ffff8880791eafd8 R14: ffff8880791eaeb0 R15: ffff8880791eaf48
FS:  0000555581642380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe875be000 CR3: 0000000076b7a000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 4e 05 00 00    	jne    0x55c
   e:	49 8b 85 70 ff ff ff 	mov    -0x90(%r13),%rax
  15:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  1c:	fc ff df
  1f:	48 8d 78 68          	lea    0x68(%rax),%rdi
  23:	48 89 f9             	mov    %rdi,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
* 2a:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1) <-- trapping instruction
  2e:	0f 85 14 05 00 00    	jne    0x548
  34:	48 8b 40 68          	mov    0x68(%rax),%rax
  38:	48 85 c0             	test   %rax,%rax
  3b:	74 31                	je     0x6e
  3d:	48                   	rex.W
  3e:	89                   	.byte 0x89
  3f:	44                   	rex.R


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

