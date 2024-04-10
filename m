Return-Path: <linux-fsdevel+bounces-16524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEF289EA2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 07:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5377B21A8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 05:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4D61CD3A;
	Wed, 10 Apr 2024 05:53:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFFB64A
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712728403; cv=none; b=YZ7rlGUPSzrYz1XmEgxJICb/P3u37o/P/NzmI5IBynZuSrvFEWdUJ4htARiqhJM1YeWkZhyvu3r1EQtn6VHHUzU+z6XvJKQ1dQ4lViM/cXmdiK8uLz9RxV1t+vVLMjldzlfF68YCiNp3d75+EvQgn3Hw78/MGgijzfB70Q7RtdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712728403; c=relaxed/simple;
	bh=BbBc/BQ5DImgORKKmiL87W83nYZ72PH9KoSuv6ECsI4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MKfXM936iMX5lKqW7kW9/UZiPUBGJ9//xVIBSiQaWvzscymyM1D/oLvuJbE4A71GWxzmp6wglUgrxU8Pz2jac5v1iNJWH+Vi7oR2OcI2PpUPmlcAIVNECzAyI3371xgOq4HYSENAhviRVKEy0ZvN7TfkPm2yURLTNXq3CzoywVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3699565f54fso62529295ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 22:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712728401; x=1713333201;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4vN47NTkxExdaEYUsqQQbRl6c378RY84tMj+NMBeuVs=;
        b=tqEoqpAc+D432/l1ArD9gXY7Go/hNv1D7zmHwwnN5t+qjWLGT5EXHC54ToxnASjBAQ
         txe6E+6NQbXF9B9x15Wv20Q1ijK4nWhoWbK0EvH8cjA094wSXSRIH7AlIKIS0cRhpq+U
         FUW8HAZk/tAEjxrT2yZ7oxip+3C1MLYivvbP8lFUCFbKa4qlpSHMMYssng3u6ZpRFTsS
         y6B2qFZj8/+XjebMVn/yrNB5OX06v2N0TXpejUaihbFMmLDN7mGFsj81jYm5p7OHB0S7
         XwmAWjRxAK1o5qnyZN4vV3RYnNvQRQjV0Rse0HXj27qNe9LXsXtQHhqRWEBSERZy4pW1
         1mUw==
X-Forwarded-Encrypted: i=1; AJvYcCVmE3wDVBEGx5d3gtNhadwZ/M0Ya+X8uV1YHr+AMmOHyUNOVUvsvqWduf7Zm0Am+w2LMf8R8bynGH1zBtM6ahRFfOYPlXFEMPfmLECKSg==
X-Gm-Message-State: AOJu0YzkdMSyxkA84rORzIoEU5/+ZpY9xcPIbD27zALOlomJFZ2bgOJ1
	IqU0SGxrGUTBzW68sHCT/k/S8wNAZ/etNWCkPMl9/19g5m5fnNgM+4SAe0cPeLRnah7kuahqWdF
	Y10pkgES15GCxGTfIwFEsVyxdSnVoWvVCda+7tL1zUeuC0pQNdKCngag=
X-Google-Smtp-Source: AGHT+IE7nTgkd8wtZQH9jQZYw9r2bg79b+KmAC4v1fS+OiDlfoftjLRDJLf+wx8YXJopaKz2WGDz+yEWLW/VlON5Fd7HhZfCYDKF
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d04:b0:36a:36e7:6c01 with SMTP id
 i4-20020a056e021d0400b0036a36e76c01mr61302ila.0.1712728400782; Tue, 09 Apr
 2024 22:53:20 -0700 (PDT)
Date: Tue, 09 Apr 2024 22:53:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ecf68e0615b7a737@google.com>
Subject: [syzbot] [jffs2?] possible deadlock in jffs2_do_clear_inode
From: syzbot <syzbot+88a60d3f927e2460d4ac@syzkaller.appspotmail.com>
To: dwmw2@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, richard@nod.at, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e8b0ccb2a787 Merge tag '9p-for-6.9-rc3' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f9ee15180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c2c72b264636e25
dashboard link: https://syzkaller.appspot.com/bug?extid=88a60d3f927e2460d4ac
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-e8b0ccb2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/36cfb6ee2b7e/vmlinux-e8b0ccb2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/86b45977fab6/bzImage-e8b0ccb2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+88a60d3f927e2460d4ac@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc2-syzkaller-00207-ge8b0ccb2a787 #0 Not tainted
------------------------------------------------------
kswapd1/112 is trying to acquire lock:
ffff888064068640 (&f->sem){+.+.}-{3:3}, at: jffs2_do_clear_inode+0x5a/0x470 fs/jffs2/readinode.c:1419

