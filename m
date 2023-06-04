Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57630721927
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jun 2023 20:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjFDSKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 14:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjFDSKL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 14:10:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA92B0;
        Sun,  4 Jun 2023 11:10:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEA1460BD4;
        Sun,  4 Jun 2023 18:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33464C433D2;
        Sun,  4 Jun 2023 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685902209;
        bh=RVfmPm1NDc929R9ZBfjOMBc6v8Z+/BxE7sw65bIFSd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SlIVRk9+F2xkLQpF4vY6FHrME1Ldj0tYTU/Pj/H9i4pxMr5JeO3Yys6CwAeqPIbbt
         WL/VgEw30qMlu1XL2RKrUuyHB04bFM8dSaIaQma+pbTIljIfBXlCp/YidH4eQsS6mO
         0CQ5Rk6RAAyQSm+9Bh0gRlC2OkcucS9NqwGNF5Nzmlr03Bk7lx4XmDfgP21e81ywK2
         pcFyUZu4vGNmhlv/VKAjerjZPkqywoEuFzXf+4nEie6FLITuCeKar0IgujWqnwMQgD
         HiybXxABQPRfN9OKyIHCS0ukRK9xY1j5WkuQ9kFQRDlTvErMpTBZD+fZN75gkwBFbQ
         GH/OzQfQlMk/g==
Date:   Sun, 4 Jun 2023 11:10:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 6/7] iomap: Create large folios in the buffered write
 path
Message-ID: <20230604181008.GG72241@frogsfrogsfrogs>
References: <20230602222445.2284892-1-willy@infradead.org>
 <20230602222445.2284892-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602222445.2284892-7-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02, 2023 at 11:24:43PM +0100, Matthew Wilcox (Oracle) wrote:
> Use the size of the write as a hint for the size of the folio to create.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/gfs2/bmap.c         | 2 +-
>  fs/iomap/buffered-io.c | 6 ++++--
>  include/linux/iomap.h  | 2 +-
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index c739b258a2d9..3702e5e47b0f 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -971,7 +971,7 @@ gfs2_iomap_get_folio(struct iomap_iter *iter, loff_t pos, unsigned len)
>  	if (status)
>  		return ERR_PTR(status);
>  
> -	folio = iomap_get_folio(iter, pos);
> +	folio = iomap_get_folio(iter, pos, len);
>  	if (IS_ERR(folio))
>  		gfs2_trans_end(sdp);
>  	return folio;
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 30d53b50ee0f..a10f9c037515 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -461,16 +461,18 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
>   * iomap_get_folio - get a folio reference for writing
>   * @iter: iteration structure
>   * @pos: start offset of write
> + * @len: length of write
>   *
>   * Returns a locked reference to the folio at @pos, or an error pointer if the
>   * folio could not be obtained.
>   */
> -struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
> +struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
>  {
>  	fgp_t fgp = FGP_WRITEBEGIN | FGP_NOFS;
>  
>  	if (iter->flags & IOMAP_NOWAIT)
>  		fgp |= FGP_NOWAIT;
> +	fgp |= fgp_set_order(len);
>  
>  	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
>  			fgp, mapping_gfp_mask(iter->inode->i_mapping));
> @@ -596,7 +598,7 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter, loff_t pos,
>  	if (folio_ops && folio_ops->get_folio)
>  		return folio_ops->get_folio(iter, pos, len);
>  	else
> -		return iomap_get_folio(iter, pos);
> +		return iomap_get_folio(iter, pos, len);
>  }
>  
>  static void __iomap_put_folio(struct iomap_iter *iter, loff_t pos, size_t ret,
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e2b836c2e119..80facb9c9e5b 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -261,7 +261,7 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
>  void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
>  bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
> -struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos);
> +struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
>  bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
>  void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
>  int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
> -- 
> 2.39.2
> 
