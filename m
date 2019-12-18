Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64778123CC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 02:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLRB6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 20:58:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46130 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfLRB6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 20:58:00 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBI1sKpQ039809;
        Wed, 18 Dec 2019 01:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=15neapn3hexipdYPtu5c6du1j7tBf71ljZTqTLp/yK0=;
 b=iJejrBuoxC49PzOrv7wgVmtR8pKVwk5BP4lVklbYqjswXAz39Nd8KtfMf+SzSRk7x+dr
 0cAbrExT8Un1uODdNwoj0PuuHfTsRgPrnmVQcMv9Dus9S4eQrgOryU/vbg2JMwEOjSfI
 1mhX/uAzxcfCWp3QADsGL4/Pl4EPWdEDXZ549iW1NcImKPM34YSHESNYYBL+2GAb4Xu9
 jR1H5dLad3KVgnDq6fAfKpdSqEKvmTH4s/Fkb//gVP4W4Z1YCVjV4B/PmboBq9wBgKXa
 r3zbHJxYG7DbmBQAcmEfNX0k2pTcuWFz+BMdmYeH0dpQCcY65GmSsRN2gMN2N5oTDJIV Pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2wvrcrad1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 01:57:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBI1sAuJ061303;
        Wed, 18 Dec 2019 01:57:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wxm5p7r7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 01:57:49 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBI1vl7a007227;
        Wed, 18 Dec 2019 01:57:47 GMT
Received: from localhost (/10.159.137.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Dec 2019 17:57:47 -0800
Date:   Tue, 17 Dec 2019 17:57:46 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, '@magnolia
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com,
        torvalds@linux-foundation.org, david@fromorbit.com
Subject: Re: [PATCH 6/6] xfs: don't do delayed allocations for uncached
 buffered writes
Message-ID: <20191218015746.GB12752@magnolia>
References: <20191217143948.26380-1-axboe@kernel.dk>
 <20191217143948.26380-7-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217143948.26380-7-axboe@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912180014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=-1004
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912180014
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 07:39:48AM -0700, Jens Axboe wrote:
> This data is going to be written immediately, so don't bother trying
> to do delayed allocation for it.
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks reasonable once all the previous patches go in,

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_iomap.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 28e2d1f37267..d0cd4a05d59f 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -847,8 +847,11 @@ xfs_buffered_write_iomap_begin(
>  	int			allocfork = XFS_DATA_FORK;
>  	int			error = 0;
>  
> -	/* we can't use delayed allocations when using extent size hints */
> -	if (xfs_get_extsz_hint(ip))
> +	/*
> +	 * Don't do delayed allocations when using extent size hints, or
> +	 * if we were asked to do uncached buffered writes.
> +	 */
> +	if (xfs_get_extsz_hint(ip) || (flags & IOMAP_UNCACHED))
>  		return xfs_direct_write_iomap_begin(inode, offset, count,
>  				flags, iomap, srcmap);
>  
> -- 
> 2.24.1
> 
