Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE0B1E7137
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 02:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438010AbgE2AXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 20:23:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56008 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437753AbgE2AX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 20:23:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04T0HfC6099027;
        Fri, 29 May 2020 00:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=q7Ts2vW9CbyvWnZilonR6KghPQweI+5CHmTJ3scB5sU=;
 b=MV3CjMKVTdIciCt2OyiPVXCUzApRQmF8uGfgUEMI8ym7mPr9YremyWDzxTUPtJsOEuyQ
 YcT6cirqzUdrWuVWiAxt4g0Mazqdpp7xtPK7NzeH6Ul451MGz0V+9uXXuI9Gejywz495
 38Xr7YDIfVmzaqGDo98ScDKDsx1Nfw4B//YwdjUd+r2rg1pGd+kdq1GHWGBGf47Ck6H/
 //gnBvuh5mn+wKhsJWG/CxmZPBX37q/+FtrcBw3X0L7Kq9zEFK5KY5wGy1rFFkPvDk98
 zlE0UP/DnObNgLpUD74ASli4jMEr2qA0Ftab1NHCf3BLYr/ZbFQnEnRxRdhB/XLbzO5z 8g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 316u8r7tjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 00:23:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04T0J82I059161;
        Fri, 29 May 2020 00:23:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 317ddtmmfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 May 2020 00:23:21 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04T0NK3a010650;
        Fri, 29 May 2020 00:23:20 GMT
Received: from localhost (/10.159.250.122)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 May 2020 17:23:20 -0700
Date:   Thu, 28 May 2020 17:23:19 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Johannes.Thumshirn@wdc.com, hch@infradead.org, dsterba@suse.cz,
        fdmanana@gmail.com
Subject: Re: [PATCH] iomap: Return zero in case of unsuccessful pagecache
 invalidation before DIO
Message-ID: <20200529002319.GQ252930@magnolia>
References: <20200528192103.xm45qoxqmkw7i5yl@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528192103.xm45qoxqmkw7i5yl@fiona>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=5 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 suspectscore=5
 phishscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 02:21:03PM -0500, Goldwyn Rodrigues wrote:
> 
> Filesystems such as btrfs are unable to guarantee page invalidation
> because pages could be locked as a part of the extent. Return zero

Locked for what?  filemap_write_and_wait_range should have just cleaned
them off.

> in case a page cache invalidation is unsuccessful so filesystems can
> fallback to buffered I/O. This is similar to
> generic_file_direct_write().
> 
> This takes care of the following invalidation warning during btrfs
> mixed buffered and direct I/O using iomap_dio_rw():
> 
> Page cache invalidation failure on direct I/O.  Possible data
> corruption due to collision with buffered I/O!
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index e4addfc58107..215315be6233 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -483,9 +483,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	 */
>  	ret = invalidate_inode_pages2_range(mapping,
>  			pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> -	if (ret)
> -		dio_warn_stale_pagecache(iocb->ki_filp);
> -	ret = 0;
> +	/*
> +	 * If a page can not be invalidated, return 0 to fall back
> +	 * to buffered write.
> +	 */
> +	if (ret) {
> +		if (ret == -EBUSY)
> +			ret = 0;
> +		goto out_free_dio;

XFS doesn't fall back to buffered io when directio fails, which means
this will cause a regression there.

Granted mixing write types is bogus...

--D

> +	}
>  
>  	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
>  	    !inode->i_sb->s_dio_done_wq) {
> 
> -- 
> Goldwyn
