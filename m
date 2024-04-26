Return-Path: <linux-fsdevel+bounces-17854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198A88B2FAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 07:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4622284293
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 05:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0963813A3E1;
	Fri, 26 Apr 2024 05:15:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D6913A240
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 05:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714108531; cv=none; b=uLnAtu6TxZbVx7gba9XZeFD7wKFnZWsLgmGR8FfhGejEbWWcCvNEHivbFX3D+CWe/ems0nhpTSWF5ksEBgJqC7D1fMcOudmsu2ISu3se2R0UMuYiu2+eDWak11dJ9kbCPF3o6raGmse4sQGQWLU3f49CAOU+00103VPoGvOiOPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714108531; c=relaxed/simple;
	bh=baHPmeqi++OzxY0/EDR1/7GQxx7Oc7qHLuRLqj252aM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r39a811i86d4mMPS+X7er7aQZJU/C7ODNNdV3HJzrYRH2tNtncSE7B/eRW4piJ0uFqPjDAKvpb6V8kZWvrRtskCr9BNGpgmvqmLSH5lAGnq/q0bwYyUK7rGajSF26xbCxTxf994P9IE7KG1EsDj8rGMmNWe44VID9TRZOm+4wpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7de2de148f9so167247939f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 22:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714108529; x=1714713329;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ykNK5VhsI+dP9tKxCFYw3VBfRAQeinv0rad6NPmo4qE=;
        b=Yq+E7oE0q1x2zZ9M0ibMghfoeGO1K4wu8Yvkqiv8BoeVTIzzrWjDJP/hBD5xMJ9/7G
         7uwKa78+HV00LZ3nYkQ245mGxCycET3wL/IrCGSxvPzhEgr/Vb+tkHZXgsGtV/cMW4O0
         7TK2DUcJIaEe00GCoQA/kNEaHMkX83JWU3T+0YJMI9p+/ULdPvRF/EbqUoIC7aRJUi5R
         H5g0rzojsC7MpEApzwuPL7jM8qePHiovkx7rJa2xpSY6sCYy63sLRMhE0yMK8u85aIf3
         ISi7xJBYcXLYDFZNax9+upR1RUFRAueawCk2wJloqJoFnIZGHZtMeuBfd1SVf62L/epv
         mNuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY06jMpqmqt/8dWJKnQ7xRx7U436hHI3LCCcbRD1O/gDIhrZto/7xXNXfPXjxCTRpNygQolR1ARA/574zkzUcPN7d+3afa3KYtwTvP7A==
X-Gm-Message-State: AOJu0YzbVKkvWsga1ndxpTPtj23ooxIH5ZMSFSCVY8jjqI03pRF0GN94
	mgBpVaJsxuT6wgxQVAK6HOv6F1sTz2mMoE7Z/QKcez2pHMlUQCVzHgP7jGOMwLCbKFIUN5nfgtQ
	z5CT5bVxqfxAQAFiahbh6P1O6xl3FxJax1hTiZf0RZ50jnR46jiebqgo=
X-Google-Smtp-Source: AGHT+IFBKFmYe5laHydCAqQAoeaWdcBuRyGTbku/3XoPsQe4bRsTG1szZALj8hXm8DhrnHGu7dMNxvO5xY50AgAMkDYBEwH96pYK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4116:b0:485:549f:eed8 with SMTP id
 ay22-20020a056638411600b00485549feed8mr84862jab.0.1714108529299; Thu, 25 Apr
 2024 22:15:29 -0700 (PDT)
