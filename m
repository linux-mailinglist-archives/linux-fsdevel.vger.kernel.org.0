Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B81865DB58
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 18:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjADRiS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 12:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjADRiQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:38:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D694039FB9;
        Wed,  4 Jan 2023 09:38:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70ED9617CF;
        Wed,  4 Jan 2023 17:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A99C433EF;
        Wed,  4 Jan 2023 17:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672853894;
        bh=bmtlEVOXW8OqJhwRIIY77LJdJYOSU3ofELsaFH1brmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p3OgRnE8hXQpGCTx+YfDrvPJUOu3OAK214tzR8Z7LttNhfzKnxA9cHxpGqssl+qrx
         3iUz3uywSAaoOyHuOJBxVXGSFBq5VVtHT4XOt4YPCyLR7XqQy0UJxVuQJYcRrjJXOp
         7zNZpVM706GfatHqxXHPOOzl34YRPeMybog0u5eAVxBOmcu/XZ9rAnPJSr8IWrA1nU
         xb64Zo8eNRWSHoVsoxrHZJ4ZivUgrMvK4jl0DO64sM2191kvbuUXaVvu6KtUIFF6r+
         ZG2SHHZBX47t/PBrweb8+ZoNFXsAG6hmzm3yqPZ3KO3xsoztIOU/bGS83hjWKuJDtO
         8RUrXpdoMC01Q==
Date:   Wed, 4 Jan 2023 09:38:14 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH v5 4/9] iomap: Add iomap_get_folio helper
Message-ID: <Y7W5hiktQFd6CvTY@magnolia>
References: <20221231150919.659533-1-agruenba@redhat.com>
 <20221231150919.659533-5-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231150919.659533-5-agruenba@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 31, 2022 at 04:09:14PM +0100, Andreas Gruenbacher wrote:
> Add an iomap_get_folio() helper that gets a folio reference based on
> an iomap iterator and an offset into the address space.  Use it in
> iomap_write_begin().
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Pretty straightforward,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 39 ++++++++++++++++++++++++++++++---------
>  include/linux/iomap.h  |  1 +
>  2 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 2a9bab4f3c79..b84838d2b5d8 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -457,6 +457,33 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
>  }
>  EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
>  
> +/**
> + * iomap_get_folio - get a folio reference for writing
> + * @iter: iteration structure
> + * @pos: start offset of write
> + *
> + * Returns a locked reference to the folio at @pos, or an error pointer if the
> + * folio could not be obtained.
> + */
> +struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
> +{
> +	unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
> +	struct folio *folio;
> +
> +	if (iter->flags & IOMAP_NOWAIT)
> +		fgp |= FGP_NOWAIT;
> +
> +	folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
> +			fgp, mapping_gfp_mask(iter->inode->i_mapping));
> +	if (folio)
> +		return folio;
> +
> +	if (iter->flags & IOMAP_NOWAIT)
> +		return ERR_PTR(-EAGAIN);
> +	return ERR_PTR(-ENOMEM);
> +}
> +EXPORT_SYMBOL_GPL(iomap_get_folio);
> +
>  bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
>  {
>  	trace_iomap_release_folio(folio->mapping->host, folio_pos(folio),
> @@ -603,12 +630,8 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	struct folio *folio;
> -	unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
>  	int status = 0;
>  
> -	if (iter->flags & IOMAP_NOWAIT)
> -		fgp |= FGP_NOWAIT;
> -
>  	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
>  	if (srcmap != &iter->iomap)
>  		BUG_ON(pos + len > srcmap->offset + srcmap->length);
> @@ -625,12 +648,10 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  			return status;
>  	}
>  
> -	folio = __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
> -			fgp, mapping_gfp_mask(iter->inode->i_mapping));
> -	if (!folio) {
> -		status = (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
> +	folio = iomap_get_folio(iter, pos);
> +	if (IS_ERR(folio)) {
>  		iomap_put_folio(iter, pos, 0, NULL);
> -		return status;
> +		return PTR_ERR(folio);
>  	}
>  
>  	/*
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 10ec36f373f4..e5732cc5716b 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -261,6 +261,7 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
>  void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
>  bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
> +struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos);
>  bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
>  void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
>  int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
> -- 
> 2.38.1
> 
