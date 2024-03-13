Return-Path: <linux-fsdevel+bounces-14260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB9D87A1A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 03:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BECD2B21DAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 02:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9AEC133;
	Wed, 13 Mar 2024 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YGUrzQul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FE263D5;
	Wed, 13 Mar 2024 02:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710297163; cv=none; b=B9gm+yE+sYQA1Ge+o6a1OxtwFiz2lgKQcFwK/X8qTYt9WwoW5hqAgRnjLhPsT/hiz2kJiae2o5x0sWmcyAOiVHaN7GqaQWRZEOeI/RQqORaVTMIA8Rc8rqpJagt9983418HQB0Orj29GUkrMgGkcgF9P0A5xgQ0f4coH+6SCwp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710297163; c=relaxed/simple;
	bh=2rI8Vzx4uZjDKcKotiU8jXVfpvMLZ3NzGiQk4GUZ+pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tux2R6zT8UPfSkWFWrlqlPDb2McPCNois4BOjpk3ekWlVAnR2bH3/q6yr1naQmrfa34xemWA0GV9LvoxhBUJlPx2nlAkKGznMfYT7a6jOqDDC1Fiu4L1BypQrE0C4TcInp/UwQJm1ezMLrAuxOWluFX6NRygoun1hegtgO+O6jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YGUrzQul; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=go09pGihhdBb65foe23c2aUUh/1SNf1G6H3P3z0HZOg=; b=YGUrzQul7KKhuzXl7VNOh2YV14
	QcBgCDwBRE8vAJ9TzZoGwkwhcqOjolkzmVjHl2zauR73YmGmQy75k9pxZeUWGowAA7VMKD/rC3bIa
	E6W74bncRKhaX/kwUog8akGnDVOVF2VIeLSzzC1cJbB2EksLgb7fMil87pDFMQ0wHI96ptZka3zDw
	30cKNsqhIgWCU60HiTuw0wUDcMuH9mZDMRQj7kBtMCaXpVf4dh5PTecqgwBKvLJzr4GWWr/q9onUs
	bHCGYqtPhkAVCHSuj7nrrGfzzHiGn8b7WO6QtT9pCVU9cdJ7ZEjLFdtgZJ90EQUggWCdhOgW2Hayu
	lavXjO+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkEPz-00000008YqS-3ViQ;
	Wed, 13 Mar 2024 02:32:35 +0000
Date: Tue, 12 Mar 2024 19:32:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 01/34] bdev: open block device as files
Message-ID: <ZfEQQ9jZZVes0WCZ@infradead.org>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-1-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-1-adbd023e19cc@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Now that this is in mainline it seems to cause blktests to crash
nbd/003 with a rather non-obvious oops for me:

nbd/003 (mount/unmount concurrently with NBD_CLEAR_SOCK)    
runtime  8.139s  ...
[  802.941685] run blktests nbd/003 at 2024-03-12 14:51:20
[  803.171958] nbd0: detected capacity change from 0 to 20971520
[  803.183725] block nbd0: shutting down sockets
[  803.184645] I/O error, dev nbd0, sector 2 op 0x0:(READ) flags 0x1000 phys_seg 1 prio class 0
[  803.185156] EXT4-fs (nbd0): unable to read superblock
[  803.186214] I/O error, dev nbd0, sector 20968432 op 0x0:(READ) flags
 0x80700 phys_seg 1 prio clas0
