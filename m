Return-Path: <linux-fsdevel+bounces-51339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490D9AD5AE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 17:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A289E172544
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 15:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9921DE2A1;
	Wed, 11 Jun 2025 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOzrIOXg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463AD1D7E41;
	Wed, 11 Jun 2025 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656671; cv=none; b=BfF13U9KoSGtyuXTRZQsA7uRLIZlZ8oIEwy6tVnK9JXJTqn8Id8VwWk7YT3ibtoncbpqt3bT7Bzv86zMjWUn2qucttat1pxAbaM3Dr3Wt60fCMnyyqrRIWA0o8dUtDvghhbkbcZjJeLdJIAF9lNyPbcYGmvFtW1GVekNRwzry20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656671; c=relaxed/simple;
	bh=qs+xkqUNwObopyBpJdS0te06oHUxkTQAo2apS8nPcxc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lAVLGf5UbyHhvHBE+MTidGu4skmsdkrjn8ounZ+cIADKpI6NUKtWXgYH5bh4MSTBINJa1aTS32rayGuY/Rwuebc66ZCelK4vJuevzKjwJC6iilDkw/GRvVResDcK67Ew0OwILDg57NUnDn3krs+hL4eVfFyuba9sQBc2n/rkf6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOzrIOXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A52C4CEE3;
	Wed, 11 Jun 2025 15:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749656670;
	bh=qs+xkqUNwObopyBpJdS0te06oHUxkTQAo2apS8nPcxc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LOzrIOXg+kAUzqqbmzyPS3Bl6hLu/HKU/G9uCEp7eJvn9Y2CqaWrGhgDGqKa5md8C
	 czbMzrinXw8F1gxriYK9i1KVlGn/0N3pm8awBVrXJD7w7iFbnBHm0teMx1OjG80gON
	 /O3ZSWSm61vrhabtVkWpHlukvyPtgoQXYFEAeFHKGK20hnT46xdtLXBf8OGdIivb5Y
	 +48v6JSnAZjshyYDfiDz0IwS2nikPMoCHyTzGEd7LQruTyOsaE47tRGgC+vg6VW4aG
	 +Zy5vhDukWUE6kXok00AfE/e5/Xpf0YJnEHNgnSxZxxfsG7YNdNNsHKljCvgtNzVni
	 QawbttnTcWptw==
Message-ID: <1720744abfdc458bba1980e62d8fd61b06870a6e.camel@kernel.org>
Subject: Re: [PATCH 5/6] NFSD: leverage DIO alignment to selectively issue
 O_DIRECT reads and writes
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jens Axboe
	 <axboe@kernel.dk>
Date: Wed, 11 Jun 2025 11:44:29 -0400
In-Reply-To: <27bc1d2d-7cc8-449c-9e4c-3a515631fa87@oracle.com>
References: <20250610205737.63343-1-snitzer@kernel.org>
	 <20250610205737.63343-6-snitzer@kernel.org>
	 <36698c20-599a-4968-a06c-310204474fe8@oracle.com>
	 <21a1a0e28349824cc0a2937f719ec38d27089e3b.camel@kernel.org>
	 <27bc1d2d-7cc8-449c-9e4c-3a515631fa87@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-11 at 11:11 -0400, Chuck Lever wrote:
