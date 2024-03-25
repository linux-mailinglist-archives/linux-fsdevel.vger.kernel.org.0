Return-Path: <linux-fsdevel+bounces-15254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CAB88B190
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 21:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693831C61B20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 20:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB571BF2F;
	Mon, 25 Mar 2024 20:35:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B811CAF
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398935; cv=none; b=NJEffA4C9yHCvX85AKFeythkghhKQXg96Vfnb7t5JyoVPtxh0urtb1OmWUbVPAD9PhP7R5e1spXJv88LYkhD5QxyMUO+nBMJNYK6AVZB7bKR2vB/jqShguGcCQZtIpD/YIei6sqwdREfv6RS/BvwvQ9iHQfxwi6XCrbPjVtVe5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398935; c=relaxed/simple;
	bh=37ggSoCxozB7Cyl2wDm3qsfZ27NlTK+vQFdVYfei4cA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B894i205fe1IklgXlWj79yiOoBqeWj5O1X5G2r/p3RcrMyB8Wu8JWvd6X/VjbV6JQmQs8XB2EfJG/1DNWqmhmZCtihSBnxLmYq/3dRozycBak2PxQbzoLYCZBKF9tqWlYfBKim8LHz+SeJ5d8W+1dIDACYYBlLi7P1ECpa76d9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so456025839f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 13:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711398933; x=1712003733;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlAyYtjNjtQAH1Vx7mUhHpGkqcRI6aawQgkDYlzv1gc=;
        b=rmbW3cDaiDkTFuWzpjhMjJHCz8Ek1MSTZr0MdLq0Txlw2z1thxV/uMCngZVGSg/HoJ
         q+CdOmUoyGkcy6OCoRk1NFQgLRQHHBZBUiHzxG7OKHkvW+hxzwZYZ4kNH+JkOfsJkweu
         rspCF2t0EM0QMfM3w5VUk3hKUbiBQTXsAqjbrn+gqyZhyVblLtEHe2MerJeS9464o30z
         bVm+crBdl5AHQrTqZnXP4htcGr8ACnehlX6mDAt4X0ZyQa0vRZiY7yJ9tfxwfkDpAYCw
         zMAOGGOajzrfPeUBWQdFUcQY4u2V3zyryeTvMrIxffUGRxq01qnBo7BTVR/N7U0j5ePE
         If1g==
X-Forwarded-Encrypted: i=1; AJvYcCU+kUQ9y+GTRKCU7fb30yxpgBjMjCufdSnbCxeyBr6SAfyxYNZ4IWfBvPrvypbDzTaoVw+AGbqRLIsNslRiOrSlvF7iiGL/1elLRWny2g==
X-Gm-Message-State: AOJu0Yy08/z15/S7IVDJmk/vHdmWsj7b5FPl0N2M7enrc2OhYUyV73V1
	KNJy4WJt3Z1v35U+YXGT+ft/7GaIEJlHf0UetgNj0JuodCKV35tLKwQ0+isnlrNpDtFAuzXM6DK
	hM/ZkJkYtsYAur0RGHnxibn6PGMPYaXVmvay2T+wNsSvNmcLUHf00qdQ=
X-Google-Smtp-Source: AGHT+IFxotLuc/2BLtMHKiX6jGV63KFZ6RAkinwENKZEE6zwN0DBFvFxwybVEETyWhX1Mlw53tOm4UaVqd3szVXuv0ObRuXoX56F
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d84:b0:368:77f0:7751 with SMTP id
 h4-20020a056e021d8400b0036877f07751mr444046ila.6.1711398933187; Mon, 25 Mar
 2024 13:35:33 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:35:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b5ec50614821d6f@google.com>
Subject: [syzbot] [xfs?] possible deadlock in xfs_qm_dqget
From: syzbot <syzbot+fa52b47267f5cac8c654@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102618b1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=fa52b47267f5cac8c654
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa52b47267f5cac8c654@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
------------------------------------------------------
syz-executor.5/6047 is trying to acquire lock:
ffffffff8e21f720 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:303 [inline]
ffffffff8e21f720 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:3746 [inline]
ffffffff8e21f720 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3827 [inline]
ffffffff8e21f720 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc+0x48/0x340 mm/slub.c:3852

