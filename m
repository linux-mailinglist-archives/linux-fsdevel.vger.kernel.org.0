Return-Path: <linux-fsdevel+bounces-51045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC244AD2340
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 18:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0603E18862BB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BB2217736;
	Mon,  9 Jun 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7gNVkhh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AA11494A3;
	Mon,  9 Jun 2025 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485061; cv=none; b=CCfSr+sHnj68a9KoyPVJbLqIQBToCt2LS+rvRnZCfehQDHvKf0Tmv9VIgOIHRJmtCG0KUT9HSsRMfQoztUzVd41WxaXeJ4f7uB/1OaW+GCJhAC6uZRXsXG0003/zpErTV3CbFPZe9qta7WUEri7Ub8vsCH3jIbqgfyU12KLfdBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485061; c=relaxed/simple;
	bh=kHl0G3xtQFEcPUPWFdl2N0Jc4xNPDnnPZA4BjNK7xlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAWCfCYOBPYYOS0knWM6CokAq94Weno78XZvUOo2afes71hMN5Zt0dYoCmgLdTp6sbADXQ65KQ+cGtFjbRbNsP3V/yrTXggzSpN5SVXIICmMI2W94KNNLhnHWPJJ//zW0v3l+xpXOGY3kv8HHr+bIAekWMGhacQmjkwQ5ccWdXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7gNVkhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9BCC4CEEB;
	Mon,  9 Jun 2025 16:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749485061;
	bh=kHl0G3xtQFEcPUPWFdl2N0Jc4xNPDnnPZA4BjNK7xlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7gNVkhhAW3qKsqea1AMXf8XUOrEqGGIEcctVmN7Zc3Ud/LKOujO8g5v0HeZIklPo
	 us2o09MXFGJghg133gMQGsa4maGTN5fDN252bW+qGav7Rf1FnJHO/lRmjWAsIXII0p
	 Ym+mJ8bhZxgw7aWeRAzcj8D9BOVfy8iG1I9u3VleGtN6aMPsCORAI6bUmaR5Q2dfUp
	 w/qg1ErwroYfhCkWRxfJxrXHpgRiGwhzHnlOZnlFuJ9fqlykaGmKGJZdlsUiv//zCb
	 fCO0EX12ey3UFDLNmUUbb+xwhJFMR73XhLMNKuhTBXq5TnVbbyQCuRLEFIzSZCxUsw
	 sR6vDWLKk6yiQ==
Date: Mon, 9 Jun 2025 09:04:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/7] iomap: optional zero range dirty folio processing
Message-ID: <20250609160420.GC6156@frogsfrogsfrogs>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-4-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605173357.579720-4-bfoster@redhat.com>

On Thu, Jun 05, 2025 at 01:33:53PM -0400, Brian Foster wrote:
> The only way zero range can currently process unwritten mappings
> with dirty pagecache is to check whether the range is dirty before
> mapping lookup and then flush when at least one underlying mapping
> is unwritten. This ordering is required to prevent iomap lookup from
> racing with folio writeback and reclaim.
> 
> Since zero range can skip ranges of unwritten mappings that are
> clean in cache, this operation can be improved by allowing the
> filesystem to provide a set of dirty folios that require zeroing. In
> turn, rather than flush or iterate file offsets, zero range can
> iterate on folios in the batch and advance over clean or uncached
> ranges in between.
> 
> Add a folio_batch in struct iomap and provide a helper for fs' to
> populate the batch at lookup time. Update the folio lookup path to
> return the next folio in the batch, if provided, and advance the
> iter if the folio starts beyond the current offset.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 73 +++++++++++++++++++++++++++++++++++++++---
>  fs/iomap/iter.c        |  6 ++++
>  include/linux/iomap.h  |  4 +++
>  3 files changed, 78 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 16499655e7b0..cf2f4f869920 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -750,6 +750,16 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter, size_t len)
>  	if (!mapping_large_folio_support(iter->inode->i_mapping))
>  		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
>  
> +	if (iter->fbatch) {
> +		struct folio *folio = folio_batch_next(iter->fbatch);
> +
> +		if (folio) {
> +			folio_get(folio);
> +			folio_lock(folio);

Hrm.  So each folio that is added to the batch isn't locked, nor does
the batch (or iomap) hold a refcount on the folio until we get here.  Do
we have to re-check that folio->{mapping,index} match what iomap is
trying to process?  Or can we assume that nobody has removed the folio
from the mapping?

I'm wondering because __filemap_get_folio/filemap_get_entry seem to do
all that for us.  I think the folio_pos check below might cover some of
that revalidation?

> +		}
> +		return folio;
> +	}
> +
>  	if (folio_ops && folio_ops->get_folio)
>  		return folio_ops->get_folio(iter, pos, len);
>  	else
> @@ -811,6 +821,8 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
>  	int status = 0;
>  
>  	len = min_not_zero(len, *plen);
> +	*foliop = NULL;
> +	*plen = 0;
>  
>  	if (fatal_signal_pending(current))
>  		return -EINTR;
> @@ -819,6 +831,12 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
>  
> +	/* no folio means we're done with a batch */

...ran out of folios but *plen is nonzero, i.e. we still have range to
cover?

