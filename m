Return-Path: <linux-fsdevel+bounces-32813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B769AEE60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF951F25960
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 17:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C931FC7F2;
	Thu, 24 Oct 2024 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oy4xNXw/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61DF1FAC42
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791596; cv=none; b=H+h6z1mrZr2Z79xLaDJF9oHKqfprtaPTcAhqRX+YPluc5D3MaNCmAOhJFsa4zkMMBAmSV49ljET6TaqiKDqXfibCunLg1AzS+dL03BOjrY4Lr/Zm7n5fGh4PnsVKdkOt+NpMvOHSWzT2tVSCXgDJHx0qR4Q31+Qn4rQBTCCfWeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791596; c=relaxed/simple;
	bh=+oEPWxzmD8GcbqkOsCV2/T2VsMRqB6Bbvmr+uEAiuXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMy1SRNcHqzhQanZ01eNjd7ks+dMTxZzbmj1YN43VRocK8UZCGTOlfzBwUxM/wII220ScgGIkrZUyhLYHiSGjXzXc3xsiV5hMbRxmrbLz94ul02VOS1UIzPdSLrbRbPGBgNsZ2JQBHyCeYL9Mnl2EvZn+c7xzmAFT+VND8tNZe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oy4xNXw/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729791592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JNDfSyetL5D0dJbQQKbhIdoTfJQz4Tdc2bgcKqgH3p0=;
	b=Oy4xNXw/suHHeGVSQ28IFXdqT8WUebESVrdKQLr9asKsGrnTOMI8VQOaIBJBb+NIczF3Na
	F9cRMwh/Nf/C/kbuxvCOyeh1dAD4LmOoNVgr07nnY5sZaDad3Ofh3FZmQ+njASFZEV27UE
	GYALLFmcdabFhzoL2zuLo1hKSEXqFR8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-stkyN_k9PDWmjF1SGYK9cg-1; Thu,
 24 Oct 2024 13:39:49 -0400
X-MC-Unique: stkyN_k9PDWmjF1SGYK9cg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B3C71955F41;
	Thu, 24 Oct 2024 17:39:48 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.135])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98BAB1956056;
	Thu, 24 Oct 2024 17:39:47 +0000 (UTC)
Date: Thu, 24 Oct 2024 13:41:14 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] iomap: elide zero range flush from partial eof zeroing
Message-ID: <ZxqGujaIJmnHjgZd@bfoster>
References: <20241023143029.11275-1-bfoster@redhat.com>
 <20241024170817.GK21853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024170817.GK21853@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Oct 24, 2024 at 10:08:17AM -0700, Darrick J. Wong wrote:
