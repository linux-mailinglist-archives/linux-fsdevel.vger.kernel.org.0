Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B7223C226
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 01:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgHDXUN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 19:20:13 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:36902 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgHDXUM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 19:20:12 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id E31251A94C8;
        Wed,  5 Aug 2020 09:20:07 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1k36E1-0000HB-FZ; Wed, 05 Aug 2020 09:20:05 +1000
Date:   Wed, 5 Aug 2020 09:20:05 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com, mhocko@kernel.org,
        willy@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <shaoyafang@didiglobal.com>
Subject: Re: [PATCH v4 1/2] xfs: avoid double restore PF_MEMALLOC_NOFS if
 transaction reservation fails
Message-ID: <20200804232005.GD2114@dread.disaster.area>
References: <20200801154632.866356-1-laoar.shao@gmail.com>
 <20200801154632.866356-2-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801154632.866356-2-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QKgWuTDL c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=DyMV3BnNAAAA:8 a=7-415B0cAAAA:8
        a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=sepEaALGW5-UqJ5a4w0A:9
        a=CjuIK1q_8ugA:10 a=9s3JYx_stmTtqx6mgxhK:22 a=biEYGPWJfzWAr4FL6Ov7:22
        a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 01, 2020 at 11:46:31AM -0400, Yafang Shao wrote:
> From: Yafang Shao <shaoyafang@didiglobal.com>
> 
> In xfs_trans_alloc(), if xfs_trans_reserve() fails, it will call
> xfs_trans_cancel(), in which it will restore the flag PF_MEMALLOC_NOFS.
> However this flags has been restored in xfs_trans_reserve(). Although
> this behavior doesn't introduce any obvious issue, we'd better improve it.
.....

> 
> Signed-off-by: Yafang Shao <shaoyafang@didiglobal.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>  fs/xfs/xfs_trans.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> index 3c94e5ff4316..9ff41970d0c7 100644
> --- a/fs/xfs/xfs_trans.c
> +++ b/fs/xfs/xfs_trans.c
> @@ -162,10 +162,9 @@ xfs_trans_reserve(
>  	 */
>  	if (blocks > 0) {
>  		error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
> -		if (error != 0) {
> -			current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +		if (error != 0)
>  			return -ENOSPC;
> -		}
> +
>  		tp->t_blk_res += blocks;
>  	}
>  
> @@ -240,8 +239,6 @@ xfs_trans_reserve(
>  		tp->t_blk_res = 0;
>  	}
>  
> -	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> -
>  	return error;
>  }

So you fix it here....

>  
> @@ -972,6 +969,7 @@ xfs_trans_roll(
>  	struct xfs_trans	**tpp)
>  {
>  	struct xfs_trans	*trans = *tpp;
> +	struct xfs_trans        *tp;
>  	struct xfs_trans_res	tres;
>  	int			error;
>  
> @@ -1005,5 +1003,10 @@ xfs_trans_roll(
>  	 * the prior and the next transactions.
>  	 */
>  	tres.tr_logflags = XFS_TRANS_PERM_LOG_RES;
> -	return xfs_trans_reserve(*tpp, &tres, 0, 0);
> +	tp = *tpp;
> +	error = xfs_trans_reserve(tp, &tres, 0, 0);
> +	if (error)
> +		current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +
> +	return error;
>  }

.... but then introduce the exact same issue here. i.e. when
xfs_trans_roll() fails, the caller will call xfs_trans_cancel() on
the returned transaction....

Realistically, I think this is kinda missing the overall intent of
rolling transactions. The issue here is that when we commit a
transaction, we unconditionally clear the PF_MEMALLOC_NOFS flag via
__xfs_trans_commit() just before freeing the transaction despite the
fact the long running rolling transaction has not yet completed.

This means that when we roll a transactions, we are bouncing the
NOFS state unnecessarily like so:

t0		t1		t2
alloc
 reserve
  NOFS
roll
		alloc
commit
clear NOFS
		reserve
		  NOFS
		roll
				alloc
		commit
		clear NOFS
				reserve
				  NOFS
				.....

right until the last commit of the sequence. IOWs, we are repeatedly
setting and clearing NOFS even though we actually only need to set
it at the t0 and clear it on the final commit or cancel.

Hence I think that __xfs_trans_commit() should probably only clear
NOFS on successful commit if @regrant is false (i.e. not called from
xfs_trans_roll()) and the setting of NOFS should be removed from
xfs_trans_reserve() and moved up into the initial xfs_trans_alloc()
before xfs_trans_reserve() is called.

This way the calls to either xfs_trans_commit() or
xfs_trans_cancel() will clear the NOFS state as they indicate that
we are exiting transaction context completely....

Also, please convert these to memalloc_nofs_save()/restore() calls
as that is the way we are supposed to mark these regions now.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
