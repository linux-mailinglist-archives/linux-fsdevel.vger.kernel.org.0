Return-Path: <linux-fsdevel+bounces-23946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FECB9350C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 18:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87DE91F22012
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 16:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B236144D3E;
	Thu, 18 Jul 2024 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUm0sJBM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1003144D09
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721320789; cv=none; b=H03PyBAFKCQRZcN/4q+SxtoCITLG0TFYM15/trVCg/eLX2wZ2sPCWUx6t6Nf5x6Us+7YpfoTg6oinYsbXuPmUVgGzspyQ7QqfG8uZoxiiyp3HDmpDPjJ7CAL+EvsoiRrHnj4p8EMfnoEUOn7/qbRTX2rbVptx/pHbd8W026uetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721320789; c=relaxed/simple;
	bh=EX6DHg0HYzT6jM5lxBj4cnz+dPlc+x116RSdrsqJwvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIG20J/pkrGY3yWnIMwRV85+kZR+rYGxUVzcVBfWlj+1/LI3MwVwgoq18dHaQtYwttzIjaXsCWFfRbhG5EBPmx4nPvuVCBlw0ASSAFcNEMIlSva1d8W/4BADVqICvXY02xxGLVU5kV9wsAs1ULO6pgId3jYMAJ4W7lXfA/gvu9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUm0sJBM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721320786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mro/2ws3n8wrTIO9avQDlSTjl3ysAKkxCf8Y1r35j9Y=;
	b=bUm0sJBMtoHXu1yi8r30T7uNRTifTfR1YTyHm60CgMndMAmECzZ+2t1IXvenP5ACBTlvU2
	FnYYnSTh0RY4vK/jE00SOPLLXCtDG/d4bYQiSr3/etXMOU61e2v9MKyKzzJtX+Kv42JHll
	liBfj4JAq4Sv6olqbbkqS+HQturmj9U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-8ghOjeQWOHyfXsWUkYnmhA-1; Thu,
 18 Jul 2024 12:39:41 -0400
X-MC-Unique: 8ghOjeQWOHyfXsWUkYnmhA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BF2E1955D58;
	Thu, 18 Jul 2024 16:39:40 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.39])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0C2A3000189;
	Thu, 18 Jul 2024 16:39:38 +0000 (UTC)
Date: Thu, 18 Jul 2024 12:40:20 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 0/4] iomap: zero dirty folios over unwritten mappings
 on zero range
Message-ID: <ZplFdASEm1LPtVD-@bfoster>
References: <20240718130212.23905-1-bfoster@redhat.com>
 <20240718153613.GC2099026@perftesting>
 <20240718160202.GL612460@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718160202.GL612460@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Jul 18, 2024 at 09:02:02AM -0700, Darrick J. Wong wrote:
