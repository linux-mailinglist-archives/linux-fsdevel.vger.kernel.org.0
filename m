Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 710C5CFDA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 17:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfJHPaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 11:30:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52170 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfJHPaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:30:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98FSugE141369;
        Tue, 8 Oct 2019 15:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Q5nz16JND+vLq217iJkuJP06Xl0/0MYQ4geI7Q7v+ls=;
 b=eLN6H9d3fJTGnXGVpL1hMFSbJOwCOPPMksrgtzmtobAPWNZmB9AeaRmoBOpVZCqE4g1D
 CmoGuQtQVHcUsOb7WsRSVN3BhWeDr7dvOlG1ac5g9a53KiXPcBpmSWqGxqwjQxDRjDBU
 lYLhUvmSnutWMmj/QoL8vChZ7OCfP1H1mBIWJzPXgy/CxZffsOH3eavRK/U+1FI7jd3/
 xLrCIaG/SouHEU28nylmxAYps0n2+22delyBvg9gfBXJs5O1APuzmUv+5GdY7jEbwv7E
 HR/xqWWQPI75kZEda1SjKyQHxQ3iXicsSW249AvxPxS93POsWjTdDfcGDHmtZx+qs7tw aw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vejkue4jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 15:29:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98FTfK4179101;
        Tue, 8 Oct 2019 15:29:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vg206j6wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 15:29:55 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x98FSgLJ018843;
        Tue, 8 Oct 2019 15:28:42 GMT
Received: from localhost (/10.159.136.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 08:28:42 -0700
Date:   Tue, 8 Oct 2019 08:28:41 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/20] xfs: split the iomap ops for buffered vs direct
 writes
