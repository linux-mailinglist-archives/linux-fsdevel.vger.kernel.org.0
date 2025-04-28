Return-Path: <linux-fsdevel+bounces-47510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176A6A9EF97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 13:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DD017221A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9682673A2;
	Mon, 28 Apr 2025 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wVUR1gBY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TtVnfy5C";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wVUR1gBY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TtVnfy5C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5488E265CAE
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745840769; cv=none; b=pTF1XTe6iIVx7oOa0XpQpciFzrDlqLVk06CGwd4I4w92FzWAwx56jgbxeonSnu1eeGidid1KNbVYkD/mVHA2qf12n8/65la3LEDz7wmASkPVOsDs2+h/7PeHHl1vTwqPNaKPPm/iNHpXLNsqDMXlk60hm3XMJc5JOB8pcU67DqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745840769; c=relaxed/simple;
	bh=voQLXQA38RwXDBkhpWU8D4PQFHXBucjZZJvw/BU86Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4MTUZnmOR4ZYT5Lop1wacFKw7p456k/mv3rqDRN31etgu5aiT8Rxry7RhN7jnUVRLcvbNthPDkGjMkVZKuiflsR6mEDxSmkjxI5fjOGsKuhWTIEzUe3xiHoQfo/jXEfARwIX+USxYY26TllqA6cN/hLb0etgxQj1gmwCWlupkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wVUR1gBY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TtVnfy5C; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wVUR1gBY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TtVnfy5C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 175471F7B0;
	Mon, 28 Apr 2025 11:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745840765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t32Q1aVaKlkInz4oPxpqG/fdvLrsLvj/pKIISZp1zcs=;
	b=wVUR1gBYN8RCyi9pRxWYsDvU5D8k7czBboTQEYlnMRpsC5VrFz4C1CZOM1GIEJO6TzWZmy
	HuY+ho3nhFikOrmvxytam0av6U+weNFM5auj5APIfJ7N6R4oKpKWLZwdu3SzexzBDGHW0I
	BARH0xPIvOYPuxwl+2DzT9ICkC4X6Kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745840765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t32Q1aVaKlkInz4oPxpqG/fdvLrsLvj/pKIISZp1zcs=;
	b=TtVnfy5Cm1OIYoPO+PUYG/Ck/Gc8QySIPmR2WWfKvTQbps1oiqbXDmNHD87Q/8bkiGLn70
	EwW/K5Kcwb29lRDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wVUR1gBY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TtVnfy5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745840765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t32Q1aVaKlkInz4oPxpqG/fdvLrsLvj/pKIISZp1zcs=;
	b=wVUR1gBYN8RCyi9pRxWYsDvU5D8k7czBboTQEYlnMRpsC5VrFz4C1CZOM1GIEJO6TzWZmy
	HuY+ho3nhFikOrmvxytam0av6U+weNFM5auj5APIfJ7N6R4oKpKWLZwdu3SzexzBDGHW0I
	BARH0xPIvOYPuxwl+2DzT9ICkC4X6Kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745840765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t32Q1aVaKlkInz4oPxpqG/fdvLrsLvj/pKIISZp1zcs=;
	b=TtVnfy5Cm1OIYoPO+PUYG/Ck/Gc8QySIPmR2WWfKvTQbps1oiqbXDmNHD87Q/8bkiGLn70
	EwW/K5Kcwb29lRDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED3F71336F;
	Mon, 28 Apr 2025 11:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yF17OXxqD2iZQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 28 Apr 2025 11:46:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 85DFBA0AD5; Mon, 28 Apr 2025 13:46:00 +0200 (CEST)
Date: Mon, 28 Apr 2025 13:46:00 +0200
From: Jan Kara <jack@suse.cz>
To: Jianzhou Zhao <luckd0g@163.com>
Cc: stable@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Potential Linux Crash:  possible deadlock in do_lock_mount   in
 linux6.12.24(longterm maintenance)
