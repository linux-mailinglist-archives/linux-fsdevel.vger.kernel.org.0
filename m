Return-Path: <linux-fsdevel+bounces-17953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807238B42AA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 01:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC46E1C20E50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 23:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8F03BBE1;
	Fri, 26 Apr 2024 23:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxKpmV0r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323083987B;
	Fri, 26 Apr 2024 23:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173653; cv=none; b=SSAmcA2WP1wATXaAVJJJKSFBBPu1dCeRwwBJXdjjOAI4yHge1FTQvg4BUv1K7fAgHSNPpO/EILjK4toTSJ+pJ0wU+x/0UkbmDrRdq8M2pki/QnDbt0eeaJ/4qCVkjKa1jHh9c4xJ+ab6RjRciVzCTrXaV9sWhq8uMF37DdyG4Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173653; c=relaxed/simple;
	bh=+SUwcMe57diWdtLlUgXI6q0655FAOJ9vlqZ2w5se5pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0UU/7O1MDqSYdQXtJOaZ52ClAr0RbFrJWOw8jfUw9b5IWsj+YD9llQBpDSSb9EDTOj/15z/53ynXK6n8Next60kYTm6lYL2hULlAOpLpxcATU4oEHRR8+dzTFJlKjHXkbN/OfWHvjXxJdiSMrT0OqYWnzdYMzFBW08kUD9cS9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxKpmV0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24B5C113CD;
	Fri, 26 Apr 2024 23:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714173652;
	bh=+SUwcMe57diWdtLlUgXI6q0655FAOJ9vlqZ2w5se5pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxKpmV0rsgWXseELIKE60wEGvsQpyrmUjkP8PBG2Z6RnzHTSGqOcGbVhUHRUXSmc2
	 y4qDecMEnpbtKkoa928L4IOZppxa0tDKRTn/wO0WV5JDMXI52lwNyITBE8pxR7L4yF
	 rcs3ngpWeqbVfwc7QG/uwsXm109mTd7j6Ad5fsUTvQ165FbhgMpIHHGHF+nPh6gMZF
	 EEgFc22Zh0vB8QXTnD+zuQOSXftAP73C9uDoZfZY9VHINBbMWW8KbRhoKULDAjSLLt
	 5FPuQWzOVxIEiSlw/Fh+sFPs+NoumpOVWuYYWjhv7o4WzesbcIXHQXJu4Hg1VG1BLH
	 8XvszxoCpd14A==
Date: Fri, 26 Apr 2024 16:20:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: syzbot <syzbot+1619d847a7b9ba3a9137@syzkaller.appspotmail.com>,
	chandan.babu@oracle.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_fs_dirty_inode
Message-ID: <20240426232052.GT360919@frogsfrogsfrogs>
References: <000000000000fee02e0616f8fdff@google.com>
 <20240426163008.GO360919@frogsfrogsfrogs>
 <ZiwbDbYUJgH7t+G6@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiwbDbYUJgH7t+G6@dread.disaster.area>