Message-ID: <20191008152841.GB13108@magnolia>
References: <20191008071527.29304-1-hch@lst.de>
 <20191008071527.29304-18-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008071527.29304-18-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080136
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 09:15:24AM +0200, Christoph Hellwig wrote:
> Instead of lots of magic conditionals in the main write_begin
> handler this make the intent very clear.  Thing will become even
> better once we support delayed allocations for extent size hints
> and realtime allocations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks the same as last time...right?
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_bmap_util.c |  3 ++-
>  fs/xfs/xfs_file.c      | 16 ++++++-----
>  fs/xfs/xfs_iomap.c     | 61 +++++++++++++++---------------------------
>  fs/xfs/xfs_iomap.h     |  3 ++-
>  fs/xfs/xfs_iops.c      |  4 +--
>  fs/xfs/xfs_reflink.c   |  5 ++--
>  6 files changed, 40 insertions(+), 52 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index 0910cb75b65d..a6831b7bdc18 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -1111,7 +1111,8 @@ xfs_free_file_space(
>  		return 0;
>  	if (offset + len > XFS_ISIZE(ip))
>  		len = XFS_ISIZE(ip) - offset;
> -	error = iomap_zero_range(VFS_I(ip), offset, len, NULL, &xfs_iomap_ops);
> +	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
> +			&xfs_buffered_write_iomap_ops);
>  	if (error)
>  		return error;
>  
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index f9814306ed8e..71ffab53a0fc 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -351,7 +351,7 @@ xfs_file_aio_write_checks(
>  	
>  		trace_xfs_zero_eof(ip, isize, iocb->ki_pos - isize);
>  		error = iomap_zero_range(inode, isize, iocb->ki_pos - isize,
> -				NULL, &xfs_iomap_ops);
> +				NULL, &xfs_buffered_write_iomap_ops);
>  		if (error)
>  			return error;
>  	} else
> @@ -547,7 +547,8 @@ xfs_file_dio_aio_write(
>  	}
>  
>  	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
> -	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops);
> +	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
> +			   &xfs_dio_write_ops);
>  
>  	/*
>  	 * If unaligned, this is the only IO in-flight. If it has not yet
> @@ -594,7 +595,7 @@ xfs_file_dax_write(
>  	count = iov_iter_count(from);
>  
>  	trace_xfs_file_dax_write(ip, count, pos);
> -	ret = dax_iomap_rw(iocb, from, &xfs_iomap_ops);
> +	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
>  	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
>  		i_size_write(inode, iocb->ki_pos);
>  		error = xfs_setfilesize(ip, pos, ret);
> @@ -641,7 +642,8 @@ xfs_file_buffered_aio_write(
>  	current->backing_dev_info = inode_to_bdi(inode);
>  
>  	trace_xfs_file_buffered_write(ip, iov_iter_count(from), iocb->ki_pos);
> -	ret = iomap_file_buffered_write(iocb, from, &xfs_iomap_ops);
> +	ret = iomap_file_buffered_write(iocb, from,
> +			&xfs_buffered_write_iomap_ops);
>  	if (likely(ret >= 0))
>  		iocb->ki_pos += ret;
>  
> @@ -1158,12 +1160,14 @@ __xfs_filemap_fault(
>  
>  		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
>  				(write_fault && !vmf->cow_page) ?
> -				 &xfs_iomap_ops : &xfs_read_iomap_ops);
> +				 &xfs_direct_write_iomap_ops :
> +				 &xfs_read_iomap_ops);
>  		if (ret & VM_FAULT_NEEDDSYNC)
>  			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
>  	} else {
>  		if (write_fault)
> -			ret = iomap_page_mkwrite(vmf, &xfs_iomap_ops);
> +			ret = iomap_page_mkwrite(vmf,
> +					&xfs_buffered_write_iomap_ops);
>  		else
>  			ret = filemap_fault(vmf);
>  	}
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index a6a03b65c4e7..5a7499f88673 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -719,16 +719,7 @@ xfs_ilock_for_iomap(
>  }
>  
>  static int
> -xfs_file_iomap_begin_delay(
> -	struct inode		*inode,
> -	loff_t			offset,
> -	loff_t			count,
> -	unsigned		flags,
> -	struct iomap		*iomap,
> -	struct iomap		*srcmap);
> -
> -static int
> -xfs_file_iomap_begin(
> +xfs_direct_write_iomap_begin(
>  	struct inode		*inode,
>  	loff_t			offset,
>  	loff_t			length,
> @@ -751,13 +742,6 @@ xfs_file_iomap_begin(
>  	if (XFS_FORCED_SHUTDOWN(mp))
>  		return -EIO;
>  
> -	if (!(flags & IOMAP_DIRECT) && !IS_DAX(inode) &&
> -	    !xfs_get_extsz_hint(ip)) {
> -		/* Reserve delalloc blocks for regular writeback. */
> -		return xfs_file_iomap_begin_delay(inode, offset, length, flags,
> -				iomap, srcmap);
> -	}
> -
>  	/*
>  	 * Lock the inode in the manner required for the specified operation and
>  	 * check for as many conditions that would result in blocking as
> @@ -857,8 +841,12 @@ xfs_file_iomap_begin(
>  	return error;
>  }
>  
> +const struct iomap_ops xfs_direct_write_iomap_ops = {
> +	.iomap_begin		= xfs_direct_write_iomap_begin,
> +};
> +
>  static int
> -xfs_file_iomap_begin_delay(
> +xfs_buffered_write_iomap_begin(
>  	struct inode		*inode,
>  	loff_t			offset,
>  	loff_t			count,
> @@ -877,8 +865,12 @@ xfs_file_iomap_begin_delay(
>  	int			whichfork = XFS_DATA_FORK;
>  	int			error = 0;
>  
> +	/* we can't use delayed allocations when using extent size hints */
> +	if (xfs_get_extsz_hint(ip))
> +		return xfs_direct_write_iomap_begin(inode, offset, count,
> +				flags, iomap, srcmap);
> +
>  	ASSERT(!XFS_IS_REALTIME_INODE(ip));
> -	ASSERT(!xfs_get_extsz_hint(ip));
>  
>  	xfs_ilock(ip, XFS_ILOCK_EXCL);
>  
> @@ -1070,18 +1062,23 @@ xfs_file_iomap_begin_delay(
>  }
>  
>  static int
> -xfs_file_iomap_end_delalloc(
> -	struct xfs_inode	*ip,
> +xfs_buffered_write_iomap_end(
> +	struct inode		*inode,
>  	loff_t			offset,
>  	loff_t			length,
>  	ssize_t			written,
> +	unsigned		flags,
>  	struct iomap		*iomap)
>  {
> +	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
>  	xfs_fileoff_t		start_fsb;
>  	xfs_fileoff_t		end_fsb;
>  	int			error = 0;
>  
> +	if (iomap->type != IOMAP_DELALLOC)
> +		return 0;
> +
>  	/*
>  	 * Behave as if the write failed if drop writes is enabled. Set the NEW
>  	 * flag to force delalloc cleanup.
> @@ -1126,25 +1123,9 @@ xfs_file_iomap_end_delalloc(
>  	return 0;
>  }
>  
> -static int
> -xfs_file_iomap_end(
> -	struct inode		*inode,
> -	loff_t			offset,
> -	loff_t			length,
> -	ssize_t			written,
> -	unsigned		flags,
> -	struct iomap		*iomap)
> -{
> -	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) &&
> -	    iomap->type == IOMAP_DELALLOC)
> -		return xfs_file_iomap_end_delalloc(XFS_I(inode), offset,
> -				length, written, iomap);
> -	return 0;
> -}
> -
> -const struct iomap_ops xfs_iomap_ops = {
> -	.iomap_begin		= xfs_file_iomap_begin,
> -	.iomap_end		= xfs_file_iomap_end,
> +const struct iomap_ops xfs_buffered_write_iomap_ops = {
> +	.iomap_begin		= xfs_buffered_write_iomap_begin,
> +	.iomap_end		= xfs_buffered_write_iomap_end,
>  };
>  
>  static int
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index 61b1fc3e5143..7aed28275089 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -39,7 +39,8 @@ xfs_aligned_fsb_count(
>  	return count_fsb;
>  }
>  
> -extern const struct iomap_ops xfs_iomap_ops;
> +extern const struct iomap_ops xfs_buffered_write_iomap_ops;
> +extern const struct iomap_ops xfs_direct_write_iomap_ops;
>  extern const struct iomap_ops xfs_read_iomap_ops;
>  extern const struct iomap_ops xfs_seek_iomap_ops;
>  extern const struct iomap_ops xfs_xattr_iomap_ops;
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 9c448a54a951..329a34af8e79 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -883,10 +883,10 @@ xfs_setattr_size(
>  	if (newsize > oldsize) {
>  		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
>  		error = iomap_zero_range(inode, oldsize, newsize - oldsize,
> -				&did_zeroing, &xfs_iomap_ops);
> +				&did_zeroing, &xfs_buffered_write_iomap_ops);
>  	} else {
>  		error = iomap_truncate_page(inode, newsize, &did_zeroing,
> -				&xfs_iomap_ops);
> +				&xfs_buffered_write_iomap_ops);
>  	}
>  
>  	if (error)
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 19a6e4644123..1e18b4024b82 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1270,7 +1270,7 @@ xfs_reflink_zero_posteof(
>  
>  	trace_xfs_zero_eof(ip, isize, pos - isize);
>  	return iomap_zero_range(VFS_I(ip), isize, pos - isize, NULL,
> -			&xfs_iomap_ops);
> +			&xfs_buffered_write_iomap_ops);
>  }
>  
>  /*
> @@ -1527,7 +1527,8 @@ xfs_reflink_unshare(
>  
>  	inode_dio_wait(inode);
>  
> -	error = iomap_file_unshare(inode, offset, len, &xfs_iomap_ops);
> +	error = iomap_file_unshare(inode, offset, len,
> +			&xfs_buffered_write_iomap_ops);
>  	if (error)
>  		goto out;
>  	error = filemap_write_and_wait(inode->i_mapping);
> -- 
> 2.20.1
> 
