Return-Path: <linux-fsdevel+bounces-25917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39190951CC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 16:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67A71F240D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 14:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB681B4C24;
	Wed, 14 Aug 2024 14:12:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF331B32B1
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644748; cv=none; b=PKi3nydMCIcqMO+/OFRo0Q8vdQtVri5iNwmZ4bRrD6+up7v11tzDRLMIPffITFuMTgwLkHJ3StJ2U4QYe6hV3aRkxpWV0sp+xZSwWEGTGbvRv4GFeVpD++bQU+iA8kx6Pg69+Sc+W1RSgpA/C008rPeVDJfnuxA1uMcPuEr8/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644748; c=relaxed/simple;
	bh=uW+YoEhZFUiapwpn9UGKynC673wpNaED/j666kFODuM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T6SU4Efsyf4dCvXAF9qbJbBL3D1yZl/UJ+EUXGopjCojCM4MrcKVu9Qa9keRCblPfQqCYPp8KbJLqtkorUKc1Pge51rZbncO2mIof6XIDZ13XVliIPfqU2gn8/jFYlwfYwu7RRmZPBef6TTZoXFbdhjtVcB412Rq1f9g/QOLTcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39aeccc6479so90660825ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 07:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723644745; x=1724249545;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boSZ5Eh0ApCoMT7BRJdc4bM7Sxny0/h7zzQAm+3Vt6c=;
        b=AkbIPc0q1K4g4pAPJiLmPgg7zWe7Rq6plVqibqiSmRKij+TDCltVL+qzNjGUzAOZyX
         XwYSbvyJUQf5NMd++sGHbr4ibdU9QoNTycmz3TJQlxB84K0txjXhQ7CrydOtDt7IwwD/
         mGzw3nbBKSljMAwTK0h97VNd7323MS5t4DlrB7DsY0k+S9kgnGfIPBg3IRnqr8Ew9kgq
         HVdIMeqUszQcz6wMt/SEVX6tCY6LXDuVg2+aotrwCbxumOKPwloA7PysCNjTQ2js9H2a
         WVpCQFOZoPtDcYGnlOMGu0zBR0OvzF5f7sO9oVek/HqgO7fbEDL9XT8jXhV/4wdftmHI
         etMA==
X-Forwarded-Encrypted: i=1; AJvYcCWy7j+zXvDJShrZfulOFtEDzwL4F62ssTYRydGIwZBUYDdfq1fUC/mQ/rtkrRBfY9Lol9AfneFP9y01Bht92n3fM1z8SUVu+Y4hPGMtqg==
X-Gm-Message-State: AOJu0Yy4xP4fnpYDJg4RHlioFC40qKDWiRyz4RO4NQ45r0siF2oLIHMJ
	AbiUQBNT4nECPKMS/p2wMiDWHyrYIggQZxkrTQIicI4oXOhOneoGVaUZY2l7gU0DhsUCw61i+3g
	2USJ00d9XjTI/kMV+FrNrwgqzrveuWJfwMrDZ5cUwnxQ/Xr4IiyGHMNU=
X-Google-Smtp-Source: AGHT+IELeklnhNoHXCFg6Uiceu3dfzjxrrOfGVjgdTVPB/RdUqPx41CymyxEOG63cw+z+/4atDuBo20/2E7NuwFfk9t9t6XI/b3k
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34ab:b0:4c2:8a0c:380d with SMTP id
 8926c6da1cb9f-4cab09ccfe3mr154285173.3.1723644745484; Wed, 14 Aug 2024
 07:12:25 -0700 (PDT)
