Return-Path: <linux-fsdevel+bounces-34459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1139C59B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 14:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A764284DC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F97C1FBF5F;
	Tue, 12 Nov 2024 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBnug96z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731BC1FBC90
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419883; cv=none; b=T/7ugLI9ktdz5fxWocBSEgy1yS671PBv0BvanKN30Ihz6VceLF7+ZA2tTvSZXgDoRilp/AlW19sI9CRxd9NMEEcT2sTwazCYaTRIPYnESC05CeSLL0xcb+sH77sf+slrKN0bmGoyJNqnlafDVl48UiDNGi8ZKOTmRF/0MWYtZtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419883; c=relaxed/simple;
	bh=8tZb7WvyMFbPTYHm5mhPbsXITAIOaIFt7bH6Vlab0dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpSPMUqssHK9mb65tmLbHE0woSWMV94k5zisBrNMr5OfySwdPh19WFecWhw7dnYxTNFPsF9Mvtr48dtWy0yp5iuOisGyVv5YMZEwQP7vuqKkCvOmbWcQd1MUxA49cuYh3uK7PciDEOPF3YHrqnF9iSO4jghfuRKoA+6WYdO0wLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBnug96z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731419880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gydm4f3yRWOR5piGiWhP5Qnp24ZxuazT7nFw+HFkeE0=;
	b=EBnug96zF0GcXsac+LG/doJB1REAfk7NcJp4tgRMZ5QhEjJZuJk7G69Bm+ZGGp9uec/sd6
	3f+QaPQU2gpSRivjkieltJ3Zq+JzjuJwELszznlL4OBh1duwRo0Q0Vrg7Vg5suvyKj+58i
	Crhk8K/7GNuV4h+ByBDqAxxxN9fCOTU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-mWpm4jGMPqGzUR7UbSjuTQ-1; Tue,
 12 Nov 2024 08:57:58 -0500
X-MC-Unique: mWpm4jGMPqGzUR7UbSjuTQ-1
X-Mimecast-MFC-AGG-ID: mWpm4jGMPqGzUR7UbSjuTQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B57CE1953955;
	Tue, 12 Nov 2024 13:57:57 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.120])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C4DC19560A3;
	Tue, 12 Nov 2024 13:57:56 +0000 (UTC)
Date: Tue, 12 Nov 2024 08:59:29 -0500
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iomap: lift zeroed mapping handling into
 iomap_zero_range()
Message-ID: <ZzNfQYdn7az_mvN9@bfoster>
References: <20241108124246.198489-1-bfoster@redhat.com>
 <20241108124246.198489-3-bfoster@redhat.com>
 <20241109030127.GB9421@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109030127.GB9421@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Nov 08, 2024 at 07:01:27PM -0800, Darrick J. Wong wrote:
> On Fri, Nov 08, 2024 at 07:42:44AM -0500, Brian Foster wrote:
> > In preparation for special handling of subranges, lift the zeroed
> > mapping logic from the iterator into the caller. Since this puts the
> > pagecache dirty check and flushing in the same place, streamline the
> > comments a bit as well.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/iomap/buffered-io.c | 64 +++++++++++++++---------------------------
> >  1 file changed, 22 insertions(+), 42 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index ef0b68bccbb6..a78b5b9b3df3 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1350,40 +1350,12 @@ static inline int iomap_zero_iter_flush_and_stale(struct iomap_iter *i)
> >  	return filemap_write_and_wait_range(mapping, i->pos, end);
> >  }
> >  
> > -static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
> > -		bool *range_dirty)
> > +static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> >  {
> > -	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> >  	loff_t pos = iter->pos;
> >  	loff_t length = iomap_length(iter);
> >  	loff_t written = 0;
> >  
> > -	/*
> > -	 * We must zero subranges of unwritten mappings that might be dirty in
> > -	 * pagecache from previous writes. We only know whether the entire range
> > -	 * was clean or not, however, and dirty folios may have been written
> > -	 * back or reclaimed at any point after mapping lookup.
> > -	 *
> > -	 * The easiest way to deal with this is to flush pagecache to trigger
> > -	 * any pending unwritten conversions and then grab the updated extents
> > -	 * from the fs. The flush may change the current mapping, so mark it
> > -	 * stale for the iterator to remap it for the next pass to handle
> > -	 * properly.
> > -	 *
> > -	 * Note that holes are treated the same as unwritten because zero range
> > -	 * is (ab)used for partial folio zeroing in some cases. Hole backed
> > -	 * post-eof ranges can be dirtied via mapped write and the flush
> > -	 * triggers writeback time post-eof zeroing.
> > -	 */
> > -	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN) {
> > -		if (*range_dirty) {
> > -			*range_dirty = false;
> > -			return iomap_zero_iter_flush_and_stale(iter);
> > -		}
> > -		/* range is clean and already zeroed, nothing to do */
> > -		return length;
> > -	}
> > -
> >  	do {
> >  		struct folio *folio;
> >  		int status;
> > @@ -1433,24 +1405,32 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> >  	bool range_dirty;
> >  
> >  	/*
> > -	 * Zero range wants to skip pre-zeroed (i.e. unwritten) mappings, but
> > -	 * pagecache must be flushed to ensure stale data from previous
> > -	 * buffered writes is not exposed. A flush is only required for certain
> > -	 * types of mappings, but checking pagecache after mapping lookup is
> > -	 * racy with writeback and reclaim.
> > +	 * Zero range can skip mappings that are zero on disk so long as
> > +	 * pagecache is clean. If pagecache was dirty prior to zero range, the
> > +	 * mapping converts on writeback completion and so must be zeroed.
> >  	 *
> > -	 * Therefore, check the entire range first and pass along whether any
> > -	 * part of it is dirty. If so and an underlying mapping warrants it,
> > -	 * flush the cache at that point. This trades off the occasional false
> > -	 * positive (and spurious flush, if the dirty data and mapping don't
> > -	 * happen to overlap) for simplicity in handling a relatively uncommon
> > -	 * situation.
> > +	 * The simplest way to deal with this across a range is to flush
> > +	 * pagecache and process the updated mappings. To avoid an unconditional
> > +	 * flush, check pagecache state and only flush if dirty and the fs
> > +	 * returns a mapping that might convert on writeback.
> >  	 */
> >  	range_dirty = filemap_range_needs_writeback(inode->i_mapping,
> >  					pos, pos + len - 1);
> > +	while ((ret = iomap_iter(&iter, ops)) > 0) {
> > +		const struct iomap *s = iomap_iter_srcmap(&iter);
> > +
> > +		if (s->type == IOMAP_HOLE || s->type == IOMAP_UNWRITTEN) {
> > +			loff_t p = iomap_length(&iter);
> 
> Another dumb nit: blank line after the declaration.
> 

Fixed.

> With that fixed, this is ok by me for further testing:
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 

Thanks.

Brian

> --D
> 
> > +			if (range_dirty) {
> > +				range_dirty = false;
> > +				p = iomap_zero_iter_flush_and_stale(&iter);
> > +			}
> > +			iter.processed = p;
> > +			continue;
> > +		}
> >  
> > -	while ((ret = iomap_iter(&iter, ops)) > 0)
> > -		iter.processed = iomap_zero_iter(&iter, did_zero, &range_dirty);
> > +		iter.processed = iomap_zero_iter(&iter, did_zero);
> > +	}
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(iomap_zero_range);
> > -- 
> > 2.47.0
> > 
> > 
> 


