Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6E3251838
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfFXQSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 12:18:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32770 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbfFXQSC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:18:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OG9RhG120007;
        Mon, 24 Jun 2019 16:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=QSdJIcYPhRP8AVUdSZIleoEcVMe8cjEDcuPBEeUeRA4=;
 b=JZfLHyYuVFOmsE2ExpcijqRHL+HP3uqAFjiq6K43XLGL+BmZOLhUrUI5aIXhOy4s+dSt
 kpMQ1SeaUclXVHn9uLfTngAS8tVq/SZ8jAT0BxqIRxYFxigzUfv0K0iJWEW5GfJsnkCl
 3++dcyyyoCSflz0rqVPDBa6f1CqJ1IkZdL3a+pzCx0pLozd+XUAtmZLlPgCcn9t9WYcO
 JU+b0XKFrygRuJID6YpM5Kh83dEf3iVfryUBiU4xDiWGc4fH6nsywyNdzWKNkI5fFPUU
 YWijSlkATWRRRfnQOykRJLeuQFT8BKoSGp5u+rVSbYZC6BQ1XWO4eW+jSO2PG/rKdbX8 JQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t9cyq7b37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 16:17:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OGHRc0190628;
        Mon, 24 Jun 2019 16:17:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t9acbkhgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 16:17:27 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5OGHL5G011382;
        Mon, 24 Jun 2019 16:17:21 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 09:17:21 -0700
Date:   Mon, 24 Jun 2019 09:17:20 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] xfs: don't preallocate a transaction for file size
 updates
Message-ID: <20190624161720.GQ5387@magnolia>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624055253.31183-8-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240129
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:52:48AM +0200, Christoph Hellwig wrote:
> We have historically decided that we want to preallocate the xfs_trans
> structure at writeback time so that we don't have to allocate on in
> the I/O completion handler.  But we treat unwrittent extent and COW
> fork conversions different already, which proves that the transaction
> allocations in the end I/O handler are not a problem.  Removing the
> preallocation gets rid of a lot of corner case code, and also ensures
> we only allocate one and log a transaction when actually required,
> as the ioend merging can reduce the number of actual i_size updates
> significantly.

That's what I thought when I wrote the ioend merging patches, but IIRC
Dave objected on the grounds that most file writes are trivial file
extending writes and therefore we should leave this alone to avoid
slowing down the ioend path even if it came at a cost of cancelling a
lot of empty transactions.

I wasn't 100% convinced it mattered but ran out of time in the
development window and never got around to researching if it made any
difference.

So, uh, how much of a hit do we take for having to allocate a
transaction for a file size extension?  Particularly since we can
combine those things now?