> On Thu, Jul 18, 2024 at 11:36:13AM -0400, Josef Bacik wrote:
> > On Thu, Jul 18, 2024 at 09:02:08AM -0400, Brian Foster wrote:
> > > Hi all,
> > > 
> > > This is a stab at fixing the iomap zero range problem where it doesn't
> > > correctly handle the case of an unwritten mapping with dirty pagecache.
> > > The gist is that we scan the mapping for dirty cache, zero any
> > > already-dirty folios via buffered writes as normal, but then otherwise
> > > skip clean ranges once we have a chance to validate those ranges against
> > > races with writeback or reclaim.
> > > 
> > > This is somewhat simplistic in terms of how it scans, but that is
> > > intentional based on the existing use cases for zero range. From poking
> > > around a bit, my current sense is that there isn't any user of zero
> > > range that would ever expect to see more than a single dirty folio. Most
> > > callers either straddle the EOF folio or flush in higher level code for
> > > presumably (fs) context specific reasons. If somebody has an example to
> > > the contrary, please let me know because I'd love to be able to use it
> > > for testing.
> > > 
> > > The caveat to this approach is that it only works for filesystems that
> > > implement folio_ops->iomap_valid(), which is currently just XFS. GFS2
> > > doesn't use ->iomap_valid() and does call zero range, but AFAICT it
> > > doesn't actually export unwritten mappings so I suspect this is not a
> > > problem. My understanding is that ext4 iomap support is in progress, but
> > > I've not yet dug into what that looks like (though I suspect similar to
> > > XFS). The concern is mainly that this leaves a landmine for fs that
> > > might grow support for unwritten mappings && zero range but not
> > > ->iomap_valid(). We'd likely never know zero range was broken for such
> > > fs until stale data exposure problems start to materialize.
> > > 
> > > I considered adding a fallback to just add a flush at the top of
> > > iomap_zero_range() so at least all future users would be correct, but I
> > > wanted to gate that on the absence of ->iomap_valid() and folio_ops
> > > isn't provided until iomap_begin() time. I suppose another way around
> > > that could be to add a flags param to iomap_zero_range() where the
> > > caller could explicitly opt out of a flush, but that's still kind of
> > > ugly. I dunno, maybe better than nothing..?
> 
> Or move ->iomap_valid to the iomap ops structure.  It's a mapping
> predicate, and has nothing to do with folios.
> 

Good idea. That might be an option.

> > > So IMO, this raises the question of whether this is just unnecessarily
> > > overcomplicated. The KISS principle implies that it would also be
> > > perfectly fine to do a conditional "flush and stale" in zero range
> > > whenever we see the combination of an unwritten mapping and dirty
> > > pagecache (the latter checked before or during ->iomap_begin()). That's
> > > simple to implement and AFAICT would work/perform adequately and
> > > generically for all filesystems. I have one or two prototypes of this
> > > sort of thing if folks want to see it as an alternative.
> 
> I wouldn't mind seeing such a prototype.  Start by hoisting the
> filemap_write_and_wait_range call to iomap, then adjust it only to do
> that if there's dirty pagecache + unwritten mappings?  Then get more
> complicated from there, and we can decide if we want the increasing
> levels of trickiness.
> 

Yeah, exactly. Start with an unconditional flush at the top of
iomap_zero_range() (which perhaps also serves as a -stable fix), then
replace it with an unconditional dirty cache check and a conditional
flush/stale down in zero_iter() (for the dirty+unwritten case). With
that false positives from the cache check are less of an issue because
the only consequence is basically just a spurious flush. From there, the
revalidation approach could be an optional further optimization to avoid
the flush entirely, but we'll have to see if it's worth the complexity.

I have various experimental patches around that pretty much do the
conditional flush thing. I just have to form it into a presentable
series.

> > I think this is the better approach, otherwise there's another behavior that's
> > gated behind having a callback that other filesystems may not know about and
> > thus have a gap.
> 
> <nod> I think filesystems currently only need to supply an ->iomap_valid
> function for pagecache operations because those are the only ones where
> we have to maintain consistency between something that isn't locked when
> we get the mapping, and the mapping not being locked when we lock that
> first thing.  I suspect they also only need to supply it if they support
> unwritten extents.
> 
> From what I can tell, the rest (e.g. directio/FIEMAP) don't care because
> callers get to manage concurrency.
> 
> *But* in general it makes sense to me that any iomap operation ought to
> be able to revalidate a mapping at any time.
> 
> > Additionally do you have a test for this stale data exposure?  I think no matter
> > what the solution it would be good to have a test for this so that we can make
> > sure we're all doing the correct thing with zero range.  Thanks,
> 
> I was also curious about this.   IIRC we have some tests for the
> validiting checking itself, but I don't recall if there's a specific
> regression test for the eofblock clearing.
> 

Err.. yeah. I have some random test sequences around that reproduce some
of these issues. I'll form them into an fstest to go along with this.

Thank you both for the feedback.

Brian

> --D
> 
> > Josef
> > 
> 


