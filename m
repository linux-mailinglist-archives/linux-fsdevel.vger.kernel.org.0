Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADECD74E247
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 01:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGJXnj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 19:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGJXni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:43:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD12619A;
        Mon, 10 Jul 2023 16:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RlN3sX4R5sZnDRHPtR6puP++dQfv9HVj4TiY9LcmsZI=; b=cCXLielT+RXu75fmQb0tegGnEH
        ANOaxvT9TuWmc+kAch4zptX/qgtJ5nB2SoMQMzm0RcR8MhRKvciN4re+1mcZyEt/euRKDOKMLpHYS
        9p9Kxk56qO0N7SMEmduic4I52dju0RYChXfOOrAiJfrckOwf6NkerHhMZw7Kuta7mVIpP9fcmQpxM
        w4n0lBwSX7Xwe21sZQ9j7fnJg1Gif3/PRvljzcZqvsFsmtX6W26bsTvClOHGtrNryZl43Qo7s01aq
        d9hSllK2sGbvcUYzFVjF0Vi7ctbaG9qynHWai2svuQTTFklWHG26mVb7Smc9fmR8H4zmHpRXUvE3h
        jvcAAuUQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJ0XX-00Cyel-0p;
        Mon, 10 Jul 2023 23:43:35 +0000
Date:   Mon, 10 Jul 2023 16:43:35 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH v4 1/9] iov_iter: Handle compound highmem pages in
 copy_page_from_iter_atomic()
Message-ID: <ZKyXp2NyoHy3K1qu@bombadil.infradead.org>
References: <20230710130253.3484695-1-willy@infradead.org>
 <20230710130253.3484695-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710130253.3484695-2-willy@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 02:02:45PM +0100, Matthew Wilcox (Oracle) wrote:
> copy_page_from_iter_atomic() already handles !highmem compound
> pages correctly, but if we are passed a highmem compound page,
> each base page needs to be mapped & unmapped individually.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  lib/iov_iter.c | 43 ++++++++++++++++++++++++++++---------------
>  1 file changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index b667b1e2f688..c728b6e4fb18 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -566,24 +566,37 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
>  }
>  EXPORT_SYMBOL(iov_iter_zero);
>  
> -size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t bytes,
> -				  struct iov_iter *i)
> +size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
> +		size_t bytes, struct iov_iter *i)
>  {
> -	char *kaddr = kmap_atomic(page), *p = kaddr + offset;
> -	if (!page_copy_sane(page, offset, bytes)) {
> -		kunmap_atomic(kaddr);
> +	size_t n, copied = 0;
> +
> +	if (!page_copy_sane(page, offset, bytes))
>  		return 0;
> -	}
> -	if (WARN_ON_ONCE(!i->data_source)) {
> -		kunmap_atomic(kaddr);
> +	if (WARN_ON_ONCE(!i->data_source))
>  		return 0;

To make it easier to review the split of the kmap_atomic() until later
and the saving of the unwinding would be nice as separate patches.

> -	}
> -	iterate_and_advance(i, bytes, base, len, off,
> -		copyin(p + off, base, len),
> -		memcpy_from_iter(i, p + off, base, len)
> -	)
> -	kunmap_atomic(kaddr);
> -	return bytes;
> +
> +	do {
> +		char *p;
> +
> +		n = bytes - copied;
> +		if (PageHighMem(page)) {
> +			page += offset / PAGE_SIZE;

I don't quite follow here how before the page was not modified
to get to the first kmap_atomic(page) and now immediately if we're
on a PageHighMem(page) we're doing some arithmetic to the page
address to get the first kmap_atomic(). The only thing I could
think of is seems like an implicit assumption here that if its a compound
highmem page then we always start off with offset with a value of
0, is that right? But that seems to not be correct either.

  Luis
