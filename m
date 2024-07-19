Return-Path: <linux-fsdevel+bounces-23979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA206937179
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 02:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BF82B21B50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 00:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0E21362;
	Fri, 19 Jul 2024 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="EyvNpIvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A3137E
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721348727; cv=none; b=NJj2Mopy+1rJi+hriFzdEHCk4jmTHFRAjncrqfidVqVZBoHr8yz8dWGYIZy4MEKxq4uFiX+VEOPjFO6U+fo2Hom62NJkGyP6oOrXgDrvHQIdOQLhNe+g0xVN6h1wS0EY/KE5UYNZJ8nkr4rfLjAlr7i1ycw3fhwI8r0AzHD7CMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721348727; c=relaxed/simple;
	bh=td+aM0rgYI+vOP/GmMfZXbsWfNpIUbeZIy4qcN1Any0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8c71aZO6xsaKrc+Ulhac/C3Ukrc7YLGpJoZEzhjX9SUH98jjudESoP7rufMYj27piCHjmk/EAym6x/KcOPrFJ+Nd6sAeKuqxqwU3xk5JwWpoh7sCufNU5oAQYq0Jpg3cpCgQM6gNY4sVMuoBEFuJmdw/F9wMUqfAvWUgbaUuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=EyvNpIvS; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6bce380eb96so923660a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 17:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1721348724; x=1721953524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOcvsNPNJsOW5of/uY6NJFdmB3X8eXRaur0mZXAcEBY=;
        b=EyvNpIvS9wuSjyCK9mUNZsAe5jp8m+SzKXGsPQ0u8mLDTOpQmJPcGwayA88YfXGwuw
         PaQJFflZ61lop+sZnPZr2HuQkxEfLOdtiZSbUGYIGv5FaNjtE7akIC/O14jXvRk9pSLV
         ye1rSafawJlnBPMNupTrkDFyyZ4Oh3wevJPR9CZA4s+lSYiOwPm+j2qomSiS+fZBFGAN
         5zQUbyH+rIlLAcYwIYTVXjtl42kyfDdT6NMTg/psKcw2dAFYL3zZoENW2HyEsnEt824f
         scz+6ndHhS7kVCCunrjOeT46mSbE0A5JiZ462o2iSjE33IJ5kvi+4Uzyzib4qdDJsvs5
         qx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721348724; x=1721953524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOcvsNPNJsOW5of/uY6NJFdmB3X8eXRaur0mZXAcEBY=;
        b=fyDwxDFs8rNtM+8OppvKhLJiN4ay/jcjFu/SwH59g/2UcDWrsonvIr+3jBE43vrPT/
         nt9l6hVkfkhxHFTujrrPf8rSmsX5nW3iOuh+YhL7H3fFmxJUvVON5waa3vqwWmdNG7x1
         MypndoUypVCHwYiNhdPWEEYZZ8QBienfBCCcTsMvvU3JDEVU6WFXfNAUmq72c2GTpfAD
         yoL1w2UcezEUUbBbvuZ9ZC8QJYH9d61wvta6rUBo2/InmXzppLQnrldCBUSJugb/WwYK
         M1W/IfxXGbwnWS+60G4OHEH+KFxJ0KPIh3IqcBDrrqiMdPQrJ+F14nqrnvSxwcQkPvQH
         juFw==
X-Gm-Message-State: AOJu0Yy5EpBP2Cyq9T1K1vJ5jst7+Jp/K2OR6wwqGP1Pa1bMWVfCpVsZ
	qkTSkgvMOcmpWBS4hhBSd7koTNmIAKY2lmItCIZLGL2W0xJY+T1wrpKsup1GuNQhNKUBrPy61/R
	p
X-Google-Smtp-Source: AGHT+IHVRTt+YTASMX6gtjziVqWXoTgY5Jeq2DjrB0huGt95tcGCxDjV8hgTw93Gk6UrlB0ObIF8lw==
X-Received: by 2002:a05:6a20:6a27:b0:1c2:9070:90ce with SMTP id adf61e73a8af0-1c3fdd30a79mr7668339637.43.1721348724405;
        Thu, 18 Jul 2024 17:25:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7b5c342sm248371a91.19.2024.07.18.17.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 17:25:23 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sUbR2-003Db1-2P;
	Fri, 19 Jul 2024 10:25:20 +1000
