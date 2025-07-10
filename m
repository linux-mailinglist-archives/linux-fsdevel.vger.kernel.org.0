Return-Path: <linux-fsdevel+bounces-54540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC5B009D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 19:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D225C483C68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 17:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8D02F0C67;
	Thu, 10 Jul 2025 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKJhFope"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8382622423A;
	Thu, 10 Jul 2025 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168181; cv=none; b=OC38mianWGPwGUue4pi6j6YZQZKf5eX2IOk92ijVkAQXSu2QFy8IBoDchYwWCpHVg7zGR0oypdDrq3kaCAJKbgj6S0J0RhKggIhPW9Pbke9tLCgj26A9M/AFqQ9cxaqwEd2xUV9x4BzqWuOuquvDoxVsIuePbVmfzR3M3uBKRK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168181; c=relaxed/simple;
	bh=V255YLFB1n8qZG3lZpwtNT15v0OgXI6hDpqjbbF7/9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bg6BAG3CiAWKreSjrTWgFtoIrUpZjgRuidEgL1pMO353FMyiYcYCHjVZOChfLfgp0sD7iRzg/FlhiAgfGbs0AYDnA+OQXLIXP3tlezVWHnYQ6gj5AGGCSNYagvu6Ee6hUIsMmTdyVe9xPVzToshxe4PlUqTRjbBB0LQcK4o+Vns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKJhFope; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C552AC4CEE3;
	Thu, 10 Jul 2025 17:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752168181;
	bh=V255YLFB1n8qZG3lZpwtNT15v0OgXI6hDpqjbbF7/9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QKJhFopeKDrpzY+2KvoVXeTP5orLVtemBroS8JmMLRSGXW/E82wWf06sAU3FFfZvL
	 2Ch64of+GDN5EQC8R8FgRG/oUI0MPV+mCiAwh5RmEVcdwwvCA3479oF5xFEZbx0D/K
	 Vlp60eRAesixtko2acE1HVniyLOxaTPkJvOUmcnUxaRZRhahKsv+lDw85+ugVmaGec
	 4bhCPpdl4dX6lw3dTHVzKMEj1gXEIaMRp6yEUaGOS2FTu044ccQwCdHCdq5KSM2dOj
	 2uR3eMK3kBW+mFU9KD6XB2ZfvxFnYZE45umNq2694KBwvo7U22IdiNqjZBA/zZPQVu
	 vm+VbjiRWNuOA==
Date: Thu, 10 Jul 2025 13:22:59 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	hch@infradead.org, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/8] lib/iov_iter: remove piecewise bvec length
 checking in iov_iter_aligned_bvec
Message-ID: <aG_28zNe3T-wt7L8@kernel.org>
References: <20250708160619.64800-1-snitzer@kernel.org>
 <20250708160619.64800-5-snitzer@kernel.org>
 <5819d6c5bb194613a14d2dcf05605e701683ba49.camel@kernel.org>
 <aG_SpLuUv4EH7fAb@kbusch-mbp>
 <aG_mbURjwxk3vZlX@kernel.org>
 <aG_qYnxiK1Rq5nZR@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG_qYnxiK1Rq5nZR@kbusch-mbp>

