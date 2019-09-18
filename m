Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B7FB6A16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 19:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfIRR46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 13:56:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53056 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfIRR46 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:56:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHd3Dl048106;
        Wed, 18 Sep 2019 17:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=WkClsRtnPAAYTrOe7KXCWZkq2xybljMWCMDIk5sFMzo=;
 b=cBRT9SM7dlyyjLaEF8BoNHDZ9P1v+UkOzHgB1RLIyfCwiAOkdprMZGC5R2QOaNhnI1zm
 rnSQXukahIMGLkB84GwBpGX083ZfO36Jv5echSvDkX/d1F8glWzV+SSQ86F9Pnk+d7Cy
 mWpweJ1RFchyUyGmYBIaGzUHtPr4KiqeQvuSUl5oybXpOzXgfrXoHyxJf+AYLtfEzVCV
 cfxRbYaxU4Uf82sBH3peHptGSXLr2Pm2yNp3fQl4o6+1UxH3eA5yibDyR/i6nwYZ1V3F
 vmhNQp3BqbRGJ2DzDNOUT8FlF4lJZm33dKnsqGwsfKDR0NP85hCqvTcttwQdqFl4k3JQ /g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2v385e5jx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:56:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHd72H121916;
        Wed, 18 Sep 2019 17:56:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2v37ma1qy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:56:30 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8IHuTJn027329;
        Wed, 18 Sep 2019 17:56:29 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 10:56:29 -0700
Date:   Wed, 18 Sep 2019 10:56:28 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/19] xfs: split out a new set of read-only iomap ops
Message-ID: <20190918175628.GG2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-15-hch@lst.de>
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

