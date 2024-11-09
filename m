Return-Path: <linux-fsdevel+bounces-34135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12529C29A0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 04:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EC2FB21B7E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 03:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463333C488;
	Sat,  9 Nov 2024 03:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPOYt8Wb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A578D17FE
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 03:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731121288; cv=none; b=Fz7SUt+bLyGStXE0ny5hD32wDryi4M4vvrqhwKUqPZ6zFFB2IsBy6xmkHS2GigKW0rcm0wQWmLQBcx684yhDqH+r+R3usobxzCZD93PBo9sEOu/xdRAvxp6UvyikHHFDdebISEDn8f3Dkt84TLR1VGvOj5zJTKtaG/nmRrUFnio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731121288; c=relaxed/simple;
	bh=RWkIGg0N9X8A0Lnd2QfJuqUDEB6G5XZLE/jDNWd1vZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXxPnamQqSypntX7j8Wqdkpbj2fCq/API7wC9BivCRqHxrNC2WfQIc8VmMMBEc2ewv2ypomot+orV1Z5INO2XBJldBn+tXYL4GnffujEpmNHxP+lD3Vy8fqIPMK7/fKlcNgPKOD2GxQcsfJ3xPWO5pmLWydu5nE2nWztGr9rFfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPOYt8Wb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8148CC4CECD;
	Sat,  9 Nov 2024 03:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731121288;
	bh=RWkIGg0N9X8A0Lnd2QfJuqUDEB6G5XZLE/jDNWd1vZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPOYt8Wb8F8e9gSi8A/oSAEn3gtCDf4KJLfnvsy9MVPVkqUJL27xJch+Zkx7niH1c
	 tw3rrmn/wpVRYaJr9N+H/btCe2LG3uKT34jYYQYTvGDx2PegxZgNWy8Ki5vgYWaWkE
	 YI8yfMOnzSeJfQP91SaX56df63aVvO0owo6mu6nnQWdzEar2AqsW9z0VjBKXARvCBW
	 z4NG0q/j3qWu2i/uLzjEXdKiAcMnZKApHzRRLO6RCvbMYLDRAYzXlOgxIS+An7lm6O
	 G2gLUrXGiHlETo6fWIXMVHMhDBktrkpKzmUnq7hDqb0JYt+8FO96v8VfusSv6oaK0m
	 NDq3BYPO+xiQQ==
Date: Fri, 8 Nov 2024 19:01:27 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iomap: lift zeroed mapping handling into
 iomap_zero_range()
Message-ID: <20241109030127.GB9421@frogsfrogsfrogs>
References: <20241108124246.198489-1-bfoster@redhat.com>
 <20241108124246.198489-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108124246.198489-3-bfoster@redhat.com>

On Fri, Nov 08, 2024 at 07:42:44AM -0500, Brian Foster wrote:
> In preparation for special handling of subranges, lift the zeroed
> mapping logic from the iterator into the caller. Since this puts the
> pagecache dirty check and flushing in the same place, streamline the
> comments a bit as well.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 64 +++++++++++++++---------------------------
>  1 file changed, 22 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ef0b68bccbb6..a78b5b9b3df3 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1350,40 +1350,12 @@ static inline int iomap_zero_iter_flush_and_stale(struct iomap_iter *i)
>  	return filemap_write_and_wait_range(mapping, i->pos, end);
>  }
>  
> -static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
> -		bool *range_dirty)
> +static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  {
> -	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	loff_t pos = iter->pos;
>  	loff_t length = iomap_length(iter);
>  	loff_t written = 0;
>  
> -	/*
> -	 * We must zero subranges of unwritten mappings that might be dirty in
> -	 * pagecache from previous writes. We only know whether the entire range
> -	 * was clean or not, however, and dirty folios may have been written
> -	 * back or reclaimed at any point after mapping lookup.
> -	 *
> -	 * The easiest way to deal with this is to flush pagecache to trigger
> -	 * any pending unwritten conversions and then grab the updated extents
> -	 * from the fs. The flush may change the current mapping, so mark it
> -	 * stale for the iterator to remap it for the next pass to handle
> -	 * properly.
> -	 *
> -	 * Note that holes are treated the same as unwritten because zero range
> -	 * is (ab)used for partial folio zeroing in some cases. Hole backed
> -	 * post-eof ranges can be dirtied via mapped write and the flush
> -	 * triggers writeback time post-eof zeroing.
> -	 */
> -	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN) {
> -		if (*range_dirty) {
> -			*range_dirty = false;
> -			return iomap_zero_iter_flush_and_stale(iter);
> -		}
> -		/* range is clean and already zeroed, nothing to do */
> -		return length;
> -	}
> -
>  	do {
>  		struct folio *folio;
>  		int status;
> @@ -1433,24 +1405,32 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  	bool range_dirty;
>  
>  	/*
> -	 * Zero range wants to skip pre-zeroed (i.e. unwritten) mappings, but
> -	 * pagecache must be flushed to ensure stale data from previous
> -	 * buffered writes is not exposed. A flush is only required for certain
> -	 * types of mappings, but checking pagecache after mapping lookup is
> -	 * racy with writeback and reclaim.
> +	 * Zero range can skip mappings that are zero on disk so long as
> +	 * pagecache is clean. If pagecache was dirty prior to zero range, the
> +	 * mapping converts on writeback completion and so must be zeroed.
>  	 *
> -	 * Therefore, check the entire range first and pass along whether any
> -	 * part of it is dirty. If so and an underlying mapping warrants it,
> -	 * flush the cache at that point. This trades off the occasional false
> -	 * positive (and spurious flush, if the dirty data and mapping don't
> -	 * happen to overlap) for simplicity in handling a relatively uncommon
> -	 * situation.
> +	 * The simplest way to deal with this across a range is to flush
> +	 * pagecache and process the updated mappings. To avoid an unconditional
> +	 * flush, check pagecache state and only flush if dirty and the fs
> +	 * returns a mapping that might convert on writeback.
>  	 */
>  	range_dirty = filemap_range_needs_writeback(inode->i_mapping,
>  					pos, pos + len - 1);
> +	while ((ret = iomap_iter(&iter, ops)) > 0) {
> +		const struct iomap *s = iomap_iter_srcmap(&iter);
> +
> +		if (s->type == IOMAP_HOLE || s->type == IOMAP_UNWRITTEN) {
> +			loff_t p = iomap_length(&iter);

Another dumb nit: blank line after the declaration.

With that fixed, this is ok by me for further testing:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +			if (range_dirty) {
> +				range_dirty = false;
> +				p = iomap_zero_iter_flush_and_stale(&iter);
> +			}
> +			iter.processed = p;
> +			continue;
> +		}
>  
> -	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.processed = iomap_zero_iter(&iter, did_zero, &range_dirty);
> +		iter.processed = iomap_zero_iter(&iter, did_zero);
> +	}
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_zero_range);
> -- 
> 2.47.0
> 
> 

