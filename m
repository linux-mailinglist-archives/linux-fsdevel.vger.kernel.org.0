Return-Path: <linux-fsdevel+bounces-18678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578DF8BB552
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 23:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1581C23322
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 21:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194DE50269;
	Fri,  3 May 2024 21:12:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EF041C87
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714770744; cv=none; b=RpApf8FmbN5f/jPW+cHmzQxbaznjPEk3NizD19CVi/8raQdv0XfpSiBNAxGPfcR1/Kn1zuehYdiPVGXcAaPFXdQZFdEcK0A8EFie8/8SIqvgyx494m/HwUlqG3hBusAe/4v5u1rFBWvMWJbNV+tNZhI9aAPBk119VyshOanLZ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714770744; c=relaxed/simple;
	bh=ycDghc68qzDwYAQewVv9WPRcdtL4zIPqb42JlXJQlJ8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y+PnFIu3HzU+NMv7othcgBkHjJZ9qOUkfctSzjUuNuEiphEtORZw9AtEr5/AOcOw/ufdkY22auqUFaIbygQEeWTJJovvfqqvHrYU6o4rmnAWdOQ6fAVXtYjqy9fwoBdNdF2iG7WRVdLHlJO5jqcJTuchKWYNnRDOZHPXntlv+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36b1fda4c6dso1473465ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 14:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714770742; x=1715375542;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7QQ1yqs7rz6ixM8Q6PLgTtJHT4Ut7GB+/Wz+jhLZ1Rk=;
        b=hrnjJUAO/131VytSCvYN1/YPXgcL2GIWcWcvg1vP3EGW2/uv8bjMOrOXIpy1BZekzK
         yje0FcF13b+gz5CCizCtw1+WDqBIjvDu1MxT1n923qEPG1CK89NlnqOWK3X0auU1e9+c
         QyV28piphZa+xMPA/KqfY26uRFRaU4rRSp1u1pLy2g2aL7YOkl+t3aK9YDzzo2eG26mJ
         2gTjoPhZhXH5t0DttnLX8/DIURUu01q58mJUzibgZWo1tOzdW+qe4S6xeJqgWN9n7Nn3
         o+jS8e1mICxkrqF7OunQC/nuR4Twb/NAD9Rh491AFSynXfRSOWDQ79xt8zTGG9mHOv6i
         aMCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpbvvxv7GLssTVJBnmDwsQwPHv9+6sXwfXiGqjPkWosoeiAdOR33XwUi0bNJ1dz3T2E/C4SxcIS8sIC+9S9djR+uXnCsGh+xERbajgFQ==
X-Gm-Message-State: AOJu0YyWD9iN4VsR5vPN11nwhcPt94svrlEKkthVNtjJpaGUkrRJejN5
	i/ZYyAnBWTxVGS4RTyG1CAL6lzoYx8Q+SlTGJFntdUUlkfW/pANI4v4xphULTSJyxfccZepp7sw
	WyVOg/d4XJ2wYu7Ik9d1WCoyLaYjXaN0r4NFWOBHey/u0xmnQDw+xzDo=
X-Google-Smtp-Source: AGHT+IGwozsz3tqmLYxBXyx9gpKBDwRjL+CDjFgR59GW2XTkvZNO4MP6/g+XMe/zXrELNjI818ssvFVinNSgKcwwSBdXn88yHXyZ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c3:b0:36b:140e:a4c with SMTP id
 i3-20020a056e0212c300b0036b140e0a4cmr136165ilm.3.1714770742390; Fri, 03 May
 2024 14:12:22 -0700 (PDT)
Date: Fri, 03 May 2024 14:12:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8c4ed0617932cf8@google.com>
Subject: [syzbot] [xfs?] possible deadlock in xfs_qm_dqfree_one (2)
From: syzbot <syzbot+8ff4d7e4aeff9f0a6390@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b947cc5bf6d7 Merge tag 'erofs-for-6.9-rc7-fixes' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11806d37180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a10709e36c02a40
dashboard link: https://syzkaller.appspot.com/bug?extid=8ff4d7e4aeff9f0a6390
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/91fab71c3d68/disk-b947cc5b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fec2372d99b3/vmlinux-b947cc5b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cd335eaa33d7/bzImage-b947cc5b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ff4d7e4aeff9f0a6390@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc6-syzkaller-00005-gb947cc5bf6d7 #0 Not tainted
------------------------------------------------------
kswapd0/88 is trying to acquire lock:
ffff88805aa35958 (&qinf->qi_tree_lock){+.+.}-{3:3}, at: xfs_qm_dqfree_one+0x6f/0x1a0 fs/xfs/xfs_qm.c:1654

