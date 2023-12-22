Return-Path: <linux-fsdevel+bounces-6761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B61C81C284
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 01:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7181F250ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 00:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FD34698;
	Fri, 22 Dec 2023 00:59:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6840523D0
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 00:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fd42a187bso8134815ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Dec 2023 16:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703206762; x=1703811562;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iedhThegUhBG7Hx+aDuT5wT4coaQ6Uh1CuWXvspDx3w=;
        b=J3TY3/iiFBDZ3epvyX4kt3ketAy8ZHKQWtUDWFqYJTVL0cosJ7F8bAqq6+BuQnknIk
         Y6nRahjhxaorfIkpRTSzLg68XuICfntNq+bIHfIxwdjJmzZbCH5Rv5QZI+0iIbv5lNZ4
         PRgLy5bnarOeM/OhPn7R4f6Al4E9qsbBHgE5kGoKlvFLJA5/CJS12FnleGDX+IfVMLgq
         ZjdsOjE7gr7xG1WrDUrfSWshBeqwcMWEd9BuApOvV4Peb+l4TNZ0VaEIfN2lwjHd2exz
         1CvDEZJ5R1OuaE0SVx734fRY/Xcmuu+jrZpEf7Sp9E2yJc6yiDdAChCZrTnn1WgIvgaW
         6TCA==
X-Gm-Message-State: AOJu0YxzBPKHPMcaFWyRM7e2zeOVV1Be3wWtCmRz01byD4PvT8e/qDXr
	fNw54D0Zi042S0eLFrzAZkNadgQvA8wmCKQ4WSKt3oY5wfd2zdY=
X-Google-Smtp-Source: AGHT+IFXaZWZi1mcoa1Cw0l9O+dWHkSzzT4h1TUYb5EigliJ62YTnqMYa8W16TubYdq7ucL6kQlrjr6Q32GzG6zTAbe8+RGATVZU
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6e:b0:35f:b1d1:8f1f with SMTP id
 w14-20020a056e021a6e00b0035fb1d18f1fmr65172ilv.3.1703206762586; Thu, 21 Dec
 2023 16:59:22 -0800 (PST)
Date: Thu, 21 Dec 2023 16:59:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000102bef060d0eba81@google.com>
Subject: [syzbot] [hfs?] WARNING in hfsplus_ext_write_extent (2)
From: syzbot <syzbot+03628e5994f8f09f5455@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    55cb5f43689d Merge tag 'trace-v6.7-rc6' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ee8d01e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5751b3a2226135d
dashboard link: https://syzkaller.appspot.com/bug?extid=03628e5994f8f09f5455
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ae263e8abe20/disk-55cb5f43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/69616b96179e/vmlinux-55cb5f43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7f052dde6379/bzImage-55cb5f43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+03628e5994f8f09f5455@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 1 PID: 6540 at kernel/locking/mutex.c:582 __mutex_lock_common kernel/locking/mutex.c:582 [inline]
WARNING: CPU: 1 PID: 6540 at kernel/locking/mutex.c:582 __mutex_lock+0xc36/0xd60 kernel/locking/mutex.c:747
Modules linked in:
CPU: 1 PID: 6540 Comm: kworker/u4:0 Not tainted 6.7.0-rc6-syzkaller-00022-g55cb5f43689d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: writeback wb_workfn (flush-7:4)
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:582 [inline]
RIP: 0010:__mutex_lock+0xc36/0xd60 kernel/locking/mutex.c:747
Code: 0f b6 04 20 84 c0 0f 85 18 01 00 00 83 3d 21 0c e0 03 00 75 19 90 48 c7 c7 60 90 6a 8b 48 c7 c6 00 91 6a 8b e8 1b 76 33 f6 90 <0f> 0b 90 90 90 e9 c8 f4 ff ff 90 0f 0b 90 e9 d6 f8 ff ff 90 0f 0b
RSP: 0018:ffffc90016a7f200 EFLAGS: 00010246
RAX: e1774778be1ec900 RBX: 0000000000000000 RCX: ffff888069518000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90016a7f350 R08: ffffffff81545d22 R09: 1ffff11017325172
R10: dffffc0000000000 R11: ffffed1017325173 R12: dffffc0000000000
R13: ffff8880355356a0 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b3992d6000 CR3: 0000000032017000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hfsplus_ext_write_extent+0x8e/0x1f0 fs/hfsplus/extents.c:149
 hfsplus_write_inode+0x22/0x5e0 fs/hfsplus/super.c:154
 write_inode fs/fs-writeback.c:1473 [inline]
 __writeback_single_inode+0x69b/0xfc0 fs/fs-writeback.c:1690
 writeback_sb_inodes+0x8e3/0x1220 fs/fs-writeback.c:1916
 wb_writeback+0x44d/0xc70 fs/fs-writeback.c:2092
 wb_do_writeback fs/fs-writeback.c:2239 [inline]
 wb_workfn+0x400/0xfb0 fs/fs-writeback.c:2279
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x90f/0x1420 kernel/workqueue.c:2700
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2781
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


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

