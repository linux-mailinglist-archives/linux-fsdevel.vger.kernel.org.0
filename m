Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8322D363C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 23:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbgLHW0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 17:26:49 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44960 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbgLHW0t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 17:26:49 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8ItgNN077047;
        Tue, 8 Dec 2020 19:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=jGEyiZqdUOS9faxXMWXb/+atEZAcG8r2YE/P50mm0iQ=;
 b=jbqTC8Y2Rj5TD8nGrgK6jb9iDgxwHigfXnK2afO+5u/0NdKru8Yhsc7z+poH1aKIccJh
 xJp1LZtYam1mq2npxylHqIJuannXkuUz0JEqlmhY8x94QRhoCpaslgwg5zog9vQDCdif
 dn6Sqcr5ZPPxFutgNIUGTGdmqpRqOHel7n8GfXgRcLIpwnSQaJCcd5YBsEzolDWnsITU
 kacciFufrJvJp/h3Zi60KiIGlcGGH4eKOfxGMop8y0FyPfXFcu5EdbyjIoH/45cyppkE
 3JTJY86Sxzl/Y6priuhxPbo2lcn72yGIZELyckJNFqJ0/NbuHYmUKXL3oL05j8fbb2s/ 1A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 357yqbvk6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Dec 2020 19:00:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B8IuUHX094441;
        Tue, 8 Dec 2020 19:00:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 358m3y5d3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Dec 2020 19:00:02 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B8J01TJ007389;
        Tue, 8 Dec 2020 19:00:01 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Dec 2020 11:00:00 -0800
Date:   Tue, 8 Dec 2020 10:59:59 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     willy@infradead.org, david@fromorbit.com, hch@infradead.org,
        mhocko@kernel.org, akpm@linux-foundation.org, dhowells@redhat.com,
        jlayton@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v11 4/4] xfs: use current->journal_info to avoid
 transaction reservation recursion
Message-ID: <20201208185959.GD1943235@magnolia>
References: <20201208122824.16118-1-laoar.shao@gmail.com>
 <20201208122824.16118-5-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208122824.16118-5-laoar.shao@gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=1 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080115
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 08, 2020 at 08:28:24PM +0800, Yafang Shao wrote:
> PF_FSTRANS which is used to avoid transaction reservation recursion, is
> dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
> PF_MEMALLOC_NOFS") and commit 7dea19f9ee63 ("mm: introduce
> memalloc_nofs_{save,restore} API") and replaced by PF_MEMALLOC_NOFS which
> means to avoid filesystem reclaim recursion.
> 
> As these two flags have different meanings, we'd better reintroduce
> PF_FSTRANS back. To avoid wasting the space of PF_* flags in task_struct,
> we can reuse the current->journal_info to do that, per Willy. As the
> check of transaction reservation recursion is used by XFS only, we can
> move the check into xfs_vm_writepage(s), per Dave.
> 
> To better abstract that behavoir, two new helpers are introduced, as
> follows,
> - xfs_trans_context_active
>   To check whehter current is in fs transcation or not
> - xfs_trans_context_swap
>   Transfer the transaction context when rolling a permanent transaction
> 
> These two new helpers are instroduced in xfs_trans.h.
> 
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jeff Layton <jlayton@redhat.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  fs/iomap/buffered-io.c |  7 -------
>  fs/xfs/xfs_aops.c      | 17 +++++++++++++++++
>  fs/xfs/xfs_trans.c     |  3 +++
>  fs/xfs/xfs_trans.h     | 22 ++++++++++++++++++++++
>  4 files changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 10cc7979ce38..3c53fa6ce64d 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1458,13 +1458,6 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  			PF_MEMALLOC))
>  		goto redirty;
>  
> -	/*
> -	 * Given that we do not allow direct reclaim to call us, we should
> -	 * never be called in a recursive filesystem reclaim context.
> -	 */
> -	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> -		goto redirty;
> -
>  	/*
>  	 * Is this page beyond the end of the file?
>  	 *
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 2371187b7615..0da0242d42c3 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -568,6 +568,16 @@ xfs_vm_writepage(
>  {
>  	struct xfs_writepage_ctx wpc = { };
>  
> +	/*
> +	 * Given that we do not allow direct reclaim to call us, we should
> +	 * never be called while in a filesystem transaction.
> +	 */
> +	if (WARN_ON_ONCE(xfs_trans_context_active())) {
> +		redirty_page_for_writepage(wbc, page);
> +		unlock_page(page);
> +		return 0;
> +	}
> +
>  	return iomap_writepage(page, wbc, &wpc.ctx, &xfs_writeback_ops);
>  }
>  
> @@ -579,6 +589,13 @@ xfs_vm_writepages(
>  	struct xfs_writepage_ctx wpc = { };
>  
>  	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
> +	/*
> +	 * Given that we do not allow direct reclaim to call us, we should
> +	 * never be called while in a filesystem transaction.
> +	 */
> +	if (WARN_ON_ONCE(xfs_trans_context_active()))
> +		return 0;
> +
>  	return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
>  }
>  
> diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> index fe20398a214e..08d4916ffb13 100644
> --- a/fs/xfs/xfs_trans.c
> +++ b/fs/xfs/xfs_trans.c
> @@ -124,6 +124,9 @@ xfs_trans_dup(
>  	tp->t_rtx_res = tp->t_rtx_res_used;
>  	ntp->t_pflags = tp->t_pflags;

This one line (ntp->t_pflags = tp->t_pflags) should move to
xfs_trans_context_swap.

--D

>  
> +	/* Associate the new transaction with this thread. */
> +	xfs_trans_context_swap(tp, ntp);
> +
>  	/* move deferred ops over to the new tp */
>  	xfs_defer_move(ntp, tp);
>  
> diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
> index 44b11c64a15e..d596a375e3bf 100644
> --- a/fs/xfs/xfs_trans.h
> +++ b/fs/xfs/xfs_trans.h
> @@ -268,16 +268,38 @@ xfs_trans_item_relog(
>  	return lip->li_ops->iop_relog(lip, tp);
>  }
>  
> +static inline bool
> +xfs_trans_context_active(void)
> +{
> +	/* Use journal_info to indicate current is in a transaction */
> +	return current->journal_info != NULL;
> +}
> +
>  static inline void
>  xfs_trans_context_set(struct xfs_trans *tp)
>  {
> +	ASSERT(!current->journal_info);
> +	current->journal_info = tp;
>  	tp->t_pflags = memalloc_nofs_save();
>  }
>  
>  static inline void
>  xfs_trans_context_clear(struct xfs_trans *tp)
>  {
> +	ASSERT(current->journal_info == tp);
> +	current->journal_info = NULL;
>  	memalloc_nofs_restore(tp->t_pflags);
>  }
>  
> +/*
> + * Transfer the transaction context when rolling a permanent
> + * transaction.
> + */
> +static inline void
> +xfs_trans_context_swap(struct xfs_trans *tp, struct xfs_trans *ntp)
> +{
> +	ASSERT(current->journal_info == tp);
> +	current->journal_info = ntp;
> +}
> +
>  #endif	/* __XFS_TRANS_H__ */
> -- 
> 2.18.4
> 
