Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6058882442
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 19:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfHERv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 13:51:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfHERv4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:51:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0ABA2300177B;
        Mon,  5 Aug 2019 17:51:56 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C46B5C1D6;
        Mon,  5 Aug 2019 17:51:55 +0000 (UTC)
Date:   Mon, 5 Aug 2019 13:51:53 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/24] xfs: synchronous AIL pushing
Message-ID: <20190805175153.GC14760@bfoster>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-14-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801021752.4986-14-david@fromorbit.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 05 Aug 2019 17:51:56 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:17:41PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Provide an interface to push the AIL to a target LSN and wait for
> the tail of the log to move past that LSN. This is used to wait for
> all items older than a specific LSN to either be cleaned (written
> back) or relogged to a higher LSN in the AIL. The primary use for
> this is to allow IO free inode reclaim throttling.
> 
> Factor the common AIL deletion code that does all the wakeups into a
> helper so we only have one copy of this somewhat tricky code to
> interface with all the wakeups necessary when the LSN of the log
> tail changes.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/xfs_inode_item.c | 12 +------
>  fs/xfs/xfs_trans_ail.c  | 69 +++++++++++++++++++++++++++++++++--------
>  fs/xfs/xfs_trans_priv.h |  6 +++-
>  3 files changed, 62 insertions(+), 25 deletions(-)
> 
...
> diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
> index 6ccfd75d3c24..9e3102179221 100644
> --- a/fs/xfs/xfs_trans_ail.c
> +++ b/fs/xfs/xfs_trans_ail.c
> @@ -654,6 +654,37 @@ xfs_ail_push_all(
>  		xfs_ail_push(ailp, threshold_lsn);
>  }
>  
> +/*
> + * Push the AIL to a specific lsn and wait for it to complete.
> + */
> +void
> +xfs_ail_push_sync(
> +	struct xfs_ail		*ailp,
> +	xfs_lsn_t		threshold_lsn)
> +{
> +	struct xfs_log_item	*lip;
> +	DEFINE_WAIT(wait);
> +
> +	spin_lock(&ailp->ail_lock);
> +	while ((lip = xfs_ail_min(ailp)) != NULL) {
> +		prepare_to_wait(&ailp->ail_push, &wait, TASK_UNINTERRUPTIBLE);
> +		if (XFS_FORCED_SHUTDOWN(ailp->ail_mount) ||
> +		    XFS_LSN_CMP(threshold_lsn, lip->li_lsn) <= 0)
> +			break;
> +		/* XXX: cmpxchg? */
> +		while (XFS_LSN_CMP(threshold_lsn, ailp->ail_target) > 0)
> +			xfs_trans_ail_copy_lsn(ailp, &ailp->ail_target, &threshold_lsn);

Why the need to repeatedly copy the ail_target like this? If the push
target only ever moves forward, we should only need to do this once at
the start of the function. In fact I'm kind of wondering why we can't
just call xfs_ail_push(). If we check the tail item after grabbing the
spin lock, we should be able to avoid any races with the waker, no?

> +		wake_up_process(ailp->ail_task);
> +		spin_unlock(&ailp->ail_lock);
> +		schedule();
> +		spin_lock(&ailp->ail_lock);
> +	}
> +	spin_unlock(&ailp->ail_lock);
> +
> +	finish_wait(&ailp->ail_push, &wait);
> +}
> +
> +
>  /*
>   * Push out all items in the AIL immediately and wait until the AIL is empty.
>   */
> @@ -764,6 +795,28 @@ xfs_ail_delete_one(
>  	return mlip == lip;
>  }
>  
> +void
> +xfs_ail_delete_finish(
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

Hmm.. so while what we really care about here are tail updates, this
logic is currently driven by removing the min ail log item. That seems
like a lot of potential churn if we're waking the pusher on every object
written back covered by a single log record / checkpoint. Perhaps we
should implement a bit more coarse wakeup logic such as only when the
tail lsn actually changes, for example?

FWIW, it also doesn't look like you've handled the case of relogged
items moving the tail forward anywhere that I can see, so we might be
missing some wakeups here. See xfs_trans_ail_update_bulk() for
additional AIL manipulation.

> +	if (!XFS_FORCED_SHUTDOWN(mp))
> +		xlog_assign_tail_lsn_locked(mp);
> +
> +	wake_up_all(&ailp->ail_push);
> +	if (list_empty(&ailp->ail_head))
> +		wake_up_all(&ailp->ail_empty);
> +	spin_unlock(&ailp->ail_lock);
> +	xfs_log_space_wake(mp);
> +}
> +
>  /**
>   * Remove a log items from the AIL
>   *
> @@ -789,10 +842,9 @@ void
>  xfs_trans_ail_delete(
>  	struct xfs_ail		*ailp,
>  	struct xfs_log_item	*lip,
> -	int			shutdown_type) __releases(ailp->ail_lock)
> +	int			shutdown_type)
>  {
>  	struct xfs_mount	*mp = ailp->ail_mount;
> -	bool			mlip_changed;
>  
>  	if (!test_bit(XFS_LI_IN_AIL, &lip->li_flags)) {
>  		spin_unlock(&ailp->ail_lock);
> @@ -805,17 +857,7 @@ xfs_trans_ail_delete(
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
> +	xfs_ail_delete_finish(ailp, xfs_ail_delete_one(ailp, lip));

Nit, but I'm not a fan of the function call buried in a function call
parameter pattern. I tend to read over it at a glance so to me it's not
worth the line of code it saves.

Brian

>  }
>  
>  int
> @@ -834,6 +876,7 @@ xfs_trans_ail_init(
>  	spin_lock_init(&ailp->ail_lock);
>  	INIT_LIST_HEAD(&ailp->ail_buf_list);
>  	init_waitqueue_head(&ailp->ail_empty);
> +	init_waitqueue_head(&ailp->ail_push);
>  
>  	ailp->ail_task = kthread_run(xfsaild, ailp, "xfsaild/%s",
>  			ailp->ail_mount->m_fsname);
> diff --git a/fs/xfs/xfs_trans_priv.h b/fs/xfs/xfs_trans_priv.h
> index 2e073c1c4614..5ab70b9b896f 100644
> --- a/fs/xfs/xfs_trans_priv.h
> +++ b/fs/xfs/xfs_trans_priv.h
> @@ -61,6 +61,7 @@ struct xfs_ail {
>  	int			ail_log_flush;
>  	struct list_head	ail_buf_list;
>  	wait_queue_head_t	ail_empty;
> +	wait_queue_head_t	ail_push;
>  };
>  
>  /*
> @@ -92,8 +93,10 @@ xfs_trans_ail_update(
>  }
>  
>  bool xfs_ail_delete_one(struct xfs_ail *ailp, struct xfs_log_item *lip);
> +void xfs_ail_delete_finish(struct xfs_ail *ailp, bool do_tail_update)
> +			__releases(ailp->ail_lock);
>  void xfs_trans_ail_delete(struct xfs_ail *ailp, struct xfs_log_item *lip,
> -		int shutdown_type) __releases(ailp->ail_lock);
> +		int shutdown_type);
>  
>  static inline void
>  xfs_trans_ail_remove(
> @@ -111,6 +114,7 @@ xfs_trans_ail_remove(
>  }
>  
>  void			xfs_ail_push(struct xfs_ail *, xfs_lsn_t);
> +void			xfs_ail_push_sync(struct xfs_ail *, xfs_lsn_t);
>  void			xfs_ail_push_all(struct xfs_ail *);
>  void			xfs_ail_push_all_sync(struct xfs_ail *);
>  struct xfs_log_item	*xfs_ail_min(struct xfs_ail  *ailp);
> -- 
> 2.22.0
> 
