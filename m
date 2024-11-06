Return-Path: <linux-fsdevel+bounces-33709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AB09BDA1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 01:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF3F1C22298
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 00:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86732653;
	Wed,  6 Nov 2024 00:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtyhK96z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E1336C
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 00:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730852065; cv=none; b=hef78HotvTB5yo2q+GKt8/9Hk3FKEI1MfhW9g2cZpb2SIRZpwvhOIx3ToAkfldNHTrx6GmwYSjhT1Ll8bqD39PKk6xrYUQmHAhQHLicaxau1pa5M7QSAS6KBqRLEyAhZeLq0I7cWVhoZHeeMCWXbba3xIsi3ATgrqiNE9BMFhig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730852065; c=relaxed/simple;
	bh=R0KrIWrGTfA1qUrQLoI4Ams9CNHdTLlBD8k93kZCa3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7f9vs77/eYA8gvdEcE763OM6jYKG6aA4YpBmg05trXebSkK5SCe/U3gjt5Ua+SGx6xuhj6DIY1FcvM6Q9THQGMXzvOt2q+I/LjYQmeEcq30+x/2i3dh02S3KpnpzTmYb5GAb7kw+barKK40tiOFE/kmZ8RaBLKwiGaN/PAZKxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtyhK96z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675E7C4CECF;
	Wed,  6 Nov 2024 00:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730852064;
	bh=R0KrIWrGTfA1qUrQLoI4Ams9CNHdTLlBD8k93kZCa3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WtyhK96zsep7p0xe7ZtqOByqx8bPHC82z/+BbtHyBZlcT44J0FD26keeixapRm+sr
	 E6G3MJYAuE2ss4VWwyeai1hKWLz4NWBH5IAv2mAZHekNBixPt4pf8Nw42ncIgwKHGq
	 xvDQvTdhfb2AkQrsuP/qmDk0KReJu2Ww9cATPqxwxtDqfavXjwqyufp1AYRet1euge
	 4nZh6PjwTfYbOkQ87YJK7N0fnb97EQ6RRBd/6WME/U2dI+biD7KqpoEnbEw2ZusOPh
	 uwowEdF1wppYLKoN6sosSGd24PHTPW3rPiqiTTLZsH5hFNDxLnAt0m2QFx/9SpG7tU
	 OtX7vtiOQlhmw==
Date: Tue, 5 Nov 2024 16:14:23 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iomap: lift zeroed mapping handling into
 iomap_zero_range()
Message-ID: <20241106001423.GQ21836@frogsfrogsfrogs>
References: <20241031140449.439576-1-bfoster@redhat.com>
 <20241031140449.439576-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031140449.439576-2-bfoster@redhat.com>

On Thu, Oct 31, 2024 at 10:04:47AM -0400, Brian Foster wrote:
> In preparation for special handling of subranges, lift the zeroed
> mapping logic from the iterator into the caller. Since this puts the
> pagecache dirty check and flushing in the same place, streamline the
> comments a bit as well.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 63 ++++++++++++++----------------------------
>  1 file changed, 21 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index aa587b2142e2..60386cb7b9ef 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1365,40 +1365,12 @@ static inline int iomap_zero_iter_flush_and_stale(struct iomap_iter *i)
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
> @@ -1448,24 +1420,31 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
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
> +	 * mapping converts on writeback completion and must be zeroed.
>  	 *
> -	 * Therefore, check the entire range first and pass along whether any
> -	 * part of it is dirty. If so and an underlying mapping warrants it,
> -	 * flush the cache at that point. This trades off the occasional false
> -	 * positive (and spurious flush, if the dirty data and mapping don't
> -	 * happen to overlap) for simplicity in handling a relatively uncommon
> -	 * situation.
> +	 * The simplest way to deal with this is to flush pagecache and process
> +	 * the updated mappings. To avoid an unconditional flush, check dirty
> +	 * state and defer the flush until a combination of dirty pagecache and
> +	 * at least one mapping that might convert on writeback is seen.
>  	 */
>  	range_dirty = filemap_range_needs_writeback(inode->i_mapping,
>  					pos, pos + len - 1);
> +	while ((ret = iomap_iter(&iter, ops)) > 0) {
> +		const struct iomap *s = iomap_iter_srcmap(&iter);

Needs a blank line after the declaration, but other than picking nits
this looks ok to me.

--D

> +		if (s->type == IOMAP_HOLE || s->type == IOMAP_UNWRITTEN) {
> +			loff_t p = iomap_length(&iter);
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
> 2.46.2
> 
> 

