Return-Path: <linux-fsdevel+bounces-16358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCC489BE60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 13:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51944B226A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 11:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCA96A01B;
	Mon,  8 Apr 2024 11:49:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0502E651B4
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712576970; cv=none; b=Uz23JYn1D8VL39REmWNzlOo+uEWf8DSS3VeNbIa7od0QCRYuxpoAA13uU0lCbd+Uy0IdLxx7lp1J+AkMwPvTt17MgU5z3pe08uy0Kt/8db72l0hMnw0oKuSlGYv2c2ippaUdDIcwB0VoD5EzvnanRvksLN0RydYkyIvTUfhpLAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712576970; c=relaxed/simple;
	bh=us0c4Dslc1F+n8qOFwHjUPkmM36/7F16esCfwf/8gr0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VCkR5spjA3hoCqC3/DB/c/Xiy+fppMi8lOOH59HeWFOGcmO400fbKQGuLpz7mwlws9VDN7+lHU/n/AuAw0OoIGLTgey/gyM3Jr0BnSzsMSfyUrufkatD4Zgi8Rw7k+yUbb/n8AaPiTpbW2N9svZdMI2DegKntJ5VXCKd7OcNakg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5efba3f8fso65004539f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Apr 2024 04:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712576968; x=1713181768;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nCDvqPR8UGBCWIEcljIq/sHtqeu9tvtElDnOT2BFW9s=;
        b=RhpzzJ+j7529hJm/G6fsCCiRQAMQtgBYe0ANoW6jMlQB7vlLVfegXwAt+VyHKtVod5
         apu1/vaZSRiYzm7Bg+Nvh1ErQ+kCsYnjfwuh/RyjFls++pb4R0suHx0H5hs5UcgVB9ve
         ojWYAy1y7dYpk+uv41ZyYJMu9uYjyl9IlMicZEXxdis9zVnGiS0BfMdBFk/HG89vuUjC
         Y95g/CfMfTtz7/qAD5CaUCHkDRaAVtcWr547LJb1TSOz8UyF6Hr5xuGiy0e0PxDn2N3u
         y4A26sWIQ7vo6khKPtvVqkvVzIIRa4JzLbY05nBs5aONhf6Jak7a3Qm9mT59cuHASznE
         A+8A==
X-Forwarded-Encrypted: i=1; AJvYcCU4DmCObcMcBJKq5WIuJdgWYQcbmwD6e6qLFfJuw4RN0P2vpQZ/pcCeUApx4gLpvMcielbvg5AeoDRsqHVdBt9ioN0seF7QG2Ygq8XZhw==
X-Gm-Message-State: AOJu0YywjCWNrv/HoOWHr6XDgP15Gj7OgeEFOR00zkrtcXW7Hw3/yPRL
	zie8kgPuHC/8BxM6IAiwxyWGoY5j3eHZYwW4bUJxewmHrdMU4YJLrLwLnEIFRrpUzkHe8Yc70mE
	4LUIlLbZViZYJ5nYCwS8qI+Enke2oZhv/4+Fuax3MTgiyVHzw/6ItQWw=
X-Google-Smtp-Source: AGHT+IGAF/FMYevGl21HzmtJCmx2OZuGTWZDw34y+9qGHUWGxNf6lT3GRF4bryRcZv7ZdMrPkY6iJ8nNtlvo8gZ6rbw9rryzTgXe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c9:b0:368:c21e:3898 with SMTP id
 9-20020a056e0220c900b00368c21e3898mr664912ilq.3.1712576968247; Mon, 08 Apr
 2024 04:49:28 -0700 (PDT)
Date: Mon, 08 Apr 2024 04:49:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7de3c0615946534@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in lookup_one_unlocked
From: syzbot <syzbot+ac3c5eb32b9d409dc11d@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17adb6d3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=ac3c5eb32b9d409dc11d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ac3c5eb32b9d409dc11d@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
------------------------------------------------------
syz-executor.1/9023 is trying to acquire lock:
ffff88805d610740 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:803 [inline]
ffff88805d610740 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: lookup_slow fs/namei.c:1708 [inline]
ffff88805d610740 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: lookup_one_unlocked+0x197/0x290 fs/namei.c:2817

