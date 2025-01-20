Return-Path: <linux-fsdevel+bounces-39697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61777A170C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339F516B1F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680B41EBFF9;
	Mon, 20 Jan 2025 16:50:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D641EB9E3
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737391831; cv=none; b=favseMCj5Pxuf+qldJBOIcKq1R1SaNOeIhCWizjvVu9rgvc8dOb/ShUXHwFQciFq8G5iL0n/BcHXDFzecThKhT0PRp/5SUNmflz2beRTtfam1uI/Xo4M5x0mkEitDDdFGRpeVXWoLoQ6/ncPUz2O4/RA49phgc1AMMwQDyMWSMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737391831; c=relaxed/simple;
	bh=66e33UUKuqz2jBevn7hTity0J+/B0V1MdB2IhVZ21GY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qczg620CAm1k75OiHwFOtxiUbbF9AnyuwKOs7/JQruYPD6HGH2CjyKrHmxUAfTUQ4C45HPhgZpCOcUZEK4ymKuehmuA4K0xHcfybYBLVXopk2/tNyALI5CaIer4TjzZsHwhXNAY2jNvamhZkxZs1a2I3ZJXto5uV8gAHcSV/gP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3cdd61a97easo30335065ab.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 08:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737391828; x=1737996628;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gfknIDdjlUM/Ijl06JZos6xriIl/OMJu13vMcEnLJ8=;
        b=k22CLuBO6Bono1KiUMkMwgSzDV72ujUzIiS8U5Gqr2I3PVzZAP+JIKr5g2ZKhMqCYw
         6pjU3i0Z87f/J1AV3w9+1MKOj5gxL1GnyM4CoiZf8WgrCBSn3gH13QeryyqvfJHtJyvw
         aPxVP14ybfyP2KPxvu7w5zSF6c6Pew3r+l6N3auilGscuNROljrO9mWEE4XNV773PrQf
         YecXJOBqvTn7bFjMM17o/A/IAhXzOv+hMPWvq8ldnmRMLUXd5FCZAsZBVQpDodJRm6jx
         1Tx4IymSS33JwKlF8vSfvxhL2IA9Oez3ZZM8a9jYMcpWuEgDtj5KApZNxi5KJCY74Wqi
         qi4g==
X-Forwarded-Encrypted: i=1; AJvYcCUrTwf5/LHnsakVTRzId5BZoIwcyIrBBYG1pjt/tp9nZV3d8d3hAXlP8l40M2TggGfdQgQdgzQ/GVOnCgyv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6lRriN6YDvW/FMpDZEFlh/to69b/BafxKcuMfIr0dm9uQ97p0
	zIRePEB/7MyQVOahoq9E0wJn9CuDH19VDza94CI7db8vJ6IH3laXaViOdpKfyGrURsTKpfzA7Ob
	bO39Sx9jMQLjGY8WBqPKU2UWXJ7pNmSKmw5jw1SOsTCIZmmZ0BXbdFEI=
X-Google-Smtp-Source: AGHT+IEQbLbR6t9CiIKBMTyeyeUdmab34NeR7w48hgSvnLJQnIwNP4arnVoKL5nauVs4e+EYNn/gDtuwXEDWu18gTkxDShbM50cP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:221d:b0:3ce:78e5:d36d with SMTP id
 e9e14a558f8ab-3cf744199c7mr119791855ab.12.1737391828179; Mon, 20 Jan 2025
 08:50:28 -0800 (PST)
Date: Mon, 20 Jan 2025 08:50:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678e7ed4.050a0220.303755.0080.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in v2_read_dquot
From: syzbot <syzbot+a90d1040934e15a19762@syzkaller.appspotmail.com>
To: jack@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5428dc1906dd Merge tag 'exfat-for-6.13-rc7' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14dc79c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ef22c4fce5135b4
dashboard link: https://syzkaller.appspot.com/bug?extid=a90d1040934e15a19762
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/031c28a69d2f/disk-5428dc19.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ba871b8b8623/vmlinux-5428dc19.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f1dd2b4ec40e/bzImage-5428dc19.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a90d1040934e15a19762@syzkaller.appspotmail.com

