Return-Path: <linux-fsdevel+bounces-53702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C152FAF6101
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 20:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA511C4092E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6A730E859;
	Wed,  2 Jul 2025 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LquPCIC1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCA719A;
	Wed,  2 Jul 2025 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480411; cv=none; b=ST0ZJ6U17F35hr2N6OxhFHfU2opEUD46hYPI0Wt1Aa+ijfzuOx/QFixgfPVzByGePMR0yRZRgysEkszW8nsonD5zAtO1wHbs/9Ehly1kHFXQs6OUyylRvc/Wq2Ajs1cckQh5kS6Jj4JL+O6JGi694HbIsE2NK4pb9pEy0h/mqwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480411; c=relaxed/simple;
	bh=d9ylYtWm1S51U7EmtOKS+lplSVp0dTFYpFrtv5yNCH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImM76dJMMpcMoSa7+3XKHsHuClq9ybSVmL5a54hrx6sRbrGMsESeQWy3nUEysoJMlxAG0Fw1cqx0QBfFZa4jBvQ9MneP+4QxQj432hWuToS9x+zZ+bonfmp6q7CrYQ13SuYGylBJuDm+b9iUteqDkTgzTlrY2UjpNeoaU+WDQHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LquPCIC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011F6C4CEE7;
	Wed,  2 Jul 2025 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751480411;
	bh=d9ylYtWm1S51U7EmtOKS+lplSVp0dTFYpFrtv5yNCH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LquPCIC1e87Xwj2+u+mXQ1vGCZPElptfNhIaL62ib+0QAexRruPs7Dy3+jt1cAMIh
	 rOpP8q9i/9ba0S1at1Y5/tCd/xyOxi6uvmHDphyEQRvmWZViQDmcnpFXT1VkSP79nK
	 iPorZaXhV2zj5vUEzXaLeSHDmyN6lmLz4mMY3qYsiPpXFlyWvkQIvMgpWWFLgbYwBT
	 f8bYeb3I1llhKCNy1m/2xu/8d5tn1Wx5o3HtDmx5HXpAKGKi+bZ3Pyz6gX2zMG33zp
	 9XzoQjVHLuYWR0B5YlSC7699c01v9U7QlNesbkKZkPzKluTsF78dxaRHU7qZ+VRPxE
	 4S4lH8kbsDQGw==
Date: Wed, 2 Jul 2025 11:20:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 12/12] iomap: build the writeback code without
 CONFIG_BLOCK
Message-ID: <20250702182010.GM10009@frogsfrogsfrogs>
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-13-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627070328.975394-13-hch@lst.de>

