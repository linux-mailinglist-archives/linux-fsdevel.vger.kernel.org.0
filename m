Return-Path: <linux-fsdevel+bounces-11318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CDC852993
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 08:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F3F1F248C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 07:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C1A17550;
	Tue, 13 Feb 2024 07:12:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E97E14A96
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707808344; cv=none; b=KpWLBlq8hAfpseM7eZErnqpmZ2cQzboX2QVkzLIm6EKP1WdHhhD0o+BcBKSCwwoKym52zWbUvCOBVaTIZbAtKNQ49qir+w1uFN+TuZuOmrb/lErsUsXgzAlBZwbzRZmK34nmbOIeEyv9nzLQ+VwefC/t2kcUSmQXmczKJsg3kj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707808344; c=relaxed/simple;
	bh=V9tcoMLA+pIAtPZxFOQObUKdNahaHhMcZEqlltDi8+o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Pgw1FFkBDJpt6aZDPb+BwLQV4dbdX97Qv7rDBEmmhtL3kwdA+U5ihROPVwPcYw2BxtWgyKxuDiH6yWDIR9Kr+8W8JNjrHuBVQ6pP1T/mRRKUrJNnDWWeP6rApe4/FDY3t2j0oPVrJOH/AnbLuZhyK9uFRO1YGKVREtC3ArpRyAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36414a7850aso7765805ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 23:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707808342; x=1708413142;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w8h8mG5vqmwpQak6Ogh28SrPEtvDJJ+fHz5Pl5o+30I=;
        b=OROflnzRK0ZwyTGSTAOFUL7My3DG4dYkONGGMVaJ9GPN5mpD8N5AP1lB0bu/i0hoW+
         EmjDIV6GQPmyKSEe/m4OEH2htd/1ogdWHCFnUTLGRuSWRL72iBgPXF5eR6k7kEjMDWP+
         y4eJpli+cFhCZl00UZGspHPJlzsfsBdVmwmaqM0ErTPMvZfzbyM3SdDHzGf9ipKzTcxT
         X9zxgj9Yxg3w/RFXlthdsl6u0u5P1tGy1nobnrCcg6VOU3TE5Ax4YRZ4XBSZwLUUVc+O
         XeDHA8MG4su7HST0uduuXWInQFN3zIC5flWYbabYvSCtpbbVv9fLJ+5wv+aeCjadoeZb
         9VEA==
X-Forwarded-Encrypted: i=1; AJvYcCUWWzNLM68B3gOxEEgmqStwDrwCGSBeeWc5twQFybKmK0/3pCgf9m+21dhCRBXbUC9Rl71VjPHPsfoeMY76hswE5EW/7zun6L+ln/MOtw==
X-Gm-Message-State: AOJu0Yx77fHOcfJ5xVUtk/8uzyCZIFLAMTwO8rulSjRzcJ4lQnHW1nq2
	33sXWrgrrx34Vcpo6Zwq9X/NjFsNgQv8m8xjjubETXTIaVhdg1y8a5NF16nRtosnigcprpbaK9W
	JaiCVF6PESGq4+8XMdrlVQ+nAj2HOO1ufPqQSvu2xT6i5ZWt5t0mYjTo=
X-Google-Smtp-Source: AGHT+IHXqjziLQXAtVxqjKa/u5HHmP/tdUZvw98vumUI48JW4FrPrgB+8TOnYbBhiW0WHsoV1zaBHbnYhalfNSYzLo0p5v+Y4COX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d38f:0:b0:363:927b:4524 with SMTP id
 o15-20020a92d38f000000b00363927b4524mr42208ilo.3.1707808342508; Mon, 12 Feb
 2024 23:12:22 -0800 (PST)
Date: Mon, 12 Feb 2024 23:12:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000998cff06113e1d91@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state (2)
From: syzbot <syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    716f4aaa7b48 Merge tag 'vfs-6.8-rc5.fixes' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=100fd062180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d7c92dd8d5c7a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=c2ada45c23d98d646118
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fcbd48180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f6e642180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ca4bf59e5a18/disk-716f4aaa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3d7ade517e63/vmlinux-716f4aaa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e13f7054c0c1/bzImage-716f4aaa.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/00ba9c2f3dd0/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS sector size (4096) and media sector size (512).
ntfs3: loop0: ino=5, "/" ntfs_iget5
============================================
WARNING: possible recursive locking detected
6.8.0-rc4-syzkaller-00003-g716f4aaa7b48 #0 Not tainted
--------------------------------------------
syz-executor354/5071 is trying to acquire lock:
ffff888070ee0100 (&ni->ni_lock#3){+.+.}-{3:3}, at: ntfs_set_state+0x1ff/0x6c0 fs/ntfs3/fsntfs.c:947

but task is already holding lock:
ffff888070de3c00 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1141 [inline]
ffff888070de3c00 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_write_inode+0x1bc/0x1010 fs/ntfs3/frecord.c:3265

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&ni->ni_lock#3);
  lock(&ni->ni_lock#3);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz-executor354/5071:
 #0: ffff88802223a420 (sb_writers#9){.+.+}-{0:0}, at: do_sys_ftruncate+0x25c/0x390 fs/open.c:191
 #1: ffff888070de3ea0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
 #1: ffff888070de3ea0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: do_truncate+0x20c/0x310 fs/open.c:64
 #2: ffff888070de3c00 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1141 [inline]
 #2: ffff888070de3c00 (&ni->ni_lock#3){+.+.}-{3:3}, at: ni_write_inode+0x1bc/0x1010 fs/ntfs3/frecord.c:3265

stack backtrace:
CPU: 0 PID: 5071 Comm: syz-executor354 Not tainted 6.8.0-rc4-syzkaller-00003-g716f4aaa7b48 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c0/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 ntfs_set_state+0x1ff/0x6c0 fs/ntfs3/fsntfs.c:947
 ntfs_iget5+0x3f0/0x3b70 fs/ntfs3/inode.c:535
 ni_update_parent+0x943/0xdd0 fs/ntfs3/frecord.c:3218
 ni_write_inode+0xde9/0x1010 fs/ntfs3/frecord.c:3324
 ntfs_truncate fs/ntfs3/file.c:410 [inline]
 ntfs3_setattr+0x950/0xb40 fs/ntfs3/file.c:703
 notify_change+0xb9f/0xe70 fs/attr.c:499
 do_truncate+0x220/0x310 fs/open.c:66
 do_sys_ftruncate+0x2f7/0x390 fs/open.c:194
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7fd0ca446639
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff0baab678 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007fff0baab848 RCX: 00007fd0ca446639
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007fd0ca4d8610 R08: 0000000000000000 R09: 00007fff0baab848
R10: 000000000001f20a R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff0baab838 R14: 0000000000000001 R15: 0000000000000001
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

