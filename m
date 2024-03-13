Return-Path: <linux-fsdevel+bounces-14375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3259487B51F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 00:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C3DDB2211F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 23:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E79A5D734;
	Wed, 13 Mar 2024 23:10:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D25CDE5
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710371436; cv=none; b=irRDAZB/53ZNlKx0p/6x1jU7riYesosg/rDIct4OSAKr/0urE5pkKhEbCT0+/4dr2cYk6JEvveKzIxJIwIfY/WAlXgsSl/1KX+UDNg3hBJFhDFY52hjB+WI8E+gUhHnGr6/nQ2l7cLbydf/apGaAvZiAsQG0j9uMl6iAmmvaMW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710371436; c=relaxed/simple;
	bh=W0n/ndiZEUEPasg9xeSEgOi6hRBR5hFqRQ+G/92EMig=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=p3dtPWWvdc5282n9l3f7Jn161Kmqi00YXLttb71otMWQ4uJL7x7UkkuyyA8oUwVXbgvYUqfRFmtG5z8quaAtUbTCKFJlO7NzuiOBfjm+Obe8msYJmjq8xQ/yUpaLPgP6UulmPEgGiMYU6zQX9t/7W63/oh7IJgmdBnWlGTGY0nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c8af56060aso25596839f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 16:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710371433; x=1710976233;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgkzGBsBAW0nNMHj1XFYGOzyoZnb9rpcdvTvIXrFMAc=;
        b=IsL5Bdo6Sa0kkCviZEWVoKKBROiWKYYz5WcZT8MMmBv/znpzGWoSf7uFtodyg6mvq5
         N2m1J97/86+B41AoQ+mThcbIQgdJi3X9yg+f9ouWLFXZNnFmOaaUDRaf5gWHZc2rbHhJ
         Vx95+nPoFBMTDOkayDFsqWExKXlLfvzrrINtl8fKP9tmtPHV0YlFq84RWApqxlj3v2qW
         0ITB+qpuf+O3Q9wiucNh8f63SXlQrjIVT43wGfhy0pIhvFmKjg8RB99bxRYIvH3+MyGS
         zSITZ5XtehLjxbeJj/iRieyP0+dpMY2eNX8cqvRrhcx5DAO0jsoRGAHGdvzWwC5qnKLO
         RI3w==
X-Forwarded-Encrypted: i=1; AJvYcCW5g6GwdJmZ4w439BlCJE6rzMRvGAwHIlM0z3YCz//aFmh06F9Yz152B87PjpZL+wyhj/T9osB/PepPFe+N1F8a1Dm4Gqh86ZDlG/1WuA==
X-Gm-Message-State: AOJu0YxGyu4KsDw+L4tXGalXBW5DIkqvpygweTGGIJsx+pi8tffBn8a7
	fXkPkrjyrV2E8oWmzdie7VyqYeFdREkl+JSw9wvtEyfOHpMB7QXBUrL2R4VO8RLJN2fSgeZ8AJB
	+7Puok9CmZ2HBcM44Cf074D1Y4mdpzsoyb1VX7qWGJnx+hRwiYks33Ss=
X-Google-Smtp-Source: AGHT+IHGGDhha+hmNL9jrW2oSJRpX5yZtSTmhFony7YGDN1cRA1eg4URiWavjg+Yp4DV46+Iy53T9Ja4qUfV5wTGsaWWs7JHJLqC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b15:b0:476:f8c5:4e19 with SMTP id
 fm21-20020a0566382b1500b00476f8c54e19mr366jab.1.1710371433550; Wed, 13 Mar
 2024 16:10:33 -0700 (PDT)
Date: Wed, 13 Mar 2024 16:10:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb26fd061392e1a9@google.com>
Subject: [syzbot] [overlayfs?] possible deadlock in iter_file_splice_write (3)
From: syzbot <syzbot+e525d9be15a106e48379@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    09e5c48fea17 Merge tag 'ceph-for-6.8-rc8' of https://githu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130a9a3e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=44c92d6f247776b0
dashboard link: https://syzkaller.appspot.com/bug?extid=e525d9be15a106e48379
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/be1396cce3c5/disk-09e5c48f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cd84fbdb0969/vmlinux-09e5c48f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/46bf297bd50b/bzImage-09e5c48f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e525d9be15a106e48379@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-rc7-syzkaller-00231-g09e5c48fea17 #0 Not tainted
------------------------------------------------------
syz-executor.2/10894 is trying to acquire lock:
ffff8880434f8468 (&pipe->mutex/1){+.+.}-{3:3}, at: iter_file_splice_write+0x335/0x14e0 fs/splice.c:687

