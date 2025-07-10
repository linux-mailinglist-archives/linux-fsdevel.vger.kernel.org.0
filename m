Return-Path: <linux-fsdevel+bounces-54534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6431FB00852
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 18:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3EA5A7C5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 16:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E519D2EF9D9;
	Thu, 10 Jul 2025 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAaTgvue"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421E82D879A;
	Thu, 10 Jul 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163952; cv=none; b=qHPfEGQAGM9BrLQjI/wp+L/dorplPGvsyy3MSYLspSIs2xS3PLqrOPg++uTfUna2gzysPv8UwKbohjsp8d02JhUv6V16tt3Nj92bKcVH0/2kHUko90RteaiVP8RqWFJYKCyupDiqtaRYvurtAy9XAIf/9zV04BBud3kal9AvRgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163952; c=relaxed/simple;
	bh=TQxkvxDCdmEvpgrrkG63eeGrJ977f+5aAoJ0l/tKO5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSQepEvSv9wZVL/DvwKlWqkATglpqWcDCl5ySNFkF9/jhon/ME+UCZDYFmhOqrgqo623Dfi3EMsj5xEHj+InAbngXzQ/taASNsFsSNYJtV06bnckoGhESR3Vowgs/x560IqpGu4z58BsVJaPwffHDjsOTkE7GkSXW3LFjqE8GpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAaTgvue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC826C4CEE3;
	Thu, 10 Jul 2025 16:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752163950;
	bh=TQxkvxDCdmEvpgrrkG63eeGrJ977f+5aAoJ0l/tKO5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAaTgvueMCvsP/he0Oa/uQbJeWvQW/RSm0EGwq14GyopuaORFtPEy+YcwmTpUjAVa
	 N4HAyO/+FbUzsmE7oojeREJ3mJ36H7P1r9QAhBOp57d+ZIMS+V2VKs/A/ftwdNDx9g
	 rc2/QQcPds0sEZzsisOzL5cdRp/1qB+PBKgNJUXwQz590Bt037fkv3GHiWtUdknSjj
	 XhBNMSwSBm25kLuYbhM3U0Z7cBbwJaqfyTVt02LlDElyKFLOqiHIr9R2KizO+u1/mD
	 34I09zeBX29vOgk6wcp6XxPhiz5sYI+roBIBu10Az9WGpEFaNBzl4ww2lHfF5/gT4h
	 BforhOeTkwVTA==
Date: Thu, 10 Jul 2025 12:12:29 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	hch@infradead.org, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/8] lib/iov_iter: remove piecewise bvec length
 checking in iov_iter_aligned_bvec
Message-ID: <aG_mbURjwxk3vZlX@kernel.org>
References: <20250708160619.64800-1-snitzer@kernel.org>
 <20250708160619.64800-5-snitzer@kernel.org>
 <5819d6c5bb194613a14d2dcf05605e701683ba49.camel@kernel.org>
 <aG_SpLuUv4EH7fAb@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG_SpLuUv4EH7fAb@kbusch-mbp>

On Thu, Jul 10, 2025 at 08:48:04AM -0600, Keith Busch wrote:
> On Thu, Jul 10, 2025 at 09:52:53AM -0400, Jeff Layton wrote:
> > On Tue, 2025-07-08 at 12:06 -0400, Mike Snitzer wrote:
> > > iov_iter_aligned_bvec() is strictly checking alignment of each element
> > > of the bvec to arrive at whether the bvec is aligned relative to
> > > dma_alignment and on-disk alignment.  Checking each element
> > > individually results in disallowing a bvec that in aggregate is
> > > perfectly aligned relative to the provided @len_mask.
> > > 
> > > Relax the on-disk alignment checking such that it is done on the full
> > > extent described by the bvec but still do piecewise checking of the
> > > dma_alignment for each bvec's bv_offset.
> > > 
> > > This allows for NFS's WRITE payload to be issued using O_DIRECT as
> > > long as the bvec created with xdr_buf_to_bvec() is composed of pages
> > > that respect the underlying device's dma_alignment (@addr_mask) and
> > > the overall contiguous on-disk extent is aligned relative to the
> > > logical_block_size (@len_mask).
> > > 
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  lib/iov_iter.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> > > index bdb37d572e97..b2ae482b8a1d 100644
> > > --- a/lib/iov_iter.c
> > > +++ b/lib/iov_iter.c
> > > @@ -819,13 +819,14 @@ static bool iov_iter_aligned_bvec(const struct iov_iter *i, unsigned addr_mask,
> > >  	unsigned skip = i->iov_offset;
> > >  	size_t size = i->count;
> > >  
> > > +	if (size & len_mask)
> > > +		return false;
> > > +
> > >  	do {
> > >  		size_t len = bvec->bv_len;
> > >  
> > >  		if (len > size)
> > >  			len = size;
> > > -		if (len & len_mask)
> > > -			return false;
> > >  		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
> > >  			return false;
> > >  
> > 
> > cc'ing Keith too since he wrote this helper originally.
> 
> Thanks.
> 
> There's a comment in __bio_iov_iter_get_pages that says it expects each
> vector to be a multiple of the block size. That makes it easier to
> slit when needed, and this patch would allow vectors that break the
> current assumption when calculating the "trim" value.

Thanks for the pointer, that high-level bio code is being too
restrictive.

But not seeing any issues with the trim calculation itself, 'trim' is
the number of bytes that are past the last logical_block_size aligned
boundary.  And then iov_iter_revert() will rollback the iov such that
it doesn't include those.  Then size is reduced by trim bytes.

Just restating my challenge:
Assuming that each vector is itself a multiple of logical_block_size
disallows valid usecases (like the one I have with NFSD needing to use
O_DIRECT for its WRITE payload, which can have the head and/or tail
vectors at _not_ logical_block_size aligned boundaries).

> But for nvme, you couldn't split such a bvec into a usable command
> anyway. I think you'd have to introduce a different queue limit to check
> against when validating iter alignment if you don't want to use the
> logical block size. 

There isn't a new queue limit in play though, but I get your meaning
that we did in fact assume the logical_block_size applicable for each
vector.

With my patch, we still validate logical_block_size (of overall
bvec length, not of each vector) and implicitly validate that each
vector has dma_alignment on-disk (while verifying that pages are
aligned to dma_alignment).

All said, in practice I haven't had any issues with this patch.  But
it could just be I don't have the stars aligned to test the case that
might have problems.  If you know of such a case I'd welcome
suggestions.

Thanks,
Mike