> On Wed, Oct 23, 2024 at 10:30:29AM -0400, Brian Foster wrote:
> > iomap zero range performs a pagecache flush upon seeing unwritten
> > extents with dirty pagecache in order to determine accurate
> > subranges that require direct zeroing. This is to support an
> > optimization where clean, unwritten ranges are skipped as they are
> > already zero on-disk.
> > 
> > Certain use cases for zero range are more sensitive to flush latency
> > than others. The kernel test robot recently reported a regression in
> > the following stress-ng workload on XFS:
> > 
> >   stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --metamix 64
> > 
> > This workload involves a series of small, strided, write extending
> > writes. On XFS, this produces a pattern of allocating post-eof
> > speculative preallocation, converting preallocation to unwritten on
> > zero range calls, dirtying pagecache over the converted mapping, and
> > then repeating the sequence again from the updated EOF. This
> > basically produces a sequence of pagecache flushes on the partial
> > EOF block zeroing use case of zero range.
> > 
> > To mitigate this problem, special case the EOF block zeroing use
> > case to prefer zeroing over a pagecache flush when the EOF folio is
> > already dirty. This brings most of the performance back by avoiding
> > flushes on write and truncate extension operations, while preserving
> > the ability for iomap to flush and properly process larger ranges.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> > 
> > Hi iomap maintainers,
> > 
> > This is an incremental optimization for the regression reported by the
> > test robot here[1]. I'm not totally convinced this is necessary as an
> > immediate fix, but the discussion on that thread was enough to suggest
> > it could be. I don't really love the factoring, but I had to play a bit
> > of whack-a-mole between fstests and stress-ng to restore performance and
> > still maintain behavior expectations for some of the tests.
> > 
> > On a positive note, exploring this gave me what I think is a better idea
> > for dealing with zero range overall, so I'm working on a followup to
> > this that reworks it by splitting zero range across block alignment
> > boundaries (similar to how something like truncate page range works, for
> > example). This simplifies things by isolating the dirty range check to a
> > single folio on an unaligned start offset, which lets the _iter() call
> > do a skip or zero (i.e. no more flush_and_stale()), and then
> > unconditionally flush the aligned portion to end-of-range. The latter
> > flush should be a no-op for every use case I've seen so far, so this
> > might entirely avoid the need for anything more complex for zero range.
> > 
> > In summary, I'm posting this as an optional and more "stable-worthy"
> > patch for reference and for the maintainers to consider as they like. I
> > think it's reasonable to include if we are concerned about this
> > particular stress-ng test and are Ok with it as a transient solution.
> > But if it were up to me, I'd probably sit on it for a bit to determine
> > if a more practical user/workload is affected by this, particularly
> > knowing that I'm trying to rework it. This could always be applied as a
> > stable fix if really needed, but I just don't think the slightly more
> > invasive rework is appropriate for -rc..
> > 
> > Thoughts, reviews, flames appreciated.
> > 
> > Brian
> > 
> > [1] https://lore.kernel.org/linux-xfs/202410141536.1167190b-oliver.sang@intel.com/
> > 
> >  fs/iomap/buffered-io.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index aa587b2142e2..8fd25b14d120 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1372,6 +1372,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
> >  	loff_t pos = iter->pos;
> >  	loff_t length = iomap_length(iter);
> >  	loff_t written = 0;
> > +	bool eof_zero = false;
> >  
> >  	/*
> >  	 * We must zero subranges of unwritten mappings that might be dirty in
> > @@ -1391,12 +1392,23 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
> >  	 * triggers writeback time post-eof zeroing.
> >  	 */
> >  	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN) {
> > -		if (*range_dirty) {
> > +		/* range is clean and already zeroed, nothing to do */
> > +		if (!*range_dirty)
> > +			return length;
> > +
> > +		/* flush for anything other than partial eof zeroing */
> > +		if (pos != i_size_read(iter->inode) ||
> > +		   (pos % i_blocksize(iter->inode)) == 0) {
> >  			*range_dirty = false;
> >  			return iomap_zero_iter_flush_and_stale(iter);
> >  		}
> > -		/* range is clean and already zeroed, nothing to do */
> > -		return length;
> > +		/*
> > +		 * Special case partial EOF zeroing. Since we know the EOF
> > +		 * folio is dirty, prefer in-memory zeroing for it. This avoids
> > +		 * excessive flush latency on frequent file size extending
> > +		 * operations.
> > +		 */
> > +		eof_zero = true;
> >  	}
> >  
> >  	do {
> > @@ -1415,6 +1427,8 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
> >  		offset = offset_in_folio(folio, pos);
> >  		if (bytes > folio_size(folio) - offset)
> >  			bytes = folio_size(folio) - offset;
> > +		if (eof_zero && length > bytes)
> > +			length = bytes;
> 
> What does this do?  I think this causes the loop to break after putting
> the folio that caches @pos?  And then I guess we go around the loop in
> iomap_zero_range again if there were more bytes to zero after this
> folio?
> 

Yeah.. it's basically just saying that if we fell into folio zeroing due
to the special case logic above, only process through the end of this
particular folio and jump back out to process the rest of the range as
normal. The idea was just to prevent going off and doing a bunch of
unexpected zeroing across an unwritten mapping just because we had an
unaligned range that starts with a dirty folio.

FWIW, the reworked variant I have of this currently looks like the
appended diff. The caveat is this can still flush if a large folio
happens to overlap the two subranges, but as is seems to placate the
stress-ng test. In theory, I think having something like an
iomap_zero_folio(folio, start_pos, end_pos) that zeroed up through
min(end_pos, folio_end_pos) for the unaligned part would mitigate that,
but I'm not quite sure of a clean way to do that; particularly if we
have a large folio made up of multiple mappings. I'm also still
undecided on whether to unconditionally flush the rest or try to
preserve the flush_and_stale() approach as well.

Brian

--- 8< ---

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index aa587b2142e2..fcc55d8c1f14 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1351,22 +1351,8 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 }
 EXPORT_SYMBOL_GPL(iomap_file_unshare);
 
-/*
- * Flush the remaining range of the iter and mark the current mapping stale.
- * This is used when zero range sees an unwritten mapping that may have had
- * dirty pagecache over it.
- */
-static inline int iomap_zero_iter_flush_and_stale(struct iomap_iter *i)
-{
-	struct address_space *mapping = i->inode->i_mapping;
-	loff_t end = i->pos + i->len - 1;
-
-	i->iomap.flags |= IOMAP_F_STALE;
-	return filemap_write_and_wait_range(mapping, i->pos, end);
-}
-
 static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
-		bool *range_dirty)
+		bool range_dirty)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
@@ -1391,12 +1377,8 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 	 * triggers writeback time post-eof zeroing.
 	 */
 	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN) {
-		if (*range_dirty) {
-			*range_dirty = false;
-			return iomap_zero_iter_flush_and_stale(iter);
-		}
-		/* range is clean and already zeroed, nothing to do */
-		return length;
+		if (!range_dirty)
+			return length;
 	}
 
 	do {
@@ -1434,9 +1416,9 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 	return written;
 }
 
