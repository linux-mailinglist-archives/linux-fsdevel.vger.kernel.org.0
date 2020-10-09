Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DCF288D93
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 18:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389323AbgJIQBD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 12:01:03 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34044 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388719AbgJIQBD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:01:03 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 099G0TaI003895;
        Fri, 9 Oct 2020 16:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=KgNlskhh6PAIeUAodtX0YrYqT7e0xrAx3/b6JvHSuz4=;
 b=E/Ev9lv6B298leOisEStRAN61sSO8wOr2ORnR8ruuGcM0yT8bAakExgw6hAVnpkD7ED4
 yXh/geo//84230eRwMBd6i45xRC9d3RPX4hmA1kWlUDGpvyHTEYwk1EUFyl788RkFh85
 UxKgpIWplF0Y8RnbiujBhQBUARvWgu+hZhYErfux/nenemxfxvkrvL5H24rP1OmaJCdO
 2fLPDthJVSXWhgKtRayV4vI3USytmxNS5em41KRuf66UKKSVXH9d179KXIPGVABN670Z
 SdYM+e/G/d5l5vMOKG9ffGcrJwyopXj9S1LA4mrwNJCKVyg2+593PAR8Q9QqH7Cv4VGn 9A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 342kvytbvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 09 Oct 2020 16:00:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 099G0KoE114711;
        Fri, 9 Oct 2020 16:00:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3429k19sbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Oct 2020 16:00:47 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 099G0jk8007943;
        Fri, 9 Oct 2020 16:00:45 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Oct 2020 09:00:44 -0700