but task is already holding lock:
ffff88801e194420 (sb_writers#4){.+.+}-{0:0}, at: do_splice+0xcf0/0x1880 fs/splice.c:1353

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (sb_writers#4){.+.+}-{0:0}:
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1641 [inline]
       sb_start_write+0x4d/0x1c0 include/linux/fs.h:1777
       mnt_want_write+0x3f/0x90 fs/namespace.c:409
       ovl_create_object+0x13b/0x370 fs/overlayfs/dir.c:629
       lookup_open fs/namei.c:3500 [inline]
       open_last_lookups fs/namei.c:3569 [inline]
       path_openat+0x1424/0x3240 fs/namei.c:3799
       do_filp_open+0x234/0x490 fs/namei.c:3829
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1404
       do_sys_open fs/open.c:1419 [inline]
       __do_sys_openat fs/open.c:1435 [inline]
       __se_sys_openat fs/open.c:1430 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1430
       do_syscall_64+0xf9/0x240
       entry_SYSCALL_64_after_hwframe+0x6f/0x77

-> #3 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       inode_lock_shared include/linux/fs.h:814 [inline]
       lookup_slow+0x45/0x70 fs/namei.c:1709
       walk_component+0x2e1/0x410 fs/namei.c:2005
       lookup_last fs/namei.c:2462 [inline]
       path_lookupat+0x16f/0x450 fs/namei.c:2486
       filename_lookup+0x255/0x610 fs/namei.c:2515
       kern_path+0x35/0x50 fs/namei.c:2623
       lookup_bdev+0xc5/0x290 block/bdev.c:1014
       resume_store+0x1a0/0x710 kernel/power/hibernate.c:1183
       kernfs_fop_write_iter+0x3a4/0x500 fs/kernfs/file.c:334
       call_write_iter include/linux/fs.h:2087 [inline]
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa81/0xcb0 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_64+0xf9/0x240
       entry_SYSCALL_64_after_hwframe+0x6f/0x77

-> #2 (&of->mutex){+.+.}-{3:3}:
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
       seq_read_iter+0x3d0/0xd60 fs/seq_file.c:225
       call_read_iter include/linux/fs.h:2081 [inline]
       new_sync_read fs/read_write.c:395 [inline]
       vfs_read+0x978/0xb70 fs/read_write.c:476
       ksys_read+0x1a0/0x2c0 fs/read_write.c:619
       do_syscall_64+0xf9/0x240
       entry_SYSCALL_64_after_hwframe+0x6f/0x77

-> #1 (&p->lock){+.+.}-{3:3}:
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
       proc_reg_read_iter+0x1c3/0x290 fs/proc/inode.c:299
       call_read_iter include/linux/fs.h:2081 [inline]
       copy_splice_read+0x661/0xb60 fs/splice.c:365
       do_splice_read fs/splice.c:985 [inline]
       splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
       do_sendfile+0x515/0xdc0 fs/read_write.c:1301
       __do_sys_sendfile64 fs/read_write.c:1356 [inline]
       __se_sys_sendfile64+0x100/0x1e0 fs/read_write.c:1348
       do_syscall_64+0xf9/0x240
       entry_SYSCALL_64_after_hwframe+0x6f/0x77

-> #0 (&pipe->mutex/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18ca/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       iter_file_splice_write+0x335/0x14e0 fs/splice.c:687
       do_splice_from fs/splice.c:941 [inline]
       do_splice+0xd77/0x1880 fs/splice.c:1354
       __do_splice fs/splice.c:1436 [inline]
       __do_sys_splice fs/splice.c:1652 [inline]
       __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
       do_syscall_64+0xf9/0x240
       entry_SYSCALL_64_after_hwframe+0x6f/0x77

other info that might help us debug this:

Chain exists of:
  &pipe->mutex/1 --> &ovl_i_mutex_dir_key[depth] --> sb_writers#4

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_writers#4);
                               lock(&ovl_i_mutex_dir_key[depth]);
                               lock(sb_writers#4);
  lock(&pipe->mutex/1);

 *** DEADLOCK ***

1 lock held by syz-executor.2/10894:
 #0: ffff88801e194420 (sb_writers#4){.+.+}-{0:0}, at: do_splice+0xcf0/0x1880 fs/splice.c:1353

stack backtrace:
CPU: 1 PID: 10894 Comm: syz-executor.2 Not tainted 6.8.0-rc7-syzkaller-00231-g09e5c48fea17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18ca/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 iter_file_splice_write+0x335/0x14e0 fs/splice.c:687
 do_splice_from fs/splice.c:941 [inline]
 do_splice+0xd77/0x1880 fs/splice.c:1354
 __do_splice fs/splice.c:1436 [inline]
 __do_sys_splice fs/splice.c:1652 [inline]
 __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7fa65fa7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa6608b00c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00007fa65fbabf80 RCX: 00007fa65fa7dda9
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007fa65faca47a R08: 0000000000000009 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fa65fbabf80 R15: 00007ffc7c0d55f8
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