On Sat, Apr 27, 2024 at 07:22:21AM +1000, Dave Chinner wrote:
> On Fri, Apr 26, 2024 at 09:30:08AM -0700, Darrick J. Wong wrote:
> > On Thu, Apr 25, 2024 at 10:15:29PM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    3b68086599f8 Merge tag 'sched_urgent_for_v6.9_rc5' of git:..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=158206bb180000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f47e5e015c177e57
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=1619d847a7b9ba3a9137
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/caa90b55d476/disk-3b680865.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/17940f1c5e8f/vmlinux-3b680865.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/b03bd6929a1c/bzImage-3b680865.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+1619d847a7b9ba3a9137@syzkaller.appspotmail.com
> > > 
> > > ======================================================
> > > WARNING: possible circular locking dependency detected
> > > 6.9.0-rc4-syzkaller-00274-g3b68086599f8 #0 Not tainted
> > > ------------------------------------------------------
> > > kswapd0/81 is trying to acquire lock:
> > > ffff8881a895a610 (sb_internal#3){.+.+}-{0:0}, at: xfs_fs_dirty_inode+0x158/0x250 fs/xfs/xfs_super.c:689
> > > 
> > > but task is already holding lock:
> > > ffffffff8e428e80 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6782 [inline]
> > > ffffffff8e428e80 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xb20/0x30c0 mm/vmscan.c:7164
> > > 
> > > which lock already depends on the new lock.
> > > 
> > > 
> > > the existing dependency chain (in reverse order) is:
> > > 
> > > -> #2 (fs_reclaim){+.+.}-{0:0}:
> > >        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
> > >        __fs_reclaim_acquire mm/page_alloc.c:3698 [inline]
> > >        fs_reclaim_acquire+0x88/0x140 mm/page_alloc.c:3712
> > >        might_alloc include/linux/sched/mm.h:312 [inline]
> > >        slab_pre_alloc_hook mm/slub.c:3746 [inline]
> > >        slab_alloc_node mm/slub.c:3827 [inline]
> > >        kmalloc_trace+0x47/0x360 mm/slub.c:3992
> > >        kmalloc include/linux/slab.h:628 [inline]
> > >        add_stack_record_to_list mm/page_owner.c:177 [inline]
> 
> There's the GFP_KERNEL allocation being warned about again.
> 
> > >        inc_stack_record_count mm/page_owner.c:219 [inline]
> > >        __set_page_owner+0x561/0x810 mm/page_owner.c:334
> > >        set_page_owner include/linux/page_owner.h:32 [inline]
> > >        post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
> > >        prep_new_page mm/page_alloc.c:1541 [inline]
> > >        get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
> > >        __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
> > >        __alloc_pages_node include/linux/gfp.h:238 [inline]
> > >        alloc_pages_node include/linux/gfp.h:261 [inline]
> > >        alloc_slab_page+0x5f/0x160 mm/slub.c:2175
> > >        allocate_slab mm/slub.c:2338 [inline]
> > >        new_slab+0x84/0x2f0 mm/slub.c:2391
> > >        ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
> > >        __slab_alloc mm/slub.c:3610 [inline]
> > >        __slab_alloc_node mm/slub.c:3663 [inline]
> > >        slab_alloc_node mm/slub.c:3835 [inline]
> > >        kmem_cache_alloc+0x252/0x340 mm/slub.c:3852
> > >        kmem_cache_zalloc include/linux/slab.h:739 [inline]
> > >        xfs_btree_alloc_cursor fs/xfs/libxfs/xfs_btree.h:679 [inline]
> > >        xfs_refcountbt_init_cursor+0x65/0x2a0 fs/xfs/libxfs/xfs_refcount_btree.c:367
> > >        xfs_reflink_find_shared fs/xfs/xfs_reflink.c:147 [inline]
> > >        xfs_reflink_trim_around_shared+0x53a/0x9d0 fs/xfs/xfs_reflink.c:194
> > >        xfs_buffered_write_iomap_begin+0xebf/0x1b40 fs/xfs/xfs_iomap.c:1062
> > 
> > Hm.  We've taken an ILOCK in xfs_buffered_write_iomap_begin, and now
> > we're allocating a btree cursor but we don't have PF_MEMALLOC_NOFS set,
> > nor do we pass GFP_NOFS.
> > 
> > Ah, because nothing in this code path sets PF_MEMALLOC_NOFS explicitly,
> > nor does it create a xfs_trans_alloc_empty, which would set that.  Prior
> > to the removal of kmem_alloc, I think we were much more aggressive about
> > GFP_NOFS usage.
> > 
> > Seeing as we're about to walk a btree, we probably want the empty
> > transaction to guard against btree cycle livelocks.
> 
> Nothing like that is needed or desired, this is a just a bug in the
> memory allocation tracking code...

Not needed because it doesn't address the root cause of these two syzbot
reports?  Or did you actually analyze the refcount btree code and
discover that there's no possibility of livelocking on btree cycles?

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

