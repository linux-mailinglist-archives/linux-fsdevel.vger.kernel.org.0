Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E7944452A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 17:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhKCQEy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 12:04:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232621AbhKCQEw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:04:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 128EB60F39;
        Wed,  3 Nov 2021 16:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635955336;
        bh=u5i16BEePwX4WEXCbo2JNpQXuAFbW+rjoTHBDvqeohg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4+wON+EMB/OFHnYytPqWyw/GK5JtmmvlAHuFX3bcttqFurJTmQslmPfADYkBsOCV
         KfL/VMKcqRofy+VNs2aCGIVLg0KBQHxHH/vMtGAq1HE/ONx8bv0++a0TH4/DppmjSx
         GSiqT7RqoudEznlgQvGeiI7i+VvYyjfDTQ4qozpxVqLyZH3kDJi3Q2xJYAgDRyBjAJ
         dBC8S7BmgpKaC1uRlfZnv8XuvvXdnCsnoo86KbksLt2ndPrIWNyckGch4jRj3TAtoe
         nLgMKxYlSGqSpJN2tjz6w6B1NSw5z8cqFRhAvGJh8VrCiwbHFdix0k4f093tvdffEJ
         soX9UkuQh2ckQ==
Date:   Wed, 3 Nov 2021 09:02:15 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 19/21] iomap: Convert iomap_migrate_page to use folios
Message-ID: <20211103160215.GL24307@magnolia>
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
> The arguments are still pages for now, but we can use folios internally
> and cut out a lot of calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 2436933dfe42..3b93fdfedb72 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -493,19 +493,21 @@ int
>  iomap_migrate_page(struct address_space *mapping, struct page *newpage,
>  		struct page *page, enum migrate_mode mode)
>  {
> +	struct folio *folio = page_folio(page);
> +	struct folio *newfolio = page_folio(newpage);
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
