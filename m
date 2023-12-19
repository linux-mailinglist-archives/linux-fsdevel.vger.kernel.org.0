Return-Path: <linux-fsdevel+bounces-6521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0592819100
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 20:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B04FB234E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 19:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1593D0B2;
	Tue, 19 Dec 2023 19:43:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0524E3D0A7
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35f49926297so73324955ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 11:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703015007; x=1703619807;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vu+jS6cLyAU338baY7JrkJ4z1XHBKULooBAqdNqSsNQ=;
        b=qSJU9aRbikx87nP2Br6DKARawQx0dhLV+vYumhSI6Zaj2RYhLYNBcAkQukMc0//k6y
         pwZnP7tAcJ74vWm0mL3pfcD+vW2bpakmOOugOw906N9zy+gSXyAzlDrP1yVpRXbppbMt
         mI769MsW/eoiVBlsBYR4esTyGXi4L+Pa9DZQaieTMGmNBuh/AH87NKHhRp2wo7ViQZ4y
         NUzY63Fyjob/LOo9/o3lXRNxIiYMMuUjKszVuHh0tw3hY3OWr/qD3KhGto+vlC+aFRR0
         9xZwnWeOWczHI0DKlOhwwBf6P9vbENIrHb5NTwQo3p7ovpzRkHRKVWrQgIgRsFSbZLcC
         xC9A==
X-Gm-Message-State: AOJu0Yxc+LrFlZTv4ROqOb6N2jN6fBXo8dZOBTBuTGaFGK4ClwyXGNYu
	rZytsxUyIDcwyWndzFD1S3ckObOgvKhr4hvtowieyMJiANAu
X-Google-Smtp-Source: AGHT+IFJLIJo5Za5v/DsLptxAuiJeDiwHKrO3f5NhLHoosTrhjd7LHSW9RjisSo2/cbNSB7daTX6AbQdlwLxvBOHeC3yJHvnpIfi
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:338d:b0:35f:b2f8:6ca3 with SMTP id
 bn13-20020a056e02338d00b0035fb2f86ca3mr497273ilb.2.1703015007319; Tue, 19 Dec
 2023 11:43:27 -0800 (PST)
Date: Tue, 19 Dec 2023 11:43:27 -0800
In-Reply-To: <000000000000e171200600d6d8bd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008efd70060ce21487@google.com>
Subject: Re: [syzbot] [overlayfs?] possible deadlock in seq_read_iter (2)
From: syzbot <syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2cf4f94d8e86 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12181571e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5751b3a2226135d
dashboard link: https://syzkaller.appspot.com/bug?extid=da4f9f61f96525c62cc7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176a4f49e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154aa8d6e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cc8943b61205/disk-2cf4f94d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b515b02658d/vmlinux-2cf4f94d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1f8ccc925248/bzImage-2cf4f94d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.7.0-rc6-syzkaller-00010-g2cf4f94d8e86 #0 Not tainted
------------------------------------------------------
syz-executor424/7758 is trying to acquire lock:
ffff88801f1ef9e0 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb2/0xd10 fs/seq_file.c:182

