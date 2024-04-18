Return-Path: <linux-fsdevel+bounces-17227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6346E8A934A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 08:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F4A1C20BDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 06:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C82C3A8EF;
	Thu, 18 Apr 2024 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cxOZH6h/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0F381CC;
	Thu, 18 Apr 2024 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422552; cv=none; b=f3INorVHXFQZoyoIlON/KjAWDoFVAZpVgEPdqwojQ9gOGc7/Wvk3rp8sgR04MAs43JktD+Uq3Nejatd8HcIJQTrn/EaqOJxXq/jcbg3BVuyOPK42k7zQe0qWXg/dhj3BpYMhHLDST0qHYLyc39th0VIgZhPuZOLPaj7sKm5ymh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422552; c=relaxed/simple;
	bh=jTnKL79GUmD0n32DMmd6B6yzCBnSRNjSUuoD7DglK+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkDsmvMpofMMTO13ivlZ5wqjrzKIGaGw/jhXIUDg8gq1xee4dAeDSj84z+Jeh6OMkvysb/tOtW00/7vwvWB0dDtgWzNCafhruCaIMBHAvYsYKb3O1LHGuhO2m9+m6KDXF1vSP6bqI6HXENGtFiC+HnUJfVCuscSMUZTpuhdptSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cxOZH6h/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eky4ZtcNrzQEzdWfEfU0kV47nJYinagPZcTgFETZ3H4=; b=cxOZH6h/4bNebHKajLLQHxXGvN
	4FQYHzce79aHSSwz/LIUSjUruAFeS+C+T1cACvwY4XmbZQalOcslvBqN7Iv4bMzbM0nqXZOO6LYYk
	E2IwV+rz8tQX+WMD4nwOU6ltfIc15xh6ndAr3VtyA0WZrDzAe2clZ0jIvvWz+CXgFG4h6/pYaSaO+
	LfReuc9TCJyh+oZ/V5+8OorEZxVh7mAmd+E908JdDyNydO+rdUn7Gmci8qQtMcmha688kjlGzeB3Y
	lQTKZvcG9tiuiumTUCBVRWmy49QVFw2CQNNQXJobbbpmRP9zJ7u7xxLL2EXWvNH8fVTPJG5OSxAPa
	aSD+woQQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxLTY-000000019ZY-2Geu;
	Thu, 18 Apr 2024 06:42:28 +0000
Date: Wed, 17 Apr 2024 23:42:28 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: fstests@vger.kernel.org, kdevops@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, david@redhat.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de
Subject: Re: [PATCH] fstests: add fsstress + compaction test
Message-ID: <ZiDA1Lokzwxd3d-v@bombadil.infradead.org>
References: <20240418001356.95857-1-mcgrof@kernel.org>
 <ZiB5x-EKrmb1ZPuf@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiB5x-EKrmb1ZPuf@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Apr 18, 2024 at 02:39:19AM +0100, Matthew Wilcox wrote:
> On Wed, Apr 17, 2024 at 05:13:56PM -0700, Luis Chamberlain wrote:
> > Running compaction while we run fsstress can crash older kernels as per
> > korg#218227 [0], the fix for that [0] has been posted [1] but that patch
> > is not yet on v6.9-rc4 and the patch requires changes for v6.9.
> 
> It doesn't require changes, it just has prerequisites:
> 
> https://lore.kernel.org/all/ZgHhcojXc9QjynUI@casper.infradead.org/

Oh alrighty, thanks I'll give those two a shot to see if that fixes
this other lockup.