> On 6/11/25 11:07 AM, Jeff Layton wrote:
> > On Wed, 2025-06-11 at 10:42 -0400, Chuck Lever wrote:
> > > On 6/10/25 4:57 PM, Mike Snitzer wrote:
> > > > IO must be aligned, otherwise it falls back to using buffered IO.
> > > >=20
> > > > RWF_DONTCACHE is _not_ currently used for misaligned IO (even when
> > > > nfsd/enable-dontcache=3D1) because it works against us (due to RMW
> > > > needing to read without benefit of cache), whereas buffered IO enab=
les
> > > > misaligned IO to be more performant.
> > > >=20
> > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > ---
> > > >  fs/nfsd/vfs.c | 40 ++++++++++++++++++++++++++++++++++++----
> > > >  1 file changed, 36 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > index e7cc8c6dfbad..a942609e3ab9 100644
> > > > --- a/fs/nfsd/vfs.c
> > > > +++ b/fs/nfsd/vfs.c
> > > > @@ -1064,6 +1064,22 @@ __be32 nfsd_splice_read(struct svc_rqst *rqs=
tp, struct svc_fh *fhp,
> > > >  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, hos=
t_err);
> > > >  }
> > > > =20
> > > > +static bool is_dio_aligned(const struct iov_iter *iter, loff_t off=
set,
> > > > +			   const u32 blocksize)
> > > > +{
> > > > +	u32 blocksize_mask;
> > > > +
> > > > +	if (!blocksize)
> > > > +		return false;
> > > > +
> > > > +	blocksize_mask =3D blocksize - 1;
> > > > +	if ((offset & blocksize_mask) ||
> > > > +	    (iov_iter_alignment(iter) & blocksize_mask))
> > > > +		return false;
> > > > +
> > > > +	return true;
> > > > +}
> > > > +
> > > >  /**
> > > >   * nfsd_iter_read - Perform a VFS read using an iterator
> > > >   * @rqstp: RPC transaction context
> > > > @@ -1107,8 +1123,16 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp=
, struct svc_fh *fhp,
> > > >  	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
> > > >  	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
> > > > =20
> > > > -	if (nfsd_enable_dontcache)
> > > > -		flags |=3D RWF_DONTCACHE;
> > > > +	if (nfsd_enable_dontcache) {
> > > > +		if (is_dio_aligned(&iter, offset, nf->nf_dio_read_offset_align))
> > > > +			flags |=3D RWF_DIRECT;
> > > > +		/* FIXME: not using RWF_DONTCACHE for misaligned IO because it w=
orks
> > > > +		 * against us (due to RMW needing to read without benefit of cac=
he),
> > > > +		 * whereas buffered IO enables misaligned IO to be more performa=
nt.
> > > > +		 */
> > > > +		//else
> > > > +		//	flags |=3D RWF_DONTCACHE;
> > > > +	}
> > > > =20
> > > >  	host_err =3D vfs_iter_read(file, &iter, &ppos, flags);
> > > >  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, hos=
t_err);
> > > > @@ -1217,8 +1241,16 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
> > > >  	nvecs =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, pay=
load);
> > > >  	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> > > > =20
> > > > -	if (nfsd_enable_dontcache)
> > > > -		flags |=3D RWF_DONTCACHE;
> > > > +	if (nfsd_enable_dontcache) {
> > > > +		if (is_dio_aligned(&iter, offset, nf->nf_dio_offset_align))
> > > > +			flags |=3D RWF_DIRECT;
> > > > +		/* FIXME: not using RWF_DONTCACHE for misaligned IO because it w=
orks
> > > > +		 * against us (due to RMW needing to read without benefit of cac=
he),
> > > > +		 * whereas buffered IO enables misaligned IO to be more performa=
nt.
> > > > +		 */
> > > > +		//else
> > > > +		//	flags |=3D RWF_DONTCACHE;
> > > > +	}
> > >=20
> > > IMO adding RWF_DONTCACHE first then replacing it later in the series
> > > with a form of O_DIRECT is confusing. Also, why add RWF_DONTCACHE her=
e
> > > and then take it away "because it doesn't work"?
> > >=20
> > > But OK, your series is really a proof-of-concept. Something to work o=
ut
> > > before it is merge-ready, I guess.
> > >=20
> > > It is much more likely for NFS READ requests to be properly aligned.
> > > Clients are generally good about that. NFS WRITE request alignment
> > > is going to be arbitrary. Fwiw.
> > >=20
> > > However, one thing we discussed at bake-a-thon was what to do about
> > > unstable WRITEs. For unstable WRITEs, the server has to cache the
> > > write data at least until the client sends a COMMIT. Otherwise the
> > > server will have to convert all UNSTABLE writes to FILE_SYNC writes,
> > > and that can have performance implications.
> > >=20
> >=20
> > If we're doing synchronous, direct I/O writes then why not just respond
> > with FILE_SYNC? The write should be on the platter by the time it
> > returns.
>=20
> Because "platter". On some devices, writes are slow.
>=20
> For some workloads, unstable is faster. I have an experimental series
> that makes NFSD convert all NFS WRITEs to FILE_SYNC. It was not an
> across the board win, even with an NVMe-backed file system.
>=20

Presumably, those devices wouldn't be exported in this mode. That's
probably a good argument for making this settable on a per-export
basis.

>=20
> > > One thing you might consider is to continue using the page cache for
> > > unstable WRITEs, and then use fadvise DONTNEED after a successful
> > > COMMIT operation to reduce page cache footprint. Unstable writes to
> > > the same range of the file might be a problem, however.
> >=20
> > Since the client sends almost everything UNSTABLE, that would probably
> > erase most of the performance win. The only reason I can see to use
> > buffered I/O in this mode would be because we had to deal with an
> > unaligned write and need to do a RMW cycle on a block.
> >=20
> > The big question is whether mixing buffered and direct I/O writes like
> > this is safe across all exportable filesystems. I'm not yet convinced
> > of that.
>=20
> Agreed, that deserves careful scrutiny.
>=20

Like Mike is asking though, I need a better understanding of the
potential races here:

XFS, for instance, takes the i_rwsem shared around dio writes and
exclusive around buffered, so they should exclude each other. If we did
all the buffered writes as RWF_SYNC, would that prevent corruption?

In any case, for now at least, unless you're using RDMA, it's going to
end up falling back to buffered writes everywhere. The data is almost
never going to be properly aligned coming in off the wire. That might
be fixable though.
--=20
Jeff Layton <jlayton@kernel.org>

