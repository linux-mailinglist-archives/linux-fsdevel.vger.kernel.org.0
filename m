Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E5BEF11C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 00:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbfKDXSl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 18:18:41 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:32770 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbfKDXSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:18:41 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4N9M80054729;
        Mon, 4 Nov 2019 23:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=cKJhMj+gq9QdNUuxuk8z+c3FWsMcVVj7p9zKcO3kt/s=;
 b=Bqsl+xk39fYNE4o+pWxoFDvYjxiJw5JS9aYk0Sc6Ue3lWt/6O3+v/4Dlk3yTCEuJDnjT
 QUqEkyiu6B1zHkXEduDPFWW4Km29Swmf2qlwEL37UdiRTNWdr/24fLrQS2g+oLc5zRX4
 f2ffsF7nPNxGsmsuKNiIKobqsaw4bIRdfnVukhDX/8Iz35DyOa99qbMri4wUEHoeDRKH
 IPcr2W5HoYTRdUHNb4OpauobXQuvTVd0kOBEhuUvdnkoc+swhR5csjPRoKuLtgsvsbZz
 BfEyA91IZnp0xRXDfSJdKjHAJTGz6adVL6Pp8KcmVY07RrM8NwKEMJSGVaV9m2aZU6z9 9g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2w11rptn6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 23:18:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4NIOgN145032;
        Mon, 4 Nov 2019 23:18:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2w1kxe5222-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 23:18:36 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA4NIZNr019066;
        Mon, 4 Nov 2019 23:18:35 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 15:18:35 -0800
Date:   Mon, 4 Nov 2019 15:18:34 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/28] xfs: tail updates only need to occur when LSN
 changes
Message-ID: <20191104231834.GQ4153244@magnolia>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-8-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031234618.15403-8-david@fromorbit.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040221
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040220
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:45:57AM +1100, Dave Chinner wrote:
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
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Brian Foster <bfoster@redhat.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_inode_item.c | 18 ++++++++++----
>  fs/xfs/xfs_trans_ail.c  | 52 ++++++++++++++++++++++++++++-------------
>  fs/xfs/xfs_trans_priv.h |  4 ++--
>  3 files changed, 51 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
> index ab12e526540a..79ffe6dff115 100644
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
> +				 * xfs_ail_update_finish() only cares about the
> +				 * lsn of the first tail item removed, any
> +				 * others will be at the same or higher lsn so
> +				 * we just ignore them.
> +				 */
> +				xfs_lsn_t lsn = xfs_ail_delete_one(ailp, blip);
> +				if (!tail_lsn && lsn)
> +					tail_lsn = lsn;
> +			} else {
>  				xfs_clear_li_failed(blip);
>  			}
>  		}
> -		xfs_ail_update_finish(ailp, mlip_changed);
> +		xfs_ail_update_finish(ailp, tail_lsn);
>  	}
>  
>  	/*
> diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
> index 656819523bbd..685a21cd24c0 100644
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
> @@ -681,11 +689,12 @@ xfs_ail_push_all_sync(
>  void
>  xfs_ail_update_finish(
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
> @@ -730,7 +739,7 @@ xfs_trans_ail_update_bulk(
>  	xfs_lsn_t		lsn) __releases(ailp->ail_lock)
>  {
>  	struct xfs_log_item	*mlip;
> -	int			mlip_changed = 0;
> +	xfs_lsn_t		tail_lsn = 0;
>  	int			i;
>  	LIST_HEAD(tmp);
>  
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
> 2.24.0.rc0
> 
