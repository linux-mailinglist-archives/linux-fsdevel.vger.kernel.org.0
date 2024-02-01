Return-Path: <linux-fsdevel+bounces-9819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F311845390
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61018B22DA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2948C15CD54;
	Thu,  1 Feb 2024 09:14:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5C615B99C
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778869; cv=none; b=CRBmmTI49lHg02Ti2Fs14lQxwZJsB5c5IuQSXOS23PK8zHfglad1PBdlUujmp4D76HrxeGb5t06y9a15z0Jp+4cW3N4m255PgFR1wiN6PVEP2nZcZwgST7CIbTGYVamHhffYvLOsnthFO7ION4Xux3q6lt74nCE4ncDU1G1OLx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778869; c=relaxed/simple;
	bh=bed9xyodDyMyEJ4BC6RZnB9FKOYwGHhD9QSHoHjvZFw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PKZ5Jy7fR5nt7tyR/AfvTMDWvKKCMNy65TSY3GS3dyBAYcKRotlDTGCynt2lc3t9bFgvTji0hVAgVMFGMxHIynj/FXJ4lqPdbTGI/kRldWFtqJEAs1hpVLnceVJbtcecuD2ndcLJBCF9/T5vbq71X9TMCuWccNGaW+AN3aCrstI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36381f0e0a6so4942235ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 01:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706778867; x=1707383667;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o4noN0O6yFVomwvxVTGTAf5XWk3ASZshtfIGcmu1hIE=;
        b=rQCLFP1Q7kKJ1N+bJ/O46iH/HGYLoWTw2wRR5Il18mx3mZ3KOJFMyYf8bJ0lb9sT3m
         zYtZ355gwjPeaqeU7RUbXLUbhis8tcnMq5b5pGTqkBodJhpi3IyHAPjtSDR9UmVGvEC8
         74mf7SaZDRuFmHRL6XW1n3BS6qIrehIKSlXH1aMbXofMF88fI8Ocehn+DG7DGb41302y
         uwlawrkHYXUV011pVblEZsQ+BNHYObBV7WWDzPEZJA5NXjT/e18XSz6tPy34sEMNgh1l
         7ywNfoO5o2lmtGrwpmXjQblKnH0DdljSAKkHQ4/V2PZ3o5vg9YKsqC5ruDLEIj36h8Vi
         efEQ==
X-Gm-Message-State: AOJu0Yw4qpwjb6nAEKasOVC4mfb5xF+liiIkCmCFWzn2QTi75q6Br/sY
	HpDCJY31PunUrWaRUcBAxHjgJTaESw6P0rTWlHT/Hag9MUgmNE4/gbKkPwpbrB9RcROSy4AeqBr
	S+Nt7gcmlVLkn+2b86YHNEmhB94Boj17rtGzqiL64A51ib4Oy9BAKfVo=
X-Google-Smtp-Source: AGHT+IEmlqgMs9OByRJIoH1H4W4mLctLxU69IfDmVx7zMJPWDvxPzy37ceYeg+qS9sOsWOSpvS1YB3a/D2bqlGXriBsFnibuSAsU
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aad:b0:363:8be6:2b22 with SMTP id
 l13-20020a056e021aad00b003638be62b22mr346870ilv.1.1706778867236; Thu, 01 Feb
 2024 01:14:27 -0800 (PST)
