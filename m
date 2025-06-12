Return-Path: <linux-fsdevel+bounces-51510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C479AD7810
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 18:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0DFC7A5C16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 16:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08DB29AAF4;
	Thu, 12 Jun 2025 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8fCJfY+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A4129A9C9;
	Thu, 12 Jun 2025 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745364; cv=none; b=Ng3ZU5EtovMPZJcTRwU4NHa9qUHvmiiT+qEvD+WFXxcAds+6iyqjWb7YJbUBznGcq/Au5rosLvxaS9CXu2q1HoJEzTf0dZoRg61NFl/rhKuYHofYd8ZY7vttlYvAGIeK/DiOKqmJ2owqVGSUTAjSzNzlhJMTU1JLARX/H56wtlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745364; c=relaxed/simple;
	bh=VYEedFIgljMdb/UmVgyxKAD3GNs+PjafpFoRERX1bec=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=krLkwG0YTz0dfR8Oib/ZLRRkqw+4icd+taG47gIyqJ/dwsHdGkUUWBOiQC5GdGg/4B/mbQA6GH6Oo8OM6rQQ13Wq+yhM/Y998UcRt2Jqz45Wb2Ks6fqyeOACpObUCLNrGwkUmb/5Kx8allmDG0ed/8sVuB/LqFXUxOitgmTxZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8fCJfY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373B1C4CEEE;
	Thu, 12 Jun 2025 16:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749745363;
	bh=VYEedFIgljMdb/UmVgyxKAD3GNs+PjafpFoRERX1bec=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=h8fCJfY+FO9ZmcDlSTflbV5IGqPNCCJvcyex5WcdZqeeboHvuvOun0MPuUn6uMx2M
	 ir/+Znl5bPaGSWd4WlStvGCmxQU+R5KtyeQgCuFaFQ4Xv0TpGhOmFzsUL0qw++/4R+
	 NUPpfCNLM+k+Xp9yy+GDgbL1QDd3sp3cZb+2DczTy8Ij0hJL4i0HD9UKAZLHbLoBdt
	 5C8jrazYpNIt7dLb9S5WyDFCCoVgBABBtpA4UOLQnz7adHe4HCzzgNPBCDe278oPDa
	 8Uv6u2G12GsEPV0MYmt2cuOR8/38gRDmtNeEY0qz4fM25R+FGmROCZF82x6qa4cESK
	 z68X0N8IEgCnQ==
