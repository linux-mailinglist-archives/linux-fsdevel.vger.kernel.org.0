Return-Path: <linux-fsdevel+bounces-18006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5DB8B4A77
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 09:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06FA41F21BD6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 07:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D645F51010;
	Sun, 28 Apr 2024 07:19:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B6750264
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2024 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714288762; cv=none; b=QJc5gyrSBUSvHjPr3BIqr33tAKzQWs/C9WSXFpIv0Sk5i2PcbGcbtcFDRc3JSgYFHAls3RpvZdRcJ9aUn42MS3kbWMG9q/PIlN3HLVZGsMlzuqXzLgoTgmje3hK/jOnyFT1l6RJ7UgWxIjgcTu/abeKvYvVa3GybrbChp2Yl72A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714288762; c=relaxed/simple;
	bh=mBmav5DgYUIxYdHYDIk02Ru+DUP6YdWlMwQ4Hd+ceR4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o7+e+1pQodBfIOCZnHdh3sKcE594bxm1CSXCGowUCnG1n9PYaLQ96kI9VQ6aC5d14o+cvphGfsjmpDWqg+xzGkErokyvxJBnhphOYSXtmnmhOTxyE3dAcMuQj/gsGCxozxfrhKs8xA4s+LCPrDwlc1wxXalc5yy0KTgHV0YsYm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7deb999eea4so124953839f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2024 00:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714288760; x=1714893560;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ajFfmxlk7w7mK1LbllQC51s0HBWBH2DjO8S8KWYskh0=;
        b=rk/aUHajHmJdhiQy97eayVNh67IC/fs1mi5kh1FkbMEAQQMXuzR5qK3CzI1Ptq5ooH
         Cq5Z6WhUjUr+FX6s8H2EbmwRaglqF1I9/ici8cz6JHvIZXAcGLH+S5R4U01Zss8OWGt0
         5/JfyfpcWSj7CRW7msQ+zh55hyJ33e89ZHBZSXsFkA/BihcIwHSXQH/jdqGNeZCPHOCc
         aypYkuKbv6GBBL9UDvf/Kaeo6rHWM7MsGx4h+JfLaZyPOyq97KaKXfkwvsszMlXzw5NB
         UEKpUUObUziiNiWryzPC4fQKkRThk0JJoThStuqhg/I/xCsNz8h9ceQ3QRFOe6cFB5MA
         skbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzVb9B/hqXE/cg4hpuBSXBdcBHvFa2tozd8BbAXL+uq6yaEMQtG0fzcIAQAeVsp5FgUtdC3d4jyW84UlG+UCrO1bX6hhayQns4lLxQKQ==
X-Gm-Message-State: AOJu0YwlGENmEuYmk/R9Gf2FP6oy00bboLVCWqdqM71YG+Rtcbq4bSYc
	lejC1GbzTUm/GVm8HVSbCSnCZA7l8M8awQyJTK0LElGs98ZCI+pMOb7XznSgtWSTF81vflx2O/v
	e53dh/y5IgQAIBIAT50IIMGz5b2bfdCX5ZuG/skFHPEbGaHX+y4d/NM8=
X-Google-Smtp-Source: AGHT+IH9wkyPO+Vazc0NB1R/lUoZ78LnD2vTnPD9swt7NAArkKYmF8s91e7sUVEjVEmeLb80ndxp/tzo4Xww7El8bmUKlJdTC9YY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3008:b0:486:ec11:3b8a with SMTP id
 r8-20020a056638300800b00486ec113b8amr375263jak.6.1714288759971; Sun, 28 Apr
 2024 00:19:19 -0700 (PDT)
Date: Sun, 28 Apr 2024 00:19:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094b0b8061722f448@google.com>
Subject: [syzbot] [xfs?] possible deadlock in xfs_qm_dqpurge
From: syzbot <syzbot+a191ccc95425c3409faa@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9d1ddab261f3 Merge tag '6.9-rc5-smb-client-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131236e3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19891bd776e81b8b
dashboard link: https://syzkaller.appspot.com/bug?extid=a191ccc95425c3409faa
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-9d1ddab2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ee7f420f8fb9/vmlinux-9d1ddab2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18bef520c373/bzImage-9d1ddab2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a191ccc95425c3409faa@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc5-syzkaller-00036-g9d1ddab261f3 #0 Not tainted
------------------------------------------------------
syz-executor.2/5415 is trying to acquire lock:
ffffffff8d9373c0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:312 [inline]
ffffffff8d9373c0 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:3746 [inline]
ffffffff8d9373c0 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3827 [inline]
ffffffff8d9373c0 (fs_reclaim){+.+.}-{0:0}, at: kmalloc_trace+0x51/0x330 mm/slub.c:3992

