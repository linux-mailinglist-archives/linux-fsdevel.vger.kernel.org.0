Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D33446C45
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Nov 2021 04:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhKFDsy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Nov 2021 23:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhKFDsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Nov 2021 23:48:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD61C061570;
        Fri,  5 Nov 2021 20:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DUeLl3GL340iUKIiVJiqtjBe7sAAcyIadJ3zWvIOyGU=; b=XFk2OqW2UNX/DKiU/a4IYDy1eY
        5Td/YNDnwQYxICncieUyGPoGBBXHFnsxtSuqaYg+NZdoIXxYO9y71QebrlKZyejsKTe4lFv3vWrKV
        sIRezDA0ssnBH2ySdKC7tzKwB64OYooNkSn7StEqj6IyeeW2NQD47r7E4JeEWxsVZrfWDtxulOFPV
        p+foN/tCkHT9gPd/o5Z4ozfcmY7ac9i0xw9XDpWJr4Yul/DlYwVXQGT18EryzUKPe6CZ/BvETR4il
        Uu/SL2RAufcD1ulLw+EAUEh2TBidZFOl0YEm9VC65KXBiGvjYfNqhnqQG2etiFFCOHJvjb40ltVLP
        VYLXab5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjCdA-0071tn-Ae; Sat, 06 Nov 2021 03:45:03 +0000
Date:   Sat, 6 Nov 2021 03:44:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 19/21] iomap: Convert iomap_migrate_page to use folios
Message-ID: <YYX6JBO/aRy07wgC@casper.infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-20-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-20-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:39:27PM +0000, Matthew Wilcox (Oracle) wrote:
> +++ b/fs/iomap/buffered-io.c
> @@ -493,19 +493,21 @@ int
>  iomap_migrate_page(struct address_space *mapping, struct page *newpage,
>  		struct page *page, enum migrate_mode mode)
>  {
> +	struct folio *folio = page_folio(page);
> +	struct folio *newfolio = page_folio(newpage);

Re-reviewing this patch, and I don't like the naming.  How about:

	struct folio *src = page_folio(page);
	struct folio *dest = page_folio(newpage);

... eventually flowing that renaming throughout the migration
implementations.

>  	int ret;
>  
> -	ret = migrate_page_move_mapping(mapping, newpage, page, 0);
> +	ret = folio_migrate_mapping(mapping, newfolio, folio, 0);
>  	if (ret != MIGRATEPAGE_SUCCESS)
>  		return ret;
>  
> -	if (page_has_private(page))
> -		attach_page_private(newpage, detach_page_private(page));
> +	if (folio_test_private(folio))
> +		folio_attach_private(newfolio, folio_detach_private(folio));
>  
>  	if (mode != MIGRATE_SYNC_NO_COPY)
> -		migrate_page_copy(newpage, page);
> +		folio_migrate_copy(newfolio, folio);
>  	else
> -		migrate_page_states(newpage, page);
> +		folio_migrate_flags(newfolio, folio);
>  	return MIGRATEPAGE_SUCCESS;
>  }
>  EXPORT_SYMBOL_GPL(iomap_migrate_page);
> -- 
> 2.33.0
> 
