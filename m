Return-Path: <linux-fsdevel+bounces-32912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610F59B0A45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 18:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F251C22648
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 16:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0F51FB8AB;
	Fri, 25 Oct 2024 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K45hxWsh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871C189BBE
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729874898; cv=none; b=Rfp+VqQrIlC7xcVUsilXDoUC8iWqeylcIkzneijDVNAYfw55qd0VXKcThXOj53Lh4DL8JqC6e4iwZ35QnlKVfeY2twDLIerZxJBZ7IB789R11UFpCxkUTcj205GdpWaWwfxy/VRxIMSQ47q9cPf34j0dwbrFUKLND+yJpr24zXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729874898; c=relaxed/simple;
	bh=8IlUFGXy9WSt23ayMZxTSkam3BvYcGo4Hf52wH7vv9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSOqKSQs18QeEA1xMbo8+Z37kjYSj+/h5Wol+eNSp2gv3XwO9iCw0pVNtQwAnRMUqIOX1Vlk3bbnbnFG3AKUr58gqnLmKGFv99ZJS2hb0Hwj+I0jP4Lj6qERFjLmIk+tU6zyb8JR7bWrANHJLycH/D2eWamRi8ilUX0IGZChHcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K45hxWsh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729874893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vXSKnpeWvxRAggtDxV+vuBnAXAXSeJg7mu2IdmBCQEc=;
	b=K45hxWshXGLorKJ1ZkS0450bzV7skzBKb/TqT1pcSD0GzgOfFR0P7pRE9eF/Z5hFt/6ygG
	/TlbFwE7yM1pkkp5aLwDA/NB1AtC7oV8MYl5BX/Vriy7MczpUux0GR/TCF+a96TPEIboh4
	a7PUQJDvTV7rg7JonZ8XuRlbSC0tbR4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-dUlERdt2MiuNK9SvfswtAQ-1; Fri,
 25 Oct 2024 12:48:09 -0400
X-MC-Unique: dUlERdt2MiuNK9SvfswtAQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB3C6195608A;
	Fri, 25 Oct 2024 16:48:08 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.135])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47CEC1956056;
	Fri, 25 Oct 2024 16:48:08 +0000 (UTC)
Date: Fri, 25 Oct 2024 12:49:35 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] iomap: elide zero range flush from partial eof zeroing
Message-ID: <ZxvMH6ylYYy-CaBG@bfoster>
References: <20241023143029.11275-1-bfoster@redhat.com>
 <20241024170817.GK21853@frogsfrogsfrogs>
 <ZxqGujaIJmnHjgZd@bfoster>
 <ZxqjMSg4c0UivDYU@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxqjMSg4c0UivDYU@bfoster>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Oct 24, 2024 at 03:42:41PM -0400, Brian Foster wrote:
