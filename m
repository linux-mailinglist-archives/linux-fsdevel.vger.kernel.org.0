Return-Path: <linux-fsdevel+bounces-27921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E78964CBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1491F21559
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5601B653F;
	Thu, 29 Aug 2024 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T72+OH9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2161B5ECB
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724952546; cv=none; b=Mp8gKQDi5H6fAKFxNN7UqzUMEUujzcMHJ5sM5R6Dih6xhFCcRf1TUWnmyT8G9sTFWsGbRB0h5wvfAU/6cQ+K2gb5Ip9/hNhNqU7GUUpDr0RRcuqTycGqyjY9vcK7Z57/rh58FYjtgKk+uccCxJBCX4fbEGt8U6qt98ptH/4YsqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724952546; c=relaxed/simple;
	bh=57+ZRvZC4sFnT1sftOTCnPAMg2AcYtqb21qrDJLl/SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQhvCAw1koOnhv+Oxb9m2gDF3YJIFKFB8otGhD0RIntUV+0CGUGCG6hKTxN9e24Zlv492Q6llkyaQko/iveDy/7VXfL96iI/Yz2VQMKXoma64neWwMKnuiJc+bJ+7IWJc9aYJwQ3yB9hPjGmNg6kf98FnJzKRHXesBv3meJinZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T72+OH9l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724952542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yjf9LIuYJXMi2HMEbvnE7/xPaGQF+IPsYR7C5/e8uMk=;
	b=T72+OH9lSjbmdigu0HsaRu72aDGbiq7W5eZiyYgxNSDkOPDe6bUUJH8VXTAmjqvJ6wwidl
	tN/ySeL9UidczdK9rxHeuhnzR+24hu/S8vn7Ne02xaMK+G1vuZKSyt2UY4oq/HEVhcRGie
	dqmkJj3MzgN2M90AjEBp7wRLuQDJBSs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-OLPeGIRuOQGWu9EBXvdjfQ-1; Thu,
 29 Aug 2024 13:28:59 -0400
X-MC-Unique: OLPeGIRuOQGWu9EBXvdjfQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD4B81955F03;
	Thu, 29 Aug 2024 17:28:57 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.95])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A27AB1956052;
	Thu, 29 Aug 2024 17:28:56 +0000 (UTC)
Date: Thu, 29 Aug 2024 13:29:56 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	josef@toxicpanda.com, david@fromorbit.com
Subject: Re: [PATCH v2 2/2] iomap: make zero range flush conditional on
 unwritten mappings
Message-ID: <ZtCwFP5Zj9pXkgOf@bfoster>
References: <20240828181912.41517-1-bfoster@redhat.com>
 <20240828181912.41517-3-bfoster@redhat.com>
 <20240828224420.GC6224@frogsfrogsfrogs>
 <ZtCN3Q0r4kIOPYkx@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtCN3Q0r4kIOPYkx@bfoster>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Aug 29, 2024 at 11:03:57AM -0400, Brian Foster wrote:
