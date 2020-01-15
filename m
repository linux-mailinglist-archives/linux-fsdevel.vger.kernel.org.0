Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 128D713BA3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 08:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgAOHQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 02:16:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAOHQ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 02:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZA7aSJRjUkKNXdsi7RFinpN7JG4VTFMCW87jm3aI7ec=; b=rq1x+uA6PcOARY9hmPbjqCwFd
        gavBZBkHnr5F5ysyBa+tFubM4qgrsJpVURzhGus5HFZBWSf/eO8p7nWgHNsZs6ym8n84dhKhsS8ao
        AkG3un+KGEC7Gv9TOcEppEBz2An4a1zg5duAzJiYQgXEh8yKauqpi1etzl1RE00HHilAd98fg74HC
        5MBzlqPS+UpWS4bW4J/U59Y3MbPTGXJfavWFR4RPmc+oOFRB0bXsLdi/v5wTLTbSjAnbHGjJ9ufr1
        dDu3Lfx+Q2KeusipZTMx4ah84hvISR3ME2KYiuhijLPz3MRV084RMG0qGKiAvJhnixbVqdV3JvWDb
        xmYof6Djw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ircui-0000Vw-LY; Wed, 15 Jan 2020 07:16:28 +0000
Date:   Tue, 14 Jan 2020 23:16:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v2 6/9] iomap,xfs: Convert from readpages to readahead
Message-ID: <20200115071628.GA3460@infradead.org>
References: <20200115023843.31325-1-willy@infradead.org>
 <20200115023843.31325-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115023843.31325-7-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 06:38:40PM -0800, Matthew Wilcox wrote:
>  static loff_t
> +iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
>  		void *data, struct iomap *iomap, struct iomap *srcmap)
>  {
>  	struct iomap_readpage_ctx *ctx = data;
> @@ -410,10 +381,8 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
>  			ctx->cur_page = NULL;
>  		}
>  		if (!ctx->cur_page) {
> -			ctx->cur_page = iomap_next_page(inode, ctx->pages,
> -					pos, length, &done);
> -			if (!ctx->cur_page)
> -				break;
> +			ctx->cur_page = readahead_page(inode->i_mapping,
> +					pos / PAGE_SIZE);

Don't we at least need a sanity check for a NULL cur_page here?
Also the readahead_page version in your previous patch seems to expect
a byte offset, so the division above would not be required. (and should
probably be replaced with a right shift anyway no matter where it ends
up)

> +unsigned
> +iomap_readahead(struct address_space *mapping, pgoff_t start,
>  		unsigned nr_pages, const struct iomap_ops *ops)
>  {
>  	struct iomap_readpage_ctx ctx = {
> -		.pages		= pages,
>  		.is_readahead	= true,
>  	};
> -	loff_t pos = page_offset(list_entry(pages->prev, struct page, lru));
> -	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
> -	loff_t length = last - pos + PAGE_SIZE, ret = 0;
> +	loff_t pos = start * PAGE_SIZE;
> +	loff_t length = nr_pages * PAGE_SIZE;

Any good reason not to pass byte offsets for start and length?

> +	return length / PAGE_SIZE;

Same for the return value?

For the file systems that would usually be a more natural interface than
a page index and number of pages.
