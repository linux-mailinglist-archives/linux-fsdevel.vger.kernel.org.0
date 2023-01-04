Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BCE65DBAD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 18:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbjADRyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 12:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239577AbjADRxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:53:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA8E3D1DC;
        Wed,  4 Jan 2023 09:53:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14922B818A4;
        Wed,  4 Jan 2023 17:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995A1C433A7;
        Wed,  4 Jan 2023 17:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672854797;
        bh=G9U1tpq7PCHeqfV/r9uKw1F6XQOioC7vjMP4gwSqTJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KP89nGG84y/s04RqJerFKt5ibLvhRwLWQIioyhq30k9A97H+FP2ZUoiFIP4XXKmUe
         T7MjL66prHrwh8r81UKn0G1mzscEswEF6wn7jbI889CkC9XR5QvWD7WaUIAnxY1uhF
         yJhxvlfGn51ALg5dhUF/Aogb3WpB4DMB8FrMr7rPTOGFpmrgLrmYySn4VYMnAO5Zy8
         0XGW9CAW0diZHYhsp21FsaroFLS9z4BH7TyfXVkN7rumqSRZaN6uK7unM/Gu1fH7LP
         xt5xdev1KHq9dHcpSjEFqdkZxT/0MbYsNj0x2pTIsu+saSnW9hxDGuBFH717F3RkWw
         7hlJd+UXMEtiQ==
Date:   Wed, 4 Jan 2023 09:53:17 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH v5 7/9] iomap/xfs: Eliminate the iomap_valid handler
Message-ID: <Y7W9Dfub1WeTvG8G@magnolia>
References: <20221231150919.659533-1-agruenba@redhat.com>
 <20221231150919.659533-8-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231150919.659533-8-agruenba@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 31, 2022 at 04:09:17PM +0100, Andreas Gruenbacher wrote:
> Eliminate the ->iomap_valid() handler by switching to a ->get_folio()
> handler and validating the mapping there.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 25 +++++--------------------
>  fs/xfs/xfs_iomap.c     | 37 ++++++++++++++++++++++++++-----------
>  include/linux/iomap.h  | 22 +++++-----------------
>  3 files changed, 36 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 4f363d42dbaf..df6fca11f18c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -630,7 +630,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	struct folio *folio;
> -	int status = 0;
> +	int status;
>  
>  	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
>  	if (srcmap != &iter->iomap)
> @@ -646,27 +646,12 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  		folio = page_ops->get_folio(iter, pos, len);
>  	else
>  		folio = iomap_get_folio(iter, pos);
> -	if (IS_ERR(folio))
> -		return PTR_ERR(folio);
> -
> -	/*
> -	 * Now we have a locked folio, before we do anything with it we need to
> -	 * check that the iomap we have cached is not stale. The inode extent
> -	 * mapping can change due to concurrent IO in flight (e.g.
> -	 * IOMAP_UNWRITTEN state can change and memory reclaim could have
> -	 * reclaimed a previously partially written page at this index after IO
> -	 * completion before this write reaches this file offset) and hence we
> -	 * could do the wrong thing here (zero a page range incorrectly or fail
> -	 * to zero) and corrupt data.
> -	 */
> -	if (page_ops && page_ops->iomap_valid) {
> -		bool iomap_valid = page_ops->iomap_valid(iter->inode,
> -							&iter->iomap);
> -		if (!iomap_valid) {
> +	if (IS_ERR(folio)) {
> +		if (folio == ERR_PTR(-ESTALE)) {
>  			iter->iomap.flags |= IOMAP_F_STALE;
> -			status = 0;
> -			goto out_unlock;
> +			return 0;
>  		}
> +		return PTR_ERR(folio);

I wonder if this should be reworked a bit to reduce indenting:

	if (PTR_ERR(folio) == -ESTALE) {
		iter->iomap.flags |= IOMAP_F_STALE;
		return 0;
	}
	if (IS_ERR(folio))
		return PTR_ERR(folio);

But I don't have any strong opinions about that.

>  	}
>  
>  	if (pos + len > folio_pos(folio) + folio_size(folio))
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 669c1bc5c3a7..d0bf99539180 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -62,29 +62,44 @@ xfs_iomap_inode_sequence(
>  	return cookie | READ_ONCE(ip->i_df.if_seq);
>  }
>  
> -/*
> - * Check that the iomap passed to us is still valid for the given offset and
> - * length.
> - */
> -static bool
> -xfs_iomap_valid(
> -	struct inode		*inode,
> -	const struct iomap	*iomap)
> +static struct folio *
> +xfs_get_folio(
> +	struct iomap_iter	*iter,
> +	loff_t			pos,
> +	unsigned		len)
>  {
> +	struct inode		*inode = iter->inode;
> +	struct iomap		*iomap = &iter->iomap;
>  	struct xfs_inode	*ip = XFS_I(inode);
> +	struct folio		*folio;
>  
> +	folio = iomap_get_folio(iter, pos);
> +	if (IS_ERR(folio))
> +		return folio;
> +
> +	/*
> +	 * Now that we have a locked folio, we need to check that the iomap we
> +	 * have cached is not stale.  The inode extent mapping can change due to
> +	 * concurrent IO in flight (e.g., IOMAP_UNWRITTEN state can change and
> +	 * memory reclaim could have reclaimed a previously partially written
> +	 * page at this index after IO completion before this write reaches
> +	 * this file offset) and hence we could do the wrong thing here (zero a
> +	 * page range incorrectly or fail to zero) and corrupt data.
> +	 */
>  	if (iomap->validity_cookie !=
>  			xfs_iomap_inode_sequence(ip, iomap->flags)) {
>  		trace_xfs_iomap_invalid(ip, iomap);
> -		return false;
> +		folio_unlock(folio);
> +		folio_put(folio);
> +		return ERR_PTR(-ESTALE);
>  	}
>  
>  	XFS_ERRORTAG_DELAY(ip->i_mount, XFS_ERRTAG_WRITE_DELAY_MS);
> -	return true;
> +	return folio;
>  }
>  
>  const struct iomap_page_ops xfs_iomap_page_ops = {
> -	.iomap_valid		= xfs_iomap_valid,
> +	.get_folio		= xfs_get_folio,
>  };
>  
>  int
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index dd3575ada5d1..6f8e3321e475 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -134,29 +134,17 @@ static inline bool iomap_inline_data_valid(const struct iomap *iomap)
>   * When get_folio succeeds, put_folio will always be called to do any
>   * cleanup work necessary.  put_folio is responsible for unlocking and putting
>   * @folio.
> + *
> + * When an iomap is created, the filesystem can store internal state (e.g., a
> + * sequence number) in iomap->validity_cookie.  When it then detects in the

I would reword this to:

"When an iomap is created, the filesystem can store internal state (e.g.
sequence number) in iomap->validity_cookie.  The get_folio handler can
use this validity cookie to detect if the iomap is no longer up to date
and needs to be refreshed.  If this is the case, the function should
return ERR_PTR(-ESTALE) to retry the operation with a fresh mapping."

--D

> + * get_folio handler that the iomap is no longer up to date and needs to be
> + * refreshed, it can return ERR_PTR(-ESTALE) to trigger a retry.
>   */
>  struct iomap_page_ops {
>  	struct folio *(*get_folio)(struct iomap_iter *iter, loff_t pos,
>  			unsigned len);
>  	void (*put_folio)(struct inode *inode, loff_t pos, unsigned copied,
>  			struct folio *folio);
> -
> -	/*
> -	 * Check that the cached iomap still maps correctly to the filesystem's
> -	 * internal extent map. FS internal extent maps can change while iomap
> -	 * is iterating a cached iomap, so this hook allows iomap to detect that
> -	 * the iomap needs to be refreshed during a long running write
> -	 * operation.
> -	 *
> -	 * The filesystem can store internal state (e.g. a sequence number) in
> -	 * iomap->validity_cookie when the iomap is first mapped to be able to
> -	 * detect changes between mapping time and whenever .iomap_valid() is
> -	 * called.
> -	 *
> -	 * This is called with the folio over the specified file position held
> -	 * locked by the iomap code.
> -	 */
> -	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
>  };
>  
>  /*
> -- 
> 2.38.1
> 