but task is already holding lock:
ffff8880767b0868 (&xfs_dquot_group_class){+.+.}-{3:3}, at: xfs_dqlock fs/xfs/xfs_dquot.h:125 [inline]
ffff8880767b0868 (&xfs_dquot_group_class){+.+.}-{3:3}, at: xfs_qm_dqpurge+0xc5/0x630 fs/xfs/xfs_qm.c:129

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&xfs_dquot_group_class){+.+.}-{3:3}:
       __lock_release kernel/locking/lockdep.c:5468 [inline]
       lock_release+0x33e/0x6c0 kernel/locking/lockdep.c:5774
       __mutex_unlock_slowpath+0xa3/0x650 kernel/locking/mutex.c:912
       xfs_qm_dqget_cache_lookup+0x428/0x880 fs/xfs/xfs_dquot.c:802
       xfs_qm_dqget_inode+0x1e7/0x6d0 fs/xfs/xfs_dquot.c:994
       xfs_qm_dqattach_one+0x26f/0x590 fs/xfs/xfs_qm.c:278
       xfs_qm_dqattach_locked+0x1c6/0x2d0 fs/xfs/xfs_qm.c:337
       xfs_qm_vop_dqalloc+0x344/0xe40 fs/xfs/xfs_qm.c:1710
       xfs_create+0x422/0x1170 fs/xfs/xfs_inode.c:1041
       xfs_generic_create+0x631/0x7c0 fs/xfs/xfs_iops.c:199
       lookup_open.isra.0+0x10a1/0x13c0 fs/namei.c:3497
       open_last_lookups fs/namei.c:3566 [inline]
       path_openat+0x92f/0x2990 fs/namei.c:3796
       do_filp_open+0x1dc/0x430 fs/namei.c:3826
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_compat_sys_open fs/open.c:1472 [inline]
       __se_compat_sys_open fs/open.c:1470 [inline]
       __ia32_compat_sys_open+0x147/0x1e0 fs/open.c:1470
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #1 (&xfs_dir_ilock_class){++++}-{3:3}:
       down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1695
       xfs_ilock+0x2ef/0x420 fs/xfs/xfs_inode.c:206
       xfs_reclaim_inode fs/xfs/xfs_icache.c:945 [inline]
       xfs_icwalk_process_inode fs/xfs/xfs_icache.c:1631 [inline]
       xfs_icwalk_ag+0xca6/0x1780 fs/xfs/xfs_icache.c:1713
       xfs_icwalk+0x57/0x100 fs/xfs/xfs_icache.c:1762
       xfs_reclaim_inodes_nr+0x182/0x250 fs/xfs/xfs_icache.c:1011
       super_cache_scan+0x409/0x550 fs/super.c:227
       do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
       shrink_slab+0x18a/0x1310 mm/shrinker.c:662
       shrink_one+0x493/0x7c0 mm/vmscan.c:4774
       shrink_many mm/vmscan.c:4835 [inline]
       lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4935
       shrink_node mm/vmscan.c:5894 [inline]
       kswapd_shrink_node mm/vmscan.c:6704 [inline]
       balance_pgdat+0x10d1/0x1a10 mm/vmscan.c:6895
       kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
       kthread+0x2c1/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3712
       might_alloc include/linux/sched/mm.h:312 [inline]
       slab_pre_alloc_hook mm/slub.c:3746 [inline]
       slab_alloc_node mm/slub.c:3827 [inline]
       kmalloc_trace+0x51/0x330 mm/slub.c:3992
       kmalloc include/linux/slab.h:628 [inline]
       add_stack_record_to_list mm/page_owner.c:177 [inline]
       inc_stack_record_count mm/page_owner.c:219 [inline]
       __set_page_owner+0x517/0x7a0 mm/page_owner.c:334
       set_page_owner include/linux/page_owner.h:32 [inline]
       post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1534
       prep_new_page mm/page_alloc.c:1541 [inline]
       get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3317
       __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
       __alloc_pages_bulk+0x742/0x14f0 mm/page_alloc.c:4523
       alloc_pages_bulk_array include/linux/gfp.h:202 [inline]
       xfs_buf_alloc_pages+0x20f/0x9d0 fs/xfs/xfs_buf.c:398
       xfs_buf_find_insert fs/xfs/xfs_buf.c:650 [inline]
       xfs_buf_get_map+0x1e69/0x30d0 fs/xfs/xfs_buf.c:755
       xfs_buf_read_map+0xd2/0xb40 fs/xfs/xfs_buf.c:860
       xfs_trans_read_buf_map+0x352/0x990 fs/xfs/xfs_trans_buf.c:289
       xfs_trans_read_buf fs/xfs/xfs_trans.h:210 [inline]
       xfs_qm_dqflush+0x224/0x1470 fs/xfs/xfs_dquot.c:1271
       xfs_qm_dqpurge+0x1d3/0x630 fs/xfs/xfs_qm.c:149
       xfs_qm_dquot_walk.isra.0+0x217/0x3d0 fs/xfs/xfs_qm.c:88
       xfs_qm_dqpurge_all fs/xfs/xfs_qm.c:194 [inline]
       xfs_qm_unmount+0x92/0x1c0 fs/xfs/xfs_qm.c:206
       xfs_unmountfs+0x76/0x240 fs/xfs/xfs_mount.c:1076
       xfs_fs_put_super+0x61/0x160 fs/xfs/xfs_super.c:1134
       generic_shutdown_super+0x159/0x3d0 fs/super.c:641
       kill_block_super+0x3b/0x90 fs/super.c:1675
       xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2026
       deactivate_locked_super+0xbe/0x1a0 fs/super.c:472
       deactivate_super+0xde/0x100 fs/super.c:505
       cleanup_mnt+0x222/0x450 fs/namespace.c:1267
       task_work_run+0x14e/0x250 kernel/task_work.c:180
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
       __do_fast_syscall_32+0x82/0x120 arch/x86/entry/common.c:389
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> &xfs_dir_ilock_class --> &xfs_dquot_group_class

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&xfs_dquot_group_class);
                               lock(&xfs_dir_ilock_class);
                               lock(&xfs_dquot_group_class);
  lock(fs_reclaim);

 *** DEADLOCK ***

