Return-Path: <linux-fsdevel+bounces-17952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463C78B429F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 01:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7CC2830FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 23:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A833BBE1;
	Fri, 26 Apr 2024 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9gEBB/h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA56BA4B;
	Fri, 26 Apr 2024 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173430; cv=none; b=O4uzHf7BdAJvB5i9QYZ3tfrEulJLLalcCBF9UPqIIt3T1KSIh/HrgcIh3hzWLisBDUqrgisGjldkUfadNp/c9ZyPFyUdbaLu8Fpt59x9hPRYLBX+DZi8kL+8FOQ0r+seJhZsoC+q6P4xecX6pMe87Bkp2lefCIlj6V8KGAXCTqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173430; c=relaxed/simple;
	bh=rcMEnyVBn3pKkfcSNlKvp5IFGtJ7Mh/CEE8I3MHF6uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6tEfzJK0a95XoI/t7t4kKgU5j16vznKrTpF35zKaqUxaCbDriUcT3aZdrDjVPp2Veoh5cLlFN5rZEOb9n5O4xy52lujAimVmAnXtBs8oVUzfue2lRr2FF03eaORwNpZ/thI4v2qTY31u2VNjOB+4LKZo0qsBE7LTtsnXEmFFEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9gEBB/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7AFC113CD;
	Fri, 26 Apr 2024 23:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714173429;
	bh=rcMEnyVBn3pKkfcSNlKvp5IFGtJ7Mh/CEE8I3MHF6uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p9gEBB/hpJvW0D7NcGlQ7pnO0GoWzoOY3S5QpN/RanZsD91BUZMPrDnwPwnDNu86q
	 6muCn+nLV6wnDBkuix+X3gTItIuh9P9pHMeURM8GTgwwAG36SZChTn8xx6w7E+I8zK
	 krKCa0RvhLZHK14opkYYNAZYTzqYcgn4YVJl6I9/LpXse63ugx3s11bwQ+Pk0L6ChY
	 XqI+mGm4ePLWu6AqFDEs3Qa5PidssgzU/Ae4DI9O3nHl9rwYWd8NijgsyYv7xTdLSJ
	 DrLBpV00/XNdYYkar1q12mJKAro+Bx5a9FRwHR5DjWtuicKQlBBl+0ldlI+kwIYjG8
	 Efxf4Oy0bQOOA==
Date: Fri, 26 Apr 2024 16:17:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: syzbot <syzbot+b7e8d799f0ab724876f9@syzkaller.appspotmail.com>,
	chandan.babu@oracle.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, linux-mm@kvack.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>
Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_ilock_data_map_shared
Message-ID: <20240426231708.GR360919@frogsfrogsfrogs>
References: <00000000000028dd9a0616ecda61@google.com>
 <20240426163228.GP360919@frogsfrogsfrogs>
 <Ziwag2++iy62jHik@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ziwag2++iy62jHik@dread.disaster.area>

