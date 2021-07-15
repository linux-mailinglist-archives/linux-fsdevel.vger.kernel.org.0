Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545D03CAEEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 00:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhGOWIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 18:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229810AbhGOWIY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:08:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7260161289;
        Thu, 15 Jul 2021 22:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626386730;
        bh=2DNiy/SAZIn85u0H7EsbVIpErwFNqQieQxrkYGH9t9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/JwXa5sm9OQeE5U+7V2hYUt9LKnsW5tCFuUYSUgeIZ1WeWoEp1GkDg1nVAsShw+i
         +C09GkLHMp1kYDcC4zjphMJ3aLEx6MiLWyL6+2ZEU/W/1oUhKreN+Cf3h4oXyI5b8Y
         Q/VURNDNpFUzhtIUrlxAgoIG+3ezWW4dmpzSiBFU9s/0P7gjXbG4uGPClZiWotBLhY
         S4b39BjsrIHSlPafmPeIOoQLNJX9ZaMFq22PSiMvsLbXKl2As5glV5gzn7PPPm+Rxs
         tPDwZXIxyze4wJF1XfXFGtZ7/OozPsDkxh5Oal/GqvizsX0PB2Is06VrcTlHjXEBXp
         mvFyRWuR07HMw==
Date:   Thu, 15 Jul 2021 15:05:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 107/138] iomap: Convert iomap_migrate_page to use
 folios
Message-ID: <20210715220530.GR22357@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-108-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-108-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:36:33AM +0100, Matthew Wilcox (Oracle) wrote:
> The arguments are still pages for now, but we can use folios internally
> and cut out a lot of calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Pretty straightforward conversion.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 0731e2c3f44b..48de198c5603 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -490,19 +490,21 @@ int
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
> 2.30.2
> 
