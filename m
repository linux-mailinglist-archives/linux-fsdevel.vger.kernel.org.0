Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01896A6BBC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 16:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfICOom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 10:44:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49648 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfICOom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:44:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83EiJc8126556;
        Tue, 3 Sep 2019 14:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=DGZ0Ams3rJ7t8wNRWOTGIli9HNjd9r48MN7ex/MQzpk=;
 b=VN3jyUyYXcthOGnSxc0RLGSo4jj068qlk0ceHrV4/D7+fg0wWJB1Tpyz2s6yLD2ATP9f
 4FGN2i5/Q0RLXqYWZoZH96NBOyr0SHWu2MV8WWeCRRfn/j/ChuFXuCHSCWL+0p5Glt58
 BH/y7vHBXmbRVAnEpofMCGq2NKAzQpIjlq8y1hcthw+AUcIaUcd+jVbQ6hTKwZBZeJD8
 m8bBl9PgBTXmY+Ib75vFe4Rp8q74r+GyAG04JNTwdZnGD+mKCjL5bLhn1aG19EWzQXd8
 W6nzeNU7J0z6T6SPXPd1OnfeQ/2vELXq3KLdqmxPh7YlgLrS1zuv+UNyjkllZLBhcAJk BA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ussx904m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 14:44:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83EgddK155113;
        Tue, 3 Sep 2019 14:44:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2us5pgxct4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 14:44:33 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83EiVXK015308;
        Tue, 3 Sep 2019 14:44:31 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Sep 2019 07:44:30 -0700
Date:   Tue, 3 Sep 2019 07:44:33 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 1/2] iomap: split size and error for iomap_dio_rw ->end_io
Message-ID: <20190903144433.GX5354@magnolia>
References: <20190903130327.6023-1-hch@lst.de>
 <20190903130327.6023-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903130327.6023-2-hch@lst.de>
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

On Tue, Sep 03, 2019 at 03:03:26PM +0200, Christoph Hellwig wrote:
> From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> 
> Modify the calling convention for the iomap_dio_rw ->end_io() callback.
> Rather than passing either dio->error or dio->size as the 'size' argument,
> instead pass both the dio->error and the dio->size value separately.
> 
> In the instance that an error occurred during a write, we currently cannot
> determine whether any blocks have been allocated beyond the current EOF and
> data has subsequently been written to these blocks within the ->end_io()
> callback. As a result, we cannot judge whether we should take the truncate
> failed write path. Having both dio->error and dio->size will allow us to
> perform such checks within this callback.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> [hch: minor cleanups]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/direct-io.c  | 9 +++------
>  fs/xfs/xfs_file.c     | 8 +++++---
>  include/linux/iomap.h | 4 ++--
>  3 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 10517cea9682..2ccf1c6460d4 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -77,13 +77,10 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  	loff_t offset = iocb->ki_pos;
>  	ssize_t ret;
>  
> -	if (dio->end_io) {
> -		ret = dio->end_io(iocb,
> -				dio->error ? dio->error : dio->size,
> -				dio->flags);
> -	} else {
> +	if (dio->end_io)
> +		ret = dio->end_io(iocb, dio->size, dio->error, dio->flags);
> +	else
>  		ret = dio->error;
> -	}
>  
>  	if (likely(!ret)) {
>  		ret = dio->size;
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index d952d5962e93..3d8e6db9ef77 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -370,21 +370,23 @@ static int
>  xfs_dio_write_end_io(
>  	struct kiocb		*iocb,
>  	ssize_t			size,
> +	int			error,
>  	unsigned		flags)
>  {
>  	struct inode		*inode = file_inode(iocb->ki_filp);
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	loff_t			offset = iocb->ki_pos;
>  	unsigned int		nofs_flag;
> -	int			error = 0;
>  
>  	trace_xfs_end_io_direct_write(ip, offset, size);
>  
>  	if (XFS_FORCED_SHUTDOWN(ip->i_mount))
>  		return -EIO;
>  
> -	if (size <= 0)
> -		return size;
> +	if (error)
> +		return error;
> +	if (!size)
> +		return 0;
>  
>  	/*
>  	 * Capture amount written on completion as we can't reliably account
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index bc499ceae392..50bb746d2216 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -188,8 +188,8 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
>   */
>  #define IOMAP_DIO_UNWRITTEN	(1 << 0)	/* covers unwritten extent(s) */
>  #define IOMAP_DIO_COW		(1 << 1)	/* covers COW extent(s) */
> -typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t ret,
> -		unsigned flags);
> +typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t size, int error,
> +				 unsigned int flags);
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, iomap_dio_end_io_t end_io);
>  int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
> -- 
> 2.20.1
> 
