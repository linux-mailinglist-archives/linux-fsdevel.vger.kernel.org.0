Return-Path: <linux-fsdevel+bounces-38834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E10A08847
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 07:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C943A1D0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C622063ED;
	Fri, 10 Jan 2025 06:23:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512317B500
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736490205; cv=none; b=VLY9OvhXe5n9K9v1wcH8oW6EqN47jNF5qS+XlQizxHOscQb14AoPnOO1fuxzjF+uHgHN0+LSJwn1+I43RNiNUuDSgNPguqVFsTo7coJfnqhrtJNA19jfu/IgkoHSgnMUCf0TYJ1Eq+QYyHEG7upckppjzPcV9Nmz55LUvP79WS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736490205; c=relaxed/simple;
	bh=zuydqTbpJVmKCppgFRphFCiPHDXdRoz7PS0SjlGoOdQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RhQ1ZiCBlXk297/SGtlI5XBOQuvSgDklMPk01QCp+ZWexpUGhpKbfnRRN34bNwizs2crSANxcrUwz91bMZ+jFDkMq2zmcM9SUk5xqPbQfiM9V6bf8xJaVBkMCmgM9nKoEwj3vv8SHGFom/hS5CJc7Ikdq83+zzIr86rit6BjZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ac98b49e4dso15150995ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2025 22:23:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736490201; x=1737095001;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m/4TZLx8pJXbwqvrOZgR/URNnN9ChT/1nWxCpomeSRQ=;
        b=G6F8EceSyPrHy551hz7v5lkT0aNM3/iQSJ1GMy3VDrle8KPFP5J+pNhO66JIGODTut
         pitAyKvxd3fRe/OMQnvNxjFmkx+rjOcy3yC7SO5gPERkGK82ZDOsP+znkHWTzk8HnLU5
         JnIIzWSCUvb2ajj2DF2XrWEwpRXNWryrV0lWImEFeshyhyAH7K8FlEECygpOlnXcAH3j
         muJK7a60ohx1eSb8kMlyG65oYhNFA4FFT66k0SU5/rW1u76aUek7Su4b342evur5gXGr
         pNS2k6rNWQJ0xRTNzxu9JQYYJGmlzUUzdPy8AIEk5LCDUhMtvgUFYRdGJzNmjZ5/MqlV
         B/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWi8Xg/yKLJNVzutpsO4dK1YI2FshYgcY28k95ErAx7FTAHtIV7CWEqAmhzzdp7SNARr9NyK7iYqUlY+BBw@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo4MK3OR4YFpMq2Gx1O5W/UDZuHD7ciB5zu4ahdZuW7Oe/n3An
	SMcUJnobCYKg8mISM3SK2am5qT4e9gah/Jk7Zw0/YUVEtSnK6iAoUHPbTY92GCRmoxnOlRbgivJ
	seT2Fj8EPemFfqIXgeflqWxgDID/zbOMXPmSXyhOiugyKbTsglI+/NHE=
X-Google-Smtp-Source: AGHT+IEDjgGHPv1W2sYBQCX1W7maoqsX0P2d3838VlzUb5ePaQBvsvN69K13dlPATOOpJWHXPP2qF+cSctbd5qb5R8U2PojQ2c3N
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214f:b0:3a7:e528:6ee6 with SMTP id
 e9e14a558f8ab-3ce3a888287mr71139445ab.13.1736490201589; Thu, 09 Jan 2025
 22:23:21 -0800 (PST)