-int
-iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
-		const struct iomap_ops *ops)
+static loff_t
+__iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
+		const struct iomap_ops *ops, bool range_dirty)
 {
 	struct iomap_iter iter = {
 		.inode		= inode,
@@ -1445,28 +1427,55 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 		.flags		= IOMAP_ZERO,
 	};
 	int ret;
-	bool range_dirty;
+	loff_t count = 0;
+
+	while ((ret = iomap_iter(&iter, ops)) > 0) {
+		iter.processed = iomap_zero_iter(&iter, did_zero, range_dirty);
+		count += iter.processed;
+	}
+	return ret ? ret : count;
+}
+
+int
+iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
+		const struct iomap_ops *ops)
+{
+	struct address_space *mapping = inode->i_mapping;
+	unsigned int blocksize = i_blocksize(inode);
+	unsigned int off = pos & (blocksize - 1);
+	int ret;
 
 	/*
-	 * Zero range wants to skip pre-zeroed (i.e. unwritten) mappings, but
-	 * pagecache must be flushed to ensure stale data from previous
-	 * buffered writes is not exposed. A flush is only required for certain
-	 * types of mappings, but checking pagecache after mapping lookup is
-	 * racy with writeback and reclaim.
+	 * Zero range wants to skip mappings that are already zero on disk, but
+	 * the only way to handle unwritten mappings covered by dirty pagecache
+	 * is to flush and reprocess the converted mappings after I/O
+	 * completion.
 	 *
-	 * Therefore, check the entire range first and pass along whether any
-	 * part of it is dirty. If so and an underlying mapping warrants it,
-	 * flush the cache at that point. This trades off the occasional false
-	 * positive (and spurious flush, if the dirty data and mapping don't
-	 * happen to overlap) for simplicity in handling a relatively uncommon
-	 * situation.
+	 * The partial EOF zeroing use case is performance sensitive, so split
+	 * and handle an unaligned start of the range separately. The dirty
+	 * check tells the iter function whether it can skip or zero the folio
+	 * without needing to flush. Larger ranges tend to have already been
+	 * flushed by the filesystem, so flush the rest here as a safety measure
+	 * and process as normal.
 	 */
-	range_dirty = filemap_range_needs_writeback(inode->i_mapping,
-					pos, pos + len - 1);
+	if (off) {
+		loff_t count = min_t(loff_t, len, blocksize - off);
+		bool range_dirty = filemap_range_needs_writeback(mapping, pos,
+					pos + count - 1);
+		count = __iomap_zero_range(inode, pos, count, did_zero, ops,
+					range_dirty);
+		if (count < 0)
+			return count;
+		pos += count;
+		len -= count;
+	}
+	if (!len)
+		return 0;
 
-	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_zero_iter(&iter, did_zero, &range_dirty);
-	return ret;
+	ret = filemap_write_and_wait_range(mapping, pos, pos + len - 1);
+	if (!ret)
+		ret = __iomap_zero_range(inode, pos, len, did_zero, ops, false);
+	return ret > 0 ? 0 : ret;
 }
 EXPORT_SYMBOL_GPL(iomap_zero_range);


