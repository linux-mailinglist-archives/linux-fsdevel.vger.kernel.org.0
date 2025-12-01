Return-Path: <linux-fsdevel+bounces-70320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D958C9682D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 10:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7813A13D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 09:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A7C301034;
	Mon,  1 Dec 2025 09:58:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862E629BDA2
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583126; cv=none; b=b3H4NTcInwGfJ4M4jR09h0FJH98tLNM6/pgL5iAQwWYN6KgDusjZwmy4wHPIu72JRxT332HTKi5cNoG58EkHRma7HGYID1LjgFofOEjqpJSVXkFwGGR3vEQcf+XR7LfCefoWFv6lgasgmT4UtGEl7wOqcbEJSKlzccyTP5wrw3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583126; c=relaxed/simple;
	bh=0RCxbcwl9Y0JZEv33M90FTAzhBMtHAKiDKJ3SwdGe7Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o3u0cNt8jTMUr8sivC62Yh4btV7HIAiVLh76Kb4kq685yDZLwcAMaa0FJ4wDbzJIh48krqpQ7gzpsJvY7R28ERNpjjgeYaCwW6s61acrNy7NPjhHusLCS8catUi6s2KEUCUpdHhDudY1SYinVAdeXBAXdLgUmIZNxDXqrTjkbHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-948fbd0745fso244451439f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 01:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583123; x=1765187923;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rajF7Cy0iF1vJ1irYG2Bw1wOONtZpKI4LMDghDA5zGk=;
        b=AyHBmF7hGvptTcfT4cRNrBlpCgbHHX6aVZekq7ZB308VVaJgNVUCGW3vs/7+cVFxXY
         tSukqe/3z4K3N5Qs92R7iGR8OkPHU8tqCV18i41KAacDNUObgaAFkK6wpsAzp1L4RRv1
         bbJPnuT/Eetuw4T+m87eZTOaOBsML8VAGiHzIZEU90Kh3lQ1YG0Gk44pRzvBBtVQSVYP
         QfDblHGZssLacnD+LcO89m7p11OBFRRfyrDJpt7fFltLOrHDlTSraejLccY3h+08U+Fw
         TirscG/c0a/NVmHgk+ny+NHSKYhq+imc4VD7HMi3CPMRbwvHJe5JB1KWgtkX7QhG1Bhf
         Uf1A==
X-Forwarded-Encrypted: i=1; AJvYcCUcwwIRiCVe/OWVPU7w4fSI/YoygZwu6CHb/OH6yhK9KJtVTBQ3ZBUL0+NIXUoSdbUoSrqWWn02cezBmFDb@vger.kernel.org
X-Gm-Message-State: AOJu0YxCG/Un24s2OdjXIehfPrD4OIH4YMSDR7gJ0UwOx1FPfbnwlBgA
	XCPqwWluPDXMUHSLQpU0enHkjUZiWSYBIKyoURMZZ5EBysD28tuy7xsLVXC8kZvkCkX0cbnBVyx
	ZkwFL69YC3CUDvkM/8w5QtKdLL4GIL/qItiEVsEWSytLFaS6dq63UE1jKOic=
X-Google-Smtp-Source: AGHT+IF0QQrMMyFfjY633Y1IgTfqhFyVa/9zRmIWMNVyeZIwplZF0KYr4bzBy3qjs/I+T78TDmZfhAuWxy+M3atkCzFa+ErLJN5y
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d83:b0:945:ac8e:fcb9 with SMTP id
 ca18e2360f4ac-949778e8a14mr1971000739f.17.1764583123686; Mon, 01 Dec 2025
 01:58:43 -0800 (PST)
Date: Mon, 01 Dec 2025 01:58:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692d66d3.a70a0220.2ea503.00b2.GAE@google.com>
Subject: [syzbot] [fs?] kernel BUG in sctp_getsockopt_peeloff_common
From: syzbot <syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7d31f578f323 Add linux-next specific files for 20251128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=156402b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6336d8e94a7c517d
dashboard link: https://syzkaller.appspot.com/bug?extid=984a5c208d87765b2ee7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a2322c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a3c512580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b49d8ad90de/disk-7d31f578.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dbe2d4988ca7/vmlinux-7d31f578.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc0448ab2411/bzImage-7d31f578.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com

