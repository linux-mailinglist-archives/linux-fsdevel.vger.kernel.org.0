Return-Path: <linux-fsdevel+bounces-51158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C47AD35DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 14:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B169D7A29E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 12:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44E028F929;
	Tue, 10 Jun 2025 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5I51PxI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D873010C
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749557858; cv=none; b=E6kmZYGEhaj8tWZUUDyjUF8MHD4CeRgtStic8Y5W5Tf/PR3i7TdENtplMY4aMbNifNtQAD3Zekn3gLAXvRB/Zn3BdGO9b1C9ws/VTeTkuQBhIF6PLWbN0dx7miYK+BbYNKYoM2nTd/9UKwj2Vg1y6htLX9Nc/eyrgsMUD1F/zvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749557858; c=relaxed/simple;
	bh=H4B53sXp0YsOqCqQnepI80STN/qEuT5OMxUclglXcsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdgUSDWVB0y6Rtg+U7Z3lGeBBWlV0icKgZ9aVbHZvEO369xKd+zxnYwHF6uD0VpVP/3A0ia4ibL2g3EAzPC/Fb72s30aeJwz3/KHb02riok/8rnL/ezXj8pSvsAbxcac+qtYTp9CfXpXrgfRgpe3L+OBON5+9zNKv3+GhwpUf88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H5I51PxI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749557854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wWkH+ATn9gMRInrtjCUClax6F1Bqidl50cWttGkZrSg=;
	b=H5I51PxIel2WWDnk76KTBbceBO96rCfJDSO3iiPYLomVGUiHMYtYcIzIMo76lIO2k9Qziz
	r6Xsbjiyy61rItWrYWRd4QKrdjE5rblbwAT1ukbrJKIbQkJ+vAHvP3HTExm8IKZ64d78d/
	ydewR1WUICnVxlAjRy7zJYgc+AatxG8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-ZCW3PQPkOEmSv4HQt-yL4A-1; Tue,
 10 Jun 2025 08:17:33 -0400
X-MC-Unique: ZCW3PQPkOEmSv4HQt-yL4A-1
X-Mimecast-MFC-AGG-ID: ZCW3PQPkOEmSv4HQt-yL4A_1749557852
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FF691808985;
	Tue, 10 Jun 2025 12:17:32 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.100])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9366019560AF;
	Tue, 10 Jun 2025 12:17:31 +0000 (UTC)
Date: Tue, 10 Jun 2025 08:21:06 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/7] iomap: optional zero range dirty folio processing
Message-ID: <aEgjMtAONSHz6yJT@bfoster>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-4-bfoster@redhat.com>
 <20250609160420.GC6156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609160420.GC6156@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Jun 09, 2025 at 09:04:20AM -0700, Darrick J. Wong wrote:
> On Thu, Jun 05, 2025 at 01:33:53PM -0400, Brian Foster wrote:
> > The only way zero range can currently process unwritten mappings
> > with dirty pagecache is to check whether the range is dirty before
> > mapping lookup and then flush when at least one underlying mapping
> > is unwritten. This ordering is required to prevent iomap lookup from
> > racing with folio writeback and reclaim.
> > 
> > Since zero range can skip ranges of unwritten mappings that are
> > clean in cache, this operation can be improved by allowing the
> > filesystem to provide a set of dirty folios that require zeroing. In
> > turn, rather than flush or iterate file offsets, zero range can
> > iterate on folios in the batch and advance over clean or uncached
> > ranges in between.
> > 
> > Add a folio_batch in struct iomap and provide a helper for fs' to
> > populate the batch at lookup time. Update the folio lookup path to
> > return the next folio in the batch, if provided, and advance the
> > iter if the folio starts beyond the current offset.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/iomap/buffered-io.c | 73 +++++++++++++++++++++++++++++++++++++++---
> >  fs/iomap/iter.c        |  6 ++++
> >  include/linux/iomap.h  |  4 +++
> >  3 files changed, 78 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 16499655e7b0..cf2f4f869920 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -750,6 +750,16 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter, size_t len)
> >  	if (!mapping_large_folio_support(iter->inode->i_mapping))
> >  		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
> >  
> > +	if (iter->fbatch) {
> > +		struct folio *folio = folio_batch_next(iter->fbatch);
> > +
> > +		if (folio) {
> > +			folio_get(folio);
> > +			folio_lock(folio);
> 
> Hrm.  So each folio that is added to the batch isn't locked, nor does
> the batch (or iomap) hold a refcount on the folio until we get here.  Do
> we have to re-check that folio->{mapping,index} match what iomap is
> trying to process?  Or can we assume that nobody has removed the folio
> from the mapping?
> 

The filemap helper grabs a reference to the folio but doesn't
necessarily lock it. The ref is effectively transferred to the batch
there and the _get() here creates the iomap reference (i.e. that is
analogous to the traditional iomap get folio path). The batch is
ultimately released via folio_batch_release() and the iomap refs dropped
in the same way regardless of whether iomap grabbed it itself or was
part of a patch.

> I'm wondering because __filemap_get_folio/filemap_get_entry seem to do
> all that for us.  I think the folio_pos check below might cover some of
> that revalidation?
> 

I'm not totally sure the folio revalidation is necessarily required
here.. If it is, I'd also need to think about whether it's ok to skip
such folios or the approach here needs revisiting. I'll take a closer
look and also try to document this better and get some feedback from
people who know this code better in the next go around..

> > +		}
> > +		return folio;
> > +	}
> > +
> >  	if (folio_ops && folio_ops->get_folio)
> >  		return folio_ops->get_folio(iter, pos, len);
> >  	else
...
> > @@ -819,6 +831,12 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
> >  	if (IS_ERR(folio))
> >  		return PTR_ERR(folio);
> >  
> > +	/* no folio means we're done with a batch */
> 
> ...ran out of folios but *plen is nonzero, i.e. we still have range to
> cover?
> 

