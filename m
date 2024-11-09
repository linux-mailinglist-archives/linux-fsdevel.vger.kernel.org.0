Return-Path: <linux-fsdevel+bounces-34136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C676A9C29A1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 04:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5001BB21B23
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 03:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2548F3C488;
	Sat,  9 Nov 2024 03:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT+FflQj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B8117FE
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 03:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731121381; cv=none; b=cHprAeB/981yYUrt5x5tEevC2/dMkoy76Cn+C6DjLUac55DJTN0YD8Dq+nENulP/dZ0yDBk4VWNTZrgKiFmYc9UE7vxBWrcLYnw5iyF7+7MhoA6N6StJlqHnGpj03sHH/MwC2FOABBbX3Qf4vXZnRl0w//hKZtl7JFd81PptnlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731121381; c=relaxed/simple;
	bh=lSicEcLxTzbnNdupBIFaYA4kM/nOd4lQC8SkxCWZMfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8rfGynbaSxocX+ZVyso6GhzuWZbid4FZ3zuL2Ud6fTz8xUwcSX6TgXo0yb7rXuJKMXVxJB7SLQfOMNibC4ffMr9FTc3Y+LPe/Xw1EJpuGfzY/AXidjVOgwLm+9/CvQVTVcKgR4uq33bj8tPurYMvjQnccSHR77wiMSUSCTEF8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HT+FflQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB2EC4CECD;
	Sat,  9 Nov 2024 03:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731121381;
	bh=lSicEcLxTzbnNdupBIFaYA4kM/nOd4lQC8SkxCWZMfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HT+FflQjLyIOJgSW146RsWSNG8gtE7tcGAotBV01DcBPERD9iISBnchXJqp0jjOib
	 1oLt6yDs65mC7uEo7lvabbJdZ8T2jY3QBxogyawwYBtQs/NwaPjp1rxf7QhEXYzGRH
	 +XTt6WnBBHXlSavOfiUVs53r8gepMQLpFchaIjZgxAur2zOHbHEzh6gXrydi5BdRQq
	 6SxBqhCykTzJx5yS8xnont3u9yZ688jEAdOBKs7s22obgUiDm/RgWAMoSj0BKMYxlW
	 c4zJmv4KLANfXyi6VvGXSahK8rjr+VQQEfU8WeWmcQ6KL+xECv4Paf/jsVFZsC/chD
	 PuczQtY3cpQBg==
Date: Fri, 8 Nov 2024 19:03:00 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iomap: elide flush from partial eof zero range
Message-ID: <20241109030300.GC9421@frogsfrogsfrogs>
References: <20241108124246.198489-1-bfoster@redhat.com>
 <20241108124246.198489-4-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108124246.198489-4-bfoster@redhat.com>

On Fri, Nov 08, 2024 at 07:42:45AM -0500, Brian Foster wrote:
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
> ---
>  fs/iomap/buffered-io.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a78b5b9b3df3..7f40234a301e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1401,6 +1401,10 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
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
> @@ -1410,12 +1414,28 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  	 * mapping converts on writeback completion and so must be zeroed.
>  	 *
>  	 * The simplest way to deal with this across a range is to flush
> -	 * pagecache and process the updated mappings. To avoid an unconditional
> -	 * flush, check pagecache state and only flush if dirty and the fs
> -	 * returns a mapping that might convert on writeback.
> +	 * pagecache and process the updated mappings. To avoid excessive
> +	 * flushing on partial eof zeroing, special case it to zero the
> +	 * unaligned start portion if already dirty in pagecache.
> +	 */
> +	if (off &&
> +	    filemap_range_needs_writeback(mapping, pos, pos + plen - 1)) {
> +		iter.len = plen;
> +		while ((ret = iomap_iter(&iter, ops)) > 0)
> +			iter.processed = iomap_zero_iter(&iter, did_zero);
> +
> +		iter.len = len - (iter.pos - pos);
> +		if (ret || !iter.len)
> +			return ret;

This looks much cleaner to me now, thanks for iterating :)
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +	}
> +
> +	/*
> +	 * To avoid an unconditional flush, check pagecache state and only flush
> +	 * if dirty and the fs returns a mapping that might convert on
> +	 * writeback.
>  	 */
>  	range_dirty = filemap_range_needs_writeback(inode->i_mapping,
> -					pos, pos + len - 1);
> +					iter.pos, iter.pos + iter.len - 1);
>  	while ((ret = iomap_iter(&iter, ops)) > 0) {
>  		const struct iomap *s = iomap_iter_srcmap(&iter);
>  
> -- 
> 2.47.0
> 
> 

