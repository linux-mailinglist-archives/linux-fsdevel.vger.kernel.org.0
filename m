Return-Path: <linux-fsdevel+bounces-17201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8118A8B47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 20:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA951F250EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 18:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99A51E52F;
	Wed, 17 Apr 2024 18:42:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78D21D540
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379343; cv=none; b=QPDdrCZXuFvCsg+7dsYbmpz3/6VQMtSsSKtimN2WVX0C5DmETFZT7zzhLMHXKm6MyaR0A98oPapCaxrGnGIo1ANZZX9zHw/PZ2cM0y+61I3DjT6I75598jHwCaPvIS10CugCZdKF4MC7PkNSIrKROreBR3wtHavav2bT/IVA/YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379343; c=relaxed/simple;
	bh=DK0MorCy2bMqQFN6AMrEBngq+fs1pfNW+hOa2B6iPRA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VzWPmNWW9c63lSgkW0NJ+SpPH0J4DvctoUjCHdzSgK+pJ7qGS0K4HcDJPoEfmITdExquANJVIShCZ65LE4FFbVHDTPHPxSgdXTMkth8dfz7knxjcLPafruyXBh96+CVVG5/azkN9XfQO0NUDNCN6VCbou1DRMnf7Wf2QtTzcH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36a20206746so133065ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 11:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713379341; x=1713984141;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9YDf9JjlxpbJ+tt2eQd5WUSwtdToxmwgvq2MusOFBCA=;
        b=kK95uU0+lzBLgZ9gCvIB0J65NTb4a4MfC07Z+xc5/4qE59Rc2B2rEL7G4OvVwmEKgo
         ozBG8w9tdeXjCP+LAC5dCDM7WzJrA2zmIFG1nmAiZ3UR2tblmEF6FVr463E2nA+2vANJ
         Oos7vjLH4Uc71UqficaOY51yh10/lCaZpM8khUAbnZ/uX/bk7Fy9BNiPNcp09K2Ia6pV
         ybpG8u1o0ke9A+Z792bBx/7pvrv679KzDOUE/+3lRVj43WvzAoLwHxTtfp8Py9VntX4i
         bOJuFIePgDSevTaaZz/SJ6aoFca4DLILsmqTaqvoIwvP7uJO5JYwU0uQ/t+vGXsYJAoS
         uVQA==
X-Forwarded-Encrypted: i=1; AJvYcCXBt2P3oCZo+Wx38PfCTAC71sOfcKoMnHvPDF1E0MhkglJu/0C4Q73gzgPjp2ynBjVUIItbDKmEq3CVBxMIZ/7S3FUZelGuOOX8HR8mXg==
X-Gm-Message-State: AOJu0Yzw56ZoQDRtgAf9jct0Forg2MH0bzd5OgzL0aGHJZ3cZZut8lxL
	ReYYU358MX3t1b7Kv0CxGwGMYVi6JsKM8Zq4cLr+mi6KWPI7JRW6SlPdwn85XFDwKKzfOT7GxZD
	rTEA+oL5Zy1fmAEf62vfXPwtQ3SeuTwL0C55aAeVQGbI8fotwKDKF6tk=
X-Google-Smtp-Source: AGHT+IGzsWZ9XDZ7RgCW6w73IrP9C34zCDhrNRhrAYgEqhSiQKHPrm2baYnC6CXZ6sFt4HRy5EB2nM/UcE+HnBSIRc3NQI02iC6x
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8e:b0:36b:2731:5fb6 with SMTP id
 w14-20020a056e021c8e00b0036b27315fb6mr17257ill.0.1713379340966; Wed, 17 Apr
 2024 11:42:20 -0700 (PDT)
Date: Wed, 17 Apr 2024 11:42:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbf10e06164f3695@google.com>
Subject: [syzbot] [xfs?] possible deadlock in xfs_qm_flush_one
From: syzbot <syzbot+4a799ff34dbbb5465776@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9ed46da14b9b Add linux-next specific files for 20240412
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11a4a1dd180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ea0abc478c49859
dashboard link: https://syzkaller.appspot.com/bug?extid=4a799ff34dbbb5465776
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fc649744d68c/disk-9ed46da1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/11eab7b9945d/vmlinux-9ed46da1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7885afd198d/bzImage-9ed46da1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4a799ff34dbbb5465776@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc3-next-20240412-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.1/7036 is trying to acquire lock:
ffffffff8e429e80 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:334 [inline]
ffffffff8e429e80 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:3847 [inline]
ffffffff8e429e80 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3937 [inline]
ffffffff8e429e80 (fs_reclaim){+.+.}-{0:0}, at: kmalloc_trace_noprof+0x3d/0x2b0 mm/slub.c:4104