R10: 0000200000000340 R11: 0000000000000246 R12: 0000000000000002
R13: 00007f49009e5fa0 R14: 00007f49009e5fa0 R15: 0000000000000005
 </TASK>
VFS_BUG_ON_INODE(inode_state_read_once(inode) & I_CLEAR) encountered for inode ffff88805d116e00
fs sockfs mode 140777 opflags 0xc flags 0x0 state 0x300 count 0
------------[ cut here ]------------
kernel BUG at fs/inode.c:1971!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 5997 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:iput+0xfc9/0x1030 fs/inode.c:1971
Code: 8b 7c 24 18 48 c7 c6 e0 f2 79 8b e8 51 f8 e6 fe 90 0f 0b e8 a9 6f 80 ff 48 8b 7c 24 18 48 c7 c6 80 f2 79 8b e8 38 f8 e6 fe 90 <0f> 0b 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c cd fb ff ff 4c 89 ef
RSP: 0018:ffffc90003987b18 EFLAGS: 00010282
RAX: 000000000000009f RBX: dffffc0000000000 RCX: e99d72d115a78d00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffffffff1ed7c72 R08: ffffc900039877c7 R09: 1ffff92000730ef8
R10: dffffc0000000000 R11: fffff52000730ef9 R12: 1ffff1100ba22e00
R13: ffff88805d117000 R14: 0000000000000200 R15: 1ffffffff1f02c74
FS:  000055557d588500(0000) GS:ffff888125e4f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000200 CR3: 0000000074b6e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 sctp_getsockopt_peeloff_common+0x6b7/0x8a0 net/sctp/socket.c:5733
 sctp_getsockopt_peeloff_flags+0x102/0x140 net/sctp/socket.c:5779
 sctp_getsockopt+0x3a5/0xb90 net/sctp/socket.c:8111
 do_sock_getsockopt+0x2b4/0x3d0 net/socket.c:2389
 __sys_getsockopt net/socket.c:2418 [inline]
 __do_sys_getsockopt net/socket.c:2425 [inline]
 __se_sys_getsockopt net/socket.c:2422 [inline]
 __x64_sys_getsockopt+0x1a5/0x250 net/socket.c:2422
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f490078f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed38d1688 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 00007f49009e5fa0 RCX: 00007f490078f749
RDX: 000000000000007a RSI: 0000000000000084 RDI: 0000000000000003
RBP: 00007ffed38d16e0 R08: 0000200000000040 R09: 0000000000000000
R10: 0000200000000340 R11: 0000000000000246 R12: 0000000000000002
R13: 00007f49009e5fa0 R14: 00007f49009e5fa0 R15: 0000000000000005
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iput+0xfc9/0x1030 fs/inode.c:1971
Code: 8b 7c 24 18 48 c7 c6 e0 f2 79 8b e8 51 f8 e6 fe 90 0f 0b e8 a9 6f 80 ff 48 8b 7c 24 18 48 c7 c6 80 f2 79 8b e8 38 f8 e6 fe 90 <0f> 0b 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c cd fb ff ff 4c 89 ef
RSP: 0018:ffffc90003987b18 EFLAGS: 00010282
RAX: 000000000000009f RBX: dffffc0000000000 RCX: e99d72d115a78d00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffffffff1ed7c72 R08: ffffc900039877c7 R09: 1ffff92000730ef8
R10: dffffc0000000000 R11: fffff52000730ef9 R12: 1ffff1100ba22e00
R13: ffff88805d117000 R14: 0000000000000200 R15: 1ffffffff1f02c74
FS:  000055557d588500(0000) GS:ffff888125e4f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000200 CR3: 0000000074b6e000 CR4: 00000000003526f0


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