EXT4-fs (loop9): revision level too high, forcing read-only mode
EXT4-fs (loop9): orphan cleanup on readonly fs
======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc6-syzkaller-00006-g5428dc1906dd #0 Not tainted
------------------------------------------------------
syz.9.3881/16245 is trying to acquire lock:
ffff8880604fc210 (&s->s_dquot.dqio_sem){++++}-{4:4}, at: v2_read_dquot+0x57/0x200 fs/quota/quota_v2.c:342

but task is already holding lock:
ffff88805500c5e8 (&dquot->dq_lock){+.+.}-{4:4}, at: dquot_acquire+0x69/0x680 fs/quota/dquot.c:458

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #8 (&dquot->dq_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       wait_on_dquot fs/quota/dquot.c:354 [inline]
       dqget+0x6e6/0xeb0 fs/quota/dquot.c:972
       dquot_transfer+0x482/0x6d0 fs/quota/dquot.c:2154
       ext4_setattr+0xb49/0x1da0 fs/ext4/inode.c:5400
       notify_change+0xbcc/0xe90 fs/attr.c:552
       chown_common+0x501/0x850 fs/open.c:778
       do_fchownat+0x16a/0x240 fs/open.c:809
       __do_sys_lchown fs/open.c:834 [inline]
       __se_sys_lchown fs/open.c:832 [inline]
       __x64_sys_lchown+0x85/0xa0 fs/open.c:832
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #7 (&ei->xattr_sem){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       ext4_readpage_inline+0x36/0x590 fs/ext4/inline.c:518
       ext4_read_folio+0x174/0x340 fs/ext4/inode.c:3185
       filemap_read_folio+0x14a/0x3b0 mm/filemap.c:2357
       filemap_create_folio mm/filemap.c:2488 [inline]
       filemap_get_pages+0x1099/0x2080 mm/filemap.c:2546
       filemap_read+0x452/0xf50 mm/filemap.c:2637
       __kernel_read+0x515/0x9d0 fs/read_write.c:523
       integrity_kernel_read+0xb0/0x100 security/integrity/iint.c:28
       ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
       ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
       ima_calc_file_hash+0xae6/0x1b30 security/integrity/ima/ima_crypto.c:568
       ima_collect_measurement+0x520/0xb10 security/integrity/ima/ima_api.c:293
       process_measurement+0x1351/0x1fb0 security/integrity/ima/ima_main.c:372
       ima_file_check+0xd9/0x120 security/integrity/ima/ima_main.c:572
       security_file_post_open+0xb9/0x280 security/security.c:3121
       do_open fs/namei.c:3830 [inline]
       path_openat+0x2ccd/0x3590 fs/namei.c:3987
       do_filp_open+0x27f/0x4e0 fs/namei.c:4014
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
       do_sys_open fs/open.c:1417 [inline]
       __do_sys_openat fs/open.c:1433 [inline]
       __se_sys_openat fs/open.c:1428 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1428
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (mapping.invalidate_lock){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       page_cache_ra_unbounded+0x142/0x720 mm/readahead.c:226
       do_async_mmap_readahead mm/filemap.c:3222 [inline]
       filemap_fault+0x818/0x1490 mm/filemap.c:3321
       __do_fault+0x137/0x390 mm/memory.c:4907
       do_read_fault mm/memory.c:5322 [inline]
       do_fault mm/memory.c:5456 [inline]
       do_pte_missing mm/memory.c:3979 [inline]
       handle_pte_fault+0x39eb/0x5ed0 mm/memory.c:5801
       __handle_mm_fault mm/memory.c:5944 [inline]
       handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
       faultin_page mm/gup.c:1196 [inline]
       __get_user_pages+0x1c82/0x49e0 mm/gup.c:1494
       __get_user_pages_locked mm/gup.c:1760 [inline]
       get_dump_page+0x155/0x2f0 mm/gup.c:2278
       dump_user_range+0x14d/0x970 fs/coredump.c:943
       elf_core_dump+0x3e9f/0x4790 fs/binfmt_elf.c:2129
       do_coredump+0x229d/0x3100 fs/coredump.c:758
       get_signal+0x140b/0x1750 kernel/signal.c:3002
       arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
       exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
       irqentry_exit_to_user_mode+0x7e/0x250 kernel/entry/common.c:231
       exc_page_fault+0x590/0x8b0 arch/x86/mm/fault.c:1542
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #5 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __might_fault+0xc6/0x120 mm/memory.c:6751
       _inline_copy_from_user include/linux/uaccess.h:162 [inline]
       _copy_from_user+0x2a/0xc0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:212 [inline]
       __blk_trace_setup kernel/trace/blktrace.c:626 [inline]
       blk_trace_ioctl+0x1ad/0x9a0 kernel/trace/blktrace.c:740
       blkdev_ioctl+0x40c/0x6a0 block/ioctl.c:682
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf7/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&q->debugfs_mutex){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       blk_mq_init_sched+0x3fa/0x830 block/blk-mq-sched.c:473
       elevator_init_mq+0x20e/0x320 block/elevator.c:610
       add_disk_fwnode+0x10d/0xf80 block/genhd.c:413
       sd_probe+0xba6/0x1100 drivers/scsi/sd.c:4024
       really_probe+0x2ba/0xad0 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
       bus_for_each_drv+0x250/0x2e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x22d/0x300 drivers/base/dd.c:987
       async_run_entry_fn+0xaa/0x420 kernel/async.c:129
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f2/0x390 kernel/kthread.c:389
       ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #3 (&q->q_usage_counter(queue)#50){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       blk_queue_enter+0xe1/0x600 block/blk-core.c:328
       blk_mq_alloc_request+0x4fa/0xaa0 block/blk-mq.c:652
       scsi_alloc_request drivers/scsi/scsi_lib.c:1222 [inline]
       scsi_execute_cmd+0x177/0x1090 drivers/scsi/scsi_lib.c:304
       read_capacity_16+0x2b4/0x1450 drivers/scsi/sd.c:2655
       sd_read_capacity drivers/scsi/sd.c:2824 [inline]
       sd_revalidate_disk+0x1013/0xbce0 drivers/scsi/sd.c:3734
       sd_probe+0x9fa/0x1100 drivers/scsi/sd.c:4010
       really_probe+0x2ba/0xad0 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
       bus_for_each_drv+0x250/0x2e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x22d/0x300 drivers/base/dd.c:987
       async_run_entry_fn+0xaa/0x420 kernel/async.c:129
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f2/0x390 kernel/kthread.c:389
       ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #2 (&q->limits_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       queue_limits_start_update include/linux/blkdev.h:947 [inline]
       loop_reconfigure_limits+0x43f/0x900 drivers/block/loop.c:998
       loop_set_block_size drivers/block/loop.c:1473 [inline]
       lo_simple_ioctl drivers/block/loop.c:1496 [inline]
       lo_ioctl+0x1351/0x1f50 drivers/block/loop.c:1559
       blkdev_ioctl+0x57f/0x6a0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf7/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#23){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3090
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       __ext4_read_bh fs/ext4/super.c:181 [inline]
       ext4_read_bh+0x1d7/0x290 fs/ext4/super.c:206
       ext4_bread+0x135/0x180 fs/ext4/inode.c:918
       ext4_quota_read+0x1b8/0x2d0 fs/ext4/super.c:7239
       read_blk fs/quota/quota_tree.c:61 [inline]
       find_free_dqentry+0x1dc/0xc30 fs/quota/quota_tree.c:275
       do_insert_tree+0x8ca/0x1490 fs/quota/quota_tree.c:400
       do_insert_tree+0xbd6/0x1490 fs/quota/quota_tree.c:402
       do_insert_tree+0xbd6/0x1490 fs/quota/quota_tree.c:402
       do_insert_tree+0xb90/0x1490 fs/quota/quota_tree.c:402
       dq_insert_tree fs/quota/quota_tree.c:432 [inline]
       qtree_write_dquot+0x496/0x5b0 fs/quota/quota_tree.c:451
       v2_write_dquot+0x17a/0x270 fs/quota/quota_v2.c:372
       dquot_acquire+0x351/0x680 fs/quota/dquot.c:470
       ext4_acquire_dquot+0x301/0x4c0 fs/ext4/super.c:6934
       dqget+0x772/0xeb0 fs/quota/dquot.c:977
       __dquot_initialize+0x468/0xec0 fs/quota/dquot.c:1505
       ext4_xattr_set+0x109/0x3e0 fs/ext4/xattr.c:2544
       __vfs_setxattr+0x46a/0x4a0 fs/xattr.c:200
       __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
       vfs_setxattr+0x221/0x430 fs/xattr.c:321
       do_setxattr fs/xattr.c:636 [inline]
       filename_setxattr+0x2af/0x430 fs/xattr.c:665
       path_setxattrat+0x440/0x510 fs/xattr.c:713
       __do_sys_setxattr fs/xattr.c:747 [inline]
       __se_sys_setxattr fs/xattr.c:743 [inline]
       __x64_sys_setxattr+0xbc/0xe0 fs/xattr.c:743
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&s->s_dquot.dqio_sem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       v2_read_dquot+0x57/0x200 fs/quota/quota_v2.c:342
       dquot_acquire+0x194/0x680 fs/quota/dquot.c:461
       ext4_acquire_dquot+0x301/0x4c0 fs/ext4/super.c:6934
       dqget+0x772/0xeb0 fs/quota/dquot.c:977
       __dquot_initialize+0x2e3/0xec0 fs/quota/dquot.c:1505
       ext4_process_orphan+0x57/0x2d0 fs/ext4/orphan.c:329
       ext4_orphan_cleanup+0xb77/0x13d0 fs/ext4/orphan.c:474
       __ext4_fill_super fs/ext4/super.c:5610 [inline]
       ext4_fill_super+0x64dc/0x6e60 fs/ext4/super.c:5733
       get_tree_bdev_flags+0x48e/0x5c0 fs/super.c:1636
       vfs_get_tree+0x92/0x2b0 fs/super.c:1814
       do_new_mount+0x2be/0xb40 fs/namespace.c:3507
       do_mount fs/namespace.c:3847 [inline]
       __do_sys_mount fs/namespace.c:4057 [inline]
       __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &s->s_dquot.dqio_sem --> &ei->xattr_sem --> &dquot->dq_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&dquot->dq_lock);
                               lock(&ei->xattr_sem);
                               lock(&dquot->dq_lock);
  rlock(&s->s_dquot.dqio_sem);

 *** DEADLOCK ***