Date:   Fri, 9 Oct 2020 09:00:40 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        mhocko@kernel.org, akpm@linux-foundation.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 2/2] xfs: avoid transaction reservation recursion
Message-ID: <20201009160040.GW6540@magnolia>
References: <20201009125127.37435-1-laoar.shao@gmail.com>
 <20201009125127.37435-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009125127.37435-3-laoar.shao@gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9769 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=5 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9769 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 suspectscore=5 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010090120
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 09, 2020 at 08:51:27PM +0800, Yafang Shao wrote:
> PF_FSTRANS which is used to avoid transaction reservation recursion, is
> dropped since commit 9070733b4efa ("xfs: abstract PF_FSTRANS to
> PF_MEMALLOC_NOFS") and commit 7dea19f9ee63 ("mm: introduce
> memalloc_nofs_{save,restore} API") and replaced by PF_MEMALLOC_NOFS which
> means to avoid filesystem reclaim recursion. That change is subtle.
> Let's take the exmple of the check of WARN_ON_ONCE(current->flags &
> PF_MEMALLOC_NOFS)) to explain why this abstraction from PF_FSTRANS to
> PF_MEMALLOC_NOFS is not proper.
> Below comment is quoted from Dave,
> > It wasn't for memory allocation recursion protection in XFS - it was for
> > transaction reservation recursion protection by something trying to flush
> > data pages while holding a transaction reservation. Doing
> > this could deadlock the journal because the existing reservation
> > could prevent the nested reservation for being able to reserve space
> > in the journal and that is a self-deadlock vector.
> > IOWs, this check is not protecting against memory reclaim recursion
> > bugs at all (that's the previous check [1]). This check is
> > protecting against the filesystem calling writepages directly from a
> > context where it can self-deadlock.
> > So what we are seeing here is that the PF_FSTRANS ->
> > PF_MEMALLOC_NOFS abstraction lost all the actual useful information
> > about what type of error this check was protecting against.
> 
> As a result, we should reintroduce PF_FSTRANS. As current->journal_info
> isn't used in XFS, we can reuse it to indicate whehter the task is in
> fstrans or not, Per Willy. To achieve that, four new helpers are introduce
> in this patch, per Dave:
> - xfs_trans_context_set()
>   Used in xfs_trans_alloc()
> - xfs_trans_context_clear()
>   Used in xfs_trans_commit() and xfs_trans_cancel()
> - xfs_trans_context_update()
>   Used in xfs_trans_roll()
> - xfs_trans_context_active()
>   To check whehter current is in fs transcation or not
> 
> [1]. Below check is to avoid memory reclaim recursion.
> if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
>         PF_MEMALLOC))
>         goto redirty;
> 
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Well, now that I've killed off (AFAIK) the last nested transaction in
XFS I guess it's time to do this...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c |  7 -------
>  fs/xfs/xfs_aops.c      | 23 +++++++++++++++++++++--
>  fs/xfs/xfs_linux.h     |  4 ----
>  fs/xfs/xfs_trans.c     | 19 +++++++++----------
>  fs/xfs/xfs_trans.h     | 30 ++++++++++++++++++++++++++++++
>  5 files changed, 60 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index bcfc288dba3f..3dc57a38bf0b 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1498,13 +1498,6 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
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
> index b35611882ff9..af7270f5f8a9 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -62,7 +62,8 @@ xfs_setfilesize_trans_alloc(
>  	 * We hand off the transaction to the completion thread now, so
>  	 * clear the flag here.
>  	 */
> -	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +	xfs_trans_context_clear(tp);
> +
>  	return 0;
>  }
>  
> @@ -125,7 +126,7 @@ xfs_setfilesize_ioend(
>  	 * thus we need to mark ourselves as being in a transaction manually.
>  	 * Similarly for freeze protection.
>  	 */
> -	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +	xfs_trans_context_set(tp);
>  	__sb_writers_acquired(VFS_I(ip)->i_sb, SB_FREEZE_FS);
>  
>  	/* we abort the update if there was an IO error */
> @@ -564,6 +565,16 @@ xfs_vm_writepage(
>  {
>  	struct xfs_writepage_ctx wpc = { };
>  
> +	/*
> +	 * Given that we do not allow direct reclaim to call us, we should
> +	 * never be called while in a filesystem transaction.
> +	 */
> +	if (xfs_trans_context_active()) {
> +		redirty_page_for_writepage(wbc, page);
> +		unlock_page(page);
> +		return 0;
> +	}
> +
>  	return iomap_writepage(page, wbc, &wpc.ctx, &xfs_writeback_ops);
>  }
>  
> @@ -575,6 +586,14 @@ xfs_vm_writepages(
>  	struct xfs_writepage_ctx wpc = { };
>  
>  	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
> +
> +	/*
> +	 * Given that we do not allow direct reclaim to call us, we should
> +	 * never be called while in a filesystem transaction.
> +	 */
> +	if (xfs_trans_context_active())
> +		return 0;
> +
>  	return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
>  }
>  
> diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
> index ab737fed7b12..8a4f6db77e33 100644
> --- a/fs/xfs/xfs_linux.h
> +++ b/fs/xfs/xfs_linux.h
> @@ -102,10 +102,6 @@ typedef __u32			xfs_nlink_t;
>  #define xfs_cowb_secs		xfs_params.cowb_timer.val
>  
>  #define current_cpu()		(raw_smp_processor_id())
> -#define current_set_flags_nested(sp, f)		\
> -		(*(sp) = current->flags, current->flags |= (f))
> -#define current_restore_flags_nested(sp, f)	\
> -		(current->flags = ((current->flags & ~(f)) | (*(sp) & (f))))
>  
>  #define NBBY		8		/* number of bits per byte */
>  
> diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> index ed72867b1a19..5f3a4ff51b3c 100644
> --- a/fs/xfs/xfs_trans.c
> +++ b/fs/xfs/xfs_trans.c
> @@ -153,8 +153,6 @@ xfs_trans_reserve(
>  	int			error = 0;
>  	bool			rsvd = (tp->t_flags & XFS_TRANS_RESERVE) != 0;
>  
> -	/* Mark this thread as being in a transaction */
> -	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
>  
>  	/*
>  	 * Attempt to reserve the needed disk blocks by decrementing
> @@ -163,10 +161,8 @@ xfs_trans_reserve(
>  	 */
>  	if (blocks > 0) {
>  		error = xfs_mod_fdblocks(mp, -((int64_t)blocks), rsvd);
> -		if (error != 0) {
> -			current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +		if (error != 0)
>  			return -ENOSPC;
> -		}
>  		tp->t_blk_res += blocks;
>  	}
>  
> @@ -241,8 +237,6 @@ xfs_trans_reserve(
>  		tp->t_blk_res = 0;
>  	}
>  
> -	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> -
>  	return error;
>  }
>  
> @@ -284,6 +278,8 @@ xfs_trans_alloc(
>  	INIT_LIST_HEAD(&tp->t_dfops);
>  	tp->t_firstblock = NULLFSBLOCK;
>  
> +	/* Mark this thread as being in a transaction */
> +	xfs_trans_context_set(tp);
>  	error = xfs_trans_reserve(tp, resp, blocks, rtextents);
>  	if (error) {
>  		xfs_trans_cancel(tp);
> @@ -878,7 +874,8 @@ __xfs_trans_commit(
>  
>  	xfs_log_commit_cil(mp, tp, &commit_lsn, regrant);
>  
> -	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +	if (!regrant)
> +		xfs_trans_context_clear(tp);
>  	xfs_trans_free(tp);
>  
>  	/*
> @@ -910,7 +907,8 @@ __xfs_trans_commit(
>  			xfs_log_ticket_ungrant(mp->m_log, tp->t_ticket);
>  		tp->t_ticket = NULL;
>  	}
> -	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +
> +	xfs_trans_context_clear(tp);
>  	xfs_trans_free_items(tp, !!error);
>  	xfs_trans_free(tp);
>  
> @@ -971,7 +969,7 @@ xfs_trans_cancel(
>  	}
>  
>  	/* mark this thread as no longer being in a transaction */
> -	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
> +	xfs_trans_context_clear(tp);
>  
>  	xfs_trans_free_items(tp, dirty);
>  	xfs_trans_free(tp);
> @@ -1013,6 +1011,7 @@ xfs_trans_roll(
>  	if (error)
>  		return error;
>  
> +	xfs_trans_context_update(trans, *tpp);
>  	/*
>  	 * Reserve space in the log for the next transaction.
>  	 * This also pushes items in the "AIL", the list of logged items,
> diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
> index b752501818d2..f84b563438f6 100644
> --- a/fs/xfs/xfs_trans.h
> +++ b/fs/xfs/xfs_trans.h
> @@ -243,4 +243,34 @@ void		xfs_trans_buf_copy_type(struct xfs_buf *dst_bp,
>  
>  extern kmem_zone_t	*xfs_trans_zone;
>  
> +static inline void
> +xfs_trans_context_set(struct xfs_trans *tp)
> +{
> +	ASSERT(!current->journal_info);
> +	current->journal_info = tp;
> +	tp->t_pflags = memalloc_nofs_save();
> +}
> +
> +static inline void
> +xfs_trans_context_update(struct xfs_trans *old, struct xfs_trans *new)
> +{
> +	ASSERT(current->journal_info == old);
> +	current->journal_info = new;
> +}
> +
> +static inline void
> +xfs_trans_context_clear(struct xfs_trans *tp)
> +{
> +	ASSERT(current->journal_info == tp);
> +	current->journal_info = NULL;
> +	memalloc_nofs_restore(tp->t_pflags);
> +}
> +
> +static inline bool
> +xfs_trans_context_active(void)
> +{
> +	/* Use journal_info to indicate current is in a transaction */
> +	return current->journal_info != NULL;
> +}
> +
>  #endif	/* __XFS_TRANS_H__ */
> -- 
> 2.17.1
> 
