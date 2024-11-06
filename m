Return-Path: <linux-fsdevel+bounces-33707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628779BDA16
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 01:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98401B2251F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 00:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CAF653;
	Wed,  6 Nov 2024 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lvp4JmGP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147EF36C
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730851892; cv=none; b=juj8WYGoWQKwvCnvEGq1BytxZjrrpBnyeDsFPutee3hwUl5c6T+i7sAGVLq789X7mhbUVpNnPoXEDqkMTqDsFIZjjfM6tTvLxzWH+qMSvMWdT2GzYqGPOEUhjBCWVyP45kVinr91w6LIO21uhaJ7j2xdoVmYUvKfq1Mas4uhNGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730851892; c=relaxed/simple;
	bh=NE1vx6DaiKUqN9EcvEEjsmfFBebOKX7Fzj6juiF6qK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk4/qHnw0R3GUfSA01TNJw8XtqSoW54s1iiyfym3rwTKQ35pIs1oal0aC231ySLuogT9Hgccnai1H2FTSTnfwucS1eKQRje0a4ZUN1sErvXANS3ZWnm/SX26TpY4xmXJhy5cVNOQCD0vn3N7Sgnc2xx5Gdu6KDqTI7n22Xv76uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lvp4JmGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7971CC4CED1;
	Wed,  6 Nov 2024 00:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730851891;
	bh=NE1vx6DaiKUqN9EcvEEjsmfFBebOKX7Fzj6juiF6qK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lvp4JmGPCupcA4wTsOnnnLMI14J6JL+EMyMhPWVHLPqE/Zusm3722GMwVp+oEiJQf
	 7FsE2JizWnmLJ+48YHZ2kf3tZ4FpwOSvjcFGA/jRME6uhd0k/bHV77qItd4ElmHfMl
	 XiDtD3y9DHC72NkCUFJb1yAdZyYhfL3HVJSvJOl2iTtG9Le9OW8b6O2ppab26FMudA
	 erli/h4w0NnjJUYSzIu+8ZdmJAuBYYICIAAsoHYhZ4EegDdo08crhetXEnsFJQ+e1x
	 Fi76+E8X//wpRNDEuCr0tEyiMlJZuwjvWu4q4Ih+t9THZAJNZW5PSKWNYfHC1SDx3k
	 +im1L6Q7A5NPw==
Date: Tue, 5 Nov 2024 16:11:30 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iomap: elide flush from partial eof zero range
Message-ID: <20241106001130.GP21836@frogsfrogsfrogs>
References: <20241031140449.439576-1-bfoster@redhat.com>
 <20241031140449.439576-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031140449.439576-3-bfoster@redhat.com>

On Thu, Oct 31, 2024 at 10:04:48AM -0400, Brian Foster wrote:
> iomap zero range flushes pagecache in certain situations to
> determine which parts of the range might require zeroing if dirty
> data is present in pagecache. The kernel robot recently reported a
> regression associated with this flushing in the following stress-ng
> workload on XFS:
> 
> stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --metamix 64
> 
> This workload involves repeated small, strided, extending writes. On
> XFS, this produces a pattern of post-eof speculative preallocation,
> conversion of preallocation from delalloc to unwritten, dirtying
> pagecache over newly unwritten blocks, and then rinse and repeat
> from the new EOF. This leads to repetitive flushing of the EOF folio
> via the zero range call XFS uses for writes that start beyond
> current EOF.
> 
> To mitigate this problem, special case EOF block zeroing to prefer
> zeroing the folio over a flush when the EOF folio is already dirty.
> To do this, split out and open code handling of an unaligned start
> offset. This brings most of the performance back by avoiding flushes
> on zero range calls via write and truncate extension operations. The
> flush doesn't occur in these situations because the entire range is
> post-eof and therefore the folio that overlaps EOF is the only one
> in the range.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Cc: <stable@vger.kernel.org> # v6.12-rc1
Fixes: 7d9b474ee4cc37 ("iomap: make zero range flush conditional on unwritten mappings")

perhaps?

> ---
>  fs/iomap/buffered-io.c | 42 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 60386cb7b9ef..343a2fa29bec 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -227,6 +227,18 @@ static void ifs_free(struct folio *folio)
>  	kfree(ifs);
>  }
>  
> +/* helper to reset an iter for reuse */
> +static inline void
> +iomap_iter_init(struct iomap_iter *iter, struct inode *inode, loff_t pos,
> +		loff_t len, unsigned flags)

Nit: maybe call this iomap_iter_reset() ?

Also I wonder if it's really safe to zero iomap_iter::private?
Won't doing that leave a minor logic bomb?

> +{
> +	memset(iter, 0, sizeof(*iter));
> +	iter->inode = inode;
> +	iter->pos = pos;
> +	iter->len = len;
> +	iter->flags = flags;
> +}
> +
>  /*
>   * Calculate the range inside the folio that we actually need to read.
>   */
> @@ -1416,6 +1428,10 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  		.len		= len,
>  		.flags		= IOMAP_ZERO,
>  	};
> +	struct address_space *mapping = inode->i_mapping;
> +	unsigned int blocksize = i_blocksize(inode);
> +	unsigned int off = pos & (blocksize - 1);
> +	loff_t plen = min_t(loff_t, len, blocksize - off);
>  	int ret;
>  	bool range_dirty;
>  
> @@ -1425,12 +1441,30 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  	 * mapping converts on writeback completion and must be zeroed.
>  	 *
>  	 * The simplest way to deal with this is to flush pagecache and process
> -	 * the updated mappings. To avoid an unconditional flush, check dirty
> -	 * state and defer the flush until a combination of dirty pagecache and
> -	 * at least one mapping that might convert on writeback is seen.
> +	 * the updated mappings. First, special case the partial eof zeroing
> +	 * use case since it is more performance sensitive. Zero the start of
> +	 * the range if unaligned and already dirty in pagecache.
> +	 */
> +	if (off &&
> +	    filemap_range_needs_writeback(mapping, pos, pos + plen - 1)) {
> +		iter.len = plen;
> +		while ((ret = iomap_iter(&iter, ops)) > 0)
> +			iter.processed = iomap_zero_iter(&iter, did_zero);
> +
> +		/* reset iterator for the rest of the range */
> +		iomap_iter_init(&iter, inode, iter.pos,
> +			len - (iter.pos - pos), IOMAP_ZERO);

Nit: maybe one more tab ^ here?

Also from the previous thread: can you reset the original iter instead
of declaring a second one by zeroing the mappings/processed fields,
re-expanding iter::len, and resetting iter::flags?

I guess we'll still do the flush if the start of the zeroing range
aligns with an fsblock?  I guess if you're going to do a lot of small
extensions then once per fsblock isn't too bad?

--D

> +		if (ret || !iter.len)
> +			return ret;
> +	}
> +
> +	/*
> +	 * To avoid an unconditional flush, check dirty state and defer the
> +	 * flush until a combination of dirty pagecache and at least one
> +	 * mapping that might convert on writeback is seen.
>  	 */
>  	range_dirty = filemap_range_needs_writeback(inode->i_mapping,
> -					pos, pos + len - 1);
> +					iter.pos, iter.pos + iter.len - 1);
>  	while ((ret = iomap_iter(&iter, ops)) > 0) {
>  		const struct iomap *s = iomap_iter_srcmap(&iter);
>  		if (s->type == IOMAP_HOLE || s->type == IOMAP_UNWRITTEN) {
> -- 
> 2.46.2
> 
> 

