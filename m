Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE072DDB3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 23:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbgLQWPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 17:15:55 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:45282 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729612AbgLQWPz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 17:15:55 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 3716D63828;
        Fri, 18 Dec 2020 09:15:10 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kq1YD-0053Mh-6c; Fri, 18 Dec 2020 09:15:09 +1100
Date:   Fri, 18 Dec 2020 09:15:09 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     darrick.wong@oracle.com, willy@infradead.org, hch@infradead.org,
        mhocko@kernel.org, akpm@linux-foundation.org, dhowells@redhat.com,
        jlayton@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v13 3/4] xfs: refactor the usage around
 xfs_trans_context_{set,clear}
Message-ID: <20201217221509.GQ632069@dread.disaster.area>
References: <20201217011157.92549-1-laoar.shao@gmail.com>
 <20201217011157.92549-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217011157.92549-4-laoar.shao@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=JnNKH_yNLsiQyFxd-UEA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 09:11:56AM +0800, Yafang Shao wrote:
> The xfs_trans context should be active after it is allocated, and
> deactive when it is freed.
> The rolling transaction should be specially considered, because in the
> case when we clear the old transaction the thread's NOFS state shouldn't
> be changed, as a result we have to set NOFS in the old transaction's
> t_pflags in xfs_trans_context_swap().
> 
> So these helpers are refactored as,
> - xfs_trans_context_set()
>   Used in xfs_trans_alloc()
> - xfs_trans_context_clear()
>   Used in xfs_trans_free()
> 
> And a new helper is instroduced to handle the rolling transaction,
> - xfs_trans_context_swap()
>   Used in rolling transaction
> 
> This patch is based on Darrick's work to fix the issue in xfs/141 in the
> earlier version. [1]
> 
> 1. https://lore.kernel.org/linux-xfs/20201104001649.GN7123@magnolia

As I said in my last comments, this change of logic is not
necessary.  All we need to do is transfer the NOFS state to the new
transactions and *remove it from the old one*.

IOWs, all this patch should do is:

> @@ -119,7 +123,9 @@ xfs_trans_dup(
>  
>  	ntp->t_rtx_res = tp->t_rtx_res - tp->t_rtx_res_used;
>  	tp->t_rtx_res = tp->t_rtx_res_used;
> -	ntp->t_pflags = tp->t_pflags;
> +
> +	/* Associate the new transaction with this thread. */
> +	xfs_trans_context_swap(tp, ntp);
>  
>  	/* move deferred ops over to the new tp */
>  	xfs_defer_move(ntp, tp);

This, and

> diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
> index 44b11c64a15e..12380eaaf7ce 100644
> --- a/fs/xfs/xfs_trans.h
> +++ b/fs/xfs/xfs_trans.h
> @@ -280,4 +280,17 @@ xfs_trans_context_clear(struct xfs_trans *tp)
>  	memalloc_nofs_restore(tp->t_pflags);
>  }
>  
> +static inline void
> +xfs_trans_context_swap(struct xfs_trans *tp, struct xfs_trans *ntp)
> +{

introduce this wrapper.

> +	ntp->t_pflags = tp->t_pflags;
> +	/*
> +	 * For the rolling transaction, we have to set NOFS in the old
> +	 * transaction's t_pflags so that when we clear the context on
> +	 * the old transaction we don't actually change the thread's NOFS
> +	 * state.
> +	 */
> +	tp->t_pflags = current->flags | PF_MEMALLOC_NOFS;
> +}

But not with this implementation.

Think for a minute, please. All we want to do is avoid clearing
the nofs state when we call xfs_trans_context_clear(tp) if the state
has been handed to another transaction.

Your current implementation hands the state to ntp, but *then leaves
it on tp* as well. So then you hack a PF_MEMALLOC_NOFS flag into
tp->t_pflags so that it doesn't clear that flag (abusing the masking
done during clearing). That's just nasty because it relies on
internal memalloc_nofs_restore() details for correct functionality.

The obvious solution: we've moved the saved process state to a
different context, so it is no longer needed for the current
transaction we are about to commit. So How about just clearing the
saved state from the original transaction when swappingi like so:

static inline void
xfs_trans_context_swap(struct xfs_trans *tp, struct xfs_trans *ntp)
{
	ntp->t_pflags = tp->t_pflags;
	tp->t_flags = 0;
}

And now, when we go to clear the transaction context, we can simply
do this:

static inline void
xfs_trans_context_clear(struct xfs_trans *tp)
{
	if (tp->t_pflags)
		memalloc_nofs_restore(tp->t_pflags);
}

and the problem is solved. The NOFS state will follow the active
transaction and not be reset until the entire transaction chain is
completed.

In the next patch you can go and introduce current->journal_info
into just the wrapper functions, maintaining the same overall
logic.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
