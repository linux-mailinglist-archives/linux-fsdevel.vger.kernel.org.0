Return-Path: <linux-fsdevel+bounces-35665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4184E9D6DFA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 11:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D950B20A87
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 10:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11B618B499;
	Sun, 24 Nov 2024 10:53:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA7F18950A
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732445606; cv=none; b=Iij8+nUc+2865mOVU+L77coAK/fUPF8onkGZNEPkz41v9py8c41el5YM4NBfQgX5FoEsawCgmpXnV/qS2GvggY9VUe+Bms4CrPvYy80klcas3d6gP8uWqHtts89nvRst3Sbn7TiK5GwFUkjwG5fUixwQy8NnwkBxAf/1IrU79tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732445606; c=relaxed/simple;
	bh=u4odtu8AJ6ObfYgY9usEUiG3XIEHqAcJENXaji4aCgI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sKTj/1E/QH97YgEjsVFCnD7heUEWv9sxtn1z5TC3k1cN1mgjHhMbphrUc/3tK6p8eszr3tb4P5pa0FOs/6GUKoJAJGoSvrzW6oRvOCFBhxiyF9O4j/dTYIa8e4elHMNQhdo8uHic+U21XLycyQTV1zd1pCvclMBVxmEc9lpN6hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7b30b03ddso887695ab.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 02:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732445604; x=1733050404;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7fFg/Ni0KiZfql037jokePcuiaJAU45KqdnhH3FOPQ=;
        b=olR06E4EqKcAh7FAjfOsjocGZhsoyFXVP7OwS8GEIgg2Sd/Mq6X4Oem7x7DGFG8JZ1
         ENkNNzCjt/Yqb99VB6Wrzr+WD6PnAlO+Qv8Za4N+YbDOw+8phcn841xsZa8R5m/eBXfX
         mqcsV+28AbRNvZFr773+1P8p3r5deGBuht022yF3vzOvphzWk50oPRZegA8oINGujwM8
         USA/A5EhTx8oHOZX/f6s3H7NZKx9motlj/d51yr3ToHB72kbJvz/mMmQpCyxjnwcQ3QN
         v9MLVRNYa6n2WPRvBmOtze04nVM0zDsxEB4p1yKcLtcjtavt8f87xxepgZS8rpi/7VQW
         gRZw==
X-Gm-Message-State: AOJu0YyBFppoTbVPgNiP1ss6Gehb9gj5W/5U28bDjJ48F4cCsHTnl8Vs
	mlDHhKQV53iIhUmjjEaioUIhFxDckFaJnShhWK/Sd2QNUFeXyiEQYI44nxXQwDMTYIYGjkZLSHf
	asTZMdOTS5EjR+bom+Vau/VpI2oNQA7BAfW3TAOMs2NrPVO95u1qw7SQ=
X-Google-Smtp-Source: AGHT+IEG+JaCd1m/gkFOoY1onehyxqlbZAkUc81MpdNrM83WGg4z6bGiH7yCl/yVE2P57vMWAVDE/Jer+NAhxTmvqsLkLsfTO5Cq
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54c:0:b0:3a7:7ee3:108d with SMTP id
 e9e14a558f8ab-3a79afd5844mr108647175ab.23.1732445603988; Sun, 24 Nov 2024
 02:53:23 -0800 (PST)
Date: Sun, 24 Nov 2024 02:53:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674305a3.050a0220.1cc393.003b.GAE@google.com>
Subject: [syzbot] [hfs?] WARNING in hfsplus_unlink
From: syzbot <syzbot+028180f480a74961919c@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bf9aa14fc523 Merge tag 'timers-core-2024-11-18' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=154e4b78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccd6152c3e2378ce
dashboard link: https://syzkaller.appspot.com/bug?extid=028180f480a74961919c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1676475f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ff46c0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f7f38a2c24fc/disk-bf9aa14f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9fe13f1c9a0f/vmlinux-bf9aa14f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/04d354ff9f6b/bzImage-bf9aa14f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/64b16595572b/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148be930580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=168be930580000
console output: https://syzkaller.appspot.com/x/log.txt?x=128be930580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+028180f480a74961919c@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5831 at fs/inode.c:407 drop_nlink+0xc4/0x110 fs/inode.c:407
Modules linked in:
CPU: 1 UID: 0 PID: 5831 Comm: syz-executor234 Not tainted 6.12.0-syzkaller-01782-gbf9aa14fc523 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:drop_nlink+0xc4/0x110 fs/inode.c:407
Code: bb 70 07 00 00 be 08 00 00 00 e8 07 df e5 ff f0 48 ff 83 70 07 00 00 5b 41 5c 41 5e 41 5f 5d c3 cc cc cc cc e8 6d f4 7e ff 90 <0f> 0b 90 eb 83 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 5c ff ff ff
RSP: 0018:ffffc9000369fbb0 EFLAGS: 00010293
RAX: ffffffff8215f523 RBX: 1ffff11004ad054f RCX: ffff88802a931e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8215f4a3 R09: 1ffff920006d3ed8
R10: dffffc0000000000 R11: fffff520006d3ed9 R12: ffff888025682a78
R13: ffff888079eef370 R14: ffff888025682a30 R15: dffffc0000000000
FS:  0000555588597380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 0000000078e92000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hfsplus_unlink+0x3fe/0x790 fs/hfsplus/dir.c:381
 vfs_unlink+0x365/0x650 fs/namei.c:4523
 do_unlinkat+0x4ae/0x830 fs/namei.c:4587
 __do_sys_unlink fs/namei.c:4635 [inline]
 __se_sys_unlink fs/namei.c:4633 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4633
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f81f72e79b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffbff4f578 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007f81f72e79b9
RDX: ffffffffffffffb8 RSI: 00007f81f72e79b9 RDI: 00000000200000c0
RBP: 00007f81f735b610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffbff4f748 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

