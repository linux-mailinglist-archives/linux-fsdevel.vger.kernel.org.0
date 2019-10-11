Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46CA1D3FB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 14:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfJKMkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 08:40:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbfJKMkI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:40:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E962710CC206;
        Fri, 11 Oct 2019 12:40:07 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C1DF5D717;
        Fri, 11 Oct 2019 12:40:07 +0000 (UTC)
Date:   Fri, 11 Oct 2019 08:40:05 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/26] xfs: synchronous AIL pushing
Message-ID: <20191011124005.GF61257@bfoster>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-7-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-7-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Fri, 11 Oct 2019 12:40:08 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:04PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Factor the common AIL deletion code that does all the wakeups into a
> helper so we only have one copy of this somewhat tricky code to
> interface with all the wakeups necessary when the LSN of the log
> tail changes.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

The patch title looks bogus considering this is a refactoring patch.
Otherwise looks fine..

Brian

>  fs/xfs/xfs_inode_item.c | 12 +----------
>  fs/xfs/xfs_trans_ail.c  | 48 ++++++++++++++++++++++-------------------
>  fs/xfs/xfs_trans_priv.h |  4 +++-
>  3 files changed, 30 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
> index bb8f076805b9..ab12e526540a 100644
> --- a/fs/xfs/xfs_inode_item.c
> +++ b/fs/xfs/xfs_inode_item.c
> @@ -743,17 +743,7 @@ xfs_iflush_done(
>  				xfs_clear_li_failed(blip);
>  			}
>  		}
> -
> -		if (mlip_changed) {
> -			if (!XFS_FORCED_SHUTDOWN(ailp->ail_mount))
> -				xlog_assign_tail_lsn_locked(ailp->ail_mount);
> -			if (list_empty(&ailp->ail_head))
> -				wake_up_all(&ailp->ail_empty);
> -		}
> -		spin_unlock(&ailp->ail_lock);
> -
> -		if (mlip_changed)
> -			xfs_log_space_wake(ailp->ail_mount);
> +		xfs_ail_update_finish(ailp, mlip_changed);
>  	}
>  
>  	/*
> diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
> index 6ccfd75d3c24..656819523bbd 100644
> --- a/fs/xfs/xfs_trans_ail.c
> +++ b/fs/xfs/xfs_trans_ail.c
> @@ -678,6 +678,27 @@ xfs_ail_push_all_sync(
>  	finish_wait(&ailp->ail_empty, &wait);
>  }
>  
> +void
> +xfs_ail_update_finish(
> +	struct xfs_ail		*ailp,
> +	bool			do_tail_update) __releases(ailp->ail_lock)
> +{
> +	struct xfs_mount	*mp = ailp->ail_mount;
> +
> +	if (!do_tail_update) {
> +		spin_unlock(&ailp->ail_lock);
> +		return;
> +	}
> +
> +	if (!XFS_FORCED_SHUTDOWN(mp))
> +		xlog_assign_tail_lsn_locked(mp);
> +
> +	if (list_empty(&ailp->ail_head))
> +		wake_up_all(&ailp->ail_empty);
> +	spin_unlock(&ailp->ail_lock);
> +	xfs_log_space_wake(mp);
> +}
> +
>  /*
>   * xfs_trans_ail_update - bulk AIL insertion operation.
>   *
> @@ -737,15 +758,7 @@ xfs_trans_ail_update_bulk(
>  	if (!list_empty(&tmp))
>  		xfs_ail_splice(ailp, cur, &tmp, lsn);
>  
> -	if (mlip_changed) {
> -		if (!XFS_FORCED_SHUTDOWN(ailp->ail_mount))
> -			xlog_assign_tail_lsn_locked(ailp->ail_mount);
> -		spin_unlock(&ailp->ail_lock);
> -
> -		xfs_log_space_wake(ailp->ail_mount);
> -	} else {
> -		spin_unlock(&ailp->ail_lock);
> -	}
> +	xfs_ail_update_finish(ailp, mlip_changed);
>  }
>  
>  bool
> @@ -789,10 +802,10 @@ void
>  xfs_trans_ail_delete(
>  	struct xfs_ail		*ailp,
>  	struct xfs_log_item	*lip,
> -	int			shutdown_type) __releases(ailp->ail_lock)
> +	int			shutdown_type)
>  {
>  	struct xfs_mount	*mp = ailp->ail_mount;
> -	bool			mlip_changed;
> +	bool			need_update;
>  
>  	if (!test_bit(XFS_LI_IN_AIL, &lip->li_flags)) {
>  		spin_unlock(&ailp->ail_lock);
> @@ -805,17 +818,8 @@ xfs_trans_ail_delete(
>  		return;
>  	}
>  
> -	mlip_changed = xfs_ail_delete_one(ailp, lip);
> -	if (mlip_changed) {
> -		if (!XFS_FORCED_SHUTDOWN(mp))
> -			xlog_assign_tail_lsn_locked(mp);
> -		if (list_empty(&ailp->ail_head))
> -			wake_up_all(&ailp->ail_empty);
> -	}
> -
> -	spin_unlock(&ailp->ail_lock);
> -	if (mlip_changed)
> -		xfs_log_space_wake(ailp->ail_mount);
> +	need_update = xfs_ail_delete_one(ailp, lip);
> +	xfs_ail_update_finish(ailp, need_update);
>  }
>  
>  int
> diff --git a/fs/xfs/xfs_trans_priv.h b/fs/xfs/xfs_trans_priv.h
> index 2e073c1c4614..64ffa746730e 100644
> --- a/fs/xfs/xfs_trans_priv.h
> +++ b/fs/xfs/xfs_trans_priv.h
> @@ -92,8 +92,10 @@ xfs_trans_ail_update(
>  }
>  
>  bool xfs_ail_delete_one(struct xfs_ail *ailp, struct xfs_log_item *lip);
> +void xfs_ail_update_finish(struct xfs_ail *ailp, bool do_tail_update)
> +			__releases(ailp->ail_lock);
>  void xfs_trans_ail_delete(struct xfs_ail *ailp, struct xfs_log_item *lip,
> -		int shutdown_type) __releases(ailp->ail_lock);
> +		int shutdown_type);
>  
>  static inline void
>  xfs_trans_ail_remove(
> -- 
> 2.23.0.rc1
> 
