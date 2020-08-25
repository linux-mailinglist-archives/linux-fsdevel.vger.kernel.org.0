Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BD3252239
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 22:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHYUwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 16:52:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49864 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYUwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:52:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PKipJV156187;
        Tue, 25 Aug 2020 20:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=auC1QONwDp3dgkmIBt9CYKiGBVa5ZJTSWe0A2XEhlOg=;
 b=jroyZo4/g0Ix8rW8adNAhTYqRd7Lxv3X8YrSWiyjBdtsB5IlyHpukUBF1A8S/ef70uk5
 m1qQOLHOqR3GOk5N1fN5gK6PQOMpPtK3sMUbhGVEVOYeTatjz5Z5esXD3ul5sX30TI+M
 vLaD7uV8LRKjIA54bybx6/XYTe3GKUyGWJky4JlNVSCtOlYmikxcceES60hJoiOZlZG2
 EugiHtQFnDDJOeasZ3m+LUzAQcmPBlP3LIh24cRawh2me07iTXsmNHmL23BUDrvkFwco
 mX7g0LlIzy5vjPcLB4ZhAwEiGWSjIZXvuHXVpMbHzTTUCM0Q7QkPWNtNQYCFI33hFung FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 333csj4xj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 20:52:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PKinCo171916;
        Tue, 25 Aug 2020 20:50:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 333r9kc0fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 20:50:36 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07PKoadf021420;
        Tue, 25 Aug 2020 20:50:36 GMT
Received: from localhost (/10.159.234.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Aug 2020 13:50:36 -0700
Date:   Tue, 25 Aug 2020 13:50:34 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/9] iomap: Use bitmap ops to set uptodate bits
Message-ID: <20200825205034.GI6096@magnolia>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-5-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=1 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250157
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 03:55:05PM +0100, Matthew Wilcox (Oracle) wrote:
> Now that the bitmap is protected by a spinlock, we can use the
> more efficient bitmap ops instead of individual test/set bit ops.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Yay!
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 639d54a4177e..dbf9572dabe9 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -134,19 +134,11 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>  	struct inode *inode = page->mapping->host;
>  	unsigned first = off >> inode->i_blkbits;
>  	unsigned last = (off + len - 1) >> inode->i_blkbits;
> -	bool uptodate = true;
>  	unsigned long flags;
> -	unsigned int i;
>  
>  	spin_lock_irqsave(&iop->uptodate_lock, flags);
> -	for (i = 0; i < i_blocks_per_page(inode, page); i++) {
> -		if (i >= first && i <= last)
> -			set_bit(i, iop->uptodate);
> -		else if (!test_bit(i, iop->uptodate))
> -			uptodate = false;
> -	}
> -
> -	if (uptodate)
> +	bitmap_set(iop->uptodate, first, last - first + 1);
> +	if (bitmap_full(iop->uptodate, i_blocks_per_page(inode, page)))
>  		SetPageUptodate(page);
>  	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
>  }
> -- 
> 2.28.0
> 
