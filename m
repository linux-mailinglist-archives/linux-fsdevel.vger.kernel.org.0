Return-Path: <linux-fsdevel+bounces-7954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E81A082DE69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 18:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE4F281E44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 17:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8F2182BE;
	Mon, 15 Jan 2024 17:22:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA1F18035
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bf47c16020so74792339f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 09:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705339339; x=1705944139;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIMtM5cQIWfoWWtc9gO0GJqV1TeSsNtRegOy1qIgr3s=;
        b=wa0ZJhmc8GrelC9zjj26J4rRLIp2ORapEVEi8h73cUu91litBOvmHchsAP0Pq+yoZc
         G01ChDt6bLIDtnJax7GTsK9Qa9Oyzfcq+4/1FORA8Z6FTwwf5gN7Z6uil0lrkMpVFVxg
         vKqw6sRVcERXR8ZlQf8i+8a+6nI5UFj6DLsdvSgGpG5LK8zW1OZ1SFQX+ug76R89GeS7
         ENJBmV1+v8uaKpt0yR0db8Pfd1tJ4e0ytMR2+BfPWhzL/iuVx4VaXXe/mqrpaUJ4uceR
         VeRuntWAtKM77ZCr64lyYL4lcjflCqZVfRJ2wNgi48O6Skd0k3Z9PV0pG/t5ZuPy8iqT
         xvJg==
X-Gm-Message-State: AOJu0Yw/j3z7TXd+TRMM37vR9q3jTLa53KJafzU81B7J8e8o06J3Qp4f
	TQHtdHZo9y006zTnsWhHEpRQ6QQjS0G5830i4AlpPlneJQQ6
X-Google-Smtp-Source: AGHT+IH2eJRKR3KXx5475N99GDNulm6KJcgkpSdGuTwLKenANzxE7B3NCqfQrTzEQL1L9c6a3kSaSznGhcpGRTM3AIpzKofhp11F
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29bc:b0:7ba:cef9:803a with SMTP id
 u28-20020a05660229bc00b007bacef9803amr73471ios.4.1705339339502; Mon, 15 Jan
 2024 09:22:19 -0800 (PST)
Date: Mon, 15 Jan 2024 09:22:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d7a36060eff419e@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_issue_discard
From: syzbot <syzbot+4a4f1eba14eb5c3417d1@syzkaller.appspotmail.com>
To: axboe@kernel.dk, clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	kristian@klausen.dk, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3e7aeb78ab01 Merge tag 'net-next-6.8' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f61d33e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e557b1c0a57d2c0
dashboard link: https://syzkaller.appspot.com/bug?extid=4a4f1eba14eb5c3417d1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bdfc0be80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177f3c83e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4c8a9f091067/disk-3e7aeb78.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8cb663b518a5/vmlinux-3e7aeb78.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bc6d189cfcf3/bzImage-3e7aeb78.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/e37fd964ba01/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/174ce0bdbd5e/mount_4.gz

The issue was bisected to:

commit 2b9ac22b12a266eb4fec246a07b504dd4983b16b
Author: Kristian Klausen <kristian@klausen.dk>
Date:   Fri Jun 18 11:51:57 2021 +0000

    loop: Fix missing discard support when using LOOP_CONFIGURE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111924a5e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=131924a5e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=151924a5e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4a4f1eba14eb5c3417d1@syzkaller.appspotmail.com
Fixes: 2b9ac22b12a2 ("loop: Fix missing discard support when using LOOP_CONFIGURE")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5071 at fs/btrfs/extent-tree.c:1263 btrfs_issue_discard+0x5ba/0x5e0 fs/btrfs/extent-tree.c:1263
Modules linked in:
CPU: 0 PID: 5071 Comm: syz-executor384 Not tainted 6.7.0-syzkaller-04629-g3e7aeb78ab01 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:btrfs_issue_discard+0x5ba/0x5e0 fs/btrfs/extent-tree.c:1263
Code: 3c 30 00 74 08 4c 89 e7 e8 23 51 58 fe 4d 01 2c 24 31 ed 89 e8 48 83 c4 28 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 87 be fb fd 90 <0f> 0b 90 4d 01 fd 49 29 dd 49 81 e5 00 fe ff ff 49 89 df e9 74 fa
RSP: 0018:ffffc900043df640 EFLAGS: 00010293
RAX: ffffffff83933039 RBX: 0000000000504200 RCX: ffff888076528000
RDX: 0000000000000000 RSI: 0000000000504018 RDI: 0000000000504200
RBP: ffffc900043df810 R08: ffffffff83932ab8 R09: 1ffff1100516a40e
R10: dffffc0000000000 R11: ffffed100516a40f R12: ffffc900043df760
R13: 000000000018bfe8 R14: ffff88801b14b980 R15: 0000000000504018
FS:  00007f61f8a7e6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f790f99dae0 CR3: 0000000028f87000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_discard_extent fs/btrfs/extent-tree.c:1359 [inline]
 btrfs_discard_extent+0x605/0xa80 fs/btrfs/extent-tree.c:1410
 do_trimming+0x1fd/0x590 fs/btrfs/free-space-cache.c:3673
 trim_no_bitmap+0xd60/0x11d0 fs/btrfs/free-space-cache.c:3797
 btrfs_trim_block_group+0x14f/0x450 fs/btrfs/free-space-cache.c:4037
 btrfs_trim_fs+0x3c7/0x10d0 fs/btrfs/extent-tree.c:6315
 btrfs_ioctl_fitrim+0x5ad/0x610 fs/btrfs/ioctl.c:535
 btrfs_ioctl+0x12b/0xd40 fs/btrfs/ioctl.c:4583
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f61f8aef469
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f61f8a7e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000040 RCX: 00007f61f8aef469
RDX: 0000000020000080 RSI: 00000000c0185879 RDI: 0000000000000005
RBP: 00007f61f8b95710 R08: 00007f61f8b95718 R09: 00007f61f8b95718
R10: 00007f61f8a7e6c0 R11: 0000000000000246 R12: 00007f61f8b9571c
R13: 000000000000006e R14: 00007ffd9ed8dbf0 R15: 00007ffd9ed8dcd8
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

