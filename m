Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64BFCFD94
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 17:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfJHP1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 11:27:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39436 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfJHP1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:27:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98FG8iR088596;
        Tue, 8 Oct 2019 15:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=qPhEjMun6Mmy7Yn588iLmVFZAuHiqy/oJlM5wUwY23M=;
 b=JkM6zjbgNgWYByPI5Q04AcH2PTtLZlZgumNppG580yG/W23Is4dPUiSdnQPW14kT3qeM
 BJRvWauBpaeGJJc4p2eqCnTAEQmXSyswD48SmNqlR4n22IVczmp2sulpFnNn0m+XmXRV
 sD/t+zLGkfnrPgDbN4CfNl27HfEHDGxGL0sW/QoJn+OwS4kJhoxckQ2twwMVv2ZTUex/
 GUNO3iwx0BidD9kbcuEnfRXtP+KpwhqfXapDmoUCgofcfELvXe9ey6HdmpQ41jgtc/G0
 WNh8GdVvcyN0H+gpcUfvEiVP3F9cLO38EQb9en8Qa0CKWIyd/ymZbg8fGsLCHvlTYUea 6Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vek4qe1pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 15:27:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98FEtiP184138;
        Tue, 8 Oct 2019 15:27:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vgeuy4tw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 15:27:05 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x98FR4uR021102;
        Tue, 8 Oct 2019 15:27:04 GMT
Received: from localhost (/10.159.136.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 08:27:03 -0700
Date:   Tue, 8 Oct 2019 08:27:02 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/20] xfs: split out a new set of read-only iomap ops
Message-ID: <20191008152702.GA13108@magnolia>
References: <20191008071527.29304-1-hch@lst.de>
 <20191008071527.29304-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008071527.29304-16-hch@lst.de>
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

On Tue, Oct 08, 2019 at 09:15:22AM +0200, Christoph Hellwig wrote:
> Start untangling xfs_file_iomap_begin by splitting out the read-only
> case into its own set of iomap_ops with a very simply iomap_begin
> helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks the same as last time...
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
> index 807af5c3c347..f708a2831d2f 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -635,7 +635,7 @@ xfs_vm_bmap(
>  	 */
>  	if (xfs_is_cow_inode(ip) || XFS_IS_REALTIME_INODE(ip))
>  		return 0;
> -	return iomap_bmap(mapping, block, &xfs_iomap_ops);
> +	return iomap_bmap(mapping, block, &xfs_read_iomap_ops);
>  }
>  
>  STATIC int
> @@ -643,7 +643,7 @@ xfs_vm_readpage(
>  	struct file		*unused,
>  	struct page		*page)
>  {
> -	return iomap_readpage(page, &xfs_iomap_ops);
> +	return iomap_readpage(page, &xfs_read_iomap_ops);
>  }
>  
>  STATIC int
> @@ -653,7 +653,7 @@ xfs_vm_readpages(
>  	struct list_head	*pages,
>  	unsigned		nr_pages)
>  {
> -	return iomap_readpages(mapping, pages, nr_pages, &xfs_iomap_ops);
> +	return iomap_readpages(mapping, pages, nr_pages, &xfs_read_iomap_ops);
>  }
>  
>  static int
> @@ -663,7 +663,8 @@ xfs_iomap_swapfile_activate(
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
> index 1ffb179f35d2..f9814306ed8e 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -188,7 +188,7 @@ xfs_file_dio_aio_read(
>  	file_accessed(iocb->ki_filp);
>  
>  	xfs_ilock(ip, XFS_IOLOCK_SHARED);
> -	ret = iomap_dio_rw(iocb, to, &xfs_iomap_ops, NULL);
> +	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL);
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
>  
>  	return ret;
> @@ -215,7 +215,7 @@ xfs_file_dax_read(
>  		xfs_ilock(ip, XFS_IOLOCK_SHARED);
>  	}
>  
> -	ret = dax_iomap_rw(iocb, to, &xfs_iomap_ops);
> +	ret = dax_iomap_rw(iocb, to, &xfs_read_iomap_ops);
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
>  
>  	file_accessed(iocb->ki_filp);
> @@ -1156,7 +1156,9 @@ __xfs_filemap_fault(
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
> index a9f9e8c9034a..0cfd973fd192 100644
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
> index fe285d123d69..9c448a54a951 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1114,7 +1114,7 @@ xfs_vn_fiemap(
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
