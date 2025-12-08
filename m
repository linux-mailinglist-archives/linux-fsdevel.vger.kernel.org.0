Return-Path: <linux-fsdevel+bounces-70957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA435CABF84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 04:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 279013027188
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 03:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616892FAC0C;
	Mon,  8 Dec 2025 03:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjwTlvRu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF5C2F745B;
	Mon,  8 Dec 2025 03:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765164916; cv=none; b=rZBqvLQFXyPMrs4QMVAn0+mKoskNp6rnh0nWTAFMxrZUDA2zKxeYrKoXcDrDlmszWhcPrHXwRHwu+5t5G38d/EKV+pYpCaJQOD1PqkW//eGp7jYKLvJV964fKQFpUO/5ukC6H//kmi/jcsOmEMOevdAWf5KFG/AjfV79Qs2scSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765164916; c=relaxed/simple;
	bh=b5ebnTmJjKhTjUGOiQ5fbxHkDfwqGedNxyuTNDaCw2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCnlhjhb/l1A29eMDxqY0McIR2YbLz7KKcy3GCXAlQ8Sbo4t3NE6LvzwZGOCxR5DGBjvAD5NCUnRTXg0fOej0MGwXLK/PqP2iXHMPyWsMoa9a9ReV4NLdvQQRCBYILg7rwuWTDNxAvLwljEkz8oqULpj/NtR+zPU0BX7++dWVgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjwTlvRu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765164914; x=1796700914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b5ebnTmJjKhTjUGOiQ5fbxHkDfwqGedNxyuTNDaCw2w=;
  b=QjwTlvRuEalGChgevBxoG0caGKTcdYLyLHHtfbwh8g5SK+ZFmbQguTpc
   e3nwbr4hcg7Jn8DpyfXGa0Q0vB8vfGf0cES6+QZ4E+o6F0sFkefJprx5x
   AfeA927sJgq1co+Oraufjxfzd8jUwGRzwDJ5/kIg3eE9o/x4XuaZRTSme
   RPD5oWXVnOu6H9u0d9Y53KpIgkBpyXBble6CivI3TJ5ri36hRKS4Agnk3
   F8jz/gwRMJ0ol3zccwTGm7RXzNQ+e2CQ35E6vgYW3VaS/jtCsuA7T2Jzl
   4wjoRaHkqndwQsexzIruo11GU7RbaWGA31tJQUuVjMrXLIgwNmnjCWB8l
   Q==;
X-CSE-ConnectionGUID: OlOmFfVIRtO3CRALYoLONg==
X-CSE-MsgGUID: D4SsijIXT6SrYKGF0KzVwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="66289295"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="66289295"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 19:35:14 -0800
X-CSE-ConnectionGUID: 1MLbK3qXRzS4I/HF58aJxQ==
X-CSE-MsgGUID: i4mvzUknRXmg7WFi9utuqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="200266554"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 19:35:11 -0800
Date: Mon, 8 Dec 2025 11:35:08 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, djwong@kernel.org,
	willy@infradead.org, brauner@kernel.org, yi1.lai@intel.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v5 5/7] xfs: fill dirty folios on zero range of unwritten
 mappings
Message-ID: <aTZHbMErmQkjWaiY@ly-workstation>
References: <20251003134642.604736-1-bfoster@redhat.com>
 <20251003134642.604736-6-bfoster@redhat.com>
 <aTJLAFyYBtW47r5Q@ly-workstation>
 <aTLkuabg_fP49Gjv@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTLkuabg_fP49Gjv@bfoster>

