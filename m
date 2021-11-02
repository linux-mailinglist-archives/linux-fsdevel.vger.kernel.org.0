Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC08442835
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 08:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhKBHXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 03:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhKBHXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:23:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3395EC061714;
        Tue,  2 Nov 2021 00:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wDLhAnhRGJ38F/R5GBK7oivxF6ESZSsILVg+gz9cSFI=; b=OouaVoGtagEHDIi4N16OO6TvNo
        m+z7eZobmUwYUoALqjEs0GnipY2N0Dz2cYcN4eOXmdI+yGrhrVouqPGgq2THVRLw9MZwN4eeTmt6z
        X3gwYUDGagCxLEg4r+zC06bgNS3+eL3BfmqSd+ZYcSLPNvIaZBzDRLcniJ2KzrYVbAQx6tNDVQwPU
        MtCJykhhLXONYq1xGfTBAQ8xh8n5FX64lL3Hw/k6zvDR1WA93h45nrSa+LmqlTjOEILvDxU5z4iP1
        cPdaMa967H30t8qYMsHmlLAdxGR5ywc0EemFFC1r8WDgKQdp6NY9KxRzO8IoOl0Bq5WE4isHs55MG
        NOLWVxGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mho6B-000lC1-5f; Tue, 02 Nov 2021 07:20:47 +0000
Date:   Tue, 2 Nov 2021 00:20:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 13/21] iomap: Convert readahead and readpage to use a
 folio
Message-ID: <YYDmz8olTe/Qr2ch@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-14-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:39:21PM +0000, Matthew Wilcox (Oracle) wrote:
>  	for (done = 0; done < length; done += ret) {
> -		if (ctx->cur_page && offset_in_page(iter->pos + done) == 0) {
> -			if (!ctx->cur_page_in_bio)
> -				unlock_page(ctx->cur_page);
> -			put_page(ctx->cur_page);
> -			ctx->cur_page = NULL;
> +		if (ctx->cur_folio &&
> +		    offset_in_folio(ctx->cur_folio, iter->pos + done) == 0) {
> +			if (!ctx->cur_folio_in_bio)
> +				folio_unlock(ctx->cur_folio);
> +			ctx->cur_folio = NULL;

Where did the put_page here disappear to?

> @@ -403,10 +403,9 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
>  
>  	if (ctx.bio)
>  		submit_bio(ctx.bio);
> -	if (ctx.cur_page) {
> -		if (!ctx.cur_page_in_bio)
> -			unlock_page(ctx.cur_page);
> -		put_page(ctx.cur_page);
> +	if (ctx.cur_folio) {
> +		if (!ctx.cur_folio_in_bio)
> +			folio_unlock(ctx.cur_folio);

... and here?
