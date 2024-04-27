Return-Path: <linux-fsdevel+bounces-17969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B89A8B45BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 13:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917631F21F8D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 11:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FBD4AEEC;
	Sat, 27 Apr 2024 11:09:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC204AEC7
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Apr 2024 11:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714216165; cv=none; b=Ex9qEpeDbs3DQ4g9c+JCOcQ91onzuNy8EZWTtX23gtkoSx/oywvij9mdjxvtmNaYEZCyK563GC41w8gbl5jCstkFGrVVM7w/IKtjrxCpWkOrbl4pOaYLAL5WzuBEewF8xY+33DXgdU1RXhVE9IOwIvIBBVDoGS7K98EgL/6Xekc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714216165; c=relaxed/simple;
	bh=ps0QFqiOcPgLOAiHQX9C6AOho2d/iZk3wEj7WbVsLcE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bt49PY2sTbLcvtF8s/DfJPcm2BvzPtdUGYqx/pxP5x1JnewEVmoip5eYZDyEfWIYpJXMbUJxs/MNmGtPYYFWHzbhOMpgeKe3eFJI8ZLHU2OAn946ttsyyqzMJJoJt14o42HjIgh/zP2wQ8Gft/d83cJ9l3UDTFJPyGDwhAeKo3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7deb999eea4so59307939f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Apr 2024 04:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714216162; x=1714820962;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qSvdmjKcw3FZYrclxf/+dfmFLq159LDn5HIUN66mdVM=;
        b=C91LwjZpYGDs0Qais3YuRqzErCx1cjJo4aS6k22VqFgnwlLXzd41TlsAQsAJ+7uvnO
         9N7NE57DF6gqqAmj5dbB63YD07ZDEyWTPMpdWMF2PXTEZnbugq71YKbd89vJv06BqUgO
         32XhV3xZvnf3ZlEyo83+073Lm+iMaJl0OVQFUdDj0bCUwRb88GII973eu9WsM/YS+rFt
         ZRs7Iuf5yl1ARpDmx8iZ6U9XjKNkWd5tFaZ2HqUXBZWeJAQEUpWmaHN8fuvzJlRy9xye
         3MIE65SpSwLSAQrPbuJlnJKb0LU8eTmmnyomAOip2KJrhDf8J4V/HcDM5BdxFXJfirTn
         zDWA==
X-Forwarded-Encrypted: i=1; AJvYcCUOHdjnVbsbar6dXrUm9GeuAhTvTh52umzbr8uJ/L5Q63UgBcztV93ZDSmK2OvoiSQ/BBI49nnDYjdC0k/t3Twl9i1B75Q1WHwiJyFjjg==
X-Gm-Message-State: AOJu0YyxiitBlnUnM8DzMfRsfk5E8p1lroV6rvF+GChcQKs8Act9kad3
	rkq+jVdOfPrtL6yzDWE44APY8JLk/ij0pynCj94twViyWmaN21tNt4dWO6kNW6mTByKaQTL5FR8
	EoDgA5NYvLl9hlcrUZ579zkmROQ9dX+NhdM++qaimMNgnXfrcnQLQ54k=
X-Google-Smtp-Source: AGHT+IFO4ByM6vPJ8dQS1FfN6XLiRyUrMdiNORijRABxlmL00upCqlX3arz84mQUtAoWdC8GKBt4yjKR2kcvLl+W6vBohhUpLtiX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:450b:b0:487:4ad0:def3 with SMTP id
 bs11-20020a056638450b00b004874ad0def3mr215228jab.0.1714216161740; Sat, 27 Apr
 2024 04:09:21 -0700 (PDT)
Date: Sat, 27 Apr 2024 04:09:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006399c80617120daa@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in kernfs_seq_start
From: syzbot <syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    71b1543c83d6 Merge tag '6.9-rc5-ksmbd-fixes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132f3973180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=4c493dcd5a68168a94b2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c2ffdc70f4f4/disk-71b1543c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3f55cd9df875/vmlinux-71b1543c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c9547057857d/bzImage-71b1543c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc5-syzkaller-00031-g71b1543c83d6 #0 Not tainted
------------------------------------------------------
syz-executor.1/17062 is trying to acquire lock:
ffff88806b638488 (&of->mutex){+.+.}-{3:3}, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154

