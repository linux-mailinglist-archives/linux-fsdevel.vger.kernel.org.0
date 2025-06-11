Return-Path: <linux-fsdevel+bounces-51357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C428DAD5EE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 21:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6097F3A9E57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 19:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3973629ACC8;
	Wed, 11 Jun 2025 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWyZAmQu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C47198A1A;
	Wed, 11 Jun 2025 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749669512; cv=none; b=Gk/SGvB4HlWd2QHp6tNXmQrRx3bwe4rotrh7xElQGsvYoEmmPVKX83nz374TufcZXrDNPgnTf4NpmMZv6Kdgn8lcrY/Sllb3AfX6t3u2gWuJY+UgMQlz7hcj9Xozhhep3W084UY14ApuJDnYQOiuf++coGLvMb+yPZE+/faT+Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749669512; c=relaxed/simple;
	bh=QvGi3kRWdmZkP0pP05vJktwCW3pLl7AETbrgT3QOeDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdbbH5Z1s+yV2/SZRj8jlFXGbtLITuagRbhR+ySElhCIuWSqNq6v3VUTo3JHvHfuykzRHlrLdqBPHwNGLWLMXVMSEK501NQNVnj8PHMfmV5N8IcnDdhwXgeLn1sJOWl+jcyQX1wJKkjLckBoc7Qi7b3KdPoerct32chTUKaQIHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWyZAmQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3268C4CEE3;
	Wed, 11 Jun 2025 19:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749669512;
	bh=QvGi3kRWdmZkP0pP05vJktwCW3pLl7AETbrgT3QOeDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OWyZAmQuCbQmU9O+K476HQV939k3rHjuiH2tAorqXeQw/rMGoV0xM9eC3QnQ252K3
	 KYfn2s4UxTVqbuGGjroLayiHh4fl2q7Qd9mPrQOGYGVdj1zhI7mMozJGfdDzQ5lO/h
	 /92gfGnwgxxsRyAESupGumzRu6sbafc/Zw7GvRYE/zXFmB0gYSo3dKkcpbczX57JzR
	 IBJdVkCNJl2jeUDVHGbFRB+B3oATG9stkqoHccdgXfIRUt/I0BxVuuzyECZSUWOtbI
	 1PJV4Nmt+28Ib0DmZS4/a11BZfZtk08wWJfQCI8eJpXQD1e9FOyWFzg3wsF/GrVyOt
	 CBxdszQeOW0gg==
Date: Wed, 11 Jun 2025 15:18:30 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE
 for all IO
Message-ID: <aEnWhlXjzOmRfCJf@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>

On Wed, Jun 11, 2025 at 10:31:20AM -0400, Chuck Lever wrote:
> On 6/10/25 4:57 PM, Mike Snitzer wrote:
> > Add 'enable-dontcache' to NFSD's debugfs interface so that: Any data
> > read or written by NFSD will either not be cached (thanks to O_DIRECT)
> > or will be removed from the page cache upon completion (DONTCACHE).
> 
> I thought we were going to do two switches: One for reads and one for
> writes? I could be misremembering.

We did discuss the possibility of doing that.  Still can-do if that's
what you'd prefer.
 
> After all, you are describing two different facilities here: a form of
> direct I/O for READs, and RWF_DONTCACHE for WRITEs (I think?).

My thinking was NFSD doesn't need to provide faithful pure
RWF_DONTCACHE if it really doesn't make sense.  But the "dontcache"
name can be (ab)used by NFSD to define it how it sees fit (O_DIRECT
doesn't cache so it seems fair).  What I arrived at with this patchset
is how I described in my cover letter:

When 'enable-dontcache' is used:
- all READs will use O_DIRECT (both DIO-aligned and misaligned)
- all DIO-aligned WRITEs will use O_DIRECT (useful for SUNRPC RDMA)
- misaligned WRITEs currently continue to use normal buffered IO

But we reserve the right to iterate on the implementation details as
we see fit.  Still using the umbrella of 'dontcache'.

> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 7d94fae1dee8..bba3e6f4f56b 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -49,6 +49,7 @@
> >  #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
> >  
> >  bool nfsd_disable_splice_read __read_mostly;
> > +bool nfsd_enable_dontcache __read_mostly;
> >  
> >  /**
> >   * nfserrno - Map Linux errnos to NFS errnos
> > @@ -1086,6 +1087,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  	unsigned long v, total;
> >  	struct iov_iter iter;
> >  	loff_t ppos = offset;
> > +	rwf_t flags = 0;
> >  	ssize_t host_err;
> >  	size_t len;
> >  
> > @@ -1103,7 +1105,11 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> >  
> >  	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
> >  	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
> > -	host_err = vfs_iter_read(file, &iter, &ppos, 0);
> > +
> > +	if (nfsd_enable_dontcache)
> > +		flags |= RWF_DONTCACHE;
> 
> Two things:
> 
> - Maybe NFSD should record whether the file system is DONTCACHE-enabled
> in @fhp or in the export it is associated with, and then check that
> setting here before asserting RWF_DONTCACHE

Sure, that'd be safer than allowing RWF_DONTCACHE to be tried only to
get EOPNOTSUPP because the underlying filesystem doesn't enable
support.

Could follow what I did with nfsd_file only storing the dio_*
alignment data retrieved from statx IFF 'enable-dontcache' was enabled
at the time the nfsd_file was opened.

By adding check for FOP_DONTCACHE being set in underlying filesystem.
But as-is, we're not actually using RWF_DONTCACHE in the final form of
what I've provided in this patchset.  So can easily circle back to
adding this if/when we do decide to use RWF_DONTCACHE.

> - I thought we were going with O_DIRECT for READs.

Yes, this is just an intermediate patch that goes away in later
patches.  I was more focused on minimal patch to get the
'enable-dontcache' debugfs interface in place and tweaking it to its
ultimate form in later patch.

I put in place a more general framework that can evolve... it being
more free-form (e.g. "don't worry your pretty head about the
implementation details, we'll worry for you").

Causes some reviewer angst I suppose, so I can just fold patches to do
away with unused intermediate state.

Mike

