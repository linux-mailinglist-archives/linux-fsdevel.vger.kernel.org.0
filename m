Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C8F27960A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 03:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgIZBvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 21:51:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40296 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZBvX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 21:51:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08Q1ouXR030859;
        Sat, 26 Sep 2020 01:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=tfFEliKo43rTqNqu7fIFYaGiplpA2RDja1HLwapDm1s=;
 b=xjyFcPvmJWv9yLixeDq0CV9ZWY4uzdHy/Fy1zriZec8uSc19litmJVzg9U1EfjMi4VhI
 AtzXMfAW/H+QkUvJPwHB/Ti6hX/pkIdMC5HK1yK4frPQHeDpXSO/RZnDpaddwuXJ/+D7
 uI8MxSiM4OwlWOGKnGzzCjtrctL2KB7BUJVkAMrna/8uHcWex6GYRaRbD8em0X408uL0
 s0um6Fc7VlSyobJ0xLzlSqiaS6LlybtbSDcKfHhQWpFfHPLOxl4MNO107GTmcUt9yZ4r
 EwsV3jhvCD6Hk5BItYhfy9kR2AZlpa6rrvjrVLtBmL+lO8dph/YLcln6GAkYHm2f8321 +Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33ndnv0b0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 26 Sep 2020 01:51:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08Q1oEiv052880;
        Sat, 26 Sep 2020 01:51:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33r2901dva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Sep 2020 01:51:11 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08Q1pAon024814;
        Sat, 26 Sep 2020 01:51:10 GMT
Received: from localhost (/10.159.232.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 18:51:09 -0700
Date:   Fri, 25 Sep 2020 18:51:08 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, hch@lst.de, johannes.thumshirn@wdc.com,
        dsterba@suse.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/14] iomap: Call inode_dio_end() before
 generic_write_sync()
Message-ID: <20200926015108.GQ7964@magnolia>
References: <20200924163922.2547-1-rgoldwyn@suse.de>
 <20200924163922.2547-5-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924163922.2547-5-rgoldwyn@suse.de>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=1 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009260012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9755 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=1 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009260012
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 11:39:11AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> iomap complete routine can deadlock with btrfs_fallocate because of the
> call to generic_write_sync().
> 
> P0                      P1
> inode_lock()            fallocate(FALLOC_FL_ZERO_RANGE)
> __iomap_dio_rw()        inode_lock()
>                         <block>
> <submits IO>
> <completes IO>
> inode_unlock()
>                         <gets inode_lock()>
>                         inode_dio_wait()
> iomap_dio_complete()
>   generic_write_sync()
>     btrfs_file_fsync()
>       inode_lock()
>       <deadlock>
> 
> inode_dio_end() is used to notify the end of DIO data in order
> to synchronize with truncate. Call inode_dio_end() before calling
> generic_write_sync(), so filesystems can lock i_rwsem during a sync.
> 
> This matches the way it is done in fs/direct-io.c:dio_complete().
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Looks ok (at least with the fses that use either iomap or ye olde
directio) to me...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

So, uh, do you want me to pull these two iomap patches in for 5.10?

--D

> ---
>  fs/iomap/direct-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index b88dbfe15118..0ea88ae57cb2 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -118,6 +118,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  			dio_warn_stale_pagecache(iocb->ki_filp);
>  	}
>  
> +	inode_dio_end(file_inode(iocb->ki_filp));
>  	/*
>  	 * If this is a DSYNC write, make sure we push it to stable storage now
>  	 * that we've written data.
> @@ -125,7 +126,6 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  	if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
>  		ret = generic_write_sync(iocb, ret);
>  
> -	inode_dio_end(file_inode(iocb->ki_filp));
>  	kfree(dio);
>  
>  	return ret;
> -- 
> 2.26.2
> 
