Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D3E2D4B05
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 20:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgLITxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 14:53:42 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43654 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgLITxm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:53:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9JnZbI071504;
        Wed, 9 Dec 2020 19:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=glYqO3NjE9NX7QzfY9FBMPwmLCfoyaBQkbDLjcWzk70=;
 b=aw7w/Y9cB1e48yH4iblVbowPn3ENlsnlwFw7xU903X4yXmXLeKA+WzHh8grRCOSOkMoB
 LT7X3tqeBQxkpnilgFnrD3PEHVLl0TMsemqoe8kZIST42T8cDd96FOHC9ezPh8XhLthQ
 tCRzW/9ZPWdY/UV+02kbCWKGBY7xFPiZ6iiBCBBetdDcE3nPhmID9kUztS/oE4J98l5V
 CuyOnm6v8kRwxbsCgN02cHMwRW1XcmenEDsKQgxm7noD0AKayVeTM6WAvaPC6xCqOFBd
 92eXVl18ePc8WZabS/PjGtjB1hgtWfkRb3izj+tisxe8UiDI1I5zxwBrMxVAKdCMX6Su PA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 35825ma3yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 19:52:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9Jon9s058615;
        Wed, 9 Dec 2020 19:52:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 358m40rpey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 19:52:44 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B9Jqbtv011915;
        Wed, 9 Dec 2020 19:52:37 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Dec 2020 11:52:36 -0800
Date:   Wed, 9 Dec 2020 11:52:35 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     willy@infradead.org, david@fromorbit.com, hch@infradead.org,
        mhocko@kernel.org, akpm@linux-foundation.org, dhowells@redhat.com,
        jlayton@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v12 3/4] xfs: refactor the usage around
 xfs_trans_context_{set,clear}
Message-ID: <20201209195235.GN1943235@magnolia>
References: <20201209131146.67289-1-laoar.shao@gmail.com>
 <20201209131146.67289-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209131146.67289-4-laoar.shao@gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090138
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 09:11:45PM +0800, Yafang Shao wrote:
> The xfs_trans context should be active after it is allocated, and
> deactive when it is freed.
> 
> So these two helpers are refactored as,
> - xfs_trans_context_set()
>   Used in xfs_trans_alloc()
> - xfs_trans_context_clear()
>   Used in xfs_trans_free()
> 
> This patch is based on Darrick's work to fix the issue in xfs/141 in the
> earlier version. [1]
> 
> 1. https://lore.kernel.org/linux-xfs/20201104001649.GN7123@magnolia
> 
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  fs/xfs/xfs_trans.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> index 11d390f0d3f2..4f4645329bb2 100644
> --- a/fs/xfs/xfs_trans.c
> +++ b/fs/xfs/xfs_trans.c
> @@ -67,6 +67,17 @@ xfs_trans_free(
>  	xfs_extent_busy_sort(&tp->t_busy);
>  	xfs_extent_busy_clear(tp->t_mountp, &tp->t_busy, false);
>  
> +
> +	/* Detach the transaction from this thread. */
> +	ASSERT(current->journal_info != NULL);
> +	/*
> +	 * The PF_MEMALLOC_NOFS is bound to the transaction itself instead
> +	 * of the reservation, so we need to check if tp is still the
> +	 * current transaction before clearing the flag.
> +	 */
> +	if (current->journal_info == tp)

Um, you don't start setting journal_info until the next patch, so this
means that someone who lands on this commit with git bisect will have a
xfs with broken logic.

Because this is the patch that changes where we set and restore NOFS
context, I think you have to introduce xfs_trans_context_swap here,
and not in the next patch.

I also think the _swap routine has to move the old NOFS state to the
new transaction's t_pflags, and then set NOFS in the old transaction's
t_pflags so that when we clear the context on the old transaction we
don't actually change the thread's NOFS state.

--D

> +		xfs_trans_context_clear(tp);
> +
>  	trace_xfs_trans_free(tp, _RET_IP_);
>  	if (!(tp->t_flags & XFS_TRANS_NO_WRITECOUNT))
>  		sb_end_intwrite(tp->t_mountp->m_super);
> @@ -153,9 +164,6 @@ xfs_trans_reserve(
>  	int			error = 0;
>  	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
>  
> -	/* Mark this thread as being in a transaction */
> -	xfs_trans_context_set(tp);
> -
>  	/*
>  	 * Attempt to reserve the needed disk blocks by decrementing
>  	 * the number needed from the number available.  This will
> @@ -163,10 +171,9 @@ xfs_trans_reserve(
>  	 */
>  	if (blocks > 0) {
>  		error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
> -		if (error != 0) {
> -			xfs_trans_context_clear(tp);
> +		if (error != 0)
>  			return -ENOSPC;
> -		}
> +
>  		tp->t_blk_res += blocks;
>  	}
>  
> @@ -241,8 +248,6 @@ xfs_trans_reserve(
>  		tp->t_blk_res = 0;
>  	}
>  
> -	xfs_trans_context_clear(tp);
> -
>  	return error;
>  }
>  
> @@ -284,6 +289,8 @@ xfs_trans_alloc(
>  	INIT_LIST_HEAD(&tp->t_dfops);
>  	tp->t_firstblock = NULLFSBLOCK;
>  
> +	/* Mark this thread as being in a transaction */
> +	xfs_trans_context_set(tp);
>  	error = xfs_trans_reserve(tp, resp, blocks, rtextents);
>  	if (error) {
>  		xfs_trans_cancel(tp);
> @@ -878,7 +885,6 @@ __xfs_trans_commit(
>  
>  	xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
>  
> -	xfs_trans_context_clear(tp);
>  	xfs_trans_free(tp);
>  
>  	/*
> @@ -911,7 +917,6 @@ __xfs_trans_commit(
>  		tp->t_ticket = NULL;
>  	}
>  
> -	xfs_trans_context_clear(tp);
>  	xfs_trans_free_items(tp, !!error);
>  	xfs_trans_free(tp);
>  
> @@ -971,9 +976,6 @@ xfs_trans_cancel(
>  		tp->t_ticket = NULL;
>  	}
>  
> -	/* mark this thread as no longer being in a transaction */
> -	xfs_trans_context_clear(tp);
> -
>  	xfs_trans_free_items(tp, dirty);
>  	xfs_trans_free(tp);
>  }
> -- 
> 2.18.4
> 