[  803.186770] I/O error, dev nbd0, sector 20968432 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  803.187026] Buffer I/O error on dev nbd0, logical block 10484216, async page read
[  803.187335] I/O error, dev nbd0, sector 20968434 op 0x0:(READ) flags 0x0 phys_seg 3 prio class 0
[  803.187593] Buffer I/O error on dev nbd0, logical block 10484217, async page read
[  803.187809] Buffer I/O error on dev nbd0, logical block 10484218, async page read
[  803.188027] Buffer I/O error on dev nbd0, logical block 10484219, async page read
[  803.194147] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  803.194400] Buffer I/O error on dev nbd0, logical block 0, async page read
[  803.194634] I/O error, dev nbd0, sector 2 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  803.194880] Buffer I/O error on dev nbd0, logical block 1, async page read
[  803.195296] I/O error, dev nbd0, sector 4 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  803.195548] Buffer I/O error on dev nbd0, logical block 2, async page read
[  803.195781] I/O error, dev nbd0, sector 6 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  803.196015] Buffer I/O error on dev nbd0, logical block 3, async page read
[  803.196246] Buffer I/O error on dev nbd0, logical block 0, async page read
[  803.196743] ldm_validate_partition_table(): Disk read failed.
[  803.197375] Dev nbd0: unable to read RDB block 0
[  803.198007]  nbd0: unable to read partition table
[  803.198467] EXT4-fs (nbd0): unable to read superblock
[  803.199444] ldm_validate_partition_table(): Disk read failed.
[  803.200487] Dev nbd0: unable to read RDB block 0
[  803.201046]  nbd0: unable to read partition table
[  803.207369] (udev-worker): attempt to access beyond end of device
[  803.207369] nbd0: rw=0, sector=2, nr_sectors = 2 limit=0
[  803.208100] (udev-worker): attempt to access beyond end of device
[  803.208100] nbd0: rw=0, sector=4, nr_sectors = 2 limit=0
[  803.208807] (udev-worker): attempt to access beyond end of device
[  803.208807] nbd0: rw=0, sector=6, nr_sectors = 2 limit=0
[  803.209197] ldm_validate_partition_table(): Disk read failed.
[  803.209365] Dev nbd0: unable to read RDB block 0
[  803.209506]  nbd0: unable to read partition table
[  803.209679] nbd0: partition table beyond EOD, truncated
[  803.210132] mount_clear_soc: attempt to access beyond end of device
[  803.210132] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[  803.210896] EXT4-fs (nbd0): unable to read superblock
[  803.212990] mount_clear_soc: attempt to access beyond end of device
[  803.212990] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[  803.213374] EXT4-fs (nbd0): unable to read superblock
[  803.221502] mount_clear_soc: attempt to access beyond end of device
[  803.221502] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[  803.221868] EXT4-fs (nbd0): unable to read superblock
[  803.223990] mount_clear_soc: attempt to access beyond end of device
[  803.223990] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[  803.224334] EXT4-fs (nbd0): unable to read superblock
[  803.229317] mount_clear_soc: attempt to access beyond end of device
[  803.229317] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[  803.229665] EXT4-fs (nbd0): unable to read superblock
[  803.231698] mount_clear_soc: attempt to access beyond end of device
[  803.231698] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[  803.232068] EXT4-fs (nbd0): unable to read superblock
[  803.233702] mount_clear_soc: attempt to access beyond end of device
[  803.233702] nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[  803.234049] EXT4-fs (nbd0): unable to read superblock
[  803.235263] general protection fault, maybe for address 0x0: 0000 [#1] PREEMPT SMP NOPTI
[  803.235505] CPU: 1 PID: 53579 Comm: mount_clear_soc Not tainted 6.8.0+ #2288
[  803.235712] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/014
[  803.235973] RIP: 0010:srso_alias_safe_ret+0x5/0x7
[  803.236118] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[  803.236637] RSP: 0018:ffffc900000d4ef8 EFLAGS: 00010202
[  803.236789] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000001
[  803.236991] RDX: 6b6b6b6b6b6b6b6b RSI: ffffffff833adc6a RDI: ffff888112581870
[  803.237200] RBP: ffffffff8124ae64 R08: 00000000ffffffff R09: 00000000ffffffff
[  803.237402] R10: 0000000000000002 R11: ffff8881130cb458 R12: ffff8881130caa40
[  803.237605] R13: 0000000000000000 R14: 0000000000031688 R15: ffffffff8124adde
[  803.237811] FS:  0000000000000000(0000) GS:ffff8881f9d00000(0000) knlGS:0000000000000000
[  803.238038] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  803.238206] CR2: 00007f2bb5507740 CR3: 0000000110dd2000 CR4: 0000000000750ef0
[  803.238412] PKRU: 55555554
[  803.238496] Call Trace:
[  803.238571]  <IRQ>
[  803.238634]  ? die_addr+0x31/0x80
[  803.238740]  ? exc_general_protection+0x24a/0x480
[  803.238886]  ? asm_exc_general_protection+0x26/0x30
[  803.239028]  ? rcu_core+0x34e/0xae0
[  803.239141]  ? rcu_core+0x3d4/0xae0
[  803.239255]  ? srso_alias_safe_ret+0x5/0x7
[  803.239379]  ? srso_alias_return_thunk+0x5/0xfbef5
[  803.239523]  ? rcu_core+0x3d9/0xae0
[  803.239636]  ? __do_softirq+0xec/0x481
[  803.239757]  ? __irq_exit_rcu+0x89/0xe0
[  803.239874]  ? irq_exit_rcu+0x9/0x30
[  803.239982]  ? sysvec_apic_timer_interrupt+0xa1/0xd0
[  803.240130]  </IRQ>
[  803.240197]  <TASK>
[  803.240265]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  803.240423]  ? __memcg_slab_free_hook+0x11e/0x230
[  803.240566]  ? __memcg_slab_free_hook+0x68/0x230
[  803.240705]  ? unlink_anon_vmas+0x78/0x200
[  803.240833]  ? kmem_cache_free+0x2ca/0x310
[  803.240960]  ? unlink_anon_vmas+0x78/0x200
[  803.241086]  ? free_pgtables+0x141/0x260
[  803.241218]  ? exit_mmap+0x194/0x440
[  803.241337]  ? __mmput+0x3a/0x110
[  803.241445]  ? do_exit+0x2bf/0xb10
[  803.241553]  ? do_group_exit+0x31/0x90
[  803.241669]  ? __x64_sys_exit_group+0x13/0x20
[  803.241801]  ? do_syscall_64+0x75/0x150
[  803.241921]  ? entry_SYSCALL_64_after_hwframe+0x6c/0x74

