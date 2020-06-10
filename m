Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127071F4EB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 09:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgFJHTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 03:19:22 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:53928 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgFJHTW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:19:22 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49hddz0HkhzcG;
        Wed, 10 Jun 2020 09:19:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591773559; bh=7gEYY7fEDHliIe4ICwlpvlUotLaIa5/Vi0eVTaTvsf4=;
        h=Date:From:To:Cc:Subject:From;
        b=RWPUr9CKHHz19QR4ikOHzJIOVVtcmJ/omgGqvqX1DQZswAuEOeiGgmVB8dY2P66in
         34yliL9OuGsBSjEiRQI0iPEGn4SqQzco4nryZRHbC+Odw5Rw6hBfe0KLDFSUNV0Mv6
         KjYJY1ro7EckAcLfAlGn51P8YSp0Pj3XynXc1ziLG35iGE4pH+uRiYGz1ekRlytFs5
         3rrGpWjgTVAE/EEZTJXvMApdaDJzFXrnwBAc5vObteoZU6gXmDRTu6dfT6+Bysvory
         CoY5QA2+0mu/kaO12riuZSZAtJR6X0iR/+5LjwPD9MJLTUG/lQOAxg3mSAERO/Zv/X
         iB47QCEtJkwmA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Wed, 10 Jun 2020 09:19:17 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Lockdep warning after `mdadm -S`
Message-ID: <20200610071916.GA2668@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Developers,

I found a lockdep warning in dmesg some after doing 'mdadm -S' while
also having btrfs mounted (light to none I/O load).  Disks under MD and
btrfs are unrelated.

Best Regards,
Micha³ Miros³aw