but task is already holding lock:
ffffffff8d939440 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x166/0x1a10 mm/vmscan.c:6782

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3712
       might_alloc include/linux/sched/mm.h:312 [inline]
       slab_pre_alloc_hook mm/slub.c:3746 [inline]
       slab_alloc_node mm/slub.c:3827 [inline]
       kmem_cache_alloc+0x4f/0x320 mm/slub.c:3852
       jffs2_do_read_inode+0x3e8/0x670 fs/jffs2/readinode.c:1372
       jffs2_iget+0x2c3/0xed0 fs/jffs2/fs.c:277
       jffs2_do_fill_super+0x44b/0xa60 fs/jffs2/fs.c:577
       jffs2_fill_super+0x283/0x370 fs/jffs2/super.c:289
       mtd_get_sb+0x2ce/0x490 drivers/mtd/mtdsuper.c:57
       mtd_get_sb_by_nr drivers/mtd/mtdsuper.c:88 [inline]
       get_tree_mtd+0x6ce/0x860 drivers/mtd/mtdsuper.c:141
       vfs_get_tree+0x8f/0x380 fs/super.c:1779
       do_new_mount fs/namespace.c:3352 [inline]
       path_mount+0x6e1/0x1f10 fs/namespace.c:3679
       do_mount fs/namespace.c:3692 [inline]
       __do_sys_mount fs/namespace.c:3898 [inline]
       __se_sys_mount fs/namespace.c:3875 [inline]
       __ia32_sys_mount+0x295/0x320 fs/namespace.c:3875
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x7a/0x120 arch/x86/entry/common.c:321
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:346
       entry_SYSENTER_compat_after_hwframe+0x7f/0x89

-> #0 (&f->sem){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       jffs2_do_clear_inode+0x5a/0x470 fs/jffs2/readinode.c:1419
       evict+0x2ed/0x6c0 fs/inode.c:667
       dispose_list+0x117/0x1e0 fs/inode.c:700
       prune_icache_sb+0xeb/0x150 fs/inode.c:885
       super_cache_scan+0x375/0x550 fs/super.c:223
       do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0xa87/0x1310 mm/shrinker.c:626
       shrink_one+0x493/0x7c0 mm/vmscan.c:4774
       shrink_many mm/vmscan.c:4835 [inline]
       lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4935
       shrink_node mm/vmscan.c:5894 [inline]
       kswapd_shrink_node mm/vmscan.c:6704 [inline]
       balance_pgdat+0x10d1/0x1a10 mm/vmscan.c:6895
       kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
       kthread+0x2c1/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&f->sem);
                               lock(fs_reclaim);
  lock(&f->sem);

 *** DEADLOCK ***

2 locks held by kswapd1/112:
 #0: ffffffff8d939440 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x166/0x1a10 mm/vmscan.c:6782
 #1: ffff88805e1aa0e0 (&type->s_umount_key#88){++++}-{3:3}, at: super_trylock_shared fs/super.c:561 [inline]
 #1: ffff88805e1aa0e0 (&type->s_umount_key#88){++++}-{3:3}, at: super_cache_scan+0x96/0x550 fs/super.c:196

stack backtrace:
CPU: 1 PID: 112 Comm: kswapd1 Not tainted 6.9.0-rc2-syzkaller-00207-ge8b0ccb2a787 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 jffs2_do_clear_inode+0x5a/0x470 fs/jffs2/readinode.c:1419
 evict+0x2ed/0x6c0 fs/inode.c:667
 dispose_list+0x117/0x1e0 fs/inode.c:700
 prune_icache_sb+0xeb/0x150 fs/inode.c:885
 super_cache_scan+0x375/0x550 fs/super.c:223
 do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
 shrink_slab_memcg mm/shrinker.c:548 [inline]
 shrink_slab+0xa87/0x1310 mm/shrinker.c:626
 shrink_one+0x493/0x7c0 mm/vmscan.c:4774
 shrink_many mm/vmscan.c:4835 [inline]
 lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4935
 shrink_node mm/vmscan.c:5894 [inline]
 kswapd_shrink_node mm/vmscan.c:6704 [inline]
 balance_pgdat+0x10d1/0x1a10 mm/vmscan.c:6895
 kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
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

