Return-Path: <linux-fsdevel+bounces-16067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C88F8978AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 20:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ECB2B28A1B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 18:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684CD15358C;
	Wed,  3 Apr 2024 18:23:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EE11534F5
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168609; cv=none; b=o01jemy/179qI6YR7mrcKEnP78dDt+TOsDjl2C+GOsD4ngIzn4rT2D1EXfQ+0OzjKxRwpwLEahbY61HOcfCVwY8F0V3KzpDsomTJ+rxyFeNGw299hsav2uN6SycLrJVgEhozW6ycfN59GB5gx/dqL1I6nXMflP6LgLws+f2u5Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168609; c=relaxed/simple;
	bh=9ZAfUM4Ih8PAKVbOYgGDM6fvh/L2tQk0e82atFHToLc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=djTxXfzyDD6K36kqwvjRszO/anNjA5fxy5BhPAL5pEdSYPt9tKknLrhUZtUOV+8OQCo58zswg8eAllVRthBfQ9/H2hWbTgs56l/6e891ISOtMADx4M1ikiLp0T/WtTYyr5N97+fRuLtS3cnshZFnKJXuNPgWMCaBJm0VhPH43T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cf179c3da4so16605539f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Apr 2024 11:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712168606; x=1712773406;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LSqRu5v298RfSB0Z/j1bnkPaJO9LM9Ank65vu8EKmZQ=;
        b=oUqyqgFOWXxUGHrMd406ttl3xep9zEQC/c7HyT+ZcvwKC/Y1y9kt1mwwMHDZFYjte4
         HNsxh4+RSYlZO3c57m/deyr+mCqspbP02x4aoNTcOVOCMrhLI6BCikrQCYOt68NgfCLN
         YeFRMtOtVqIjyt+F9JKx6DkCa7+6Hzh1hhUesu1rvTGJaCIGE3kRobBmeSJJVRfEqvGy
         +WuVsDihiFWKfi5W/l56U8t3En4+vdeYO9s+3ZnhZXbnO4hroB5hlKKLit+ZRL/9G3z7
         OrB6mrHhohkiPYrA7mF3Tay1zyh2yc+sfYijiLRHtpybIIklRN1FanoPRGmIFNZEdZdK
         Px5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdahFYWmpaVil+6siGl6PXqFttCxxVmDlw4yrhJSRE5IZ0irtSUszC/sSjiyxdjT4pKfZZ662T2cVSwiyZGRBSjUxqWuN86J07HVp2QQ==
X-Gm-Message-State: AOJu0Yxcbm9U6QSvK33Zw0/KB21bRC6PBgcTY4kCqO0U5r/K0uN5hE66
	6xaiXN9tr/p/7PY0fsPIX+YP0YC7lP0svdSExoPR1dMx+F5rYw1yiXTTkvd1TaoCqrJF2Kwvkr8
	xVGmZv/Hh2nvgOCJfP+2vi3yh8CUqlutHggYPuPShuabONbMr8oCZMq8=
X-Google-Smtp-Source: AGHT+IHW4ryJ74XFijYLrPEqALfrybmEmLpHsHpTQzHFv0O460XS7kSdwlUlOiOh6GAVuDL2HmpuW5RYLOLjwi98HEMXLWCygWQd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1347:b0:7cc:66b1:fa95 with SMTP id
 i7-20020a056602134700b007cc66b1fa95mr11827iov.3.1712168606688; Wed, 03 Apr
 2024 11:23:26 -0700 (PDT)
Date: Wed, 03 Apr 2024 11:23:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098f75506153551a1@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
From: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=136eb2f6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=9a5b0ced8b1bfb238b56
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f1d93d180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c38139180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
------------------------------------------------------
syz-executor250/5062 is trying to acquire lock:
ffff888022c36888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_llseek+0x7e/0x2a0 fs/kernfs/file.c:867

but task is already holding lock:
ffff88807edeadd8 (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_inode_lock fs/overlayfs/overlayfs.h:649 [inline]
ffff88807edeadd8 (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_llseek+0x26b/0x470 fs/overlayfs/file.c:214

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ovl_i_lock_key[depth]){+.+.}-{3:3}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ovl_inode_lock_interruptible fs/overlayfs/overlayfs.h:654 [inline]
       ovl_nlink_start+0xdc/0x390 fs/overlayfs/util.c:1162
       ovl_do_remove+0x1fa/0xd90 fs/overlayfs/dir.c:893
       vfs_rmdir+0x367/0x4c0 fs/namei.c:4209
       do_rmdir+0x3b5/0x580 fs/namei.c:4268
       __do_sys_rmdir fs/namei.c:4287 [inline]
       __se_sys_rmdir fs/namei.c:4285 [inline]
       __x64_sys_rmdir+0x49/0x60 fs/namei.c:4285
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #1 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
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

-> #0 (&of->mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
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

other info that might help us debug this:

Chain exists of:
  &of->mutex --> &ovl_i_mutex_dir_key[depth] --> &ovl_i_lock_key[depth]

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ovl_i_lock_key[depth]);
                               lock(&ovl_i_mutex_dir_key[depth]);
                               lock(&ovl_i_lock_key[depth]);
  lock(&of->mutex);

 *** DEADLOCK ***

1 lock held by syz-executor250/5062:
 #0: ffff88807edeadd8 (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_inode_lock fs/overlayfs/overlayfs.h:649 [inline]
 #0: ffff88807edeadd8 (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_llseek+0x26b/0x470 fs/overlayfs/file.c:214

stack backtrace:
CPU: 1 PID: 5062 Comm: syz-executor250 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
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
 kernfs_fop_llseek+0x7e/0x2a0 fs/kernfs/file.c:867
 ovl_llseek+0x314/0x470 fs/overlayfs/file.c:218
 vfs_llseek fs/read_write.c:289 [inline]
 ksys_lseek fs/read_write.c:302 [inline]
 __do_sys_lseek fs/read_write.c:313 [inline]
 __se_sys_lseek fs/read_write.c:311 [inline]
 __x64_sys_lseek+0x153/0x1e0 fs/read_write.c:311
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f0e2bdfd219
Code: 48 83 c4 28 c3 e8 67 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd2f80f3f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000008
RAX: ffffffffffffffda RBX: 00007ffd2f80f400 RCX: 00007f0e2bdfd219
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007ffd2f80f408 R08: 00007f0e2bdca000 R09: 00007f0e2bdca000
R10: 00007f0e2bdca000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd2f80f668 R14: 0000000000000001 R15: 0000000000000001


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