On Fri, Dec 05, 2025 at 08:57:13AM -0500, Brian Foster wrote:
> On Fri, Dec 05, 2025 at 11:01:20AM +0800, Lai, Yi wrote:
> > On Fri, Oct 03, 2025 at 09:46:39AM -0400, Brian Foster wrote:
> > > Use the iomap folio batch mechanism to select folios to zero on zero
> > > range of unwritten mappings. Trim the resulting mapping if the batch
> > > is filled (unlikely for current use cases) to distinguish between a
> > > range to skip and one that requires another iteration due to a full
> > > batch.
> > > 
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  fs/xfs/xfs_iomap.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > > 
> > > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > > index 6a05e04ad5ba..535bf3b8705d 100644
> > > --- a/fs/xfs/xfs_iomap.c
> > > +++ b/fs/xfs/xfs_iomap.c
> > > @@ -1702,6 +1702,8 @@ xfs_buffered_write_iomap_begin(
> > >  	struct iomap		*iomap,
> > >  	struct iomap		*srcmap)
> > >  {
> > > +	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter,
> > > +						     iomap);
> > >  	struct xfs_inode	*ip = XFS_I(inode);
> > >  	struct xfs_mount	*mp = ip->i_mount;
> > >  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> > > @@ -1773,6 +1775,7 @@ xfs_buffered_write_iomap_begin(
> > >  	 */
> > >  	if (flags & IOMAP_ZERO) {
> > >  		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
> > > +		u64 end;
> > >  
> > >  		if (isnullstartblock(imap.br_startblock) &&
> > >  		    offset_fsb >= eof_fsb)
> > > @@ -1780,6 +1783,26 @@ xfs_buffered_write_iomap_begin(
> > >  		if (offset_fsb < eof_fsb && end_fsb > eof_fsb)
> > >  			end_fsb = eof_fsb;
> > >  
> > > +		/*
> > > +		 * Look up dirty folios for unwritten mappings within EOF.
> > > +		 * Providing this bypasses the flush iomap uses to trigger
> > > +		 * extent conversion when unwritten mappings have dirty
> > > +		 * pagecache in need of zeroing.
> > > +		 *
> > > +		 * Trim the mapping to the end pos of the lookup, which in turn
> > > +		 * was trimmed to the end of the batch if it became full before
> > > +		 * the end of the mapping.
> > > +		 */
> > > +		if (imap.br_state == XFS_EXT_UNWRITTEN &&
> > > +		    offset_fsb < eof_fsb) {
> > > +			loff_t len = min(count,
> > > +					 XFS_FSB_TO_B(mp, imap.br_blockcount));
> > > +
> > > +			end = iomap_fill_dirty_folios(iter, offset, len);
> > > +			end_fsb = min_t(xfs_fileoff_t, end_fsb,
> > > +					XFS_B_TO_FSB(mp, end));
> > > +		}
> > > +
> > >  		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
> > >  	}
> > >  
> > > -- 
> > > 2.51.0
> > >
> >  
> > Hi Brian Foster,
> > 
> > Greetings!
> > 
> > I used Syzkaller and found that there is possible deadlock in xfs_ilock in linux-next next-20251203.
> > 
> > After bisection and the first bad commit is:
> > "
> > 77c475692c5e xfs: fill dirty folios on zero range of unwritten mappings
> > "
> > 
> 
> The referenced reproducer doesn't throw anything for me, but if you want
> to test the following:
> 
> https://lore.kernel.org/linux-fsdevel/20251113135404.553339-1-bfoster@redhat.com/
> 
> ... that removes the allocation associated with this splat. Thanks.
> 
> Brian
>

After applying this patch, the possible deadlock issue cannot be reproduced.

Regards,
Yi Lai
 
> > All detailed into can be found at:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/251204_221645_xfs_ilock
> > Syzkaller repro code:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/251204_221645_xfs_ilock/repro.c
> > Syzkaller repro syscall steps:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/251204_221645_xfs_ilock/repro.prog
> > Syzkaller report:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/251204_221645_xfs_ilock/repro.report
> > Kconfig(make olddefconfig):
> > https://github.com/laifryiee/syzkaller_logs/tree/main/251204_221645_xfs_ilock/kconfig_origin
> > Bisect info:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/251204_221645_xfs_ilock/bisect_info.log
> > bzImage:
> > https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/251204_221645_xfs_ilock/bzImage_b2c27842ba853508b0da00187a7508eb3a96c8f7
> > Issue dmesg:
> > https://github.com/laifryiee/syzkaller_logs/blob/main/251204_221645_xfs_ilock/b2c27842ba853508b0da00187a7508eb3a96c8f7_dmesg.log
> > 
> > "
> > [   21.088994] ======================================================
> > [   21.089362] WARNING: possible circular locking dependency detected
> > [   21.089726] 6.18.0-next-20251203-b2c27842ba85 #1 Not tainted
> > [   21.090060] ------------------------------------------------------
> > [   21.090417] kswapd0/58 is trying to acquire lock:
> > [   21.090697] ffff888028ff1f18 (&xfs_nondir_ilock_class){++++}-{4:4}, at: xfs_ilock+0x30f/0x390
> > [   21.091235]
> > [   21.091235] but task is already holding lock:
> > [   21.091575] ffffffff8784b580 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xb7e/0x15c0
> > [   21.092058]
> > [   21.092058] which lock already depends on the new lock.
> > [   21.092058]
> > [   21.092524]
> > [   21.092524] the existing dependency chain (in reverse order) is:
> > [   21.092949]
> > [   21.092949] -> #1 (fs_reclaim){+.+.}-{0:0}:
> > [   21.093290]        fs_reclaim_acquire+0x116/0x160
> > [   21.093579]        __kmalloc_cache_noprof+0x53/0x7e0
> > [   21.093886]        iomap_fill_dirty_folios+0x118/0x2c0
> > [   21.094204]        xfs_buffered_write_iomap_begin+0xf18/0x2150
> > [   21.094552]        iomap_iter+0x551/0xf40
> > [   21.094798]        iomap_zero_range+0x20b/0xa90
> > [   21.095075]        xfs_zero_range+0xb5/0x100
> > [   21.095335]        xfs_reflink_remap_prep+0x3d3/0xa90
> > [   21.095643]        xfs_file_remap_range+0x23c/0xdc0
> > [   21.095944]        vfs_clone_file_range+0x2b1/0xda0
> > [   21.096243]        ioctl_file_clone+0x6e/0x110
> > [   21.096521]        do_vfs_ioctl+0xcab/0x14d0
> > [   21.096786]        __x64_sys_ioctl+0x127/0x220
> > [   21.097057]        x64_sys_call+0x1280/0x21b0
> > [   21.097331]        do_syscall_64+0x6d/0x1180
> > [   21.097607]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   21.097936]
> > [   21.097936] -> #0 (&xfs_nondir_ilock_class){++++}-{4:4}:
> > [   21.098334]        __lock_acquire+0x14d1/0x2210
> > [   21.098615]        lock_acquire+0x170/0x2f0
> > [   21.098869]        down_write_nested+0x9a/0x210
> > [   21.099145]        xfs_ilock+0x30f/0x390
> > [   21.099385]        xfs_icwalk_ag+0xaec/0x1b60
> > [   21.099652]        xfs_icwalk+0x56/0xc0
> > [   21.099892]        xfs_reclaim_inodes_nr+0x1d3/0x2d0
> > [   21.100192]        xfs_fs_free_cached_objects+0x6a/0x90
> > [   21.100506]        super_cache_scan+0x415/0x570
> > [   21.100794]        do_shrink_slab+0x408/0x1030
> > [   21.101069]        shrink_slab+0x348/0x12f0
> > [   21.101329]        shrink_node+0xacc/0x2670
> > [   21.101587]        balance_pgdat+0xa2d/0x15c0
> > [   21.101860]        kswapd+0x5b9/0xab0
> > [   21.102093]        kthread+0x464/0x980
> > [   21.102329]        ret_from_fork+0x780/0x8f0
> > [   21.102596]        ret_from_fork_asm+0x1a/0x30
> > [   21.102873]
> > [   21.102873] other info that might help us debug this:
> > [   21.102873]
> > [   21.103335]  Possible unsafe locking scenario:
> > [   21.103335]
> > [   21.103683]        CPU0                    CPU1
> > [   21.103955]        ----                    ----
> > [   21.104225]   lock(fs_reclaim);
> > [   21.104428]                                lock(&xfs_nondir_ilock_class);
> > [   21.104823]                                lock(fs_reclaim);
> > [   21.105158]   lock(&xfs_nondir_ilock_class);
> > [   21.105416]
> > [   21.105416]  *** DEADLOCK ***
> > [   21.105416]
> > [   21.105762] 2 locks held by kswapd0/58:
> > [   21.105993]  #0: ffffffff8784b580 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xb7e/0x15c0
> > [   21.106487]  #1: ffff88800fd580e0 (&type->s_umount_key#53){.+.+}-{4:4}, at: super_cache_scan+0x9f/0x570
> > [   21.107047]
> > [   21.107047] stack backtrace:
> > [   21.107307] CPU: 1 UID: 0 PID: 58 Comm: kswapd0 Not tainted 6.18.0-next-20251203-b2c27842ba85 #1 PREEMPT(volu
> > [   21.107319] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.q4
> > [   21.107326] Call Trace:
> > [   21.107335]  <TASK>
> > [   21.107338]  dump_stack_lvl+0xea/0x150
> > [   21.107352]  dump_stack+0x19/0x20
> > [   21.107359]  print_circular_bug+0x283/0x350
> > [   21.107370]  check_noncircular+0x12d/0x150
> > [   21.107383]  __lock_acquire+0x14d1/0x2210
> > [   21.107398]  lock_acquire+0x170/0x2f0
> > [   21.107407]  ? xfs_ilock+0x30f/0x390
> > [   21.107420]  ? __cond_resched+0x37/0x50
> > [   21.107434]  down_write_nested+0x9a/0x210
> > [   21.107445]  ? xfs_ilock+0x30f/0x390
> > [   21.107456]  ? __pfx_down_write_nested+0x10/0x10
> > [   21.107468]  ? xfs_icwalk_ag+0xadf/0x1b60
> > [   21.107482]  ? xfs_icwalk_ag+0xaec/0x1b60
> > [   21.107497]  ? xfs_icwalk_ag+0xaec/0x1b60
> > [   21.107510]  xfs_ilock+0x30f/0x390
> > [   21.107523]  xfs_icwalk_ag+0xaec/0x1b60
> > [   21.107542]  ? __pfx_xfs_icwalk_ag+0x10/0x10
> > [   21.107561]  ? __pfx_xa_find+0x10/0x10
> > [   21.107581]  ? xfs_group_grab_next_mark+0x26a/0x520
> > [   21.107605]  ? __this_cpu_preempt_check+0x21/0x30
> > [   21.107616]  ? lock_release+0x14f/0x2a0
> > [   21.107628]  ? xfs_group_grab_next_mark+0x274/0x520
> > [   21.107643]  ? __pfx_xfs_group_grab_next_mark+0x10/0x10
> > [   21.107662]  ? __pfx_try_to_wake_up+0x10/0x10
> > [   21.107678]  ? lock_release+0x14f/0x2a0
> > [   21.107689]  xfs_icwalk+0x56/0xc0
> > [   21.107704]  xfs_reclaim_inodes_nr+0x1d3/0x2d0
> > [   21.107718]  ? __pfx_xfs_reclaim_inodes_nr+0x10/0x10
> > [   21.107734]  ? __this_cpu_preempt_check+0x21/0x30
> > [   21.107744]  ? __pfx_prune_icache_sb+0x10/0x10
> > [   21.107762]  xfs_fs_free_cached_objects+0x6a/0x90
> > [   21.107777]  super_cache_scan+0x415/0x570
> > [   21.107794]  do_shrink_slab+0x408/0x1030
> > [   21.107813]  shrink_slab+0x348/0x12f0
> > [   21.107831]  ? shrink_slab+0x160/0x12f0
> > [   21.107845]  ? __pfx_shrink_slab+0x10/0x10
> > [   21.107866]  shrink_node+0xacc/0x2670
> > [   21.107888]  ? __pfx_shrink_node+0x10/0x10
> > [   21.107900]  ? preempt_schedule_common+0x49/0xd0
> > [   21.107913]  balance_pgdat+0xa2d/0x15c0
> > [   21.107929]  ? __pfx_balance_pgdat+0x10/0x10
> > [   21.107941]  ? rcu_watching_snap_stopped_since+0x20/0xf0
> > [   21.107975]  kswapd+0x5b9/0xab0
> > [   21.107990]  ? __pfx_kswapd+0x10/0x10
> > [   21.108002]  ? _raw_spin_unlock_irqrestore+0x35/0x70
> > [   21.108017]  ? trace_hardirqs_on+0x26/0x130
> > [   21.108040]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [   21.108060]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> > [   21.108080]  ? __kthread_parkme+0x1bc/0x260
> > [   21.108094]  ? __pfx_kswapd+0x10/0x10
> > [   21.108107]  ? __pfx_kswapd+0x10/0x10
> > [   21.108120]  kthread+0x464/0x980
> > [   21.108128]  ? __pfx_kthread+0x10/0x10
> > [   21.108135]  ? trace_hardirqs_on+0x26/0x130
> > [   21.108149]  ? _raw_spin_unlock_irq+0x3c/0x60
> > [   21.108158]  ? __pfx_kthread+0x10/0x10
> > [   21.108167]  ret_from_fork+0x780/0x8f0
> > [   21.108177]  ? __pfx_ret_from_fork+0x10/0x10
> > [   21.108186]  ? native_load_tls+0x16/0x50
> > [   21.108199]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
> > [   21.108213]  ? __switch_to+0x823/0x10b0
> > [   21.108232]  ? __pfx_kthread+0x10/0x10
> > [   21.108240]  ret_from_fork_asm+0x1a/0x30
> > [   21.108257]  </TASK>
> > [   21.592826] repro: page allocation failure: order:0, mode:0x10cc0(GFP_KERNEL|__GFP_NORETRY), nodemask=(null),0
> > [   21.593533] CPU: 1 UID: 0 PID: 727 Comm: repro Not tainted 6.18.0-next-20251203-b2c27842ba85 #1 PREEMPT(volun
> > [   21.593545] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.q4
> > [   21.593551] Call Trace:
> > [   21.593554]  <TASK>
> > [   21.593557]  dump_stack_lvl+0x121/0x150
> > [   21.593572]  dump_stack+0x19/0x20
> > [   21.593582]  warn_alloc+0x216/0x360
> > [   21.593595]  ? __pfx_warn_alloc+0x10/0x10
> > [   21.593607]  ? __pfx___alloc_pages_direct_compact+0x10/0x10
> > [   21.593618]  ? __drain_all_pages+0x27d/0x480
> > [   21.593628]  __alloc_pages_slowpath.constprop.0+0x1340/0x2230
> > [   21.593644]  ? __pfx___alloc_pages_slowpath.constprop.0+0x10/0x10
> > [   21.593657]  ? __might_sleep+0x108/0x160
> > [   21.593680]  __alloc_frozen_pages_noprof+0x47f/0x550
> > [   21.593690]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
> > [   21.593702]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10
> > [   21.593716]  ? policy_nodemask+0xf9/0x450
> > [   21.593734]  alloc_pages_mpol+0x236/0x4c0
> > [   21.593746]  ? __pfx_alloc_pages_mpol+0x10/0x10
> > [   21.593758]  ? alloc_frozen_pages_noprof+0x48/0x180
> > [   21.593766]  ? alloc_frozen_pages_noprof+0x51/0x180
> > [   21.593775]  alloc_frozen_pages_noprof+0xa9/0x180
> > [   21.593783]  alloc_pages_noprof+0x27/0xa0
> > [   21.593791]  kimage_alloc_pages+0x78/0x240
> > [   21.593809]  kimage_alloc_control_pages+0x1ca/0xa60
> > [   21.593819]  ? __pfx_kimage_alloc_control_pages+0x10/0x10
> > [   21.593827]  ? __sanitizer_cov_trace_cmp8+0x1c/0x30
> > [   21.593844]  do_kexec_load+0x39b/0x8c0
> > [   21.593851]  ? __might_fault+0xf1/0x1b0
> > [   21.593868]  ? __pfx_do_kexec_load+0x10/0x10
> > [   21.593876]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
> > [   21.593887]  ? _copy_from_user+0x75/0xa0
> > [   21.593904]  __x64_sys_kexec_load+0x1cc/0x240
> > [   21.593913]  x64_sys_call+0x1c90/0x21b0
> > [   21.593922]  do_syscall_64+0x6d/0x1180
> > [   21.593930]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   21.593938] RIP: 0033:0x7f347b83ee5d
> > [   21.593952] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 88
> > [   21.593959] RSP: 002b:00007ffc6cb1d938 EFLAGS: 00000207 ORIG_RAX: 00000000000000f6
> > [   21.593972] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f347b83ee5d
> > [   21.593977] RDX: 0000200000000180 RSI: 0000000000000003 RDI: 0000000000000000
> > [   21.593982] RBP: 00007ffc6cb1d950 R08: 00007ffc6cb1d3c0 R09: 00007ffc6cb1d950
> > [   21.593986] R10: 0000000000000000 R11: 0000000000000207 R12: 00007ffc6cb1daa8
> > [   21.593991] R13: 00000000004030f5 R14: 000000000040ee08 R15: 00007f347bb26000
> > [   21.594000]  </TASK>
> > "
> > 
> > Hope this cound be insightful to you.
> > 
> > Regards,
> > Yi Lai
> > 
> > ---
> > 
> > If you don't need the following environment to reproduce the problem or if you
> > already have one reproduced environment, please ignore the following information.
> > 
> > How to reproduce:
> > git clone https://gitlab.com/xupengfe/repro_vm_env.git
> > cd repro_vm_env
> > tar -xvf repro_vm_env.tar.gz
> > cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
> >   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
> >   // You could change the bzImage_xxx as you want
> >   // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> > You could use below command to log in, there is no password for root.
> > ssh -p 10023 root@localhost
> > 
> > After login vm(virtual machine) successfully, you could transfer reproduced
> > binary to the vm by below way, and reproduce the problem in vm:
> > gcc -pthread -o repro repro.c
> > scp -P 10023 repro root@localhost:/root/
> > 
> > Get the bzImage for target kernel:
> > Please use target kconfig and copy it to kernel_src/.config
> > make olddefconfig
> > make -jx bzImage           //x should equal or less than cpu num your pc has
> > 
> > Fill the bzImage file into above start3.sh to load the target kernel in vm.
> > 
> > 
> > Tips:
> > If you already have qemu-system-x86_64, please ignore below info.
> > If you want to install qemu v7.1.0 version:
> > git clone https://github.com/qemu/qemu.git
> > cd qemu
> > git checkout -f v7.1.0
> > mkdir build
> > cd build
> > yum install -y ninja-build.x86_64
> > yum -y install libslirp-devel.x86_64
> > ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> > make
> > make install 
> > 
> > 
> 