but task is already holding lock:
ffff888011c298a8 (&xfs_dquot_project_class){+.+.}-{3:3}, at: xfs_dqlock fs/xfs/xfs_dquot.h:125 [inline]
ffff888011c298a8 (&xfs_dquot_project_class){+.+.}-{3:3}, at: xfs_qm_flush_one+0xd9/0x430 fs/xfs/xfs_qm.c:1250

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&xfs_dquot_project_class){+.+.}-{3:3}:
       reacquire_held_locks+0x3eb/0x690 kernel/locking/lockdep.c:5279
       __lock_release kernel/locking/lockdep.c:5468 [inline]
       lock_release+0x379/0x9f0 kernel/locking/lockdep.c:5774
       __mutex_unlock_slowpath+0xe2/0x750 kernel/locking/mutex.c:912
       xfs_qm_dqget_cache_lookup+0x340/0x8c0 fs/xfs/xfs_dquot.c:802
       xfs_qm_dqget_inode+0x308/0xaf0 fs/xfs/xfs_dquot.c:994
       xfs_qm_dqattach_one+0x181/0x640 fs/xfs/xfs_qm.c:278
       xfs_qm_dqattach_locked+0x42c/0x4e0 fs/xfs/xfs_qm.c:345
       xfs_qm_vop_dqalloc+0x3fd/0xf10 fs/xfs/xfs_qm.c:1710
       xfs_create+0x578/0x1320 fs/xfs/xfs_inode.c:1041
       xfs_generic_create+0x495/0xd70 fs/xfs/xfs_iops.c:199
       lookup_open fs/namei.c:3497 [inline]
       open_last_lookups fs/namei.c:3566 [inline]
       path_openat+0x1425/0x3280 fs/namei.c:3796
       do_filp_open+0x235/0x490 fs/namei.c:3826
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_sys_openat fs/open.c:1437 [inline]
       __se_sys_openat fs/open.c:1432 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
       do_syscall_x64 arch/x86/entry/common.c:74 [inline]
       do_syscall_64+0xfa/0x250 arch/x86/entry/common.c:105
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&xfs_dir_ilock_class){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1695
       xfs_reclaim_inode fs/xfs/xfs_icache.c:945 [inline]
       xfs_icwalk_process_inode fs/xfs/xfs_icache.c:1631 [inline]
       xfs_icwalk_ag+0x120e/0x1ad0 fs/xfs/xfs_icache.c:1713
       xfs_icwalk fs/xfs/xfs_icache.c:1762 [inline]
       xfs_reclaim_inodes_nr+0x257/0x360 fs/xfs/xfs_icache.c:1011
       super_cache_scan+0x40f/0x4b0 fs/super.c:227
       do_shrink_slab+0x705/0x1160 mm/shrinker.c:435
       shrink_slab+0x1092/0x14d0 mm/shrinker.c:662
       shrink_one+0x453/0x880 mm/vmscan.c:4809
       shrink_many mm/vmscan.c:4870 [inline]
       lru_gen_shrink_node mm/vmscan.c:4970 [inline]
       shrink_node+0x3b17/0x4310 mm/vmscan.c:5929
       kswapd_shrink_node mm/vmscan.c:6741 [inline]
       balance_pgdat mm/vmscan.c:6932 [inline]
       kswapd+0x1882/0x38a0 mm/vmscan.c:7201
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __fs_reclaim_acquire mm/page_alloc.c:3825 [inline]
       fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3839
       might_alloc include/linux/sched/mm.h:334 [inline]
       slab_pre_alloc_hook mm/slub.c:3847 [inline]
       slab_alloc_node mm/slub.c:3937 [inline]
       kmalloc_trace_noprof+0x3d/0x2b0 mm/slub.c:4104
       kmalloc_noprof include/linux/slab.h:660 [inline]
       add_stack_record_to_list mm/page_owner.c:177 [inline]
       inc_stack_record_count mm/page_owner.c:219 [inline]
       __set_page_owner+0x561/0x810 mm/page_owner.c:334
       set_page_owner include/linux/page_owner.h:32 [inline]
       post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1474
       prep_new_page mm/page_alloc.c:1482 [inline]
       get_page_from_freelist+0x2ce2/0x2d90 mm/page_alloc.c:3444
       __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4702
       alloc_pages_bulk_noprof+0x729/0xd40 mm/page_alloc.c:4650
       xfs_buf_alloc_pages+0x1a8/0x880 fs/xfs/xfs_buf.c:398
       xfs_buf_find_insert+0x19a/0x1540 fs/xfs/xfs_buf.c:650
       xfs_buf_get_map+0x149c/0x1ae0 fs/xfs/xfs_buf.c:755
       xfs_buf_read_map+0x111/0xa60 fs/xfs/xfs_buf.c:860
       xfs_trans_read_buf_map+0x260/0xad0 fs/xfs/xfs_trans_buf.c:289
       xfs_trans_read_buf fs/xfs/xfs_trans.h:210 [inline]
       xfs_qm_dqflush+0x2eb/0x16d0 fs/xfs/xfs_dquot.c:1271
       xfs_qm_flush_one+0x129/0x430 fs/xfs/xfs_qm.c:1285
       xfs_qm_dquot_walk+0x232/0x4a0 fs/xfs/xfs_qm.c:88
       xfs_qm_quotacheck+0x41a/0x6f0 fs/xfs/xfs_qm.c:1375
       xfs_qm_mount_quotas+0x345/0x630 fs/xfs/xfs_qm.c:1488
       xfs_mountfs+0x1849/0x1eb0 fs/xfs/xfs_mount.c:963
       xfs_fs_fill_super+0x114b/0x13c0 fs/xfs/xfs_super.c:1730
       get_tree_bdev+0x3f7/0x570 fs/super.c:1614
       vfs_get_tree+0x90/0x2a0 fs/super.c:1779
       do_new_mount+0x2be/0xb40 fs/namespace.c:3352
       do_mount fs/namespace.c:3692 [inline]
       __do_sys_mount fs/namespace.c:3898 [inline]
       __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
       do_syscall_x64 arch/x86/entry/common.c:74 [inline]
       do_syscall_64+0xfa/0x250 arch/x86/entry/common.c:105
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> &xfs_dir_ilock_class --> &xfs_dquot_project_class

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&xfs_dquot_project_class);
                               lock(&xfs_dir_ilock_class);
                               lock(&xfs_dquot_project_class);
  lock(fs_reclaim);

 *** DEADLOCK ***