> > Today I find that v6.9-rc4 is also hitting an unrecoverable hung task
> > between compaction and fsstress while running generic/476 on the
> > following kdevops test sections [2]:
> > 
> >   * xfs_nocrc
> >   * xfs_nocrc_2k
> >   * xfs_nocrc_4k
> > 
> > Analyzing the trace I see the guest uses loopback block devices for the
> > fstests TEST_DEV, the loopback file uses sparsefiles on a btrfs
> > partition. The contention based on traces [3] [4] seems to be that we
> > have somehow have fsstress + compaction race on folio_wait_bit_common().
> 
> What do you mean by "race"?  Here's what I see:
> 
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: INFO: task kcompactd0:72 blocked for more than 120 seconds.
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4 #4
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: task:kcompactd0      state:D stack:0     pid:72    tgid:72    ppid:2      flags:0x00004000
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel: Call Trace:
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  <TASK>
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  __schedule+0x3d9/0xaf0
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  schedule+0x26/0xf0
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  io_schedule+0x42/0x70
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  folio_wait_bit_common+0x123/0x370
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  ? __pfx_wake_page_function+0x10/0x10
> Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  migrate_pages_batch+0x69a/0xd70
> 
> But you didn't run the backtrace through scripts/decode_stacktrace.sh
> so I can't figure out what we're waiting on.

Oh, lemme do that. OK here's the full log and at the end of this email
is just the relevant traces.

https://gist.github.com/mcgrof/5e2886a33fd9448e1033acfbe244e82f