On Sat, Apr 27, 2024 at 07:20:03AM +1000, Dave Chinner wrote:
> [cc linux-mm@kvack.org]
> 
> On Fri, Apr 26, 2024 at 09:32:28AM -0700, Darrick J. Wong wrote:
> > On Thu, Apr 25, 2024 at 07:46:28AM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    977b1ef51866 Merge tag 'block-6.9-20240420' of git://git.k..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=126497cd180000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=d239903bd07761e5
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=b7e8d799f0ab724876f9
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/08d7b6e107aa/disk-977b1ef5.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/9c5e543ffdcf/vmlinux-977b1ef5.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/04a6d79d2f69/bzImage-977b1ef5.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+b7e8d799f0ab724876f9@syzkaller.appspotmail.com
> > > 
> > > XFS (loop2): Ending clean mount
> > > ======================================================
> > > WARNING: possible circular locking dependency detected
> > > 6.9.0-rc4-syzkaller-00266-g977b1ef51866 #0 Not tainted
> > > ------------------------------------------------------
> > > syz-executor.2/7915 is trying to acquire lock:
> > > ffffffff8e42a800 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:312 [inline]
> > > ffffffff8e42a800 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:3746 [inline]
> > > ffffffff8e42a800 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3827 [inline]
> > > ffffffff8e42a800 (fs_reclaim){+.+.}-{0:0}, at: kmalloc_trace+0x47/0x360 mm/slub.c:3992
> > > 
> > > but task is already holding lock:
> > > ffff888056da8118 (&xfs_dir_ilock_class){++++}-{3:3}, at: xfs_ilock_data_map_shared+0x4f/0x70 fs/xfs/xfs_inode.c:114
> > > 
> > > which lock already depends on the new lock.
> > > 
> > > 
> > > the existing dependency chain (in reverse order) is:
> > > 
> > > -> #1 (&xfs_dir_ilock_class){++++}-{3:3}:
> > >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
> > >        down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1695
> > >        xfs_reclaim_inode fs/xfs/xfs_icache.c:945 [inline]
> > >        xfs_icwalk_process_inode fs/xfs/xfs_icache.c:1631 [inline]
> > >        xfs_icwalk_ag+0x120e/0x1ad0 fs/xfs/xfs_icache.c:1713
> > >        xfs_icwalk fs/xfs/xfs_icache.c:1762 [inline]
> > >        xfs_reclaim_inodes_nr+0x257/0x360 fs/xfs/xfs_icache.c:1011
> > >        super_cache_scan+0x411/0x4b0 fs/super.c:227
> > >        do_shrink_slab+0x707/0x1160 mm/shrinker.c:435
> > >        shrink_slab+0x1092/0x14d0 mm/shrinker.c:662
> > >        shrink_one+0x453/0x880 mm/vmscan.c:4774
> > >        shrink_many mm/vmscan.c:4835 [inline]
> > >        lru_gen_shrink_node mm/vmscan.c:4935 [inline]
> > >        shrink_node+0x3b17/0x4310 mm/vmscan.c:5894
> > >        kswapd_shrink_node mm/vmscan.c:6704 [inline]
> > >        balance_pgdat mm/vmscan.c:6895 [inline]
> > >        kswapd+0x1882/0x38a0 mm/vmscan.c:7164
> > >        kthread+0x2f2/0x390 kernel/kthread.c:388
> > >        ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
> > >        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > > 
> > > -> #0 (fs_reclaim){+.+.}-{0:0}:
> > >        check_prev_add kernel/locking/lockdep.c:3134 [inline]
> > >        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
> > >        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
> > >        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
> > >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
> > >        __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
> > >        fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3712
> > >        might_alloc include/linux/sched/mm.h:312 [inline]
> > >        slab_pre_alloc_hook mm/slub.c:3746 [inline]
> > >        slab_alloc_node mm/slub.c:3827 [inline]
> > >        kmalloc_trace+0x47/0x360 mm/slub.c:3992
> > >        kmalloc include/linux/slab.h:628 [inline]
> > >        add_stack_record_to_list mm/page_owner.c:177 [inline]
> > >        inc_stack_record_count mm/page_owner.c:219 [inline]
> > >        __set_page_owner+0x561/0x810 mm/page_owner.c:334
> > >        set_page_owner include/linux/page_owner.h:32 [inline]
> > >        post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
> > >        prep_new_page mm/page_alloc.c:1541 [inline]
> > >        get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
> > >        __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
> > >        __alloc_pages_bulk+0x729/0xd40 mm/page_alloc.c:4523
> > >        alloc_pages_bulk_array include/linux/gfp.h:202 [inline]
> > >        xfs_buf_alloc_pages+0x1a7/0x860 fs/xfs/xfs_buf.c:398
> > >        xfs_buf_find_insert+0x19a/0x1540 fs/xfs/xfs_buf.c:650
> > >        xfs_buf_get_map+0x149c/0x1ae0 fs/xfs/xfs_buf.c:755
> > >        xfs_buf_read_map+0x111/0xa60 fs/xfs/xfs_buf.c:860
> > >        xfs_trans_read_buf_map+0x260/0xad0 fs/xfs/xfs_trans_buf.c:289
> > >        xfs_da_read_buf+0x2b1/0x470 fs/xfs/libxfs/xfs_da_btree.c:2674
> > >        xfs_dir3_block_read+0x92/0x1a0 fs/xfs/libxfs/xfs_dir2_block.c:145
> > >        xfs_dir2_block_lookup_int+0x109/0x7d0 fs/xfs/libxfs/xfs_dir2_block.c:700
> > >        xfs_dir2_block_lookup+0x19a/0x630 fs/xfs/libxfs/xfs_dir2_block.c:650
> > >        xfs_dir_lookup+0x633/0xaf0 fs/xfs/libxfs/xfs_dir2.c:399
> > 
> > Hm.  We've taken an ILOCK in xfs_dir_lookup, and now we're reading a
> > directory block.  We don't have PF_MEMALLOC_NOFS set, nor do we pass
> > GFP_NOFS when allocating the xfs_buf pages.
> > 
> > Nothing in this code path sets PF_MEMALLOC_NOFS explicitly, nor does it
> > create a xfs_trans_alloc_empty, which would set that.  Prior to the
> > removal of kmem_alloc, I think we were much more aggressive about
> > GFP_NOFS usage.
> 
> This isn't an XFS bug. The XFS code is correct - the callsite in the
> buffer cache is using GFP_KERNEL | __GFP_NOLOCKDEP explicitly to
> avoid these sorts of false positives.
> 
> Please take a closer look at the stack trace - there's a second
> memory allocation taking place there way below the XFS memory
> allocation inside the page owner tracking code itself:
> 
> static void add_stack_record_to_list(struct stack_record *stack_record,
>                                      gfp_t gfp_mask)
> {
>         unsigned long flags;
>         struct stack *stack;
> 
>         /* Filter gfp_mask the same way stackdepot does, for consistency */
>         gfp_mask &= ~GFP_ZONEMASK;
>         gfp_mask &= (GFP_ATOMIC | GFP_KERNEL);
>         gfp_mask |= __GFP_NOWARN;
> 
>         set_current_in_page_owner();
>         stack = kmalloc(sizeof(*stack), gfp_mask);
>         if (!stack) {
>                 unset_current_in_page_owner();
>                 return;
>         }
>         unset_current_in_page_owner();
> .....
> 
> Look familiar? That exactly the same gfp mask filtering that the
> stackdepot code was doing that caused this issue with KASAN:
> 
> https://lore.kernel.org/linux-xfs/000000000000fbf10e06164f3695@google.com/
> 
> Which was fixed with this patch:
> 
> https://lore.kernel.org/linux-xfs/20240418141133.22950-1-ryabinin.a.a@gmail.com/
> 
> Essentially, we're now playing whack-a-mole with internal kernel
> debug code that doesn't honor __GFP_NOLOCKDEP....
> 
> MM-people: can you please do an audit of all the nested allocations
> that occur inside the public high level allocation API and ensure
> that they all obey __GFP_NOLOCKDEP so we don't have syzbot keep
> tripping over them one at a time?

Ah.  Well.  Given my clear inability to investigate these reports
sufficiently, I will step back and let the experts handle them from now
on.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

