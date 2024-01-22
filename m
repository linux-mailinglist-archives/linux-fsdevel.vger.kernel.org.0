Return-Path: <linux-fsdevel+bounces-8407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48906835FB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 11:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1431C25CC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 10:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48733A1C0;
	Mon, 22 Jan 2024 10:30:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B483A1A6
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919426; cv=none; b=WXNRwpxkqYQe4YTJnAsOHlJ0trdvUkRJfUfGH6fIWuz9hQBxIBKe5yBr6rHtr3tvNPWOf/ZSWvv57Itf5pOGoa3LD2251uYPKeV3CvR2bLWIsgpd3e/cNEeS3P0FS4Bx9VdpOd5QWXkPEwAGUS/4bqyQTt91jLyVOGm3v/MI/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919426; c=relaxed/simple;
	bh=sjhtYo0uTKJDjV64i8Uij6oqjEcJm5KTACoZq53pVOQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s+AA3gqLXqU5i3ft80RNy/nnZ5sdg3nM7m2QcxKSOU/d8I8nd5cqrvByvDjxFAJma2IKYiqxKgWoQ1eY7Qk4OL/ctB2YYMcp+w3mJH9R4HRVPUE0pfTyE86NdO57N+1siIMkPkWrIrc/pzYUCtKpAgGXiDOosoR1FYDNgZu94xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bf2a5cd631so418505239f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 02:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705919424; x=1706524224;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FdEqyXOm54eQOBsxXTV0kXHce7OoLUwfV8tUD0Ci2E=;
        b=WLMORL9pypKkvFTtGsG2rGqM+5mYt9hNrIc+lA8xT+nlLZUnu8lbsuJj6E8uRt0b6B
         abMS+0dtQ4pjmR2yFck4GUvj0XZIkUOO2heZ6XDuJvUQCqLsDgXWmddEi6Y8dM7I/HnJ
         a3TIbc8zCk8mKErRF/t/zSQuGqfwWgIKkmOnl6miiLXa1bVpFpTQfy1RGRCKIjnWF82t
         PZjB0E4RE3CWXeR6Z5tGnHRR9ts870dmVWA1Di1YVQ18caZioC9NpeqzXpUyCUIcQsJX
         +wAwHBZyh1ERyF1s3ZR3dOYsRQ4MQJItnFvyCGG6MZqyKh0KHq4RnGo3KOwqsU0OcHM6
         34Nw==
X-Gm-Message-State: AOJu0YyH5bcUmz9pWga4ASnq+ksSvFwvm+d7l0efAw5Gv6NJHXgLjI2C
	fzm1Juno2EmyfPBuRTFiHdhLQPilsahwZhLpDIq9e/5sTKzQP5XdXyabhxb/B8zO0ntCuGZ8K1X
	0L69AN3TXO705Yuf12fN/NnfegqEGWza9HumGroK22KxLbY3b0bTGEl7VZQ==
X-Google-Smtp-Source: AGHT+IGJNaMG4cdhwWkiWJx3xn1C6qSB5FShAtMCbV7fb/WyB3LPFECQOmel16t7a/V2qP5q2Zdnk9MzrJdRh7mCVStlfeEwDFBR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be8:b0:35f:a338:44ae with SMTP id
 y8-20020a056e021be800b0035fa33844aemr510512ilv.3.1705919424054; Mon, 22 Jan
 2024 02:30:24 -0800 (PST)
Date: Mon, 22 Jan 2024 02:30:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000494dd8060f865121@google.com>
Subject: [syzbot] [reiserfs?] possible deadlock in vfs_removexattr (2)
From: syzbot <syzbot+7ecfa4360b4449cf2a01@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0802e17d9aca Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10379b1be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9616b7e180577ba
dashboard link: https://syzkaller.appspot.com/bug?extid=7ecfa4360b4449cf2a01
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e84e45f27a78/disk-0802e17d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a8b16d2fc3b1/vmlinux-0802e17d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c7ac36b3de1/Image-0802e17d.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7ecfa4360b4449cf2a01@syzkaller.appspotmail.com