Date: Thu, 25 Apr 2024 22:15:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fee02e0616f8fdff@google.com>
Subject: [syzbot] [xfs?] possible deadlock in xfs_fs_dirty_inode
From: syzbot <syzbot+1619d847a7b9ba3a9137@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3b68086599f8 Merge tag 'sched_urgent_for_v6.9_rc5' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158206bb180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f47e5e015c177e57
dashboard link: https://syzkaller.appspot.com/bug?extid=1619d847a7b9ba3a9137
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/caa90b55d476/disk-3b680865.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/17940f1c5e8f/vmlinux-3b680865.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b03bd6929a1c/bzImage-3b680865.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1619d847a7b9ba3a9137@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc4-syzkaller-00274-g3b68086599f8 #0 Not tainted
------------------------------------------------------
kswapd0/81 is trying to acquire lock:
ffff8881a895a610 (sb_internal#3){.+.+}-{0:0}, at: xfs_fs_dirty_inode+0x158/0x250 fs/xfs/xfs_super.c:689

but task is already holding lock:
ffffffff8e428e80 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6782 [inline]
ffffffff8e428e80 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xb20/0x30c0 mm/vmscan.c:7164

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
       fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3712
       might_alloc include/linux/sched/mm.h:312 [inline]
       slab_pre_alloc_hook mm/slub.c:3746 [inline]
       slab_alloc_node mm/slub.c:3827 [inline]
       kmalloc_trace+0x47/0x360 mm/slub.c:3992
       kmalloc include/linux/slab.h:628 [inline]
       add_stack_record_to_list mm/page_owner.c:177 [inline]
       inc_stack_record_count mm/page_owner.c:219 [inline]
       __set_page_owner+0x561/0x810 mm/page_owner.c:334
       set_page_owner include/linux/page_owner.h:32 [inline]
       post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
       prep_new_page mm/page_alloc.c:1541 [inline]
       get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
       __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
       __alloc_pages_node include/linux/gfp.h:238 [inline]
       alloc_pages_node include/linux/gfp.h:261 [inline]
       alloc_slab_page+0x5f/0x160 mm/slub.c:2175
       allocate_slab mm/slub.c:2338 [inline]
       new_slab+0x84/0x2f0 mm/slub.c:2391
       ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
       __slab_alloc mm/slub.c:3610 [inline]
       __slab_alloc_node mm/slub.c:3663 [inline]
       slab_alloc_node mm/slub.c:3835 [inline]
       kmem_cache_alloc+0x252/0x340 mm/slub.c:3852
       kmem_cache_zalloc include/linux/slab.h:739 [inline]
       xfs_btree_alloc_cursor fs/xfs/libxfs/xfs_btree.h:679 [inline]
       xfs_refcountbt_init_cursor+0x65/0x2a0 fs/xfs/libxfs/xfs_refcount_btree.c:367
       xfs_reflink_find_shared fs/xfs/xfs_reflink.c:147 [inline]
       xfs_reflink_trim_around_shared+0x53a/0x9d0 fs/xfs/xfs_reflink.c:194
       xfs_buffered_write_iomap_begin+0xebf/0x1b40 fs/xfs/xfs_iomap.c:1062
       iomap_iter+0x691/0xf60 fs/iomap/iter.c:91
       iomap_file_unshare+0x17a/0x710 fs/iomap/buffered-io.c:1364
       xfs_reflink_unshare+0x173/0x5f0 fs/xfs/xfs_reflink.c:1710
       xfs_file_fallocate+0x87c/0xd00 fs/xfs/xfs_file.c:1082
       vfs_fallocate+0x564/0x6c0 fs/open.c:330
       ksys_fallocate fs/open.c:353 [inline]
       __do_sys_fallocate fs/open.c:361 [inline]
       __se_sys_fallocate fs/open.c:359 [inline]
       __x64_sys_fallocate+0xbd/0x110 fs/open.c:359
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&xfs_nondir_ilock_class#3){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1695
       xfs_dquot_disk_alloc+0x399/0xe50 fs/xfs/xfs_dquot.c:332
       xfs_qm_dqread+0x1a3/0x650 fs/xfs/xfs_dquot.c:693
       xfs_qm_dqget+0x2bb/0x6f0 fs/xfs/xfs_dquot.c:905
       xfs_qm_quotacheck_dqadjust+0xea/0x5a0 fs/xfs/xfs_qm.c:1096
       xfs_qm_dqusage_adjust+0x4db/0x6f0 fs/xfs/xfs_qm.c:1215
       xfs_iwalk_ag_recs+0x4e0/0x860 fs/xfs/xfs_iwalk.c:213
       xfs_iwalk_run_callbacks+0x218/0x470 fs/xfs/xfs_iwalk.c:372
       xfs_iwalk_ag+0xa39/0xb50 fs/xfs/xfs_iwalk.c:478
       xfs_iwalk_ag_work+0xfb/0x1b0 fs/xfs/xfs_iwalk.c:620
       xfs_pwork_work+0x7f/0x190 fs/xfs/xfs_pwork.c:47
       process_one_work kernel/workqueue.c:3254 [inline]
       process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
       worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
       kthread+0x2f0/0x390 kernel/kthread.c:388
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (sb_internal#3){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1664 [inline]
       sb_start_intwrite include/linux/fs.h:1847 [inline]
       xfs_trans_alloc+0xe5/0x830 fs/xfs/xfs_trans.c:264
       xfs_fs_dirty_inode+0x158/0x250 fs/xfs/xfs_super.c:689
       __mark_inode_dirty+0x325/0xe20 fs/fs-writeback.c:2477
       mark_inode_dirty_sync include/linux/fs.h:2410 [inline]
       iput+0x1fe/0x930 fs/inode.c:1764
       __dentry_kill+0x20d/0x630 fs/dcache.c:603
       shrink_kill+0xa9/0x2c0 fs/dcache.c:1048
       shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1075
       prune_dcache_sb+0x10f/0x180 fs/dcache.c:1156
       super_cache_scan+0x34f/0x4b0 fs/super.c:221
       do_shrink_slab+0x705/0x1160 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0x883/0x14d0 mm/shrinker.c:626
       shrink_node_memcgs mm/vmscan.c:5875 [inline]
       shrink_node+0x11f5/0x2d60 mm/vmscan.c:5908
       kswapd_shrink_node mm/vmscan.c:6704 [inline]
       balance_pgdat mm/vmscan.c:6895 [inline]
       kswapd+0x1a25/0x30c0 mm/vmscan.c:7164
       kthread+0x2f0/0x390 kernel/kthread.c:388
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  sb_internal#3 --> &xfs_nondir_ilock_class#3 --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&xfs_nondir_ilock_class#3);
                               lock(fs_reclaim);
  rlock(sb_internal#3);

 *** DEADLOCK ***

2 locks held by kswapd0/81:
 #0: ffffffff8e428e80 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6782 [inline]
 #0: ffffffff8e428e80 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xb20/0x30c0 mm/vmscan.c:7164
 #1: ffff8881a895a0e0 (&type->s_umount_key#65){++++}-{3:3}, at: super_trylock_shared fs/super.c:561 [inline]
 #1: ffff8881a895a0e0 (&type->s_umount_key#65){++++}-{3:3}, at: super_cache_scan+0x94/0x4b0 fs/super.c:196

stack backtrace:
CPU: 1 PID: 81 Comm: kswapd0 Not tainted 6.9.0-rc4-syzkaller-00274-g3b68086599f8 #0
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
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1664 [inline]
 sb_start_intwrite include/linux/fs.h:1847 [inline]
 xfs_trans_alloc+0xe5/0x830 fs/xfs/xfs_trans.c:264
 xfs_fs_dirty_inode+0x158/0x250 fs/xfs/xfs_super.c:689
 __mark_inode_dirty+0x325/0xe20 fs/fs-writeback.c:2477
 mark_inode_dirty_sync include/linux/fs.h:2410 [inline]
 iput+0x1fe/0x930 fs/inode.c:1764
 __dentry_kill+0x20d/0x630 fs/dcache.c:603
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1048
 shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1075
 prune_dcache_sb+0x10f/0x180 fs/dcache.c:1156
 super_cache_scan+0x34f/0x4b0 fs/super.c:221
 do_shrink_slab+0x705/0x1160 mm/shrinker.c:435
 shrink_slab_memcg mm/shrinker.c:548 [inline]
 shrink_slab+0x883/0x14d0 mm/shrinker.c:626
 shrink_node_memcgs mm/vmscan.c:5875 [inline]
 shrink_node+0x11f5/0x2d60 mm/vmscan.c:5908
 kswapd_shrink_node mm/vmscan.c:6704 [inline]
 balance_pgdat mm/vmscan.c:6895 [inline]
 kswapd+0x1a25/0x30c0 mm/vmscan.c:7164
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
NILFS (loop4): discard dirty page: offset=98304, ino=3
NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
NILFS (loop4): discard dirty block: blocknr=0, size=1024
NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
NILFS (loop4): discard dirty page: offset=0, ino=12
NILFS (loop4): discard dirty block: blocknr=17, size=1024
NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
NILFS (loop4): discard dirty page: offset=0, ino=3
NILFS (loop4): discard dirty block: blocknr=42, size=1024
NILFS (loop4): discard dirty block: blocknr=43, size=1024
NILFS (loop4): discard dirty block: blocknr=44, size=1024
NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
NILFS (loop4): discard dirty page: offset=4096, ino=6
NILFS (loop4): discard dirty block: blocknr=39, size=1024
NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
NILFS (loop4): discard dirty page: offset=196608, ino=3
NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024
NILFS (loop4): discard dirty block: blocknr=49, size=1024
NILFS (loop4): discard dirty block: blocknr=18446744073709551615, size=1024


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