--D

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_aops.c | 110 +++++-----------------------------------------
>  fs/xfs/xfs_aops.h |   1 -
>  2 files changed, 12 insertions(+), 99 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 633baaaff7ae..017b87b7765f 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -130,44 +130,23 @@ static inline bool xfs_ioend_is_append(struct xfs_ioend *ioend)
>  		XFS_I(ioend->io_inode)->i_d.di_size;
>  }
>  
> -STATIC int
> -xfs_setfilesize_trans_alloc(
> -	struct xfs_ioend	*ioend)
> -{
> -	struct xfs_mount	*mp = XFS_I(ioend->io_inode)->i_mount;
> -	struct xfs_trans	*tp;
> -	int			error;
> -
> -	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp);
> -	if (error)
> -		return error;
> -
> -	ioend->io_append_trans = tp;
> -
> -	/*
> -	 * We may pass freeze protection with a transaction.  So tell lockdep
> -	 * we released it.
> -	 */
> -	__sb_writers_release(ioend->io_inode->i_sb, SB_FREEZE_FS);
> -	/*
> -	 * We hand off the transaction to the completion thread now, so
> -	 * clear the flag here.
> -	 */
> -	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> -	return 0;
> -}
> -
>  /*
>   * Update on-disk file size now that data has been written to disk.
>   */
> -STATIC int
> -__xfs_setfilesize(
> +int
> +xfs_setfilesize(
>  	struct xfs_inode	*ip,
> -	struct xfs_trans	*tp,
>  	xfs_off_t		offset,
>  	size_t			size)
>  {
> +	struct xfs_mount	*mp = ip->i_mount;
> +	struct xfs_trans	*tp;
>  	xfs_fsize_t		isize;
> +	int			error;
> +
> +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp);
> +	if (error)
> +		return error;
>  
>  	xfs_ilock(ip, XFS_ILOCK_EXCL);
>  	isize = xfs_new_eof(ip, offset + size);
> @@ -186,48 +165,6 @@ __xfs_setfilesize(
>  	return xfs_trans_commit(tp);
>  }
>  
> -int
> -xfs_setfilesize(
> -	struct xfs_inode	*ip,
> -	xfs_off_t		offset,
> -	size_t			size)
> -{
> -	struct xfs_mount	*mp = ip->i_mount;
> -	struct xfs_trans	*tp;
> -	int			error;
> -
> -	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp);
> -	if (error)
> -		return error;
> -
> -	return __xfs_setfilesize(ip, tp, offset, size);
> -}
> -
> -STATIC int
> -xfs_setfilesize_ioend(
> -	struct xfs_ioend	*ioend,
> -	int			error)
> -{
> -	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
> -	struct xfs_trans	*tp = ioend->io_append_trans;
> -
> -	/*
> -	 * The transaction may have been allocated in the I/O submission thread,
> -	 * thus we need to mark ourselves as being in a transaction manually.
> -	 * Similarly for freeze protection.
> -	 */
> -	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> -	__sb_writers_acquired(VFS_I(ip)->i_sb, SB_FREEZE_FS);
> -
> -	/* we abort the update if there was an IO error */
> -	if (error) {
> -		xfs_trans_cancel(tp);
> -		return error;
> -	}
> -
> -	return __xfs_setfilesize(ip, tp, ioend->io_offset, ioend->io_size);
> -}
> -
>  /*
>   * IO write completion.
>   */
> @@ -267,12 +204,9 @@ xfs_end_ioend(
>  		error = xfs_reflink_end_cow(ip, offset, size);
>  	else if (ioend->io_type == IOMAP_UNWRITTEN)
>  		error = xfs_iomap_write_unwritten(ip, offset, size, false);
> -	else
> -		ASSERT(!xfs_ioend_is_append(ioend) || ioend->io_append_trans);
> -
> +	if (!error && xfs_ioend_is_append(ioend))
> +		error = xfs_setfilesize(ip, offset, size);
>  done:
> -	if (ioend->io_append_trans)
> -		error = xfs_setfilesize_ioend(ioend, error);
>  	list_replace_init(&ioend->io_list, &ioend_list);
>  	xfs_destroy_ioend(ioend, error);
>  
> @@ -307,8 +241,6 @@ xfs_ioend_can_merge(
>  		return false;
>  	if (ioend->io_offset + ioend->io_size != next->io_offset)
>  		return false;
> -	if (xfs_ioend_is_append(ioend) != xfs_ioend_is_append(next))
> -		return false;
>  	return true;
>  }
>  
> @@ -320,7 +252,6 @@ xfs_ioend_try_merge(
>  {
>  	struct xfs_ioend	*next_ioend;
>  	int			ioend_error;
> -	int			error;
>  
>  	if (list_empty(more_ioends))
>  		return;
> @@ -334,10 +265,6 @@ xfs_ioend_try_merge(
>  			break;
>  		list_move_tail(&next_ioend->io_list, &ioend->io_list);
>  		ioend->io_size += next_ioend->io_size;
> -		if (ioend->io_append_trans) {
> -			error = xfs_setfilesize_ioend(next_ioend, 1);
> -			ASSERT(error == 1);
> -		}
>  	}
>  }
>  
> @@ -398,7 +325,7 @@ xfs_end_bio(
>  
>  	if (ioend->io_fork == XFS_COW_FORK ||
>  	    ioend->io_type == IOMAP_UNWRITTEN ||
> -	    ioend->io_append_trans != NULL) {
> +	    xfs_ioend_is_append(ioend)) {
>  		spin_lock_irqsave(&ip->i_ioend_lock, flags);
>  		if (list_empty(&ip->i_ioend_list))
>  			WARN_ON_ONCE(!queue_work(mp->m_unwritten_workqueue,
> @@ -660,18 +587,6 @@ xfs_submit_ioend(
>  		memalloc_nofs_restore(nofs_flag);
>  	}
>  
> -	/* Reserve log space if we might write beyond the on-disk inode size. */
> -	if (!status &&
> -	    (ioend->io_fork == XFS_COW_FORK ||
> -	     ioend->io_type != IOMAP_UNWRITTEN) &&
> -	    xfs_ioend_is_append(ioend) &&
> -	    !ioend->io_append_trans) {
> -		unsigned nofs_flag = memalloc_nofs_save();
> -
> -		status = xfs_setfilesize_trans_alloc(ioend);
> -		memalloc_nofs_restore(nofs_flag);
> -	}
> -
>  	ioend->io_bio->bi_private = ioend;
>  	ioend->io_bio->bi_end_io = xfs_end_bio;
>  
> @@ -715,7 +630,6 @@ xfs_alloc_ioend(
>  	ioend->io_inode = inode;
>  	ioend->io_size = 0;
>  	ioend->io_offset = offset;
> -	ioend->io_append_trans = NULL;
>  	ioend->io_bio = bio;
>  	return ioend;
>  }
> diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
> index 72e30d1c3bdf..23c087f0bcbf 100644
> --- a/fs/xfs/xfs_aops.h
> +++ b/fs/xfs/xfs_aops.h
> @@ -18,7 +18,6 @@ struct xfs_ioend {
>  	struct inode		*io_inode;	/* file being written to */
>  	size_t			io_size;	/* size of the extent */
>  	xfs_off_t		io_offset;	/* offset in the file */
> -	struct xfs_trans	*io_append_trans;/* xact. for size update */
>  	struct bio		*io_bio;	/* bio being built */
>  	struct bio		io_inline_bio;	/* MUST BE LAST! */
>  };
> -- 
> 2.20.1
> 
