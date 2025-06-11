Return-Path: <linux-fsdevel+bounces-51361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E879AAD6060
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 22:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857E4177D41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 20:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F102874EB;
	Wed, 11 Jun 2025 20:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCIOTfI3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B832367A6;
	Wed, 11 Jun 2025 20:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675064; cv=none; b=JwqiqNUF3eZMraSBvvZMjnJt52VjgtcRZpS9arWqtra/ud/PJuZFDkpnvra8wosVIxmMIlLsFKok46Fw7UZR7SPtm+ZAhN3efVeXfvaFX5rmSUmdEkmhUms6yDwPR3WRgsfwQePepxSQ3VRtKn8HHKKe9XKnUeuNZXuvjM6bYgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675064; c=relaxed/simple;
	bh=2nXstaYAEep1Zd4TypusU2EeFdZYT2IiwfF5t+k6kAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lds5Aj5PRgdkSbNmvXXVKPqv4pkOT2AaMC/CDaqOszbYRT77XF3JsmAx+mnRcRFFYsiNUeNLJiTtkFcyfhaCB7/s6gTxuN26i462FZIZD+3LIva0ZCb1xwQkkcXPgAxSvWY21ZK/4rgmEAboTHIMVjsdjMKV3dGjJzS23KFFapk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCIOTfI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34436C4CEE3;
	Wed, 11 Jun 2025 20:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749675064;
	bh=2nXstaYAEep1Zd4TypusU2EeFdZYT2IiwfF5t+k6kAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tCIOTfI3TB/MD9FTOedfEJhoaRxm3n7o6tu0lqDuLmr1BMTV6ZW0Zr3QwAV386wwf
	 c538cPTUS2w6U4yPvFDpX9E+QH98bPRpuiuwzYsnZr8V87kfGhHAoWcrx5r/X3ay3h
	 SKyEiJ5QrKV0mIvBkSkhvp0taHvJmnvmx0BMXBfx2Zqtdm6p3+dAEuojmFMQuW4Oib
	 toXIba72+iT8POpE2cFvuEXUuS3ST49XB6uMZWGY8eAyGBB3ZeR70KjIDjwYj+/r++
	 FrL0TdqwwZfQgWT6aFAklFV/ZM3rxwz40SytdSqtEMFJoEs60cWVlYQNQfHsFp4tHJ
	 eoJlVpmXTXxsg==
Date: Wed, 11 Jun 2025 16:51:03 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	bcodding@redhat.com
Subject: Re: [PATCH 5/6] NFSD: leverage DIO alignment to selectively issue
 O_DIRECT reads and writes
Message-ID: <aEnsN0uYB61_MyrW@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-6-snitzer@kernel.org>
 <36698c20-599a-4968-a06c-310204474fe8@oracle.com>
 <21a1a0e28349824cc0a2937f719ec38d27089e3b.camel@kernel.org>
 <27bc1d2d-7cc8-449c-9e4c-3a515631fa87@oracle.com>
 <1720744abfdc458bba1980e62d8fd61b06870a6e.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1720744abfdc458bba1980e62d8fd61b06870a6e.camel@kernel.org>

