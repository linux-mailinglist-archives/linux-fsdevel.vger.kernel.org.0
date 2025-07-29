Return-Path: <linux-fsdevel+bounces-56286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A014B1553A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 00:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C0E4E1192
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 22:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E0B283FC9;
	Tue, 29 Jul 2025 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0ij3xPo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5669615533F;
	Tue, 29 Jul 2025 22:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753827773; cv=none; b=KcTTeQ7LeDc1G36NbflHpD3h2AkEuTPnW5OVjU+8e3xyeTH3FKrcg24cc0ocKbVbssOE3lys7LLQEkWQYWXQHWIyKUUksQ92RVYRBWp0LR/jiz8y0otqiUHIOrHRivzrsV7pn+aBCb+Z+Y8QWbg8P2MF4Ns9/qRVfe709DCXbVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753827773; c=relaxed/simple;
	bh=2pfJ8ECQygmuXE+SAxq+Ar3wEl3aaGMm0AxzH8iMiEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkQ4jTtiV3GptP9zfy6EkFma6QhY4bD38xS1OsFPoh3+0k3lNrpgjkrwAcAc+i/BxG3L/N480hZjEz0Lq8dcGVBqSYXz6eBNxWYoGkxtWQpnDjMtQkX7duqqqUrS5a+hEqfNDBCjoq0Dy8JOmRc2hA63BCnbRfOjjiXTwBDB7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0ij3xPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA0FC4CEEF;
	Tue, 29 Jul 2025 22:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753827772;
	bh=2pfJ8ECQygmuXE+SAxq+Ar3wEl3aaGMm0AxzH8iMiEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0ij3xPoA2qbQ09QimCAhZHdQ8I8bi/k5XeS1SjbpSjCY8lhzp6fsn7JtfpPbRI/Z
	 7zu/ZZ5aS6Dm7RGzhzJgOrPWibpFu1MVROSFLnW6YLZuH/dkhitYLSenCNrtvg/cpn
	 hY0QfPWdyWoXmo4yQ8LJryVgVBbnq8TCozC5cXSOToMu29X7yveQCZb7yUDwC9ZjKx
	 thsnhi01z2NoyfWVnSUO0XFFoJr9qdc/uoPK403vf7GKpze6PISBEH7wKTvcydJ+UJ
	 Ymizx4TLa/U2UZEMrj4HI3s/VJIqOf9UZfqZD57CPdYmFl9qa1gjdEEgCSray2nnf+
	 zfnIuH62ZL1aA==
Date: Tue, 29 Jul 2025 15:22:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, david@fromorbit.com, ebiggers@kernel.org,
	hch@lst.de, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 02/29] iomap: introduce iomap_read/write_region
 interface
Message-ID: <20250729222252.GJ2672049@frogsfrogsfrogs>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-2-9e5443af0e34@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-fsverity-v1-2-9e5443af0e34@kernel.org>

On Mon, Jul 28, 2025 at 10:30:06PM +0200, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> Interface for writing data beyond EOF into offsetted region in
> page cache.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  include/linux/iomap.h  | 16 ++++++++
>  fs/iomap/buffered-io.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 114 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 4a0b5ebb79e9..73288f28543f 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -83,6 +83,11 @@ struct vm_fault;
>   */
>  #define IOMAP_F_PRIVATE		(1U << 12)
>  
> +/*
> + * Writes happens beyound inode EOF
> + */
> +#define IOMAP_F_BEYOND_EOF	(1U << 13)
> +
>  /*
>   * Flags set by the core iomap code during operations:
>   *
> @@ -533,4 +538,15 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
>  
>  extern struct bio_set iomap_ioend_bioset;
>  
> +struct ioregion {
> +	struct inode *inode;
> +	loff_t pos;				/* IO position */
> +	const void *buf;			/* Data to be written (in only) */
> +	size_t length;				/* Length of the date */

Length of the data ?

> +	const struct iomap_ops *ops;
> +};

This sounds like a kiocb and a kvec...

> +
> +struct folio *iomap_read_region(struct ioregion *region);
> +int iomap_write_region(struct ioregion *region);

...and these sound a lot like filemap_read and iomap_write_iter.
Why not use those?  You'd get readahead for free.  Though I guess
filemap_read cuts off at i_size so maybe that's why this is necessary?

(and by extension, is this why the existing fsverity implementations
seem to do their own readahead and reading?)

((and now I guess I see why this isn't done through the regular kiocb
interface, because then we'd be exposing post-EOF data hiding to
everyone in the system))

