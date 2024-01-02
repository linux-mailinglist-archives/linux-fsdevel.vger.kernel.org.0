Return-Path: <linux-fsdevel+bounces-7065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B35582170E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 06:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93CC1F21A5E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 05:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C62110F;
	Tue,  2 Jan 2024 05:11:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672D7ECD
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 05:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fe765d63eso54144225ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jan 2024 21:11:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704172278; x=1704777078;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVe+cydX2QovZEBdgwMrlF6BxalR+VmGg5udIFEWvfM=;
        b=AzNZnJTQhQIZvewKh1ygLvsjyaTby3TG9tjgD/pFI6H3pHd5Dt+5MNMVf9H05IjsB+
         i3/PfWXdtB0VE3o1DTVmZ1E82XqHwWS29JF8i5Nbrr4Y0Fijt00uLNuchKF+syfe7F+s
         5bJ+j5ilDqgyaeqSWDPKmkLOjP/GW0nNo59dhLTiM1doYaovXXeKuwtGCxf4KlvDYfyZ
         Le3h7V18QZSWC1rNAVKdzmfM6dLU9wyM4oDAvC1RQpPRobP2/QV4diHLl8ABy51810fz
         ztsvaKhbhTYbtkHwsC3rtj07vHB9RmKl6yKWz1m6XQWaGI+jCCsNdqWyG9CtTOvb2gto
         2EsQ==
X-Gm-Message-State: AOJu0YyHnLb9dtBRHKshqKFKx7RcdbbRDaOykXg36rsnPCrSM2fism59
	Egq4UOmWEfLUfx3eWD0YD8pQUVotIz1rU3San9z4BPU9YCKpR8Q=
X-Google-Smtp-Source: AGHT+IEl1EXDVpJ7uc2J2iIM3JgcYrO6OpxfupKtTr/omz7Oem4Ls9bHdMhoP2tuSCrqsofNsCEYP39zQfJ5aPtqUBX4zReQQXdp
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174e:b0:35f:cca8:cd54 with SMTP id
 y14-20020a056e02174e00b0035fcca8cd54mr2929191ill.2.1704172278706; Mon, 01 Jan
 2024 21:11:18 -0800 (PST)
Date: Mon, 01 Jan 2024 21:11:18 -0800
In-Reply-To: <000000000000d95cf9060c5038e3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004efa57060def87be@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfs_extend_file (2)
From: syzbot <syzbot+41a88b825a315aac2254@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    610a9b8f49fb Linux 6.7-rc8
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d7c48de80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=247b5a935d307ee5
dashboard link: https://syzkaller.appspot.com/bug?extid=41a88b825a315aac2254
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1552fe19e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1419bcade80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e174ec82158f/disk-610a9b8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4bed5e1c1c26/vmlinux-610a9b8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4fd13b65ecb5/bzImage-610a9b8f.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/19a994dad52e/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/8c8468d1fd79/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+41a88b825a315aac2254@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
============================================
WARNING: possible recursive locking detected
6.7.0-rc8-syzkaller #0 Not tainted
--------------------------------------------
syz-executor279/5059 is trying to acquire lock:
ffff888079c100f8 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}, at: hfs_extend_file+0xa2/0xb10 fs/hfs/extent.c:397

but task is already holding lock:
ffff888079c10778 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}, at: hfs_extend_file+0xa2/0xb10 fs/hfs/extent.c:397

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&HFS_I(tree->inode)->extents_lock);
  lock(&HFS_I(tree->inode)->extents_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

5 locks held by syz-executor279/5059:
 #0: ffff88807a160418 (sb_writers#9){.+.+}-{0:0}, at: open_last_lookups fs/namei.c:3535 [inline]
 #0: ffff88807a160418 (sb_writers#9){.+.+}-{0:0}, at: path_openat+0x19f6/0x2c50 fs/namei.c:3776
 #1: ffff888079c10fa8 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
 #1: ffff888079c10fa8 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: open_last_lookups fs/namei.c:3543 [inline]
 #1: ffff888079c10fa8 (&type->i_mutex_dir_key#6){+.+.}-{3:3}, at: path_openat+0x8bd/0x2c50 fs/namei.c:3776
 #2: ffff88807a1640b0 (&tree->tree_lock){+.+.}-{3:3}, at: hfs_find_init+0x1b6/0x220 fs/hfs/bfind.c:30
 #3: ffff888079c10778 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}, at: hfs_extend_file+0xa2/0xb10 fs/hfs/extent.c:397
 #4: ffff88807a1620b0 (&tree->tree_lock/1){+.+.}-{3:3}, at: hfs_find_init+0x17f/0x220 fs/hfs/bfind.c:33

stack backtrace:
CPU: 0 PID: 5059 Comm: syz-executor279 Not tainted 6.7.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain kernel/locking/lockdep.c:3856 [inline]
 __lock_acquire+0x20f8/0x3b20 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x175/0x9d0 kernel/locking/mutex.c:747
 hfs_extend_file+0xa2/0xb10 fs/hfs/extent.c:397
 hfs_bmap_reserve+0x29c/0x370 fs/hfs/btree.c:234
 __hfs_ext_write_extent+0x3cb/0x520 fs/hfs/extent.c:121
 __hfs_ext_cache_extent fs/hfs/extent.c:174 [inline]
 hfs_ext_read_extent+0x805/0x9d0 fs/hfs/extent.c:202
 hfs_extend_file+0x4e0/0xb10 fs/hfs/extent.c:401
 hfs_bmap_reserve+0x29c/0x370 fs/hfs/btree.c:234
 hfs_cat_create+0x227/0x810 fs/hfs/catalog.c:104
 hfs_create+0x67/0xe0 fs/hfs/dir.c:202
 lookup_open.isra.0+0x1095/0x13b0 fs/namei.c:3477
 open_last_lookups fs/namei.c:3546 [inline]
 path_openat+0x922/0x2c50 fs/namei.c:3776
 do_filp_open+0x1de/0x430 fs/namei.c:3809
 do_sys_openat2+0x176/0x1e0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f776291b759
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f77628d7168 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f77629a46c8 RCX: 00007f776291b759
RDX: 000000000000275a RSI: 0000000020000000 RDI: 00000000ffffff9c
RBP: 00007f77629a46c0 R08: 00007f77629a46c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f77629a46cc
R13: 0000000000000006 R14: 00007ffd59ba19f0 R15: 00007ffd59ba1ad8
 </TASK>
hfs: request for non-existent node 16777216 in B*Tree
hfs: request for non-existent node 16777216 in B*Tree
hfs: inconsistency in B*Tree (5,0,1,0,1)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

