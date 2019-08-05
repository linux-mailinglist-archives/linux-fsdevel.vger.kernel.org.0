Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9F7A82448
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 19:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfHERx3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 13:53:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfHERx3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:53:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 841A14E8AC;
        Mon,  5 Aug 2019 17:53:28 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 05BE85D704;
        Mon,  5 Aug 2019 17:53:27 +0000 (UTC)
Date:   Mon, 5 Aug 2019 13:53:26 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/24] xfs: tail updates only need to occur when LSN
 changes
Message-ID: <20190805175325.GD14760@bfoster>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-15-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801021752.4986-15-david@fromorbit.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 05 Aug 2019 17:53:28 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:17:42PM +1000, Dave Chinner wrote:
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
> XXX: occasionally get a temporary hang in xfs_ail_push_sync() with
> this change - log force from log worker gets things moving again.
> Only happens under extreme memory pressure - possibly push racing
> with a tail update on an empty log. Needs further investigation.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Ok, this addresses the wakeup granularity issue mentioned in the
previous patch. Note that I was kind of wondering why we wouldn't base
this on the l_tail_lsn update in xlog_assign_tail_lsn_locked() as
opposed to the current approach.

For example, xlog_assign_tail_lsn_locked() could simply check the
current min item against the current l_tail_lsn before it does the
assignment and use that to trigger tail change events. If we wanted to
also filter out the other wakeups (as this patch does) then we could
just pass a bool pointer or something that returns whether the tail
actually changed.

Brian

>  fs/xfs/xfs_inode_item.c | 18 +++++++++++++-----
>  fs/xfs/xfs_trans_ail.c  | 37 ++++++++++++++++++++++++++++---------
>  fs/xfs/xfs_trans_priv.h |  4 ++--
>  3 files changed, 43 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
> index 7b942a63e992..16a7d6f752c9 100644
> --- a/fs/xfs/xfs_inode_item.c
> +++ b/fs/xfs/xfs_inode_item.c
> @@ -731,19 +731,27 @@ xfs_iflush_done(
>  	 * holding the lock before removing the inode from the AIL.
>  	 */
>  	if (need_ail) {
> -		bool			mlip_changed = false;
> +		xfs_lsn_t	tail_lsn = 0;
>  
>  		/* this is an opencoded batch version of xfs_trans_ail_delete */
>  		spin_lock(&ailp->ail_lock);
>  		list_for_each_entry(blip, &tmp, li_bio_list) {
>  			if (INODE_ITEM(blip)->ili_logged &&
> -			    blip->li_lsn == INODE_ITEM(blip)->ili_flush_lsn)
> -				mlip_changed |= xfs_ail_delete_one(ailp, blip);
> -			else {
> +			    blip->li_lsn == INODE_ITEM(blip)->ili_flush_lsn) {
> +				/*
> +				 * xfs_ail_delete_finish() only cares about the
> +				 * lsn of the first tail item removed, any others
> +				 * will be at the same or higher lsn so we just
> +				 * ignore them.
> +				 */
> +				xfs_lsn_t lsn = xfs_ail_delete_one(ailp, blip);
> +				if (!tail_lsn && lsn)
> +					tail_lsn = lsn;
> +			} else {
>  				xfs_clear_li_failed(blip);
>  			}
>  		}
> -		xfs_ail_delete_finish(ailp, mlip_changed);
> +		xfs_ail_delete_finish(ailp, tail_lsn);
>  	}
>  
>  	/*
> diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
> index 9e3102179221..00d66175f41a 100644
> --- a/fs/xfs/xfs_trans_ail.c
> +++ b/fs/xfs/xfs_trans_ail.c
> @@ -108,17 +108,25 @@ xfs_ail_next(
>   * We need the AIL lock in order to get a coherent read of the lsn of the last
>   * item in the AIL.
>   */
> +static xfs_lsn_t
> +__xfs_ail_min_lsn(
> +	struct xfs_ail		*ailp)
> +{
> +	struct xfs_log_item	*lip = xfs_ail_min(ailp);
> +
> +	if (lip)
> +		return lip->li_lsn;
> +	return 0;
> +}
> +
>  xfs_lsn_t
>  xfs_ail_min_lsn(
>  	struct xfs_ail		*ailp)
>  {
> -	xfs_lsn_t		lsn = 0;
> -	struct xfs_log_item	*lip;
> +	xfs_lsn_t		lsn;
>  
>  	spin_lock(&ailp->ail_lock);
> -	lip = xfs_ail_min(ailp);
> -	if (lip)
> -		lsn = lip->li_lsn;
> +	lsn = __xfs_ail_min_lsn(ailp);
>  	spin_unlock(&ailp->ail_lock);
>  
>  	return lsn;
> @@ -779,12 +787,20 @@ xfs_trans_ail_update_bulk(
>  	}
>  }
>  
> -bool
> +/*
> + * Delete one log item from the AIL.
> + *
> + * If this item was at the tail of the AIL, return the LSN of the log item so
> + * that we can use it to check if the LSN of the tail of the log has moved
> + * when finishing up the AIL delete process in xfs_ail_delete_finish().
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
> @@ -792,17 +808,20 @@ xfs_ail_delete_one(
>  	clear_bit(XFS_LI_IN_AIL, &lip->li_flags);
>  	lip->li_lsn = 0;
>  
> -	return mlip == lip;
> +	if (mlip == lip)
> +		return lsn;
> +	return 0;
>  }
>  
>  void
>  xfs_ail_delete_finish(
>  	struct xfs_ail		*ailp,
> -	bool			do_tail_update) __releases(ailp->ail_lock)
> +	xfs_lsn_t		old_lsn) __releases(ailp->ail_lock)
>  {
>  	struct xfs_mount	*mp = ailp->ail_mount;
>  
> -	if (!do_tail_update) {
> +	/* if the tail lsn hasn't changed, don't do updates or wakeups. */
> +	if (!old_lsn || old_lsn == __xfs_ail_min_lsn(ailp)) {
>  		spin_unlock(&ailp->ail_lock);
>  		return;
>  	}

> diff --git a/fs/xfs/xfs_trans_priv.h b/fs/xfs/xfs_trans_priv.h
> index 5ab70b9b896f..db589bb7468d 100644
> --- a/fs/xfs/xfs_trans_priv.h
> +++ b/fs/xfs/xfs_trans_priv.h
> @@ -92,8 +92,8 @@ xfs_trans_ail_update(
>  	xfs_trans_ail_update_bulk(ailp, NULL, &lip, 1, lsn);
>  }
>  
> -bool xfs_ail_delete_one(struct xfs_ail *ailp, struct xfs_log_item *lip);
> -void xfs_ail_delete_finish(struct xfs_ail *ailp, bool do_tail_update)
> +xfs_lsn_t xfs_ail_delete_one(struct xfs_ail *ailp, struct xfs_log_item *lip);
> +void xfs_ail_delete_finish(struct xfs_ail *ailp, xfs_lsn_t old_lsn)
>  			__releases(ailp->ail_lock);
>  void xfs_trans_ail_delete(struct xfs_ail *ailp, struct xfs_log_item *lip,
>  		int shutdown_type);
> -- 
> 2.22.0
> 