but task is already holding lock:
ffff88814cd7a418 (sb_writers#4){.+.+}-{0:0}, at: do_sendfile+0x607/0x1000 fs/read_write.c:1253

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3
 (sb_writers#4){.+.+}-{0:0}:
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1635 [inline]
       sb_start_write+0x4d/0x1c0 include/linux/fs.h:1710
       mnt_want_write+0x3f/0x90 fs/namespace.c:404
       ovl_create_object+0x13b/0x360 fs/overlayfs/dir.c:629
       lookup_open fs/namei.c:3477 [inline]
       open_last_lookups fs/namei.c:3546 [inline]
       path_openat+0x13fa/0x3290 fs/namei.c:3776
       do_filp_open+0x234/0x490 fs/namei.c:3809
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_open fs/open.c:1460 [inline]
       __se_sys_open fs/open.c:1456 [inline]
       __x64_sys_open+0x225/0x270 fs/open.c:1456
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #2 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       inode_lock_shared include/linux/fs.h:812 [inline]
       lookup_slow+0x45/0x70 fs/namei.c:1710
       walk_component+0x2d0/0x400 fs/namei.c:2002
       lookup_last fs/namei.c:2459 [inline]
       path_lookupat+0x16f/0x450 fs/namei.c:2483
       filename_lookup+0x255/0x610 fs/namei.c:2512
       kern_path+0x35/0x50 fs/namei.c:2610
       lookup_bdev+0xc5/0x290 block/bdev.c:979
       resume_store+0x1a0/0x710 kernel/power/hibernate.c:1177
       kernfs_fop_write_iter+0x3b3/0x510 fs/kernfs/file.c:334
       do_iter_readv_writev+0x330/0x4a0
       do_iter_write+0x1f6/0x8d0 fs/read_write.c:860
       iter_file_splice_write+0x86d/0x1010 fs/splice.c:736
       do_splice_from fs/splice.c:933 [inline]
       direct_splice_actor+0xea/0x1c0 fs/splice.c:1142
       splice_direct_to_actor+0x376/0x9e0 fs/splice.c:1088
       do_splice_direct+0x2ac/0x3f0 fs/splice.c:1194
       do_sendfile+0x62c/0x1000 fs/read_write.c:1254
       __do_sys_sendfile64 fs/read_write.c:1322 [inline]
       __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #1 (&of->mutex){+.+.}-{3:3}:
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
       kernfs_seq_start+0x53/0x3a0 fs/kernfs/file.c:154
       seq_read_iter+0x3d4/0xd10 fs/seq_file.c:225
       call_read_iter include/linux/fs.h:2014 [inline]
       new_sync_read fs/read_write.c:389 [inline]
       vfs_read+0x78b/0xb00 fs/read_write.c:470
       ksys_read+0x1a0/0x2c0 fs/read_write.c:613
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

-> #0 (&p->lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x1909/0x5ab0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
       seq_read_iter+0xb2/0xd10 fs/seq_file.c:182
       call_read_iter include/linux/fs.h:2014 [inline]
       copy_splice_read+0x4c9/0x9c0 fs/splice.c:364
       splice_direct_to_actor+0x2c4/0x9e0 fs/splice.c:1069
       do_splice_direct+0x2ac/0x3f0 fs/splice.c:1194
       do_sendfile+0x62c/0x1000 fs/read_write.c:1254
       __do_sys_sendfile64 fs/read_write.c:1322 [inline]
       __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

other info that might help us debug this:

Chain exists of:
  &p->lock --> &ovl_i_mutex_dir_key[depth] --> sb_writers#4

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_writers#4);
                               lock(&ovl_i_mutex_dir_key[depth]);
                               lock(sb_writers#4);
  lock(&p->lock);

 *** DEADLOCK ***

1 lock held by syz-executor424/7758:
 #0: ffff88814cd7a418 (sb_writers#4){.+.+}-{0:0}, at: do_sendfile+0x607/0x1000 fs/read_write.c:1253

stack backtrace:
CPU: 0 PID: 7758 Comm: syz-executor424 Not tainted 6.7.0-rc6-syzkaller-00010-g2cf4f94d8e86 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x366/0x490 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x1909/0x5ab0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
 seq_read_iter+0xb2/0xd10 fs/seq_file.c:182
 call_read_iter include/linux/fs.h:2014 [inline]
 copy_splice_read+0x4c9/0x9c0 fs/splice.c:364
 splice_direct_to_actor+0x2c4/0x9e0 fs/splice.c:1069
 do_splice_direct+0x2ac/0x3f0 fs/splice.c:1194
 do_sendfile+0x62c/0x1000 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fef41211d49
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fef411d2218 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fef4129c3e8 RCX: 00007fef41211d49
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 00007fef4129c3e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0001000000201007 R11: 0000000000000246 R12: 00007fef41269060
R13: 0030656c69662f2e R14: 6e6f3d6f6e69782c R15: 0079616c7265766f
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