Date: Thu, 09 Jan 2025 22:23:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6780bcd9.050a0220.216c54.0009.GAE@google.com>
Subject: [syzbot] [exfat?] possible deadlock in exfat_get_block (2)
From: syzbot <syzbot+32b7df93cfaf0062bf37@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ab75170520d4 Merge tag 'linux-watchdog-6.13-rc6' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a836f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c541fa8af5c9cc7
dashboard link: https://syzkaller.appspot.com/bug?extid=32b7df93cfaf0062bf37
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4d752d5dc5aa/disk-ab751705.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/146ff38a4872/vmlinux-ab751705.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d68e63897d18/bzImage-ab751705.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+32b7df93cfaf0062bf37@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc5-syzkaller-00163-gab75170520d4 #0 Not tainted
------------------------------------------------------
syz.7.4118/20433 is trying to acquire lock:
ffff88805d2f40e8 (&sbi->s_lock#2){+.+.}-{4:4}, at: exfat_get_block+0x1c3/0x2180 fs/exfat/inode.c:278

but task is already holding lock:
ffff8880127232a0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
ffff8880127232a0 (&mm->mmap_lock){++++}-{4:4}, at: get_mmap_lock_carefully mm/memory.c:6149 [inline]
ffff8880127232a0 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0x32/0x2f0 mm/memory.c:6209

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

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

-> #1 (&q->q_usage_counter(io)#24){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3090
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       submit_bh fs/buffer.c:2819 [inline]
       __sync_dirty_buffer+0x23d/0x390 fs/buffer.c:2857
       exfat_set_volume_dirty+0x5d/0x80 fs/exfat/super.c:124
       exfat_create+0x190/0x570 fs/exfat/namei.c:564
       lookup_open fs/namei.c:3649 [inline]
       open_last_lookups fs/namei.c:3748 [inline]
       path_openat+0x1c05/0x3590 fs/namei.c:3984
       do_filp_open+0x27f/0x4e0 fs/namei.c:4014
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
       do_sys_open fs/open.c:1417 [inline]
       __do_sys_openat fs/open.c:1433 [inline]
       __se_sys_openat fs/open.c:1428 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1428
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sbi->s_lock#2){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       exfat_get_block+0x1c3/0x2180 fs/exfat/inode.c:278
       __block_write_begin_int+0x694/0x19a0 fs/buffer.c:2116
       block_write_begin+0x8f/0x120 fs/buffer.c:2226
       exfat_write_begin+0xfb/0x240 fs/exfat/inode.c:434
       exfat_extend_valid_size+0x1f8/0x340 fs/exfat/file.c:553
       exfat_page_mkwrite+0x16e/0x220 fs/exfat/file.c:649
       do_page_mkwrite+0x15e/0x350 mm/memory.c:3176
       do_shared_fault mm/memory.c:5398 [inline]
       do_fault mm/memory.c:5460 [inline]
       do_pte_missing mm/memory.c:3979 [inline]
       handle_pte_fault+0x10c6/0x5ed0 mm/memory.c:5801
       __handle_mm_fault mm/memory.c:5944 [inline]
       handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
       do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x2b9/0x8b0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
       raw_copy_to_user arch/x86/include/asm/uaccess_64.h:147 [inline]
       _inline_copy_to_user include/linux/uaccess.h:197 [inline]
       _copy_to_user+0x86/0xb0 lib/usercopy.c:26
       copy_to_user include/linux/uaccess.h:225 [inline]
       cp_new_stat+0x545/0x6e0 fs/stat.c:496
       __do_sys_newfstat fs/stat.c:543 [inline]
       __se_sys_newfstat fs/stat.c:537 [inline]
       __x64_sys_newfstat+0x16c/0x1c0 fs/stat.c:537
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &sbi->s_lock#2 --> &q->debugfs_mutex --> &mm->mmap_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&mm->mmap_lock);
                               lock(&q->debugfs_mutex);
                               lock(&mm->mmap_lock);
  lock(&sbi->s_lock#2);

 *** DEADLOCK ***

2 locks held by syz.7.4118/20433:
 #0: ffff8880127232a0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
 #0: ffff8880127232a0 (&mm->mmap_lock){++++}-{4:4}, at: get_mmap_lock_carefully mm/memory.c:6149 [inline]
 #0: ffff8880127232a0 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0x32/0x2f0 mm/memory.c:6209
 #1: ffff88805bbaafb0 (&sb->s_type->i_mutex_key#35){+.+.}-{4:4}, at: inode_trylock include/linux/fs.h:838 [inline]
 #1: ffff88805bbaafb0 (&sb->s_type->i_mutex_key#35){+.+.}-{4:4}, at: exfat_page_mkwrite+0x8f/0x220 fs/exfat/file.c:641

stack backtrace:
CPU: 0 UID: 0 PID: 20433 Comm: syz.7.4118 Not tainted 6.13.0-rc5-syzkaller-00163-gab75170520d4 #0
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
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
 exfat_get_block+0x1c3/0x2180 fs/exfat/inode.c:278
 __block_write_begin_int+0x694/0x19a0 fs/buffer.c:2116
 block_write_begin+0x8f/0x120 fs/buffer.c:2226
 exfat_write_begin+0xfb/0x240 fs/exfat/inode.c:434
 exfat_extend_valid_size+0x1f8/0x340 fs/exfat/file.c:553
 exfat_page_mkwrite+0x16e/0x220 fs/exfat/file.c:649
 do_page_mkwrite+0x15e/0x350 mm/memory.c:3176
 do_shared_fault mm/memory.c:5398 [inline]
 do_fault mm/memory.c:5460 [inline]
 do_pte_missing mm/memory.c:3979 [inline]
 handle_pte_fault+0x10c6/0x5ed0 mm/memory.c:5801
 __handle_mm_fault mm/memory.c:5944 [inline]
 handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
 do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x2b9/0x8b0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
RIP: 0010:raw_copy_to_user arch/x86/include/asm/uaccess_64.h:147 [inline]
RIP: 0010:_inline_copy_to_user include/linux/uaccess.h:197 [inline]
RIP: 0010:_copy_to_user+0x86/0xb0 lib/usercopy.c:26
Code: c0 1c dd fc 4c 39 fb 72 3d 4c 39 eb 77 38 e8 51 1a dd fc 4c 89 f7 44 89 e6 e8 b6 84 43 fd 0f 01 cb 4c 89 ff 4c 89 e1 4c 89 f6 <f3> a4 0f 1f 00 49 89 cc 0f 01 ca 4c 89 e0 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc9000beafbb0 EFLAGS: 00050246
RAX: ffffffff84c26901 RBX: 0000000020000390 RCX: 0000000000000090
RDX: 0000000000000000 RSI: ffffc9000beafc20 RDI: 0000000020000300
RBP: ffffc9000beafd50 R08: ffffc9000beafcaf R09: 1ffff920017d5f95
R10: dffffc0000000000 R11: fffff520017d5f96 R12: 0000000000000090
R13: 00007ffffffff000 R14: ffffc9000beafc20 R15: 0000000020000300
 copy_to_user include/linux/uaccess.h:225 [inline]
 cp_new_stat+0x545/0x6e0 fs/stat.c:496
 __do_sys_newfstat fs/stat.c:543 [inline]
 __se_sys_newfstat fs/stat.c:537 [inline]
 __x64_sys_newfstat+0x16c/0x1c0 fs/stat.c:537
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcfdf985d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcfe0865038 EFLAGS: 00000246 ORIG_RAX: 0000000000000005
RAX: ffffffffffffffda RBX: 00007fcfdfb75fa0 RCX: 00007fcfdf985d29
RDX: 0000000000000000 RSI: 0000000020000300 RDI: 0000000000000004
RBP: 00007fcfdfa01b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fcfdfb75fa0 R15: 00007ffea462a438
 </TASK>
----------------
Code disassembly (best guess):
   0:	c0 1c dd fc 4c 39 fb 	rcrb   $0x72,-0x4c6b304(,%rbx,8)
   7:	72
   8:	3d 4c 39 eb 77       	cmp    $0x77eb394c,%eax
   d:	38 e8                	cmp    %ch,%al
   f:	51                   	push   %rcx
  10:	1a dd                	sbb    %ch,%bl
  12:	fc                   	cld
  13:	4c 89 f7             	mov    %r14,%rdi
  16:	44 89 e6             	mov    %r12d,%esi
  19:	e8 b6 84 43 fd       	call   0xfd4384d4
  1e:	0f 01 cb             	stac
  21:	4c 89 ff             	mov    %r15,%rdi
  24:	4c 89 e1             	mov    %r12,%rcx
  27:	4c 89 f6             	mov    %r14,%rsi
* 2a:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi) <-- trapping instruction
  2c:	0f 1f 00             	nopl   (%rax)
  2f:	49 89 cc             	mov    %rcx,%r12
  32:	0f 01 ca             	clac
  35:	4c 89 e0             	mov    %r12,%rax
  38:	5b                   	pop    %rbx
  39:	41 5c                	pop    %r12
  3b:	41 5d                	pop    %r13
  3d:	41 5e                	pop    %r14
  3f:	41                   	rex.B


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

