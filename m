Return-Path: <linux-fsdevel+bounces-11759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63806856F32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 22:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5CB28B10D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 21:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C80613DBA4;
	Thu, 15 Feb 2024 21:18:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D31C41C61
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031913; cv=none; b=XWNR4S/qDo+LTHwq/qIUDMp9+hEezsjXCl2N/8kVbpLIAdqNrp7EyLkL3syA45tOe/galKusNTnWbEd1LzY4UDdStIkSVCMLDjJrFGhX8BA09b4zBr2Hv9pDjsmPgjk9mq0wjS+JReMvLUnzDkBk7ag9gGoqQRLaO5NbStSTzcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031913; c=relaxed/simple;
	bh=daffOALHp8DQN40vohY4HfKV9YhAbZQOGzdVIhbHlW4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TZyAsMz972a6v5Nzywo+KEUaCXLT7N9mxCxKz3H/PRX70qo+1Bast9pse08qgJfbOfuNGykluo9Hs/47DLbJ5ix7GHQ14JRu1AxJs2gP/KhKUstY5oTvbuBsN9L2obbMdzz522oLuuITJAIvINztNt1FJcAsAJB1ltV+9X6kMzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3642ae0c5c5so12649175ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 13:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708031910; x=1708636710;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BjUBA52P/Pyj7YfYtfLD1Xo37YybOST4jKghch+oOg=;
        b=ceWPrM1Xd7AhGq3OFM2nfUv3j+vfXlSIKdGq/jNVRj6Oc8hKGU5/fGA5vUVkGzQ0Hu
         wuGoTdH+eVmNXN5yy/BtPUAsJNO9K2tUI7DVWkoLVWQehsi0kU3VvJAXQb6RHZSO6b89
         am3wBDZU7/zlLFz5pw4NUOKy2i31EhGsUyprW5FdxsyzpiRNqYR43Tvi33SGhl4l8Dw0
         N/W0A9NPT81Y8V0pAdRnwEjaaxtgW2IVPe53HAPXA+IMbvJgoQKGHRel/Wy8yM/QQMSl
         Ot602sezoCI8rkYb3NkcEW3DOEc5plMKvA4u3V7cuXP5EPRXTU5EZLufv2gVRekDVj4f
         3BFw==
X-Forwarded-Encrypted: i=1; AJvYcCXgrkzWUd5OMDGmBqD+4Ga9Gk1G0t/a2wB74YvDs3KOLcQ2G5Y5DTLuJVl9+hslp7e1bj4hgTDfERHjNSwlMDzykn6Q5S4pPRbchzjn2A==
X-Gm-Message-State: AOJu0YwL16+dJ/yn2y/FTbu6GPAAXxrJFay6CN8TtUAJny/AGqdEKgYj
	t/+yYRZNE0rftXBD5j2JFAtNCvcmCdIRopPYGvJGv7ylP2dRSW79Wzvp1DTDv4q/PCTnUHD/Ov0
	EEM5RaL6I68/LIWqIzqpS3CTqa0ulpaekKH96f5nEkGtq6K71UevlVgs=
X-Google-Smtp-Source: AGHT+IHOPtYvgn4Ddz9EbkXVdEBoPLDhUMfTNdLYE88sYXKgMNt83o09o9CMnGS7/PXGwlrlN37gg/FTgsTYCMWA6rL6xCnB4UFb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:220b:b0:363:c53e:f20a with SMTP id
 j11-20020a056e02220b00b00363c53ef20amr238257ilf.4.1708031910514; Thu, 15 Feb
 2024 13:18:30 -0800 (PST)
Date: Thu, 15 Feb 2024 13:18:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a97300611722b1c@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_evict_inode (3)
From: syzbot <syzbot+295234f4b13c00852ba4@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    445a555e0623 Add linux-next specific files for 20240209
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11187fd4180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85aa3388229f9ea9
dashboard link: https://syzkaller.appspot.com/bug?extid=295234f4b13c00852ba4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9188bb84c998/disk-445a555e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ce0c98eabb2/vmlinux-445a555e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab801b1c1d6d/bzImage-445a555e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+295234f4b13c00852ba4@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-rc3-next-20240209-syzkaller #0 Not tainted
------------------------------------------------------
kswapd0/87 is trying to acquire lock:
ffff88802ed52610 (sb_internal){.+.+}-{0:0}, at: __sb_start_write include/linux/fs.h:1657 [inline]
ffff88802ed52610 (sb_internal){.+.+}-{0:0}, at: sb_start_intwrite include/linux/fs.h:1840 [inline]
ffff88802ed52610 (sb_internal){.+.+}-{0:0}, at: ext4_evict_inode+0x2e4/0xf30 fs/ext4/inode.c:212