but task is already holding lock:
ffff88806fe359e0 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&p->lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
       call_read_iter include/linux/fs.h:2104 [inline]
       copy_splice_read+0x662/0xb60 fs/splice.c:365
       do_splice_read fs/splice.c:985 [inline]
       splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
       do_sendfile+0x515/0xdc0 fs/read_write.c:1301
       __do_sys_sendfile64 fs/read_write.c:1362 [inline]
       __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&pipe->mutex){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       iter_file_splice_write+0x335/0x14e0 fs/splice.c:687
       do_splice_from fs/splice.c:941 [inline]
       do_splice+0xd77/0x1880 fs/splice.c:1354
       __do_splice fs/splice.c:1436 [inline]
       __do_sys_splice fs/splice.c:1652 [inline]
       __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (sb_writers#4){.+.+}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1664 [inline]
       sb_start_write+0x4d/0x1c0 include/linux/fs.h:1800
       mnt_want_write+0x3f/0x90 fs/namespace.c:409
       ovl_create_object+0x13b/0x370 fs/overlayfs/dir.c:629
       lookup_open fs/namei.c:3497 [inline]
       open_last_lookups fs/namei.c:3566 [inline]
       path_openat+0x1425/0x3240 fs/namei.c:3796
       do_filp_open+0x235/0x490 fs/namei.c:3826
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_sys_openat fs/open.c:1437 [inline]
       __se_sys_openat fs/open.c:1432 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       inode_lock_shared include/linux/fs.h:805 [inline]
       lookup_slow+0x45/0x70 fs/namei.c:1708
       walk_component+0x2e1/0x410 fs/namei.c:2004
       lookup_last fs/namei.c:2461 [inline]
       path_lookupat+0x16f/0x450 fs/namei.c:2485
       filename_lookup+0x256/0x610 fs/namei.c:2514
       kern_path+0x35/0x50 fs/namei.c:2622
       lookup_bdev+0xc5/0x290 block/bdev.c:1136
       resume_store+0x1a0/0x710 kernel/power/hibernate.c:1235
       kernfs_fop_write_iter+0x3a1/0x500 fs/kernfs/file.c:334
       call_write_iter include/linux/fs.h:2110 [inline]
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa84/0xcb0 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&of->mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
       seq_read_iter+0x3d0/0xd60 fs/seq_file.c:225
       call_read_iter include/linux/fs.h:2104 [inline]
       copy_splice_read+0x662/0xb60 fs/splice.c:365
       do_splice_read fs/splice.c:985 [inline]
       splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
       do_sendfile+0x515/0xdc0 fs/read_write.c:1301
       __do_sys_sendfile64 fs/read_write.c:1362 [inline]
       __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &of->mutex --> &pipe->mutex --> &p->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&p->lock);
                               lock(&pipe->mutex);
                               lock(&p->lock);
  lock(&of->mutex);

 *** DEADLOCK ***

2 locks held by syz-executor.1/17062:
 #0: ffff88802d049468 (&pipe->mutex){+.+.}-{3:3}, at: splice_file_to_pipe+0x2e/0x500 fs/splice.c:1292
 #1: ffff88806fe359e0 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182

stack backtrace:
CPU: 0 PID: 17062 Comm: syz-executor.1 Not tainted 6.9.0-rc5-syzkaller-00031-g71b1543c83d6 #0
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
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
 seq_read_iter+0x3d0/0xd60 fs/seq_file.c:225
 call_read_iter include/linux/fs.h:2104 [inline]
 copy_splice_read+0x662/0xb60 fs/splice.c:365
 do_splice_read fs/splice.c:985 [inline]
 splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
 do_sendfile+0x515/0xdc0 fs/read_write.c:1301
 __do_sys_sendfile64 fs/read_write.c:1362 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f50be67dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f50bf41a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f50be7ac1f0 RCX: 00007f50be67dea9
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000005
RBP: 00007f50be6ca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f50be7ac1f0 R15: 00007ffe78344d68
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

