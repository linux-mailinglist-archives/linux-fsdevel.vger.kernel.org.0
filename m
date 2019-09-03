Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AABCDA6BC2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 16:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfICOq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 10:46:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51668 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICOq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:46:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83EiP6p126612;
        Tue, 3 Sep 2019 14:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=21BM/9yHmlJT8xTxjIp4TcPp8l3pTDXDNo0NbefEYw4=;
 b=OjWQuRT4yJAZafQR3w2lROdHEOuL66K13PkbJrfGwvgnyv667/qBIuXKBOtRSntLbpWG
 KrZu95g+NeWCY0macYDIJDTKu12/vzuO4uha/EhFyRpTXwcFdPweiMFa83Oy7074GMIS
 bMjX9aomlT1foPp0w4eYcYtT366MdmswWAFXpLDEILKvuU/P3TIrvOfJ1rYFyMExq03R
 FQinb5WjnOPEEkOSIUrXQVRGhqHjexRhoUIof82Y9kSupayFI3ReHBI6GA3bE8Se69y9
 QzlTAnR9+zwNWMbQ9Wr0yZa2Vwtma7z6XUBA61THOS++f778A3MuyBsiSEO2vBVtWVCF Lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2ussx904yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 14:46:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83EhNVf144250;
        Tue, 3 Sep 2019 14:46:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2usk7dwk22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 14:46:21 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83EkJd7016572;
        Tue, 3 Sep 2019 14:46:20 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Sep 2019 07:46:19 -0700
Date:   Tue, 3 Sep 2019 07:46:22 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 2/2] iomap: move the iomap_dio_rw ->end_io callback into
 a structure
Message-ID: <20190903144622.GY5354@magnolia>
References: <20190903130327.6023-1-hch@lst.de>
 <20190903130327.6023-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903130327.6023-3-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9368 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9368 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030155
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 03:03:27PM +0200, Christoph Hellwig wrote:
> Add a new iomap_dio_ops structure that for now just contains the end_io
> handler.  This avoid storing the function pointer in a mutable structure,
> which is a possible exploit vector for kernel code execution, and prepares
> for adding a submit_io handler that btrfs needs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/direct-io.c  | 21 ++++++++++-----------
>  fs/xfs/xfs_file.c     |  6 +++++-
>  include/linux/iomap.h | 10 +++++++---
>  3 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 2ccf1c6460d4..1fc28c2da279 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -24,7 +24,7 @@
>  
>  struct iomap_dio {
>  	struct kiocb		*iocb;
> -	iomap_dio_end_io_t	*end_io;
> +	const struct iomap_dio_ops *dops;
>  	loff_t			i_size;
>  	loff_t			size;
>  	atomic_t		ref;
> @@ -72,15 +72,14 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
>  
>  static ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  {
> +	const struct iomap_dio_ops *dops = dio->dops;
>  	struct kiocb *iocb = dio->iocb;
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	loff_t offset = iocb->ki_pos;
> -	ssize_t ret;
> +	ssize_t ret = dio->error;
>  
> -	if (dio->end_io)
> -		ret = dio->end_io(iocb, dio->size, dio->error, dio->flags);
> -	else
> -		ret = dio->error;
> +	if (dops && dops->end_io)
> +		ret = dops->end_io(iocb, dio->size, ret, dio->flags);
>  
>  	if (likely(!ret)) {
>  		ret = dio->size;
> @@ -98,9 +97,9 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  	 * one is a pretty crazy thing to do, so we don't support it 100%.  If
>  	 * this invalidation fails, tough, the write still worked...
>  	 *
> -	 * And this page cache invalidation has to be after dio->end_io(), as
> -	 * some filesystems convert unwritten extents to real allocations in
> -	 * end_io() when necessary, otherwise a racing buffer read would cache
> +	 * And this page cache invalidation has to be after ->end_io(), as some
> +	 * filesystems convert unwritten extents to real allocations in
> +	 * ->end_io() when necessary, otherwise a racing buffer read would cache
>  	 * zeros from unwritten extents.
>  	 */
>  	if (!dio->error &&
> @@ -393,7 +392,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
>   */
>  ssize_t
>  iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> -		const struct iomap_ops *ops, iomap_dio_end_io_t end_io)
> +		const struct iomap_ops *ops, const struct iomap_dio_ops *dops)
>  {
>  	struct address_space *mapping = iocb->ki_filp->f_mapping;
>  	struct inode *inode = file_inode(iocb->ki_filp);
> @@ -418,7 +417,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	atomic_set(&dio->ref, 1);
>  	dio->size = 0;
>  	dio->i_size = i_size_read(inode);
> -	dio->end_io = end_io;
> +	dio->dops = dops;
>  	dio->error = 0;
>  	dio->flags = 0;
>  
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 3d8e6db9ef77..1ffb179f35d2 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -443,6 +443,10 @@ xfs_dio_write_end_io(
>  	return error;
>  }
>  
> +static const struct iomap_dio_ops xfs_dio_write_ops = {
> +	.end_io		= xfs_dio_write_end_io,
> +};
> +
>  /*
>   * xfs_file_dio_aio_write - handle direct IO writes
>   *
> @@ -543,7 +547,7 @@ xfs_file_dio_aio_write(
>  	}
>  
>  	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
> -	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, xfs_dio_write_end_io);
> +	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops);
>  
>  	/*
>  	 * If unaligned, this is the only IO in-flight. If it has not yet
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 50bb746d2216..7aa5d6117936 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -188,10 +188,14 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
>   */
>  #define IOMAP_DIO_UNWRITTEN	(1 << 0)	/* covers unwritten extent(s) */
>  #define IOMAP_DIO_COW		(1 << 1)	/* covers COW extent(s) */
> -typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t size, int error,
> -				 unsigned int flags);
> +
> +struct iomap_dio_ops {
> +	int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
> +		      unsigned flags);
> +};
> +
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> -		const struct iomap_ops *ops, iomap_dio_end_io_t end_io);
> +		const struct iomap_ops *ops, const struct iomap_dio_ops *dops);
>  int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
>  
>  #ifdef CONFIG_SWAP
> -- 
> 2.20.1
> 
