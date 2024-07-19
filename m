Return-Path: <linux-fsdevel+bounces-24017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F9A9379BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 17:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB2B1C20B1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 15:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A5913F435;
	Fri, 19 Jul 2024 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSbdnzym"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C65D4C85
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721402200; cv=none; b=kQQub+LIJUo1u+JO42cTzKKK2JcTgxNb/GHFm3PtUV29002KukXG1px4LfG11rLJ6PusJQbVwOBDgP3V44x79RwQA8PgNS47WF4zww714alY/xC2aJpNpNZKlzl/s7n2i7BZ0WR5ymaWlLgrAFs1f3z1ku6+6uxk4LMyYDqJTSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721402200; c=relaxed/simple;
	bh=WoIdRi7cjyVa+jPKU7Avbk6vOm/bQhg0xgUEnuSpDpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FR84ZXnodtJyiiZInHO4BSx+1rE4s8IinBn+LHHJ8y5aUvEVSMdImaQ0mLojE1/fr1a92t5VmQOIcxZKBRC3mwud+Xr4SkAsnQzpN07RRotLSdralND4Dijw9dSLcbsPxS24zv8DRlSeIOgqE3twZUYFrhIBhbCN0ikYTLpYip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OSbdnzym; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721402197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/3gmF88nJPMuYLc1q2w2ITpkkG0+EY8lFRs3TCS3tQI=;
	b=OSbdnzymVUqsQsQHhTjxIWIwQp4yVKYxLipfzQbnkYVYHsRqfZRj62V3Y8jx60SyHtEW8m
	k86gSiPf+7bI5m/+bW2M+pkT/9fLp2/MWnLIOI4vYTHAZUeE8F4oGH1GMzQ4lARkqqQ7Jt
	HIqfeQEECTJSo2U+J8OEz42jgNZW4fA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-kVbap8H3PW-PXIwxT9yQEg-1; Fri,
 19 Jul 2024 11:16:35 -0400
X-MC-Unique: kVbap8H3PW-PXIwxT9yQEg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61C981954128;
	Fri, 19 Jul 2024 15:16:34 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.39])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F5503000196;
	Fri, 19 Jul 2024 15:16:33 +0000 (UTC)
Date: Fri, 19 Jul 2024 11:17:17 -0400
From: Brian Foster <bfoster@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/4] iomap: fix handling of dirty folios over unwritten
 extents
Message-ID: <ZpqDfUgcDNX3MsF-@bfoster>
References: <20240718130212.23905-1-bfoster@redhat.com>
 <20240718130212.23905-4-bfoster@redhat.com>
 <ZpmycN7FraEm+jRs@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpmycN7FraEm+jRs@dread.disaster.area>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Jul 19, 2024 at 10:25:20AM +1000, Dave Chinner wrote:
