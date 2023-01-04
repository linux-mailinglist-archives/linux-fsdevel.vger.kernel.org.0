Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A0265DB74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 18:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbjADRqF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 12:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbjADRqE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:46:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A176113B;
        Wed,  4 Jan 2023 09:46:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E265C617AA;
        Wed,  4 Jan 2023 17:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4665FC433F0;
        Wed,  4 Jan 2023 17:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672854362;
        bh=JHdovKMdHjtYJSEEWBGcTw28NvHtJi6sqq/Knuet9cY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VAPH78P5PNOkMlX18x0aSWm62H9iTmv5QrHWJKyquXAwdL2z6EEw7++UOGjdHivuh
         VlC1HqEpKKJhNvnuZxdludwpwV1FfQmust75Y0bfOZQkse4y1I16QdniJo8DsGT8Op
         wJJsQL1dldCYzha7k6sE+1FlbWNuzoUgNAh3Jyx9gaUvd0LMpGLInbJ4t1JAbK0Ep2
         61Z2TwBinDnIAsfpdxxrVVyetxHWEv6jXBym0fVfM2u5kxriBXX1eiSPbpBu8Z/txZ
         zVGPgkUcoRomN6oTSQW3ELqQ9cA5hULjGmraKqRYX7MbZJoR75X4ReRQpnXThrpgOE
         4ozey/XbQ/tXA==
Date:   Wed, 4 Jan 2023 09:46:01 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH v5 6/9] iomap: Rename page_prepare handler to get_folio
Message-ID: <Y7W7WYW2mPLHACcl@magnolia>
References: <20221231150919.659533-1-agruenba@redhat.com>
 <20221231150919.659533-7-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231150919.659533-7-agruenba@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 31, 2022 at 04:09:16PM +0100, Andreas Gruenbacher wrote:
> The ->page_prepare() handler in struct iomap_page_ops is now somewhat
> misnamed, so rename it to ->get_folio().
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/gfs2/bmap.c         | 6 +++---
>  fs/iomap/buffered-io.c | 4 ++--
>  include/linux/iomap.h  | 6 +++---
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 41349e09558b..d3adb715ac8c 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -957,7 +957,7 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
>  }
>  
>  static struct folio *
> -gfs2_iomap_page_prepare(struct iomap_iter *iter, loff_t pos, unsigned len)
> +gfs2_iomap_get_folio(struct iomap_iter *iter, loff_t pos, unsigned len)
>  {
>  	struct inode *inode = iter->inode;
>  	unsigned int blockmask = i_blocksize(inode) - 1;
> @@ -998,7 +998,7 @@ static void gfs2_iomap_put_folio(struct inode *inode, loff_t pos,
>  }
>  
>  static const struct iomap_page_ops gfs2_iomap_page_ops = {
> -	.page_prepare = gfs2_iomap_page_prepare,
> +	.get_folio = gfs2_iomap_get_folio,
>  	.put_folio = gfs2_iomap_put_folio,
>  };
>  
> @@ -1291,7 +1291,7 @@ int gfs2_alloc_extent(struct inode *inode, u64 lblock, u64 *dblock,
>  /*
>   * NOTE: Never call gfs2_block_zero_range with an open transaction because it
>   * uses iomap write to perform its actions, which begin their own transactions
> - * (iomap_begin, page_prepare, etc.)
> + * (iomap_begin, get_folio, etc.)
>   */
>  static int gfs2_block_zero_range(struct inode *inode, loff_t from,
>  				 unsigned int length)
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 7decd8cdc755..4f363d42dbaf 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -642,8 +642,8 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  	if (!mapping_large_folio_support(iter->inode->i_mapping))
>  		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
>  
> -	if (page_ops && page_ops->page_prepare)
> -		folio = page_ops->page_prepare(iter, pos, len);
> +	if (page_ops && page_ops->get_folio)
> +		folio = page_ops->get_folio(iter, pos, len);
>  	else
>  		folio = iomap_get_folio(iter, pos);
>  	if (IS_ERR(folio))
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 87b5d0f8e578..dd3575ada5d1 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -126,17 +126,17 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
>  }
>  
>  /*
> - * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
> + * When a filesystem sets page_ops in an iomap mapping it returns, get_folio
>   * and put_folio will be called for each page written to.  This only applies to
>   * buffered writes as unbuffered writes will not typically have pages
>   * associated with them.
>   *
> - * When page_prepare succeeds, put_folio will always be called to do any
> + * When get_folio succeeds, put_folio will always be called to do any
>   * cleanup work necessary.  put_folio is responsible for unlocking and putting
>   * @folio.
>   */
>  struct iomap_page_ops {
> -	struct folio *(*page_prepare)(struct iomap_iter *iter, loff_t pos,
> +	struct folio *(*get_folio)(struct iomap_iter *iter, loff_t pos,
>  			unsigned len);
>  	void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
>  			struct folio *folio);
> -- 
> 2.38.1
> 