Message-ID: <tjtv4vwxr4a67m7oakzbz522o3q5vrgakpbdhkztxsq5q74k6f@r3uzclrvjy2j>
References: <52b894ef.1f94.1967512da39.Coremail.luckd0g@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52b894ef.1f94.1967512da39.Coremail.luckd0g@163.com>
X-Rspamd-Queue-Id: 175471F7B0
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun 27-04-25 10:28:11, Jianzhou Zhao wrote:
> Hello, I found a potential bug titled "  possible deadlock in do_lock_mount " with modified syzkaller in the  Linux6.12.24(longterm maintenance, last updated on April 20, 2025).
> (The latest version of 6.12 is 6.12-25 at present. However, after comparison, I found that there seems to be no fix for this bug in the latest version.)
> Unfortunately, I am unable to reproduce this bug.
> If you fix this issue, please add the following tag to the commit:  Reported-by: Jianzhou Zhao <luckd0g@163.com>,    xingwei lee <xrivendell7@gmail.com>
> The commit of the kernel is : b6efa8ce222e58cfe2bbaa4e3329818c2b4bd74e
> kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=55f8591b98dd132
> compiler: gcc version 11.4.0
> 
> ------------[ cut here ]-----------------------------------------
>  TITLE:  possible deadlock in do_lock_mount
> ------------[ cut here ]------------
> ======================================================
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.12.24 #3 Not tainted
> ------------------------------------------------------
> syz.6.1765/29153 is trying to acquire lock:
> ffffffff8e14afc0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:318 [inline]
> ffffffff8e14afc0 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4058 [inline]
> ffffffff8e14afc0 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4136 [inline]
> ffffffff8e14afc0 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_cache_noprof+0x4b/0x310 mm/slub.c:4312
> 
> but task is already holding lock:
> ffffffff8e1bfdd0 (namespace_sem){++++}-{3:3}, at: namespace_lock fs/namespace.c:1713 [inline]
> ffffffff8e1bfdd0 (namespace_sem){++++}-{3:3}, at: do_lock_mount+0x150/0x5b0 fs/namespace.c:2618
> 
> which lock already depends on the new lock.

Hum, the lockdep report looks like a possible deadlock but not overly
concerning. The core of the deadlock loop is that we do GFP_KERNEL
allocation under inode_lock in do_loopback()->lock_mount()->do_lock_mount()
however for debugfs, the inode lock gets burried deep in the locking chain
e.g. by device discovery path.  So to deadlock the kernel, you need
something like:

  task 1					task 2
  try to bind mount a debugfs dir
    enter reclaim
      wants to do some IO			freeze request queue
        blocks on request queue being frozen
						wants to modify debugfs
						  blocks on debugfs inode lock

I'm not sure if we care...

								Honza