> On Thu, Jul 18, 2024 at 09:02:11AM -0400, Brian Foster wrote:
> > iomap_zero_range() does not correctly handle unwritten mappings with
> > dirty folios in pagecache. It skips unwritten mappings
> > unconditionally as if they were already zeroed, and thus potentially
> > exposes stale data from a previous write if affected folios are not
> > written back before the zero range.
> > 
> > Most callers already flush the target range of the zero for
> > unrelated, context specific reasons, so this problem is not
> > necessarily prevalent. The known outliers (in XFS) are file
> > extension via buffered write and truncate. The truncate path issues
> > a flush to work around this iomap problem, but the file extension
> > path does not and thus can expose stale data if current EOF is
> > unaligned and has a dirty folio over an unwritten block.
> > 
> > This patch implements a mechanism for making zero range pagecache
> > aware for filesystems that support mapping validation (i.e.
> > folio_ops->iomap_valid()). Instead of just skipping unwritten
> > mappings, scan the corresponding pagecache range for dirty or
> > writeback folios. If found, explicitly zero them via buffered write.
> > Clean or uncached subranges of unwritten mappings are skipped, as
> > before.
> > 
> > The quirk with a post-iomap_begin() pagecache scan is that it is
> > racy with writeback and reclaim activity. Even if the higher level
> > code holds the invalidate lock, nothing prevents a dirty folio from
> > being written back, cleaned, and even reclaimed sometime after
> > iomap_begin() returns an unwritten map but before a pagecache scan
> > might find the dirty folio. To handle this situation, we can rely on
> > the fact that writeback completion converts unwritten extents in the
> > fs before writeback state is cleared on the folio.
> > 
> > This means that a pagecache scan followed by a mapping revalidate of
> > an unwritten mapping should either find a dirty folio if it exists,
> > or detect a mapping change if a dirty folio did exist and had been
> > cleaned sometime before the scan but after the unwritten mapping was
> > found. If the revalidation succeeds then we can safely assume
> > nothing has been written back and skip the range. If the
> > revalidation fails then we must assume any offset in the range could
> > have been modified by writeback. In other words, we must be
> > particularly careful to make sure that any uncached range we intend
> > to skip does not make it into iter.processed until the mapping is
> > revalidated.
> > 
> > Altogether, this allows zero range to handle dirty folios over
> > unwritten extents without needing to flush and wait for writeback
> > completion.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/iomap/buffered-io.c | 53 +++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 50 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index a9425170df72..ea1d396ef445 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1385,6 +1385,23 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
> >  }
> >  EXPORT_SYMBOL_GPL(iomap_file_unshare);
> >  
> > +/*
> > + * Scan an unwritten mapping for dirty pagecache and return the length of the
> > + * clean or uncached range leading up to it. This is the range that zeroing may
> > + * skip once the mapping is validated.
> > + */
> > +static inline loff_t
> > +iomap_zero_iter_unwritten(struct iomap_iter *iter, loff_t pos, loff_t length)
> > +{
> > +	struct address_space *mapping = iter->inode->i_mapping;
> > +	loff_t fpos = pos;
> > +
> > +	if (!filemap_range_has_writeback(mapping, &fpos, length))
> > +		return length;
> > +	/* fpos can be smaller if the start folio is dirty */
> > +	return max(fpos, pos) - pos;
> 
> I'm not sure this is safe. filemap_range_has_writeback() doesn't do
> checks for invalidation races or that the folio is actually valid.
> It also treats locked folios as dirty and a locked folio isn't
> necessarily dirty. IOWs, this check assumes that we'll do all these
> checks during the actual writeback operation that would follow this
> check and so skip anything that might have given a false positive
> here.
> 

I'm aware... I probably should have documented this somewhere, but this
prototype implies that false positives are acceptable. I'm not worried
about the occasional spurious unwritten block conversion, at least for a
first variant of a fix given the constraints mentioned in the cover
letter. If we come up with ideas to iterate and improve on that to
eliminate false positives, then great.

I thought about creating a separate lookup variant for this use case
without the lock check, but I'm still not totally convinced that isn't
actually racy and worth the tradeoff. That said, Willy has already
pointed out why patch 1 is wrong so if we end up recreating something
more bespoke for this purpose then we can probably make it work more
predictably.

> iomap_write_begin() doesn't do those sorts of check. If there's no
> folio in the cache, it will simply instantiate a new one and dirty
> it. If there's an existing folio, it will simply dirty it.
> 
> Hence I don't think a "is there a folio  in this range that is a
> potential writeback candidate" check is correct here. I think we
> need to be more robust in determining if a cached folio in the range
> exists and needs zeroing. Ideas on that to follow...
> 
> >  static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> >  {
> >  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> > @@ -1393,16 +1410,46 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> >  	loff_t written = 0;
> >  
> >  	/* already zeroed?  we're done. */
> > -	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
> > +	if (srcmap->type == IOMAP_HOLE)
> >  		return length;
> >  
> >  	do {
> >  		struct folio *folio;
> >  		int status;
> >  		size_t offset;
> > -		size_t bytes = min_t(u64, SIZE_MAX, length);
> > +		size_t bytes;
> > +		loff_t pending = 0;
> >  		bool ret;
> >  
> > +		/*
> > +		 * Determine the range of the unwritten mapping that is clean in
> > +		 * pagecache. We can skip this range, but only if the mapping is
> > +		 * still valid after the pagecache scan. This is because
> > +		 * writeback may have cleaned folios after the mapping lookup
> > +		 * but before we were able to find them here. If that occurs,
> > +		 * then the mapping must now be stale and we must reprocess the
> > +		 * range.
> > +		 */
> > +		if (srcmap->type == IOMAP_UNWRITTEN) {
> > +			pending = iomap_zero_iter_unwritten(iter, pos, length);
> > +			if (pending == length) {
> > +				/* no dirty cache, revalidate and bounce as we're
> > +				 * either done or the mapping is stale */
> > +				if (iomap_revalidate(iter))
> > +					written += pending;
> 
> Ok, this isn't really how the revalidation was supposed to be used
> (i.e. it's not stabilising the data and page cache state first),
> but it looks like works for this situation. We can use this. :)
> 

Yeah.. the main concern I had with this was basically whether we need
some kind of barrier or something in the case where there is no folio to
lock.

At the end of the day we need to be able to handle the case where the
last part of a range is uncached and so no folio exists to lock, yet we
need to confirm that we haven't raced with writeback and reclaim before
the zero range operation can complete.

> > +				break;
> > +			}
> > +
> > +			/*
> > +			 * Found a dirty folio. Update pos/length to point at
> > +			 * it. written is updated only after the mapping is
> > +			 * revalidated by iomap_write_begin().
> > +			 */
> > +			pos += pending;
> > +			length -= pending;
> > +		}
> > +
> > +		bytes = min_t(u64, SIZE_MAX, length);
> >  		status = iomap_write_begin(iter, pos, bytes, &folio);
> >  		if (status)
> >  			return status;
> 
> We don't hold any references to the page cache between the
> iomap_zero_iter_unwritten() and then the actual folio lookup in
> iomap_write_begin() where we reference and lock the folio at the
> given offset. e.g. we get a "dirty" hit because of a locked folio,
> and that folio is clean and contains zeroes (e.g. mmap read,
> readahead, etc). We now write zeroes to that folio and dirty it
> when, we should actually be skipping it and leaving the range as
> unwritten.
> 
> In previous patches that fixed this zeroing issue, this wasn't a
> problem because it used the existing iomap page cache lookup
> mechanisms from iomap_write_begin() to get referenced, locked folios
> over the zeroing range. Instead of skipping potential page cache
> holes, it prevented page cache instantiation over page cache holes
> from occurring when zeroing unwritten extents and that skipped page
> cache holes naturally.
> 
> https://lore.kernel.org/linux-xfs/20240529095206.2568162-2-yi.zhang@huaweicloud.com/
> 
> This means the iteration would skip holes but still safely
> revalidate the iomap once it found and locked a folio in the given
> range. It could also then check the folio is dirty to determine if
> zeroing was necessary.  Yes, this means it iterated holes in the
> range PAGE_SIZE by PAGE_SIZE to do lookups, so it was inefficient.
> 
> However, we could still use this filemap_range_has_writeback()
> optimisation to skip unwritten extents that don't have any cached
> pages over them completely, but ti don't think it is really safe to
> use it during the iteration to discover regions that don't need
> zeroing. i.e. the fast path is this:
> 
> 	if (srcmap->type == IOMAP_HOLE)
> 		return length;
> 	if (srcmap->type == IOMAP_UNWRITTEN &&
> 	    !filemap_range_has_writeback(mapping, pos, length)) {
> 		if (!iomap_revalidate(iter))
> 			return 0; /* stale mapping */
> 		return length;
> 	}
> 

We might be able to do something like this, but this is really more of a
behavioral tradeoff than a functional issue. With the above, if you have
a large range with a dirty page at the start, you'll spend a significant
amount of time chugging through the rest of the range checking each
offset for folios (and then still ultimately may have to revalidate an
uncached range).

Last I played around with that it wasn't hard to reproduce a scan that
took minutes to complete. See my replies in the thread you've linked
above for an example (as well as another prototype variant for
iomap_truncate_page() that more explicitly implements the tradeoff of
writing over unwritten blocks).

> And the slow path does something similar to the above patch.
> However, I'm still not sure that filemap_range_has_writeback() is
> the right set of checks to use here.
> 

Re: above, the _has_writeback() thing was more of an attempt to keep
things simple and reuse existing code. I suspect we can roll our own
lookup mechanism if need be.

> I just thought of another option - after thinking about how you've
> modified filemap_range_has_writeback() to increment the iomap
> iterator position to skip empty ranges, I think we could actually
> drive that inwards to the page cache lookup. We could use
> use filemap_get_folios() instead of __filemap_get_folio() for
> unwritten extent zeroing iteration. This would allow the page cache
> lookup to return the first folio in the range as a referenced folio
> which we can then lock and validate similar to __filemap_get_folio().
> 
> We can then increment the iterator position based on the folio
> position, the iomap_write_begin() code will do the revalidation of
> the iomap, and the zeroing code can then determine if zeroing is
> needed based on whether the folio is dirty/writeback or not. As this
> all happens under the folio lock, it is largely safe from both page
> cache data and state and extent state changes racing with the
> zeroing operation.
> 

I thought about something kind of similar.. do a batched folio lookup
either in iomap or in the fs under locks (via an iomap helper) and feed
that into the iomap operation path in place of the internal folio
lookups, etc. Where that kind of gets annoying is dealing with trimming
the mappings and whatnot for dealing with situations where the batch
might be full. I don't recall ruling that out, but it didn't strike me
as worth the complexity at the time. It occurs to me now there might be
more simple ways around that, such as just looping out on a full batch.

It sounds like what you describe above is more to push that lookup down
in the existing iomap folio lookup path, and then essentially drive the
range processing loop via walking the mapping xarray (via
iomap_write_begin() -> filemap_get_folios()) rather than it being
offset/length driven. If I follow that correctly, that sounds like a
potentially elegant solution to avoid the per-offset lookup walk and the
has_wb() scan.

I was _kind of_ hoping to be able to just lookup the next dirty folio,
but last I checked we couldn't easily lookup the next (dirty ||
writeback) folio in the same lookup operation. But TBH the more I think
about this, the batched lookup thing where we just check each present
folio directly for (dirty||wb) might be perfectly good enough. I need to
stare at the code and play around with it a bit. Thanks for the idea.

Brian

> Thoughts?
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 


