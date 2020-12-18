Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283B22DDC54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 01:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbgLRAP1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 19:15:27 -0500
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:37271 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727172AbgLRAP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 19:15:27 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id A2DC51B3DEC;
        Fri, 18 Dec 2020 11:14:43 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kq3Pu-00559F-Q5; Fri, 18 Dec 2020 11:14:42 +1100
Date:   Fri, 18 Dec 2020 11:14:42 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     darrick.wong@oracle.com, willy@infradead.org, hch@infradead.org,
        mhocko@kernel.org, akpm@linux-foundation.org, dhowells@redhat.com,
        jlayton@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v13 4/4] xfs: use current->journal_info to avoid
 transaction reservation recursion
Message-ID: <20201218001442.GS632069@dread.disaster.area>
References: <20201217011157.92549-1-laoar.shao@gmail.com>
 <20201217011157.92549-5-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217011157.92549-5-laoar.shao@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=yPCof4ZbAAAA:8 a=JfrnYn6hAAAA:8
        a=7-415B0cAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
        a=g3Vo3s_gVwYIqt0w1rsA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22 a=AjGcO6oz07-iQ99wixmX:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 09:11:57AM +0800, Yafang Shao wrote:
> PF_FSTRANS which is used to avoid transaction reservation recursion, is
> dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
> PF_MEMALLOC_NOFS") and replaced by PF_MEMALLOC_NOFS which means to avoid
> filesystem reclaim recursion.
> 
> As these two flags have different meanings, we'd better reintroduce
> PF_FSTRANS back. To avoid wasting the space of PF_* flags in task_struct,
> we can reuse the current->journal_info to do that, per Willy. As the
> check of transaction reservation recursion is used by XFS only, we can
> move the check into xfs_vm_writepage(s), per Dave.
> 
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jeff Layton <jlayton@redhat.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  fs/iomap/buffered-io.c |  7 -------
>  fs/xfs/xfs_aops.c      | 17 +++++++++++++++++
>  fs/xfs/xfs_trans.h     | 26 +++++++++++++++++++-------
>  3 files changed, 36 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 10cc7979ce38..3c53fa6ce64d 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1458,13 +1458,6 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  			PF_MEMALLOC))
>  		goto redirty;
>  
> -	/*
> -	 * Given that we do not allow direct reclaim to call us, we should
> -	 * never be called in a recursive filesystem reclaim context.
> -	 */
> -	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> -		goto redirty;
> -
>  	/*
>  	 * Is this page beyond the end of the file?
>  	 *
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 2371187b7615..0da0242d42c3 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -568,6 +568,16 @@ xfs_vm_writepage(
>  {
>  	struct xfs_writepage_ctx wpc = { };
>  
> +	/*
> +	 * Given that we do not allow direct reclaim to call us, we should
> +	 * never be called while in a filesystem transaction.
> +	 */

Comment is wrong. This is not protecting against direct reclaim
recursion, this is protecting against writeback from within a
transaction context.

Best to remove the comment altogether, because it is largely
redundant.

> +	if (WARN_ON_ONCE(xfs_trans_context_active())) {
> +		redirty_page_for_writepage(wbc, page);
> +		unlock_page(page);
> +		return 0;
> +	}
> +
>  	return iomap_writepage(page, wbc, &wpc.ctx, &xfs_writeback_ops);
>  }
>  
> @@ -579,6 +589,13 @@ xfs_vm_writepages(
>  	struct xfs_writepage_ctx wpc = { };
>  
>  	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
> +	/*
> +	 * Given that we do not allow direct reclaim to call us, we should
> +	 * never be called while in a filesystem transaction.
> +	 */

same here.

> +	if (WARN_ON_ONCE(xfs_trans_context_active()))
> +		return 0;
> +
>  	return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
>  }
>  
> diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
> index 12380eaaf7ce..0c8140147b9b 100644
> --- a/fs/xfs/xfs_trans.h
> +++ b/fs/xfs/xfs_trans.h
> @@ -268,29 +268,41 @@ xfs_trans_item_relog(
>  	return lip->li_ops->iop_relog(lip, tp);
>  }
>  
> +static inline bool
> +xfs_trans_context_active(void)
> +{
> +	/* Use journal_info to indicate current is in a transaction */
> +	return current->journal_info != NULL;
> +}

Comment is not necessary.

> +
>  static inline void
>  xfs_trans_context_set(struct xfs_trans *tp)
>  {
> +	ASSERT(!current->journal_info);
> +	current->journal_info = tp;
>  	tp->t_pflags = memalloc_nofs_save();
>  }
>  
>  static inline void
>  xfs_trans_context_clear(struct xfs_trans *tp)
>  {
> +	/*
> +	 * If xfs_trans_context_swap() handed the NOFS context to a
> +	 * new transaction we do not clear the context here.
> +	 */

It's a transaction context, not a "NOFS context". Setting NOFS is
just something we implement inside the transaction context. More
correct would be:

	/*
	 * If we handed over the context via xfs_trans_context_swap() then 
	 * the context is no longer ours to clear.
	 */

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