2 locks held by syz.9.3881/16245:
 #0: ffff8880604fc0e0 (&type->s_umount_key#27/1){+.+.}-{4:4}, at: alloc_super+0x221/0x9d0 fs/super.c:344
 #1: ffff88805500c5e8 (&dquot->dq_lock){+.+.}-{4:4}, at: dquot_acquire+0x69/0x680 fs/quota/dquot.c:458

stack backtrace:
CPU: 0 UID: 0 PID: 16245 Comm: syz.9.3881 Not tainted 6.13.0-rc6-syzkaller-00006-g5428dc1906dd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
 v2_read_dquot+0x57/0x200 fs/quota/quota_v2.c:342
 dquot_acquire+0x194/0x680 fs/quota/dquot.c:461
 ext4_acquire_dquot+0x301/0x4c0 fs/ext4/super.c:6934
 dqget+0x772/0xeb0 fs/quota/dquot.c:977
 __dquot_initialize+0x2e3/0xec0 fs/quota/dquot.c:1505
 ext4_process_orphan+0x57/0x2d0 fs/ext4/orphan.c:329
 ext4_orphan_cleanup+0xb77/0x13d0 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5610 [inline]
 ext4_fill_super+0x64dc/0x6e60 fs/ext4/super.c:5733
 get_tree_bdev_flags+0x48e/0x5c0 fs/super.c:1636
 vfs_get_tree+0x92/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f55ffd874ca
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5600b1ce68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f5600b1cef0 RCX: 00007f55ffd874ca
RDX: 0000000020000140 RSI: 0000000020000580 RDI: 00007f5600b1ceb0
RBP: 0000000020000140 R08: 00007f5600b1cef0 R09: 0000000000008205
R10: 0000000000008205 R11: 0000000000000246 R12: 0000000020000580
R13: 00007f5600b1ceb0 R14: 0000000000000618 R15: 000000000000002c
 </TASK>
EXT4-fs error (device loop9) in ext4_reserve_inode_write:5837: Corrupt filesystem
EXT4-fs (loop9): Remounting filesystem read-only
Quota error (device loop9): write_blk: dquota write failed
Quota error (device loop9): write_blk: dquota write failed
Quota error (device loop9): qtree_write_dquot: Error -28 occurred while creating quota
Quota error (device loop9): v2_write_file_info: Can't write info structure
EXT4-fs (loop9): 1 orphan inode deleted
EXT4-fs (loop9): mounted filesystem 00000000-0000-0000-0000-000000000000 ro without journal. Quota mode: none.


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