> On Thu, Oct 24, 2024 at 01:41:14PM -0400, Brian Foster wrote:
> > On Thu, Oct 24, 2024 at 10:08:17AM -0700, Darrick J. Wong wrote:
> > > On Wed, Oct 23, 2024 at 10:30:29AM -0400, Brian Foster wrote:
> > > > iomap zero range performs a pagecache flush upon seeing unwritten
> > > > extents with dirty pagecache in order to determine accurate
> > > > subranges that require direct zeroing. This is to support an
> > > > optimization where clean, unwritten ranges are skipped as they are
> > > > already zero on-disk.
> > > > 
> > > > Certain use cases for zero range are more sensitive to flush latency
> > > > than others. The kernel test robot recently reported a regression in
> > > > the following stress-ng workload on XFS:
> > > > 
> > > >   stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --metamix 64
> > > > 
> > > > This workload involves a series of small, strided, write extending
> > > > writes. On XFS, this produces a pattern of allocating post-eof
> > > > speculative preallocation, converting preallocation to unwritten on
> > > > zero range calls, dirtying pagecache over the converted mapping, and
> > > > then repeating the sequence again from the updated EOF. This
> > > > basically produces a sequence of pagecache flushes on the partial
> > > > EOF block zeroing use case of zero range.
> > > > 
> > > > To mitigate this problem, special case the EOF block zeroing use
> > > > case to prefer zeroing over a pagecache flush when the EOF folio is
> > > > already dirty. This brings most of the performance back by avoiding
> > > > flushes on write and truncate extension operations, while preserving
> > > > the ability for iomap to flush and properly process larger ranges.
> > > > 
> > > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > > ---
> > > > 
> > > > Hi iomap maintainers,
> > > > 
> > > > This is an incremental optimization for the regression reported by the
> > > > test robot here[1]. I'm not totally convinced this is necessary as an
> > > > immediate fix, but the discussion on that thread was enough to suggest
> > > > it could be. I don't really love the factoring, but I had to play a bit
> > > > of whack-a-mole between fstests and stress-ng to restore performance and
> > > > still maintain behavior expectations for some of the tests.
> > > > 
> > > > On a positive note, exploring this gave me what I think is a better idea
> > > > for dealing with zero range overall, so I'm working on a followup to
> > > > this that reworks it by splitting zero range across block alignment
> > > > boundaries (similar to how something like truncate page range works, for
> > > > example). This simplifies things by isolating the dirty range check to a
> > > > single folio on an unaligned start offset, which lets the _iter() call
> > > > do a skip or zero (i.e. no more flush_and_stale()), and then
> > > > unconditionally flush the aligned portion to end-of-range. The latter
> > > > flush should be a no-op for every use case I've seen so far, so this
> > > > might entirely avoid the need for anything more complex for zero range.
> > > > 
> > > > In summary, I'm posting this as an optional and more "stable-worthy"
> > > > patch for reference and for the maintainers to consider as they like. I
> > > > think it's reasonable to include if we are concerned about this
> > > > particular stress-ng test and are Ok with it as a transient solution.
> > > > But if it were up to me, I'd probably sit on it for a bit to determine
> > > > if a more practical user/workload is affected by this, particularly
> > > > knowing that I'm trying to rework it. This could always be applied as a
> > > > stable fix if really needed, but I just don't think the slightly more
> > > > invasive rework is appropriate for -rc..
> > > > 
> > > > Thoughts, reviews, flames appreciated.
> > > > 
> > > > Brian
> > > > 
> > > > [1] https://lore.kernel.org/linux-xfs/202410141536.1167190b-oliver.sang@intel.com/
> > > > 
> > > >  fs/iomap/buffered-io.c | 20 +++++++++++++++++---
> > > >  1 file changed, 17 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > index aa587b2142e2..8fd25b14d120 100644
> > > > --- a/fs/iomap/buffered-io.c
> > > > +++ b/fs/iomap/buffered-io.c
> > > > @@ -1372,6 +1372,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
> > > >  	loff_t pos = iter->pos;
> > > >  	loff_t length = iomap_length(iter);
> > > >  	loff_t written = 0;
> > > > +	bool eof_zero = false;
> > > >  
> > > >  	/*
> > > >  	 * We must zero subranges of unwritten mappings that might be dirty in
> > > > @@ -1391,12 +1392,23 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
> > > >  	 * triggers writeback time post-eof zeroing.
> > > >  	 */
> > > >  	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN) {
> > > > -		if (*range_dirty) {
> > > > +		/* range is clean and already zeroed, nothing to do */
> > > > +		if (!*range_dirty)
> > > > +			return length;
> > > > +
> > > > +		/* flush for anything other than partial eof zeroing */
> > > > +		if (pos != i_size_read(iter->inode) ||
> > > > +		   (pos % i_blocksize(iter->inode)) == 0) {
> > > >  			*range_dirty = false;
> > > >  			return iomap_zero_iter_flush_and_stale(iter);
> > > >  		}
> > > > -		/* range is clean and already zeroed, nothing to do */
> > > > -		return length;
> > > > +		/*
> > > > +		 * Special case partial EOF zeroing. Since we know the EOF
> > > > +		 * folio is dirty, prefer in-memory zeroing for it. This avoids
> > > > +		 * excessive flush latency on frequent file size extending
> > > > +		 * operations.
> > > > +		 */
> > > > +		eof_zero = true;
> > > >  	}
> > > >  
> > > >  	do {
> > > > @@ -1415,6 +1427,8 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
> > > >  		offset = offset_in_folio(folio, pos);
> > > >  		if (bytes > folio_size(folio) - offset)
> > > >  			bytes = folio_size(folio) - offset;
> > > > +		if (eof_zero && length > bytes)
> > > > +			length = bytes;
> > > 
> > > What does this do?  I think this causes the loop to break after putting
> > > the folio that caches @pos?  And then I guess we go around the loop in
> > > iomap_zero_range again if there were more bytes to zero after this
> > > folio?
> > > 
> > 
> > Yeah.. it's basically just saying that if we fell into folio zeroing due
> > to the special case logic above, only process through the end of this
> > particular folio and jump back out to process the rest of the range as
> > normal. The idea was just to prevent going off and doing a bunch of
> > unexpected zeroing across an unwritten mapping just because we had an
> > unaligned range that starts with a dirty folio.
> > 
> > FWIW, the reworked variant I have of this currently looks like the
> > appended diff. The caveat is this can still flush if a large folio
> > happens to overlap the two subranges, but as is seems to placate the
> > stress-ng test. In theory, I think having something like an
> > iomap_zero_folio(folio, start_pos, end_pos) that zeroed up through
> > min(end_pos, folio_end_pos) for the unaligned part would mitigate that,
> > but I'm not quite sure of a clean way to do that; particularly if we
> > have a large folio made up of multiple mappings. I'm also still
> > undecided on whether to unconditionally flush the rest or try to
> > preserve the flush_and_stale() approach as well.
> > 
> > Brian
> > 
> > --- 8< ---
> > 
> ...
> 
> And here's another variant that preserves the flush_and_stale()
> behavior. This one is compile tested only:
> 

This one survived an overnight fstests run. FWIW the simplicity of the
previous unconditional flush variant was more appealing to me initially,
but the more I think about it I think I prefer this one. I'm a little
concerned that if we fix this stress-ng test but reintroduce an
unconditional flush on the other end, the bots will find some other
obscure test to complain about.

This approach is at least more incremental in that it retains the
conditional flush logic while improving on the strided write workload,
so hopefully pacifies the robots. This still needs more small block size
testing and I'd probably rework some comments and such, but I'm
interested if you, Christoph, Christian, etc., have any thoughts on this
one. Thanks.

Brian

> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index aa587b2142e2..37a27c344078 100644
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
> @@ -1434,38 +1406,69 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
>  	return written;
>  }
>  
> +static inline void
> +iomap_iter_init(struct iomap_iter *iter, struct inode *inode, loff_t pos,
> +		loff_t len)
> +{
> +	memset(iter, 0, sizeof(*iter));
> +	iter->inode = inode;
> +	iter->pos = pos;
> +	iter->len = len;
> +	iter->flags = IOMAP_ZERO;
> +}
> +
>  int
>  iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  		const struct iomap_ops *ops)
>  {
> -	struct iomap_iter iter = {
> -		.inode		= inode,
> -		.pos		= pos,
> -		.len		= len,
> -		.flags		= IOMAP_ZERO,
> -	};
> +	struct iomap_iter iter;
> +	struct address_space *mapping = inode->i_mapping;
> +	unsigned int blocksize = i_blocksize(inode);
> +	unsigned int off = pos & (blocksize - 1);
> +	loff_t plen = min_t(loff_t, len, blocksize - off);
> +	bool dirty;
>  	int ret;
> -	bool range_dirty;
> +
> +	iomap_iter_init(&iter, inode, pos, len);
>  
>  	/*
> -	 * Zero range wants to skip pre-zeroed (i.e. unwritten) mappings, but
> -	 * pagecache must be flushed to ensure stale data from previous
> -	 * buffered writes is not exposed. A flush is only required for certain
> -	 * types of mappings, but checking pagecache after mapping lookup is
> -	 * racy with writeback and reclaim.
> +	 * Zero range wants to skip mappings that are already zero on disk, but
> +	 * the only way to handle unwritten mappings covered by dirty pagecache
> +	 * is to flush and reprocess the converted mappings after I/O
> +	 * completion.
>  	 *
> -	 * Therefore, check the entire range first and pass along whether any
> -	 * part of it is dirty. If so and an underlying mapping warrants it,
> -	 * flush the cache at that point. This trades off the occasional false
> -	 * positive (and spurious flush, if the dirty data and mapping don't
> -	 * happen to overlap) for simplicity in handling a relatively uncommon
> -	 * situation.
> +	 * The partial EOF zeroing use case is performance sensitive, so split
> +	 * and handle an unaligned start of the range separately. The dirty
> +	 * check tells the iter function whether it can skip or zero the folio
> +	 * without needing to flush. Larger ranges tend to have already been
> +	 * flushed by the filesystem, so flush the rest here as a safety measure
> +	 * and process as normal.
>  	 */
> -	range_dirty = filemap_range_needs_writeback(inode->i_mapping,
> -					pos, pos + len - 1);
> +	if (off &&
> +	    filemap_range_needs_writeback(mapping, pos, pos + plen - 1)) {
> +		iter.len = plen;
> +		while ((ret = iomap_iter(&iter, ops)) > 0)
> +			iter.processed = iomap_zero_iter(&iter, did_zero);
> +		iomap_iter_init(&iter, inode, iter.pos, len - (iter.pos - pos));
> +		if (ret || !iter.len)
> +			return ret;
> +	}
> +
> +	dirty = filemap_range_needs_writeback(mapping, iter.pos,
> +					iter.pos + iter.len - 1);
> +	while ((ret = iomap_iter(&iter, ops)) > 0) {
> +		const struct iomap *s = iomap_iter_srcmap(&iter);
> +		if (!(s->type == IOMAP_HOLE || s->type == IOMAP_UNWRITTEN)) {
> +			iter.processed = iomap_zero_iter(&iter, did_zero);
> +			continue;
> +		}
> +		iter.processed = iomap_length(&iter);
> +		if (dirty) {
> +			dirty = false;
> +			iter.processed = iomap_zero_iter_flush_and_stale(&iter);
> +		}
> +	}
>  
> -	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.processed = iomap_zero_iter(&iter, did_zero, &range_dirty);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_zero_range);
> 
> 


