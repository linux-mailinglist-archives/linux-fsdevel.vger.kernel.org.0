Return-Path: <linux-fsdevel+bounces-16331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF33889B38B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 20:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F954B225A3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 18:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD163C48E;
	Sun,  7 Apr 2024 18:37:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C0B3BB48
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Apr 2024 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712515049; cv=none; b=DNZup/GltBJFT/jSrYv8HggrGbKqyjNGthR7OTF3yeQyNL4rJqA4h+a5UFpSFjVZbxESNDAbjg/8aJcauLNZe9hVBHUDJI1frOR7iqATekb7AlbZRkg1dppOxM/jYCKVUdOcjmdARrr9hxd0n7nrTGx9fy+eJQIfZL8A6kknfg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712515049; c=relaxed/simple;
	bh=z9dVydCGQccil9iduLyVYmGvHO0quDz92LltjxcSIP4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DcRUKCTShjSl9PbVYVLPYPKmPUtROWJkieeGCq5+N2X1ZUpjIsbSWlNXUZhtNVgm9Nq3Vlwv19P6xFKV06p2xNtamexMlE54yckQ/+UoHpd5QLDLlT6t4hEVowM1eg71pORX8k+7jHysdqOSuEeHgJARGUhPUfsM+rLk54C9JqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c7e21711d0so298996539f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Apr 2024 11:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712515046; x=1713119846;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZtGQvEQZ/fTBpSrM4TpNjFmoANPjSiQ4qjQ7HxVZ0EI=;
        b=uWniTBVPbPGC6Rgv763EX+OYikK9uLsxwuOcxjKXAa7K0SZBD2psQhExCjVAz2lZX0
         g/zgjvrWFQ6fqlwRexEU3FDtSbtZnqJIm4wKqs8rir3H5Bc2jusr1+Ciq3PTl7sUEFsr
         TytlRqcOV9ev5HnA381AfF6shV4sSkav2SS0sHMEzDUOIxS4zNKrbJpJ5VwTuKrQ2m61
         x6GT1UBz49lf6TIFFnrim/i45yt4MCgr6XGOgLT7auf5U6B0FCCddt1oJXOFkQ7K/N5m
         lo8PVozGXw9z8TXnwFq/YAFA9gDTzKuo0n6ejFaPlBccW51JI3Q43iTqyK64PBFjDLSE
         O7xw==
X-Forwarded-Encrypted: i=1; AJvYcCWlI3cv7ggEw8CqBUXTuVG4wsIm5oK9fJanFyugdpC3IbIW+xErTZa5Ig9fRtPZIbBnKLWxfAPkCmQfXaauzVaazY8qoID+6Hn146R7bA==
X-Gm-Message-State: AOJu0YyHhEdbuHQAbFjV3+xJedtnFZ7u80e5d4gM3oVKX6D6W3z/1hgC
	1Q1Wig+w25hN8sRkewlCG6rQLdf8YgK+U4tTdGvyuUBrV1zW9pQuVy8mZrbqMXwOVAEb8JYBj1x
	OZlPnlx+E6BxNmoL2Y6awZNhoUphsQOH0Xu6PYvLRFQXweu2f5WwBnC8=
X-Google-Smtp-Source: AGHT+IEMMfEJ1vPqqmcV5Eghlm9vTYfBeLb9v464xCZ7Hc2GJXk5IJwp5pQGcGOig7pbJfZ7LmAgK0ceaM4TJZTnjGXTHRAZAmdK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22d0:b0:47c:195d:16f6 with SMTP id
 j16-20020a05663822d000b0047c195d16f6mr235298jat.6.1712515046692; Sun, 07 Apr
 2024 11:37:26 -0700 (PDT)
