Return-Path: <linux-fsdevel+bounces-27870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B732964968
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052A42821A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12569194C88;
	Thu, 29 Aug 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWm7E27X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A41B1502
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943818; cv=none; b=Hpnu3JVjuH5g9jjGRumKFH33jmtvaqZm3A4RH4SnlHJx8PYkG3Uh1xnHM1Dma8xLRTeow6J0BpeQVxV9g7pgZY9bXizsB7VZ9ZdkGqudk46uBpKG24RD42H3dUDpMnZGwPkbqWvVN/xfP209fXvd+eKXx4JQxItc6Yahbiz2qa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943818; c=relaxed/simple;
	bh=8vNO7Rbk8GOuaZ901bKO/EAWXuWf7IknVeYO4V3Pn3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/E7AbsJKcSdDClrFMzHgGGPQqqf2mzW6EJBpbwaiqNBiyUUvfsq8W+uyFAfjViupIHaeZ3sXNl+9ObjfKssvG+FFxzuT8NiZT+u7udbzf9ZEbkjP0J5R0JrKOQtl8KHNrB4OxeVdlS1L6hHmLhHZsh2SR1skUDvtbjsHXzDxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWm7E27X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724943816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=952cIaJDDi22U/iXtlkiHY69WJa8ULf24IPZ11gj2Sk=;
	b=PWm7E27Xaszs7fHdrhAu91aLan4pVRsOkqDanzhE4kLbNp+394qVzhgaFuNqL8VNqbZU73
	VQDiezL2jobOjHLytW+2RMrkVUPPMM+EZA8BorcTsa98WuKswjUPjbUF+r1RmbDvFfxH4n
	5IL7irhtOpPqfd/oe2/HdNFOAJQjNvY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-DVBSm686OqOr11wlzFoerQ-1; Thu,
 29 Aug 2024 11:03:30 -0400
X-MC-Unique: DVBSm686OqOr11wlzFoerQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 272AA1954B32;
	Thu, 29 Aug 2024 15:03:29 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.95])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02E2E3002240;
	Thu, 29 Aug 2024 15:03:27 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:04:28 -0400
From: Brian Foster <bfoster@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH v2 2/2] iomap: make zero range flush conditional on
 unwritten mappings
Message-ID: <ZtCN_Gtw850JFqq0@bfoster>
References: <20240828181912.41517-1-bfoster@redhat.com>
 <20240828181912.41517-3-bfoster@redhat.com>
 <20240828224420.GC6224@frogsfrogsfrogs>
 <Zs/AHi/UwAQ1zVdj@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs/AHi/UwAQ1zVdj@dread.disaster.area>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Aug 29, 2024 at 10:26:06AM +1000, Dave Chinner wrote:
> On Wed, Aug 28, 2024 at 03:44:20PM -0700, Darrick J. Wong wrote:
> > On Wed, Aug 28, 2024 at 02:19:11PM -0400, Brian Foster wrote:
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
> > static inline bool iomap_zero_need_flush(const struct iomap_iter *i)
> > {
> > 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> > 
> > 	return srcmap->type == IOMAP_HOLE ||
> > 	       srcmap->type == IOMAP_UNWRITTEN;
> > }
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
> > 	}
> > 
> > The logic looks correct and sensible. :)
> 
> Yeah, I think this is better.
> 
> However, the one thing that both versions have in common is that
> they don't explain -why- the iomap needs to be marked stale.
> So, something like:
> 
> "When we flush the dirty data over the range, the extent state for
> the range will change. We need to to know that new state before
> performing any zeroing operations on the range.  Hence we mark the
> iomap stale so that the iterator will remap this range and the next
> ieration pass will see the new extent state and perform the correct
> zeroing operation for the range."
> 

Sure, I'll update the comments however the factoring ultimately turns
out. Thanks.

Brian

> -Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
> 


