Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3889B69E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 19:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfIRRwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 13:52:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41166 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbfIRRwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:52:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHd1j1100434;
        Wed, 18 Sep 2019 17:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=cgxeaOMY0qSxoZT/LWRWDSDADbr7L2IP+dx0dwUZwkI=;
 b=DpaDlXQmw6PXX2UVdmLc6VWvo2NNbX4hq696EMrT2bqsAgeh6NXiHUwTIYAV4lzYnsSs
 CFV6hjc1wYl4wnTLD/7Q8bxxkIt8YRkM8Ucaxttd4NHTURPPcHDSNyqggFc8icNbZmeE
 WdntIW81ey5CHiK76yQODFq4WjAjYm5U5JxQR+zlmfxMoc5rNeWlYWPcUNjXAAOw5dSE
 d8LNDfapWeQ05svHQ+lpymkWz+SlZNMmJCWvDzjO7pkfkwfbXdkOOkCiwPltoRkPCZ1F
 n84JHJq7T7EE24PLIup5R+g5eo4PLjI338wuQZALVvdC+hcRZXDLM5hOUp5W22E/BM7Q FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2v385dwhx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:52:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHd6SM054458;
        Wed, 18 Sep 2019 17:52:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2v37maxs2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:52:32 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8IHqUdd031944;
        Wed, 18 Sep 2019 17:52:31 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 10:52:29 -0700
Date:   Wed, 18 Sep 2019 10:52:28 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/19] xfs: fill out the srcmap in iomap_begin
Message-ID: <20190918175228.GE2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-13-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909180160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909180160
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 08:27:15PM +0200, Christoph Hellwig wrote:
> Replace our local hacks to report the source block in the main iomap
> with the proper scrmap reporting.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_iomap.c | 49 +++++++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 18a0f8a5d8c9..d12eacdc9bba 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -527,7 +527,8 @@ xfs_file_iomap_begin_delay(
>  	loff_t			offset,
>  	loff_t			count,
>  	unsigned		flags,
> -	struct iomap		*iomap)
> +	struct iomap		*iomap,
> +	struct iomap		*srcmap)
>  {
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> @@ -721,11 +722,13 @@ xfs_file_iomap_begin_delay(
>  found_cow:
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  	if (imap.br_startoff <= offset_fsb) {
> -		/* ensure we only report blocks we have a reservation for */
> -		xfs_trim_extent(&imap, cmap.br_startoff, cmap.br_blockcount);
> -		return xfs_bmbt_to_iomap(ip, iomap, &imap, IOMAP_F_SHARED);
> +		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, 0);
> +		if (error)
> +			return error;
> +	} else {
> +		xfs_trim_extent(&cmap, offset_fsb,
> +				imap.br_startoff - offset_fsb);
>  	}
> -	xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
>  	return xfs_bmbt_to_iomap(ip, iomap, &cmap, IOMAP_F_SHARED);
>  
>  out_unlock:
> @@ -933,7 +936,7 @@ xfs_file_iomap_begin(
>  {
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> -	struct xfs_bmbt_irec	imap;
> +	struct xfs_bmbt_irec	imap, cmap;
>  	xfs_fileoff_t		offset_fsb, end_fsb;
>  	int			nimaps = 1, error = 0;
>  	bool			shared = false;
> @@ -947,7 +950,7 @@ xfs_file_iomap_begin(
>  			!IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
>  		/* Reserve delalloc blocks for regular writeback. */
>  		return xfs_file_iomap_begin_delay(inode, offset, length, flags,
> -				iomap);
> +				iomap, srcmap);
>  	}
>  
>  	/*
> @@ -987,9 +990,6 @@ xfs_file_iomap_begin(
>  	 * been done up front, so we don't need to do them here.
>  	 */
>  	if (xfs_is_cow_inode(ip)) {
> -		struct xfs_bmbt_irec	cmap;
> -		bool			directio = (flags & IOMAP_DIRECT);
> -
>  		/* if zeroing doesn't need COW allocation, then we are done. */
>  		if ((flags & IOMAP_ZERO) &&
>  		    !needs_cow_for_zeroing(&imap, nimaps))
> @@ -997,23 +997,11 @@ xfs_file_iomap_begin(
>  
>  		/* may drop and re-acquire the ilock */
>  		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
> -				&lockmode, directio);
> +				&lockmode, flags & IOMAP_DIRECT);
>  		if (error)
>  			goto out_unlock;
> -
> -		/*
> -		 * For buffered writes we need to report the address of the
> -		 * previous block (if there was any) so that the higher level
> -		 * write code can perform read-modify-write operations; we
> -		 * won't need the CoW fork mapping until writeback.  For direct
> -		 * I/O, which must be block aligned, we need to report the
> -		 * newly allocated address.  If the data fork has a hole, copy
> -		 * the COW fork mapping to avoid allocating to the data fork.
> -		 */
> -		if (shared &&
> -		    (directio || imap.br_startblock == HOLESTARTBLOCK))
> -			imap = cmap;
> -
> +		if (shared)
> +			goto out_found_cow;
>  		end_fsb = imap.br_startoff + imap.br_blockcount;
>  		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
>  	}
> @@ -1067,6 +1055,17 @@ xfs_file_iomap_begin(
>  	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
>  	goto out_finish;
>  
> +out_found_cow:
> +	xfs_iunlock(ip, lockmode);
> +	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
> +	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
> +	if (imap.br_startblock != HOLESTARTBLOCK) {

TBH I've been wondering for a while now if it would make more sense to
do this in iomap_apply (and the open-coded versions in dax.c):

	struct iomap srcmap = { .type = IOMAP_HOLE };

in the iomap_apply function (and change the "if (!srcmap.type)" checks
to "if (srcmap.type != IOMAP_HOLE)").  That would get rid of the weird
situation where iomap.h doesn't define an iomap type name corresponding
to 0 but clearly it has some special meaning because the iomap code
changes behavior based on that.

It also strikes me as weird that for the @imap parameter, type == 0
would be considered a coding error but for @srcmap, we use type == 0 to
mean "no mapping" but we don't do that for @srcmap.type == IOMAP_HOLE.

I mention that because, if some ->iomap_begin function returns
IOMAP_HOLE then iomap_apply will pass the (hole) srcmap as the second
parameter to the ->actor function.  When that happens, iomap_write_begin
call will try to fill in the rest of the page from @srcmap (which is
hole), not the @iomap (which might not be a hole) which seems wrong.

As for this function, if we made the above change, then the conditional
becomes unneccessary -- we know this is a COW write, so we call
xfs_bmbt_to_iomap on both mappings and exit.  No need for special
casing.

--D

> +		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, 0);
> +		if (error)
> +			return error;
> +	}
> +	return xfs_bmbt_to_iomap(ip, iomap, &cmap, IOMAP_F_SHARED);
> +
>  out_unlock:
>  	xfs_iunlock(ip, lockmode);
>  	return error;
> -- 
> 2.20.1
> 
