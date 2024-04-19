Return-Path: <linux-fsdevel+bounces-17311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC9E8AB458
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 19:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890C9287D0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB2E13A86B;
	Fri, 19 Apr 2024 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="47Tn6tP0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88638004E;
	Fri, 19 Apr 2024 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713547534; cv=none; b=CjQSJH7ElKzi6vSIxE+UmUYVv4QRslQbde1B+k5K4cpVbRn6vXICXuHCK6x5kN7TsxlNPp4hPqQk+UdD6R0QfkIarcD++hWGOAKkOJIKpC19OI7scKCm56JyLFHo5lmmVR/XDfPHjiDrimRzeSrhQirWOh6rduusurSH3+vuW+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713547534; c=relaxed/simple;
	bh=ON8x2AUsSzWtvrMUOjSMPuisVmPNv5kw7KexZwh8CgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0MeVilxTi9laaHk5YttNRFoQxydIwLNgkG0OCZWSsmbhmzVg5Vj+Zm5SZxWWMiXFZDkgbwTgI+kbvbYU02kWP4SGsHsxdafqQKE4fCNHIA6Y9FS4rqDS+OJ/rsxDU0P4Ab8L0j8RYhOc2qlwWv9HFn+BCKDhE24b7D1wFcJoC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=47Tn6tP0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4+nIQt2+30Cr28KXSDZpSho0FuIpxxh/GcD5c9Bt/Vk=; b=47Tn6tP0rQ1cOH7nHkZoJuUwyQ
	fG3y0EbQpxpurzm1rvtT1rbx3hwJSZdjIyB4Bb0QI5b384TGBBvenZCkPrqhwReQhMojg8mEbIrvu
	9W5IR0FayUQ3Ss9c55HSLe4jje0ney8wQFTum2WORI0uIyRPbklTpNfD4NJD5BNBlOUk5ea4HXic+
	vl0iVmuTFyik81UF2PxY4Cz1+4QwGDB53Z5e/f6IYfvRd2Io2w20FRlrI+6HsG2s/OEev5EfrnTVX
	P4yBuaA0y7OAQh6sSx+FxHtIMgGaWw0LbdRsPkZs2zgc7yuqhC7jjh3qHGB3CR+HqCzVhCIa7m+uR
	ZiUtoEug==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxrzM-00000006X1r-2kWR;
	Fri, 19 Apr 2024 17:25:28 +0000
Date: Fri, 19 Apr 2024 10:25:28 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org,
	kdevops@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, david@redhat.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] fstests: add fsstress + compaction test
Message-ID: <ZiKpCBhywMFaOJp0@bombadil.infradead.org>
References: <20240418001356.95857-1-mcgrof@kernel.org>
 <ZiB5x-EKrmb1ZPuf@casper.infradead.org>
 <ZiDEYrY479OdZBq2@infradead.org>
 <d0d118ed-88dd-4757-8693-f0730dc9727c@suse.cz>
 <20240418114552.37e9cc827d68e3c4781dd61a@linux-foundation.org>
 <ZiFt8uGMLIWuTh4g@casper.infradead.org>
 <3d4eac1f-8f33-4fbb-8c9f-5d7b2c50b6dd@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d4eac1f-8f33-4fbb-8c9f-5d7b2c50b6dd@suse.cz>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Apr 19, 2024 at 09:51:35AM +0200, Vlastimil Babka wrote:
> On 4/18/24 9:01 PM, Matthew Wilcox wrote:
> > On Thu, Apr 18, 2024 at 11:45:52AM -0700, Andrew Morton wrote:
> >> It indeed appears that I can move
> >> 
> >> mm-create-folio_flag_false-and-folio_type_ops-macros.patch
> >> mm-support-page_mapcount-on-page_has_type-pages.patch
> >> mm-turn-folio_test_hugetlb-into-a-pagetype.patch
> >> mm-turn-folio_test_hugetlb-into-a-pagetype-fix.patch
> >> 
> >> without merge or build issues.  I added
> >> 
> >> Fixes: 9c5ccf2db04b ("mm: remove HUGETLB_PAGE_DTOR")
> >> Cc: <stable@vger.kernel.org>
> >> 
> >> to all patches.
> >> 
> >> But a question: 9c5ccf2db04b is from August 2023.  Why are we seeing
> >> this issue now?
> > 
> > We saw it earlier, we just didn't know how to fix it.
> > eg December 2023:
> > https://lore.kernel.org/all/ZXNhGsX32y19a2Xv@casper.infradead.org/
> > 
> > I think there were earlier reports, but I'm not finding them now.
> 
> It's a race and needs CONFIG_DEBUG_VM to be visible, which probably makes it
> rare.

