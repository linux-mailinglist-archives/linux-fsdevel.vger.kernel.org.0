Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B3D3D0602
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 02:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhGTXWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 19:22:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232511AbhGTXVr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 19:21:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9370061019;
        Wed, 21 Jul 2021 00:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626825744;
        bh=92Gjrop0XLyAuerlYU5OBiO3OpCjgEbq8pXa4g95YMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HSEsFujMopdUvp/8h/Vc0fIoUMksjU9jfdH9FvJoEO7G/eylKh7A35iPv8fZOQq0p
         +7MVyZZ72wnBFkYD9qVLyS+7p2f/3yRzQkG+Kh9R+45N+Rcllur2A9iHsvFVLQJ18r
         rSFuT5t3tYnmCZubOLS0HgLwJd/+77CNDCS2OYMFcSlhOYaUL288u3RwfRfZmuvv5I
         AXyjMxXp8RvrV9Xa02Oz42YzOWMrHxUpoeWKBeHawB6v70VDFGqoq9QXS/5GeBQ4z6
         as5XpKOVLB7hyc9wUeduPF7u/OoY2LE9Vm6tX363ql0sy1Nm2f/0775xk71coepC1F
         Xh7d+IHGYJzXA==
Date:   Tue, 20 Jul 2021 17:02:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 17/17] iomap: Convert iomap_migrate_page to use folios
Message-ID: <20210721000224.GQ22357@magnolia>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-18-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:40:01PM +0100, Matthew Wilcox (Oracle) wrote:
> The arguments are still pages for now, but we can use folios internally
> and cut out a lot of calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Didn't I RVb this last time? ;)
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 60d3b7af61d1..cf56b19fb101 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -492,19 +492,21 @@ int
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