but task is already holding lock:
ffff88801f58d958 (&qinf->qi_tree_lock){+.+.}-{3:3}, at: xfs_qm_dqget_cache_insert fs/xfs/xfs_dquot.c:825 [inline]
ffff88801f58d958 (&qinf->qi_tree_lock){+.+.}-{3:3}, at: xfs_qm_dqget+0x2c4/0x640 fs/xfs/xfs_dquot.c:901

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&qinf->qi_tree_lock){+.+.}-{3:3}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       xfs_qm_dqfree_one+0x66/0x170 fs/xfs/xfs_qm.c:1654
       xfs_qm_shrink_scan+0x33f/0x400 fs/xfs/xfs_qm.c:531
       do_shrink_slab+0x6d2/0x1140 mm/shrinker.c:435
       shrink_slab+0x1092/0x14d0 mm/shrinker.c:662
       shrink_one+0x423/0x7f0 mm/vmscan.c:4767
       shrink_many mm/vmscan.c:4828 [inline]
       lru_gen_shrink_node mm/vmscan.c:4929 [inline]
       shrink_node+0x37b8/0x3e70 mm/vmscan.c:5888
       kswapd_shrink_node mm/vmscan.c:6696 [inline]
       balance_pgdat mm/vmscan.c:6886 [inline]
       kswapd+0x17d1/0x36e0 mm/vmscan.c:7146
       kthread+0x2f2/0x390 kernel/kthread.c:388
       ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __fs_reclaim_acquire mm/page_alloc.c:3692 [inline]
       fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3706
       might_alloc include/linux/sched/mm.h:303 [inline]
       slab_pre_alloc_hook mm/slub.c:3746 [inline]
       slab_alloc_node mm/slub.c:3827 [inline]
       kmem_cache_alloc+0x48/0x340 mm/slub.c:3852
       radix_tree_node_alloc+0x8b/0x3c0 lib/radix-tree.c:276
       radix_tree_extend+0x148/0x5c0 lib/radix-tree.c:425
       __radix_tree_create lib/radix-tree.c:613 [inline]
       radix_tree_insert+0x15c/0x680 lib/radix-tree.c:712
       xfs_qm_dqget_cache_insert fs/xfs/xfs_dquot.c:826 [inline]
       xfs_qm_dqget+0x2d4/0x640 fs/xfs/xfs_dquot.c:901
       xfs_qm_vop_dqalloc+0x5a3/0xef0 fs/xfs/xfs_qm.c:1730
       xfs_setattr_nonsize+0x410/0xea0 fs/xfs/xfs_iops.c:707
       xfs_vn_setattr+0x2d1/0x320 fs/xfs/xfs_iops.c:1027
       notify_change+0xb9f/0xe70 fs/attr.c:497
       chown_common+0x501/0x850 fs/open.c:790
       do_fchownat+0x16d/0x250 fs/open.c:821
       __do_sys_chown fs/open.c:841 [inline]
       __se_sys_chown fs/open.c:839 [inline]
       __x64_sys_chown+0x82/0x90 fs/open.c:839
       do_syscall_64+0xfd/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&qinf->qi_tree_lock);
                               lock(fs_reclaim);
                               lock(&qinf->qi_tree_lock);
  lock(fs_reclaim);

 *** DEADLOCK ***

3 locks held by syz-executor.5/6047:
 #0: ffff888028a02420 (sb_writers#16){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #1: ffff8880b4d650b8 (&inode->i_sb->s_type->i_mutex_dir_key){++++}-{3:3}, at: inode_lock include/linux/fs.h:793 [inline]
 #1: ffff8880b4d650b8 (&inode->i_sb->s_type->i_mutex_dir_key){++++}-{3:3}, at: chown_common+0x3e1/0x850 fs/open.c:780
 #2: ffff88801f58d958 (&qinf->qi_tree_lock){+.+.}-{3:3}, at: xfs_qm_dqget_cache_insert fs/xfs/xfs_dquot.c:825 [inline]
 #2: ffff88801f58d958 (&qinf->qi_tree_lock){+.+.}-{3:3}, at: xfs_qm_dqget+0x2c4/0x640 fs/xfs/xfs_dquot.c:901

stack backtrace:
CPU: 0 PID: 6047 Comm: syz-executor.5 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
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
 __fs_reclaim_acquire mm/page_alloc.c:3692 [inline]
 fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3706
 might_alloc include/linux/sched/mm.h:303 [inline]
 slab_pre_alloc_hook mm/slub.c:3746 [inline]
 slab_alloc_node mm/slub.c:3827 [inline]
 kmem_cache_alloc+0x48/0x340 mm/slub.c:3852
 radix_tree_node_alloc+0x8b/0x3c0 lib/radix-tree.c:276
 radix_tree_extend+0x148/0x5c0 lib/radix-tree.c:425
 __radix_tree_create lib/radix-tree.c:613 [inline]
 radix_tree_insert+0x15c/0x680 lib/radix-tree.c:712
 xfs_qm_dqget_cache_insert fs/xfs/xfs_dquot.c:826 [inline]
 xfs_qm_dqget+0x2d4/0x640 fs/xfs/xfs_dquot.c:901
 xfs_qm_vop_dqalloc+0x5a3/0xef0 fs/xfs/xfs_qm.c:1730
 xfs_setattr_nonsize+0x410/0xea0 fs/xfs/xfs_iops.c:707
 xfs_vn_setattr+0x2d1/0x320 fs/xfs/xfs_iops.c:1027
 notify_change+0xb9f/0xe70 fs/attr.c:497
 chown_common+0x501/0x850 fs/open.c:790
 do_fchownat+0x16d/0x250 fs/open.c:821
 __do_sys_chown fs/open.c:841 [inline]
 __se_sys_chown fs/open.c:839 [inline]
 __x64_sys_chown+0x82/0x90 fs/open.c:839
 do_syscall_64+0xfd/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fe9a027dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe99f5ff0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000005c
RAX: ffffffffffffffda RBX: 00007fe9a03abf80 RCX: 00007fe9a027dda9
RDX: 0000000039323420 RSI: 000000000000ee00 RDI: 0000000020000140
RBP: 00007fe9a02ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fe9a03abf80 R15: 00007ffd68c11948
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