Sure, but what would be the impact in practice if life chugs on with
the assumtions being incorrect?

> What seems to be new are the stress tests that have more "luck" at
> hitting it?

The fsstress tests are not new, the test in this patch just adds a
background forceful compaction to try to make this easier to reproduce.
Although it is hard to reproduce at least we now have a 100% confidence
way to reproduce new issues as described below. Also I hope that the
automation with kdevops allows anyone to easily ramp up and reproduce
this rather fast too as described in the patch first email.

> Or maybe also the changes towards more high-order folio usage
> make it more likely.

I've applied these 3 patches to v6.9-rc4:

mm: Create FOLIO_FLAG_FALSE and FOLIO_TYPE_OPS macros
mm: Support page_mapcount() on page_has_type() pages
mm: Turn folio_test_hugetlb into a PageType

The test in this patch still manages to trigger an unrecoverable
situation, and the trace is below. Note I'm using a SOAK_DURATION=9900
so about 2.75 hours on this test, the timestamps on the first task
blocking shows it took about 1 hour 11 minutes for this to trigger.

write_cache_pages() seems to linger with compaction.

  Luis

Apr 18 16:37:28 base-xfs-nocrc-2k unknown: run fstests generic/744 at 2024-04-18 16:37:28
Apr 18 16:37:29 base-xfs-nocrc-2k kernel: XFS (loop5): Mounting V4 Filesystem 2c71ddbc-bc0d-47d2-ad67-8089bc7434cf
Apr 18 16:37:29 base-xfs-nocrc-2k kernel: XFS (loop5): Ending clean mount
Apr 18 16:37:29 base-xfs-nocrc-2k kernel: xfs filesystem being mounted at /media/scratch supports timestamps until 2038-01-19 (0x7fffffff)
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: INFO: task kworker/u37:7:44996 blocked for more than 120 seconds.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4+ #6
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: task:kworker/u37:7   state:D stack:0     pid:44996 tgid:44996 ppid:2      flags:0x00004000
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: Workqueue: writeback wb_workfn (flush-7:5)
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: Call Trace:
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  <TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: schedule_timeout (kernel/time/timer.c:2559) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? check_preempt_wakeup_fair (kernel/sched/fair.c:8349 (discriminator 1)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __wait_for_common (kernel/sched/completion.c:95 kernel/sched/completion.c:116) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_schedule_timeout (kernel/time/timer.c:2544) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __flush_workqueue (kernel/workqueue.c:4002 (discriminator 2)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xlog_cil_push_now.isra.0 (fs/xfs/xfs_log_cil.c:1477 (discriminator 29)) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xlog_cil_force_seq (./include/linux/spinlock.h:351 fs/xfs/xfs_log_cil.c:1687) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __xfs_btree_check_block (fs/xfs/libxfs/xfs_btree.c:244 fs/xfs/libxfs/xfs_btree.c:272) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_log_force (./include/linux/spinlock.h:351 fs/xfs/xfs_log.c:3194) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_extent_busy_flush (fs/xfs/xfs_extent_busy.c:615) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_autoremove_wake_function (kernel/sched/wait.c:383) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_alloc_ag_vextent_size (fs/xfs/libxfs/xfs_alloc.c:1879) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_alloc_vextent_iterate_ags.constprop.0 (fs/xfs/libxfs/xfs_alloc.c:3700) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_alloc_vextent_start_ag (fs/xfs/libxfs/xfs_alloc.c:3768) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_bmap_btalloc (fs/xfs/libxfs/xfs_bmap.c:3767 fs/xfs/libxfs/xfs_bmap.c:3808) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_bmapi_allocate (fs/xfs/libxfs/xfs_bmap.c:4184 fs/xfs/libxfs/xfs_bmap.c:4227) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_bmapi_convert_delalloc (fs/xfs/libxfs/xfs_bmap.c:4692) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_map_blocks (fs/xfs/xfs_aops.c:268 fs/xfs/xfs_aops.c:390) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: iomap_do_writepage (fs/iomap/buffered-io.c:1777 fs/iomap/buffered-io.c:1925 fs/iomap/buffered-io.c:1964) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_iomap_do_writepage (fs/iomap/buffered-io.c:1963) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: write_cache_pages (mm/page-writeback.c:2569) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: iomap_writepages (fs/iomap/buffered-io.c:1984) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_vm_writepages (fs/xfs/xfs_aops.c:508) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: do_writepages (mm/page-writeback.c:2612) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? wakeup_preempt (kernel/sched/core.c:2240) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? ttwu_do_activate (kernel/sched/core.c:3768 (discriminator 2) kernel/sched/core.c:3796 (discriminator 2)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:152 (discriminator 3) kernel/locking/spinlock.c:194 (discriminator 3)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? try_to_wake_up (./include/linux/preempt.h:480 (discriminator 3) ./include/linux/preempt.h:480 (discriminator 3) kernel/sched/core.c:4233 (discriminator 3)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __writeback_single_inode (fs/fs-writeback.c:1659) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: writeback_sb_inodes (fs/fs-writeback.c:1943) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: wb_writeback (fs/fs-writeback.c:2117) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: wb_workfn (fs/fs-writeback.c:2265 fs/fs-writeback.c:2304) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __schedule (kernel/sched/core.c:6752) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: process_one_work (kernel/workqueue.c:3254) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: worker_thread (kernel/workqueue.c:3329 (discriminator 2) kernel/workqueue.c:3416 (discriminator 2)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_worker_thread (kernel/workqueue.c:3362) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: kthread (kernel/kthread.c:388) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  </TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: INFO: task xfsaild/loop5:46115 blocked for more than 120 seconds.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4+ #6
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: task:xfsaild/loop5   state:D stack:0     pid:46115 tgid:46115 ppid:2      flags:0x00004000
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: Call Trace:
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  <TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_wbt_cleanup_cb (block/blk-wbt.c:575) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_wbt_inflight_cb (block/blk-wbt.c:569) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: io_schedule (kernel/sched/core.c:9019 (discriminator 1) kernel/sched/core.c:9045 (discriminator 1)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: rq_qos_wait (block/blk-rq-qos.c:284 (discriminator 4)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_rq_qos_wake_function (block/blk-rq-qos.c:208) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_wbt_inflight_cb (block/blk-wbt.c:569) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: wbt_wait (block/blk-wbt.c:660) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __rq_qos_throttle (block/blk-rq-qos.c:66) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: blk_mq_submit_bio (block/blk-mq.c:2880 block/blk-mq.c:2984) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: submit_bio_noacct_nocheck (./include/linux/bio.h:639 block/blk-core.c:701 block/blk-core.c:729) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? submit_bio_noacct (block/blk-core.c:758 (discriminator 1)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: _xfs_buf_ioapply (fs/xfs/xfs_buf.c:1584 fs/xfs/xfs_buf.c:1671) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5852 kernel/sched/core.c:5849 kernel/sched/core.c:5877) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __xfs_buf_submit (./arch/x86/include/asm/atomic.h:67 ./include/linux/atomic/atomic-arch-fallback.h:2278 ./include/linux/atomic/atomic-instrumented.h:1384 fs/xfs/xfs_buf.c:1762) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_buf_delwri_submit_buffers (fs/xfs/xfs_buf.c:2280 (discriminator 2)) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfsaild (fs/xfs/xfs_trans_ail.c:560 (discriminator 1) fs/xfs/xfs_trans_ail.c:671 (discriminator 1)) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_xfsaild (fs/xfs/xfs_trans_ail.c:597) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: kthread (kernel/kthread.c:388) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  </TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: INFO: task 744:46117 blocked for more than 120 seconds.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4+ #6
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: task:744             state:D stack:0     pid:46117 tgid:46117 ppid:45928  flags:0x00004002
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: Call Trace:
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  <TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: io_schedule (kernel/sched/core.c:9019 (discriminator 1) kernel/sched/core.c:9045 (discriminator 1)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: folio_wait_bit_common (mm/filemap.c:1275 (discriminator 4)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_wake_page_function (mm/filemap.c:1091) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: migrate_pages_batch (./include/linux/pagemap.h:1048 mm/migrate.c:1486 mm/migrate.c:1700) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_compaction_free (mm/compaction.c:1907) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_compaction_alloc (mm/compaction.c:1855) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __mod_node_page_state (mm/vmstat.c:403 (discriminator 2)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: migrate_pages (mm/migrate.c:1849 mm/migrate.c:1953) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_compaction_alloc (mm/compaction.c:1855) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_compaction_free (mm/compaction.c:1907) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __mod_node_page_state (mm/vmstat.c:403 (discriminator 2)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? folio_putback_lru (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/atomic/atomic-instrumented.h:33 ./include/linux/page_ref.h:67 ./include/linux/mm.h:1134 ./include/linux/mm.h:1140 ./include/linux/mm.h:1507 mm/vmscan.c:819) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: compact_zone (mm/compaction.c:2663) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: compact_node (mm/compaction.c:2925) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: sysctl_compaction_handler (mm/compaction.c:2946 mm/compaction.c:2996 mm/compaction.c:2983) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: proc_sys_call_handler (fs/proc/proc_sysctl.c:595) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: vfs_write (./include/linux/fs.h:2110 fs/read_write.c:497 fs/read_write.c:590) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ksys_write (fs/read_write.c:643) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RIP: 0033:0x7fd5b7abe240
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RSP: 002b:00007fff12f5c1d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fd5b7abe240
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RDX: 0000000000000002 RSI: 0000556d0aacf160 RDI: 0000000000000001
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RBP: 0000556d0aacf160 R08: 0000000000000007 R09: 0000000000000073
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: R13: 00007fd5b7b99760 R14: 0000000000000002 R15: 00007fd5b7b949e0
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  </TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: INFO: task fsstress:46119 blocked for more than 120 seconds.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4+ #6
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: task:fsstress        state:D stack:0     pid:46119 tgid:46119 ppid:46118  flags:0x00000002
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: Call Trace:
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  <TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? path_openat (fs/namei.c:3497 fs/namei.c:3566 fs/namei.c:3796) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: schedule_timeout (kernel/time/timer.c:2559) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_free_object_rcu (mm/kmemleak.c:508) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __call_rcu_common.constprop.0 (./arch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/cpumask.h:505 ./include/linux/cpumask.h:1120 kernel/rcu/tree.c:2628 kernel/rcu/tree.c:2755) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __wait_for_common (kernel/sched/completion.c:95 kernel/sched/completion.c:116) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_schedule_timeout (kernel/time/timer.c:2544) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __flush_work.isra.0 (kernel/workqueue.c:4211) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_wq_barrier_func (kernel/workqueue.c:3742) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_flush_inodes (fs/xfs/xfs_super.c:635 (discriminator 1)) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_create (fs/xfs/xfs_inode.c:1067) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:152 (discriminator 3) kernel/locking/spinlock.c:194 (discriminator 3)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __wake_up (kernel/sched/wait.c:110 kernel/sched/wait.c:127) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? get_cached_acl (fs/posix_acl.c:62) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_generic_create (fs/xfs/xfs_iops.c:199 (discriminator 1)) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: path_openat (fs/namei.c:3497 fs/namei.c:3566 fs/namei.c:3796) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: do_filp_open (fs/namei.c:3826) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5852 kernel/sched/core.c:5849 kernel/sched/core.c:5877) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __check_object_size (mm/usercopy.c:196 mm/usercopy.c:251 mm/usercopy.c:213) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: do_sys_openat2 (fs/open.c:1406) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __x64_sys_creat (fs/open.c:1491) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RIP: 0033:0x7fba99e17a60
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RSP: 002b:00007ffff8aaf2f8 EFLAGS: 00000202 ORIG_RAX: 0000000000000055
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RAX: ffffffffffffffda RBX: 00000000000b0041 RCX: 00007fba99e17a60
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RDX: 0000000000000000 RSI: 00000000000001b6 RDI: 000055602f262c70
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RBP: 00007ffff8aaf460 R08: 00007fba99ef1c60 R09: 0000000000000078
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: R10: 00007ffff8aaef74 R11: 0000000000000202 R12: 00000000000001b6
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: R13: 0000000000000000 R14: 00007ffff8aaf460 R15: 0000000000000001
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  </TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: INFO: task fsstress:46120 blocked for more than 121 seconds.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4+ #6
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: task:fsstress        state:D stack:0     pid:46120 tgid:46120 ppid:46118  flags:0x00000002
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: Call Trace:
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  <TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: schedule_timeout (kernel/time/timer.c:2559) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? wakeup_preempt (kernel/sched/core.c:2240) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __wait_for_common (kernel/sched/completion.c:95 kernel/sched/completion.c:116) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_schedule_timeout (kernel/time/timer.c:2544) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __flush_work.isra.0 (kernel/workqueue.c:4211) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_wq_barrier_func (kernel/workqueue.c:3742) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_create (fs/xfs/xfs_inode.c:1067) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __get_acl.part.0 (fs/posix_acl.c:159) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_generic_create (fs/xfs/xfs_iops.c:199 (discriminator 1)) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: path_openat (fs/namei.c:3497 fs/namei.c:3566 fs/namei.c:3796) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: do_filp_open (fs/namei.c:3826) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5852 kernel/sched/core.c:5849 kernel/sched/core.c:5877) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __check_object_size (mm/usercopy.c:196 mm/usercopy.c:251 mm/usercopy.c:213) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: do_sys_openat2 (fs/open.c:1406) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __x64_sys_creat (fs/open.c:1491) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RIP: 0033:0x7fba99e17a60
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RSP: 002b:00007ffff8aaf2f8 EFLAGS: 00000202 ORIG_RAX: 0000000000000055
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RAX: ffffffffffffffda RBX: 00000000000aff0e RCX: 00007fba99e17a60
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RDX: 0000000000000000 RSI: 00000000000001b6 RDI: 000055602f2872a0
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RBP: 00007ffff8aaf460 R08: 00007fba99ef1c60 R09: 000055602f287550
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: R10: 5a4c7c6f94523808 R11: 0000000000000202 R12: 00000000000001b6
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: R13: 0000000000000000 R14: 00007ffff8aaf460 R15: 0000000000000001
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  </TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: INFO: task fsstress:46121 blocked for more than 121 seconds.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4+ #6
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: task:fsstress        state:D stack:0     pid:46121 tgid:46121 ppid:46118  flags:0x00000002
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: Call Trace:
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  <TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? path_openat (fs/namei.c:3497 fs/namei.c:3566 fs/namei.c:3796) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: schedule_timeout (kernel/time/timer.c:2559) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_free_object_rcu (mm/kmemleak.c:508) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __call_rcu_common.constprop.0 (./arch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/cpumask.h:505 ./include/linux/cpumask.h:1120 kernel/rcu/tree.c:2628 kernel/rcu/tree.c:2755) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __wait_for_common (kernel/sched/completion.c:95 kernel/sched/completion.c:116) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_schedule_timeout (kernel/time/timer.c:2544) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __flush_work.isra.0 (kernel/workqueue.c:4211) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_wq_barrier_func (kernel/workqueue.c:3742) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_flush_inodes (fs/xfs/xfs_super.c:635 (discriminator 1)) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_create (fs/xfs/xfs_inode.c:1067) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:152 (discriminator 3) kernel/locking/spinlock.c:194 (discriminator 3)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __wake_up (kernel/sched/wait.c:110 kernel/sched/wait.c:127) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? get_cached_acl (fs/posix_acl.c:62) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_generic_create (fs/xfs/xfs_iops.c:199 (discriminator 1)) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: path_openat (fs/namei.c:3497 fs/namei.c:3566 fs/namei.c:3796) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: do_filp_open (fs/namei.c:3826) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5852 kernel/sched/core.c:5849 kernel/sched/core.c:5877) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __check_object_size (mm/usercopy.c:196 mm/usercopy.c:251 mm/usercopy.c:213) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: do_sys_openat2 (fs/open.c:1406) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __x64_sys_creat (fs/open.c:1491) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RIP: 0033:0x7fba99e17a60
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RSP: 002b:00007ffff8aaf2f8 EFLAGS: 00000202 ORIG_RAX: 0000000000000055
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RAX: ffffffffffffffda RBX: 00000000000b698d RCX: 00007fba99e17a60
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RDX: 0000000000000000 RSI: 00000000000001b6 RDI: 000055602f304f60
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RBP: 00007ffff8aaf460 R08: 00007fba99ef1c60 R09: 0000000000000078
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: R10: 00007ffff8aaef73 R11: 0000000000000202 R12: 00000000000001b6
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: R13: 0000000000000000 R14: 00007ffff8aaf460 R15: 0000000000000001
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  </TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: INFO: task fsstress:46122 blocked for more than 121 seconds.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4+ #6
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: task:fsstress        state:D stack:0     pid:46122 tgid:46122 ppid:46118  flags:0x00004002
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: Call Trace:
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  <TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: schedule_timeout (kernel/time/timer.c:2559) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:152 (discriminator 3) kernel/locking/spinlock.c:194 (discriminator 3)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? try_to_wake_up (./include/linux/preempt.h:480 (discriminator 3) ./include/linux/preempt.h:480 (discriminator 3) kernel/sched/core.c:4233 (discriminator 3)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __wait_for_common (kernel/sched/completion.c:95 kernel/sched/completion.c:116) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_schedule_timeout (kernel/time/timer.c:2544) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __flush_workqueue (kernel/workqueue.c:4002 (discriminator 2)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xlog_cil_push_now.isra.0 (fs/xfs/xfs_log_cil.c:1477 (discriminator 29)) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xlog_cil_force_seq (./include/linux/spinlock.h:351 fs/xfs/xfs_log_cil.c:1687) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5852 (discriminator 1) kernel/sched/core.c:5849 (discriminator 1) kernel/sched/core.c:5877 (discriminator 1)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_log_force (./include/linux/spinlock.h:351 fs/xfs/xfs_log.c:3194) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_fs_sync_fs (fs/xfs/xfs_super.c:782) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_sync_fs_one_sb (fs/sync.c:81) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: iterate_supers (fs/super.c:922) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ksys_sync (fs/sync.c:105) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __do_sys_sync (fs/sync.c:115) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RIP: 0033:0x7fba99e1db97
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RSP: 002b:00007ffff8aaf498 EFLAGS: 00000202 ORIG_RAX: 00000000000000a2
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RAX: ffffffffffffffda RBX: 00000000000b1de4 RCX: 00007fba99e1db97
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RDX: 000000005764828b RSI: 000000005764828b RDI: 00000000000b1de4
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: RBP: 000000000000c350 R08: 0000000000000073 R09: 0000000000000000
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: R10: 00007ffff8aaf4e0 R11: 0000000000000202 R12: 0000555ff6a925a0
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: R13: 028f5c28f5c28f5c R14: 8f5c28f5c28f5c29 R15: 0000555ff6a7f540
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  </TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: INFO: task kworker/u38:1:46372 blocked for more than 121 seconds.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4+ #6
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: task:kworker/u38:1   state:D stack:0     pid:46372 tgid:46372 ppid:2      flags:0x00004000
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: Workqueue: xfs-cil/loop5 xlog_cil_push_work [xfs]
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: Call Trace:
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  <TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xlog_wait_on_iclog (fs/xfs/xfs_log_priv.h:623 fs/xfs/xfs_log.c:892) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_default_wake_function (kernel/sched/core.c:7078) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xlog_cil_push_work (./include/linux/spinlock.h:351 fs/xfs/xfs_log_cil.c:1312) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: process_one_work (kernel/workqueue.c:3254) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: worker_thread (kernel/workqueue.c:3329 (discriminator 2) kernel/workqueue.c:3416 (discriminator 2)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_worker_thread (kernel/workqueue.c:3362) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: kthread (kernel/kthread.c:388) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  </TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: INFO: task kworker/u37:5:47276 blocked for more than 121 seconds.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4+ #6
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: task:kworker/u37:5   state:D stack:0     pid:47276 tgid:47276 ppid:2      flags:0x00004000
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: Workqueue: loop5 loop_rootcg_workfn [loop]
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: Call Trace:
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  <TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: io_schedule (kernel/sched/core.c:9019 (discriminator 1) kernel/sched/core.c:9045 (discriminator 1)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: folio_wait_bit_common (mm/filemap.c:1275 (discriminator 4)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_wake_page_function (mm/filemap.c:1091) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: extent_write_cache_pages (fs/btrfs/extent_io.c:2130) btrfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: extent_writepages (fs/btrfs/extent_io.c:131 fs/btrfs/extent_io.c:2275) btrfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_end_bbio_data_write (fs/btrfs/extent_io.c:463) btrfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: do_writepages (mm/page-writeback.c:2612) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? process_one_work (kernel/workqueue.c:3254) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? worker_thread (kernel/workqueue.c:3329 (discriminator 2) kernel/workqueue.c:3416 (discriminator 2)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? kthread (kernel/kthread.c:388) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? ret_from_fork (arch/x86/kernel/process.c:147) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5852 kernel/sched/core.c:5849 kernel/sched/core.c:5877) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __link_object (./include/linux/rculist.h:79 (discriminator 1) ./include/linux/rculist.h:128 (discriminator 1) mm/kmemleak.c:733 (discriminator 1)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: filemap_fdatawrite_wbc (mm/filemap.c:398 mm/filemap.c:387) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __filemap_fdatawrite_range (mm/filemap.c:431) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: start_ordered_ops.constprop.0 (fs/btrfs/file.c:3873 fs/btrfs/file.c:1743) btrfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: btrfs_sync_file (fs/btrfs/file.c:1818) btrfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: loop_process_work (drivers/block/loop.c:329 (discriminator 1) drivers/block/loop.c:475 (discriminator 1) drivers/block/loop.c:1907 (discriminator 1) drivers/block/loop.c:1942 (discriminator 1)) loop
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: process_one_work (kernel/workqueue.c:3254) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: worker_thread (kernel/workqueue.c:3329 (discriminator 2) kernel/workqueue.c:3416 (discriminator 2)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_worker_thread (kernel/workqueue.c:3362) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: kthread (kernel/kthread.c:388) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  </TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: INFO: task kworker/6:2:48556 blocked for more than 121 seconds.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:       Not tainted 6.9.0-rc4+ #6
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: task:kworker/6:2     state:D stack:0     pid:48556 tgid:48556 ppid:2      flags:0x00004000
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: Workqueue: xfs-conv/loop5 xfs_end_io [xfs]
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: Call Trace:
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  <TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: __schedule (kernel/sched/core.c:5409 kernel/sched/core.c:6746) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: schedule (kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: schedule_preempt_disabled (kernel/sched/core.c:6896) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: rwsem_down_write_slowpath (kernel/locking/rwsem.c:1180 (discriminator 4)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? xfs_trans_alloc (fs/xfs/xfs_trans.c:271 (discriminator 1)) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: down_write (kernel/locking/rwsem.c:1306 kernel/locking/rwsem.c:1315 kernel/locking/rwsem.c:1580) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_trans_alloc_inode (fs/xfs/xfs_trans.c:1210) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_iomap_write_unwritten (fs/xfs/xfs_iomap.c:606) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? iomap_finish_ioends (fs/iomap/buffered-io.c:1558) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_end_ioend (fs/xfs/xfs_aops.c:131) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: xfs_end_io (./include/linux/sched.h:1988 fs/xfs/xfs_aops.c:174) xfs
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: process_one_work (kernel/workqueue.c:3254) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: worker_thread (kernel/workqueue.c:3329 (discriminator 2) kernel/workqueue.c:3416 (discriminator 2)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_worker_thread (kernel/workqueue.c:3362) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: kthread (kernel/kthread.c:388) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ret_from_fork (arch/x86/kernel/process.c:147) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ? __pfx_kthread (kernel/kthread.c:341) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
Apr 18 17:48:27 base-xfs-nocrc-2k kernel:  </TASK>
Apr 18 17:48:27 base-xfs-nocrc-2k kernel: Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings


