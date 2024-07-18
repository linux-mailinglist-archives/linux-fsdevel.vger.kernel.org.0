Return-Path: <linux-fsdevel+bounces-23939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5B593505D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 18:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D1E1C20F38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F0D143C59;
	Thu, 18 Jul 2024 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iI0Cu8PP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F04E13C3E6;
	Thu, 18 Jul 2024 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318524; cv=none; b=ubZmf98AmTBliezwLSZtPpPlwyoMVwJpmQ4HuSFSlYQPVcMtpHtpS8enApWfF32whGlV3hPg1E3JsHJfGJK6/FnNifdNGUnovwxFS7X//DS0yaC4Df9qp8pP3tdAsamnAnUaFFUVsBOtGKNlvcLLJyw4eUrZHhsZDnisKbzEOEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318524; c=relaxed/simple;
	bh=chaMx9s0OPNI5Z83DMujo8XKQemJrFuGl7D3JBJIH/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuQeVhJ0s2h8s1mX411hUPbG116r7eHJBeGO3UpIgCzlb2mw4xYQXc3zD+4qhQvV3PCWv0ktVPQf6PTBK9KD9R3doOOdTF0GLpnh+fNoOExCavjXFX/3JBr0gwACI7IW7CZ84zMBp5uKXIj+H+XV+3ehw1ktXKf7x8xXYo+r3FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iI0Cu8PP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0050C116B1;
	Thu, 18 Jul 2024 16:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721318523;
	bh=chaMx9s0OPNI5Z83DMujo8XKQemJrFuGl7D3JBJIH/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iI0Cu8PPtEXbTYKZQp8/M7xkyPuUFZoXYWEk5RZil8xgg3YSv1wLP6shLL7c52bAP
	 oygIa4yxoGc3jYydhbfvDcZWqQTLg87J2nfdHBf0nWue9vwvwdZ0YRkD0eJw8jLEMO
	 ypNOKyxRyfhkiduJVs3KKd8qVDeHgq8Jif8YuV+eNZbpcx8wB8TisWdwAyE3mFasm2
	 lF+V2gvDjg0PjBE0K2UpkGW7MW9xa6Ea38F1iM1Gsf5TKdPKmZ+Dwd6L4++7S3dukK
	 amwfHiexgKzRYQe4CKZGaXx6LuscSa7cpxAVKok2E5tcfXY0KHR3kCv5Au4rsok5jk
	 2sDi+Ly+E1QYA==
Date: Thu, 18 Jul 2024 09:02:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 0/4] iomap: zero dirty folios over unwritten mappings
 on zero range
Message-ID: <20240718160202.GL612460@frogsfrogsfrogs>
References: <20240718130212.23905-1-bfoster@redhat.com>
 <20240718153613.GC2099026@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718153613.GC2099026@perftesting>

On Thu, Jul 18, 2024 at 11:36:13AM -0400, Josef Bacik wrote:
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
> > range that would ever expect to see more than a single dirty folio. Most
> > callers either straddle the EOF folio or flush in higher level code for
> > presumably (fs) context specific reasons. If somebody has an example to
> > the contrary, please let me know because I'd love to be able to use it
> > for testing.
> > 
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

Or move ->iomap_valid to the iomap ops structure.  It's a mapping
predicate, and has nothing to do with folios.

> > So IMO, this raises the question of whether this is just unnecessarily
> > overcomplicated. The KISS principle implies that it would also be
> > perfectly fine to do a conditional "flush and stale" in zero range
> > whenever we see the combination of an unwritten mapping and dirty
> > pagecache (the latter checked before or during ->iomap_begin()). That's
> > simple to implement and AFAICT would work/perform adequately and
> > generically for all filesystems. I have one or two prototypes of this
> > sort of thing if folks want to see it as an alternative.

I wouldn't mind seeing such a prototype.  Start by hoisting the
filemap_write_and_wait_range call to iomap, then adjust it only to do
that if there's dirty pagecache + unwritten mappings?  Then get more
complicated from there, and we can decide if we want the increasing
levels of trickiness.

> I think this is the better approach, otherwise there's another behavior that's
> gated behind having a callback that other filesystems may not know about and
> thus have a gap.

<nod> I think filesystems currently only need to supply an ->iomap_valid
function for pagecache operations because those are the only ones where
we have to maintain consistency between something that isn't locked when
we get the mapping, and the mapping not being locked when we lock that
first thing.  I suspect they also only need to supply it if they support
unwritten extents.

From what I can tell, the rest (e.g. directio/FIEMAP) don't care because
callers get to manage concurrency.

*But* in general it makes sense to me that any iomap operation ought to
be able to revalidate a mapping at any time.

> Additionally do you have a test for this stale data exposure?  I think no matter
> what the solution it would be good to have a test for this so that we can make
> sure we're all doing the correct thing with zero range.  Thanks,

I was also curious about this.   IIRC we have some tests for the
validiting checking itself, but I don't recall if there's a specific
regression test for the eofblock clearing.

--D

> Josef
> 