On Mon, Sep 09, 2019 at 08:27:17PM +0200, Christoph Hellwig wrote:
> Start untangling xfs_file_iomap_begin by splitting out the read-only
> case into its own set of iomap_ops with a very simply iomap_begin
> helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_aops.c  |  9 ++++---
>  fs/xfs/xfs_file.c  |  8 +++---
>  fs/xfs/xfs_iomap.c | 61 ++++++++++++++++++++++++++++++++++------------
>  fs/xfs/xfs_iomap.h |  1 +
>  fs/xfs/xfs_iops.c  |  2 +-
>  5 files changed, 58 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 4e4a4d7df5ac..fe47a4d52247 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -1158,7 +1158,7 @@ xfs_vm_bmap(
>  	 */
>  	if (xfs_is_cow_inode(ip) || XFS_IS_REALTIME_INODE(ip))
>  		return 0;
> -	return iomap_bmap(mapping, block, &xfs_iomap_ops);
> +	return iomap_bmap(mapping, block, &xfs_read_iomap_ops);
>  }
>  
>  STATIC int
> @@ -1167,7 +1167,7 @@ xfs_vm_readpage(
>  	struct page		*page)
>  {
>  	trace_xfs_vm_readpage(page->mapping->host, 1);
> -	return iomap_readpage(page, &xfs_iomap_ops);
> +	return iomap_readpage(page, &xfs_read_iomap_ops);
>  }
>  
>  STATIC int
> @@ -1178,7 +1178,7 @@ xfs_vm_readpages(
>  	unsigned		nr_pages)
>  {
>  	trace_xfs_vm_readpages(mapping->host, nr_pages);
> -	return iomap_readpages(mapping, pages, nr_pages, &xfs_iomap_ops);
> +	return iomap_readpages(mapping, pages, nr_pages, &xfs_read_iomap_ops);
>  }
>  
>  static int
> @@ -1188,7 +1188,8 @@ xfs_iomap_swapfile_activate(
>  	sector_t			*span)
>  {
>  	sis->bdev = xfs_find_bdev_for_inode(file_inode(swap_file));
> -	return iomap_swapfile_activate(sis, swap_file, span, &xfs_iomap_ops);
> +	return iomap_swapfile_activate(sis, swap_file, span,
> +			&xfs_read_iomap_ops);
>  }
>  
>  const struct address_space_operations xfs_address_space_operations = {
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 21bd3d575aaa..d8e2e36b84f7 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -187,7 +187,7 @@ xfs_file_dio_aio_read(
>  	file_accessed(iocb->ki_filp);
>  
>  	xfs_ilock(ip, XFS_IOLOCK_SHARED);
> -	ret = iomap_dio_rw(iocb, to, &xfs_iomap_ops, NULL);
> +	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL);
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
>  
>  	return ret;
> @@ -214,7 +214,7 @@ xfs_file_dax_read(
>  		xfs_ilock(ip, XFS_IOLOCK_SHARED);
>  	}
>  
> -	ret = dax_iomap_rw(iocb, to, &xfs_iomap_ops);
> +	ret = dax_iomap_rw(iocb, to, &xfs_read_iomap_ops);
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
>  
>  	file_accessed(iocb->ki_filp);
> @@ -1131,7 +1131,9 @@ __xfs_filemap_fault(
>  	if (IS_DAX(inode)) {
>  		pfn_t pfn;
>  
> -		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &xfs_iomap_ops);
> +		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
> +				(write_fault && !vmf->cow_page) ?
> +				 &xfs_iomap_ops : &xfs_read_iomap_ops);
>  		if (ret & VM_FAULT_NEEDDSYNC)
>  			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
>  	} else {
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 0ba67a8d8169..d0ed0cba9041 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -950,11 +950,13 @@ xfs_file_iomap_begin(
>  	u16			iomap_flags = 0;
>  	unsigned		lockmode;
>  
> +	ASSERT(flags & (IOMAP_WRITE | IOMAP_ZERO));
> +
>  	if (XFS_FORCED_SHUTDOWN(mp))
>  		return -EIO;
>  
> -	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) && !(flags & IOMAP_DIRECT) &&
> -			!IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
> +	if (!(flags & IOMAP_DIRECT) && !IS_DAX(inode) &&
> +	    !xfs_get_extsz_hint(ip)) {
>  		/* Reserve delalloc blocks for regular writeback. */
>  		return xfs_file_iomap_begin_delay(inode, offset, length, flags,
>  				iomap, srcmap);
> @@ -975,17 +977,6 @@ xfs_file_iomap_begin(
>  	if (error)
>  		goto out_unlock;
>  
> -	if (flags & IOMAP_REPORT) {
> -		/* Trim the mapping to the nearest shared extent boundary. */
> -		error = xfs_reflink_trim_around_shared(ip, &imap, &shared);
> -		if (error)
> -			goto out_unlock;
> -	}
> -
> -	/* Non-modifying mapping requested, so we are done */
> -	if (!(flags & (IOMAP_WRITE | IOMAP_ZERO)))
> -		goto out_found;
> -
>  	/*
>  	 * Break shared extents if necessary. Checks for non-blocking IO have
>  	 * been done up front, so we don't need to do them here.
> @@ -1046,8 +1037,6 @@ xfs_file_iomap_begin(
>  	trace_xfs_iomap_alloc(ip, offset, length, XFS_DATA_FORK, &imap);
>  
>  out_finish:
> -	if (shared)
> -		iomap_flags |= IOMAP_F_SHARED;
>  	return xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags);
>  
>  out_found:
> @@ -1150,6 +1139,48 @@ const struct iomap_ops xfs_iomap_ops = {
>  	.iomap_end		= xfs_file_iomap_end,
>  };
>  
> +static int
> +xfs_read_iomap_begin(
> +	struct inode		*inode,
> +	loff_t			offset,
> +	loff_t			length,
> +	unsigned		flags,
> +	struct iomap		*iomap,
> +	struct iomap		*srcmap)
> +{
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	struct xfs_mount	*mp = ip->i_mount;
> +	struct xfs_bmbt_irec	imap;
> +	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> +	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
> +	int			nimaps = 1, error = 0;
> +	bool			shared = false;
> +	unsigned		lockmode;
> +
> +	ASSERT(!(flags & (IOMAP_WRITE | IOMAP_ZERO)));
> +
> +	if (XFS_FORCED_SHUTDOWN(mp))
> +		return -EIO;
> +
> +	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
> +	if (error)
> +		return error;
> +	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
> +			       &nimaps, 0);
> +	if (!error && (flags & IOMAP_REPORT))
> +		error = xfs_reflink_trim_around_shared(ip, &imap, &shared);
> +	xfs_iunlock(ip, lockmode);
> +
> +	if (error)
> +		return error;
> +	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, shared ? IOMAP_F_SHARED : 0);
> +}
> +
> +const struct iomap_ops xfs_read_iomap_ops = {
> +	.iomap_begin		= xfs_read_iomap_begin,
> +};
> +
>  static int
>  xfs_seek_iomap_begin(
>  	struct inode		*inode,
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index 71d0ae460c44..61b1fc3e5143 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -40,6 +40,7 @@ xfs_aligned_fsb_count(
>  }
>  
>  extern const struct iomap_ops xfs_iomap_ops;
> +extern const struct iomap_ops xfs_read_iomap_ops;
>  extern const struct iomap_ops xfs_seek_iomap_ops;
>  extern const struct iomap_ops xfs_xattr_iomap_ops;
>  
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index ff3c1fae5357..f0c7df82e18b 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1113,7 +1113,7 @@ xfs_vn_fiemap(
>  				&xfs_xattr_iomap_ops);
>  	} else {
>  		error = iomap_fiemap(inode, fieinfo, start, length,
> -				&xfs_iomap_ops);
> +				&xfs_read_iomap_ops);
>  	}
>  	xfs_iunlock(XFS_I(inode), XFS_IOLOCK_SHARED);
>  
> -- 
> 2.20.1
> 