Apr 16 21:45:28 base-xfs-nocrc-2k unknown: run fstests generic/476 at 2024-04-16 21:45:28
Apr 16 21:45:29 base-xfs-nocrc-2k kernel: XFS (loop16): Mounting V4 Filesystem 2edc77d4-f00a-40d8-9d7f-b1e3876a156e
Apr 16 21:45:29 base-xfs-nocrc-2k kernel: XFS (loop16): Ending clean mount
Apr 16 21:45:29 base-xfs-nocrc-2k kernel: xfs filesystem being mounted at /media/test supports timestamps until 2038-01-19 (0x7fffffff)
Apr 16 21:45:29 base-xfs-nocrc-2k kernel: XFS (loop5): Mounting V4 Filesystem c13935a8-e0a2-491f-a58f-ed56430999dc
Apr 16 21:45:29 base-xfs-nocrc-2k kernel: XFS (loop5): Ending clean mount
Apr 16 21:45:29 base-xfs-nocrc-2k kernel: xfs filesystem being mounted at /media/scratch supports timestamps until 2038-01-19 (0x7fffffff)
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: INFO: task kcompactd0:72 blocked for more than 120 seconds.
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4 #4
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: task:kcompactd0      state:D stack:0     pid:72    tgid:72    ppid:2      flags:0x00004000
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: Call Trace:
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  <TASK>
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: io_schedule (kernel/sched/core.c:9019 (discriminator 1) kernel/sched/core.c:9045 (discriminator 1)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: folio_wait_bit_common (mm/filemap.c:1275 (discriminator 4)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_wake_page_function (mm/filemap.c:1091) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: migrate_pages_batch (./include/linux/pagemap.h:1048 mm/migrate.c:1486 mm/migrate.c:1700) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_compaction_free (mm/compaction.c:1907) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_compaction_alloc (mm/compaction.c:1855) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __mod_node_page_state (mm/vmstat.c:403 (discriminator 2)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: migrate_pages (mm/migrate.c:1849 mm/migrate.c:1953) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_compaction_alloc (mm/compaction.c:1855) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_compaction_free (mm/compaction.c:1907) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? folio_putback_lru (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/atomic/atomic-instrumented.h:33 ./include/linux/page_ref.h:67 ./include/linux/mm.h:1134 ./include/linux/mm.h:1140 ./include/linux/mm.h:1505 mm/vmscan.c:819) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: compact_zone (mm/compaction.c:2663) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? update_load_avg (kernel/sched/fair.c:4411 kernel/sched/fair.c:4748) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: compact_node (mm/compaction.c:2925) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: kcompactd (./include/linux/mmzone.h:1501 mm/compaction.c:2257 mm/compaction.c:3222) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_autoremove_wake_function (kernel/sched/wait.c:383) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_kcompactd (mm/compaction.c:3168) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: kthread (kernel/kthread.c:388) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  </TASK>
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: INFO: task kworker/u38:8:807213 blocked for more than 120 seconds.
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4 #4
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: task:kworker/u38:8   state:D stack:0     pid:807213 tgid:807213 ppid:2      flags:0x00004000
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: Workqueue: writeback wb_workfn (flush-btrfs-2)
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: Call Trace:
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  <TASK>
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: io_schedule (kernel/sched/core.c:9019 (discriminator 1) kernel/sched/core.c:9045 (discriminator 1)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: folio_wait_bit_common (mm/filemap.c:1275 (discriminator 4)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_wake_page_function (mm/filemap.c:1091) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: extent_write_cache_pages (fs/btrfs/extent_io.c:2130) btrfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5852 (discriminator 1) kernel/sched/core.c:5849 (discriminator 1) kernel/sched/core.c:5877 (discriminator 1)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? stack_depot_save_flags (lib/stackdepot.c:609) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? put_cpu_partial (./arch/x86/include/asm/irqflags.h:134 (discriminator 1) mm/slub.c:2978 (discriminator 1)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: extent_writepages (fs/btrfs/extent_io.c:131 fs/btrfs/extent_io.c:2275) btrfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: do_writepages (mm/page-writeback.c:2612) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? update_sd_lb_stats.constprop.0 (kernel/sched/fair.c:9896 (discriminator 2) kernel/sched/fair.c:10577 (discriminator 2)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __writeback_single_inode (fs/fs-writeback.c:1659) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: writeback_sb_inodes (fs/fs-writeback.c:1943) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __writeback_inodes_wb (fs/fs-writeback.c:2013) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: wb_writeback (fs/fs-writeback.c:2119) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: wb_workfn (fs/fs-writeback.c:2276 (discriminator 1) fs/fs-writeback.c:2304 (discriminator 1)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: process_one_work (kernel/workqueue.c:3254) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: worker_thread (kernel/workqueue.c:3329 (discriminator 2) kernel/workqueue.c:3416 (discriminator 2)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_worker_thread (kernel/workqueue.c:3362) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: kthread (kernel/kthread.c:388) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  </TASK>
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: INFO: task kworker/u34:9:1268436 blocked for more than 120 seconds.
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4 #4
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: task:kworker/u34:9   state:D stack:0     pid:1268436 tgid:1268436 ppid:2      flags:0x00004000
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: Workqueue: loop5 loop_rootcg_workfn [loop]
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: Call Trace:
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  <TASK>
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: io_schedule (kernel/sched/core.c:9019 (discriminator 1) kernel/sched/core.c:9045 (discriminator 1)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: folio_wait_bit_common (mm/filemap.c:1275 (discriminator 4)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_wake_page_function (mm/filemap.c:1091) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: btrfs_folio_start_writer_lock (./include/linux/pagemap.h:1048 fs/btrfs/subpage.c:394) btrfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: lock_delalloc_pages (fs/btrfs/extent_io.c:281 (discriminator 1)) btrfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5852 kernel/sched/core.c:5849 kernel/sched/core.c:5877) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? _raw_spin_unlock (./include/linux/spinlock_api_smp.h:143 (discriminator 3) kernel/locking/spinlock.c:186 (discriminator 3)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? btrfs_find_delalloc_range (fs/btrfs/extent-io-tree.c:1036) btrfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: find_lock_delalloc_range (fs/btrfs/extent_io.c:377) btrfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: writepage_delalloc (fs/btrfs/extent_io.c:1217 (discriminator 1)) btrfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: extent_write_cache_pages (fs/btrfs/extent_io.c:1475 (discriminator 1) fs/btrfs/extent_io.c:2152 (discriminator 1)) btrfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: extent_writepages (fs/btrfs/extent_io.c:131 fs/btrfs/extent_io.c:2275) btrfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_end_bbio_data_write (fs/btrfs/extent_io.c:463) btrfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: do_writepages (mm/page-writeback.c:2612) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pv_queued_spin_lock_slowpath (kernel/locking/qspinlock.c:565 (discriminator 38)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pv_queued_spin_lock_slowpath (kernel/locking/qspinlock.c:565 (discriminator 38)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: filemap_fdatawrite_wbc (mm/filemap.c:398 mm/filemap.c:387) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __filemap_fdatawrite_range (mm/filemap.c:431) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: start_ordered_ops.constprop.0 (fs/btrfs/file.c:3873 fs/btrfs/file.c:1743) btrfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: btrfs_sync_file (fs/btrfs/file.c:1818) btrfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: loop_process_work (drivers/block/loop.c:329 (discriminator 1) drivers/block/loop.c:475 (discriminator 1) drivers/block/loop.c:1907 (discriminator 1) drivers/block/loop.c:1942 (discriminator 1)) loop
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: process_one_work (kernel/workqueue.c:3254) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: worker_thread (kernel/workqueue.c:3329 (discriminator 2) kernel/workqueue.c:3416 (discriminator 2)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_worker_thread (kernel/workqueue.c:3362) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: kthread (kernel/kthread.c:388) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  </TASK>
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: INFO: task xfsaild/loop5:1377891 blocked for more than 120 seconds.
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4 #4
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: task:xfsaild/loop5   state:D stack:0     pid:1377891 tgid:1377891 ppid:2      flags:0x00004000
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: Call Trace:
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  <TASK>
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_wbt_cleanup_cb (block/blk-wbt.c:575) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_wbt_inflight_cb (block/blk-wbt.c:569) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: io_schedule (kernel/sched/core.c:9019 (discriminator 1) kernel/sched/core.c:9045 (discriminator 1)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: rq_qos_wait (block/blk-rq-qos.c:284 (discriminator 4)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_rq_qos_wake_function (block/blk-rq-qos.c:208) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_wbt_inflight_cb (block/blk-wbt.c:569) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: wbt_wait (block/blk-wbt.c:660) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __rq_qos_throttle (block/blk-rq-qos.c:66) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: blk_mq_submit_bio (block/blk-mq.c:2880 block/blk-mq.c:2984) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: submit_bio_noacct_nocheck (./include/linux/bio.h:639 block/blk-core.c:701 block/blk-core.c:729) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? submit_bio_noacct (block/blk-core.c:758 (discriminator 1)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: _xfs_buf_ioapply (fs/xfs/xfs_buf.c:1584 fs/xfs/xfs_buf.c:1671) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? xfs_dir_ino_validate (fs/xfs/libxfs/xfs_dir2.c:220 (discriminator 2)) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5852 kernel/sched/core.c:5849 kernel/sched/core.c:5877) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __xfs_buf_submit (./arch/x86/include/asm/atomic.h:67 ./include/linux/atomic/atomic-arch-fallback.h:2278 ./include/linux/atomic/atomic-instrumented.h:1384 fs/xfs/xfs_buf.c:1762) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_buf_delwri_submit_buffers (fs/xfs/xfs_buf.c:2280 (discriminator 2)) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfsaild (fs/xfs/xfs_trans_ail.c:560 (discriminator 1) fs/xfs/xfs_trans_ail.c:671 (discriminator 1)) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_xfsaild (fs/xfs/xfs_trans_ail.c:597) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: kthread (kernel/kthread.c:388) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  </TASK>
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: INFO: task fsstress:1377894 blocked for more than 120 seconds.
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4 #4
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: task:fsstress        state:D stack:0     pid:1377894 tgid:1377894 ppid:1377892 flags:0x00004002
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: Call Trace:
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  <TASK>
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: schedule_timeout (kernel/time/timer.c:2559) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? blk_finish_plug (block/blk-core.c:1218 (discriminator 1)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __wait_for_common (kernel/sched/completion.c:95 kernel/sched/completion.c:116) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_schedule_timeout (kernel/time/timer.c:2544) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_buf_iowait (fs/xfs/xfs_buf.c:1691) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __xfs_buf_submit (fs/xfs/xfs_buf.c:1770) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_buf_read_map (fs/xfs/xfs_buf.c:870) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? xfs_btree_read_buf_block (./fs/xfs/xfs_trans.h:210 fs/xfs/libxfs/xfs_btree.c:1432) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_trans_read_buf_map (fs/xfs/xfs_trans_buf.c:289 (discriminator 1)) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? xfs_btree_read_buf_block (./fs/xfs/xfs_trans.h:210 fs/xfs/libxfs/xfs_btree.c:1432) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_btree_read_buf_block (./fs/xfs/xfs_trans.h:210 fs/xfs/libxfs/xfs_btree.c:1432) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_btree_lookup_get_block (fs/xfs/libxfs/xfs_btree.c:1934) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_btree_lookup (fs/xfs/libxfs/xfs_btree.c:2045) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? kmem_cache_alloc (./include/linux/kmemleak.h:42 mm/slub.c:3802 mm/slub.c:3845 mm/slub.c:3852) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? xfs_bunmapi (fs/xfs/libxfs/xfs_bmap.c:5671) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? xfs_free_file_space (fs/xfs/xfs_bmap_util.c:786 fs/xfs/xfs_bmap_util.c:856) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? xfs_file_fallocate (fs/xfs/xfs_file.c:1004 (discriminator 1)) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? vfs_fallocate (fs/open.c:330) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_bmap_del_extent_real (fs/xfs/libxfs/xfs_bmap.c:5173) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __xfs_bunmapi (fs/xfs/libxfs/xfs_bmap.c:5593) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? xfs_trans_alloc_inode (fs/xfs/xfs_trans.c:1220) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_bunmapi (fs/xfs/libxfs/xfs_bmap.c:5671) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_free_file_space (fs/xfs/xfs_bmap_util.c:786 fs/xfs/xfs_bmap_util.c:856) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_file_fallocate (fs/xfs/xfs_file.c:1004 (discriminator 1)) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? apparmor_file_permission (security/apparmor/include/cred.h:24 security/apparmor/include/cred.h:49 security/apparmor/include/cred.h:76 security/apparmor/include/cred.h:109 security/apparmor/lsm.c:533 security/apparmor/lsm.c:546) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: vfs_fallocate (fs/open.c:330) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ioctl_preallocate (fs/ioctl.c:293) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __x64_sys_ioctl (fs/ioctl.c:903 fs/ioctl.c:890 fs/ioctl.c:890) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: RIP: 0033:0x7f4c8f5a2c5b
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: RSP: 002b:00007ffd503d7980 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: RAX: ffffffffffffffda RBX: 00000000000d3809 RCX: 00007f4c8f5a2c5b
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: RDX: 00007ffd503d7a00 RSI: 000000004030582b RDI: 0000000000000003
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: RBP: 0000000000000003 R08: 000000000000004f R09: 00007ffd503d79ec
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: R10: 0000000000001000 R11: 0000000000000246 R12: 0000000000000000
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: R13: 000000000026acd9 R14: 8f5c28f5c28f5c29 R15: 0000558585e10990
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  </TASK>
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: INFO: task fsstress:1377895 blocked for more than 120 seconds.
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4 #4
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: task:fsstress        state:D stack:0     pid:1377895 tgid:1377895 ppid:1377892 flags:0x00000002
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: Call Trace:
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  <TASK>
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: schedule_timeout (kernel/time/timer.c:2559) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? blk_finish_plug (block/blk-core.c:1218 (discriminator 1)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __wait_for_common (kernel/sched/completion.c:95 kernel/sched/completion.c:116) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? __pfx_schedule_timeout (kernel/time/timer.c:2544) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_buf_iowait (fs/xfs/xfs_buf.c:1691) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __xfs_buf_submit (fs/xfs/xfs_buf.c:1770) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_buf_read_map (fs/xfs/xfs_buf.c:870) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? xfs_da_read_buf (fs/xfs/libxfs/xfs_da_btree.c:2676) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_trans_read_buf_map (fs/xfs/xfs_trans_buf.c:289 (discriminator 1)) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? xfs_da_read_buf (fs/xfs/libxfs/xfs_da_btree.c:2676) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_da_read_buf (fs/xfs/libxfs/xfs_da_btree.c:2676) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_attr3_leaf_read (fs/xfs/libxfs/xfs_attr_leaf.c:458) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? xfs_attr_is_leaf (fs/xfs/libxfs/xfs_attr.c:95) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_attr_leaf_hasname (fs/xfs/libxfs/xfs_attr.c:1206) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_attr_leaf_get (fs/xfs/libxfs/xfs_attr.c:1275) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_attr_get (fs/xfs/libxfs/xfs_attr.c:276) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_xattr_get (fs/xfs/xfs_xattr.c:143) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __vfs_getxattr (fs/xattr.c:423) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: cap_inode_need_killpriv (security/commoncap.c:303) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: security_inode_need_killpriv (security/security.c:2504 (discriminator 13)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: file_remove_privs_flags (fs/inode.c:2016 fs/inode.c:2046) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? xfs_break_dax_layouts (fs/xfs/xfs_file.c:884) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? tomoyo_init_request_info (security/tomoyo/util.c:1026) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? tomoyo_path_number_perm (security/tomoyo/file.c:719 (discriminator 1)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? aa_file_perm (security/apparmor/file.c:591) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: file_modified (fs/inode.c:2167 fs/inode.c:2196) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: xfs_file_fallocate (fs/xfs/xfs_file.c:999 (discriminator 1)) xfs
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ? apparmor_file_permission (security/apparmor/include/cred.h:24 security/apparmor/include/cred.h:49 security/apparmor/include/cred.h:76 security/apparmor/include/cred.h:109 security/apparmor/lsm.c:533 security/apparmor/lsm.c:546) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: vfs_fallocate (fs/open.c:330) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: ioctl_preallocate (fs/ioctl.c:293) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: __x64_sys_ioctl (fs/ioctl.c:903 fs/ioctl.c:890 fs/ioctl.c:890) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: RIP: 0033:0x7f4c8f5a2c5b
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: RSP: 002b:00007ffd503d7980 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: RAX: ffffffffffffffda RBX: 00000000000d9386 RCX: 00007f4c8f5a2c5b
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: RDX: 00007ffd503d7a00 RSI: 000000004030582a RDI: 0000000000000003
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: RBP: 0000000000000003 R08: 000000000000000f R09: 00007ffd503d79ec
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: R10: 0000000000001000 R11: 0000000000000246 R12: 0000000000000000
Apr 16 23:06:11 base-xfs-nocrc-2k kernel: R13: 0000000000049b5f R14: 8f5c28f5c28f5c29 R15: 0000558585e106d0
Apr 16 23:06:11 base-xfs-nocrc-2k kernel:  </TASK>
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: INFO: task kcompactd0:72 blocked for more than 241 seconds.
Apr 16 23:08:11 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4 #4
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: task:kcompactd0      state:D stack:0     pid:72    tgid:72    ppid:2      flags:0x00004000
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: Call Trace:
Apr 16 23:08:11 base-xfs-nocrc-2k kernel:  <TASK>
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: io_schedule (kernel/sched/core.c:9019 (discriminator 1) kernel/sched/core.c:9045 (discriminator 1)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: folio_wait_bit_common (mm/filemap.c:1275 (discriminator 4)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_wake_page_function (mm/filemap.c:1091) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: migrate_pages_batch (./include/linux/pagemap.h:1048 mm/migrate.c:1486 mm/migrate.c:1700) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_compaction_free (mm/compaction.c:1907) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_compaction_alloc (mm/compaction.c:1855) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __mod_node_page_state (mm/vmstat.c:403 (discriminator 2)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: migrate_pages (mm/migrate.c:1849 mm/migrate.c:1953) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_compaction_alloc (mm/compaction.c:1855) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_compaction_free (mm/compaction.c:1907) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? folio_putback_lru (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/atomic/atomic-instrumented.h:33 ./include/linux/page_ref.h:67 ./include/linux/mm.h:1134 ./include/linux/mm.h:1140 ./include/linux/mm.h:1505 mm/vmscan.c:819) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: compact_zone (mm/compaction.c:2663) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? update_load_avg (kernel/sched/fair.c:4411 kernel/sched/fair.c:4748) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: compact_node (mm/compaction.c:2925) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: kcompactd (./include/linux/mmzone.h:1501 mm/compaction.c:2257 mm/compaction.c:3222) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_autoremove_wake_function (kernel/sched/wait.c:383) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_kcompactd (mm/compaction.c:3168) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: kthread (kernel/kthread.c:388) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel:  </TASK>
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: INFO: task kworker/u38:8:807213 blocked for more than 241 seconds.
Apr 16 23:08:11 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4 #4
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: task:kworker/u38:8   state:D stack:0     pid:807213 tgid:807213 ppid:2      flags:0x00004000
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: Workqueue: writeback wb_workfn (flush-btrfs-2)
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: Call Trace:
Apr 16 23:08:11 base-xfs-nocrc-2k kernel:  <TASK>
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: io_schedule (kernel/sched/core.c:9019 (discriminator 1) kernel/sched/core.c:9045 (discriminator 1)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: folio_wait_bit_common (mm/filemap.c:1275 (discriminator 4)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_wake_page_function (mm/filemap.c:1091) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: extent_write_cache_pages (fs/btrfs/extent_io.c:2130) btrfs
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5852 (discriminator 1) kernel/sched/core.c:5849 (discriminator 1) kernel/sched/core.c:5877 (discriminator 1)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? stack_depot_save_flags (lib/stackdepot.c:609) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? put_cpu_partial (./arch/x86/include/asm/irqflags.h:134 (discriminator 1) mm/slub.c:2978 (discriminator 1)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: extent_writepages (fs/btrfs/extent_io.c:131 fs/btrfs/extent_io.c:2275) btrfs
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: do_writepages (mm/page-writeback.c:2612) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? update_sd_lb_stats.constprop.0 (kernel/sched/fair.c:9896 (discriminator 2) kernel/sched/fair.c:10577 (discriminator 2)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: __writeback_single_inode (fs/fs-writeback.c:1659) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: writeback_sb_inodes (fs/fs-writeback.c:1943) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: __writeback_inodes_wb (fs/fs-writeback.c:2013) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: wb_writeback (fs/fs-writeback.c:2119) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: wb_workfn (fs/fs-writeback.c:2276 (discriminator 1) fs/fs-writeback.c:2304 (discriminator 1)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: process_one_work (kernel/workqueue.c:3254) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: worker_thread (kernel/workqueue.c:3329 (discriminator 2) kernel/workqueue.c:3416 (discriminator 2)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_worker_thread (kernel/workqueue.c:3362) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: kthread (kernel/kthread.c:388) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel:  </TASK>
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: INFO: task kworker/u34:9:1268436 blocked for more than 241 seconds.
Apr 16 23:08:11 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4 #4
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: task:kworker/u34:9   state:D stack:0     pid:1268436 tgid:1268436 ppid:2      flags:0x00004000
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: Workqueue: loop5 loop_rootcg_workfn [loop]
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: Call Trace:
Apr 16 23:08:11 base-xfs-nocrc-2k kernel:  <TASK>
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: io_schedule (kernel/sched/core.c:9019 (discriminator 1) kernel/sched/core.c:9045 (discriminator 1)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: folio_wait_bit_common (mm/filemap.c:1275 (discriminator 4)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_wake_page_function (mm/filemap.c:1091) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: btrfs_folio_start_writer_lock (./include/linux/pagemap.h:1048 fs/btrfs/subpage.c:394) btrfs
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: lock_delalloc_pages (fs/btrfs/extent_io.c:281 (discriminator 1)) btrfs
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5852 kernel/sched/core.c:5849 kernel/sched/core.c:5877) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? _raw_spin_unlock (./include/linux/spinlock_api_smp.h:143 (discriminator 3) kernel/locking/spinlock.c:186 (discriminator 3)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? btrfs_find_delalloc_range (fs/btrfs/extent-io-tree.c:1036) btrfs
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: find_lock_delalloc_range (fs/btrfs/extent_io.c:377) btrfs
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: writepage_delalloc (fs/btrfs/extent_io.c:1217 (discriminator 1)) btrfs
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: extent_write_cache_pages (fs/btrfs/extent_io.c:1475 (discriminator 1) fs/btrfs/extent_io.c:2152 (discriminator 1)) btrfs
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: extent_writepages (fs/btrfs/extent_io.c:131 fs/btrfs/extent_io.c:2275) btrfs
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_end_bbio_data_write (fs/btrfs/extent_io.c:463) btrfs
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: do_writepages (mm/page-writeback.c:2612) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pv_queued_spin_lock_slowpath (kernel/locking/qspinlock.c:565 (discriminator 38)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pv_queued_spin_lock_slowpath (kernel/locking/qspinlock.c:565 (discriminator 38)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: filemap_fdatawrite_wbc (mm/filemap.c:398 mm/filemap.c:387) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: __filemap_fdatawrite_range (mm/filemap.c:431) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: start_ordered_ops.constprop.0 (fs/btrfs/file.c:3873 fs/btrfs/file.c:1743) btrfs
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: btrfs_sync_file (fs/btrfs/file.c:1818) btrfs
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: loop_process_work (drivers/block/loop.c:329 (discriminator 1) drivers/block/loop.c:475 (discriminator 1) drivers/block/loop.c:1907 (discriminator 1) drivers/block/loop.c:1942 (discriminator 1)) loop
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: process_one_work (kernel/workqueue.c:3254) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: worker_thread (kernel/workqueue.c:3329 (discriminator 2) kernel/workqueue.c:3416 (discriminator 2)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_worker_thread (kernel/workqueue.c:3362) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: kthread (kernel/kthread.c:388) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel:  </TASK>
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: INFO: task xfsaild/loop5:1377891 blocked for more than 241 seconds.
Apr 16 23:08:11 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4 #4
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: task:xfsaild/loop5   state:D stack:0     pid:1377891 tgid:1377891 ppid:2      flags:0x00004000
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: Call Trace:
Apr 16 23:08:11 base-xfs-nocrc-2k kernel:  <TASK>
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_wbt_cleanup_cb (block/blk-wbt.c:575) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_wbt_inflight_cb (block/blk-wbt.c:569) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: io_schedule (kernel/sched/core.c:9019 (discriminator 1) kernel/sched/core.c:9045 (discriminator 1)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: rq_qos_wait (block/blk-rq-qos.c:284 (discriminator 4)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_rq_qos_wake_function (block/blk-rq-qos.c:208) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_wbt_inflight_cb (block/blk-wbt.c:569) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: wbt_wait (block/blk-wbt.c:660) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: __rq_qos_throttle (block/blk-rq-qos.c:66) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: blk_mq_submit_bio (block/blk-mq.c:2880 block/blk-mq.c:2984) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: submit_bio_noacct_nocheck (./include/linux/bio.h:639 block/blk-core.c:701 block/blk-core.c:729) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? submit_bio_noacct (block/blk-core.c:758 (discriminator 1)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: _xfs_buf_ioapply (fs/xfs/xfs_buf.c:1584 fs/xfs/xfs_buf.c:1671) xfs
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? xfs_dir_ino_validate (fs/xfs/libxfs/xfs_dir2.c:220 (discriminator 2)) xfs
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5852 kernel/sched/core.c:5849 kernel/sched/core.c:5877) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: __xfs_buf_submit (./arch/x86/include/asm/atomic.h:67 ./include/linux/atomic/atomic-arch-fallback.h:2278 ./include/linux/atomic/atomic-instrumented.h:1384 fs/xfs/xfs_buf.c:1762) xfs
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: xfs_buf_delwri_submit_buffers (fs/xfs/xfs_buf.c:2280 (discriminator 2)) xfs
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: xfsaild (fs/xfs/xfs_trans_ail.c:560 (discriminator 1) fs/xfs/xfs_trans_ail.c:671 (discriminator 1)) xfs
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_xfsaild (fs/xfs/xfs_trans_ail.c:597) xfs
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: kthread (kernel/kthread.c:388) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Apr 16 23:08:11 base-xfs-nocrc-2k kernel:  </TASK>
Apr 16 23:08:11 base-xfs-nocrc-2k kernel: Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

  Luis

