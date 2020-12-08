Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4032D3448
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 21:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbgLHUef (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 15:34:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38204 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730338AbgLHUee (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:34:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8ItQ72193360;
        Tue, 8 Dec 2020 18:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=t8e48zvQbSC6khVK99dljyMN4QkE7EO+hnp5rY9YKN4=;
 b=ePhVH1n6wfbYieZk40aCtaCTSrhMa+Y+9rfSpIYXB/sOwBAjXLAn9/vLq91YUWR420rR
 TrJGSsUOAYF3dX7OESvbLPboggzG/v9Eg34KjlkDzXZ9l1OoYKX9jVfhUY0G3jo8cfYA
 CojTzjWwsdSp3C+mVeErv+Zc1CgRu5G9nmEBjvGX0LEAwZsJvZsBpaj/mRPFZAbRvHWq
 lyuJgieY+7D0nuW1l4JlN8O+rIV4x/lq9+QzdcyfQ9rWz7zgDSOjv00opnQnCSDYXd5H
 nlSTf5TXq48TG+ShcvJZV5OXQIFJtqDov/9JYWZ9denxxqRbuVKpHTYOz1TZbYv1zM2I KQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3581mqverf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Dec 2020 18:59:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8IsgpX157501;
        Tue, 8 Dec 2020 18:59:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 358kytc64w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Dec 2020 18:59:51 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B8IxmX8014713;
        Tue, 8 Dec 2020 18:59:48 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Dec 2020 10:59:48 -0800
Date:   Tue, 8 Dec 2020 10:59:46 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     willy@infradead.org, david@fromorbit.com, hch@infradead.org,
        mhocko@kernel.org, akpm@linux-foundation.org, dhowells@redhat.com,
        jlayton@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v11 3/4] xfs: refactor the usage around
 xfs_trans_context_{set,clear}
Message-ID: <20201208185946.GC1943235@magnolia>
References: <20201208122824.16118-1-laoar.shao@gmail.com>
 <20201208122824.16118-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208122824.16118-4-laoar.shao@gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080115
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 08, 2020 at 08:28:23PM +0800, Yafang Shao wrote:
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
>  fs/xfs/xfs_trans.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> index 11d390f0d3f2..fe20398a214e 100644
> --- a/fs/xfs/xfs_trans.c
> +++ b/fs/xfs/xfs_trans.c
> @@ -67,6 +67,9 @@ xfs_trans_free(
>  	xfs_extent_busy_sort(&tp->t_busy);
>  	xfs_extent_busy_clear(tp->t_mountp, &tp->t_busy, false);
>  
> +	/* Detach the transaction from this thread. */
> +	xfs_trans_context_clear(tp);

Don't you need to check if tp is still the current transaction before
you clear PF_MEMALLOC_NOFS, now that the NOFS is bound to the lifespan
of the transaction itself instead of the reservation?

--D

> +
>  	trace_xfs_trans_free(tp, _RET_IP_);
>  	if (!(tp->t_flags & XFS_TRANS_NO_WRITECOUNT))
>  		sb_end_intwrite(tp->t_mountp->m_super);
> @@ -153,9 +156,6 @@ xfs_trans_reserve(
>  	int			error = 0;
>  	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
>  
> -	/* Mark this thread as being in a transaction */
> -	xfs_trans_context_set(tp);
> -
>  	/*
>  	 * Attempt to reserve the needed disk blocks by decrementing
>  	 * the number needed from the number available.  This will
> @@ -163,10 +163,9 @@ xfs_trans_reserve(
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
> @@ -241,8 +240,6 @@ xfs_trans_reserve(
>  		tp->t_blk_res = 0;
>  	}
>  
> -	xfs_trans_context_clear(tp);
> -
>  	return error;
>  }
>  
> @@ -284,6 +281,8 @@ xfs_trans_alloc(
>  	INIT_LIST_HEAD(&tp->t_dfops);
>  	tp->t_firstblock = NULLFSBLOCK;
>  
> +	/* Mark this thread as being in a transaction */
> +	xfs_trans_context_set(tp);
>  	error = xfs_trans_reserve(tp, resp, blocks, rtextents);
>  	if (error) {
>  		xfs_trans_cancel(tp);
> @@ -878,7 +877,6 @@ __xfs_trans_commit(
>  
>  	xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
>  
> -	xfs_trans_context_clear(tp);
>  	xfs_trans_free(tp);
>  
>  	/*
> @@ -911,7 +909,6 @@ __xfs_trans_commit(
>  		tp->t_ticket = NULL;
>  	}
>  
> -	xfs_trans_context_clear(tp);
>  	xfs_trans_free_items(tp, !!error);
>  	xfs_trans_free(tp);
>  
> @@ -971,9 +968,6 @@ xfs_trans_cancel(
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
