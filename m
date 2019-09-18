Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC618B690F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 19:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbfIRR21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 13:28:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46962 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfIRR21 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:28:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHO9K0088227;
        Wed, 18 Sep 2019 17:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=QF2jNLrF/P7CW6y91WK8PxXUsqZiHIEa7lVkeIKXwfQ=;
 b=RixEdA5G1+gNq6neVfB7P8SgcbqN6Etr4aYORUbq8MRuyV7oYC+BDTArnQJ+1vcG6BTt
 TYCRihRwbtc3pGlfWjjq8JtgPcO1tJpE7jFhJqJUih6H1Tp6Lw8hHia5go2PG75szi4x
 ufQvpFJNcb6qq0UEmGoaIwOuM8AlWwckNfe7jLHb29XwTJDOsFBZ+9H2GujHjm/UVMUj
 8hqCqrS4neYsJQ4+5i7UnLpSP1TOKnPaYgpfh+nzWYks93iOLJRk2mjOB890I0ma55lM
 PmcfCsrPXMrFkS3RUWsdKNAEPJhcMoJDUhYN4U8A4J+cifJUfWXVrnOXacSSL7TKpORn JA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2v385dwe03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:28:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHMpaI078259;
        Wed, 18 Sep 2019 17:26:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2v37mndc56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:26:20 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8IHQJBu020712;
        Wed, 18 Sep 2019 17:26:19 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 10:26:18 -0700
