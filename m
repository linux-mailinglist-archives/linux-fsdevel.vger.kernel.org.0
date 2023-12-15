Return-Path: <linux-fsdevel+bounces-6183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A33CF814998
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 14:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB40286B03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 13:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885A52E3FE;
	Fri, 15 Dec 2023 13:49:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F4B2F85A
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35f7f48d2f6so7364705ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 05:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702648162; x=1703252962;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fcg6YeQhWzXnquq1qC1+RR7NbEHfog/+Gy6jNbdBe8=;
        b=i2OSBBnP1C+mdH1vzDi9oagKxcKnLrSE6tYhTcFFgKlriydRjiY4LoFAyze72DNlZh
         mcZoonOwx/W382zOOZ+O6Bt5GldpnRLwffqKZ47wpHDUpsvYes/L5e471xC5XwS6ibwc
         1ph3qWop8n/9CyFy5AE8GnUF1uZnKAm11JaB3XYbxbixjNhL4O0YcCy32GKKig4I1pR1
         DjSYqzRKNF+uMzFHcB4gwqB8pbWPJ/B4J55O6A2hX6gi1BzxXcZGt77QTHzfQRu9T6tl
         jbtl0L9cAi5AXv7u/hHkfDne3CjrVBXdQDpYIZ2Hvz7E2SIEUCstpacwEQM0DFKgotSv
         A6Hg==
X-Gm-Message-State: AOJu0YwlWbCZyW0g9x/MUc3miEW73m5I35UnaBoaEYHfI0tnuJYDPD11
	+eU51iz0y+UpHMBzdht73QJ6vS4XS5KpubJSqiuIblhVwXon
X-Google-Smtp-Source: AGHT+IE4vO15ZYfkyVn2/O0gwJCpcuVogA0/cGDEc5Yg252LmSHz/Dzl61AP4aoxWSetvkwcp6afVp+ysEH9Esx/3ZL3kFqe2Lq2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0b:b0:35f:98ba:ace2 with SMTP id
 i11-20020a056e021d0b00b0035f98baace2mr11741ila.4.1702648162117; Fri, 15 Dec
 2023 05:49:22 -0800 (PST)
Date: Fri, 15 Dec 2023 05:49:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e17185060c8caaad@google.com>
Subject: [syzbot] [ext4?] WARNING in lock_two_nondirectories
From: syzbot <syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a39b6ac3781d Linux 6.7-rc5
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12c3a112e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e043d554f0a5f852
dashboard link: https://syzkaller.appspot.com/bug?extid=2c4a3b922a860084cc7f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1687292ee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d8adbce80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/67fd20dff9bc/disk-a39b6ac3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/778677113ec4/vmlinux-a39b6ac3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fd69b2e7d493/bzImage-a39b6ac3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/28ab13ef564b/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1286a2b2e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1186a2b2e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1686a2b2e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com

EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5067 at fs/inode.c:1148 lock_two_nondirectories+0xca/0x100 fs/inode.c:1148
Modules linked in:
CPU: 1 PID: 5067 Comm: syz-executor207 Not tainted 6.7.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:lock_two_nondirectories+0xca/0x100 fs/inode.c:1148
Code: ff 66 41 81 fc 00 40 74 1b e8 c2 3d 92 ff 48 89 ee 48 89 df 5b 5d b9 04 00 00 00 31 d2 41 5c e9 5c fd ff ff e8 a7 3d 92 ff 90 <0f> 0b 90 eb da e8 9c 3d 92 ff 90 0f 0b 90 eb 83 48 89 df e8 5e e4
RSP: 0018:ffffc90003a4fc38 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807cf82ab0 RCX: ffffffff81f55031
RDX: ffff888078b21dc0 RSI: ffffffff81f55059 RDI: 0000000000000003
RBP: ffff88807cfe66b0 R08: 0000000000000003 R09: 0000000000004000
R10: 0000000000004000 R11: ffffffff915fc8a0 R12: 0000000000004000
R13: ffff8880298d2c80 R14: ffff88807cfe66b0 R15: ffffffff8d195740
FS:  0000555555d51380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000056e5a000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 swap_inode_boot_loader fs/ext4/ioctl.c:391 [inline]
 __ext4_ioctl+0x118d/0x4570 fs/ext4/ioctl.c:1437
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f61c40c4af9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe0eaa3fb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffe0eaa4198 RCX: 00007f61c40c4af9
RDX: 0000000000000000 RSI: 0000000000006611 RDI: 0000000000000004
RBP: 00007f61c4138610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe0eaa4188 R14: 0000000000000001 R15: 0000000000000001
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

