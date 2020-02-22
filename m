Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF17C168B2A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 01:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgBVApI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 19:45:08 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57560 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgBVApI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:45:08 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01M0iXKo069490;
        Sat, 22 Feb 2020 00:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=RJWVxIQBtpVgLNZnOCgy+9DNBRETFyaw+B0IqQ80Smk=;
 b=nN7Sv9aAp1H5VNNHgY3l0Y8a6GkUkVAQwxYCK7nBY3u4+U0MhiP8X5I4zx8YknXK7zVO
 kSiV7uX0W1ht1ti0UCfB9WMesmmPQQNYMgrjYAKzWbu9+zDyk1QLFzxk2eXMBu12OgOb
 IK11lZpex2Vs79Mc9GOI67PGIte05b1FhvOddV/Hmp6TCKu+/8YmKr57C9gshxW+71eS
 k9YCRmVeiiMcdml+G/0dXbBKhQpDRF4Jb5reMrmO6oBEKdRiXFUaNCeG2SoUS7s1lCC0
 vObNA+f+EtvbzMBjjuEOJkL0chWUualvFuiinduRft/uSF2RD+r78eE7lIG3Vpw6kQnj OA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2y8udkuk25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Feb 2020 00:44:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01M0h54Z146709;
        Sat, 22 Feb 2020 00:44:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 2y8udg8m3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 22 Feb 2020 00:44:33 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01M0iWwv149129;
        Sat, 22 Feb 2020 00:44:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2y8udg8m32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Feb 2020 00:44:32 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01M0iRp8021588;
        Sat, 22 Feb 2020 00:44:27 GMT
Received: from localhost (/10.145.179.117)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Feb 2020 16:44:27 -0800
Date:   Fri, 21 Feb 2020 16:44:25 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 21/24] iomap: Restructure iomap_readpages_actor
Message-ID: <20200222004425.GG9506@magnolia>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-22-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219210103.32400-22-willy@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002220001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:01:00PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By putting the 'have we reached the end of the page' condition at the end
> of the loop instead of the beginning, we can remove the 'submit the last
> page' code from iomap_readpages().  Also check that iomap_readpage_actor()
> didn't return 0, which would lead to an endless loop.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index cb3511eb152a..31899e6cb0f8 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -400,15 +400,9 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
>  		void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct iomap_readpage_ctx *ctx = data;
> -	loff_t done, ret;
> -
> -	for (done = 0; done < length; done += ret) {
> -		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
> -			if (!ctx->cur_page_in_bio)
> -				unlock_page(ctx->cur_page);
> -			put_page(ctx->cur_page);
> -			ctx->cur_page = NULL;
> -		}
> +	loff_t ret, done = 0;
> +
> +	while (done < length) {
>  		if (!ctx->cur_page) {
>  			ctx->cur_page = iomap_next_page(inode, ctx->pages,
>  					pos, length, &done);
> @@ -418,6 +412,20 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
>  		}
>  		ret = iomap_readpage_actor(inode, pos + done, length - done,
>  				ctx, iomap, srcmap);
> +		done += ret;
> +
> +		/* Keep working on a partial page */
> +		if (ret && offset_in_page(pos + done))
> +			continue;
> +
> +		if (!ctx->cur_page_in_bio)
> +			unlock_page(ctx->cur_page);
> +		put_page(ctx->cur_page);
> +		ctx->cur_page = NULL;
> +
> +		/* Don't loop forever if we made no progress */
> +		if (WARN_ON(!ret))
> +			break;
>  	}
>  
>  	return done;
> @@ -451,11 +459,7 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
>  done:
>  	if (ctx.bio)
>  		submit_bio(ctx.bio);
> -	if (ctx.cur_page) {
> -		if (!ctx.cur_page_in_bio)
> -			unlock_page(ctx.cur_page);
> -		put_page(ctx.cur_page);
> -	}
> +	BUG_ON(ctx.cur_page);

Whoah, is the system totally unrecoverably hosed at this point?

I get that this /shouldn't/ happen, but should we somehow end up with a
page here, are we unable either to release it or even just leak it?  I'd
have thought a WARN_ON would be just fine here.

--D

>  
>  	/*
>  	 * Check that we didn't lose a page due to the arcance calling
> -- 
> 2.25.0
> 
