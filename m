Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8C3CFD8A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 17:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfJHP0M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 11:26:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38210 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfJHP0M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:26:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98FG8Pv088607;
        Tue, 8 Oct 2019 15:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=cfnYLKKF3QvoXEkOEJS5obBIn+BMzCR+6N4HazsRGPY=;
 b=EbC2tZ0zc93PAli8XbLd1qe0qrbTkHjj8sWut0COc1eE02MFxQ9XFh0Z6x9V31yOHitZ
 0+S+XXP9nG32HIWlTCkH5Lkl14fAT9Ro22OY32wRlYqfB5uKr2C01Elldwug6VhOL1Xo
 fEklyqakDagMkcuLh+NzbuXSHxRCnpWSCKb8/G4BCddJXJTAXqgt8iS5u856YZwcC0xJ
 uGS23+1t/vjjfptev6a0FYMGMPmfpgewjlWunQSBKq2BFGEvh0rKbdYNyvR945VFXJ7o
 bbb3w5YifNyYn/7LbZo4u2CrgBFkGE2k0FvmD4Q70qMpEX0ClSDaxx/bBM6PbUpTcTaf Rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vek4qe1g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 15:26:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98FFJMT143305;
        Tue, 8 Oct 2019 15:26:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vg206j2pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 15:26:05 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x98FQ4aD029031;
        Tue, 8 Oct 2019 15:26:05 GMT
Received: from localhost (/10.159.136.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 08:26:04 -0700
Date:   Tue, 8 Oct 2019 08:26:03 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/20] xfs: fill out the srcmap in iomap_begin
Message-ID: <20191008152603.GZ13108@magnolia>
References: <20191008071527.29304-1-hch@lst.de>
 <20191008071527.29304-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008071527.29304-14-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080135
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 09:15:20AM +0200, Christoph Hellwig wrote:
> Replace our local hacks to report the source block in the main iomap
> with the proper scrmap reporting.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_iomap.c | 49 +++++++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 3292dfc8030a..ab2482a573d8 100644
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
