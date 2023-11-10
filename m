Return-Path: <linux-fsdevel+bounces-2722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2C47E7C35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 13:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E5C2813C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 12:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C671A125DB;
	Fri, 10 Nov 2023 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F91D513
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 12:38:31 +0000 (UTC)
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD52034800
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 04:38:28 -0800 (PST)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1cc281f1214so18988645ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 04:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699619908; x=1700224708;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n4jYcXhSccrT1hloG9/QX759NTdojbCoAe1uWt2G6uA=;
        b=WJAOm2s5yvZMA6K+wrqE3UIFiBdmNmJ8eBK9ywae7sAOQjnnXqlQ0To90kmJ331lae
         yku3D/vKRdx4ZlY6zSQvsleq/XhYx25HpEtOXL0ev8hLhoRcUdLjZfe2gu78LhRnx0z+
         0nWdz/TOL9mXtc6NwFRaugxzp3ObnBVMXvkMPAasbXZLoc9b5pS6livXXmXD8V6/rWZT
         Wistw0cHIQslG08/KmGVkrpg3ikqJzMfgj8BTZLgAGgALJDXnrnCO8U7MlUDs3L1qfpl
         yCofOBAulwEArkCNIe6kt3OwtJaG3Y1dRm0qpOxtz0xxdVrDWCzusW1ig9BU8uezH5xf
         XmFQ==
X-Gm-Message-State: AOJu0YzC96qTWbKNj2xwY7Vwb33ElxB3IYAzWFf/qUks+cDMq1SJBKY1
	QFLKdFgia/SsVFtDhsGMJUullIwTd1fi2y1DcmK74sY92D0pLsd+pQ==
X-Google-Smtp-Source: AGHT+IHFmnI3m63V8A1f5olDym/aDP2+pSV6x5M2ggCKhXDdUCHt4WRgkKdME66otbr8ngKjPyLeWqR56HCqbEnnprOhZ1HaK2zY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:f54a:b0:1cc:20c8:323a with SMTP id
 h10-20020a170902f54a00b001cc20c8323amr1458437plf.1.1699619908297; Fri, 10 Nov
 2023 04:38:28 -0800 (PST)
Date: Fri, 10 Nov 2023 04:38:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e32f3c0609cb98d0@google.com>
Subject: [syzbot] [reiserfs?] possible deadlock in chmod_common (2)
From: syzbot <syzbot+83693dbba860b4f2e549@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8de1e7afcc1c Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=136e2560e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
dashboard link: https://syzkaller.appspot.com/bug?extid=83693dbba860b4f2e549
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f00907f9764/disk-8de1e7af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0502fe78c60d/vmlinux-8de1e7af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/192135168cc0/Image-8de1e7af.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+83693dbba860b4f2e549@syzkaller.appspotmail.com

REISERFS (device loop5): Using tea hash to sort names
REISERFS (device loop5): Created .reiserfs_priv - reserved for xattr storage.
======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc7-syzkaller-g8de1e7afcc1c #0 Not tainted
------------------------------------------------------
syz-executor.5/10863 is trying to acquire lock:
ffff00012f979d60 (&type->i_mutex_dir_key#18){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
ffff00012f979d60 (&type->i_mutex_dir_key#18){+.+.}-{3:3}, at: chmod_common+0x17c/0x418 fs/open.c:637

but task is already holding lock:
ffff00012d90a410 (sb_writers#26){.+.+}-{0:0}, at: mnt_want_write+0x44/0x9c fs/namespace.c:403

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_writers#26){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1571 [inline]
       sb_start_write+0x60/0x2ec include/linux/fs.h:1646
       mnt_want_write_file+0x64/0x1e8 fs/namespace.c:447
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
       reiserfs_fill_super+0x1bc0/0x2028 fs/reiserfs/super.c:2174
       mount_bdev+0x1e8/0x2b4 fs/super.c:1629
       get_super_block+0x44/0x58 fs/reiserfs/super.c:2601
       legacy_get_tree+0xd4/0x16c fs/fs_context.c:662
       vfs_get_tree+0x90/0x288 fs/super.c:1750
       do_new_mount+0x25c/0x8c8 fs/namespace.c:3335
       path_mount+0x590/0xe04 fs/namespace.c:3662
       do_mount fs/namespace.c:3675 [inline]
       __do_sys_mount fs/namespace.c:3884 [inline]
       __se_sys_mount fs/namespace.c:3861 [inline]
       __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3861
       __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
       el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

-> #0 (&type->i_mutex_dir_key#18){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x3370/0x75e8 kernel/locking/lockdep.c:5136
       lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
       down_write+0x50/0xc0 kernel/locking/rwsem.c:1573
       inode_lock include/linux/fs.h:802 [inline]
       chmod_common+0x17c/0x418 fs/open.c:637
       vfs_fchmod fs/open.c:659 [inline]
       __do_sys_fchmod fs/open.c:668 [inline]
       __se_sys_fchmod fs/open.c:662 [inline]
       __arm64_sys_fchmod+0xe0/0x150 fs/open.c:662
       __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
       invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
       el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
       do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
       el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
       el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

other info that might help us debug this:

Chain exists of:
  &type->i_mutex_dir_key#18 --> &sbi->lock --> sb_writers#26

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_writers#26);
                               lock(&sbi->lock);
                               lock(sb_writers#26);
  lock(&type->i_mutex_dir_key#18);

 *** DEADLOCK ***

1 lock held by syz-executor.5/10863:
 #0: ffff00012d90a410 (sb_writers#26){.+.+}-{0:0}, at: mnt_want_write+0x44/0x9c fs/namespace.c:403

stack backtrace:
CPU: 1 PID: 10863 Comm: syz-executor.5 Not tainted 6.6.0-rc7-syzkaller-g8de1e7afcc1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2060
 check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x3370/0x75e8 kernel/locking/lockdep.c:5136
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5753
 down_write+0x50/0xc0 kernel/locking/rwsem.c:1573
 inode_lock include/linux/fs.h:802 [inline]
 chmod_common+0x17c/0x418 fs/open.c:637
 vfs_fchmod fs/open.c:659 [inline]
 __do_sys_fchmod fs/open.c:668 [inline]
 __se_sys_fchmod fs/open.c:662 [inline]
 __arm64_sys_fchmod+0xe0/0x150 fs/open.c:662
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
netlink: 12 bytes leftover after parsing attributes in process `syz-executor.5'.
netlink: 32 bytes leftover after parsing attributes in process `syz-executor.5'.


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