Date:   Wed, 18 Sep 2019 10:26:17 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/19] xfs: pass two imaps to xfs_reflink_allocate_cow
Message-ID: <20190918172617.GB2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-11-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909180159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909180159
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 08:27:13PM +0200, Christoph Hellwig wrote:
> xfs_reflink_allocate_cow consumes the source data fork imap, and
> potentially returns the COW fork imap.  Split the arguments in two
> to clear up the calling conventions and to prepare for returning
> a source iomap from ->iomap_begin.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_iomap.c   |  8 ++++----
>  fs/xfs/xfs_reflink.c | 30 +++++++++++++++---------------
>  fs/xfs/xfs_reflink.h |  4 ++--
>  3 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index db4764c16142..b228d1dbf59f 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -996,9 +996,8 @@ xfs_file_iomap_begin(
>  			goto out_found;
>  
>  		/* may drop and re-acquire the ilock */
> -		cmap = imap;
> -		error = xfs_reflink_allocate_cow(ip, &cmap, &shared, &lockmode,
> -				directio);
> +		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
> +				&lockmode, directio);
>  		if (error)
>  			goto out_unlock;
>  
> @@ -1011,7 +1010,8 @@ xfs_file_iomap_begin(
>  		 * newly allocated address.  If the data fork has a hole, copy
>  		 * the COW fork mapping to avoid allocating to the data fork.
>  		 */
> -		if (directio || imap.br_startblock == HOLESTARTBLOCK)
> +		if (shared &&

Hmm.  At first I thought this was a behavior change but I think it isn't
because prior to this patch we'd set cmap = imap and if _allocate_cow
didn't find a shared extent then it would just return without doing
anything or touching cmap.  In the !shared case this would just set imap
to itself pointlessly.

Now that we pass both imap and cmap to _allocate_cow, in the !shared
case we don't initialized cmap at all, so adding the @shared check is
required for correct operation, right?

If so,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks for cleaning that up, the "mapping could be from another fork on
exit" behavior always bothered me.

--D

> +		    (directio || imap.br_startblock == HOLESTARTBLOCK))
>  			imap = cmap;
>  
>  		end_fsb = imap.br_startoff + imap.br_blockcount;
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 73f8cce4722d..673018a618f0 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -308,13 +308,13 @@ static int
>  xfs_find_trim_cow_extent(
>  	struct xfs_inode	*ip,
>  	struct xfs_bmbt_irec	*imap,
> +	struct xfs_bmbt_irec	*cmap,
>  	bool			*shared,
>  	bool			*found)
>  {
>  	xfs_fileoff_t		offset_fsb = imap->br_startoff;
>  	xfs_filblks_t		count_fsb = imap->br_blockcount;
>  	struct xfs_iext_cursor	icur;
> -	struct xfs_bmbt_irec	got;
>  
>  	*found = false;
>  
> @@ -322,23 +322,22 @@ xfs_find_trim_cow_extent(
>  	 * If we don't find an overlapping extent, trim the range we need to
>  	 * allocate to fit the hole we found.
>  	 */
> -	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &got))
> -		got.br_startoff = offset_fsb + count_fsb;
> -	if (got.br_startoff > offset_fsb) {
> +	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, cmap))
> +		cmap->br_startoff = offset_fsb + count_fsb;
> +	if (cmap->br_startoff > offset_fsb) {
>  		xfs_trim_extent(imap, imap->br_startoff,
> -				got.br_startoff - imap->br_startoff);
> +				cmap->br_startoff - imap->br_startoff);
>  		return xfs_inode_need_cow(ip, imap, shared);
>  	}
>  
>  	*shared = true;
> -	if (isnullstartblock(got.br_startblock)) {
> -		xfs_trim_extent(imap, got.br_startoff, got.br_blockcount);
> +	if (isnullstartblock(cmap->br_startblock)) {
> +		xfs_trim_extent(imap, cmap->br_startoff, cmap->br_blockcount);
>  		return 0;
>  	}
>  
>  	/* real extent found - no need to allocate */
> -	xfs_trim_extent(&got, offset_fsb, count_fsb);
> -	*imap = got;
> +	xfs_trim_extent(cmap, offset_fsb, count_fsb);
>  	*found = true;
>  	return 0;
>  }
> @@ -348,6 +347,7 @@ int
>  xfs_reflink_allocate_cow(
>  	struct xfs_inode	*ip,
>  	struct xfs_bmbt_irec	*imap,
> +	struct xfs_bmbt_irec	*cmap,
>  	bool			*shared,
>  	uint			*lockmode,
>  	bool			convert_now)
> @@ -367,7 +367,7 @@ xfs_reflink_allocate_cow(
>  		xfs_ifork_init_cow(ip);
>  	}
>  
> -	error = xfs_find_trim_cow_extent(ip, imap, shared, &found);
> +	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
>  	if (error || !*shared)
>  		return error;
>  	if (found)
> @@ -392,7 +392,7 @@ xfs_reflink_allocate_cow(
>  	/*
>  	 * Check for an overlapping extent again now that we dropped the ilock.
>  	 */
> -	error = xfs_find_trim_cow_extent(ip, imap, shared, &found);
> +	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
>  	if (error || !*shared)
>  		goto out_trans_cancel;
>  	if (found) {
> @@ -411,7 +411,7 @@ xfs_reflink_allocate_cow(
>  	nimaps = 1;
>  	error = xfs_bmapi_write(tp, ip, imap->br_startoff, imap->br_blockcount,
>  			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC,
> -			resblks, imap, &nimaps);
> +			resblks, cmap, &nimaps);
>  	if (error)
>  		goto out_unreserve;
>  
> @@ -427,15 +427,15 @@ xfs_reflink_allocate_cow(
>  	if (nimaps == 0)
>  		return -ENOSPC;
>  convert:
> -	xfs_trim_extent(imap, offset_fsb, count_fsb);
> +	xfs_trim_extent(cmap, offset_fsb, count_fsb);
>  	/*
>  	 * COW fork extents are supposed to remain unwritten until we're ready
>  	 * to initiate a disk write.  For direct I/O we are going to write the
>  	 * data and need the conversion, but for buffered writes we're done.
>  	 */
> -	if (!convert_now || imap->br_state == XFS_EXT_NORM)
> +	if (!convert_now || cmap->br_state == XFS_EXT_NORM)
>  		return 0;
> -	trace_xfs_reflink_convert_cow(ip, imap);
> +	trace_xfs_reflink_convert_cow(ip, cmap);
>  	return xfs_reflink_convert_cow_locked(ip, offset_fsb, count_fsb);
>  
>  out_unreserve:
> diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
> index 28a43b7f581d..d18ad7f4fb64 100644
> --- a/fs/xfs/xfs_reflink.h
> +++ b/fs/xfs/xfs_reflink.h
> @@ -25,8 +25,8 @@ extern int xfs_reflink_trim_around_shared(struct xfs_inode *ip,
>  bool xfs_inode_need_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
>  		bool *shared);
>  
> -extern int xfs_reflink_allocate_cow(struct xfs_inode *ip,
> -		struct xfs_bmbt_irec *imap, bool *shared, uint *lockmode,
> +int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
> +		struct xfs_bmbt_irec *cmap, bool *shared, uint *lockmode,
>  		bool convert_now);
>  extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
>  		xfs_off_t count);
> -- 
> 2.20.1
> 