Date: Fri, 19 Jul 2024 10:25:20 +1000
From: Dave Chinner <david@fromorbit.com>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/4] iomap: fix handling of dirty folios over unwritten
 extents
Message-ID: <ZpmycN7FraEm+jRs@dread.disaster.area>
References: <20240718130212.23905-1-bfoster@redhat.com>
 <20240718130212.23905-4-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718130212.23905-4-bfoster@redhat.com>

On Thu, Jul 18, 2024 at 09:02:11AM -0400, Brian Foster wrote:
> iomap_zero_range() does not correctly handle unwritten mappings with
> dirty folios in pagecache. It skips unwritten mappings
> unconditionally as if they were already zeroed, and thus potentially
> exposes stale data from a previous write if affected folios are not
> written back before the zero range.
> 
> Most callers already flush the target range of the zero for
> unrelated, context specific reasons, so this problem is not
> necessarily prevalent. The known outliers (in XFS) are file
> extension via buffered write and truncate. The truncate path issues
> a flush to work around this iomap problem, but the file extension
> path does not and thus can expose stale data if current EOF is
> unaligned and has a dirty folio over an unwritten block.
> 
> This patch implements a mechanism for making zero range pagecache
> aware for filesystems that support mapping validation (i.e.
> folio_ops->iomap_valid()). Instead of just skipping unwritten
> mappings, scan the corresponding pagecache range for dirty or
> writeback folios. If found, explicitly zero them via buffered write.
> Clean or uncached subranges of unwritten mappings are skipped, as
> before.
> 
> The quirk with a post-iomap_begin() pagecache scan is that it is
> racy with writeback and reclaim activity. Even if the higher level
> code holds the invalidate lock, nothing prevents a dirty folio from
> being written back, cleaned, and even reclaimed sometime after
> iomap_begin() returns an unwritten map but before a pagecache scan
> might find the dirty folio. To handle this situation, we can rely on
> the fact that writeback completion converts unwritten extents in the
> fs before writeback state is cleared on the folio.
> 
> This means that a pagecache scan followed by a mapping revalidate of
> an unwritten mapping should either find a dirty folio if it exists,
> or detect a mapping change if a dirty folio did exist and had been
> cleaned sometime before the scan but after the unwritten mapping was
> found. If the revalidation succeeds then we can safely assume
> nothing has been written back and skip the range. If the
> revalidation fails then we must assume any offset in the range could
> have been modified by writeback. In other words, we must be
> particularly careful to make sure that any uncached range we intend
> to skip does not make it into iter.processed until the mapping is
> revalidated.
> 
> Altogether, this allows zero range to handle dirty folios over
> unwritten extents without needing to flush and wait for writeback
> completion.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 53 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a9425170df72..ea1d396ef445 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1385,6 +1385,23 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_unshare);
>  
> +/*
> + * Scan an unwritten mapping for dirty pagecache and return the length of the
> + * clean or uncached range leading up to it. This is the range that zeroing may
> + * skip once the mapping is validated.
> + */
> +static inline loff_t
> +iomap_zero_iter_unwritten(struct iomap_iter *iter, loff_t pos, loff_t length)
> +{
> +	struct address_space *mapping = iter->inode->i_mapping;
> +	loff_t fpos = pos;
> +
> +	if (!filemap_range_has_writeback(mapping, &fpos, length))
> +		return length;
> +	/* fpos can be smaller if the start folio is dirty */
> +	return max(fpos, pos) - pos;

I'm not sure this is safe. filemap_range_has_writeback() doesn't do
checks for invalidation races or that the folio is actually valid.
It also treats locked folios as dirty and a locked folio isn't
necessarily dirty. IOWs, this check assumes that we'll do all these
checks during the actual writeback operation that would follow this
check and so skip anything that might have given a false positive
here.

iomap_write_begin() doesn't do those sorts of check. If there's no
folio in the cache, it will simply instantiate a new one and dirty
it. If there's an existing folio, it will simply dirty it.

Hence I don't think a "is there a folio  in this range that is a
potential writeback candidate" check is correct here. I think we
need to be more robust in determining if a cached folio in the range
exists and needs zeroing. Ideas on that to follow...

>  static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  {
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> @@ -1393,16 +1410,46 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  	loff_t written = 0;
>  
>  	/* already zeroed?  we're done. */
> -	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
> +	if (srcmap->type == IOMAP_HOLE)
>  		return length;
>  
>  	do {
>  		struct folio *folio;
>  		int status;
>  		size_t offset;
> -		size_t bytes = min_t(u64, SIZE_MAX, length);
> +		size_t bytes;
> +		loff_t pending = 0;
>  		bool ret;
>  
> +		/*
> +		 * Determine the range of the unwritten mapping that is clean in
> +		 * pagecache. We can skip this range, but only if the mapping is
> +		 * still valid after the pagecache scan. This is because
> +		 * writeback may have cleaned folios after the mapping lookup
> +		 * but before we were able to find them here. If that occurs,
> +		 * then the mapping must now be stale and we must reprocess the
> +		 * range.
> +		 */
> +		if (srcmap->type == IOMAP_UNWRITTEN) {
> +			pending = iomap_zero_iter_unwritten(iter, pos, length);
> +			if (pending == length) {
> +				/* no dirty cache, revalidate and bounce as we're
> +				 * either done or the mapping is stale */
> +				if (iomap_revalidate(iter))
> +					written += pending;

Ok, this isn't really how the revalidation was supposed to be used
(i.e. it's not stabilising the data and page cache state first),
but it looks like works for this situation. We can use this. :)

> +				break;
> +			}
> +
> +			/*
> +			 * Found a dirty folio. Update pos/length to point at
> +			 * it. written is updated only after the mapping is
> +			 * revalidated by iomap_write_begin().
> +			 */
> +			pos += pending;
> +			length -= pending;
> +		}
> +
> +		bytes = min_t(u64, SIZE_MAX, length);
>  		status = iomap_write_begin(iter, pos, bytes, &folio);
>  		if (status)
>  			return status;

We don't hold any references to the page cache between the
iomap_zero_iter_unwritten() and then the actual folio lookup in
iomap_write_begin() where we reference and lock the folio at the
given offset. e.g. we get a "dirty" hit because of a locked folio,
and that folio is clean and contains zeroes (e.g. mmap read,
readahead, etc). We now write zeroes to that folio and dirty it
when, we should actually be skipping it and leaving the range as
unwritten.

In previous patches that fixed this zeroing issue, this wasn't a
problem because it used the existing iomap page cache lookup
mechanisms from iomap_write_begin() to get referenced, locked folios
over the zeroing range. Instead of skipping potential page cache
holes, it prevented page cache instantiation over page cache holes
from occurring when zeroing unwritten extents and that skipped page
cache holes naturally.

https://lore.kernel.org/linux-xfs/20240529095206.2568162-2-yi.zhang@huaweicloud.com/

This means the iteration would skip holes but still safely
revalidate the iomap once it found and locked a folio in the given
range. It could also then check the folio is dirty to determine if
zeroing was necessary.  Yes, this means it iterated holes in the
range PAGE_SIZE by PAGE_SIZE to do lookups, so it was inefficient.

However, we could still use this filemap_range_has_writeback()
optimisation to skip unwritten extents that don't have any cached
pages over them completely, but ti don't think it is really safe to
use it during the iteration to discover regions that don't need
zeroing. i.e. the fast path is this:

	if (srcmap->type == IOMAP_HOLE)
		return length;
	if (srcmap->type == IOMAP_UNWRITTEN &&
	    !filemap_range_has_writeback(mapping, pos, length)) {
		if (!iomap_revalidate(iter))
			return 0; /* stale mapping */
		return length;
	}

And the slow path does something similar to the above patch.
However, I'm still not sure that filemap_range_has_writeback() is
the right set of checks to use here.

I just thought of another option - after thinking about how you've
modified filemap_range_has_writeback() to increment the iomap
iterator position to skip empty ranges, I think we could actually
drive that inwards to the page cache lookup. We could use
use filemap_get_folios() instead of __filemap_get_folio() for
unwritten extent zeroing iteration. This would allow the page cache
lookup to return the first folio in the range as a referenced folio
which we can then lock and validate similar to __filemap_get_folio().

We can then increment the iterator position based on the folio
position, the iomap_write_begin() code will do the revalidation of
the iomap, and the zeroing code can then determine if zeroing is
needed based on whether the folio is dirty/writeback or not. As this
all happens under the folio lock, it is largely safe from both page
cache data and state and extent state changes racing with the
zeroing operation.

Thoughts?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