Message-ID: <f201c16677525288597becfd904d873931092cea.camel@kernel.org>
Subject: Re: need SUNRPC TCP to receive into aligned pages [was: Re: [PATCH
 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE for all IO]
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jens Axboe
	 <axboe@kernel.dk>
Date: Thu, 12 Jun 2025 12:22:42 -0400
In-Reply-To: <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
References: <20250610205737.63343-1-snitzer@kernel.org>
	 <20250610205737.63343-2-snitzer@kernel.org>
	 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
	 <aEnWhlXjzOmRfCJf@kernel.org>
	 <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
	 <aEn2-mYA3VDv-vB8@kernel.org>
	 <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
	 <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
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

On Thu, 2025-06-12 at 09:28 -0400, Chuck Lever wrote:
> On 6/12/25 6:28 AM, Jeff Layton wrote:
> > On Wed, 2025-06-11 at 17:36 -0400, Mike Snitzer wrote:
> > > On Wed, Jun 11, 2025 at 04:29:58PM -0400, Jeff Layton wrote:
> > > > On Wed, 2025-06-11 at 15:18 -0400, Mike Snitzer wrote:
> > > > > On Wed, Jun 11, 2025 at 10:31:20AM -0400, Chuck Lever wrote:
> > > > > > On 6/10/25 4:57 PM, Mike Snitzer wrote:
> > > > > > > Add 'enable-dontcache' to NFSD's debugfs interface so that: A=
ny data
> > > > > > > read or written by NFSD will either not be cached (thanks to =
O_DIRECT)
> > > > > > > or will be removed from the page cache upon completion (DONTC=
ACHE).
> > > > > >=20
> > > > > > I thought we were going to do two switches: One for reads and o=
ne for
> > > > > > writes? I could be misremembering.
> > > > >=20
> > > > > We did discuss the possibility of doing that.  Still can-do if th=
at's
> > > > > what you'd prefer.
> > > > > =20
> > > >=20
> > > > Having them as separate controls in debugfs is fine for
> > > > experimentation's sake, but I imagine we'll need to be all-in one w=
ay
> > > > or the other with a real interface.
> > > >=20
> > > > I think if we can crack the problem of receiving WRITE payloads int=
o an
> > > > already-aligned buffer, then that becomes much more feasible. I thi=
nk
> > > > that's a solveable problem.
> > >=20
> > > You'd immediately be my hero!  Let's get into it:
> > >=20
> > > In a previously reply to this thread you aptly detailed what I found
> > > out the hard way (with too much xdr_buf code review and tracing):
> > >=20
> > > On Wed, Jun 11, 2025 at 08:55:20AM -0400, Jeff Layton wrote:
> > > > >=20
> > > > > NFSD will also set RWF_DIRECT if a WRITE's IO is aligned relative=
 to
> > > > > DIO alignment (both page and disk alignment).  This works quite w=
ell
> > > > > for aligned WRITE IO with SUNRPC's RDMA transport as-is, because =
it
> > > > > maps the WRITE payload into aligned pages. But more work is neede=
d to
> > > > > be able to leverage O_DIRECT when SUNRPC's regular TCP transport =
is
> > > > > used. I spent quite a bit of time analyzing the existing xdr_buf =
code
> > > > > and NFSD's use of it.  Unfortunately, the WRITE payload gets stor=
ed in
> > > > > misaligned pages such that O_DIRECT isn't possible without a copy
> > > > > (completely defeating the point).  I'll reply to this cover lette=
r to
> > > > > start a subthread to discuss how best to deal with misaligned wri=
te
> > > > > IO (by association with Hammerspace, I'm most interested in NFS v=
3).
> > > > >=20
> > > >=20
> > > > Tricky problem. svc_tcp_recvfrom() just slurps the whole RPC into t=
he
> > > > rq_pages array. To get alignment right, you'd probably have to do t=
he
> > > > receive in a much more piecemeal way.
> > > >=20
> > > > Basically, you'd need to decode as you receive chunks of the messag=
e,
> > > > and look out for WRITEs, and then set it up so that their payloads =
are
> > > > received with proper alignment.
> > >=20
> > > 1)
> > > Yes, and while I arrived at the same exact conclusion I was left with
> > > dread about the potential for "breaking too many eggs to make that
> > > tasty omelette".
> > >=20
> > > If you (or others) see a way forward to have SUNRPC TCP's XDR receive
> > > "inline" decode (rather than have the 2 stage process you covered
> > > above) that'd be fantastic.  Seems like really old tech-debt in SUNRP=
C
> > > from a time when such care about alignment of WRITE payload pages was
> > > completely off engineers' collective radar (owed to NFSD only using
> > > buffered IO I assume?).
> > >=20
> > > 2)
> > > One hack that I verified to work for READ and WRITE IO on my
> > > particular TCP testbed was to front-pad the first "head" page of the
> > > xdr_buf such that the WRITE payload started at the 2nd page of
> > > rq_pages.  So that looked like this hack for my usage:
> > >=20
> > > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > > index 8fc5b2b2d806..cf082a265261 100644
> > > --- a/net/sunrpc/svc_xprt.c
> > > +++ b/net/sunrpc/svc_xprt.c
> > > @@ -676,7 +676,9 @@ static bool svc_alloc_arg(struct svc_rqst *rqstp)
> > >=20
> > >         /* Make arg->head point to first page and arg->pages point to=
 rest */
> > >         arg->head[0].iov_base =3D page_address(rqstp->rq_pages[0]);
> > > -       arg->head[0].iov_len =3D PAGE_SIZE;
> > > +       // FIXME: front-pad optimized to align TCP's WRITE payload
> > > +       // but may not be enough for other operations?
> > > +       arg->head[0].iov_len =3D 148;
> > >         arg->pages =3D rqstp->rq_pages + 1;
> > >         arg->page_base =3D 0;
> > >         /* save at least one page for response */
> > >=20
> > > That gut "but may not be enough for other operations?" comment proved
> > > to be prophetic.
> > >=20
> > > Sadly it went on to fail spectacularly for other ops (specifically
> > > READDIR and READDIRPLUS, probably others would too) because
> > > xdr_inline_decode() _really_ doesn't like going beyond the end of the
> > > xdr_buf's inline "head" page.  It could be that even if
> > > xdr_inline_decode() et al was "fixed" (which isn't for the faint of
> > > heart given xdr_buf's more complex nature) there will likely be other
> > > mole(s) that pop up.  And in addition, we'd be wasting space in the
> > > xdr_buf's head page (PAGE_SIZE-frontpad).  So I moved on from trying
> > > to see this frontpad hack through to completion.
> > >=20
> > > 3)
> > > Lastly, for completeness, I also mentioned briefly in a previous
> > > recent reply:
> > >=20
> > > On Wed, Jun 11, 2025 at 04:51:03PM -0400, Mike Snitzer wrote:
> > > > On Wed, Jun 11, 2025 at 11:44:29AM -0400, Jeff Layton wrote:
> > > >=20
> > > > > In any case, for now at least, unless you're using RDMA, it's goi=
ng to
> > > > > end up falling back to buffered writes everywhere. The data is al=
most
> > > > > never going to be properly aligned coming in off the wire. That m=
ight
> > > > > be fixable though.
> > > >=20
> > > > Ben Coddington mentioned to me that soft-iwarp would allow use of R=
DMA
> > > > over TCP to workaround SUNRPC TCP's XDR handling always storing the
> > > > write payload in misaligned IO.  But that's purely a stop-gap
> > > > workaround, which needs testing (to see if soft-iwap negates the wi=
n
> > > > of using O_DIRECT, etc).
> > >=20
> > > (Ab)using soft-iwarp as the basis for easily getting page aligned TCP
> > > WRITE payloads seems pretty gross given we are chasing utmost
> > > performance, etc.
> > >=20
> > > All said, I welcome your sage advice and help on this effort to
> > > DIO-align SUNRPC TCP's WRITE payload pages.
> > >=20
> > > Thanks,
> > > Mike
> >=20
> > (Sent this to Mike only by accident yesterday -- resending to the full
> > list now)
> >=20
> > I've been looking over the code today. Basically, I think we need to
> > have svc_tcp_recvfrom() receive in phases. At a high level:
> >=20
> > 1/ receive the record marker (just like it does today)
> >=20
> > 2/ receive enough for the RPC header and then decode it.
> >=20
> > 3/ Use the rpc program and version from the decoded header to look up
> > the svc_program. Add an optional pg_tcp_recvfrom callback to that
> > structure that will receive the rest of the data into the buffer. If
> > pg_tcp_recvfrom isn't set, then just call svc_tcp_read_msg() like we do
> > today.
>=20
> The layering violations here are mind-blowing.
>=20

Aww. I don't think it's too bad.

>=20
> > For NFSv3, pc_tcp_recvfrom can just look at the procedure. If it's
> > anything but a WRITE we'll just do what we do today
> > (svc_tcp_read_msg()).
> >=20
> > For a WRITE, we'll receive the first part of the WRITE3args (everything
> > but the data) into rq_pages, and decode it. We can then use that info
> > to figure out the alignment. Advance to the next page in rq_pages, and
> > then to the point where the data is properly aligned. Do the receive
> > into that spot.
> >=20
> > Then we just add a RQ_ALIGNED_DATA to rqstp->rq_flags, and teach
> > nfsd3_proc_write how to find the data and do a DIO write when it's set.
> >=20
> > Unaligned writes are still a problem though. If two WRITE RPCs come in
> > for different parts of the same block at the same time, then you could
> > end up losing the result of the first write. I don't see a way to make
> > that non-racy.
> >=20
> > NFSv4 will also be a bit of a challenge. We'll need to receive the
> > whole compound one operation at a time. If we hit a WRITE, then we can
> > just do the same thing that we do for v3 to align the data.
> >=20
> > I'd probably aim to start with an implementation for v3, and then add
> > v4 support in a second phase.
> >=20
> > I'm interested in working on this. It'll be a fair bit of work though.
> > I'll need to think about how to break this up into manageable pieces.
>=20
> Bruce has been thinking about payload alignment schemes for at least
> ten years. My opinion has always been:
>=20
> - We have this already via RDMA, even over TCP
> - Any scheme like this will still not perform as well as RDMA
> - NFS/TCP is kind of a "works everywhere" technology that I prefer to
>   not screw around with
> - The corner cases will be troubling us for many years
> - Only a handful of users will truly benefit from it
> - There are plenty of higher priority items on our to-do list.
>=20

If you're against the idea, I won't waste my time.

It would require some fairly hefty rejiggering of the receive code. The
v4 part would be pretty nightmarish to work out too since you'd have to
decode the compound as you receive to tell where the next op starts.

The potential for corruption with unaligned writes is also pretty
nasty.
--=20
Jeff Layton <jlayton@kernel.org>

