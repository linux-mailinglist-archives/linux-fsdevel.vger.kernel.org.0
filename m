Return-Path: <linux-fsdevel+bounces-72042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D1DCDC219
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 12:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93C8530552EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BFA32E15B;
	Wed, 24 Dec 2025 11:26:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA77930E83E
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766575584; cv=none; b=AGmiWQdo5H8pWzE8u/Phwrk55ajDFQvAczI34rM3sKAnRQKb2GMLT/DETt0PaRrhoSq7k+GkXLQRckxZVMj1FrJoLdweJHRhY6v678smV0iPGEb5/TOYBdxe+57LfVAv+d2oJhkPhbkv4tSiVL9bC0tVCbqDqDNpj3Ex5EUCmIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766575584; c=relaxed/simple;
	bh=uSGwm5F+ft+0JujkGGWSKK56zcGUxNMh0mbx4C5UC8o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r/nmvNKaXetW6ZvwR595yArD0BSMpDyzEd2zhJSh6fs3AFBOivTgLB+rQ3STmMiDyAUF3OScXsHB5l5W8Sz+OXQp/Uz4ueOwrKZcUPW8h9EEgNiMakzJILTYt5o2ghRNMTKqrWLodOFwaycJ8r4FexnkFG/z7n0XMiDPNjRK3Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-656b7cf5c66so8962069eaf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 03:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766575581; x=1767180381;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vlNOjTzccLZvIPt2pll8NuIQDEXyKlVML40vK8g/2gs=;
        b=GVCrXshyImdaK6IR2DB8OnTXhHj1ggBWkavkqz1184P0eF2ijiSwBjHjv7pUSKgae7
         H/GYk4PkV3kX7cNpZkIqZSdRPRYzx8HBfd07fozMdfKVMWwpjXULJqOTJ2e3+5GdIKhv
         6gseh5Oigzli9yJg8wrDFJIuqvexth155ZHJpcNGShIcGyL/aqX6Rlaz9Lw65i84L7HC
         umqVuGfItDhhbXFIdVZcUZtHACxftRcBI9KXRxNcgdXdkwMafJfxRFWUKD3xMxvrJNhj
         6oT07nfVOnXBG/ox5RdqjAEaIGgR8d/xxt+HbMolIuNmGEJeoyP0O25Il6qpZPnf22lv
         +XMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZxVX1vhIbenKccGiFBEzbGhzqz29OAf2EARERIXpVd1zKJboeebHh6rEV1OOGWUAvHnOHlb3OdtvYIOV5@vger.kernel.org
X-Gm-Message-State: AOJu0YyhrivZNH5IbsJqdfrD5Tn60lZHWiqpM3n4urBGuyICdRMjmXiw
	l6M0GVfKdX8jb5MABzNqNoMSl1TcFdqzGV6eDw/nEn7FxppwVEiDyh+JIOPN7aKqEgOL873lGFQ
	RldG4NRkZNw/iG4sc2woggFpNu7SiOdxWBUSTAacpLfABliMe8WrzQdWq94M=
X-Google-Smtp-Source: AGHT+IGTbhbM1YMAs0I5RCoKkumj+Q8SchNKj0yDBBsMSe2bDmviE0v5N8wGcsV8boC5TSv5Tl96E9/S04MDqXyEX8ZgYAdiantl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:771a:b0:65c:f253:214f with SMTP id
 006d021491bc7-65d0e9e3b5amr5299303eaf.33.1766575581696; Wed, 24 Dec 2025
 03:26:21 -0800 (PST)
Date: Wed, 24 Dec 2025 03:26:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694bcddd.050a0220.35954c.001b.GAE@google.com>
Subject: [syzbot] [fs?] kernel BUG in socket
From: syzbot <syzbot+e956b5830b1895c9cb7b@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    92fd6e84175b Add linux-next specific files for 20251125
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17d79612580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8705ffbbff9235f
dashboard link: https://syzkaller.appspot.com/bug?extid=e956b5830b1895c9cb7b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a3c57c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130acf42580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/504ec57bbfb4/disk-92fd6e84.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/90731c1057eb/vmlinux-92fd6e84.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7066fa5b18b8/bzImage-92fd6e84.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e956b5830b1895c9cb7b@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fa38bbe5fa0 R14: 00007fa38bbe5fa0 R15: 0000000000000000
 </TASK>
VFS_BUG_ON_INODE(inode_state_read_once(inode) & I_CLEAR) encountered for inode ffff88805b5d5140
fs sockfs mode 140777 opflags 0x8 flags 0x0 state 0x300 count 0
------------[ cut here ]------------
kernel BUG at fs/inode.c:1978!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6012 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:iput+0xfc9/0x1030 fs/inode.c:1978
Code: 8b 7c 24 18 48 c7 c6 80 c0 99 8b e8 61 c1 e6 fe 90 0f 0b e8 19 7b 80 ff 48 8b 7c 24 18 48 c7 c6 20 c0 99 8b e8 48 c1 e6 fe 90 <0f> 0b 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c cd fb ff ff 4c 89 ef
RSP: 0018:ffffc90002ff7de0 EFLAGS: 00010282
RAX: 000000000000009f RBX: dffffc0000000000 RCX: 9e18d727a1916b00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffffffff1f54606 R08: ffffc90002ff7aa7 R09: 1ffff920005fef54
R10: dffffc0000000000 R11: fffff520005fef55 R12: 1ffff1100b6baa68
R13: ffff88805b5d5340 R14: 0000000000000200 R15: 1ffffffff1f7f5d4
FS:  000055556e081500(0000) GS:ffff888125b41000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ec8d3e1138 CR3: 0000000076182000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 sock_release net/socket.c:685 [inline]
 sock_map_fd net/socket.c:510 [inline]
 __sys_socket+0x2f0/0x370 net/socket.c:1762
 __do_sys_socket net/socket.c:1767 [inline]
 __se_sys_socket net/socket.c:1765 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1765
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa38b98f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe62833658 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
RAX: ffffffffffffffda RBX: 00007fa38bbe5fa0 RCX: 00007fa38b98f749
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 0000000000000004 R08: 0000000000000000 R09: 00000000000927c0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fa38bbe5fa0 R14: 00007fa38bbe5fa0 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iput+0xfc9/0x1030 fs/inode.c:1978
Code: 8b 7c 24 18 48 c7 c6 80 c0 99 8b e8 61 c1 e6 fe 90 0f 0b e8 19 7b 80 ff 48 8b 7c 24 18 48 c7 c6 20 c0 99 8b e8 48 c1 e6 fe 90 <0f> 0b 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c cd fb ff ff 4c 89 ef
RSP: 0018:ffffc90002ff7de0 EFLAGS: 00010282
RAX: 000000000000009f RBX: dffffc0000000000 RCX: 9e18d727a1916b00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffffffff1f54606 R08: ffffc90002ff7aa7 R09: 1ffff920005fef54
R10: dffffc0000000000 R11: fffff520005fef55 R12: 1ffff1100b6baa68
R13: ffff88805b5d5340 R14: 0000000000000200 R15: 1ffffffff1f7f5d4
FS:  000055556e081500(0000) GS:ffff888125b41000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ec8d3e1138 CR3: 0000000076182000 CR4: 00000000003526f0


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