but task is already holding lock:
ffffffff8e21a620 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6790 [inline]
ffffffff8e21a620 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xb8a/0x3570 mm/vmscan.c:7162

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __fs_reclaim_acquire mm/page_alloc.c:3734 [inline]
       fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3748
       might_alloc include/linux/sched/mm.h:312 [inline]
       slab_pre_alloc_hook mm/slub.c:3762 [inline]
       slab_alloc_node mm/slub.c:3843 [inline]
       kmem_cache_alloc+0x48/0x350 mm/slub.c:3868
       ext4_es_insert_delayed_block+0x2d9/0xa10 fs/ext4/extents_status.c:2090
       ext4_insert_delayed_block fs/ext4/inode.c:1676 [inline]
       ext4_da_map_blocks fs/ext4/inode.c:1777 [inline]
       ext4_da_get_block_prep+0xa67/0x1420 fs/ext4/inode.c:1817
       ext4_block_write_begin+0x53b/0x1850 fs/ext4/inode.c:1055
       ext4_da_write_begin+0x5e8/0xa50 fs/ext4/inode.c:2894
       generic_perform_write+0x322/0x640 mm/filemap.c:3921
       ext4_buffered_write_iter+0xc6/0x350 fs/ext4/file.c:299
       ext4_file_write_iter+0x1de/0x1a10
       call_write_iter include/linux/fs.h:2103 [inline]
       iter_file_splice_write+0xbd7/0x14e0 fs/splice.c:743
       do_splice_from fs/splice.c:941 [inline]
       direct_splice_actor+0x11e/0x220 fs/splice.c:1164
       splice_direct_to_actor+0x58e/0xc90 fs/splice.c:1108
       do_splice_direct_actor fs/splice.c:1207 [inline]
       do_splice_direct+0x28c/0x3e0 fs/splice.c:1233
       do_sendfile+0x56d/0xdc0 fs/read_write.c:1295
       __do_sys_sendfile64 fs/read_write.c:1362 [inline]
       __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #2 (&ei->i_data_sem){++++}-{3:3}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       ext4_map_blocks+0x988/0x1d20 fs/ext4/inode.c:616
       mpage_map_one_extent fs/ext4/inode.c:2163 [inline]
       mpage_map_and_submit_extent fs/ext4/inode.c:2216 [inline]
       ext4_do_writepages+0x15e1/0x3ca0 fs/ext4/inode.c:2679
       ext4_writepages+0x213/0x3c0 fs/ext4/inode.c:2768
       do_writepages+0x3a4/0x670 mm/page-writeback.c:2553
       __writeback_single_inode+0x155/0xfd0 fs/fs-writeback.c:1650
       writeback_sb_inodes+0x8e4/0x1220 fs/fs-writeback.c:1941
       __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:2012
       wb_writeback+0x45b/0xc70 fs/fs-writeback.c:2119
       wb_check_background_flush fs/fs-writeback.c:2189 [inline]
       wb_do_writeback fs/fs-writeback.c:2277 [inline]
       wb_workfn+0xc33/0x1070 fs/fs-writeback.c:2304
       process_one_work kernel/workqueue.c:3143 [inline]
       process_scheduled_works+0x9d7/0x1730 kernel/workqueue.c:3223
       worker_thread+0x86d/0xd70 kernel/workqueue.c:3304
       kthread+0x2f0/0x390 kernel/kthread.c:388
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242