Date: Sun, 07 Apr 2024 11:37:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007ebc6061585fb7f@google.com>
Subject: [syzbot] [overlayfs?] possible deadlock in ovl_copy_up_start (3)
From: syzbot <syzbot+5e130dffef394d3f11a6@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f706ad180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=5e130dffef394d3f11a6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5e130dffef394d3f11a6@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
------------------------------------------------------
syz-executor.4/8594 is trying to acquire lock:
ffff88805d9aff38 (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_inode_lock_interruptible fs/overlayfs/overlayfs.h:654 [inline]
ffff88805d9aff38 (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_copy_up_start+0x53/0x310 fs/overlayfs/util.c:719

but task is already holding lock:
ffff88805d9afb80 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: inode_lock include/linux/fs.h:793 [inline]
ffff88805d9afb80 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: vfs_rmdir+0x101/0x4c0 fs/namei.c:4198

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       inode_lock_shared include/linux/fs.h:803 [inline]
       lookup_slow+0x45/0x70 fs/namei.c:1708
       walk_component+0x2e1/0x410 fs/namei.c:2004
       lookup_last fs/namei.c:2461 [inline]
       path_lookupat+0x16f/0x450 fs/namei.c:2485
       filename_lookup+0x256/0x610 fs/namei.c:2514
       kern_path+0x35/0x50 fs/namei.c:2622
       lookup_bdev+0xc5/0x290 block/bdev.c:1072
       resume_store+0x1a0/0x710 kernel/power/hibernate.c:1235
       kernfs_fop_write_iter+0x3a4/0x500 fs/kernfs/file.c:334
       call_write_iter include/linux/fs.h:2108 [inline]
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa84/0xcb0 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #1 (&of->mutex){+.+.}-{3:3}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       kernfs_fop_llseek+0x7e/0x2a0 fs/kernfs/file.c:867
       ovl_llseek+0x314/0x470 fs/overlayfs/file.c:218
       vfs_llseek fs/read_write.c:289 [inline]
       ksys_lseek fs/read_write.c:302 [inline]
       __do_sys_lseek fs/read_write.c:313 [inline]
       __se_sys_lseek fs/read_write.c:311 [inline]
       __x64_sys_lseek+0x153/0x1e0 fs/read_write.c:311
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #0 (&ovl_i_lock_key[depth]){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ovl_inode_lock_interruptible fs/overlayfs/overlayfs.h:654 [inline]
       ovl_copy_up_start+0x53/0x310 fs/overlayfs/util.c:719
       ovl_copy_up_one fs/overlayfs/copy_up.c:1161 [inline]
       ovl_copy_up_flags+0xbb6/0x4450 fs/overlayfs/copy_up.c:1223
       ovl_nlink_start+0x9f/0x390 fs/overlayfs/util.c:1157
       ovl_do_remove+0x1fa/0xd90 fs/overlayfs/dir.c:893
       vfs_rmdir+0x367/0x4c0 fs/namei.c:4209
       do_rmdir+0x3b5/0x580 fs/namei.c:4268
       __do_sys_rmdir fs/namei.c:4287 [inline]
       __se_sys_rmdir fs/namei.c:4285 [inline]
       __x64_sys_rmdir+0x49/0x60 fs/namei.c:4285
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

Chain exists of:
  &ovl_i_lock_key[depth] --> &of->mutex --> &ovl_i_mutex_dir_key[depth]

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ovl_i_mutex_dir_key[depth]);
                               lock(&of->mutex);
                               lock(&ovl_i_mutex_dir_key[depth]);
  lock(&ovl_i_lock_key[depth]);

 *** DEADLOCK ***

3 locks held by syz-executor.4/8594:
 #0: ffff88802c9d8420 (sb_writers#23){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #1: ffff88805d9aa450 (&ovl_i_mutex_dir_key[depth]/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:828 [inline]
 #1: ffff88805d9aa450 (&ovl_i_mutex_dir_key[depth]/1){+.+.}-{3:3}, at: do_rmdir+0x263/0x580 fs/namei.c:4256
 #2: ffff88805d9afb80 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: inode_lock include/linux/fs.h:793 [inline]
 #2: ffff88805d9afb80 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: vfs_rmdir+0x101/0x4c0 fs/namei.c:4198

stack backtrace:
CPU: 0 PID: 8594 Comm: syz-executor.4 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 ovl_inode_lock_interruptible fs/overlayfs/overlayfs.h:654 [inline]
 ovl_copy_up_start+0x53/0x310 fs/overlayfs/util.c:719
 ovl_copy_up_one fs/overlayfs/copy_up.c:1161 [inline]
 ovl_copy_up_flags+0xbb6/0x4450 fs/overlayfs/copy_up.c:1223
 ovl_nlink_start+0x9f/0x390 fs/overlayfs/util.c:1157
 ovl_do_remove+0x1fa/0xd90 fs/overlayfs/dir.c:893
 vfs_rmdir+0x367/0x4c0 fs/namei.c:4209
 do_rmdir+0x3b5/0x580 fs/namei.c:4268
 __do_sys_rmdir fs/namei.c:4287 [inline]
 __se_sys_rmdir fs/namei.c:4285 [inline]
 __x64_sys_rmdir+0x49/0x60 fs/namei.c:4285
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f3be947dde9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3bea1720c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 00007f3be95abf80 RCX: 00007f3be947dde9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200002c0
RBP: 00007f3be94ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f3be95abf80 R15: 00007ffd9e6203e8
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

