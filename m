Return-Path: <linux-fsdevel+bounces-38866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 884D3A09211
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 14:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E05B3A1237
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 13:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09966210184;
	Fri, 10 Jan 2025 13:31:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4601620E707
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736515889; cv=none; b=PlhX2rbgF+50rEIhat/DwaBS6G0Itp7fhOo2svoLN9HJV3aJNkTxYM3acGxinXox97BG9IheFkN72tHKGyC+SDEBo0KukNdhvKA5Rj5YgHm4UzwKvmH4PYxaElTcje7IRH5ueDIdyTUDMe4feA9JPBsk+QLFWzRQoYE9Qh29E/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736515889; c=relaxed/simple;
	bh=4JjU+QhaRritw/xCUJMLrtGOrGPFB0GvS3tuCCzGPcU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ufMmt158m0wg9xzbIYDgVIjM3203wFKN6ULHg3qfQ2v9SI4tUOm9x0JvYhc4K41+UiWDs/K2BkgX1TzeCAELjv4oAefuvXyGCalUZFYKqPhS9bt8F27TVdmLigkTelRgjypnYTM/J0COuoGouYfS7of7DPbBhVZ8AzU8fHn7iY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a81357cdc7so24436795ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 05:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736515886; x=1737120686;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WphgEzuaYUUQByTdeNPzPwrEMTPaTNDYuKQJr+97fi4=;
        b=uug9+4T2Ob+4g+1Gt1PUi4DQC9ltxYHApVsUu1MRxzjIFxHFl1OCFN+XzOYAQ4leTC
         7V7XpPwKlGqE5CyJivT7r/Yk/YqeIy3xnvXFphYhlFS+FRJ99s+tdBpekFDgjCe43o15
         3S4kFcXlqyI05eBmaBn1oUiW/teMJwRLFtqyGFNo37EmS3fVQak3BPg8nM5DDHIMuJi8
         q23Mwc5CK95M9iy7UiUmOL0fO8hjTgt6/AA1lW7XxYS+9ncdt4gjq6JNnO3Yun9WOC7A
         KFtfAUChilwZOrIOp37zmfUlF7BkGZSn6Hn3bg1DOw2P0hK9GirvgogfNyzM0BlKZLMH
         TppQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTiiPJK08J6A6RQpi20m8kR0uFe69nNGvWsxiRVN6NibMetrzkkjr00AwT77C6pUjUqVp9qUh7fnSL93GH@vger.kernel.org
X-Gm-Message-State: AOJu0YyHHsVzuw3FzwewWHFQYwbuQA/NWQgOD8c7r6fkE5tMBXSySNyF
	eyK8nN1iiPdgG5j7D1SCqkuBGu0OU652R9gS6aLtYT836+8XcNclDxfY2kFSjHZnjJowdwwslbw
	ohLlM1dNgdiDzVpk5DLUz7GoWb+WlrP4GyyBNifPnx5aPCUWxhWpJUU0=
X-Google-Smtp-Source: AGHT+IHi5jsw47jvByWO0LV7HF2kjVa4vqn4rp2Ca5rH2rRRq35lVfgehQ4xiJZp4y1j5Vjau5t6qbdWW/yETY8lFMBIyy4h+zyR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8c:b0:3ce:3565:629 with SMTP id
 e9e14a558f8ab-3ce4af94ad3mr49350845ab.1.1736515886371; Fri, 10 Jan 2025
 05:31:26 -0800 (PST)
Date: Fri, 10 Jan 2025 05:31:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6781212e.050a0220.216c54.000c.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in iterate_dir (2)
From: syzbot <syzbot+2220a1178b3b136ffbc2@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    56e6a3499e14 Merge tag 'trace-v6.13-rc5' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1107e6c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba7cde9482d6bb6
dashboard link: https://syzkaller.appspot.com/bug?extid=2220a1178b3b136ffbc2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b0c687f0b78b/disk-56e6a349.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a6a699950805/vmlinux-56e6a349.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18cded3d3aa6/bzImage-56e6a349.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2220a1178b3b136ffbc2@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc5-syzkaller-00006-g56e6a3499e14 #0 Not tainted
------------------------------------------------------
syz.9.3502/20118 is trying to acquire lock:
ffff88805716cde0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:153