> the existing dependency chain (in reverse order) is:
> 
> -> #7 (namespace_sem){++++}-{3:3}:
>        down_write+0x92/0x200 kernel/locking/rwsem.c:1577
>        namespace_lock fs/namespace.c:1713 [inline]
>        do_lock_mount+0x150/0x5b0 fs/namespace.c:2618
>        lock_mount fs/namespace.c:2654 [inline]
>        do_loopback fs/namespace.c:2777 [inline]
>        path_mount+0xcda/0x1ea0 fs/namespace.c:3833
>        do_mount fs/namespace.c:3852 [inline]
>        __do_sys_mount fs/namespace.c:4062 [inline]
>        __se_sys_mount fs/namespace.c:4039 [inline]
>        __x64_sys_mount+0x284/0x310 fs/namespace.c:4039
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #6 (&sb->s_type->i_mutex_key#3){++++}-{3:3}:
>        down_write+0x92/0x200 kernel/locking/rwsem.c:1577
>        inode_lock include/linux/fs.h:815 [inline]
>        start_creating.part.0+0xb2/0x370 fs/debugfs/inode.c:374
>        start_creating fs/debugfs/inode.c:351 [inline]
>        debugfs_create_dir+0x72/0x600 fs/debugfs/inode.c:593
>        blk_register_queue+0x16a/0x4f0 block/blk-sysfs.c:766
>        device_add_disk+0x77f/0x12f0 block/genhd.c:489
>        add_disk include/linux/blkdev.h:741 [inline]
>        brd_alloc.isra.0+0x57a/0x800 drivers/block/brd.c:401
>        brd_init+0xf5/0x1e0 drivers/block/brd.c:481
>        do_one_initcall+0x10e/0x6d0 init/main.c:1269
>        do_initcall_level init/main.c:1331 [inline]
>        do_initcalls init/main.c:1347 [inline]
>        do_basic_setup init/main.c:1366 [inline]
>        kernel_init_freeable+0x5ae/0x8a0 init/main.c:1580
>        kernel_init+0x1e/0x2d0 init/main.c:1469
>        ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:152
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> -> #5 (&q->debugfs_mutex){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x147/0x930 kernel/locking/mutex.c:752
>        blk_mq_init_sched+0x436/0x650 block/blk-mq-sched.c:473
>        elevator_init_mq+0x2cc/0x420 block/elevator.c:610
>        device_add_disk+0x10e/0x12f0 block/genhd.c:411
>        sd_probe+0xa0e/0xf80 drivers/scsi/sd.c:4024
>        call_driver_probe drivers/base/dd.c:579 [inline]
>        really_probe+0x24f/0xa90 drivers/base/dd.c:658
>        __driver_probe_device+0x1df/0x450 drivers/base/dd.c:800
>        driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
>        __device_attach_driver+0x1db/0x2f0 drivers/base/dd.c:958
>        bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:459
>        __device_attach_async_helper+0x1d1/0x290 drivers/base/dd.c:987
>        async_run_entry_fn+0x9c/0x530 kernel/async.c:129
>        process_one_work+0xa02/0x1bf0 kernel/workqueue.c:3232
>        process_scheduled_works kernel/workqueue.c:3314 [inline]
>        worker_thread+0x677/0xe90 kernel/workqueue.c:3395
>        kthread+0x2c7/0x3b0 kernel/kthread.c:389
>        ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:152
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> -> #4 (&q->q_usage_counter(queue)#51){++++}-{0:0}:
>        blk_queue_enter+0x4d0/0x600 block/blk-core.c:328
>        blk_mq_alloc_request+0x422/0x9c0 block/blk-mq.c:680
>        scsi_alloc_request drivers/scsi/scsi_lib.c:1227 [inline]
>        scsi_execute_cmd+0x1fe/0xf20 drivers/scsi/scsi_lib.c:304
>        read_capacity_16+0x1f2/0xe60 drivers/scsi/sd.c:2655
>        sd_read_capacity drivers/scsi/sd.c:2824 [inline]
>        sd_revalidate_disk.isra.0+0x1989/0xa440 drivers/scsi/sd.c:3734
>        sd_probe+0x887/0xf80 drivers/scsi/sd.c:4010
>        call_driver_probe drivers/base/dd.c:579 [inline]
>        really_probe+0x24f/0xa90 drivers/base/dd.c:658
>        __driver_probe_device+0x1df/0x450 drivers/base/dd.c:800
>        driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
>        __device_attach_driver+0x1db/0x2f0 drivers/base/dd.c:958
>        bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:459
>        __device_attach_async_helper+0x1d1/0x290 drivers/base/dd.c:987
>        async_run_entry_fn+0x9c/0x530 kernel/async.c:129
>        process_one_work+0xa02/0x1bf0 kernel/workqueue.c:3232
>        process_scheduled_works kernel/workqueue.c:3314 [inline]
>        worker_thread+0x677/0xe90 kernel/workqueue.c:3395
>        kthread+0x2c7/0x3b0 kernel/kthread.c:389
>        ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:152
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> -> #3 (&q->limits_lock){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x147/0x930 kernel/locking/mutex.c:752
>        queue_limits_start_update include/linux/blkdev.h:935 [inline]
>        loop_reconfigure_limits+0x1f2/0x960 drivers/block/loop.c:1004
>        loop_set_block_size drivers/block/loop.c:1474 [inline]
>        lo_simple_ioctl drivers/block/loop.c:1497 [inline]
>        lo_ioctl+0xb92/0x1870 drivers/block/loop.c:1560
>        blkdev_ioctl+0x27b/0x6c0 block/ioctl.c:693
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:907 [inline]
>        __se_sys_ioctl fs/ioctl.c:893 [inline]
>        __x64_sys_ioctl+0x19d/0x210 fs/ioctl.c:893
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #2 (&q->q_usage_counter(io)#19){++++}-{0:0}:
>        bio_queue_enter block/blk.h:76 [inline]
>        blk_mq_submit_bio+0x2167/0x2b70 block/blk-mq.c:3090
>        __submit_bio+0x399/0x630 block/blk-core.c:629
>        __submit_bio_noacct_mq block/blk-core.c:716 [inline]
>        submit_bio_noacct_nocheck+0x6c3/0xd00 block/blk-core.c:745
>        submit_bio_noacct+0x57a/0x1fa0 block/blk-core.c:868
>        xfs_buf_ioapply_map fs/xfs/xfs_buf.c:1585 [inline]
>        _xfs_buf_ioapply+0x8a4/0xbe0 fs/xfs/xfs_buf.c:1673
>        __xfs_buf_submit+0x241/0x840 fs/xfs/xfs_buf.c:1757
>        xfs_buf_submit fs/xfs/xfs_buf.c:61 [inline]
>        _xfs_buf_read fs/xfs/xfs_buf.c:808 [inline]
>        xfs_buf_read_map+0x3e7/0xb40 fs/xfs/xfs_buf.c:872
>        xfs_trans_read_buf_map+0x10a/0x9b0 fs/xfs/xfs_trans_buf.c:289
>        xfs_trans_read_buf fs/xfs/xfs_trans.h:212 [inline]
>        xfs_read_agf+0x2c1/0x5b0 fs/xfs/libxfs/xfs_alloc.c:3367
>        xfs_alloc_read_agf+0x152/0xb90 fs/xfs/libxfs/xfs_alloc.c:3401
>        xfs_alloc_fix_freelist+0x925/0xff0 fs/xfs/libxfs/xfs_alloc.c:2863
>        xfs_alloc_vextent_prepare_ag+0x7c/0x6c0 fs/xfs/libxfs/xfs_alloc.c:3532
>        xfs_alloc_vextent_iterate_ags.constprop.0+0x1b0/0x970 fs/xfs/libxfs/xfs_alloc.c:3717
>        xfs_alloc_vextent_start_ag+0x32b/0x800 fs/xfs/libxfs/xfs_alloc.c:3806
>        xfs_bmap_btalloc_best_length fs/xfs/libxfs/xfs_bmap.c:3731 [inline]
>        xfs_bmap_btalloc+0xbc4/0x17d0 fs/xfs/libxfs/xfs_bmap.c:3776
>        xfs_bmapi_allocate+0x23d/0xe80 fs/xfs/libxfs/xfs_bmap.c:4189
>        xfs_bmapi_write+0x686/0xca0 fs/xfs/libxfs/xfs_bmap.c:4518
>        xfs_dquot_disk_alloc+0x654/0xbb0 fs/xfs/xfs_dquot.c:376
>        xfs_qm_dqread+0x55d/0x5f0 fs/xfs/xfs_dquot.c:715
>        xfs_qm_dqget+0x142/0x470 fs/xfs/xfs_dquot.c:927
>        xfs_qm_quotacheck_dqadjust+0xaa/0x570 fs/xfs/xfs_qm.c:1125
>        xfs_qm_dqusage_adjust+0x511/0x680 fs/xfs/xfs_qm.c:1248
>        xfs_iwalk_ag_recs+0x476/0x7c0 fs/xfs/xfs_iwalk.c:213
>        xfs_iwalk_run_callbacks+0x1fa/0x560 fs/xfs/xfs_iwalk.c:371
>        xfs_iwalk_ag+0x73a/0x940 fs/xfs/xfs_iwalk.c:477
>        xfs_iwalk_ag_work+0x14e/0x1c0 fs/xfs/xfs_iwalk.c:619
>        xfs_pwork_work+0x7f/0x160 fs/xfs/xfs_pwork.c:47
>        process_one_work+0xa02/0x1bf0 kernel/workqueue.c:3232
>        process_scheduled_works kernel/workqueue.c:3314 [inline]
>        worker_thread+0x677/0xe90 kernel/workqueue.c:3395
>        kthread+0x2c7/0x3b0 kernel/kthread.c:389
>        ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:152
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> -> #1 (&xfs_nondir_ilock_class#3){++++}-{3:3}:
>        down_write_nested+0x96/0x210 kernel/locking/rwsem.c:1693
>        xfs_ilock+0x198/0x210 fs/xfs/xfs_inode.c:164
>        xfs_reclaim_inode fs/xfs/xfs_icache.c:981 [inline]
>        xfs_icwalk_process_inode fs/xfs/xfs_icache.c:1675 [inline]
>        xfs_icwalk_ag+0xa5e/0x17b0 fs/xfs/xfs_icache.c:1757
>        xfs_icwalk fs/xfs/xfs_icache.c:1805 [inline]
>        xfs_reclaim_inodes_nr+0x1bd/0x300 fs/xfs/xfs_icache.c:1047
>        super_cache_scan+0x412/0x570 fs/super.c:227
>        do_shrink_slab+0x44b/0x1190 mm/shrinker.c:437
>        shrink_slab+0x332/0x12a0 mm/shrinker.c:664
>        shrink_one+0x4ad/0x7c0 mm/vmscan.c:4835
>        shrink_many mm/vmscan.c:4896 [inline]
>        lru_gen_shrink_node mm/vmscan.c:4974 [inline]
>        shrink_node+0x2420/0x3890 mm/vmscan.c:5954
>        kswapd_shrink_node mm/vmscan.c:6782 [inline]
>        balance_pgdat+0xbe5/0x18c0 mm/vmscan.c:6974
>        kswapd+0x702/0xd50 mm/vmscan.c:7243
>        kthread+0x2c7/0x3b0 kernel/kthread.c:389
>        ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:152
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> -> #0 (fs_reclaim){+.+.}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3161 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>        validate_chain kernel/locking/lockdep.c:3904 [inline]
>        __lock_acquire+0x2425/0x3b90 kernel/locking/lockdep.c:5202
>        lock_acquire.part.0+0x11b/0x370 kernel/locking/lockdep.c:5825
>        __fs_reclaim_acquire mm/page_alloc.c:3853 [inline]
>        fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:3867
>        might_alloc include/linux/sched/mm.h:318 [inline]
>        slab_pre_alloc_hook mm/slub.c:4058 [inline]
>        slab_alloc_node mm/slub.c:4136 [inline]
>        __kmalloc_cache_noprof+0x4b/0x310 mm/slub.c:4312
>        kmalloc_noprof include/linux/slab.h:878 [inline]
>        get_mountpoint+0x14c/0x410 fs/namespace.c:909
>        do_lock_mount+0x171/0x5b0 fs/namespace.c:2639
>        lock_mount fs/namespace.c:2654 [inline]
>        do_new_mount_fc fs/namespace.c:3449 [inline]
>        do_new_mount fs/namespace.c:3514 [inline]
>        path_mount+0x1695/0x1ea0 fs/namespace.c:3839
>        do_mount fs/namespace.c:3852 [inline]
>        __do_sys_mount fs/namespace.c:4062 [inline]
>        __se_sys_mount fs/namespace.c:4039 [inline]
>        __x64_sys_mount+0x284/0x310 fs/namespace.c:4039
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   fs_reclaim --> &sb->s_type->i_mutex_key#3 --> namespace_sem
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(namespace_sem);
>                                lock(&sb->s_type->i_mutex_key#3);
>                                lock(namespace_sem);
>   lock(fs_reclaim);
> 
>  *** DEADLOCK ***
> 
> 2 locks held by syz.6.1765/29153:
>  #0: ffff888055a94158 (&sb->s_type->i_mutex_key#29){++++}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
>  #0: ffff888055a94158 (&sb->s_type->i_mutex_key#29){++++}-{3:3}, at: do_lock_mount+0xae/0x5b0 fs/namespace.c:2612
>  #1: ffffffff8e1bfdd0 (namespace_sem){++++}-{3:3}, at: namespace_lock fs/namespace.c:1713 [inline]
>  #1: ffffffff8e1bfdd0 (namespace_sem){++++}-{3:3}, at: do_lock_mount+0x150/0x5b0 fs/namespace.c:2618
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 29153 Comm: syz.6.1765 Not tainted 6.12.24 #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
>  print_circular_bug+0x406/0x5c0 kernel/locking/lockdep.c:2074
>  check_noncircular+0x2f7/0x3e0 kernel/locking/lockdep.c:2206
>  check_prev_add kernel/locking/lockdep.c:3161 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>  validate_chain kernel/locking/lockdep.c:3904 [inline]
>  __lock_acquire+0x2425/0x3b90 kernel/locking/lockdep.c:5202
>  lock_acquire.part.0+0x11b/0x370 kernel/locking/lockdep.c:5825
>  __fs_reclaim_acquire mm/page_alloc.c:3853 [inline]
>  fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:3867
>  might_alloc include/linux/sched/mm.h:318 [inline]
>  slab_pre_alloc_hook mm/slub.c:4058 [inline]
>  slab_alloc_node mm/slub.c:4136 [inline]
>  __kmalloc_cache_noprof+0x4b/0x310 mm/slub.c:4312
>  kmalloc_noprof include/linux/slab.h:878 [inline]
>  get_mountpoint+0x14c/0x410 fs/namespace.c:909
>  do_lock_mount+0x171/0x5b0 fs/namespace.c:2639
>  lock_mount fs/namespace.c:2654 [inline]
>  do_new_mount_fc fs/namespace.c:3449 [inline]
>  do_new_mount fs/namespace.c:3514 [inline]
>  path_mount+0x1695/0x1ea0 fs/namespace.c:3839
>  do_mount fs/namespace.c:3852 [inline]
>  __do_sys_mount fs/namespace.c:4062 [inline]
>  __se_sys_mount fs/namespace.c:4039 [inline]
>  __x64_sys_mount+0x284/0x310 fs/namespace.c:4039
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcb/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff6353ad5ad
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ff6361edf98 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007ff6355e5fa0 RCX: 00007ff6353ad5ad
> RDX: 00002000000000c0 RSI: 0000200000000080 RDI: 0000000000000000
> RBP: 00007ff635446d56 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007ff6355e5fa0 R15: 00007ff6361ce000
>  </TASK>
> 
> ==================================================================
> 
> I hope it helps.
> Best regards
> Jianzhou Zhao
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

