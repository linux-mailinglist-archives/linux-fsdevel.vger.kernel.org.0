Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42C4319A463
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 06:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgDAEbf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 00:31:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41704 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgDAEbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 00:31:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0314RQCb086170;
        Wed, 1 Apr 2020 04:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=SvycLXEfobZZx7pBCEX9Ld+Rqmnfw9gUQeQ7eJ4ZuwM=;
 b=sEiaYrdVBrsuXNedhBS+9f/6GMOWDnxzW8YdzYD0vZqng6pS/tV9uOhiU7Wv3Mgxg9oq
 ao7bCnjd5HbBRUxEB/pcgH4AZIyZc4a+na18cjbr0Ie3qyUoxpTkkfJeGZza/SCYb6je
 3NquI5P01bUpLw7igBfzHUCK2VD90J09TNiY3LdeAfqOWzjIcAlUUtGvusMtbsmM3ddN
 GIFKeXFXZwY+v+94MvnIaZanI0bQv/QuLeFDiUtukDZYnqCmixV8hsvpntCy1xOPjHuJ
 kN7ZQZEv91un2Pj/wZhrFH7r3HZoo4gsIzps6G1OpPqDHmlAelmI5a6oswuLyodJaa+2 Ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 303yun5r3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 04:31:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0314R1rO124805;
        Wed, 1 Apr 2020 04:31:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 302gcenp5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 04:31:28 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0314VQo7013350;
        Wed, 1 Apr 2020 04:31:26 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 31 Mar 2020 21:31:26 -0700
Date:   Tue, 31 Mar 2020 21:31:25 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Handle memory allocation failure in readahead
Message-ID: <20200401043125.GD56958@magnolia>
References: <20200401030421.17195-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401030421.17195-1-willy@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9577 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9577 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010038
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 31, 2020 at 08:04:21PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> bio_alloc() can fail when we use GFP_NORETRY.  If it does, allocate
> a bio large enough for a single page like mpage_readpages() does.

Why does mpage_readpages() do that?

Is this a means to guarantee some kind of forward (readahead?) progress?
Forgive my ignorance, but if memory is so tight we can't allocate a bio
for readahead then why not exit having accomplished nothing?

--D

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 417115bfaf6b..c258801f18d4 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -302,6 +302,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  
>  	if (!ctx->bio || !is_contig || bio_full(ctx->bio, plen)) {
>  		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
> +		gfp_t orig_gfp = gfp;
>  		int nr_vecs = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  
>  		if (ctx->bio)
> @@ -310,6 +311,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		if (ctx->is_readahead) /* same as readahead_gfp_mask */
>  			gfp |= __GFP_NORETRY | __GFP_NOWARN;
>  		ctx->bio = bio_alloc(gfp, min(BIO_MAX_PAGES, nr_vecs));
> +		if (!ctx->bio)
> +			ctx->bio = bio_alloc(orig_gfp, 1);
>  		ctx->bio->bi_opf = REQ_OP_READ;
>  		if (ctx->is_readahead)
>  			ctx->bio->bi_opf |= REQ_RAHEAD;
> -- 
> 2.25.1
> 
