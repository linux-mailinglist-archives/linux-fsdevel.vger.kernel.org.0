Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA273D05EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 01:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhGTXQx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 19:16:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232402AbhGTXQw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 19:16:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAEBB61007;
        Tue, 20 Jul 2021 23:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626825447;
        bh=+cUiV985wmYic24lRaCwT9f5w3aNSR/YyFMd0hJ3ZQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=htWE3SCJxV6U3m4mDWtM3PqYvJrjcojmOCYJsBKLHefhtlctr4zkoYMESyPVOpCmJ
         86SCcrcCYM+jGe9utMjcOt3iLZb3ssDojEz7vWl580aw1dOY9/UG174n+sjGmOiXfM
         GMm2t0kjHxNtahsw2rUFKsT/GXI6FuHC6nDhTmSmAsxBqmq5XSu9Fb7DdbgsC8LIsH
         DbPKaUTtgv+Ls3eZPWpxJnAmFcUfK81YNXWwUV4ItLOvutEnwaiLyM4PgvB2t67pkf
         gbiADXluutxxmzaTRRYWn82FHKQV9Ny956+9IzxNnbQDH5dLwj5XWUmcnMTBjmdEJx
         qJCsMAzbBJQVw==
Date:   Tue, 20 Jul 2021 16:57:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 07/17] iomap: Convert iomap_invalidatepage to use a
 folio
Message-ID: <20210720235726.GB3033223@magnolia>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-8-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:51PM +0100, Matthew Wilcox (Oracle) wrote:
> This is an address_space operation, so its argument must remain as a
> struct page, but we can use a folio internally.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 715b25a1c1e6..0d7b6ef4c5cc 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -480,15 +480,15 @@ iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
>  {
>  	struct folio *folio = page_folio(page);
>  
> -	trace_iomap_invalidatepage(page->mapping->host, offset, len);
> +	trace_iomap_invalidatepage(folio->mapping->host, offset, len);
>  
>  	/*
>  	 * If we are invalidating the entire page, clear the dirty state from it
>  	 * and release it to avoid unnecessary buildup of the LRU.
>  	 */
> -	if (offset == 0 && len == PAGE_SIZE) {
> -		WARN_ON_ONCE(PageWriteback(page));
> -		cancel_dirty_page(page);
> +	if (offset == 0 && len == folio_size(folio)) {
> +		WARN_ON_ONCE(folio_test_writeback(folio));
> +		folio_cancel_dirty(folio);
>  		iomap_page_release(folio);
>  	}
>  }
> -- 
> 2.30.2
> 
