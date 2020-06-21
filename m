Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC35202D9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 01:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgFUXEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jun 2020 19:04:30 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:57073 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726398AbgFUXEa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jun 2020 19:04:30 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 837D43A4B86;
        Mon, 22 Jun 2020 09:04:21 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jn90e-0000u6-Dr; Mon, 22 Jun 2020 09:04:20 +1000
Date:   Mon, 22 Jun 2020 09:04:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mhocko@kernel.org, darrick.wong@oracle.com, hch@infradead.org,
        akpm@linux-foundation.org, bfoster@redhat.com, vbabka@suse.cz,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] xfs: reintroduce PF_FSTRANS for transaction reservation
 recursion protection
Message-ID: <20200621230420.GT2005@dread.disaster.area>
References: <1592637174-19657-1-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592637174-19657-1-git-send-email-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=7-415B0cAAAA:8 a=VwQbUJbxAAAA:8
        a=pGLkceISAAAA:8 a=cCpOmXS292ZDskx4PqcA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22 a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 20, 2020 at 03:12:54AM -0400, Yafang Shao wrote:
> PF_FSTRANS which is used to avoid transaction reservation recursion, is
> dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
> PF_MEMALLOC_NOFS") and commit 7dea19f9ee63 ("mm: introduce
> memalloc_nofs_{save,restore} API") and replaced by PF_MEMALLOC_NOFS which
> means to avoid filesystem reclaim recursion. That change is subtle.
> Let's take the exmple of the check of WARN_ON_ONCE(current->flags &
> PF_MEMALLOC_NOFS)) to explain why this abstraction from PF_FSTRANS to
> PF_MEMALLOC_NOFS is not proper.
> 
> Bellow comment is quoted from Dave,
> > It wasn't for memory allocation recursion protection in XFS - it was for
> > transaction reservation recursion protection by something trying to flush
> > data pages while holding a transaction reservation. Doing
> > this could deadlock the journal because the existing reservation
> > could prevent the nested reservation for being able to reserve space
> > in the journal and that is a self-deadlock vector.
> > IOWs, this check is not protecting against memory reclaim recursion
> > bugs at all (that's the previous check [1]). This check is
> > protecting against the filesystem calling writepages directly from a
> > context where it can self-deadlock.
> > So what we are seeing here is that the PF_FSTRANS ->
> > PF_MEMALLOC_NOFS abstraction lost all the actual useful information
> > about what type of error this check was protecting against.
> 
> Besides reintroducing PF_FSTRANS, there're some other improvements in this
> patch,
> - Remove useless MACRO current_clear_flags_nested(), current_pid() and
>   current_test_flags().
> - Remove useless memalloc_nofs_{save, restore} in __kmem_vmalloc()
> 
> [1]. Bellow check is to avoid memory reclaim recursion.
> if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
> 	PF_MEMALLOC))
> 	goto redirty;
> 
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  fs/iomap/buffered-io.c    |  4 ++--
>  fs/xfs/kmem.c             |  7 -------
>  fs/xfs/kmem.h             |  2 +-
>  fs/xfs/libxfs/xfs_btree.c |  2 +-
>  fs/xfs/xfs_aops.c         |  4 ++--
>  fs/xfs/xfs_linux.h        |  4 ----
>  fs/xfs/xfs_trans.c        | 12 ++++++------
>  include/linux/sched.h     |  1 +
>  8 files changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index bcfc288..0f1945c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1500,9 +1500,9 @@ static void iomap_writepage_end_bio(struct bio *bio)
>  
>  	/*
>  	 * Given that we do not allow direct reclaim to call us, we should
> -	 * never be called in a recursive filesystem reclaim context.
> +	 * never be called while in a filesystem transaction.
>  	 */
> -	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> +	if (WARN_ON_ONCE(current->flags & PF_FSTRANS))
>  		goto redirty;

This is OK, but the rest of the patch is not.

I did not say "replace all XFS use of GFP_NOFS/KM_NOFS with
PF_TRANS", which is what this patch does. The use of
PF_MEMALLOC_NOFS within transactions is correct and valid and needs
to remain. Replacing this with PF_FSTRANS effectively reverts all
the simplifications and obviously self-documneting code that
PF_MEMALLOC_NOFS provides us with.

IOWs, PF_MEMALLOC_NOFS is used to indicate that this is a "no
reclaim recursion" path and so it's use remains completely unchanged
in XFS. PF_FSTRANS is to indicate this is a "no
transaction recursion" path, which is a different thing and needs
it's own specific annotation.