> +	if (!folio) {
> +		WARN_ON_ONCE(!iter->fbatch);
> +		return 0;
> +	}
> +
>  	/*
>  	 * Now we have a locked folio, before we do anything with it we need to
>  	 * check that the iomap we have cached is not stale. The inode extent
> @@ -839,6 +857,20 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
>  		}
>  	}
>  
> +	/*
> +	 * folios in a batch may not be contiguous. If we've skipped forward,
> +	 * advance the iter to the pos of the current folio. If the folio starts
> +	 * beyond the end of the mapping, it may have been trimmed since the
> +	 * lookup for whatever reason. Return a NULL folio to terminate the op.
> +	 */
> +	if (folio_pos(folio) > iter->pos) {
> +		len = min_t(u64, folio_pos(folio) - iter->pos,
> +				 iomap_length(iter));
> +		status = iomap_iter_advance(iter, &len);
> +		if (status || !len)
> +			goto out_unlock;
> +	}
> +
>  	pos = iomap_trim_folio_range(iter, folio, poffset, &len);
>  	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
>  	if (srcmap != &iter->iomap)
> @@ -1380,6 +1412,12 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		if (iter->iomap.flags & IOMAP_F_STALE)
>  			break;
>  
> +		/* a NULL folio means we're done with a folio batch */
> +		if (!folio) {
> +			status = iomap_iter_advance_full(iter);
> +			break;
> +		}
> +
>  		/* warn about zeroing folios beyond eof that won't write back */
>  		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
>  
> @@ -1401,6 +1439,26 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  	return status;
>  }
>  
> +loff_t
> +iomap_fill_dirty_folios(
> +	struct iomap_iter	*iter,
> +	loff_t			offset,
> +	loff_t			length)
> +{
> +	struct address_space	*mapping = iter->inode->i_mapping;
> +	pgoff_t			start = offset >> PAGE_SHIFT;
> +	pgoff_t			end = (offset + length - 1) >> PAGE_SHIFT;
> +
> +	iter->fbatch = kmalloc(sizeof(struct folio_batch), GFP_KERNEL);
> +	if (!iter->fbatch)
> +		return offset + length;
> +	folio_batch_init(iter->fbatch);
> +
> +	filemap_get_folios_dirty(mapping, &start, end, iter->fbatch);
> +	return (start << PAGE_SHIFT);
> +}
> +EXPORT_SYMBOL_GPL(iomap_fill_dirty_folios);

Not used anywhere ... ?

Oh, it's in the next patch.

> +
>  int
>  iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  		const struct iomap_ops *ops, void *private)
> @@ -1429,7 +1487,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  	 * flushing on partial eof zeroing, special case it to zero the
>  	 * unaligned start portion if already dirty in pagecache.
>  	 */
> -	if (off &&
> +	if (!iter.fbatch && off &&
>  	    filemap_range_needs_writeback(mapping, pos, pos + plen - 1)) {
>  		iter.len = plen;
>  		while ((ret = iomap_iter(&iter, ops)) > 0)
> @@ -1445,13 +1503,18 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  	 * if dirty and the fs returns a mapping that might convert on
>  	 * writeback.
>  	 */
> -	range_dirty = filemap_range_needs_writeback(inode->i_mapping,
> -					iter.pos, iter.pos + iter.len - 1);
> +	range_dirty = filemap_range_needs_writeback(mapping, iter.pos,
> +					iter.pos + iter.len - 1);
>  	while ((ret = iomap_iter(&iter, ops)) > 0) {
>  		const struct iomap *srcmap = iomap_iter_srcmap(&iter);
>  
> -		if (srcmap->type == IOMAP_HOLE ||
> -		    srcmap->type == IOMAP_UNWRITTEN) {
> +		if (WARN_ON_ONCE(iter.fbatch &&
> +				 srcmap->type != IOMAP_UNWRITTEN))

I wonder, are you planning to expand the folio batching to other
buffered-io.c operations?  Such that the iter.fbatch checks might some
day go away?

--D

> +			return -EIO;
> +
> +		if (!iter.fbatch &&
> +		    (srcmap->type == IOMAP_HOLE ||
> +		     srcmap->type == IOMAP_UNWRITTEN)) {
>  			s64 status;
>  
>  			if (range_dirty) {
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index 6ffc6a7b9ba5..89bd5951a6fd 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -9,6 +9,12 @@
>  
>  static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
>  {
> +	if (iter->fbatch) {
> +		folio_batch_release(iter->fbatch);
> +		kfree(iter->fbatch);
> +		iter->fbatch = NULL;
> +	}
> +
>  	iter->status = 0;
>  	memset(&iter->iomap, 0, sizeof(iter->iomap));
>  	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 522644d62f30..0b9b460b2873 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -9,6 +9,7 @@
>  #include <linux/types.h>
>  #include <linux/mm_types.h>
>  #include <linux/blkdev.h>
> +#include <linux/pagevec.h>
>  
>  struct address_space;
>  struct fiemap_extent_info;
> @@ -239,6 +240,7 @@ struct iomap_iter {
>  	unsigned flags;
>  	struct iomap iomap;
>  	struct iomap srcmap;
> +	struct folio_batch *fbatch;
>  	void *private;
>  };
>  
> @@ -345,6 +347,8 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
>  bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
>  int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  		const struct iomap_ops *ops);
> +loff_t iomap_fill_dirty_folios(struct iomap_iter *iter, loff_t offset,
> +		loff_t length);
>  int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
>  		bool *did_zero, const struct iomap_ops *ops, void *private);
>  int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> -- 
> 2.49.0
> 
> 