Date: Wed, 14 Aug 2024 07:12:25 -0700
In-Reply-To: <000000000000e33add0616358204@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c61f9a061fa550db@google.com>
Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_icwalk_ag (2)
From: syzbot <syzbot+4248e91deb3db78358a2@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    6b0f8db921ab Merge tag 'execve-v6.11-rc4' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149dea91980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=801d05d1ea4be1b8
dashboard link: https://syzkaller.appspot.com/bug?extid=4248e91deb3db78358a2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10aa45cb980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b59205980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-6b0f8db9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b407dbb66544/vmlinux-6b0f8db9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5c1cf0f1b692/bzImage-6b0f8db9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ddaad63422d8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4248e91deb3db78358a2@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc3-syzkaller-00013-g6b0f8db921ab #0 Not tainted
------------------------------------------------------
kswapd0/80 is trying to acquire lock:
ffff88803ba5a7d8 (&xfs_nondir_ilock_class#3){++++}-{3:3}, at: xfs_reclaim_inode fs/xfs/xfs_icache.c:944 [inline]
ffff88803ba5a7d8 (&xfs_nondir_ilock_class#3){++++}-{3:3}, at: xfs_icwalk_process_inode fs/xfs/xfs_icache.c:1630 [inline]
ffff88803ba5a7d8 (&xfs_nondir_ilock_class#3){++++}-{3:3}, at: xfs_icwalk_ag+0x120e/0x1ad0 fs/xfs/xfs_icache.c:1712

but task is already holding lock:
ffffffff8ea2fce0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6841 [inline]
ffffffff8ea2fce0 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbb4/0x35a0 mm/vmscan.c:7223

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __fs_reclaim_acquire mm/page_alloc.c:3823 [inline]
       fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3837
       might_alloc include/linux/sched/mm.h:334 [inline]
       slab_pre_alloc_hook mm/slub.c:3939 [inline]
       slab_alloc_node mm/slub.c:4017 [inline]
       __do_kmalloc_node mm/slub.c:4157 [inline]
       __kmalloc_noprof+0xa9/0x400 mm/slub.c:4170
       kmalloc_noprof include/linux/slab.h:685 [inline]
       xfs_attr_shortform_list+0x753/0x1900 fs/xfs/xfs_attr_list.c:117
       xfs_attr_list+0x1d0/0x270 fs/xfs/xfs_attr_list.c:595
       xfs_vn_listxattr+0x1d2/0x2c0 fs/xfs/xfs_xattr.c:341
       vfs_listxattr fs/xattr.c:493 [inline]
       listxattr+0x107/0x290 fs/xattr.c:841
       path_listxattr fs/xattr.c:865 [inline]
       __do_sys_listxattr fs/xattr.c:877 [inline]
       __se_sys_listxattr fs/xattr.c:874 [inline]
       __x64_sys_listxattr+0x173/0x230 fs/xattr.c:874
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&xfs_nondir_ilock_class#3){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1695
       xfs_reclaim_inode fs/xfs/xfs_icache.c:944 [inline]
       xfs_icwalk_process_inode fs/xfs/xfs_icache.c:1630 [inline]
       xfs_icwalk_ag+0x120e/0x1ad0 fs/xfs/xfs_icache.c:1712
       xfs_icwalk fs/xfs/xfs_icache.c:1761 [inline]
       xfs_reclaim_inodes_nr+0x2d4/0x3e0 fs/xfs/xfs_icache.c:1010
       super_cache_scan+0x40f/0x4b0 fs/super.c:227
       do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
       shrink_slab+0x1090/0x14c0 mm/shrinker.c:662
       shrink_one+0x43b/0x850 mm/vmscan.c:4815
       shrink_many mm/vmscan.c:4876 [inline]
       lru_gen_shrink_node mm/vmscan.c:4954 [inline]
       shrink_node+0x3799/0x3de0 mm/vmscan.c:5934
       kswapd_shrink_node mm/vmscan.c:6762 [inline]
       balance_pgdat mm/vmscan.c:6954 [inline]
       kswapd+0x1bcd/0x35a0 mm/vmscan.c:7223
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&xfs_nondir_ilock_class#3);
                               lock(fs_reclaim);
  lock(&xfs_nondir_ilock_class#3);

 *** DEADLOCK ***

2 locks held by kswapd0/80:
 #0: ffffffff8ea2fce0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6841 [inline]
 #0: ffffffff8ea2fce0 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbb4/0x35a0 mm/vmscan.c:7223
 #1: ffff88803a4000e0 (&type->s_umount_key#44){.+.+}-{3:3}, at: super_trylock_shared fs/super.c:562 [inline]
 #1: ffff88803a4000e0 (&type->s_umount_key#44){.+.+}-{3:3}, at: super_cache_scan+0x94/0x4b0 fs/super.c:196

stack backtrace:
CPU: 0 UID: 0 PID: 80 Comm: kswapd0 Not tainted 6.11.0-rc3-syzkaller-00013-g6b0f8db921ab #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1695
 xfs_reclaim_inode fs/xfs/xfs_icache.c:944 [inline]
 xfs_icwalk_process_inode fs/xfs/xfs_icache.c:1630 [inline]
 xfs_icwalk_ag+0x120e/0x1ad0 fs/xfs/xfs_icache.c:1712
 xfs_icwalk fs/xfs/xfs_icache.c:1761 [inline]
 xfs_reclaim_inodes_nr+0x2d4/0x3e0 fs/xfs/xfs_icache.c:1010
 super_cache_scan+0x40f/0x4b0 fs/super.c:227
 do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
 shrink_slab+0x1090/0x14c0 mm/shrinker.c:662
 shrink_one+0x43b/0x850 mm/vmscan.c:4815
 shrink_many mm/vmscan.c:4876 [inline]
 lru_gen_shrink_node mm/vmscan.c:4954 [inline]
 shrink_node+0x3799/0x3de0 mm/vmscan.c:5934
 kswapd_shrink_node mm/vmscan.c:6762 [inline]
 balance_pgdat mm/vmscan.c:6954 [inline]
 kswapd+0x1bcd/0x35a0 mm/vmscan.c:7223
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