On Wed, Jun 11, 2025 at 11:44:29AM -0400, Jeff Layton wrote:
> On Wed, 2025-06-11 at 11:11 -0400, Chuck Lever wrote:
> > On 6/11/25 11:07 AM, Jeff Layton wrote:
> > > On Wed, 2025-06-11 at 10:42 -0400, Chuck Lever wrote:
> > > > On 6/10/25 4:57 PM, Mike Snitzer wrote:
> > > > > IO must be aligned, otherwise it falls back to using buffered IO.
> > > > > 
> > > > > RWF_DONTCACHE is _not_ currently used for misaligned IO (even when
> > > > > nfsd/enable-dontcache=1) because it works against us (due to RMW
> > > > > needing to read without benefit of cache), whereas buffered IO enables
> > > > > misaligned IO to be more performant.
> > > > > 
> > > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > > ---
> > > > >  fs/nfsd/vfs.c | 40 ++++++++++++++++++++++++++++++++++++----
> > > > >  1 file changed, 36 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > > index e7cc8c6dfbad..a942609e3ab9 100644
> > > > > --- a/fs/nfsd/vfs.c
> > > > > +++ b/fs/nfsd/vfs.c
> > > > > @@ -1064,6 +1064,22 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > > > >  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
> > > > >  }
> > > > >  
> > > > > +static bool is_dio_aligned(const struct iov_iter *iter, loff_t offset,
> > > > > +			   const u32 blocksize)
> > > > > +{
> > > > > +	u32 blocksize_mask;
> > > > > +
> > > > > +	if (!blocksize)
> > > > > +		return false;
> > > > > +
> > > > > +	blocksize_mask = blocksize - 1;
> > > > > +	if ((offset & blocksize_mask) ||
> > > > > +	    (iov_iter_alignment(iter) & blocksize_mask))
> > > > > +		return false;
> > > > > +
> > > > > +	return true;
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * nfsd_iter_read - Perform a VFS read using an iterator
> > > > >   * @rqstp: RPC transaction context
> > > > > @@ -1107,8 +1123,16 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > > > >  	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
> > > > >  	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
> > > > >  
> > > > > -	if (nfsd_enable_dontcache)
> > > > > -		flags |= RWF_DONTCACHE;
> > > > > +	if (nfsd_enable_dontcache) {
> > > > > +		if (is_dio_aligned(&iter, offset, nf->nf_dio_read_offset_align))
> > > > > +			flags |= RWF_DIRECT;
> > > > > +		/* FIXME: not using RWF_DONTCACHE for misaligned IO because it works
> > > > > +		 * against us (due to RMW needing to read without benefit of cache),
> > > > > +		 * whereas buffered IO enables misaligned IO to be more performant.
> > > > > +		 */
> > > > > +		//else
> > > > > +		//	flags |= RWF_DONTCACHE;
> > > > > +	}
> > > > >  
> > > > >  	host_err = vfs_iter_read(file, &iter, &ppos, flags);
> > > > >  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
> > > > > @@ -1217,8 +1241,16 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
> > > > >  	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
> > > > >  	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> > > > >  
> > > > > -	if (nfsd_enable_dontcache)
> > > > > -		flags |= RWF_DONTCACHE;
> > > > > +	if (nfsd_enable_dontcache) {
> > > > > +		if (is_dio_aligned(&iter, offset, nf->nf_dio_offset_align))
> > > > > +			flags |= RWF_DIRECT;
> > > > > +		/* FIXME: not using RWF_DONTCACHE for misaligned IO because it works
> > > > > +		 * against us (due to RMW needing to read without benefit of cache),
> > > > > +		 * whereas buffered IO enables misaligned IO to be more performant.
> > > > > +		 */
> > > > > +		//else
> > > > > +		//	flags |= RWF_DONTCACHE;
> > > > > +	}
> > > > 
> > > > IMO adding RWF_DONTCACHE first then replacing it later in the series
> > > > with a form of O_DIRECT is confusing. Also, why add RWF_DONTCACHE here
> > > > and then take it away "because it doesn't work"?

I spoke to this in a previous reply.  I can fold patches to elininate
this distraction in v2.

> > > > But OK, your series is really a proof-of-concept. Something to work out
> > > > before it is merge-ready, I guess.
> > > > 
> > > > It is much more likely for NFS READ requests to be properly aligned.
> > > > Clients are generally good about that. NFS WRITE request alignment
> > > > is going to be arbitrary. Fwiw.

Correct, thankfully TCP reads don't misalign their payload like TCP
writes do.  As you know, the value of patch 6 is that application IO
that generates misaligned IO (as a side-effect of misaligned read
blocksize, e.g. IOR hard's 47008 blocksize) can issue reads using
O_DIRECT.

> > > > However, one thing we discussed at bake-a-thon was what to do about
> > > > unstable WRITEs. For unstable WRITEs, the server has to cache the
> > > > write data at least until the client sends a COMMIT. Otherwise the
> > > > server will have to convert all UNSTABLE writes to FILE_SYNC writes,
> > > > and that can have performance implications.
> > > > 
> > > 
> > > If we're doing synchronous, direct I/O writes then why not just respond
> > > with FILE_SYNC? The write should be on the platter by the time it
> > > returns.

For v2 I'll look to formalize responding with FILE_SYNC when
'enable-dontcache' is set.

> > Because "platter". On some devices, writes are slow.
> > 
> > For some workloads, unstable is faster. I have an experimental series
> > that makes NFSD convert all NFS WRITEs to FILE_SYNC. It was not an
> > across the board win, even with an NVMe-backed file system.
> > 
> 
> Presumably, those devices wouldn't be exported in this mode. That's
> probably a good argument for making this settable on a per-export
> basis.

Correct.  This shouldn't be used by default.  But if/when it makes
sense, it *really* sings.

> > > > One thing you might consider is to continue using the page cache for
> > > > unstable WRITEs, and then use fadvise DONTNEED after a successful
> > > > COMMIT operation to reduce page cache footprint. Unstable writes to
> > > > the same range of the file might be a problem, however.
> > > 
> > > Since the client sends almost everything UNSTABLE, that would probably
> > > erase most of the performance win. The only reason I can see to use
> > > buffered I/O in this mode would be because we had to deal with an
> > > unaligned write and need to do a RMW cycle on a block.
> > > 
> > > The big question is whether mixing buffered and direct I/O writes like
> > > this is safe across all exportable filesystems. I'm not yet convinced
> > > of that.
> > 
> > Agreed, that deserves careful scrutiny.
> > 
> 
> Like Mike is asking though, I need a better understanding of the
> potential races here:
> 
> XFS, for instance, takes the i_rwsem shared around dio writes and
> exclusive around buffered, so they should exclude each other.

> If we did all the buffered writes as RWF_SYNC, would that prevent
> corruption?

I welcome any help pinning down what must be done to ensure this
is safe ("this" being: arbitrary switching between buffered and direct
IO and associated page cache invalidation).  But to be 100% clear:
NFSD exporting XFS with enable-dontcache=1 has worked very well.

Do we need to go to the extreme of each filesystem exporting support
with a new flag like FOP_INVALIDATES_BUFFERED_VS_DIRECT?  And if set,
any evidence to the contrary is a bug?

And does the VFS have a role in ensuring it's safe or can we assume
vfs/mm/etc are intended to be safe and any core common code that
proves otherwise is a bug?

> In any case, for now at least, unless you're using RDMA, it's going to
> end up falling back to buffered writes everywhere. The data is almost
> never going to be properly aligned coming in off the wire. That might
> be fixable though.

Ben Coddington mentioned to me that soft-iwarp would allow use of RDMA
over TCP to workaround SUNRPC TCP's XDR handling always storing the
write payload in misaligned IO.  But that's purely a stop-gap
workaround, which needs testing (to see if soft-iwap negates the win
of using O_DIRECT, etc).

But a long-term better fix is absolutely needed, to be continued (in
the subthread I need to get going)...

Mike

