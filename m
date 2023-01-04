Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3634565DB5E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 18:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbjADRjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 12:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjADRjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:39:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F43139FB9;
        Wed,  4 Jan 2023 09:39:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED6C1617D0;
        Wed,  4 Jan 2023 17:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50407C433D2;
        Wed,  4 Jan 2023 17:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672853948;
        bh=T0O3yBPdDIA9OGYRLepkhHQkWmaK+2iyMaqY0PIZcbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NcxgovfnswSEoi5qEL/dB4XlclrvqKj98RoH6UgAylQ4oqjDY9vVTzywoG4SmO4y+
         IFG5hMpshDAqjRzM9Ei/NhZ4To5wlKtJjsDJT656AmRsJykez3WA96gvjAutxwrdRg
         LG1NDqQZHZbkz21+ZcC0BEBTc4e88e796UP95bVB+e1P94InYorYjReXORJdqwzyYB
         aGWTRAbGpPAggUs76bXNAbKuF1xEokHyxdHW66NgOM4IGxRX9hRMrzcbgg9ZbgDklK
         9yAWyCi2VuEenBKDLGAfY8dgE4E8HLJyVRSgpyxrq7YiEH32lonCx72utFtdfhCHtk
         +HUcgTAmaW9Sw==
Date:   Wed, 4 Jan 2023 09:39:07 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH v5 1/9] iomap: Add iomap_put_folio helper
Message-ID: <Y7W5uyho8AWpo5or@magnolia>
References: <20221231150919.659533-1-agruenba@redhat.com>
 <20221231150919.659533-2-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231150919.659533-2-agruenba@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 31, 2022 at 04:09:11PM +0100, Andreas Gruenbacher wrote:
> Add an iomap_put_folio() helper to encapsulate unlocking the folio,
> calling ->page_done(), and putting the folio.  Use the new helper in
> iomap_write_begin() and iomap_write_end().
> 
> This effectively doesn't change the way the code works, but prepares for
> successive improvements.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 356193e44cf0..c30d150a9303 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -575,6 +575,19 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  	return 0;
>  }
>  
> +static void iomap_put_folio(struct iomap_iter *iter, loff_t pos, size_t ret,
> +		struct folio *folio)
> +{
> +	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
> +
> +	if (folio)
> +		folio_unlock(folio);
> +	if (page_ops && page_ops->page_done)
> +		page_ops->page_done(iter->inode, pos, ret, &folio->page);
> +	if (folio)
> +		folio_put(folio);
> +}
> +
>  static int iomap_write_begin_inline(const struct iomap_iter *iter,
>  		struct folio *folio)
>  {
> @@ -616,7 +629,8 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  			fgp, mapping_gfp_mask(iter->inode->i_mapping));
>  	if (!folio) {
>  		status = (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
> -		goto out_no_page;
> +		iomap_put_folio(iter, pos, 0, NULL);
> +		return status;
>  	}
>  
>  	/*
> @@ -656,13 +670,9 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  	return 0;
>  
>  out_unlock:
> -	folio_unlock(folio);
> -	folio_put(folio);
> +	iomap_put_folio(iter, pos, 0, folio);
>  	iomap_write_failed(iter->inode, pos, len);
>  
> -out_no_page:
> -	if (page_ops && page_ops->page_done)
> -		page_ops->page_done(iter->inode, pos, 0, NULL);
>  	return status;
>  }
>  
> @@ -712,7 +722,6 @@ static size_t iomap_write_end_inline(const struct iomap_iter *iter,
>  static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  		size_t copied, struct folio *folio)
>  {
> -	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	loff_t old_size = iter->inode->i_size;
>  	size_t ret;
> @@ -735,14 +744,10 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  		i_size_write(iter->inode, pos + ret);
>  		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
>  	}
> -	folio_unlock(folio);
> +	iomap_put_folio(iter, pos, ret, folio);
>  
>  	if (old_size < pos)
>  		pagecache_isize_extended(iter->inode, old_size, pos);
> -	if (page_ops && page_ops->page_done)
> -		page_ops->page_done(iter->inode, pos, ret, &folio->page);
> -	folio_put(folio);
> -
>  	if (ret < len)
>  		iomap_write_failed(iter->inode, pos + ret, len - ret);
>  	return ret;
> -- 
> 2.38.1
> 