> diff --git a/fs/xfs/kmem.c b/fs/xfs/kmem.c
> index f136647..9875a23 100644
> --- a/fs/xfs/kmem.c
> +++ b/fs/xfs/kmem.c
> @@ -41,18 +41,11 @@
>  static void *
>  __kmem_vmalloc(size_t size, xfs_km_flags_t flags)
>  {
> -	unsigned nofs_flag = 0;
>  	void	*ptr;
>  	gfp_t	lflags = kmem_flags_convert(flags);
>  
> -	if (flags & KM_NOFS)
> -		nofs_flag = memalloc_nofs_save();
> -
>  	ptr = __vmalloc(size, lflags);
>  
> -	if (flags & KM_NOFS)
> -		memalloc_nofs_restore(nofs_flag);
> -

This breaks both kmem_alloc_large() and kmem_alloc_io() if they are
called from an explicit KM_NOFS context. vmalloc() does not respect
the gfp flags that are passed to it and will always do GFP_KERNEL
allocations deep down in the page table allocation code, and hence
we must use memalloc_nofs_save() here if called in a KM_NOFS
context.

>  	return ptr;
>  }
>  
> diff --git a/fs/xfs/kmem.h b/fs/xfs/kmem.h
> index 34cbcfd..ccc63de 100644
> --- a/fs/xfs/kmem.h
> +++ b/fs/xfs/kmem.h
> @@ -34,7 +34,7 @@
>  	BUG_ON(flags & ~(KM_NOFS | KM_MAYFAIL | KM_ZERO | KM_NOLOCKDEP));
>  
>  	lflags = GFP_KERNEL | __GFP_NOWARN;
> -	if (flags & KM_NOFS)
> +	if (current->flags & PF_FSTRANS || flags & KM_NOFS)
>  		lflags &= ~__GFP_FS;

No. If we are in a transaction context, PF_MEMALLOC_NOFS should be
set. We got rid of all the PF_FSTRANS checks out of this code by
moving to PF_MEMALLOC_NOFS, reverting this isn't an improvement.

>  
>  	/*
> diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
> index 2d25bab..65d0afe 100644
> --- a/fs/xfs/libxfs/xfs_btree.c
> +++ b/fs/xfs/libxfs/xfs_btree.c
> @@ -2814,7 +2814,7 @@ struct xfs_btree_split_args {
>  	struct xfs_btree_split_args	*args = container_of(work,
>  						struct xfs_btree_split_args, work);
>  	unsigned long		pflags;
> -	unsigned long		new_pflags = PF_MEMALLOC_NOFS;
> +	unsigned long		new_pflags = PF_FSTRANS;

	new_pflags = PF_MEMALLOC_NOFS | PF_FSTRANS;
>  
>  	/*
>  	 * we are in a transaction context here, but may also be doing work
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index b356118..02733eb 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -62,7 +62,7 @@ static inline bool xfs_ioend_is_append(struct iomap_ioend *ioend)
>  	 * We hand off the transaction to the completion thread now, so
>  	 * clear the flag here.
>  	 */
> -	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +	current_restore_flags_nested(&tp->t_pflags, PF_FSTRANS);

	current_restore_flags_nested(PF_MEMALLOC_NOFS | PF_FSTRANS);

>  	return 0;
>  }
>  
> @@ -125,7 +125,7 @@ static inline bool xfs_ioend_is_append(struct iomap_ioend *ioend)
>  	 * thus we need to mark ourselves as being in a transaction manually.
>  	 * Similarly for freeze protection.
>  	 */
> -	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +	current_set_flags_nested(&tp->t_pflags, PF_FSTRANS);

	current_set_flags_nested(PF_MEMALLOC_NOFS | PF_FSTRANS);

>  	__sb_writers_acquired(VFS_I(ip)->i_sb, SB_FREEZE_FS);
>  
>  	/* we abort the update if there was an IO error */
> diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
> index 9f70d2f..ab737fe 100644
> --- a/fs/xfs/xfs_linux.h
> +++ b/fs/xfs/xfs_linux.h
> @@ -102,12 +102,8 @@
>  #define xfs_cowb_secs		xfs_params.cowb_timer.val
>  
>  #define current_cpu()		(raw_smp_processor_id())
> -#define current_pid()		(current->pid)
> -#define current_test_flags(f)	(current->flags & (f))
>  #define current_set_flags_nested(sp, f)		\
>  		(*(sp) = current->flags, current->flags |= (f))
> -#define current_clear_flags_nested(sp, f)	\
> -		(*(sp) = current->flags, current->flags &= ~(f))
>  #define current_restore_flags_nested(sp, f)	\
>  		(current->flags = ((current->flags & ~(f)) | (*(sp) & (f))))

Separate cleanup patch to remove unrelated definitions, please.

> diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> index 3c94e5f..1c1b982 100644
> --- a/fs/xfs/xfs_trans.c
> +++ b/fs/xfs/xfs_trans.c
> @@ -153,7 +153,7 @@
>  	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
>  
>  	/* Mark this thread as being in a transaction */
> -	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +	current_set_flags_nested(&tp->t_pflags, PF_FSTRANS);
>  

And, again, PF_FSTRANS | PF_MEMALLOC_NOFS through this code.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