Date: Thu, 01 Feb 2024 01:14:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017878306104e6c59@google.com>
Subject: [syzbot] [ext4?] [block?] kernel BUG in set_blocksize
From: syzbot <syzbot+4bfc572b93963675a662@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1bbb19b6eb1b Merge tag 'erofs-for-6.8-rc3-fixes' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146e3d40180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13fb219792fd389b
dashboard link: https://syzkaller.appspot.com/bug?extid=4bfc572b93963675a662
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175dc87be80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/798e03d5a1df/disk-1bbb19b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/54077750a6bf/vmlinux-1bbb19b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/840fdc1b94f1/bzImage-1bbb19b6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/63a064a072f7/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4bfc572b93963675a662@syzkaller.appspotmail.com

 __fput+0x429/0x8a0 fs/file_table.c:376
 __do_sys_close fs/open.c:1554 [inline]
 __se_sys_close fs/open.c:1539 [inline]
 __x64_sys_close+0x7e/0x110 fs/open.c:1539
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
------------[ cut here ]------------
kernel BUG at mm/truncate.c:413!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 8131 Comm: syz-executor.1 Not tainted 6.8.0-rc2-syzkaller-00047-g1bbb19b6eb1b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:truncate_inode_pages_range+0xe33/0xf70 mm/truncate.c:413
Code: 38 c1 0f 8c d5 f8 ff ff 4c 89 f7 e8 27 7f 24 00 e9 c8 f8 ff ff e8 ed b1 c5 ff 4c 89 e7 48 c7 c6 a0 8a b3 8b e8 2e 73 0a 00 90 <0f> 0b e8 96 b8 8f 09 e8 d1 b1 c5 ff 48 8b 7c 24 18 48 c7 c6 e0 8b
RSP: 0018:ffffc9000afc76c0 EFLAGS: 00010246
RAX: f4eb776fbe124800 RBX: 0000000000000001 RCX: ffffc9000afc7503
RDX: 0000000000000001 RSI: ffffffff8baac6e0 RDI: ffffffff8bfd9420
RBP: ffffc9000afc7920 R08: ffffffff8f84262f R09: 1ffffffff1f084c5
R10: dffffc0000000000 R11: fffffbfff1f084c6 R12: ffffea0001a41e40
R13: 0000000000000002 R14: ffffc9000afc7808 R15: ffffc9000afc7770
FS:  00007f35ceaab6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f29e7309d58 CR3: 0000000025a64000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kill_bdev block/bdev.c:79 [inline]
 set_blocksize+0x315/0x390 block/bdev.c:155
 sb_set_blocksize block/bdev.c:164 [inline]
 sb_min_blocksize+0xb3/0x190 block/bdev.c:180
 ext4_load_super fs/ext4/super.c:5030 [inline]
 __ext4_fill_super fs/ext4/super.c:5227 [inline]
 ext4_fill_super+0x6ec/0x6da0 fs/ext4/super.c:5703
 get_tree_bdev+0x3f7/0x570 fs/super.c:1619
 vfs_get_tree+0x90/0x2a0 fs/super.c:1784
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f35cdc7f4aa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f35ceaaaef8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f35ceaaaf80 RCX: 00007f35cdc7f4aa
RDX: 0000000020000100 RSI: 00000000200002c0 RDI: 00007f35ceaaaf40
RBP: 0000000020000100 R08: 00007f35ceaaaf80 R09: 0000000003000480
R10: 0000000003000480 R11: 0000000000000246 R12: 00000000200002c0
R13: 00007f35ceaaaf40 R14: 0000000000000786 R15: 00000000200000c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:truncate_inode_pages_range+0xe33/0xf70 mm/truncate.c:413
Code: 38 c1 0f 8c d5 f8 ff ff 4c 89 f7 e8 27 7f 24 00 e9 c8 f8 ff ff e8 ed b1 c5 ff 4c 89 e7 48 c7 c6 a0 8a b3 8b e8 2e 73 0a 00 90 <0f> 0b e8 96 b8 8f 09 e8 d1 b1 c5 ff 48 8b 7c 24 18 48 c7 c6 e0 8b
RSP: 0018:ffffc9000afc76c0 EFLAGS: 00010246
RAX: f4eb776fbe124800 RBX: 0000000000000001 RCX: ffffc9000afc7503
RDX: 0000000000000001 RSI: ffffffff8baac6e0 RDI: ffffffff8bfd9420
RBP: ffffc9000afc7920 R08: ffffffff8f84262f R09: 1ffffffff1f084c5
R10: dffffc0000000000 R11: fffffbfff1f084c6 R12: ffffea0001a41e40
R13: 0000000000000002 R14: ffffc9000afc7808 R15: ffffc9000afc7770
FS:  00007f35ceaab6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f29dd4ff000 CR3: 0000000025a64000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