-> #1 (jbd2_handle){++++}-{0:0}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       start_this_handle+0x1fc7/0x2200 fs/jbd2/transaction.c:463
       jbd2__journal_start+0x306/0x620 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x215/0x5b0 fs/ext4/ext4_jbd2.c:112
       ext4_sample_last_mounted fs/ext4/file.c:837 [inline]
       ext4_file_open+0x53e/0x760 fs/ext4/file.c:866
       do_dentry_open+0x907/0x15a0 fs/open.c:953
       do_open fs/namei.c:3639 [inline]
       path_openat+0x2860/0x3240 fs/namei.c:3796
       do_filp_open+0x235/0x490 fs/namei.c:3823
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1404
       do_sys_open fs/open.c:1419 [inline]
       __do_sys_openat fs/open.c:1435 [inline]
       __se_sys_openat fs/open.c:1430 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1430
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #0 (sb_internal){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       percpu_down_read+0x44/0x1b0 include/linux/percpu-rwsem.h:51
       __sb_start_write include/linux/fs.h:1657 [inline]
       sb_start_intwrite include/linux/fs.h:1840 [inline]
       ext4_evict_inode+0x2e4/0xf30 fs/ext4/inode.c:212
       evict+0x2a8/0x630 fs/inode.c:666
       __dentry_kill+0x20d/0x630 fs/dcache.c:603
       shrink_kill+0xa9/0x2c0 fs/dcache.c:1048
       shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1075
       prune_dcache_sb+0x10f/0x180 fs/dcache.c:1156
       super_cache_scan+0x34f/0x4b0 fs/super.c:221
       do_shrink_slab+0x6d0/0x1140 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0x883/0x14d0 mm/shrinker.c:626
       shrink_one+0x423/0x7f0 mm/vmscan.c:4784
       shrink_many mm/vmscan.c:4845 [inline]
       lru_gen_shrink_node mm/vmscan.c:4946 [inline]
       shrink_node+0x358a/0x3b60 mm/vmscan.c:5905
       kswapd_shrink_node mm/vmscan.c:6712 [inline]
       balance_pgdat mm/vmscan.c:6903 [inline]
       kswapd+0x1815/0x3570 mm/vmscan.c:7162
       kthread+0x2f0/0x390 kernel/kthread.c:388
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242

other info that might help us debug this:

Chain exists of:
  sb_internal --> &ei->i_data_sem --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&ei->i_data_sem);
                               lock(fs_reclaim);
  rlock(sb_internal);

 *** DEADLOCK ***

2 locks held by kswapd0/87:
 #0: ffffffff8e21a620 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6790 [inline]
 #0: ffffffff8e21a620 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xb8a/0x3570 mm/vmscan.c:7162
 #1: ffff88802ed520e0 (&type->s_umount_key#31){++++}-{3:3}, at: super_trylock_shared fs/super.c:566 [inline]
 #1: ffff88802ed520e0 (&type->s_umount_key#31){++++}-{3:3}, at: super_cache_scan+0x94/0x4b0 fs/super.c:196

stack backtrace:
CPU: 1 PID: 87 Comm: kswapd0 Not tainted 6.8.0-rc3-next-20240209-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
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
 percpu_down_read+0x44/0x1b0 include/linux/percpu-rwsem.h:51
 __sb_start_write include/linux/fs.h:1657 [inline]
 sb_start_intwrite include/linux/fs.h:1840 [inline]
 ext4_evict_inode+0x2e4/0xf30 fs/ext4/inode.c:212
 evict+0x2a8/0x630 fs/inode.c:666
 __dentry_kill+0x20d/0x630 fs/dcache.c:603
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1048
 shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1075
 prune_dcache_sb+0x10f/0x180 fs/dcache.c:1156
 super_cache_scan+0x34f/0x4b0 fs/super.c:221
 do_shrink_slab+0x6d0/0x1140 mm/shrinker.c:435
 shrink_slab_memcg mm/shrinker.c:548 [inline]
 shrink_slab+0x883/0x14d0 mm/shrinker.c:626
 shrink_one+0x423/0x7f0 mm/vmscan.c:4784
 shrink_many mm/vmscan.c:4845 [inline]
 lru_gen_shrink_node mm/vmscan.c:4946 [inline]
 shrink_node+0x358a/0x3b60 mm/vmscan.c:5905
 kswapd_shrink_node mm/vmscan.c:6712 [inline]
 balance_pgdat mm/vmscan.c:6903 [inline]
 kswapd+0x1815/0x3570 mm/vmscan.c:7162
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
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