REISERFS (device loop1): Created .reiserfs_priv - reserved for xattr storage.
======================================================
WARNING: possible circular locking dependency detected
6.7.0-rc8-syzkaller-g0802e17d9aca #0 Not tainted
------------------------------------------------------
syz-executor.1/16589 is trying to acquire lock:
ffff00012c9b82e0 (&type->i_mutex_dir_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
ffff00012c9b82e0 (&type->i_mutex_dir_key#15){+.+.}-{3:3}, at: vfs_removexattr+0xcc/0x23c fs/xattr.c:575

but task is already holding lock:
ffff0000ce5fe418 (sb_writers#28){.+.+}-{0:0}, at: mnt_want_write+0x44/0x9c fs/namespace.c:404

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_writers#28){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1635 [inline]
       sb_start_write+0x60/0x2ec include/linux/fs.h:1710
       mnt_want_write_file+0x64/0x1e8 fs/namespace.c:448
       reiserfs_ioctl+0x188/0x42c fs/reiserfs/ioctl.c:103
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:871 [inline]
       __se_sys_ioctl fs/ioctl.c:857 [inline]
       __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
       __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
       el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

-> #1 (&sbi->lock){+.+.}-{3:3}:
       __mutex_lock_common+0x190/0x21a0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
       reiserfs_write_lock+0x7c/0xe8 fs/reiserfs/lock.c:27
       reiserfs_lookup+0x128/0x45c fs/reiserfs/namei.c:364
       __lookup_slow+0x250/0x374 fs/namei.c:1694
       lookup_one_len+0x178/0x28c fs/namei.c:2746
       reiserfs_lookup_privroot+0x8c/0x184 fs/reiserfs/xattr.c:977
       reiserfs_fill_super+0x15b4/0x2028 fs/reiserfs/super.c:2192
       mount_bdev+0x1e8/0x2b4 fs/super.c:1650
       get_super_block+0x44/0x58 fs/reiserfs/super.c:2601
       legacy_get_tree+0xd4/0x16c fs/fs_context.c:662
       vfs_get_tree+0x90/0x288 fs/super.c:1771
       do_new_mount+0x25c/0x8c8 fs/namespace.c:3337
       path_mount+0x590/0xe04 fs/namespace.c:3664
       do_mount fs/namespace.c:3677 [inline]
       __do_sys_mount fs/namespace.c:3886 [inline]
       __se_sys_mount fs/namespace.c:3863 [inline]
       __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3863
       __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
       el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

-> #0 (&type->i_mutex_dir_key#15){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x3384/0x763c kernel/locking/lockdep.c:5137
       lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5754
       down_write+0x50/0xc0 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:802 [inline]
       vfs_removexattr+0xcc/0x23c fs/xattr.c:575
       removexattr+0x148/0x1c4 fs/xattr.c:918
       path_removexattr+0x160/0x23c fs/xattr.c:932
       __do_sys_removexattr fs/xattr.c:946 [inline]
       __se_sys_removexattr fs/xattr.c:943 [inline]
       __arm64_sys_removexattr+0x60/0x78 fs/xattr.c:943
       __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
       el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

other info that might help us debug this:

Chain exists of:
  &type->i_mutex_dir_key#15 --> &sbi->lock --> sb_writers#28

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_writers#28);
                               lock(&sbi->lock);
                               lock(sb_writers#28);
  lock(&type->i_mutex_dir_key#15);

 *** DEADLOCK ***

1 lock held by syz-executor.1/16589:
 #0: ffff0000ce5fe418 (sb_writers#28){.+.+}-{0:0}, at: mnt_want_write+0x44/0x9c fs/namespace.c:404

stack backtrace:
CPU: 0 PID: 16589 Comm: syz-executor.1 Not tainted 6.7.0-rc8-syzkaller-g0802e17d9aca #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:291
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:298
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2060
 check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x3384/0x763c kernel/locking/lockdep.c:5137
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5754
 down_write+0x50/0xc0 kernel/locking/rwsem.c:1579
 inode_lock include/linux/fs.h:802 [inline]
 vfs_removexattr+0xcc/0x23c fs/xattr.c:575
 removexattr+0x148/0x1c4 fs/xattr.c:918
 path_removexattr+0x160/0x23c fs/xattr.c:932
 __do_sys_removexattr fs/xattr.c:946 [inline]
 __se_sys_removexattr fs/xattr.c:943 [inline]
 __arm64_sys_removexattr+0x60/0x78 fs/xattr.c:943
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595


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

