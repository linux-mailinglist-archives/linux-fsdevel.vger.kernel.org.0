Return-Path: <linux-fsdevel+bounces-27661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8437E9634F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 00:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478FE2847ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 22:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26C31AD3FD;
	Wed, 28 Aug 2024 22:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axjCM3IJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B59158546;
	Wed, 28 Aug 2024 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885062; cv=none; b=jfq9JqO2pJP6YuirdIPpMdoxs5oJhT0TjnMqCjJjj8kUG0Q/OQLEYPbvSu3FRo581SWFuV+f8yCsNPSMbQbZ9UkJs7Xm8pvo09CtWtmtgq/7l4sCb5nigUCY+x345a7R6g8jyfawHARPqap4j4mA9oBwwfSAQ3MNH/qTgtN0Xxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885062; c=relaxed/simple;
	bh=R9mW+ylzhLy0IuXvjpnz+Mkgv/g706DtNj6l5N3dz3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sumrQb5ZqlWqQDYmNX4qquVCRrkvBJmC2OurV8ihjSC1SL23E2jZ+xene9J+BJN40eMS1MhNfhL8Led3TamEQYrUi7nsCXYkZE1ZRBxyQn1oQ5pFE4fZ86QudoQxpr/U1fpUDfBwLux6Yk3HgmK2SYtxvC1k99cxKMGn0PSe7nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axjCM3IJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983B0C4CEC0;
	Wed, 28 Aug 2024 22:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724885061;
	bh=R9mW+ylzhLy0IuXvjpnz+Mkgv/g706DtNj6l5N3dz3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axjCM3IJXSdCk5LULIa1Te76ICLXuceArRT12movyQZTv3c1gcgyOdztEHcmQSDBK
	 +Y+Un9M9FTC2O2+YxsWMtujG85iTOo+D2JkRf4YhH2kWYE9NzrjcCdtfDSutcK3QFc
	 D0A3s2zp2+qzeiTsABWGyNTidG/GsVFW2k0XjwrtBjbMX80bAyyax5D6q9DgBTM7P9
	 H62ZgvsuoPg8wxw8IfbK/HZQKoAGDaKLIsA7nFBjpvFH7eh27GLJlEYmgE6NTANE2H
	 xxH7fW0WpSXLFKOdhZprBErwKM+7+URtasXkdh8cZPEKxgt/tzzmUDJvAXkkzCx050
	 Wz0xC9ChTFHlw==
Date: Wed, 28 Aug 2024 15:44:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	josef@toxicpanda.com, david@fromorbit.com
Subject: Re: [PATCH v2 2/2] iomap: make zero range flush conditional on
 unwritten mappings
Message-ID: <20240828224420.GC6224@frogsfrogsfrogs>
References: <20240828181912.41517-1-bfoster@redhat.com>
 <20240828181912.41517-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828181912.41517-3-bfoster@redhat.com>

