Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19FEC111D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 05:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfEBDTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 23:19:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34238 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfEBDTc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 23:19:32 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x423A2LX123407;
        Thu, 2 May 2019 03:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=2493aj9eAFUSolLRq5wu7qZnhNz2tGnrVP07Q1j7Pfs=;
 b=Cev4onefGVYui8ZUvgh1LQNh1yqH0uPsv5bKcm6oYeIkb4l1VmG4wMavnaUQpjH2rC7y
 gUCFpDNFT4vwYFnSYU/AQIRO3jxOiZgawdAe6jA+DDtl1xs34rdXDNpHhdNUzQ1FFtX+
 XrnZStcm85Tc9MBLDq2F58ImGepSS7smEEZv4cSwet1G+/O/HDt0/vjb0vJBGokEZNZt
 cVQx1E6604MYky5xjyFXttyyE7j1d0yTiJK+2aiFWDrztxhs8my6bWVOw/UeCbjgC1tI
 UzNc0pNyVlAEMHaN9cCO/IO6rQk+sjLlNAHiI12QHlUYCFj2xhD+0nDRRSt4pxF82tr4 Lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2s6xhydvej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 May 2019 03:19:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x423J9Sv064932;
        Thu, 2 May 2019 03:19:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2s6xhgtpj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 May 2019 03:19:16 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x423JDaX016405;
        Thu, 2 May 2019 03:19:13 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 May 2019 20:19:13 -0700
Date:   Wed, 1 May 2019 20:19:12 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     agruenba@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: move iomap_read_inline_data around
Message-ID: <20190502031912.GH5200@magnolia>
References: <20190501161111.32475-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501161111.32475-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905020024
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905020024
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 01, 2019 at 12:11:11PM -0400, Christoph Hellwig wrote:
> iomap_read_inline_data ended up being placed in the middle of the bio
> based read I/O completion handling, which tends to confuse the heck out
> of me whenever I follow the code.  Move it to a more suitable place.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/iomap.c b/fs/iomap.c
> index fbfe20b7f6f0..9ef049d61e8a 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -240,26 +240,6 @@ iomap_read_page_end_io(struct bio_vec *bvec, int error)
>  	iomap_read_finish(iop, page);
>  }
>  
> -static void
> -iomap_read_inline_data(struct inode *inode, struct page *page,
> -		struct iomap *iomap)
> -{
> -	size_t size = i_size_read(inode);
> -	void *addr;
> -
> -	if (PageUptodate(page))
> -		return;
> -
> -	BUG_ON(page->index);
> -	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> -
> -	addr = kmap_atomic(page);
> -	memcpy(addr, iomap->inline_data, size);
> -	memset(addr + size, 0, PAGE_SIZE - size);
> -	kunmap_atomic(addr);
> -	SetPageUptodate(page);
> -}
> -
>  static void
>  iomap_read_end_io(struct bio *bio)
>  {
> @@ -281,6 +261,26 @@ struct iomap_readpage_ctx {
>  	struct list_head	*pages;
>  };
>  
> +static void
> +iomap_read_inline_data(struct inode *inode, struct page *page,
> +		struct iomap *iomap)
> +{
> +	size_t size = i_size_read(inode);
> +	void *addr;
> +
> +	if (PageUptodate(page))
> +		return;
> +
> +	BUG_ON(page->index);
> +	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +
> +	addr = kmap_atomic(page);
> +	memcpy(addr, iomap->inline_data, size);
> +	memset(addr + size, 0, PAGE_SIZE - size);
> +	kunmap_atomic(addr);
> +	SetPageUptodate(page);
> +}
> +
>  static loff_t
>  iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		struct iomap *iomap)
> -- 
> 2.20.1
> 
