Return-Path: <linux-fsdevel+bounces-10139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EED84846D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 08:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2E17B2A228
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 07:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1E44F203;
	Sat,  3 Feb 2024 07:57:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B154EB2F
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Feb 2024 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706947051; cv=none; b=j6Otoedp+EDCe9IDy3lMOWLI1V5Unh2F4vSoUOc5KGCNn4h43iG7roAKQaxlXXEJUlAv0Lkx2vCBDx6P9WDZo+cE2h+jhYpea9FSn0MScMT8e7UCVD/+KsoI9HplzqSgSAkpK02DvR4Us2AaAvFXvCWnibcxTr/uFq1wGCYnUxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706947051; c=relaxed/simple;
	bh=hroIZKqVyIMMeicPNrsjwRZRLDKnJZ+qliuelIcNzX8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AOkS3sYdCQ0IwT3ztSt5mdl+8WRDMHal84DoADjkIO+uG1FlG3EKSO73AuLo0rS3I7geiBLcAXjrqbNleXz6j/EQgUnj0LvlOr1l7kwNoMwDPiq3+hZjbCDLQdkfkFbGWwXM2L6F/6bSV/uXsAjJzZ6InHJ66c0/mAjJaY6ypnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363bc4a8d38so2894915ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 23:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706947049; x=1707551849;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6nBQdvx1rkzyJkyFMyp4g5RXHBqZrOZM6xaBekHJyg=;
        b=aXsnkZkYqlFQwh6LWVcj4nRWy/tN3WfrEh5YzD5fzI5vRGIQfuDUqAcGJDyJ7dFdxh
         U2CT02RMdEgTIR3zMnhYmXmKCrTFrQdAkc+380FxQRKzBHzmSBdH6Z14lDup4sLL2Otm
         6QPXTGS0rX6juQqMbL3lxfKfU5dmDabBWO1Rd7U1IpxH9LjMLquoUlNS/caoi9OyQzL6
         wU9PlW+h+fcPmObgq7RUvXC6cSSncA/nKpl6eVoPrZPdAIfXzj4mrf3vVCZ3NDX0BSya
         aAeEhr0x86nn22eq93/wH9xtV7Lj1WqIJuNOcsRjoFq57ATWQyZjpwJgr6nKE2NKU5/i
         /FoA==
X-Gm-Message-State: AOJu0YyoJXK/ojxH0HDwul5cdilDHKHcKoctx2Rsp2o1ASQC7Z0BIIeh
	GYUMosCU+A3lZdt3B1pirgLra1CTVTZkLq7PzZpxcfmIwbGbVbFLHxNHod0Emp5rjnx3vjD7G5J
	aWqwP5oPja13XXlrrAYDTDtytbgKiaNLoNnEyQEj+Z7sIlkNxnw52YDM=
X-Google-Smtp-Source: AGHT+IG/81Ib99PMqzWj59NX8R5GBRq+ruAXmTaGG3acfiU4b7NcBEN+QysElG0EOQfr9Nm6d4BCDOAeXQO0Gg4iZUOcX7L6/ojv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4c:b0:363:812d:d6a5 with SMTP id
 u12-20020a056e021a4c00b00363812dd6a5mr301584ilv.0.1706947049138; Fri, 02 Feb
 2024 23:57:29 -0800 (PST)
Date: Fri, 02 Feb 2024 23:57:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083b24f0610759407@google.com>
Subject: [syzbot] [netfs?] kernel BUG in __fscache_relinquish_cookie (2)
From: syzbot <syzbot+ccef0a87d907980eed03@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    596764183be8 Add linux-next specific files for 20240129
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1571092fe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=584144ad19f381aa
dashboard link: https://syzkaller.appspot.com/bug?extid=ccef0a87d907980eed03
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b647c038857b/disk-59676418.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/729e26c3ac55/vmlinux-59676418.xz
kernel image: https://storage.googleapis.com/syzbot-assets/15aa5e287059/bzImage-59676418.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ccef0a87d907980eed03@syzkaller.appspotmail.com

netfs: 
netfs: Assertion failed
netfs: ffffffffadacafae == 0 is false
------------[ cut here ]------------
kernel BUG at fs/netfs/fscache_cookie.c:985!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 22343 Comm: syz-executor.0 Not tainted 6.8.0-rc1-next-20240129-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:__fscache_relinquish_cookie+0x4e8/0x620 fs/netfs/fscache_cookie.c:985
Code: e8 83 e0 07 83 c0 03 38 d0 7c 0c 84 d2 74 08 48 89 ef e8 cb d4 b8 ff 48 63 73 04 31 d2 48 c7 c7 c0 a2 22 8b e8 b9 29 40 ff 90 <0f> 0b e8 c1 51 5e ff 48 c7 c7 40 a2 22 8b e8 a5 29 40 ff 48 c7 c7
RSP: 0018:ffffc90014417b00 EFLAGS: 00010282
RAX: 0000000000000025 RBX: ffff88823bd40ee8 RCX: ffffc9000cded000
RDX: 0000000000000000 RSI: ffffffff816eb7e6 RDI: 0000000000000005
RBP: ffff88823bd40eec R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: fffffffffffc94f8 R12: ffff88823bd40fd8
R13: 00000000adacafae R14: 000000000003c0cc R15: ffff8880750f29c0
FS:  00007f4f507ef6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f41889747a0 CR3: 000000007c79e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fscache_relinquish_cookie include/linux/fscache.h:308 [inline]
 v9fs_evict_inode+0x102/0x150 fs/9p/vfs_inode.c:356
 evict+0x2ed/0x6c0 fs/inode.c:666
 iput_final fs/inode.c:1740 [inline]
 iput.part.0+0x573/0x7c0 fs/inode.c:1766
 iput+0x5c/0x80 fs/inode.c:1756
 v9fs_fid_iget_dotl+0x1b4/0x260 fs/9p/vfs_inode_dotl.c:96
 v9fs_get_inode_from_fid fs/9p/v9fs.h:230 [inline]
 v9fs_mount+0x515/0xa90 fs/9p/vfs_super.c:142
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1784
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f4f4fa7cda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4f507ef0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f4f4fbabf80 RCX: 00007f4f4fa7cda9
RDX: 0000000020000140 RSI: 0000000020000400 RDI: 0000000000000000
RBP: 00007f4f4fac947a R08: 00000000200007c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f4f4fbabf80 R15: 00007ffd6430a4a8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__fscache_relinquish_cookie+0x4e8/0x620 fs/netfs/fscache_cookie.c:985
Code: e8 83 e0 07 83 c0 03 38 d0 7c 0c 84 d2 74 08 48 89 ef e8 cb d4 b8 ff 48 63 73 04 31 d2 48 c7 c7 c0 a2 22 8b e8 b9 29 40 ff 90 <0f> 0b e8 c1 51 5e ff 48 c7 c7 40 a2 22 8b e8 a5 29 40 ff 48 c7 c7
RSP: 0018:ffffc90014417b00 EFLAGS: 00010282
RAX: 0000000000000025 RBX: ffff88823bd40ee8 RCX: ffffc9000cded000
RDX: 0000000000000000 RSI: ffffffff816eb7e6 RDI: 0000000000000005
RBP: ffff88823bd40eec R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: fffffffffffc94f8 R12: ffff88823bd40fd8
R13: 00000000adacafae R14: 000000000003c0cc R15: ffff8880750f29c0
FS:  00007f4f507ef6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efe021a8000 CR3: 000000007c79e000 CR4: 00000000003506f0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

