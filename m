Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6654DEF116
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 00:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfKDXQk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 18:16:40 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58770 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbfKDXQk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:16:40 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4N9hJA054840;
        Mon, 4 Nov 2019 23:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Q42CSrqOcEzzrc3bcsO7tprPOJw9cGVj6+BIWUZzPUY=;
 b=YtzofMCBgWQ5o/iUb2eaHpLhrXf2FLgzSTx8w9kOI/wsG3PONpuQFZhfcjPYBNVoboEZ
 jjwiavviDZzYe+XJPNFhOnR8viKAVMUweFv5CDmq3p+iT1ubMXJsh8ZFi4oLcj0EwdZA
 +oRZUA+d/pPUakzU8xmZwkyEmMyHEtEr5Xa7pbd+xyH9qecw9PoyAQe28vllXuUf2Ljn
 8M0i8EQ3ulYYl6ytlCKwOzZpzpc90/21oNhzCWB5QOCAbtvKzGvH1cHvscU3ZakRdHbx
 BuFeurgRqCVmfGf3J2rrxMTZS2sapzRfFj03Q7qk420USxfhSJIiZCFXT+ZDeZUBw8uv NA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2w11rptmy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 23:16:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4N8xxr123048;
        Mon, 4 Nov 2019 23:16:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2w1kxe4yyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 23:16:35 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA4NGXLb018080;
        Mon, 4 Nov 2019 23:16:33 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 15:16:33 -0800
Date:   Mon, 4 Nov 2019 15:16:32 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/28] xfs: factor common AIL item deletion code
Message-ID: <20191104231632.GP4153244@magnolia>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-7-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031234618.15403-7-david@fromorbit.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040220
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

On Fri, Nov 01, 2019 at 10:45:56AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Factor the common AIL deletion code that does all the wakeups into a
> helper so we only have one copy of this somewhat tricky code to
> interface with all the wakeups necessary when the LSN of the log
> tail changes.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
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

This call site didn't have a wake_up_all and now it does; is that going
to make a difference?  I /think/ the answer is that this function
usually puts things on the AIL so we won't trigger the ail_empty wakeup;
and if the AIL was previously empty and we didn't match any log items
(such that it's still empty) then it's fine to wake up anyone who was
waiting for the ail to clear out?

--D

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
> 2.24.0.rc0
> 
