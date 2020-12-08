Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813342D2119
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 03:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgLHCr0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 21:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgLHCr0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:47:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156BAC061749;
        Mon,  7 Dec 2020 18:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4bGdqJOiAh44+Z3o6LJTZujUikOJ+hSG5Cpx9YxdlAk=; b=Hndl8Y3bRfeqMqm5o5aIOKK2jV
        hQ6yMIfYoGsqtQ6eswrgwta5imTo/r+l9dKm0poiDraCArw+0FAy2Tmk7WuAfD8+j2mZ6JnMfuyf+
        3dmtXKAIgkRg67qMjfs3QXubD35twD9azJ2Wq30njVbcbZBYDV7PD8kIzHqIlrSkDQJcdb7JzIb4t
        eNDYwKZjm8hgn5MO135Jbc/d+gCGyqnoRlDPK+4o1iKvTLOyfm/kihQ/td7xnH5tR/yn1rwoCXW8s
        OHO876UoMbIAJg2c7sllgGMpMdhHOstfCPZ67m7j5q5zxH220obP84jyxs1Qpu/Gy8Omyy4tmm8pj
        0AOpzw9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmT1R-00036C-IO; Tue, 08 Dec 2020 02:46:37 +0000
Date:   Tue, 8 Dec 2020 02:46:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     darrick.wong@oracle.com, david@fromorbit.com, hch@infradead.org,
        mhocko@kernel.org, akpm@linux-foundation.org, dhowells@redhat.com,
        jlayton@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v10 2/4] xfs: use memalloc_nofs_{save,restore} in xfs
 transaction
Message-ID: <20201208024637.GG7338@casper.infradead.org>
References: <20201208021543.76501-1-laoar.shao@gmail.com>
 <20201208021543.76501-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208021543.76501-3-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 08, 2020 at 10:15:41AM +0800, Yafang Shao wrote:
> memalloc_nofs_{save,restore} API is introduced in
> commit 7dea19f9ee63 ("mm: introduce memalloc_nofs_{save,restore} API"),
> which gives a better abstraction of the usage around PF_MEMALLOC_NOFS. We'd
> better use this API in XFS instead of using PF_MEMALLOC_NOFS directly as
> well.
> 
> To prepare for the followup patch, two new helpers are introduced in XFS
> to wrap the memalloc_nofs_{save,restore} API, as follows,
> 
> static inline void
> xfs_trans_context_set(struct xfs_trans *tp)
> {
> 	tp->t_pflags = memalloc_nofs_save();
> }
> 
> static inline void
> xfs_trans_context_clear(struct xfs_trans *tp)
> {
> 	memalloc_nofs_restore(tp->t_pflags);
> }

Don't repeat the contents of the patch in the changelog.

Also, this ordering of patches doesn't make sense.  If I saw this
patch by itself instead of part of the series, there's no good reason
to replace one xfs-specific wrapper (current_set_flags_nested) with
another (xfs_trans_context_set).

If the changelog here said something like ...

Introduce a new API to mark the start and end of XFS transactions.
For now, just save and restore the memalloc_nofs flags.

... then it might make more sense to do things in this order.

> These two new helpers are added into xfs_tans.h as they are used in xfs
> transaction only.
> 
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  fs/xfs/xfs_aops.c  |  4 ++--
>  fs/xfs/xfs_linux.h |  4 ----
>  fs/xfs/xfs_trans.c | 13 +++++++------
>  fs/xfs/xfs_trans.h | 12 ++++++++++++
>  4 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 4304c6416fbb..2371187b7615 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -62,7 +62,7 @@ xfs_setfilesize_trans_alloc(
>  	 * We hand off the transaction to the completion thread now, so
>  	 * clear the flag here.
>  	 */
> -	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +	xfs_trans_context_clear(tp);
>  	return 0;
>  }
>  
> @@ -125,7 +125,7 @@ xfs_setfilesize_ioend(
>  	 * thus we need to mark ourselves as being in a transaction manually.
>  	 * Similarly for freeze protection.
>  	 */
> -	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +	xfs_trans_context_set(tp);
>  	__sb_writers_acquired(VFS_I(ip)->i_sb, SB_FREEZE_FS);
>  
>  	/* we abort the update if there was an IO error */
> diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
> index 5b7a1e201559..6ab0f8043c73 100644
> --- a/fs/xfs/xfs_linux.h
> +++ b/fs/xfs/xfs_linux.h
> @@ -102,10 +102,6 @@ typedef __u32			xfs_nlink_t;
>  #define xfs_cowb_secs		xfs_params.cowb_timer.val
>  
>  #define current_cpu()		(raw_smp_processor_id())
> -#define current_set_flags_nested(sp, f)		\
> -		(*(sp) = current->flags, current->flags |= (f))
> -#define current_restore_flags_nested(sp, f)	\
> -		(current->flags = ((current->flags & ~(f)) | (*(sp) & (f))))
>  
>  #define NBBY		8		/* number of bits per byte */
>  
> diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> index c94e71f741b6..11d390f0d3f2 100644
> --- a/fs/xfs/xfs_trans.c
> +++ b/fs/xfs/xfs_trans.c
> @@ -154,7 +154,7 @@ xfs_trans_reserve(
>  	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
>  
>  	/* Mark this thread as being in a transaction */
> -	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +	xfs_trans_context_set(tp);
>  
>  	/*
>  	 * Attempt to reserve the needed disk blocks by decrementing
> @@ -164,7 +164,7 @@ xfs_trans_reserve(
>  	if (blocks > 0) {
>  		error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
>  		if (error != 0) {
> -			current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +			xfs_trans_context_clear(tp);
>  			return -ENOSPC;
>  		}
>  		tp->t_blk_res += blocks;
> @@ -241,7 +241,7 @@ xfs_trans_reserve(
>  		tp->t_blk_res = 0;
>  	}
>  
> -	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +	xfs_trans_context_clear(tp);
>  
>  	return error;
>  }
> @@ -878,7 +878,7 @@ __xfs_trans_commit(
>  
>  	xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
>  
> -	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +	xfs_trans_context_clear(tp);
>  	xfs_trans_free(tp);
>  
>  	/*
> @@ -910,7 +910,8 @@ __xfs_trans_commit(
>  			xfs_log_ticket_ungrant(mp->m_log, tp->t_ticket);
>  		tp->t_ticket = NULL;
>  	}
> -	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +
> +	xfs_trans_context_clear(tp);
>  	xfs_trans_free_items(tp, !!error);
>  	xfs_trans_free(tp);
>  
> @@ -971,7 +972,7 @@ xfs_trans_cancel(
>  	}
>  
>  	/* mark this thread as no longer being in a transaction */
> -	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +	xfs_trans_context_clear(tp);
>  
>  	xfs_trans_free_items(tp, dirty);
>  	xfs_trans_free(tp);
> diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
> index 084658946cc8..44b11c64a15e 100644
> --- a/fs/xfs/xfs_trans.h
> +++ b/fs/xfs/xfs_trans.h
> @@ -268,4 +268,16 @@ xfs_trans_item_relog(
>  	return lip->li_ops->iop_relog(lip, tp);
>  }
>  
> +static inline void
> +xfs_trans_context_set(struct xfs_trans *tp)
> +{
> +	tp->t_pflags = memalloc_nofs_save();
> +}
> +
> +static inline void
> +xfs_trans_context_clear(struct xfs_trans *tp)
> +{
> +	memalloc_nofs_restore(tp->t_pflags);
> +}
> +
>  #endif	/* __XFS_TRANS_H__ */
> -- 
> 2.18.4
> 
> 
