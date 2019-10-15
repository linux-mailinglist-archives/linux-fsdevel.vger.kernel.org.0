Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C790D7E5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 20:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388992AbfJOSDS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 14:03:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49020 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfJOSDS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:03:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FHmZe7077029;
        Tue, 15 Oct 2019 18:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=aCaTnFQPPEM73tLQl9o5ZZRtFT9/0aRVHchdJ5i3nKw=;
 b=PoVcA8yBsANGExGoXSt1OKCPVUwx0ngIxZ8SMIk8/1YGbyJkOaD/l0PpN208TkJ0E0e+
 t5s4bi8Ug9eiLbsbWNfVTsgSJdIpj4wDSvVDVGVetmR3dCYrITSFwkTgu7oVWSkai69A
 sKDZQXKRRZg0GQtfpuXAWzKHWvaVi8jvD8L21q9KaPDm/lfGYHdJnbm7Cg8eA/dmAlfA
 X//YdO43m8EnerEHLTHHyOZvXYKLEVZhxb7X3khPJJa8BTBX5zznyqPdtAr7/IGEZRw/
 YHSQGzJfRTSbFxrU3Ag2gs4xBBLkCq/9Rlra0ErJnVnkg18pOgCcojcWPnQWQ5dzQEwV 8Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vk6sqhumr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 18:02:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FHmPkF060075;
        Tue, 15 Oct 2019 18:02:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vnb0fm2mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 18:02:58 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9FI2vbN010420;
        Tue, 15 Oct 2019 18:02:57 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 11:02:57 -0700
Date:   Tue, 15 Oct 2019 11:02:56 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] xfs: turn io_append_trans into an io_private void
 pointer
Message-ID: <20191015180256.GR13108@magnolia>
References: <20191015154345.13052-1-hch@lst.de>
 <20191015154345.13052-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015154345.13052-6-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910150153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910150153
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 05:43:38PM +0200, Christoph Hellwig wrote:
> In preparation for moving the ioend structure to common code we need
> to get rid of the xfs-specific xfs_trans type.  Just make it a file
> system private void pointer instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_aops.c | 26 +++++++++++++-------------
>  fs/xfs/xfs_aops.h |  2 +-
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index c29ef69d1e51..df5955388adc 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -153,7 +153,7 @@ xfs_setfilesize_trans_alloc(
>  	if (error)
>  		return error;
>  
> -	ioend->io_append_trans = tp;
> +	ioend->io_private = tp;
>  
>  	/*
>  	 * We may pass freeze protection with a transaction.  So tell lockdep
> @@ -220,7 +220,7 @@ xfs_setfilesize_ioend(
>  	int			error)
>  {
>  	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
> -	struct xfs_trans	*tp = ioend->io_append_trans;
> +	struct xfs_trans	*tp = ioend->io_private;
>  
>  	/*
>  	 * The transaction may have been allocated in the I/O submission thread,
> @@ -285,10 +285,10 @@ xfs_end_ioend(
>  	else if (ioend->io_type == IOMAP_UNWRITTEN)
>  		error = xfs_iomap_write_unwritten(ip, offset, size, false);
>  	else
> -		ASSERT(!xfs_ioend_is_append(ioend) || ioend->io_append_trans);
> +		ASSERT(!xfs_ioend_is_append(ioend) || ioend->io_private);
>  
>  done:
> -	if (ioend->io_append_trans)
> +	if (ioend->io_private)
>  		error = xfs_setfilesize_ioend(ioend, error);
>  	xfs_destroy_ioends(ioend, error);
>  	memalloc_nofs_restore(nofs_flag);
> @@ -321,13 +321,13 @@ xfs_ioend_can_merge(
>   * as it is guaranteed to be clean.
>   */
>  static void
> -xfs_ioend_merge_append_transactions(
> +xfs_ioend_merge_private(
>  	struct xfs_ioend	*ioend,
>  	struct xfs_ioend	*next)
>  {
> -	if (!ioend->io_append_trans) {
> -		ioend->io_append_trans = next->io_append_trans;
> -		next->io_append_trans = NULL;
> +	if (!ioend->io_private) {
> +		ioend->io_private = next->io_private;
> +		next->io_private = NULL;
>  	} else {
>  		xfs_setfilesize_ioend(next, -ECANCELED);
>  	}
> @@ -349,8 +349,8 @@ xfs_ioend_try_merge(
>  			break;
>  		list_move_tail(&next->io_list, &ioend->io_list);
>  		ioend->io_size += next->io_size;
> -		if (next->io_append_trans)
> -			xfs_ioend_merge_append_transactions(ioend, next);
> +		if (next->io_private)
> +			xfs_ioend_merge_private(ioend, next);
>  	}
>  }
>  
> @@ -415,7 +415,7 @@ xfs_end_bio(
>  
>  	if (ioend->io_fork == XFS_COW_FORK ||
>  	    ioend->io_type == IOMAP_UNWRITTEN ||
> -	    ioend->io_append_trans != NULL) {
> +	    ioend->io_private) {
>  		spin_lock_irqsave(&ip->i_ioend_lock, flags);
>  		if (list_empty(&ip->i_ioend_list))
>  			WARN_ON_ONCE(!queue_work(mp->m_unwritten_workqueue,
> @@ -680,7 +680,7 @@ xfs_submit_ioend(
>  	    (ioend->io_fork == XFS_COW_FORK ||
>  	     ioend->io_type != IOMAP_UNWRITTEN) &&
>  	    xfs_ioend_is_append(ioend) &&
> -	    !ioend->io_append_trans)
> +	    !ioend->io_private)
>  		status = xfs_setfilesize_trans_alloc(ioend);
>  
>  	memalloc_nofs_restore(nofs_flag);
> @@ -729,7 +729,7 @@ xfs_alloc_ioend(
>  	ioend->io_inode = inode;
>  	ioend->io_size = 0;
>  	ioend->io_offset = offset;
> -	ioend->io_append_trans = NULL;
> +	ioend->io_private = NULL;
>  	ioend->io_bio = bio;
>  	return ioend;
>  }
> diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
> index 4af8ec0115cd..6a45d675dcba 100644
> --- a/fs/xfs/xfs_aops.h
> +++ b/fs/xfs/xfs_aops.h
> @@ -18,7 +18,7 @@ struct xfs_ioend {
>  	struct inode		*io_inode;	/* file being written to */
>  	size_t			io_size;	/* size of the extent */
>  	xfs_off_t		io_offset;	/* offset in the file */
> -	struct xfs_trans	*io_append_trans;/* xact. for size update */
> +	void			*io_private;	/* file system private data */
>  	struct bio		*io_bio;	/* bio being built */
>  	struct bio		io_inline_bio;	/* MUST BE LAST! */
>  };
> -- 
> 2.20.1
> 