but task is already holding lock:
ffff888148c00148 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: iterate_dir+0x20c/0x800 fs/readdir.c:101

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (&sb->s_type->i_mutex_key#3){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:818 [inline]
       start_creating+0x130/0x310 fs/debugfs/inode.c:374
       debugfs_create_dir+0x25/0x430 fs/debugfs/inode.c:582
       blk_register_queue+0x194/0x400 block/blk-sysfs.c:775
       add_disk_fwnode+0x648/0xf80 block/genhd.c:493
       add_disk include/linux/blkdev.h:753 [inline]
       brd_alloc+0x547/0x790 drivers/block/brd.c:401
       brd_init+0x126/0x1b0 drivers/block/brd.c:481
       do_one_initcall+0x248/0x870 init/main.c:1266
       do_initcall_level+0x157/0x210 init/main.c:1328
       do_initcalls+0x3f/0x80 init/main.c:1344
       kernel_init_freeable+0x435/0x5d0 init/main.c:1577
       kernel_init+0x1d/0x2b0 init/main.c:1466
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #5 (&q->debugfs_mutex){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       blk_mq_init_sched+0x3fa/0x830 block/blk-mq-sched.c:473
       elevator_init_mq+0x20e/0x320 block/elevator.c:610
       add_disk_fwnode+0x10d/0xf80 block/genhd.c:413
       sd_probe+0xba6/0x1100 drivers/scsi/sd.c:4024
       really_probe+0x2b8/0xad0 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
       bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x22d/0x300 drivers/base/dd.c:987
       async_run_entry_fn+0xa8/0x420 kernel/async.c:129
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #4 (&q->q_usage_counter(queue)#50){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       blk_queue_enter+0xe1/0x600 block/blk-core.c:328
       blk_mq_alloc_request+0x4fa/0xaa0 block/blk-mq.c:652
       scsi_alloc_request drivers/scsi/scsi_lib.c:1222 [inline]
       scsi_execute_cmd+0x177/0x1090 drivers/scsi/scsi_lib.c:304
       read_capacity_16+0x2b4/0x1450 drivers/scsi/sd.c:2655
       sd_read_capacity drivers/scsi/sd.c:2824 [inline]
       sd_revalidate_disk+0x1013/0xbce0 drivers/scsi/sd.c:3734
       sd_probe+0x9fa/0x1100 drivers/scsi/sd.c:4010
       really_probe+0x2b8/0xad0 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
       bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x22d/0x300 drivers/base/dd.c:987
       async_run_entry_fn+0xa8/0x420 kernel/async.c:129
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #3 (&q->limits_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       queue_limits_start_update include/linux/blkdev.h:947 [inline]
       __nbd_set_size drivers/block/nbd.c:351 [inline]
       nbd_set_size+0x2e0/0x8f0 drivers/block/nbd.c:388
       nbd_start_device_ioctl drivers/block/nbd.c:1464 [inline]
       __nbd_ioctl drivers/block/nbd.c:1539 [inline]
       nbd_ioctl+0x5dc/0xf40 drivers/block/nbd.c:1579
       blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&q->q_usage_counter(io)#50){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3090
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       submit_bh fs/buffer.c:2819 [inline]
       block_read_full_folio+0x9b3/0xae0 fs/buffer.c:2446
       filemap_read_folio+0x148/0x3b0 mm/filemap.c:2366
       filemap_update_page mm/filemap.c:2450 [inline]
       filemap_get_pages+0x18ca/0x2080 mm/filemap.c:2571
       filemap_read+0x452/0xf50 mm/filemap.c:2646
       blkdev_read_iter+0x2d8/0x430 block/fops.c:770
       new_sync_read fs/read_write.c:484 [inline]
       vfs_read+0x991/0xb70 fs/read_write.c:565
       ksys_read+0x18f/0x2b0 fs/read_write.c:708
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (mapping.invalidate_lock#2){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       page_cache_ra_unbounded+0x142/0x720 mm/readahead.c:226
       do_async_mmap_readahead mm/filemap.c:3231 [inline]
       filemap_fault+0x818/0x1490 mm/filemap.c:3330
       __do_fault+0x135/0x390 mm/memory.c:4907
       do_read_fault mm/memory.c:5322 [inline]
       do_fault mm/memory.c:5456 [inline]
       do_pte_missing mm/memory.c:3979 [inline]
       handle_pte_fault+0x39eb/0x5ed0 mm/memory.c:5801
       __handle_mm_fault mm/memory.c:5944 [inline]
       handle_mm_fault+0x1053/0x1ad0 mm/memory.c:6112
       faultin_page mm/gup.c:1196 [inline]
       __get_user_pages+0x1c82/0x49e0 mm/gup.c:1494
       __get_user_pages_locked mm/gup.c:1760 [inline]
       get_dump_page+0x155/0x2f0 mm/gup.c:2278
       dump_user_range+0x14d/0x970 fs/coredump.c:943
       elf_core_dump+0x3e9f/0x4790 fs/binfmt_elf.c:2129
       do_coredump+0x229b/0x3100 fs/coredump.c:758
       get_signal+0x140b/0x1750 kernel/signal.c:3002
       arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
       exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
       irqentry_exit_to_user_mode+0x7e/0x250 kernel/entry/common.c:231
       exc_page_fault+0x590/0x8b0 arch/x86/mm/fault.c:1542
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #0 (&mm->mmap_lock){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read_killable+0xca/0xd30 kernel/locking/rwsem.c:1547
       mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:153
       get_mmap_lock_carefully mm/memory.c:6158 [inline]
       lock_mm_and_find_vma+0x29c/0x2f0 mm/memory.c:6209
       do_user_addr_fault arch/x86/mm/fault.c:1361 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x1bf/0x8b0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       filldir64+0x2b1/0x690 fs/readdir.c:371
       dir_emit include/linux/fs.h:3745 [inline]
       dcache_readdir+0x3a5/0x650 fs/libfs.c:209
       iterate_dir+0x571/0x800 fs/readdir.c:108
       __do_sys_getdents64 fs/readdir.c:403 [inline]
       __se_sys_getdents64+0x1e2/0x4b0 fs/readdir.c:389
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> &q->debugfs_mutex --> &sb->s_type->i_mutex_key#3

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&sb->s_type->i_mutex_key#3);
                               lock(&q->debugfs_mutex);
                               lock(&sb->s_type->i_mutex_key#3);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

2 locks held by syz.9.3502/20118:
 #0: ffff888031ce1978 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x254/0x320 fs/file.c:1191
 #1: ffff888148c00148 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: iterate_dir+0x20c/0x800 fs/readdir.c:101

stack backtrace:
CPU: 1 UID: 0 PID: 20118 Comm: syz.9.3502 Not tainted 6.13.0-rc5-syzkaller-00006-g56e6a3499e14 #0
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
 down_read_killable+0xca/0xd30 kernel/locking/rwsem.c:1547
 mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:153
 get_mmap_lock_carefully mm/memory.c:6158 [inline]
 lock_mm_and_find_vma+0x29c/0x2f0 mm/memory.c:6209
 do_user_addr_fault arch/x86/mm/fault.c:1361 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x1bf/0x8b0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:filldir64+0x2b1/0x690 fs/readdir.c:372
Code: 87 56 02 00 00 0f 01 cb 0f ae e8 48 8b 44 24 58 49 89 46 08 48 8b 4c 24 18 48 8b 44 24 50 48 89 01 48 8b 44 24 20 8b 54 24 34 <66> 89 41 10 88 51 12 4d 63 f7 42 c6 44 31 13 00 48 8d 69 13 bf 07
RSP: 0018:ffffc900043a7c58 EFLAGS: 00050283
RAX: 0000000000000018 RBX: 0000000020001008 RCX: 0000000020000ff0
RDX: 0000000000000004 RSI: 0000000020000fc8 RDI: 0000000020001008
RBP: 00007ffffffff000 R08: ffffffff821a39fa R09: 1ffff1100549cb40
R10: dffffc0000000000 R11: ffffed100549cb41 R12: ffff888148fdd500
R13: ffffc900043a7e50 R14: 0000000020000fc8 R15: 0000000000000003
 dir_emit include/linux/fs.h:3745 [inline]
 dcache_readdir+0x3a5/0x650 fs/libfs.c:209
 iterate_dir+0x571/0x800 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:403 [inline]
 __se_sys_getdents64+0x1e2/0x4b0 fs/readdir.c:389
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6a8d785d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6a8e580038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f6a8d976160 RCX: 00007f6a8d785d29
RDX: 0000000000001000 RSI: 0000000020000f80 RDI: 0000000000000007
RBP: 00007f6a8d801b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f6a8d976160 R15: 00007ffdc8c39ca8
 </TASK>
----------------
Code disassembly (best guess):
   0:	87 56 02             	xchg   %edx,0x2(%rsi)
   3:	00 00                	add    %al,(%rax)
   5:	0f 01 cb             	stac
   8:	0f ae e8             	lfence
   b:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
  10:	49 89 46 08          	mov    %rax,0x8(%r14)
  14:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
  19:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  1e:	48 89 01             	mov    %rax,(%rcx)
  21:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  26:	8b 54 24 34          	mov    0x34(%rsp),%edx
* 2a:	66 89 41 10          	mov    %ax,0x10(%rcx) <-- trapping instruction
  2e:	88 51 12             	mov    %dl,0x12(%rcx)
  31:	4d 63 f7             	movslq %r15d,%r14
  34:	42 c6 44 31 13 00    	movb   $0x0,0x13(%rcx,%r14,1)
  3a:	48 8d 69 13          	lea    0x13(%rcx),%rbp
  3e:	bf                   	.byte 0xbf
  3f:	07                   	(bad)


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