but task is already holding lock:
ffff88805d612450 (&ovl_i_mutex_dir_key[depth]#3){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:803 [inline]
ffff88805d612450 (&ovl_i_mutex_dir_key[depth]#3){.+.+}-{3:3}, at: lookup_slow+0x45/0x70 fs/namei.c:1708

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&ovl_i_mutex_dir_key[depth]#3){.+.+}-{3:3}:
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

-> #4 (&of->mutex){+.+.}-{3:3}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
       seq_read_iter+0x3d0/0xd60 fs/seq_file.c:225
       call_read_iter include/linux/fs.h:2102 [inline]
       new_sync_read fs/read_write.c:395 [inline]
       vfs_read+0x97b/0xb70 fs/read_write.c:476
       ksys_read+0x1a0/0x2c0 fs/read_write.c:619
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #3 (&p->lock){+.+.}-{3:3}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
       call_read_iter include/linux/fs.h:2102 [inline]
       copy_splice_read+0x662/0xb60 fs/splice.c:365
       do_splice_read fs/splice.c:985 [inline]
       splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
       do_sendfile+0x515/0xdc0 fs/read_write.c:1301
       __do_sys_sendfile64 fs/read_write.c:1362 [inline]
       __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #2 (&pipe->mutex){+.+.}-{3:3}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       iter_file_splice_write+0x335/0x14e0 fs/splice.c:687
       do_splice_from fs/splice.c:941 [inline]
       do_splice+0xd77/0x1880 fs/splice.c:1354
       __do_splice fs/splice.c:1436 [inline]
       __do_sys_splice fs/splice.c:1652 [inline]
       __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #1 (sb_writers#4){.+.+}-{0:0}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1662 [inline]
       sb_start_write+0x4d/0x1c0 include/linux/fs.h:1798
       mnt_want_write+0x3f/0x90 fs/namespace.c:409
       ovl_create_object+0x13b/0x370 fs/overlayfs/dir.c:629
       lookup_open fs/namei.c:3497 [inline]
       open_last_lookups fs/namei.c:3566 [inline]
       path_openat+0x1425/0x3240 fs/namei.c:3796
       do_filp_open+0x235/0x490 fs/namei.c:3826
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_sys_open fs/open.c:1429 [inline]
       __se_sys_open fs/open.c:1425 [inline]
       __x64_sys_open+0x225/0x270 fs/open.c:1425
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #0 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       inode_lock_shared include/linux/fs.h:803 [inline]
       lookup_slow fs/namei.c:1708 [inline]
       lookup_one_unlocked+0x197/0x290 fs/namei.c:2817
       ovl_lookup_positive_unlocked fs/overlayfs/namei.c:210 [inline]
       ovl_lookup_single+0x200/0xbd0 fs/overlayfs/namei.c:240
       ovl_lookup_layer+0x417/0x510 fs/overlayfs/namei.c:333
       ovl_lookup+0xcf7/0x2a60 fs/overlayfs/namei.c:1124
       __lookup_slow+0x28c/0x3f0 fs/namei.c:1692
       lookup_slow+0x53/0x70 fs/namei.c:1709
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

other info that might help us debug this:

Chain exists of:
  &ovl_i_mutex_dir_key[depth] --> &of->mutex --> &ovl_i_mutex_dir_key[depth]#3

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&ovl_i_mutex_dir_key[depth]#3);
                               lock(&of->mutex);
                               lock(&ovl_i_mutex_dir_key[depth]#3);
  rlock(&ovl_i_mutex_dir_key[depth]);

 *** DEADLOCK ***

5 locks held by syz-executor.1/9023:
 #0: ffff888059ebf248 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x259/0x320 fs/file.c:1191
 #1: ffff88802f972420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2853 [inline]
 #1: ffff88802f972420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x233/0xcb0 fs/read_write.c:586
 #2: ffff88801edfd088 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1eb/0x500 fs/kernfs/file.c:325
 #3: ffff888019281918 (kn->active#59){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20f/0x500 fs/kernfs/file.c:326
 #4: ffff88805d612450 (&ovl_i_mutex_dir_key[depth]#3){.+.+}-{3:3}, at: inode_lock_shared include/linux/fs.h:803 [inline]
 #4: ffff88805d612450 (&ovl_i_mutex_dir_key[depth]#3){.+.+}-{3:3}, at: lookup_slow+0x45/0x70 fs/namei.c:1708

stack backtrace:
CPU: 1 PID: 9023 Comm: syz-executor.1 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
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
 down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
 inode_lock_shared include/linux/fs.h:803 [inline]
 lookup_slow fs/namei.c:1708 [inline]
 lookup_one_unlocked+0x197/0x290 fs/namei.c:2817
 ovl_lookup_positive_unlocked fs/overlayfs/namei.c:210 [inline]
 ovl_lookup_single+0x200/0xbd0 fs/overlayfs/namei.c:240
 ovl_lookup_layer+0x417/0x510 fs/overlayfs/namei.c:333
 ovl_lookup+0xcf7/0x2a60 fs/overlayfs/namei.c:1124
 __lookup_slow+0x28c/0x3f0 fs/namei.c:1692
 lookup_slow+0x53/0x70 fs/namei.c:1709
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
RIP: 0033:0x7f389687de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f38963ff0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f38969abf80 RCX: 00007f389687de69
RDX: 0000000000000012 RSI: 0000000020000000 RDI: 0000000000000006
RBP: 00007f38968ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f38969abf80 R15: 00007ffca27d9338
 </TASK>
PM: Image not found (code -6)


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

