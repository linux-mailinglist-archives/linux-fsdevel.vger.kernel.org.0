Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3834C23C23B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 01:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgHDXft (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 19:35:49 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:50416 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbgHDXft (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 19:35:49 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 2F6FC3A45EE;
        Wed,  5 Aug 2020 09:35:43 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1k36T7-0000S4-UF; Wed, 05 Aug 2020 09:35:41 +1000
Date:   Wed, 5 Aug 2020 09:35:41 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com, mhocko@kernel.org,
        willy@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <shaoyafang@didiglobal.com>
Subject: Re: [PATCH v4 2/2] xfs: avoid transaction reservation recursion
Message-ID: <20200804233541.GE2114@dread.disaster.area>
References: <20200801154632.866356-1-laoar.shao@gmail.com>
 <20200801154632.866356-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801154632.866356-3-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=DyMV3BnNAAAA:8 a=7-415B0cAAAA:8
        a=hviAvM6Ym9aLxgkzF5oA:9 a=CjuIK1q_8ugA:10 a=9s3JYx_stmTtqx6mgxhK:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 01, 2020 at 11:46:32AM -0400, Yafang Shao wrote:
> From: Yafang Shao <shaoyafang@didiglobal.com>
> 
> PF_FSTRANS which is used to avoid transaction reservation recursion, is
> dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
> PF_MEMALLOC_NOFS") and commit 7dea19f9ee63 ("mm: introduce
> memalloc_nofs_{save,restore} API") and replaced by PF_MEMALLOC_NOFS which
> means to avoid filesystem reclaim recursion. That change is subtle.
> Let's take the exmple of the check of WARN_ON_ONCE(current->flags &
> PF_MEMALLOC_NOFS)) to explain why this abstraction from PF_FSTRANS to
> PF_MEMALLOC_NOFS is not proper.
> Below comment is quoted from Dave,
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
> As a result, we should reintroduce PF_FSTRANS. As current->journal_info
> isn't used in XFS, we can reuse it to indicate whehter the task is in
> fstrans or not.

IF we are just going to use ->journal_info, do it the simple way.

> index 2d25bab68764..0795511f9e6a 100644
> --- a/fs/xfs/libxfs/xfs_btree.c
> +++ b/fs/xfs/libxfs/xfs_btree.c
> @@ -2825,6 +2825,7 @@ xfs_btree_split_worker(
>  	if (args->kswapd)
>  		new_pflags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
>  
> +	xfs_trans_context_start();

Not really. We are transferring a transaction context here, not
starting one. Hence this reads somewhat strangely.

This implies that the helper function should be something like:

	xfs_trans_context_set(tp);


>  	current_set_flags_nested(&pflags, new_pflags);
>  
>  	args->result = __xfs_btree_split(args->cur, args->level, args->ptrp,
> @@ -2832,6 +2833,7 @@ xfs_btree_split_worker(
>  	complete(args->done);
>  
>  	current_restore_flags_nested(&pflags, new_pflags);
> +	xfs_trans_context_end();

And this is more likely xfs_trans_context_clear(tp)

Reasons for this will become clear soon...

>  }
>  
>  /*
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index b35611882ff9..39ef95acdd8e 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -63,6 +63,8 @@ xfs_setfilesize_trans_alloc(
>  	 * clear the flag here.
>  	 */
>  	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +	xfs_trans_context_end();

Note the repeated pairing of functions in this patch?

> +
>  	return 0;
>  }
>  
> @@ -125,6 +127,7 @@ xfs_setfilesize_ioend(
>  	 * thus we need to mark ourselves as being in a transaction manually.
>  	 * Similarly for freeze protection.
>  	 */
> +	xfs_trans_context_start();
>  	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
>  	__sb_writers_acquired(VFS_I(ip)->i_sb, SB_FREEZE_FS);
>  
> diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
> index 9f70d2f68e05..1192b660a968 100644
> --- a/fs/xfs/xfs_linux.h
> +++ b/fs/xfs/xfs_linux.h
> @@ -111,6 +111,25 @@ typedef __u32			xfs_nlink_t;
>  #define current_restore_flags_nested(sp, f)	\
>  		(current->flags = ((current->flags & ~(f)) | (*(sp) & (f))))
>  
> +static inline void xfs_trans_context_start(void)
> +{
> +	long flags = (long)current->journal_info;
> +
> +	/*
> +	 * Reuse journal_info to indicate whehter the current is in fstrans
> +	 * or not.
> +	 */
> +	current->journal_info = (void *)(flags + 1);
> +}
> +
> +static inline void xfs_trans_context_end(void)
> +{
> +	long flags = (long)current->journal_info;
> +
> +	WARN_ON_ONCE(flags <= 0);
> +	current->journal_info = ((void *)(flags - 1));
> +}

This is overly complex, and cannot be used for validation that we
are clearing the transaction context we expect to be clearing. These
are really "set" and "clear" operations, and for rolling
transactions we are going to need an "update" operation, too.

As per my comments about the previous patch, _set() would be done
in xfs_trans_alloc(), _clear() would be done on the final
xfs_trans_commit() or _cancel() and _update() would be done when the
transaction rolls.

Then we can roll in the NOFS updates, and we get these three helper
functions that keep all the per-transaction thread state coherent:

static inline void
xfs_trans_context_set(struct xfs_trans *tp)
{
	ASSERT(!current->journal_info);
	current->journal_info = tp;
	tp->t_flags = memalloc_nofs_save();
}

static inline void
xfs_trans_context_update(struct xfs_trans *old, struct xfs_trans *new)
{
	ASSERT(current->journal_info == old);
	current->journal_info = new;
	new->t_flags = old->t_flags;
}

static inline void
xfs_trans_context_clear(struct xfs_trans *tp)
{
	ASSERT(current->journal_info == tp);
	current->journal_info = NULL;
	memalloc_nofs_restore(tp->t_flags);
}

static bool
xfs_trans_context_active(void)
{
	return current->journal_info != NULL;
}


Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
