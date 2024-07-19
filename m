Return-Path: <linux-fsdevel+bounces-24018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D71309379CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 17:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62AB71F21C08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 15:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D4C144316;
	Fri, 19 Jul 2024 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyXfMoYy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A53143723
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721402533; cv=none; b=fFTxfkC8JeFhkd/SSDPLGq0Z+hRdjmap8pySTXEL8e9E3WVjSRxvoJL+UJumWHi68nyD/VaosWV6Zd9GFN9+pPawkAJUrNS/XhxD5QVYa90F761HAhiro5w5r37tZ4IA5fV8dX19pLcnfkBWIb+0dF91t22IW7IyoMVB5AZ7dJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721402533; c=relaxed/simple;
	bh=SHW/LwvRG1aHnO8OkolBg1JUNi3mNqYQlHdJKE64Cyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpBuRV9lSR5OQISPlg4fOWjkXo+Q1ryEOIWaaiWdtchw75hhsN0iY+qD7obfCr887iCSJTlmi1GPuNw+MX9xhzeK9JM91r8op4hSdvhOS3dRSmtM8hMt+nbe2tRtbMSvtSaU8svWyntmXX1NxrHvbRsMFQ/krKzZ5ishvL2GJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RyXfMoYy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721402529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PCE4O/Tp9Kmg7NnSX/TlEVAmDfV/MnD1PiAPLrlkRgk=;
	b=RyXfMoYyZIUD967TStpJTpJLF/YzDlUFjeGKo7FfIpPPyXYI6HUHBkQZ97Ecn8BXQucyOE
	7enHIKPvQiSoFPdjTM2v5LismdXfdHoqSWm00KXo3cgnOA4B1tRSOnkFWPiyzC/5t6cEee
	OMv9vRPX4e4yUAoftSO5VBevPBWrZHw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-viQbmyEhNt6EfwlbZb8R1A-1; Fri,
 19 Jul 2024 11:22:08 -0400
X-MC-Unique: viQbmyEhNt6EfwlbZb8R1A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20CC619540F0;
	Fri, 19 Jul 2024 15:22:07 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.39])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11C231955D47;
	Fri, 19 Jul 2024 15:22:05 +0000 (UTC)
Date: Fri, 19 Jul 2024 11:22:50 -0400
From: Brian Foster <bfoster@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC 0/4] iomap: zero dirty folios over unwritten mappings
 on zero range
Message-ID: <ZpqEyg4m1_iRKoo4@bfoster>
References: <20240718130212.23905-1-bfoster@redhat.com>
 <Zpm9BFLjU0DkHBWc@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zpm9BFLjU0DkHBWc@dread.disaster.area>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Jul 19, 2024 at 11:10:28AM +1000, Dave Chinner wrote:
> On Thu, Jul 18, 2024 at 09:02:08AM -0400, Brian Foster wrote:
> > Hi all,
> > 
> > This is a stab at fixing the iomap zero range problem where it doesn't
> > correctly handle the case of an unwritten mapping with dirty pagecache.
> > The gist is that we scan the mapping for dirty cache, zero any
> > already-dirty folios via buffered writes as normal, but then otherwise
> > skip clean ranges once we have a chance to validate those ranges against
> > races with writeback or reclaim.
> > 
> > This is somewhat simplistic in terms of how it scans, but that is
> > intentional based on the existing use cases for zero range. From poking
> > around a bit, my current sense is that there isn't any user of zero
> > range that would ever expect to see more than a single dirty folio.
> 
> The current code generally only zeroes a single filesystem block or
> less because that's all we need to zero for partial writes.  This is
> not going to be true for very much longer with XFS forcealign
> functionality, and I suspect it's not true right now for large rt
> extent sizes when doing sub-extent writes. In these cases, we are
> going to have to zero multiple filesystem blocks during truncate,
> hole punch, unaligned writes, etc.
> 
> So even if we don't do this now, I think this is something we will
> almost certainly be doing in the next kernel release or two.
> 
> > Most
> > callers either straddle the EOF folio or flush in higher level code for
> > presumably (fs) context specific reasons. If somebody has an example to
> > the contrary, please let me know because I'd love to be able to use it
> > for testing.
> 
> Check the xfs_inode_has_bigrtalloc() and xfs_inode_alloc_unitsize()
> cases. These are currently being worked on and expanded and factored
> so eventually these cases will all fall under
> xfs_inode_alloc_unitsize().
> 
> > The caveat to this approach is that it only works for filesystems that
> > implement folio_ops->iomap_valid(), which is currently just XFS. GFS2
> > doesn't use ->iomap_valid() and does call zero range, but AFAICT it
> > doesn't actually export unwritten mappings so I suspect this is not a
> > problem. My understanding is that ext4 iomap support is in progress, but
> > I've not yet dug into what that looks like (though I suspect similar to
> > XFS). The concern is mainly that this leaves a landmine for fs that
> > might grow support for unwritten mappings && zero range but not
> > ->iomap_valid(). We'd likely never know zero range was broken for such
> > fs until stale data exposure problems start to materialize.
> > 
> > I considered adding a fallback to just add a flush at the top of
> > iomap_zero_range() so at least all future users would be correct, but I
> > wanted to gate that on the absence of ->iomap_valid() and folio_ops
> > isn't provided until iomap_begin() time. I suppose another way around
> > that could be to add a flags param to iomap_zero_range() where the
> > caller could explicitly opt out of a flush, but that's still kind of
> > ugly. I dunno, maybe better than nothing..?
> 
> We want to avoid the flush in this case if we can - what XFS does is
> a workaround for iomap not handling dirty data over unwritten
> extents. That first flush causes performance issues with certain
> truncate heavy workloads, so we really want to avoid it in the
> generic code if we can.
> 

