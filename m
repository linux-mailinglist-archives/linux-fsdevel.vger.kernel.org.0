Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DA524E5BA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 07:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgHVF7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 01:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHVF7z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 01:59:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A6AC061573;
        Fri, 21 Aug 2020 22:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h+trC/HFYHTtnms24Fdz8ZD6MASZ+P+qyAQTjFOZVOQ=; b=uu3Ewgd5xA1nrmnuegWRC86I0V
        hX6VMzisu4f0KzokVIPvdMeWUKqWDupDzu9096rLLSEmldU5CdaVNhEhVgFDJ+x4uPWwXc0NHWckr
        v94umLDkxLD6fBdlpHfpe2tSNZovuafeeVllqhA5Od9WqZDzFKMQIk4dD/kUPtwsbXREX/AZV6jeP
        qaFTXYjylvYy2zt21l4oeLG+pggGtYZ0r4ESUWiQOTFYXrxbSO/QtZyNuu3pDBbAvE3wNOXBY4QXX
        aAOpJH0HrvR92rK6kpJTjtcsO5uh8QhXnYwCvhs2xvr9tNBH9v4FZWQWbjuQiHST8VYq1z6xwqLWj
        uoDISxWA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9MZ9-0004bj-LQ; Sat, 22 Aug 2020 05:59:47 +0000
Date:   Sat, 22 Aug 2020 06:59:47 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Yu Kuai <yukuai3@huawei.com>, hch@infradead.org,
        darrick.wong@oracle.com, david@fromorbit.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH 2/3] iomap: Use bitmap ops to set uptodate bits
Message-ID: <20200822055947.GB17129@infradead.org>
References: <20200821124424.GQ17456@casper.infradead.org>
 <20200821124606.10165-1-willy@infradead.org>
 <20200821124606.10165-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821124606.10165-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 01:46:05PM +0100, Matthew Wilcox (Oracle) wrote:
> Now that the bitmap is protected by a spinlock, we can use the
> more efficient bitmap ops instead of individual test/set bit ops.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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

Can you respin this to be based on current Linus' tree without
i_blocks_per_page?  With that it looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
