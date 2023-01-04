Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9572D65DBB1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 18:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbjADRz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 12:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240163AbjADRzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:55:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524F74086E;
        Wed,  4 Jan 2023 09:53:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C24A5B8188A;
        Wed,  4 Jan 2023 17:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA2CC433EF;
        Wed,  4 Jan 2023 17:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672854814;
        bh=14iHohPaMDWcxHiPz7x3Ct3bJsKuuBxxpXFIJO8SUiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZWJpqmA3WP/UFajTb7dL3x0LikMreoVlzmoTtADAt20O59YFhQsIQNp0x20d3dnDC
         9Mi/qj+Js8rLGIGymURZgW9uoWoDP9uGh7U80KBae6pWMeHMuZmtV+BbBgxqSE5igu
         e/e6w3HQRs+awYXyADXcmhqdNecXDEX+WAfE6uOg650d9dfpfPIplgBcGS6+ZAu6I8
         wzVWqAc5el1dTqM6+NIsMsA4Xt0Mogh7skLOjM4wEvZJI0tSw9AjdJfIvSe1eKw/Up
         ComCL68G17Kzsv96K0Wy99+FV0e+OY/8C556eJ4BzjOUcZ6JXdKixA5O+9/jwUaRFv
         pExfG72wszckw==
Date:   Wed, 4 Jan 2023 09:53:34 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH v5 8/9] iomap: Rename page_ops to folio_ops
Message-ID: <Y7W9HlvH7zzIBJhO@magnolia>
References: <20221231150919.659533-1-agruenba@redhat.com>
 <20221231150919.659533-9-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231150919.659533-9-agruenba@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 31, 2022 at 04:09:18PM +0100, Andreas Gruenbacher wrote:
> The operations in struct page_ops all operate on folios, so rename
> struct page_ops to struct folio_ops.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Yup.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/gfs2/bmap.c         |  4 ++--
>  fs/iomap/buffered-io.c | 12 ++++++------
>  fs/xfs/xfs_iomap.c     |  4 ++--
>  include/linux/iomap.h  | 14 +++++++-------
>  4 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index d3adb715ac8c..e191ecfb1fde 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -997,7 +997,7 @@ static void gfs2_iomap_put_folio(struct inode *inode, loff_t pos,
>  	gfs2_trans_end(sdp);
>  }
>  
> -static const struct iomap_page_ops gfs2_iomap_page_ops = {
> +static const struct iomap_folio_ops gfs2_iomap_folio_ops = {
>  	.get_folio = gfs2_iomap_get_folio,
>  	.put_folio = gfs2_iomap_put_folio,
>  };
> @@ -1075,7 +1075,7 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
>  	}
>  
>  	if (gfs2_is_stuffed(ip) || gfs2_is_jdata(ip))
> -		iomap->page_ops = &gfs2_iomap_page_ops;
> +		iomap->folio_ops = &gfs2_iomap_folio_ops;
>  	return 0;
>  
>  out_trans_end:
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index df6fca11f18c..c4a7aef2a272 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -605,10 +605,10 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  static void iomap_put_folio(struct iomap_iter *iter, loff_t pos, size_t ret,
>  		struct folio *folio)
>  {
> -	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
> +	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
>  
> -	if (page_ops && page_ops->put_folio) {
> -		page_ops->put_folio(iter->inode, pos, ret, folio);
> +	if (folio_ops && folio_ops->put_folio) {
> +		folio_ops->put_folio(iter->inode, pos, ret, folio);
>  	} else {
>  		folio_unlock(folio);
>  		folio_put(folio);
> @@ -627,7 +627,7 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
>  static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  		size_t len, struct folio **foliop)
>  {
> -	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
> +	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	struct folio *folio;
>  	int status;
> @@ -642,8 +642,8 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  	if (!mapping_large_folio_support(iter->inode->i_mapping))
>  		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
>  
> -	if (page_ops && page_ops->get_folio)
> -		folio = page_ops->get_folio(iter, pos, len);
> +	if (folio_ops && folio_ops->get_folio)
> +		folio = folio_ops->get_folio(iter, pos, len);
>  	else
>  		folio = iomap_get_folio(iter, pos);
>  	if (IS_ERR(folio)) {
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index d0bf99539180..5bddf31e21eb 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -98,7 +98,7 @@ xfs_get_folio(
>  	return folio;
>  }
>  
> -const struct iomap_page_ops xfs_iomap_page_ops = {
> +const struct iomap_folio_ops xfs_iomap_folio_ops = {
>  	.get_folio		= xfs_get_folio,
>  };
>  
> @@ -148,7 +148,7 @@ xfs_bmbt_to_iomap(
>  		iomap->flags |= IOMAP_F_DIRTY;
>  
>  	iomap->validity_cookie = sequence_cookie;
> -	iomap->page_ops = &xfs_iomap_page_ops;
> +	iomap->folio_ops = &xfs_iomap_folio_ops;
>  	return 0;
>  }
>  
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 6f8e3321e475..2e2be828af86 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -86,7 +86,7 @@ struct vm_fault;
>   */
>  #define IOMAP_NULL_ADDR -1ULL	/* addr is not valid */
>  
> -struct iomap_page_ops;
> +struct iomap_folio_ops;
>  
>  struct iomap {
>  	u64			addr; /* disk offset of mapping, bytes */
> @@ -98,7 +98,7 @@ struct iomap {
>  	struct dax_device	*dax_dev; /* dax_dev for dax operations */
>  	void			*inline_data;
>  	void			*private; /* filesystem private */
> -	const struct iomap_page_ops *page_ops;
> +	const struct iomap_folio_ops *folio_ops;
>  	u64			validity_cookie; /* used with .iomap_valid() */
>  };
>  
> @@ -126,10 +126,10 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
>  }
>  
>  /*
> - * When a filesystem sets page_ops in an iomap mapping it returns, get_folio
> - * and put_folio will be called for each page written to.  This only applies to
> - * buffered writes as unbuffered writes will not typically have pages
> - * associated with them.
> + * When a filesystem sets folio_ops in an iomap mapping it returns,
> + * get_folio and put_folio will be called for each page written to.  This
> + * only applies to buffered writes as unbuffered writes will not typically have
> + * pages associated with them.
>   *
>   * When get_folio succeeds, put_folio will always be called to do any
>   * cleanup work necessary.  put_folio is responsible for unlocking and putting
> @@ -140,7 +140,7 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
>   * get_folio handler that the iomap is no longer up to date and needs to be
>   * refreshed, it can return ERR_PTR(-ESTALE) to trigger a retry.
>   */
> -struct iomap_page_ops {
> +struct iomap_folio_ops {
>  	struct folio *(*get_folio)(struct iomap_iter *iter, loff_t pos,
>  			unsigned len);
>  	void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
> -- 
> 2.38.1
> 