======================================================
WARNING: possible circular locking dependency detected
5.7.1mq+ #383 Tainted: G           O     
------------------------------------------------------
kworker/u16:3/8175 is trying to acquire lock:
ffff8882f19556a0 (sb_internal#3){.+.+}-{0:0}, at: start_transaction+0x37e/0x550 [btrfs]

but task is already holding lock:
ffffc900087c7e68 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x235/0x620

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #8 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}:
       __flush_work+0x331/0x490
       wb_shutdown+0x8f/0xb0
       bdi_unregister+0x72/0x1f0
       del_gendisk+0x2b0/0x2c0
       md_free+0x28/0x90
       kobject_put+0xa6/0x1b0
       process_one_work+0x2b6/0x620
       worker_thread+0x35/0x3e0
       kthread+0x143/0x160
       ret_from_fork+0x3a/0x50

-> #7 ((work_completion)(&mddev->del_work)){+.+.}-{0:0}:
       process_one_work+0x28d/0x620
       worker_thread+0x35/0x3e0
       kthread+0x143/0x160
       ret_from_fork+0x3a/0x50

-> #6 ((wq_completion)md_misc){+.+.}-{0:0}:
       flush_workqueue+0xa9/0x4e0
       __md_stop_writes+0x18/0x100
       do_md_stop+0x165/0x2d0
       md_ioctl+0xa52/0x1d60
       blkdev_ioctl+0x1cc/0x2a0
       block_ioctl+0x3a/0x40
       ksys_ioctl+0x81/0xc0
       __x64_sys_ioctl+0x11/0x20
       do_syscall_64+0x4f/0x210
       entry_SYSCALL_64_after_hwframe+0x49/0xb3

-> #5 (&mddev->open_mutex){+.+.}-{3:3}:
       __mutex_lock+0x93/0x9c0
       md_open+0x43/0xc0
       __blkdev_get+0xea/0x560
       blkdev_get+0x60/0x130
       do_dentry_open+0x147/0x3e0
       path_openat+0x84f/0xa80
       do_filp_open+0x8e/0x100
       do_sys_openat2+0x225/0x2e0
       do_sys_open+0x46/0x80
       do_syscall_64+0x4f/0x210
       entry_SYSCALL_64_after_hwframe+0x49/0xb3

-> #4 (&bdev->bd_mutex){+.+.}-{3:3}:
       __mutex_lock+0x93/0x9c0
       __blkdev_get+0x77/0x560
       blkdev_get+0x60/0x130
       blkdev_get_by_path+0x41/0x80
       btrfs_get_bdev_and_sb+0x16/0xb0 [btrfs]
       open_fs_devices+0x9d/0x240 [btrfs]
       btrfs_open_devices+0x89/0x90 [btrfs]
       btrfs_mount_root+0x26a/0x4b0 [btrfs]
       legacy_get_tree+0x2b/0x50
       vfs_get_tree+0x23/0xc0
       fc_mount+0x9/0x40
       vfs_kern_mount.part.40+0x57/0x80
       btrfs_mount+0x148/0x3f0 [btrfs]
       legacy_get_tree+0x2b/0x50
       vfs_get_tree+0x23/0xc0
       do_mount+0x712/0xa40
       __x64_sys_mount+0xbf/0xe0
       do_syscall_64+0x4f/0x210
       entry_SYSCALL_64_after_hwframe+0x49/0xb3

-> #3 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
       __mutex_lock+0x93/0x9c0
       btrfs_run_dev_stats+0x44/0x470 [btrfs]
       commit_cowonly_roots+0xac/0x2a0 [btrfs]
       btrfs_commit_transaction+0x511/0xa70 [btrfs]
       transaction_kthread+0x13c/0x160 [btrfs]
       kthread+0x143/0x160
       ret_from_fork+0x3a/0x50

-> #2 (&fs_info->tree_log_mutex){+.+.}-{3:3}:
       __mutex_lock+0x93/0x9c0
       btrfs_commit_transaction+0x4b6/0xa70 [btrfs]
       transaction_kthread+0x13c/0x160 [btrfs]
       kthread+0x143/0x160
       ret_from_fork+0x3a/0x50

-> #1 (&fs_info->reloc_mutex){+.+.}-{3:3}:
       __mutex_lock+0x93/0x9c0
       btrfs_record_root_in_trans+0x3e/0x60 [btrfs]
       start_transaction+0xcb/0x550 [btrfs]
       btrfs_mkdir+0x5c/0x1e0 [btrfs]
       vfs_mkdir+0x107/0x1d0
       do_mkdirat+0xe7/0x110
       do_syscall_64+0x4f/0x210
       entry_SYSCALL_64_after_hwframe+0x49/0xb3

-> #0 (sb_internal#3){.+.+}-{0:0}:
       __lock_acquire+0x11f9/0x1aa0
       lock_acquire+0x9e/0x380
       __sb_start_write+0x13a/0x270
       start_transaction+0x37e/0x550 [btrfs]
       cow_file_range_inline.constprop.74+0xe4/0x640 [btrfs]
       cow_file_range+0xe5/0x3f0 [btrfs]
       btrfs_run_delalloc_range+0x128/0x620 [btrfs]
       writepage_delalloc+0xe2/0x140 [btrfs]
       __extent_writepage+0x1a3/0x370 [btrfs]
       extent_write_cache_pages+0x2b8/0x470 [btrfs]
       extent_writepages+0x3f/0x90 [btrfs]
       do_writepages+0x3c/0xe0
       __writeback_single_inode+0x4f/0x650
       writeback_sb_inodes+0x1f7/0x560
       __writeback_inodes_wb+0x58/0xa0
       wb_writeback+0x33b/0x4b0
       wb_workfn+0x428/0x5b0
       process_one_work+0x2b6/0x620
       worker_thread+0x35/0x3e0
       kthread+0x143/0x160
       ret_from_fork+0x3a/0x50

other info that might help us debug this:

Chain exists of:
  sb_internal#3 --> (work_completion)(&mddev->del_work) --> (work_completion)(&(&wb->dwork)->work)

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((work_completion)(&(&wb->dwork)->work));
                               lock((work_completion)(&mddev->del_work));
                               lock((work_completion)(&(&wb->dwork)->work));
  lock(sb_internal#3);

 *** DEADLOCK ***

3 locks held by kworker/u16:3/8175:
 #0: ffff88840baa6948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x235/0x620
 #1: ffffc900087c7e68 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x235/0x620
 #2: ffff8882f19550e8 (&type->s_umount_key#52){++++}-{3:3}, at: trylock_super+0x11/0x50

stack backtrace:
CPU: 1 PID: 8175 Comm: kworker/u16:3 Tainted: G           O      5.7.1mq+ #383
Hardware name: System manufacturer System Product Name/P8Z68-V PRO, BIOS 3603 11/09/2012
Workqueue: writeback wb_workfn (flush-btrfs-1)
Call Trace:
 dump_stack+0x71/0xa0
 check_noncircular+0x165/0x180
 ? stack_trace_save+0x46/0x70
 __lock_acquire+0x11f9/0x1aa0
 lock_acquire+0x9e/0x380
 ? start_transaction+0x37e/0x550 [btrfs]
 __sb_start_write+0x13a/0x270
 ? start_transaction+0x37e/0x550 [btrfs]
 start_transaction+0x37e/0x550 [btrfs]
 ? kmem_cache_alloc+0x1b0/0x2c0
 cow_file_range_inline.constprop.74+0xe4/0x640 [btrfs]
 ? lock_acquire+0x9e/0x380
 ? test_range_bit+0x3d/0x130 [btrfs]
 cow_file_range+0xe5/0x3f0 [btrfs]
 btrfs_run_delalloc_range+0x128/0x620 [btrfs]
 ? find_lock_delalloc_range+0x1f3/0x220 [btrfs]
 writepage_delalloc+0xe2/0x140 [btrfs]
 __extent_writepage+0x1a3/0x370 [btrfs]
 extent_write_cache_pages+0x2b8/0x470 [btrfs]
 ? __lock_acquire+0x3fc/0x1aa0
 extent_writepages+0x3f/0x90 [btrfs]
 do_writepages+0x3c/0xe0
 ? find_held_lock+0x2d/0x90
 __writeback_single_inode+0x4f/0x650
 writeback_sb_inodes+0x1f7/0x560
 __writeback_inodes_wb+0x58/0xa0
 wb_writeback+0x33b/0x4b0
 wb_workfn+0x428/0x5b0
 ? sched_clock_cpu+0xe/0xd0
 process_one_work+0x2b6/0x620
 ? worker_thread+0xc7/0x3e0
 worker_thread+0x35/0x3e0
 ? process_one_work+0x620/0x620
 kthread+0x143/0x160
 ? kthread_park+0x80/0x80
 ret_from_fork+0x3a/0x50