but task is already holding lock:
ffffffff8db37c40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x166/0x19a0 mm/vmscan.c:6782

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3712
       might_alloc include/linux/sched/mm.h:312 [inline]
       slab_pre_alloc_hook mm/slub.c:3746 [inline]
       slab_alloc_node mm/slub.c:3827 [inline]
       kmalloc_trace+0x51/0x330 mm/slub.c:3992
       kmalloc include/linux/slab.h:628 [inline]
       add_stack_record_to_list mm/page_owner.c:177 [inline]
       inc_stack_record_count mm/page_owner.c:219 [inline]
       __set_page_owner+0x34a/0x560 mm/page_owner.c:334
       set_page_owner include/linux/page_owner.h:32 [inline]
       post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1534
       prep_new_page mm/page_alloc.c:1541 [inline]
       get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3317
       __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
       __alloc_pages_bulk+0x742/0x14f0 mm/page_alloc.c:4523
       alloc_pages_bulk_array include/linux/gfp.h:202 [inline]
       xfs_buf_alloc_pages+0x20f/0x9d0 fs/xfs/xfs_buf.c:398
       xfs_buf_find_insert fs/xfs/xfs_buf.c:650 [inline]
       xfs_buf_get_map+0x1e71/0x30e0 fs/xfs/xfs_buf.c:755
       xfs_buf_read_map+0xd2/0xb40 fs/xfs/xfs_buf.c:860
       xfs_trans_read_buf_map+0x352/0x990 fs/xfs/xfs_trans_buf.c:289
       xfs_trans_read_buf fs/xfs/xfs_trans.h:210 [inline]
       xfs_qm_dqflush+0x224/0x1470 fs/xfs/xfs_dquot.c:1271
       xfs_qm_flush_one+0x2f7/0x3b0 fs/xfs/xfs_qm.c:1285
       xfs_qm_dquot_walk.isra.0+0x21a/0x3d0 fs/xfs/xfs_qm.c:88
       xfs_qm_quotacheck+0x7af/0x920 fs/xfs/xfs_qm.c:1375
       xfs_qm_mount_quotas+0x11a/0x650 fs/xfs/xfs_qm.c:1488
       xfs_mountfs+0x1c45/0x1d40 fs/xfs/xfs_mount.c:963
       xfs_fs_fill_super+0x1424/0x1d80 fs/xfs/xfs_super.c:1730
       get_tree_bdev+0x372/0x610 fs/super.c:1614
       vfs_get_tree+0x92/0x380 fs/super.c:1779
       do_new_mount fs/namespace.c:3352 [inline]
       path_mount+0x14e6/0x1f20 fs/namespace.c:3679
       do_mount fs/namespace.c:3692 [inline]
       __do_sys_mount fs/namespace.c:3898 [inline]
       __se_sys_mount fs/namespace.c:3875 [inline]
       __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&xfs_dquot_project_class){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       xfs_dqlock fs/xfs/xfs_dquot.h:125 [inline]
       xfs_qm_dqget_cache_insert.constprop.0+0xda/0x3d0 fs/xfs/xfs_dquot.c:842
       xfs_qm_dqget+0x182/0x4a0 fs/xfs/xfs_dquot.c:909
       xfs_qm_quotacheck_dqadjust+0xb3/0x550 fs/xfs/xfs_qm.c:1096
       xfs_qm_dqusage_adjust+0x4ef/0x660 fs/xfs/xfs_qm.c:1229
       xfs_iwalk_ag_recs+0x4d2/0x850 fs/xfs/xfs_iwalk.c:213
       xfs_iwalk_run_callbacks+0x1f3/0x540 fs/xfs/xfs_iwalk.c:372
       xfs_iwalk_ag+0x823/0xa60 fs/xfs/xfs_iwalk.c:478
       xfs_iwalk_ag_work+0x144/0x1c0 fs/xfs/xfs_iwalk.c:620
       xfs_pwork_work+0x82/0x160 fs/xfs/xfs_pwork.c:47
       process_one_work+0x9ac/0x1ac0 kernel/workqueue.c:3254
       process_scheduled_works kernel/workqueue.c:3335 [inline]
       worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
       kthread+0x2c4/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&qinf->qi_tree_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       xfs_qm_dqfree_one+0x6f/0x1a0 fs/xfs/xfs_qm.c:1654
       xfs_qm_shrink_scan+0x25c/0x3f0 fs/xfs/xfs_qm.c:531
       do_shrink_slab+0x452/0x11c0 mm/shrinker.c:435
       shrink_slab+0x18a/0x1310 mm/shrinker.c:662
       shrink_one+0x493/0x7c0 mm/vmscan.c:4774
       shrink_many mm/vmscan.c:4835 [inline]
       lru_gen_shrink_node mm/vmscan.c:4935 [inline]
       shrink_node+0x231f/0x3a80 mm/vmscan.c:5894
       kswapd_shrink_node mm/vmscan.c:6704 [inline]
       balance_pgdat+0x9a0/0x19a0 mm/vmscan.c:6895
       kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
       kthread+0x2c4/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &qinf->qi_tree_lock --> &xfs_dquot_project_class --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&xfs_dquot_project_class);
                               lock(fs_reclaim);
  lock(&qinf->qi_tree_lock);

 *** DEADLOCK ***

1 lock held by kswapd0/88:
 #0: ffffffff8db37c40 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x166/0x19a0 mm/vmscan.c:6782

stack backtrace:
CPU: 0 PID: 88 Comm: kswapd0 Not tainted 6.9.0-rc6-syzkaller-00005-gb947cc5bf6d7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
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
 xfs_qm_dqfree_one+0x6f/0x1a0 fs/xfs/xfs_qm.c:1654
 xfs_qm_shrink_scan+0x25c/0x3f0 fs/xfs/xfs_qm.c:531
 do_shrink_slab+0x452/0x11c0 mm/shrinker.c:435
 shrink_slab+0x18a/0x1310 mm/shrinker.c:662
 shrink_one+0x493/0x7c0 mm/vmscan.c:4774
 shrink_many mm/vmscan.c:4835 [inline]
 lru_gen_shrink_node mm/vmscan.c:4935 [inline]
 shrink_node+0x231f/0x3a80 mm/vmscan.c:5894
 kswapd_shrink_node mm/vmscan.c:6704 [inline]
 balance_pgdat+0x9a0/0x19a0 mm/vmscan.c:6895
 kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
 kthread+0x2c4/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

