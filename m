Return-Path: <linux-fsdevel+bounces-42178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 984A3A3DFB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 17:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D223B4B31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A301FF1DC;
	Thu, 20 Feb 2025 16:00:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06981FECA3
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067227; cv=none; b=hUxRDdaCyab6AXkIvbZUnu97NyJSwRaf6E53UeIw3+1LmL3biDgvijqqc+h5zFWjJLPWI4FBQMXR4EscvInsvp/btBOzs1nPYsEx4bY+2vXnzLCuuTf7nfMBqeg0+pN3OipZkOQu+KaxAqv3MFGVVVBaAddbvAEvyDGotc9W6Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067227; c=relaxed/simple;
	bh=YxQajyH+IN9SN8lh/zKBA+mhYBVHiFlPZXI6BhyiMxU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G+Li9Xq8rJyeo47p8o1K2uVhbzJvBFFnfaI7qg4W/sb1bfbunDvWlgds79Biz/YC/kkLf4Jm/rT5Qq7Xb8ZC4HrvWN179ZsctI2Z1i2pQXxc6cncXXysObaMwnMyJ+8NamnfyvLmpViGP0MYzebk2iFVB3p/42D4zSyOrCJoUF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d2b3882febso6478645ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 08:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740067225; x=1740672025;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uCQNcIKHaZp9R0+muKHEhzMyApNHh6tu+d5HdAXMj6s=;
        b=ajTGYS7yunOOxsJYZwJJldqGXLIWSfL9HlYzXw1CoObqHCzvg6gZK79S/z+KnhX9z4
         wigg9h7RvVrDK/bkK7sE8nFkV12GAmXuWG0SPi/Ab1fYSF5BbtzhiIAXeO6exuazODp6
         WQ/mW+5J4FEKgKa9x8WUWHQPPUpmwq31WGDs9knfCKgzSfyEvfsxgQ88tPbXp6HseqzU
         IZPNT0MQbHJ6mFhssAH5RBWf6nG1E/cto27ouH/Nykhc59WhkI5yqsrzmGCOOlX68QG4
         XOU8ved1edIK0Njqp2HL5tO1EPKTo0In2pKRJK8Zta53kdUMRSjszlIL9JFMK3Q1q9Gc
         680A==
X-Forwarded-Encrypted: i=1; AJvYcCUv1INHQ8iGc4vdZRVwGtn7bhGiyShsjWXSAhMhk/RMvSFJJXsE+HeKjKgOA97Fy77JAxlQa5GqS+kQBS9D@vger.kernel.org
X-Gm-Message-State: AOJu0YxV4/cKl1MN7rdDq1S6ZK+eQXEfbWkly6WNIf3oRkEJQOrzx/QM
	56mSr6bjYtuaCWzS7Z/at81O+C1iNW7bCrUffwnC+2qZkjpORYrd2VDa02wr2g+moc4uYDZ6suk
	cnbymoTgafYt6e6/NCQ+70jm6GutQUfP7mrGcn0SLaooUAA2j9QF7PJ0=
X-Google-Smtp-Source: AGHT+IH5QN70LqIk9UbBfYPN8ydbtw9LdvO4dGiI/PvEXs64CCRDaYvzTRZSGWgK9cHRhV3eye6Zrz0/wYClGduI2Kd+mg5m3FgI
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:461a:b0:3d2:b295:6653 with SMTP id
 e9e14a558f8ab-3d2b29567cemr73962215ab.13.1740067224347; Thu, 20 Feb 2025
 08:00:24 -0800 (PST)
Date: Thu, 20 Feb 2025 08:00:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b75198.050a0220.14d86d.02e2.GAE@google.com>
Subject: [syzbot] [netfs?] kernel BUG in folio_unlock (3)
From: syzbot <syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6537cfb395f3 Merge tag 'sound-6.14-rc4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12af2fdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4f6914bcba459be
dashboard link: https://syzkaller.appspot.com/bug?extid=c0dc46208750f063d0e0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165827f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141b4ba4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-6537cfb3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c6f2faba4c42/vmlinux-6537cfb3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16fc32b66fc0/bzImage-6537cfb3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com

 __vm_munmap+0x19b/0x390 mm/vma.c:2951
 __do_sys_munmap mm/mmap.c:1084 [inline]
 __se_sys_munmap mm/mmap.c:1081 [inline]
 __x64_sys_munmap+0x59/0x80 mm/mmap.c:1081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
------------[ cut here ]------------
kernel BUG at mm/filemap.c:1499!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 5937 Comm: syz-executor137 Not tainted 6.14.0-rc3-syzkaller-00060-g6537cfb395f3 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:folio_unlock mm/filemap.c:1499 [inline]
RIP: 0010:folio_unlock+0xb3/0xd0 mm/filemap.c:1494
Code: f3 68 ca ff 48 89 ef 31 f6 e8 e9 ed ff ff 5b 5d e9 e2 68 ca ff e8 dd 68 ca ff 48 c7 c6 00 8a 78 8b 48 89 ef e8 de c9 11 00 90 <0f> 0b 48 89 df e8 d3 83 2d 00 e9 7b ff ff ff 66 66 2e 0f 1f 84 00
RSP: 0018:ffffc9000359f988 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9000359f830
RDX: ffff888027d14880 RSI: ffffffff81ef7612 RDI: ffff888027d14cc4
RBP: ffffea0000dfa680 R08: 0000000000000000 R09: fffffbfff20c49e2
R10: ffffffff90624f17 R11: 0000000000000003 R12: ffff888035b30890
R13: ffff888035b30bb0 R14: ffffea0000dfa680 R15: ffffc9000359fde8
FS:  0000555555b9a380(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5e877c6264 CR3: 0000000031914000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_perform_write+0xc04/0x2140 fs/netfs/buffered_write.c:400
 netfs_buffered_write_iter_locked fs/netfs/buffered_write.c:445 [inline]
 netfs_file_write_iter+0x494/0x550 fs/netfs/buffered_write.c:484
 v9fs_file_write_iter+0x9b/0x100 fs/9p/vfs_file.c:407
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5e87770829
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd7fd729d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffd7fd729f0 RCX: 00007f5e87770829
RDX: 000000000000000a RSI: 0000400000000080 RDI: 0000000000000004
RBP: 0000000000000001 R08: 00007ffd7fd72777 R09: 00000000000000a0
R10: 0000000000000001 R11: 0000000000000246 R12: 00007ffd7fd729ec
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_unlock mm/filemap.c:1499 [inline]
RIP: 0010:folio_unlock+0xb3/0xd0 mm/filemap.c:1494
Code: f3 68 ca ff 48 89 ef 31 f6 e8 e9 ed ff ff 5b 5d e9 e2 68 ca ff e8 dd 68 ca ff 48 c7 c6 00 8a 78 8b 48 89 ef e8 de c9 11 00 90 <0f> 0b 48 89 df e8 d3 83 2d 00 e9 7b ff ff ff 66 66 2e 0f 1f 84 00
RSP: 0018:ffffc9000359f988 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9000359f830
RDX: ffff888027d14880 RSI: ffffffff81ef7612 RDI: ffff888027d14cc4
RBP: ffffea0000dfa680 R08: 0000000000000000 R09: fffffbfff20c49e2
R10: ffffffff90624f17 R11: 0000000000000003 R12: ffff888035b30890
R13: ffff888035b30bb0 R14: ffffea0000dfa680 R15: ffffc9000359fde8
FS:  0000555555b9a380(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005595a83ba0f8 CR3: 0000000031914000 CR4: 0000000000352ef0
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