3 locks held by syz-executor.2/5415:
 #0: ffff8880267b00e0 (&type->s_umount_key#52){++++}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff8880267b00e0 (&type->s_umount_key#52){++++}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff8880267b00e0 (&type->s_umount_key#52){++++}-{3:3}, at: deactivate_super+0xd6/0x100 fs/super.c:504
 #1: ffff88805a740158 (&qinf->qi_tree_lock){+.+.}-{3:3}, at: xfs_qm_dquot_walk.isra.0+0x111/0x3d0 fs/xfs/xfs_qm.c:75
 #2: ffff8880767b0868 (&xfs_dquot_group_class){+.+.}-{3:3}, at: xfs_dqlock fs/xfs/xfs_dquot.h:125 [inline]
 #2: ffff8880767b0868 (&xfs_dquot_group_class){+.+.}-{3:3}, at: xfs_qm_dqpurge+0xc5/0x630 fs/xfs/xfs_qm.c:129

stack backtrace:
CPU: 3 PID: 5415 Comm: syz-executor.2 Not tainted 6.9.0-rc5-syzkaller-00036-g9d1ddab261f3 #0
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
 __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
 fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3712
 might_alloc include/linux/sched/mm.h:312 [inline]
 slab_pre_alloc_hook mm/slub.c:3746 [inline]
 slab_alloc_node mm/slub.c:3827 [inline]
 kmalloc_trace+0x51/0x330 mm/slub.c:3992
 kmalloc include/linux/slab.h:628 [inline]
 add_stack_record_to_list mm/page_owner.c:177 [inline]
 inc_stack_record_count mm/page_owner.c:219 [inline]
 __set_page_owner+0x517/0x7a0 mm/page_owner.c:334
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3317
 __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
 __alloc_pages_bulk+0x742/0x14f0 mm/page_alloc.c:4523
 alloc_pages_bulk_array include/linux/gfp.h:202 [inline]
 xfs_buf_alloc_pages+0x20f/0x9d0 fs/xfs/xfs_buf.c:398
 xfs_buf_find_insert fs/xfs/xfs_buf.c:650 [inline]
 xfs_buf_get_map+0x1e69/0x30d0 fs/xfs/xfs_buf.c:755
 xfs_buf_read_map+0xd2/0xb40 fs/xfs/xfs_buf.c:860
 xfs_trans_read_buf_map+0x352/0x990 fs/xfs/xfs_trans_buf.c:289
 xfs_trans_read_buf fs/xfs/xfs_trans.h:210 [inline]
 xfs_qm_dqflush+0x224/0x1470 fs/xfs/xfs_dquot.c:1271
 xfs_qm_dqpurge+0x1d3/0x630 fs/xfs/xfs_qm.c:149
 xfs_qm_dquot_walk.isra.0+0x217/0x3d0 fs/xfs/xfs_qm.c:88
 xfs_qm_dqpurge_all fs/xfs/xfs_qm.c:194 [inline]
 xfs_qm_unmount+0x92/0x1c0 fs/xfs/xfs_qm.c:206
 xfs_unmountfs+0x76/0x240 fs/xfs/xfs_mount.c:1076
 xfs_fs_put_super+0x61/0x160 fs/xfs/xfs_super.c:1134
 generic_shutdown_super+0x159/0x3d0 fs/super.c:641
 kill_block_super+0x3b/0x90 fs/super.c:1675
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2026
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:472
 deactivate_super+0xde/0x100 fs/super.c:505
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x82/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7334579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffb89538 EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffb8a680 RCX: 0000000000000009
RDX: 00000000f748bff4 RSI: 0000000000000064 RDI: 00000000ffb8a680
RBP: 00000000f73db3bd R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
EXT4-fs (loop2): unmounting filesystem 76b65be2-f6da-4727-8c75-0525a5b65a09.
XFS (loop2): Unmounting Filesystem a2f82aab-77f8-4286-afd4-a8f747a74bab
XFS (loop2): Unmounting Filesystem a2f82aab-77f8-4286-afd4-a8f747a74bab
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