> On Wed, Aug 28, 2024 at 03:44:20PM -0700, Darrick J. Wong wrote:
> > On Wed, Aug 28, 2024 at 02:19:11PM -0400, Brian Foster wrote:
> > > iomap_zero_range() flushes pagecache to mitigate consistency
> > > problems with dirty pagecache and unwritten mappings. The flush is
> > > unconditional over the entire range because checking pagecache state
> > > after mapping lookup is racy with writeback and reclaim. There are
> > > ways around this using iomap's mapping revalidation mechanism, but
> > > this is not supported by all iomap based filesystems and so is not a
> > > generic solution.
> > > 
> > > There is another way around this limitation that is good enough to
> > > filter the flush for most cases in practice. If we check for dirty
> > > pagecache over the target range (instead of unconditionally flush),
> > > we can keep track of whether the range was dirty before lookup and
> > > defer the flush until/unless we see a combination of dirty cache
> > > backed by an unwritten mapping. We don't necessarily know whether
> > > the dirty cache was backed by the unwritten maping or some other
> > > (written) part of the range, but the impliciation of a false
> > > positive here is a spurious flush and thus relatively harmless.
> > > 
> > > Note that we also flush for hole mappings because iomap_zero_range()
> > > is used for partial folio zeroing in some cases. For example, if a
> > > folio straddles EOF on a sub-page FSB size fs, the post-eof portion
> > > is hole-backed and dirtied/written via mapped write, and then i_size
> > > increases before writeback can occur (which otherwise zeroes the
> > > post-eof portion of the EOF folio), then the folio becomes
> > > inconsistent with disk until reclaimed. A flush in this case
> > > executes partial zeroing from writeback, and iomap knows that there
> > > is otherwise no I/O to submit for hole backed mappings.
> > > 
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > ---
> > >  fs/iomap/buffered-io.c | 57 +++++++++++++++++++++++++++++++++++-------
> > >  1 file changed, 48 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 3e846f43ff48..a6e897e6e303 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -1393,16 +1393,47 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
> > >  }
> > >  EXPORT_SYMBOL_GPL(iomap_file_unshare);
> > >  
> > > -static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> > > +/*
> > > + * Flush the remaining range of the iter and mark the current mapping stale.
> > > + * This is used when zero range sees an unwritten mapping that may have had
> > > + * dirty pagecache over it.
> > > + */
> > > +static inline int iomap_zero_iter_flush_and_stale(struct iomap_iter *i)
> > > +{
> > > +	struct address_space *mapping = i->inode->i_mapping;
> > > +	loff_t end = i->pos + i->len - 1;
> > > +
> > > +	i->iomap.flags |= IOMAP_F_STALE;
> > > +	return filemap_write_and_wait_range(mapping, i->pos, end);
> > > +}
> > > +
> > > +static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
> > > +		bool *range_dirty)
> > >  {
> > >  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> > >  	loff_t pos = iter->pos;
> > >  	loff_t length = iomap_length(iter);
> > >  	loff_t written = 0;
> > >  
> > > -	/* already zeroed?  we're done. */
> > > -	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
> > > +	/*
> > > +	 * We can skip pre-zeroed mappings so long as either the mapping was
> > > +	 * clean before we started or we've flushed at least once since.
> > > +	 * Otherwise we don't know whether the current mapping had dirty
> > > +	 * pagecache, so flush it now, stale the current mapping, and proceed
> > > +	 * from there.
> > > +	 *
> > > +	 * The hole case is intentionally included because this is (ab)used to
> > > +	 * handle partial folio zeroing in some cases. Hole backed post-eof
> > > +	 * ranges can be dirtied via mapped write and the flush triggers
> > > +	 * writeback time post-eof zeroing.
> > > +	 */
> > > +	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN) {
> > > +		if (*range_dirty) {
> > > +			*range_dirty = false;
> > > +			return iomap_zero_iter_flush_and_stale(iter);
> > > +		}
> > >  		return length;
> > > +	}
> > >  
> > >  	do {
> > >  		struct folio *folio;
> > > @@ -1450,19 +1481,27 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> > >  		.flags		= IOMAP_ZERO,
> > >  	};
> > >  	int ret;
> > > +	bool range_dirty;
> > >  
> > >  	/*
> > >  	 * Zero range wants to skip pre-zeroed (i.e. unwritten) mappings, but
> > >  	 * pagecache must be flushed to ensure stale data from previous
> > > -	 * buffered writes is not exposed.
> > > +	 * buffered writes is not exposed. A flush is only required for certain
> > > +	 * types of mappings, but checking pagecache after mapping lookup is
> > > +	 * racy with writeback and reclaim.
> > > +	 *
> > > +	 * Therefore, check the entire range first and pass along whether any
> > > +	 * part of it is dirty. If so and an underlying mapping warrants it,
> > > +	 * flush the cache at that point. This trades off the occasional false
> > > +	 * positive (and spurious flush, if the dirty data and mapping don't
> > > +	 * happen to overlap) for simplicity in handling a relatively uncommon
> > > +	 * situation.
> > >  	 */
> > > -	ret = filemap_write_and_wait_range(inode->i_mapping,
> > > -			pos, pos + len - 1);
> > > -	if (ret)
> > > -		return ret;
> > > +	range_dirty = filemap_range_needs_writeback(inode->i_mapping,
> > > +					pos, pos + len - 1);
> > >  
> > >  	while ((ret = iomap_iter(&iter, ops)) > 0)
> > > -		iter.processed = iomap_zero_iter(&iter, did_zero);
> > > +		iter.processed = iomap_zero_iter(&iter, did_zero, &range_dirty);
> > 
> > Style nit: Could we do this flush-and-stale from the loop body instead
> > of passing pointers around?  e.g.
> > 
> 
> So FWIW, I had multiple other variations of this that used an
> IOMAP_DIRTY_CACHE flag on the iomap to track dirty pagecache for
> arbitrary operations. The flag could be set and cleared at the
> appropriate points as expected (for ops that care).
> 
> To me, that's how I'd prefer to avoid just passing a pointer, but I
> intentionally factored that out to avoid using a flag for something that
> (for now) could be simplified to a local variable. OTOH, it is something
> that might be useful for the iomap seek data/hole implementations down
> the road.
> 
> I've played with that a bit, but also have been trying to avoid getting
> too much into that rabbit hole for zero range. My thought was I'd
> reintroduce it and replace the range_dirty thing if/when it proved
> useful for multiple operations.
> 
> > static inline bool iomap_zero_need_flush(const struct iomap_iter *i)
> > {
> > 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> > 
> > 	return srcmap->type == IOMAP_HOLE ||
> > 	       srcmap->type == IOMAP_UNWRITTEN;
> > }
> 
> The factoring looks mostly reasonable, but a couple things bug me that
> I'd like to see if we can resolve..
> 
> One is that this doesn't really indicate whether a flush is needed,
> because the dirty cache state is a critical part of that logic. I
> suppose we could rename it (to what?), but it also seems a little odd to
> have a helper just for mapping type checks.
> 
> > 
> > static inline int iomap_zero_iter_flush(struct iomap_iter *i)
> > {
> > 	struct address_space *mapping = i->inode->i_mapping;
> > 	loff_t end = i->pos + i->len - 1;
> > 
> > 	i->iomap.flags |= IOMAP_F_STALE;
> > 	return filemap_write_and_wait_range(mapping, i->pos, end);
> > }
> > 
> > and then:
> > 
> > 	range_dirty = filemap_range_needs_writeback(...);
> > 
> > 	while ((ret = iomap_iter(&iter, ops)) > 0) {
> > 		if (range_dirty && iomap_zero_need_flush(&iter)) {
> > 			/*
> > 			 * Zero range wants to skip pre-zeroed (i.e.
> > 			 * unwritten) mappings, but...
> > 			 */
> > 			range_dirty = false;
> > 			iter.processed = iomap_zero_iter_flush(&iter);
> > 		} else {
> > 			iter.processed = iomap_zero_iter(&iter, did_zero);
> > 		}
> 
> The other is that the optimization logic is now split across multiple
> functions. I.e., iomap_zero_iter() has a landmine if ever called without
> doing the flush_and_stale() part first (a consideration if
> truncate_page() were ever open coded, for example).
> 
> I wonder if a compromise might be to factor out the whole optimization
> into a separate helper rather than just the flush part (first via a prep
> patch), then the higher level loop ends up looking almost the same:
> 
> 	while ((ret = iomap_iter(&iter, ops)) > 0) {
> 		/* special handling for already zeroed mappings */
> 		if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
> 			iter.processed = iomap_zero_mapping_iter(&iter, &range_dirty);
> 		else
> 			iter.processed = iomap_zero_iter(&iter, did_zero);
> 		}
> 
> That doesn't avoid passing the range_dirty pointer, but we just end up
> passing that instead of did_zero. Also as noted above, it could still be
> made to go away if the range_dirty check gets pushed down into the
> iomap_iter() path for more general use.
> 

FWIW, here's another variation of iomap_zero_range() that seems a bit
closer to yours:

       range_dirty = filemap_range_needs_writeback(inode->i_mapping,
                                        pos, pos + len - 1);

        while ((ret = iomap_iter(&iter, ops)) > 0) {
                const struct iomap *srcmap = iomap_iter_srcmap(&iter);

                if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN) {
                        iter.processed = iomap_length(&iter);
                        if (range_dirty) {
                                range_dirty = false;
                                iter.processed = iomap_zero_iter_flush_and_stale(&iter);
                        }
                        continue;
                }

                iter.processed = iomap_zero_iter(&iter, did_zero);
        }

This avoids passing around range_dirty, but keeps the optimization logic
together. Hm?

Brian

> Anyways those are just my thoughts. I'm of the mind that whatever
> factoring we do here may have to change if Dave's batched folio
> lookup/iteration idea pans out for fs' with validation support, so at
> the end of the day I'll change this to look exactly like you wrote it if
> it means the zeroing problem gets fixed. Thoughts or preference?
> 
> Brian
> 
> > 	}
> > 
> > The logic looks correct and sensible. :)
> > 
> > --D
> > 
> > >  	return ret;
> > >  }
> > >  EXPORT_SYMBOL_GPL(iomap_zero_range);
> > > -- 
> > > 2.45.0
> > > 
> > > 
> > 
> 
> 


