Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90583CD3BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 13:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbhGSKlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 06:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbhGSKkd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:40:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78133C061574;
        Mon, 19 Jul 2021 03:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XRraZAxjHWHOmKDHLSEsZ8UjvPxlwYc6y4fq7IIgfIQ=; b=h1qdBi0FWIlit/z9Kr+XrqBsI2
        8zGpF3RiZW81r65EUD8AOdCS5gMjNpuAwM5GfsuJnGIBIdlO6ajbmKyu0YlZhjoGpxIWvovLGulb0
        +ngRKmWAGi5Q4LL5rkDiAgHGqvtNsCI+o4aUgF7Lom+mJNC5Uco8q6X0cyT9KBR+/lLHZbg0/B1D2
        ZlxsXcHG+QEqLhO/LnIVys+tZHfQWPJDZJO4stCWDkyvftKpCdBWHr4dvnn6kdep4sZfZxcpiMbpU
        7G80OcHXKGajF53erZ23RAJfv2Dcmm66BZxo/dlPrZCBNvnj+tORfSn7/vRYFcGMO+C70MH7S3AqU
        SLckoFZw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5RFT-006nL5-Qf; Mon, 19 Jul 2021 11:15:56 +0000
Date:   Mon, 19 Jul 2021 12:15:47 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gr??nbacher <andreas.gruenbacher@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
Message-ID: <YPVe41YqpfGLNsBS@infradead.org>
References: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
 <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
 <YPGDZYT9OxdgNYf2@casper.infradead.org>
 <YPGQB3zT4Wp4Q38X@B-P7TQMD6M-0146.local>
 <YPGbNCdCNXIpNdqd@casper.infradead.org>
 <YPGfqLcSiH3/z2RT@B-P7TQMD6M-0146.local>
 <CAHpGcMJzEiJUbD=7ZOdH7NF+gq9MuEi8=ym34ay7QAm5_91s7g@mail.gmail.com>
 <YPLdSja/4FBsjss/@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPLdSja/4FBsjss/@B-P7TQMD6M-0146.local>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 17, 2021 at 09:38:18PM +0800, Gao Xiang wrote:
> >From 62f367245492e389711bcebbf7da5adae586299f Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 16 Jul 2021 10:52:48 +0200
> Subject: [PATCH] iomap: support tail packing inline read

I'd still credit this to you as you did all the hard work.

> +	/* inline source data must be inside a single page */
> +	BUG_ON(iomap->length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +	/* handle tail-packing blocks cross the current page into the next */
> +	if (size > PAGE_SIZE - poff)
> +		size = PAGE_SIZE - poff;

This should probably use min or min_t.

>  
>  	addr = kmap_atomic(page);
> -	memcpy(addr, iomap->inline_data, size);
> -	memset(addr + size, 0, PAGE_SIZE - size);
> +	memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
> +	memset(addr + poff + size, 0, PAGE_SIZE - poff - size);
>  	kunmap_atomic(addr);
> -	SetPageUptodate(page);
> +	flush_dcache_page(page);

The flush_dcache_page addition should be a separate patch.

>  
>  	if (dio->flags & IOMAP_DIO_WRITE) {
>  		loff_t size = inode->i_size;
> @@ -394,7 +395,8 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
>  			mark_inode_dirty(inode);
>  		}
>  	} else {
> -		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
> +		copied = copy_to_iter(iomap->inline_data + pos - iomap->offset,
> +				length, iter);

We also need to take the offset into account for the write side.
I guess it would be nice to have a local variable for the inline
address to not duplicate that calculation multiple times.
