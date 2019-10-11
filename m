Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1D22D442A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 17:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfJKP2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 11:28:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59650 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfJKP2m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:28:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BFNfwC096791;
        Fri, 11 Oct 2019 15:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=QEOfw2wo0NK2ZyZKht2qMAqECorh+bD/BvtGru6FGfo=;
 b=esESY4u0ly2eRIPE7rKUf4fTxpgqpYvqGEk5f/cUGpUb+OwvrcVydIs1gvU4235KRvfe
 zK4QCKVPZFx5rzUjyQvc40f5HeZ+y3LkyW9qrbHqU3P/fYlMFaUbknWS0fRmbBfoN+f7
 VGObfcapzOOMvFbB3J2FfgzvLIQpksjeYYJyq0/dHnIDrcVpg+COsMPY6ugsa63n2+Lg
 N9UwXgOyq5mT4FkOyLavQmfpnGyUZ5ks2yFIxM8rJcJKBQtWIBU4ezqr1OZbIMuQ1A79
 9J0QUr3hUhkCAqdP/EqpMnO5j9EXvAEhPSvH4WzcnkgMI8nKyexc3oA7EqXr/qTs26Th JA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vejkv2fxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 15:28:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BFOEJ8071554;
        Fri, 11 Oct 2019 15:28:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vjryccw3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 15:28:30 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9BFSSUq030165;
        Fri, 11 Oct 2019 15:28:29 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Oct 2019 08:28:28 -0700
Date:   Fri, 11 Oct 2019 08:28:21 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 1/2] iomap: Allow forcing of waiting for running DIO in
 iomap_dio_rw()
Message-ID: <20191011152821.GJ13108@magnolia>
References: <20191011125520.11697-1-jack@suse.cz>
 <20191011141433.18354-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011141433.18354-1-jack@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9406 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910110143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9406 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910110143
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 04:14:31PM +0200, Jan Kara wrote:
> Filesystems do not support doing IO as asynchronous in some cases. For
> example in case of unaligned writes or in case file size needs to be
> extended (e.g. for ext4). Instead of forcing filesystem to wait for AIO
> in such cases, add argument to iomap_dio_rw() which makes the function
> wait for IO completion. This also results in executing
> iomap_dio_complete() inline in iomap_dio_rw() providing its return value
> to the caller as for ordinary sync IO.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/gfs2/file.c        | 6 ++++--
>  fs/iomap/direct-io.c  | 7 +++++--
>  fs/xfs/xfs_file.c     | 5 +++--
>  include/linux/iomap.h | 3 ++-
>  4 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 997b326247e2..f0caee2b7c00 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -732,7 +732,8 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to)
>  	if (ret)
>  		goto out_uninit;
>  
> -	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL);
> +	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
> +			   is_sync_kiocb(iocb));
>  
>  	gfs2_glock_dq(&gh);
>  out_uninit:
> @@ -767,7 +768,8 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  	if (offset + len > i_size_read(&ip->i_inode))
>  		goto out;
>  
> -	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL);
> +	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
> +			   is_sync_kiocb(iocb));
>  
>  out:
>  	gfs2_glock_dq(&gh);
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 1fc28c2da279..1bfa0993f705 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -392,7 +392,8 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
>   */
>  ssize_t
>  iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> -		const struct iomap_ops *ops, const struct iomap_dio_ops *dops)
> +		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> +		bool wait_for_completion)
>  {
>  	struct address_space *mapping = iocb->ki_filp->f_mapping;
>  	struct inode *inode = file_inode(iocb->ki_filp);
> @@ -400,7 +401,6 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	loff_t pos = iocb->ki_pos, start = pos;
>  	loff_t end = iocb->ki_pos + count - 1, ret = 0;
>  	unsigned int flags = IOMAP_DIRECT;
> -	bool wait_for_completion = is_sync_kiocb(iocb);
>  	struct blk_plug plug;
>  	struct iomap_dio *dio;
>  
> @@ -409,6 +409,9 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	if (!count)
>  		return 0;
>  
> +	if (WARN_ON(is_sync_kiocb(iocb) && !wait_for_completion))
> +		return -EINVAL;

So far in iomap we've been returning EIO when someone internal screws
up, which (AFAICT) is the case here.

Other than that, the rest of the changes look ok.

--D

> +
>  	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
>  	if (!dio)
>  		return -ENOMEM;
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 1ffb179f35d2..0739ba72a82e 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -188,7 +188,7 @@ xfs_file_dio_aio_read(
>  	file_accessed(iocb->ki_filp);
>  
>  	xfs_ilock(ip, XFS_IOLOCK_SHARED);
> -	ret = iomap_dio_rw(iocb, to, &xfs_iomap_ops, NULL);
> +	ret = iomap_dio_rw(iocb, to, &xfs_iomap_ops, NULL, is_sync_kiocb(iocb));
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
>  
>  	return ret;
> @@ -547,7 +547,8 @@ xfs_file_dio_aio_write(
>  	}
>  
>  	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
> -	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops);
> +	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops,
> +			   is_sync_kiocb(iocb));
>  
>  	/*
>  	 * If unaligned, this is the only IO in-flight. If it has not yet
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 7aa5d6117936..76b14cb729dc 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -195,7 +195,8 @@ struct iomap_dio_ops {
>  };
>  
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> -		const struct iomap_ops *ops, const struct iomap_dio_ops *dops);
> +		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> +		bool wait_for_completion);
>  int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
>  
>  #ifdef CONFIG_SWAP
> -- 
> 2.16.4
> 
