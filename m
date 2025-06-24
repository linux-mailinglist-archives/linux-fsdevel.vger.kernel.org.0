Return-Path: <linux-fsdevel+bounces-52792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B243AE6D38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 19:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2ED816F112
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2932236F8;
	Tue, 24 Jun 2025 17:02:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D7D7DA73
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784548; cv=none; b=L+uDmo9lq+m1W5QbQn3cdN0wtQKhVELjzTdtct7UkrWsbZi9/KR4uLYf+9DsX92avIBmk7yrb6+RuakLtwj6cbC9jXILNpVk3cJETmkr1/yVaFmIVuTckcmhx0TSTgeNxLibkFGAU6U6x3cfZQ+Qy2IlZE5BAQbVJMeBqdRpvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784548; c=relaxed/simple;
	bh=rVT5B2iWZZr9OKkNpthk5FE/RUvJxgj/XBpIPkA+dVY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=I4crjkuz0EymfxN/GHY5VNE4UaWNZmF/BWWN6ka21lcLq3qSPWzjHhdyC7TbvSDqY6VbsOYs1B+/zqoc4WTehqZerG9icJ1BEhEPxWM/Q3icy8d8TthcGiI9v2JJ12uJ6YaC+hpfGddjiBw4NOwZJjl4ufoRQoDJnsJ2GAv50p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ddd90ca184so6094465ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 10:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750784546; x=1751389346;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLFH6eoxt7bnwcvodcPHkdsqctyfANQtqy/+9gnynnQ=;
        b=YSPkvVr/AnG1cbpFcxeigIyWTTDYe65nZabOYHaSqbrkCEYxdOK/4JyTuvlmZ+z5PG
         xM8rrPh4QHEkdDy6cc67qt8+oomUAXfJanOQTIDWftJ6UxU00bff8/cIRJrhgDaRpGDi
         3Vf37b2QebOq11ynfA56Rc8P495sXM2dZiJXN3fGpmTjL8QiNCs5pfFTT+KWBuffeGnV
         1ZQ/oMh/hbN2TS7yd1VA1zFoB67r9d9ffCa94/hDXnDewKPJx9ETdfo4MRwXnvbAqHKg
         YErsN6uZSx0fd3Dv4bn56culvcfFOcGkMJrYHYuo7d5X9CzC1ajcIV/7qpGhrX6cAzvx
         ZxkA==
X-Gm-Message-State: AOJu0Ywg9GNyEswGkQ/+N+r/K0Sk5zU4ZUjqRxcpgdY4wfFuWBEU635I
	4fm91qWSq+K7/f/PYsnGJefFOFFMgRnTgr3DrdyytoHoVy+1YmGrrwNwLBYBHQdeCRNzEu2dyYT
	1N9C2HZFbh1vjGmtn+FkNlwnRNSddSgu5bkbF0/6ZYQQVxG94h7EU2UM5UJUMlA==
X-Google-Smtp-Source: AGHT+IFALlkKleQrrNMPzjarn8EpBeg13EQeNdOqET3QREb0fiA0vwwaEcVn7iiFB8i08VNs4qk2heQG9gVsU6i5dFCiuESZbVvx
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b83:b0:3dd:c4ed:39c0 with SMTP id
 e9e14a558f8ab-3de38c159a7mr227556445ab.1.1750784546405; Tue, 24 Jun 2025
 10:02:26 -0700 (PDT)
Date: Tue, 24 Jun 2025 10:02:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685ada22.a00a0220.2e5631.0089.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in minix_rename
From: syzbot <syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    78f4e737a53e Merge tag 'for-6.16/dm-fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b29182580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28cc6f051378bb16
dashboard link: https://syzkaller.appspot.com/bug?extid=a65e824272c5f741247d
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1446370c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/560a423a60ad/disk-78f4e737.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9e97e18d85b9/vmlinux-78f4e737.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a147a5a27c6e/bzImage-78f4e737.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2c4c332ed1d0/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=12276b70580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6388 at fs/inode.c:417 drop_nlink+0xc5/0x110 fs/inode.c:417
Modules linked in:
CPU: 0 UID: 0 PID: 6388 Comm: syz.6.27 Not tainted 6.16.0-rc3-syzkaller-00042-g78f4e737a53e #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:drop_nlink+0xc5/0x110 fs/inode.c:417
Code: 78 07 00 00 be 08 00 00 00 e8 c7 35 e8 ff f0 48 ff 83 78 07 00 00 5b 41 5c 41 5e 41 5f 5d e9 42 01 29 09 cc e8 fc da 86 ff 90 <0f> 0b 90 eb 81 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 5b ff ff ff
RSP: 0018:ffffc900030c7a30 EFLAGS: 00010293
RAX: ffffffff82397124 RBX: ffff888055405aa8 RCX: ffff88802da29e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8f9fe1f7 R09: 1ffffffff1f3fc3e
R10: dffffc0000000000 R11: fffffbfff1f3fc3f R12: 1ffff1100aa80b5e
R13: 0000000000000000 R14: ffff888055405af0 R15: dffffc0000000000
FS:  00007fb57180a6c0(0000) GS:ffff888125c83000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb571809f98 CR3: 0000000032278000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_dec_link_count include/linux/fs.h:2634 [inline]
 minix_rename+0x3cf/0x700 fs/minix/namei.c:222
 vfs_rename+0xb99/0xec0 fs/namei.c:5137
 do_renameat2+0x878/0xc50 fs/namei.c:5286
 __do_sys_rename fs/namei.c:5333 [inline]
 __se_sys_rename fs/namei.c:5331 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5331
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb57098e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb57180a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007fb570bb6080 RCX: 00007fb57098e929
RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000200000001980
RBP: 00007fb570a10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fb570bb6080 R15: 00007fffa5abc5a8
 </TASK>


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

