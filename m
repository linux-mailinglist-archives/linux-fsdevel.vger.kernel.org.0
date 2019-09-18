Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2C5B6A27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 20:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfIRSAt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 14:00:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57166 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfIRSAt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:00:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHx4W6064591;
        Wed, 18 Sep 2019 18:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=yDBHQbGcmuVS41t4fS4zMXiDJwgfSGD1sCjF+5DJmD8=;
 b=pA3a4kDX1BKYfgIq2m3Yb5i4c0c3IGp47rLbWKAJM4H8/tqeFM9c0gdg8LIojCEDNklC
 hl+DvZN5YSwDJpNrwDxiJIFxIZBKPJdcC/D0MCibrOcgiOFN1//lAWZSNcPSEzKMRVcY
 m1QHH4wk+NlVyrwN6rfj1T/t5bSIlkFMTvsfCtnZGqWDe7hwEmv314UP7qzhon9oemDG
 9Fg7BA3jY+mur9s4RzQf8XOTgOvG/W0D/RqrsEbQIhjm2saDKq0Eydy9v63jrPJp2NV6
 uSX++auZZcRZhDK+BFId7D48dB1kDMSZVc4wBgh6XjnfiFtus0gGPiXr30yu6IsUDWWm GQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2v385e5kqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 18:00:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHcKvf172521;
        Wed, 18 Sep 2019 18:00:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2v37mn2h2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 18:00:43 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8II0gYt024479;
        Wed, 18 Sep 2019 18:00:42 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 11:00:41 -0700
Date:   Wed, 18 Sep 2019 11:00:37 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 16/19] xfs: split the iomap ops for buffered vs direct
 writes
Message-ID: <20190918180037.GI2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-17-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909180160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909180161
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 08:27:19PM +0200, Christoph Hellwig wrote:
> Instead of lots of magic conditionals in the main write_begin
> handler this make the intent very clear.  Thing will become even
> better once we support delayed allocations for extent size hints
> and realtime allocations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
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
> index 98c6a7a71427..a4a4813e9cc6 100644
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
> index d8e2e36b84f7..b2ea030485e9 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -350,7 +350,7 @@ xfs_file_aio_write_checks(
>  	
>  		trace_xfs_zero_eof(ip, isize, iocb->ki_pos - isize);
>  		error = iomap_zero_range(inode, isize, iocb->ki_pos - isize,
> -				NULL, &xfs_iomap_ops);
> +				NULL, &xfs_buffered_write_iomap_ops);
>  		if (error)
>  			return error;
>  	} else
> @@ -546,7 +546,8 @@ xfs_file_dio_aio_write(
>  	}
>  
>  	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
> -	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops);
> +	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
> +			   &xfs_dio_write_ops);
>  
>  	/*
>  	 * If unaligned, this is the only IO in-flight. If it has not yet
> @@ -593,7 +594,7 @@ xfs_file_dax_write(
>  	count = iov_iter_count(from);
>  
>  	trace_xfs_file_dax_write(ip, count, pos);
> -	ret = dax_iomap_rw(iocb, from, &xfs_iomap_ops);
> +	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
>  	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
>  		i_size_write(inode, iocb->ki_pos);
>  		error = xfs_setfilesize(ip, pos, ret);
> @@ -640,7 +641,8 @@ xfs_file_buffered_aio_write(
>  	current->backing_dev_info = inode_to_bdi(inode);
>  
>  	trace_xfs_file_buffered_write(ip, iov_iter_count(from), iocb->ki_pos);
> -	ret = iomap_file_buffered_write(iocb, from, &xfs_iomap_ops);
> +	ret = iomap_file_buffered_write(iocb, from,
> +			&xfs_buffered_write_iomap_ops);
>  	if (likely(ret >= 0))
>  		iocb->ki_pos += ret;
>  
> @@ -1133,12 +1135,14 @@ __xfs_filemap_fault(
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
> index 7ae55503ee27..6dd143374d75 100644
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
> index f0c7df82e18b..5c1154e761ca 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -882,10 +882,10 @@ xfs_setattr_size(
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
> index 673018a618f0..c68700c3a64a 100644
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
> @@ -1532,7 +1532,8 @@ xfs_reflink_unshare(
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
