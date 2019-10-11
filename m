Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEC94D3FC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 14:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfJKMkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 08:40:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfJKMkq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:40:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79308C04D293;
        Fri, 11 Oct 2019 12:40:45 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDFB5600C4;
        Fri, 11 Oct 2019 12:40:44 +0000 (UTC)
Date:   Fri, 11 Oct 2019 08:40:43 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/26] xfs: tail updates only need to occur when LSN
 changes
Message-ID: <20191011124043.GG61257@bfoster>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-8-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-8-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 11 Oct 2019 12:40:45 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:05PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> We currently wake anything waiting on the log tail to move whenever
> the log item at the tail of the log is removed. Historically this
> was fine behaviour because there were very few items at any given
> LSN. But with delayed logging, there may be thousands of items at
> any given LSN, and we can't move the tail until they are all gone.
> 
> Hence if we are removing them in near tail-first order, we might be
> waking up processes waiting on the tail LSN to change (e.g. log
> space waiters) repeatedly without them being able to make progress.
> This also occurs with the new sync push waiters, and can result in
> thousands of spurious wakeups every second when under heavy direct
> reclaim pressure.
> 
> To fix this, check that the tail LSN has actually changed on the
> AIL before triggering wakeups. This will reduce the number of
> spurious wakeups when doing bulk AIL removal and make this code much
> more efficient.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/xfs_inode_item.c | 18 ++++++++++----
>  fs/xfs/xfs_trans_ail.c  | 52 ++++++++++++++++++++++++++++-------------
>  fs/xfs/xfs_trans_priv.h |  4 ++--
>  3 files changed, 51 insertions(+), 23 deletions(-)
> 
...
> diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
> index 656819523bbd..685a21cd24c0 100644
> --- a/fs/xfs/xfs_trans_ail.c
> +++ b/fs/xfs/xfs_trans_ail.c
...
> @@ -745,9 +754,10 @@ xfs_trans_ail_update_bulk(
>  				continue;
>  
>  			trace_xfs_ail_move(lip, lip->li_lsn, lsn);
> +			if (mlip == lip && !tail_lsn)
> +				tail_lsn = lip->li_lsn;
> +
>  			xfs_ail_delete(ailp, lip);
> -			if (mlip == lip)
> -				mlip_changed = 1;

FWIW, I think this code could be simplified to just assign tail_lsn
directly via the new helper and pass that value into
xfs_ail_update_finish() below. I doubt filtering out that extra lsn
comparison with the mlip check makes much difference when we're already
doing a bulk insertion and referencing every lip along the way. That's
just a nit though. Otherwise looks fine to me:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  		} else {
>  			trace_xfs_ail_insert(lip, 0, lsn);
>  		}
> @@ -758,15 +768,23 @@ xfs_trans_ail_update_bulk(
>  	if (!list_empty(&tmp))
>  		xfs_ail_splice(ailp, cur, &tmp, lsn);
>  
> -	xfs_ail_update_finish(ailp, mlip_changed);
> +	xfs_ail_update_finish(ailp, tail_lsn);
>  }
>  
> -bool
> +/*
> + * Delete one log item from the AIL.
> + *
> + * If this item was at the tail of the AIL, return the LSN of the log item so
> + * that we can use it to check if the LSN of the tail of the log has moved
> + * when finishing up the AIL delete process in xfs_ail_update_finish().
> + */
> +xfs_lsn_t
>  xfs_ail_delete_one(
>  	struct xfs_ail		*ailp,
>  	struct xfs_log_item	*lip)
>  {
>  	struct xfs_log_item	*mlip = xfs_ail_min(ailp);
> +	xfs_lsn_t		lsn = lip->li_lsn;
>  
>  	trace_xfs_ail_delete(lip, mlip->li_lsn, lip->li_lsn);
>  	xfs_ail_delete(ailp, lip);
> @@ -774,7 +792,9 @@ xfs_ail_delete_one(
>  	clear_bit(XFS_LI_IN_AIL, &lip->li_flags);
>  	lip->li_lsn = 0;
>  
> -	return mlip == lip;
> +	if (mlip == lip)
> +		return lsn;
> +	return 0;
>  }
>  
>  /**
> @@ -805,7 +825,7 @@ xfs_trans_ail_delete(
>  	int			shutdown_type)
>  {
>  	struct xfs_mount	*mp = ailp->ail_mount;
> -	bool			need_update;
> +	xfs_lsn_t		tail_lsn;
>  
>  	if (!test_bit(XFS_LI_IN_AIL, &lip->li_flags)) {
>  		spin_unlock(&ailp->ail_lock);
> @@ -818,8 +838,8 @@ xfs_trans_ail_delete(
>  		return;
>  	}
>  
> -	need_update = xfs_ail_delete_one(ailp, lip);
> -	xfs_ail_update_finish(ailp, need_update);
> +	tail_lsn = xfs_ail_delete_one(ailp, lip);
> +	xfs_ail_update_finish(ailp, tail_lsn);
>  }
>  
>  int
> diff --git a/fs/xfs/xfs_trans_priv.h b/fs/xfs/xfs_trans_priv.h
> index 64ffa746730e..35655eac01a6 100644
> --- a/fs/xfs/xfs_trans_priv.h
> +++ b/fs/xfs/xfs_trans_priv.h
> @@ -91,8 +91,8 @@ xfs_trans_ail_update(
>  	xfs_trans_ail_update_bulk(ailp, NULL, &lip, 1, lsn);
>  }
>  
> -bool xfs_ail_delete_one(struct xfs_ail *ailp, struct xfs_log_item *lip);
> -void xfs_ail_update_finish(struct xfs_ail *ailp, bool do_tail_update)
> +xfs_lsn_t xfs_ail_delete_one(struct xfs_ail *ailp, struct xfs_log_item *lip);
> +void xfs_ail_update_finish(struct xfs_ail *ailp, xfs_lsn_t old_lsn)
>  			__releases(ailp->ail_lock);
>  void xfs_trans_ail_delete(struct xfs_ail *ailp, struct xfs_log_item *lip,
>  		int shutdown_type);
> -- 
> 2.23.0.rc1
> 
