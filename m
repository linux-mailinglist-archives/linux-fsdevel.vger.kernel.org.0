Return-Path: <linux-fsdevel+bounces-11821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 489118575B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 06:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677BC1C2261B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 05:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C73134B6;
	Fri, 16 Feb 2024 05:45:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE934125DB
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708062328; cv=none; b=oDD/vSFKqJJUrQmKQckpKgqESLRZ2v7gpFevKCwJvEXgKq9X4hXF7NwO4zfAM+EIbE/+enXoU2snckZdUSlcVNDvIUJLYhVctQLi7jCyD3TB2kAtO6EMD4NWLg0eRvpdEgxuzY60lwSV/8HBABJWZA/h8quF281xh2t9yvdTLZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708062328; c=relaxed/simple;
	bh=NXeerdPnSdjRJMAOoy0b+p1owK1ag5JZVRlrO+XLnFM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QE5K4pkW6Giky1k1jsumXAehS/oMZ+WuRV2x6tQf9W8h8xjGL9qBo2/ZreazBoAocxIOMIsm5NpOALekZJvRE5HGZDuSuydFVq5Q7SEYpsz7IkOd/1EuA3vooNbHxn+7esFVmqmC2l/8qnXWrZ3QV0Er1dO4pIV8bVarFBmT+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3610073a306so13248965ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 21:45:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708062326; x=1708667126;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VbMnwxI0bsWGHkIgRlCRYPURp0x7Da8PjZhkcBzxrIk=;
        b=HEVEEQ1e/w0sgkD0lMOtl8QIaKAl3Zx2cOnEl6s9wT0pfn4lI8Gn6LkYnqwVVHFGqO
         wyKqB/Fcw+zslNSvVTd1AzOnoJnoiZV0ehMVNkefv/M0RHHH/mTy9j2ObggHOhOvmiWN
         hc/dwnYwd0RJq0PcqCpuAsVGlrTwOn/HF62Gt+4AHf6vXYCel1R1h25HnI1Vg4Mxvtvt
         YG+g8d/VfO6nfsizjRMkibVDutEdqGdLRmD4GDBlAaA3MmbTyOiTnDwntMFk7MPc4duV
         JD76vrRFmV8Dy3gXU8imyhdbM3+heDHZQHBqPgfmsbr7jLn84yQyIrVN9wzBbPKDFfIb
         Zrkg==
X-Forwarded-Encrypted: i=1; AJvYcCWm/uqzRwBp3cCMkoU6rTeE0ojgSko2HroFyU/wY8fPjr5nSy4kVP6eerIpI7tnP+crB+wQFeBg4r4j8pR+9J4S7rbdmCOPnu8Mj0vFIA==
X-Gm-Message-State: AOJu0YzRBWEwJyoTMUhcKDHaZFA9iz8xxb04xgRxY/+Zl3S8h6zWUygY
	aB3iNkEydfLKwSxaVn7x/x+GVtyjupCK0z94+xmd+ue6lvxSLssfRDyg8DevqT/DjTsUEWx9QCG
	Kz6QFgWSelg2/QYFc7hHHKVJ31rtB2OlaETl1nUNl0oYW36wUGgiIU+8=
X-Google-Smtp-Source: AGHT+IFIgJMUnbYJEWOTsYZF3gO/ldOeMCK6h12ZamDBIKLbO7DV8UZZBZVadxEdTzG74omaDR4Db2ukCOqPK+8WytHVbozM3OBZ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c8:b0:363:c919:eec7 with SMTP id
 i8-20020a056e0212c800b00363c919eec7mr339653ilm.6.1708062326068; Thu, 15 Feb
 2024 21:45:26 -0800 (PST)
Date: Thu, 15 Feb 2024 21:45:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000331e0906117940f9@google.com>
Subject: [syzbot] [mm?] WARNING in move_pages
From: syzbot <syzbot+06ae923a4359a62d0bac@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axelrasmussen@google.com, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lokeshgidra@google.com, peterx@redhat.com, 
	rppt@kernel.org, syzkaller-bugs@googlegroups.com, usama.anjum@collabora.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ae00c445390b Add linux-next specific files for 20240212
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=126cddf4180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4eb3a27eddb32a14
dashboard link: https://syzkaller.appspot.com/bug?extid=06ae923a4359a62d0bac
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16aa2720180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1437d320180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b2a2d0b511f/disk-ae00c445.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a668a09c9d03/vmlinux-ae00c445.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4ad623928692/bzImage-ae00c445.xz

The issue was bisected to:

commit 31d97016c80a83daa4c938014c81282810a14773
Author: Lokesh Gidra <lokeshgidra@google.com>
Date:   Thu Feb 8 21:22:04 2024 +0000

    userfaultfd: use per-vma locks in userfaultfd operations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170b3442180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=148b3442180000
console output: https://syzkaller.appspot.com/x/log.txt?x=108b3442180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+06ae923a4359a62d0bac@syzkaller.appspotmail.com
Fixes: 31d97016c80a ("userfaultfd: use per-vma locks in userfaultfd operations")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5065 at mm/userfaultfd.c:1706 move_pages+0x438/0xff0 mm/userfaultfd.c:1706
Modules linked in:
CPU: 0 PID: 5065 Comm: syz-executor296 Not tainted 6.8.0-rc4-next-20240212-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:move_pages+0x438/0xff0 mm/userfaultfd.c:1706
Code: 0b 90 e9 d2 fe ff ff 90 0f 0b 90 31 ff 4c 89 e6 e8 6d 72 90 ff 4d 85 e4 74 2b e8 83 6d 90 ff e9 ba fd ff ff e8 79 6d 90 ff 90 <0f> 0b 90 45 31 e4 e9 a9 fd ff ff e8 68 6d 90 ff 45 31 e4 45 31 ff
RSP: 0018:ffffc9000345f640 EFLAGS: 00010293
RAX: ffffffff82036f37 RBX: 1ffff9200068bedc RCX: ffff88801fc41e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000345f770 R08: ffffffff82036e0e R09: 1ffffffff1f0cfa5
R10: dffffc0000000000 R11: fffffbfff1f0cfa6 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88801ec54188 R15: 0000000000000000
FS:  0000555556d1f380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000001fd14000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 userfaultfd_move fs/userfaultfd.c:2008 [inline]
 userfaultfd_ioctl+0x5c10/0x72c0 fs/userfaultfd.c:2126
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:857
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fe1b68902e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe594e4008 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffe594e41d8 RCX: 00007fe1b68902e9
RDX: 0000000020000000 RSI: 00000000c028aa05 RDI: 0000000000000003
RBP: 00007fe1b6903610 R08: 00007ffe594e41d8 R09: 00007ffe594e41d8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe594e41c8 R14: 0000000000000001 R15: 0000000000000001
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