>  #endif /* LINUX_IOMAP_H */
> 
> -- 
> 2.50.0
> 
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 7bef232254a3..e959a206cba9 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -321,6 +321,7 @@ struct iomap_readpage_ctx {
>  	bool			cur_folio_in_bio;
>  	struct bio		*bio;
>  	struct readahead_control *rac;
> +	int			flags;

What flags go in here?

>  };
>  
>  /**
> @@ -387,7 +388,8 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
>  	if (plen == 0)
>  		goto done;
>  
> -	if (iomap_block_needs_zeroing(iter, pos)) {
> +	if (iomap_block_needs_zeroing(iter, pos) &&
> +	    !(iomap->flags & IOMAP_F_BEYOND_EOF)) {
>  		folio_zero_range(folio, poff, plen);
>  		iomap_set_range_uptodate(folio, poff, plen);
>  		goto done;
> @@ -2007,3 +2009,98 @@ iomap_writepages_unbound(struct address_space *mapping, struct writeback_control
>  	return iomap_submit_ioend(wpc, error);
>  }
>  EXPORT_SYMBOL_GPL(iomap_writepages_unbound);
> +
> +struct folio *
> +iomap_read_region(struct ioregion *region)
> +{
> +	struct inode *inode = region->inode;
> +	fgf_t fgp = FGP_CREAT | FGP_LOCK | fgf_set_order(region->length);
> +	pgoff_t index = (region->pos) >> PAGE_SHIFT;
> +	struct folio *folio = __filemap_get_folio(inode->i_mapping, index, fgp,
> +				    mapping_gfp_mask(inode->i_mapping));
> +	int ret;
> +	struct iomap_iter iter = {
> +		.inode		= folio->mapping->host,
> +		.pos		= region->pos,
> +		.len		= region->length,
> +	};
> +	struct iomap_readpage_ctx ctx = {
> +		.cur_folio	= folio,
> +	};
> +
> +	if (folio_test_uptodate(folio)) {
> +		folio_unlock(folio);
> +		return folio;
> +	}
> +
> +	while ((ret = iomap_iter(&iter, region->ops)) > 0)
> +		iter.status = iomap_read_folio_iter(&iter, &ctx);

Huh, we don't read into region->buf?  Oh, I see, this gets iomap to
install an uptodate folio in the pagecache, and then later we can
just hand it to fsverity.  Maybe?

--D

> +
> +	if (ctx.bio) {
> +		submit_bio(ctx.bio);
> +		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
> +	} else {
> +		WARN_ON_ONCE(ctx.cur_folio_in_bio);
> +		folio_unlock(folio);
> +	}
> +
> +	return folio;
> +}
> +EXPORT_SYMBOL_GPL(iomap_read_region);
> +
> +static int iomap_write_region_iter(struct iomap_iter *iter, const void *buf)
> +{
> +	loff_t pos = iter->pos;
> +	u64 bytes = iomap_length(iter);
> +	int status;
> +
> +	do {
> +		struct folio *folio;
> +		size_t offset;
> +		bool ret;

Is balance_dirty_pages_ratelimited_flags need here if we're at the dirty
thresholds?

> +
> +		bytes = min_t(u64, SIZE_MAX, bytes);
> +		status = iomap_write_begin(iter, &folio, &offset, &bytes);
> +		if (status)
> +			return status;
> +		if (iter->iomap.flags & IOMAP_F_STALE)
> +			break;
> +
> +		offset = offset_in_folio(folio, pos);
> +		if (bytes > folio_size(folio) - offset)
> +			bytes = folio_size(folio) - offset;
> +
> +		memcpy_to_folio(folio, offset, buf, bytes);
> +
> +		ret = iomap_write_end(iter, bytes, bytes, folio);
> +		if (WARN_ON_ONCE(!ret))
> +			return -EIO;
> +
> +		__iomap_put_folio(iter, bytes, folio);
> +		if (WARN_ON_ONCE(!ret))
> +			return -EIO;
> +
> +		status = iomap_iter_advance(iter, &bytes);
> +		if (status)
> +			break;
> +	} while (bytes > 0);
> +
> +	return status;
> +}

Hrm, stripped down version of iomap_write_iter without the isize
updates.

--D

> +
> +int
> +iomap_write_region(struct ioregion *region)
> +{
> +	struct iomap_iter iter = {
> +		.inode		= region->inode,
> +		.pos		= region->pos,
> +		.len		= region->length,
> +	};
> +	ssize_t ret;
> +
> +	while ((ret = iomap_iter(&iter, region->ops)) > 0)
> +		iter.status = iomap_write_region_iter(&iter, region->buf);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iomap_write_region);