Sort of.. the only complaint I've heard about this was due to reliance
on a userspace program with a subtly dumb and repetitive truncate
workload. We worked around this problem by fixing the userspace tool and
I've not heard a complaint since.

Even without that userspace fix, a conditional flush in the kernel would
have been perfectly suitable for the same workload (as in, pretty much
unnoticeable). So the broader point here is just that this isn't so
black and white that flushing at all is necessarily a problem.

> > So IMO, this raises the question of whether this is just unnecessarily
> > overcomplicated. The KISS principle implies that it would also be
> > perfectly fine to do a conditional "flush and stale" in zero range
> > whenever we see the combination of an unwritten mapping and dirty
> > pagecache (the latter checked before or during ->iomap_begin()). That's
> > simple to implement and AFAICT would work/perform adequately and
> > generically for all filesystems. I have one or two prototypes of this
> > sort of thing if folks want to see it as an alternative.
> 
> If we are going to zero the range, and the range is already
> unwritten, then why do we need to flush the data in the cache to
> make it clean and written before running the zeroing? Why not just
> invalidate the entire cache over the unwritten region and so return it
> all to containing zeroes (i.e. is unwritten!) without doing any IO.
> 
> Yes, if some of the range is under writeback, the invalidation will
> have to wait for that to complete - invalidate_inode_pages2_range()
> does this for us - but after the invalidation those regions will now
> be written and iomap revalidation after page cache invalidation will
> detect this.
> 
> So maybe the solution is simply to invalidate the cache over
> unwritten extents and then revalidate the iomap? If the iomap is
> still valid, then we can skip the unwritten extent completely. If
> the invalidation returned -EBUSY or the iomap is stale, then remap
> it and try again?
> 
> If we don't have an iomap validation function, then we could check
> filemap_range_needs_writeback() before calling
> invalidate_inode_pages2_range() as that will tell us if there were
> folios that might have been under writeback during the invalidation.
> In that case, we can treat "needs writeback" the same as a failed
> iomap revalidation.
> 
> So what am I missing? What does the flush actually accomplish that
> simply calling invalidate_inode_pages2_range() to throw the data we
> need to zero away doesn't?
> 

Ugh.. when I look at invalidate I see various additional corner case
complexities to think about, for pretty much no additional value over a
conditional flush, especially when you start getting into some of the
writeback complexities you've already noted above. Even if you could
make it work technically (which I'm not sure of), it looks like it would
be increasingly more difficult to properly test and maintain. I don't
really see much reason to go down that path without explicit
justification and perhaps some proving out.

I think the right approach to this problem is precisely what was
discussed up thread with Josef and Darrick. Do the simple and
generically correct thing by lifting the unconditional flush from XFS,
optimize to make the flush conditional to dirty+unwritten while still
being fs generic, and then finally optimize away the flush entirely for
filesystems that provide the proper revalidation support like XFS.

A benefit of that is we can start with a tested and veriable functional
base to iterate from and fall back on. I think the mapping iteration
thing from the patch 3 discussion might turn out elegant enough that
maybe we'll come up with a generic non-flushing solution based on that
(I have some vague thoughts that require investigation) once we have
some code to poke around at.

Brian

P.S., I'm off for a week or so after today. I'll think more about the
mapping iteration idea and then try to put something together once I'm
back.

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 