3 locks held by syz-executor.1/7036:
 #0: ffff888183b720e0 (&type->s_umount_key#64/1){+.+.}-{3:3}, at: alloc_super+0x221/0x9d0 fs/super.c:343
 #1: ffff8881874c9958 (&qinf->qi_tree_lock){+.+.}-{3:3}, at: xfs_qm_dquot_walk+0x136/0x4a0 fs/xfs/xfs_qm.c:75
 #2: ffff888011c298a8 (&xfs_dquot_project_class){+.+.}-{3:3}, at: xfs_dqlock fs/xfs/xfs_dquot.h:125 [inline]
 #2: ffff888011c298a8 (&xfs_dquot_project_class){+.+.}-{3:3}, at: xfs_qm_flush_one+0xd9/0x430 fs/xfs/xfs_qm.c:1250

stack backtrace:
CPU: 1 PID: 7036 Comm: syz-executor.1 Not tainted 6.9.0-rc3-next-20240412-syzkaller #0
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
 __fs_reclaim_acquire mm/page_alloc.c:3825 [inline]
 fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3839
 might_alloc include/linux/sched/mm.h:334 [inline]
 slab_pre_alloc_hook mm/slub.c:3847 [inline]
 slab_alloc_node mm/slub.c:3937 [inline]
 kmalloc_trace_noprof+0x3d/0x2b0 mm/slub.c:4104
 kmalloc_noprof include/linux/slab.h:660 [inline]
 add_stack_record_to_list mm/page_owner.c:177 [inline]
 inc_stack_record_count mm/page_owner.c:219 [inline]
 __set_page_owner+0x561/0x810 mm/page_owner.c:334
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1474
 prep_new_page mm/page_alloc.c:1482 [inline]
 get_page_from_freelist+0x2ce2/0x2d90 mm/page_alloc.c:3444
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4702
 alloc_pages_bulk_noprof+0x729/0xd40 mm/page_alloc.c:4650
 xfs_buf_alloc_pages+0x1a8/0x880 fs/xfs/xfs_buf.c:398
 xfs_buf_find_insert+0x19a/0x1540 fs/xfs/xfs_buf.c:650
 xfs_buf_get_map+0x149c/0x1ae0 fs/xfs/xfs_buf.c:755
 xfs_buf_read_map+0x111/0xa60 fs/xfs/xfs_buf.c:860
 xfs_trans_read_buf_map+0x260/0xad0 fs/xfs/xfs_trans_buf.c:289
 xfs_trans_read_buf fs/xfs/xfs_trans.h:210 [inline]
 xfs_qm_dqflush+0x2eb/0x16d0 fs/xfs/xfs_dquot.c:1271
 xfs_qm_flush_one+0x129/0x430 fs/xfs/xfs_qm.c:1285
 xfs_qm_dquot_walk+0x232/0x4a0 fs/xfs/xfs_qm.c:88
 xfs_qm_quotacheck+0x41a/0x6f0 fs/xfs/xfs_qm.c:1375
 xfs_qm_mount_quotas+0x345/0x630 fs/xfs/xfs_qm.c:1488
 xfs_mountfs+0x1849/0x1eb0 fs/xfs/xfs_mount.c:963
 xfs_fs_fill_super+0x114b/0x13c0 fs/xfs/xfs_super.c:1730
 get_tree_bdev+0x3f7/0x570 fs/super.c:1614
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:74 [inline]
 do_syscall_64+0xfa/0x250 arch/x86/entry/common.c:105
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcda6a7f56a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcda77c4ef8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fcda77c4f80 RCX: 00007fcda6a7f56a
RDX: 0000000020009800 RSI: 0000000020009840 RDI: 00007fcda77c4f40
RBP: 0000000020009800 R08: 00007fcda77c4f80 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020009840
R13: 00007fcda77c4f40 R14: 000000000000985b R15: 0000000020000240
 </TASK>
XFS (loop1): Quotacheck: Done.


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