On Fri, Jun 27, 2025 at 09:02:45AM +0200, Christoph Hellwig wrote:
> Allow fuse to use the iomap writeback code even when CONFIG_BLOCK is
> not enabled.  Do this with an ifdef instead of a separate file to keep
> the iomap_folio_state local to buffered-io.c.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Seems reasonable to me...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/Makefile      |   6 +--
>  fs/iomap/buffered-io.c | 113 ++++++++++++++++++++++-------------------
>  2 files changed, 64 insertions(+), 55 deletions(-)
> 
> diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
> index 69e8ebb41302..f7e1c8534c46 100644
> --- a/fs/iomap/Makefile
> +++ b/fs/iomap/Makefile
> @@ -9,9 +9,9 @@ ccflags-y += -I $(src)		# needed for trace events
>  obj-$(CONFIG_FS_IOMAP)		+= iomap.o
>  
>  iomap-y				+= trace.o \
> -				   iter.o
> -iomap-$(CONFIG_BLOCK)		+= buffered-io.o \
> -				   direct-io.o \
> +				   iter.o \
> +				   buffered-io.o
> +iomap-$(CONFIG_BLOCK)		+= direct-io.o \
>  				   ioend.o \
>  				   fiemap.o \
>  				   seek.o
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 1a9ade77aeeb..6ceeb0e2fc13 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -284,6 +284,46 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  	*lenp = plen;
>  }
>  
> +static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
> +		loff_t pos)
> +{
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> +
> +	return srcmap->type != IOMAP_MAPPED ||
> +		(srcmap->flags & IOMAP_F_NEW) ||
> +		pos >= i_size_read(iter->inode);
> +}
> +
> +/**
> + * iomap_read_inline_data - copy inline data into the page cache
> + * @iter: iteration structure
> + * @folio: folio to copy to
> + *
> + * Copy the inline data in @iter into @folio and zero out the rest of the folio.
> + * Only a single IOMAP_INLINE extent is allowed at the end of each file.
> + * Returns zero for success to complete the read, or the usual negative errno.
> + */
> +static int iomap_read_inline_data(const struct iomap_iter *iter,
> +		struct folio *folio)
> +{
> +	const struct iomap *iomap = iomap_iter_srcmap(iter);
> +	size_t size = i_size_read(iter->inode) - iomap->offset;
> +	size_t offset = offset_in_folio(folio, iomap->offset);
> +
> +	if (folio_test_uptodate(folio))
> +		return 0;
> +
> +	if (WARN_ON_ONCE(size > iomap->length))
> +		return -EIO;
> +	if (offset > 0)
> +		ifs_alloc(iter->inode, folio, iter->flags);
> +
> +	folio_fill_tail(folio, offset, iomap->inline_data, size);
> +	iomap_set_range_uptodate(folio, offset, folio_size(folio) - offset);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_BLOCK
>  static void iomap_finish_folio_read(struct folio *folio, size_t off,
>  		size_t len, int error)
>  {
> @@ -323,45 +363,6 @@ struct iomap_readpage_ctx {
>  	struct readahead_control *rac;
>  };
>  
> -/**
> - * iomap_read_inline_data - copy inline data into the page cache
> - * @iter: iteration structure
> - * @folio: folio to copy to
> - *
> - * Copy the inline data in @iter into @folio and zero out the rest of the folio.
> - * Only a single IOMAP_INLINE extent is allowed at the end of each file.
> - * Returns zero for success to complete the read, or the usual negative errno.
> - */
> -static int iomap_read_inline_data(const struct iomap_iter *iter,
> -		struct folio *folio)
> -{
> -	const struct iomap *iomap = iomap_iter_srcmap(iter);
> -	size_t size = i_size_read(iter->inode) - iomap->offset;
> -	size_t offset = offset_in_folio(folio, iomap->offset);
> -
> -	if (folio_test_uptodate(folio))
> -		return 0;
> -
> -	if (WARN_ON_ONCE(size > iomap->length))
> -		return -EIO;
> -	if (offset > 0)
> -		ifs_alloc(iter->inode, folio, iter->flags);
> -
> -	folio_fill_tail(folio, offset, iomap->inline_data, size);
> -	iomap_set_range_uptodate(folio, offset, folio_size(folio) - offset);
> -	return 0;
> -}
> -
> -static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
> -		loff_t pos)
> -{
> -	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> -
> -	return srcmap->type != IOMAP_MAPPED ||
> -		(srcmap->flags & IOMAP_F_NEW) ||
> -		pos >= i_size_read(iter->inode);
> -}
> -
>  static int iomap_readpage_iter(struct iomap_iter *iter,
>  		struct iomap_readpage_ctx *ctx)
>  {
> @@ -554,6 +555,27 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(iomap_readahead);
>  
> +static int iomap_read_folio_range(const struct iomap_iter *iter,
> +		struct folio *folio, loff_t pos, size_t len)
> +{
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	struct bio_vec bvec;
> +	struct bio bio;
> +
> +	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
> +	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
> +	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
> +	return submit_bio_wait(&bio);
> +}
> +#else
> +static int iomap_read_folio_range(const struct iomap_iter *iter,
> +		struct folio *folio, loff_t pos, size_t len)
> +{
> +	WARN_ON_ONCE(1);
> +	return -EIO;
> +}
> +#endif /* CONFIG_BLOCK */
> +
>  /*
>   * iomap_is_partially_uptodate checks whether blocks within a folio are
>   * uptodate or not.
> @@ -667,19 +689,6 @@ iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
>  					 pos + len - 1);
>  }
>  
> -static int iomap_read_folio_range(const struct iomap_iter *iter,
> -		struct folio *folio, loff_t pos, size_t len)
> -{
> -	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> -	struct bio_vec bvec;
> -	struct bio bio;
> -
> -	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
> -	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
> -	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
> -	return submit_bio_wait(&bio);
> -}
> -
>  static int __iomap_write_begin(const struct iomap_iter *iter,
>  		const struct iomap_write_ops *write_ops, size_t len,
>  		struct folio *folio)
> -- 
> 2.47.2
> 
> 