On Thu, Jul 10, 2025 at 10:29:22AM -0600, Keith Busch wrote:
> On Thu, Jul 10, 2025 at 12:12:29PM -0400, Mike Snitzer wrote:
> > On Thu, Jul 10, 2025 at 08:48:04AM -0600, Keith Busch wrote:
> > > On Thu, Jul 10, 2025 at 09:52:53AM -0400, Jeff Layton wrote:
> > > > On Tue, 2025-07-08 at 12:06 -0400, Mike Snitzer wrote:
> > > > > iov_iter_aligned_bvec() is strictly checking alignment of each element
> > > > > of the bvec to arrive at whether the bvec is aligned relative to
> > > > > dma_alignment and on-disk alignment.  Checking each element
> > > > > individually results in disallowing a bvec that in aggregate is
> > > > > perfectly aligned relative to the provided @len_mask.
> > > > > 
> > > > > Relax the on-disk alignment checking such that it is done on the full
> > > > > extent described by the bvec but still do piecewise checking of the
> > > > > dma_alignment for each bvec's bv_offset.
> > > > > 
> > > > > This allows for NFS's WRITE payload to be issued using O_DIRECT as
> > > > > long as the bvec created with xdr_buf_to_bvec() is composed of pages
> > > > > that respect the underlying device's dma_alignment (@addr_mask) and
> > > > > the overall contiguous on-disk extent is aligned relative to the
> > > > > logical_block_size (@len_mask).
> > > > > 
> > > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > > ---
> > > > >  lib/iov_iter.c | 5 +++--
> > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> > > > > index bdb37d572e97..b2ae482b8a1d 100644
> > > > > --- a/lib/iov_iter.c
> > > > > +++ b/lib/iov_iter.c
> > > > > @@ -819,13 +819,14 @@ static bool iov_iter_aligned_bvec(const struct iov_iter *i, unsigned addr_mask,
> > > > >  	unsigned skip = i->iov_offset;
> > > > >  	size_t size = i->count;
> > > > >  
> > > > > +	if (size & len_mask)
> > > > > +		return false;
> > > > > +
> > > > >  	do {
> > > > >  		size_t len = bvec->bv_len;
> > > > >  
> > > > >  		if (len > size)
> > > > >  			len = size;
> > > > > -		if (len & len_mask)
> > > > > -			return false;
> > > > >  		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
> > > > >  			return false;
> > > > >  
> > > > 
> > > > cc'ing Keith too since he wrote this helper originally.
> > > 
> > > Thanks.
> > > 
> > > There's a comment in __bio_iov_iter_get_pages that says it expects each
> > > vector to be a multiple of the block size. That makes it easier to
> > > slit when needed, and this patch would allow vectors that break the
> > > current assumption when calculating the "trim" value.
> > 
> > Thanks for the pointer, that high-level bio code is being too
> > restrictive.
> > 
> > But not seeing any issues with the trim calculation itself, 'trim' is
> > the number of bytes that are past the last logical_block_size aligned
> > boundary.  And then iov_iter_revert() will rollback the iov such that
> > it doesn't include those.  Then size is reduced by trim bytes.
> 
> The trim calculation assumes the current bi_size is already a block size
> multiple, but it may not be with your propsal. So the trim bytes needs
> to take into account the existing bi_size to know how much to trim off
> to arrive at a proper total bi_size instead of assuming we can append a
> block sized multiple carved out the current iov.

The trim "calculation" doesn't assume anything, it just lops off
whatever is past the end of the last logical_block_size aligned
boundary of the requested pages (which is meant to be bi_size).  The
fact that the trim ever gets anything implies bi_size is *not* always
logical_block_size aligned. No?

But sure, with my change it opens the door for bvecs with vectors that
aren't all logical_block_size aligned.  

I'll revisit this code, but if you see a way forward to fix
__bio_iov_iter_get_pages to cope with my desired iov_iter_aligned_bvec
change please don't be shy with a patch ;)

> > All said, in practice I haven't had any issues with this patch.  But
> > it could just be I don't have the stars aligned to test the case that
> > might have problems.  If you know of such a case I'd welcome
> > suggestions.
> 
> It might be a little harder with iter_bvec, but you also mentioned doing
> the same for iter_iovec too, which I think should be pretty easy to
> cause a problem for nvme: just submit an O_DIRECT read or write with
> individual iovec sizes that are not block size granularities.

I made the iter_iovec change yesterday (before I realized I don't
actually need it for my NFSD case) and all was fine issuing O_DIRECT
IO (via NFSD, so needing the relaxed checking) through to 16
XFS-on-NVMe devices.  SO I think the devil will be in the details if
NVMe actually cares.

Mike