Yes I suppose that is implied by being in this path.. will fix.

> > +	if (!folio) {
> > +		WARN_ON_ONCE(!iter->fbatch);
> > +		return 0;
> > +	}
> > +
> >  	/*
> >  	 * Now we have a locked folio, before we do anything with it we need to
> >  	 * check that the iomap we have cached is not stale. The inode extent
...
> > +
> >  int
> >  iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> >  		const struct iomap_ops *ops, void *private)
...
> > @@ -1445,13 +1503,18 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> >  	 * if dirty and the fs returns a mapping that might convert on
> >  	 * writeback.
> >  	 */
> > -	range_dirty = filemap_range_needs_writeback(inode->i_mapping,
> > -					iter.pos, iter.pos + iter.len - 1);
> > +	range_dirty = filemap_range_needs_writeback(mapping, iter.pos,
> > +					iter.pos + iter.len - 1);
> >  	while ((ret = iomap_iter(&iter, ops)) > 0) {
> >  		const struct iomap *srcmap = iomap_iter_srcmap(&iter);
> >  
> > -		if (srcmap->type == IOMAP_HOLE ||
> > -		    srcmap->type == IOMAP_UNWRITTEN) {
> > +		if (WARN_ON_ONCE(iter.fbatch &&
> > +				 srcmap->type != IOMAP_UNWRITTEN))
> 
> I wonder, are you planning to expand the folio batching to other
> buffered-io.c operations?  Such that the iter.fbatch checks might some
> day go away?
> 

Yes.. but I'm not totally sure wrt impact on the fbatch checks quite
yet. The next thing I wanted to look at is addressing the same unwritten
mapping vs. dirty folios issue in the seek data/hole path. It's been a
little while since I last investigated there (and that was also before
the whole granular advance approach was devised), but IIRC it would look
rather similar to what this is doing for zero range. That may or may
not justify just making the batch required for both operations and
potentially simplifying this logic further. I'll keep that in mind when
I get to it..

After that, I may play around with the buffered write path, but that is
a larger change with slightly different scope and requirements..

Brian

> --D
> 
> > +			return -EIO;
> > +
> > +		if (!iter.fbatch &&
> > +		    (srcmap->type == IOMAP_HOLE ||
> > +		     srcmap->type == IOMAP_UNWRITTEN)) {
> >  			s64 status;
> >  
> >  			if (range_dirty) {
> > diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> > index 6ffc6a7b9ba5..89bd5951a6fd 100644
> > --- a/fs/iomap/iter.c
> > +++ b/fs/iomap/iter.c
> > @@ -9,6 +9,12 @@
> >  
> >  static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
> >  {
> > +	if (iter->fbatch) {
> > +		folio_batch_release(iter->fbatch);
> > +		kfree(iter->fbatch);
> > +		iter->fbatch = NULL;
> > +	}
> > +
> >  	iter->status = 0;
> >  	memset(&iter->iomap, 0, sizeof(iter->iomap));
> >  	memset(&iter->srcmap, 0, sizeof(iter->srcmap));
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index 522644d62f30..0b9b460b2873 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -9,6 +9,7 @@
> >  #include <linux/types.h>
> >  #include <linux/mm_types.h>
> >  #include <linux/blkdev.h>
> > +#include <linux/pagevec.h>
> >  
> >  struct address_space;
> >  struct fiemap_extent_info;
> > @@ -239,6 +240,7 @@ struct iomap_iter {
> >  	unsigned flags;
> >  	struct iomap iomap;
> >  	struct iomap srcmap;
> > +	struct folio_batch *fbatch;
> >  	void *private;
> >  };
> >  
> > @@ -345,6 +347,8 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
> >  bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
> >  int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
> >  		const struct iomap_ops *ops);
> > +loff_t iomap_fill_dirty_folios(struct iomap_iter *iter, loff_t offset,
> > +		loff_t length);
> >  int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
> >  		bool *did_zero, const struct iomap_ops *ops, void *private);
> >  int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> > -- 
> > 2.49.0
> > 
> > 
> 