On Wed, Aug 28, 2024 at 02:19:11PM -0400, Brian Foster wrote:
> iomap_zero_range() flushes pagecache to mitigate consistency
> problems with dirty pagecache and unwritten mappings. The flush is
> unconditional over the entire range because checking pagecache state
> after mapping lookup is racy with writeback and reclaim. There are
> ways around this using iomap's mapping revalidation mechanism, but
> this is not supported by all iomap based filesystems and so is not a
> generic solution.
> 
> There is another way around this limitation that is good enough to
> filter the flush for most cases in practice. If we check for dirty
> pagecache over the target range (instead of unconditionally flush),
> we can keep track of whether the range was dirty before lookup and
> defer the flush until/unless we see a combination of dirty cache
> backed by an unwritten mapping. We don't necessarily know whether
> the dirty cache was backed by the unwritten maping or some other
> (written) part of the range, but the impliciation of a false
> positive here is a spurious flush and thus relatively harmless.
> 
> Note that we also flush for hole mappings because iomap_zero_range()
> is used for partial folio zeroing in some cases. For example, if a
> folio straddles EOF on a sub-page FSB size fs, the post-eof portion
> is hole-backed and dirtied/written via mapped write, and then i_size
> increases before writeback can occur (which otherwise zeroes the
> post-eof portion of the EOF folio), then the folio becomes
> inconsistent with disk until reclaimed. A flush in this case
> executes partial zeroing from writeback, and iomap knows that there
> is otherwise no I/O to submit for hole backed mappings.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 57 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 48 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3e846f43ff48..a6e897e6e303 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1393,16 +1393,47 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_unshare);
>  
> -static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> +/*
> + * Flush the remaining range of the iter and mark the current mapping stale.
> + * This is used when zero range sees an unwritten mapping that may have had
> + * dirty pagecache over it.
> + */
> +static inline int iomap_zero_iter_flush_and_stale(struct iomap_iter *i)
> +{
> +	struct address_space *mapping = i->inode->i_mapping;
> +	loff_t end = i->pos + i->len - 1;
> +
> +	i->iomap.flags |= IOMAP_F_STALE;
> +	return filemap_write_and_wait_range(mapping, i->pos, end);
> +}
> +
> +static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
> +		bool *range_dirty)
>  {
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	loff_t pos = iter->pos;
>  	loff_t length = iomap_length(iter);
>  	loff_t written = 0;
>  
> -	/* already zeroed?  we're done. */
> -	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
> +	/*
> +	 * We can skip pre-zeroed mappings so long as either the mapping was
> +	 * clean before we started or we've flushed at least once since.
> +	 * Otherwise we don't know whether the current mapping had dirty
> +	 * pagecache, so flush it now, stale the current mapping, and proceed
> +	 * from there.
> +	 *
> +	 * The hole case is intentionally included because this is (ab)used to
> +	 * handle partial folio zeroing in some cases. Hole backed post-eof
> +	 * ranges can be dirtied via mapped write and the flush triggers
> +	 * writeback time post-eof zeroing.
> +	 */
> +	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN) {
> +		if (*range_dirty) {
> +			*range_dirty = false;
> +			return iomap_zero_iter_flush_and_stale(iter);
> +		}
>  		return length;
> +	}
>  
>  	do {
>  		struct folio *folio;
> @@ -1450,19 +1481,27 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  		.flags		= IOMAP_ZERO,
>  	};
>  	int ret;
> +	bool range_dirty;
>  
>  	/*
>  	 * Zero range wants to skip pre-zeroed (i.e. unwritten) mappings, but
>  	 * pagecache must be flushed to ensure stale data from previous
> -	 * buffered writes is not exposed.
> +	 * buffered writes is not exposed. A flush is only required for certain
> +	 * types of mappings, but checking pagecache after mapping lookup is
> +	 * racy with writeback and reclaim.
> +	 *
> +	 * Therefore, check the entire range first and pass along whether any
> +	 * part of it is dirty. If so and an underlying mapping warrants it,
> +	 * flush the cache at that point. This trades off the occasional false
> +	 * positive (and spurious flush, if the dirty data and mapping don't
> +	 * happen to overlap) for simplicity in handling a relatively uncommon
> +	 * situation.
>  	 */
> -	ret = filemap_write_and_wait_range(inode->i_mapping,
> -			pos, pos + len - 1);
> -	if (ret)
> -		return ret;
> +	range_dirty = filemap_range_needs_writeback(inode->i_mapping,
> +					pos, pos + len - 1);
>  
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.processed = iomap_zero_iter(&iter, did_zero);
> +		iter.processed = iomap_zero_iter(&iter, did_zero, &range_dirty);

Style nit: Could we do this flush-and-stale from the loop body instead
of passing pointers around?  e.g.

static inline bool iomap_zero_need_flush(const struct iomap_iter *i)
{
	const struct iomap *srcmap = iomap_iter_srcmap(iter);

	return srcmap->type == IOMAP_HOLE ||
	       srcmap->type == IOMAP_UNWRITTEN;
}

static inline int iomap_zero_iter_flush(struct iomap_iter *i)
{
	struct address_space *mapping = i->inode->i_mapping;
	loff_t end = i->pos + i->len - 1;

	i->iomap.flags |= IOMAP_F_STALE;
	return filemap_write_and_wait_range(mapping, i->pos, end);
}

and then:

	range_dirty = filemap_range_needs_writeback(...);

	while ((ret = iomap_iter(&iter, ops)) > 0) {
		if (range_dirty && iomap_zero_need_flush(&iter)) {
			/*
			 * Zero range wants to skip pre-zeroed (i.e.
			 * unwritten) mappings, but...
			 */
			range_dirty = false;
			iter.processed = iomap_zero_iter_flush(&iter);
		} else {
			iter.processed = iomap_zero_iter(&iter, did_zero);
		}
	}

The logic looks correct and sensible. :)

--D

>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_zero_range);
> -- 
> 2.45.0
> 
> 

