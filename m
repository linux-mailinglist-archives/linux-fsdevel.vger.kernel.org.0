Return-Path: <linux-fsdevel+bounces-51589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D63AD8CAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 15:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8977A64C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 13:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A937260F;
	Fri, 13 Jun 2025 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uV4JHpSk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A8763A9;
	Fri, 13 Jun 2025 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749819746; cv=none; b=l3lKFzSjJi8ey8UO8QVZYNRleQxvhSDNtOBCCXgtd9BV0Zc8bIs+zNEBaqMcUNV2mEkqw9VHLWscsu6H55aQX0jIrvkr84/xl8fEBsmZTiF6A92PAryDkzASoNgwiiy6P8Fib+4XfT35lq1A8er4SOJEAQnbHXbaysEtWCUWGEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749819746; c=relaxed/simple;
	bh=7PN5k/AFgWAvQWxG5z8DzkDiPOVq1Fl4+DiqkGFpucE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fWrVFMotgP7Hl2t+9FyChdC9JEEZVhxuh76DTKs5EpEF7OuyDEYTpmp34H6QioawP9CDHVtb/MhGdHnzODy6FwVek8qsoaEsOrzMBtFGcqTXaQb+7YK81mPFiR5rBZGZ/FM7+dYjCojxeDVNN+rsxDZWslJ4xCUMZEF3UqNAvkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uV4JHpSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0404DC4CEE3;
	Fri, 13 Jun 2025 13:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749819745;
	bh=7PN5k/AFgWAvQWxG5z8DzkDiPOVq1Fl4+DiqkGFpucE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=uV4JHpSkp+O0rpQSPW7BeXhNWqi8sAZ767BwEjQFaD6jligPeo+3wdF+gxRaIROvK
	 O2BIezAIGYa4hfa7YHhSlPpfMGxH/auAXBIrMb3wjAtV9L82zCuSexezS02quWEPcX
	 CydkSNXrj4CUvP3bE3oDMZId7ez3xlWadcQsjf7plNw5fDqCAaBn/4o7yC3dFbiX6G
	 vRe88Tc675kSN/BAy5OrKPcoDS1rrxwQoML8Iq/C5CPak0wShRRGiLcZl9Kq2ZP5C/
	 v/VkUfMv2u9aKGuWBvNa/rS70wD0Lsm+kcxL9dF4yCFa6ZXWVX0bUphDATJYNVQDsZ
	 XgTrMA9WDMKnA==
Message-ID: <826d22214f01fc453a7e38953e2b8893073fcd46.camel@kernel.org>
Subject: Re: need SUNRPC TCP to receive into aligned pages [was: Re: [PATCH
 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE for all IO]
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	david.flynn@hammerspace.com
Date: Fri, 13 Jun 2025 09:02:23 -0400
In-Reply-To: <aEvuJP7_xhVk5R4S@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
	 <20250610205737.63343-2-snitzer@kernel.org>
	 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
	 <aEnWhlXjzOmRfCJf@kernel.org>
	 <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
	 <aEn2-mYA3VDv-vB8@kernel.org>
	 <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
	 <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
	 <f201c16677525288597becfd904d873931092cea.camel@kernel.org>
	 <aEu7GSa7HRNNVJVA@infradead.org> <aEvuJP7_xhVk5R4S@kernel.org>
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

On Fri, 2025-06-13 at 05:23 -0400, Mike Snitzer wrote:
> On Thu, Jun 12, 2025 at 10:46:01PM -0700, Christoph Hellwig wrote:
> > On Thu, Jun 12, 2025 at 12:22:42PM -0400, Jeff Layton wrote:
> > > If you're against the idea, I won't waste my time.
> > >=20
> > > It would require some fairly hefty rejiggering of the receive code. T=
he
> > > v4 part would be pretty nightmarish to work out too since you'd have =
to
> > > decode the compound as you receive to tell where the next op starts.
> > >=20
> > > The potential for corruption with unaligned writes is also pretty
> > > nasty.
> >=20
> > Maybe I'm missing an improvement to the receive buffer handling in mode=
rn
> > network hardware, but AFAIK this still would only help you to align the
> > sunrpc data buffer to page boundaries, but avoid the data copy from the
> > hardware receive buffer to the sunrpc data buffer as you still don't ha=
ve
> > hardware header splitting.
>=20
> Correct, everything that Jeff detailed is about ensuring the WRITE
> payload is received into page aligned boundary.
>=20
> Which in practice has proven a hard requirement for O_DIRECT in my
> testing -- but I could be hitting some bizarre driver bug in my TCP
> testbed (which sadly sits ontop of older VMware guests/drivers).
>=20
> But if you looking at patch 5 in this series:
> https://lore.kernel.org/linux-nfs/20250610205737.63343-6-snitzer@kernel.o=
rg/
>=20
> I added fs/nfsd/vfs.c:is_dio_aligned(), which is basically a tweaked
> ditto of fs/btrfs/direct-io.c:check_direct_IO():
>=20
> static bool is_dio_aligned(const struct iov_iter *iter, loff_t offset,
>                            const u32 blocksize)
> {
>         u32 blocksize_mask;
>=20
>         if (!blocksize)
>                 return false;
>=20
>         blocksize_mask =3D blocksize - 1;
>         if ((offset & blocksize_mask) ||
>             (iov_iter_alignment(iter) & blocksize_mask))
>                 return false;
>=20
>         return true;
> }
>=20
> And fs/nfsd/vfs.c:nfsd_vfs_write() has (after my patch 5):
>=20
>         nvecs =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, pay=
load);
>         iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
>=20
>         if (nfsd_enable_dontcache) {
>                 if (is_dio_aligned(&iter, offset, nf->nf_dio_offset_align=
))
>                         flags |=3D RWF_DIRECT;
>=20
> What I found is that unless SUNRPC TPC stored the WRITE payload in a
> page-aligned boundary then iov_iter_alignment() would fail.
>=20
> The @payload arg above, with my SUNRPC TCP testing, was always offset
> 148 bytes into the first page of the pages allocated for xdr_buf's
> use, which is rqstp->rq_pages, which is allocated by
> net/sunrpc/svc_xprt.c:svc_alloc_arg().
>=20
> > And I don't even know what this is supposed to buy the nfs server.
> > Direct I/O writes need to have the proper file offset alignment, but as
> > far as Linux is concerned we don't require any memory alignment.  Most
> > storage hardware has requirements for the memory alignment that we pass
> > on, but typically that's just a dword (4-byte) alignment, which matches
> > the alignment sunrpc wants for most XDR data structures anyway.  So wha=
t
> > additional alignment is actually needed for support direct I/O writes
> > assuming that is the goal?  (I might also simply misunderstand the
> > problem).
>
> THIS... this is the very precise question/detail I discussed with
> Hammerspace's CEO David Flynn when discussing Linux's O_DIRECT
> support.  David shares your understanding and confusion.  And all I
> could tell him is that in practice I always page-aligned my data
> buffers used to issue O_DIRECT.  And that in this instance if I don't
> then O_DIRECT doesn't work (if I commented out the iov_iter_alignment
> check in is_dio_aligned above).
>
> But is that simply due to xdr_buf_to_bvec()'s use of bvec_set_virt()
> for xdr_buf "head" page (first page of rqstp->rg_pages)?  Whereas you
> can see xdr_buf_to_bvec() uses bvec_set_page() to add each of the
> other pages that immediately follow the first "head" page.
>=20
> All said, if Linux can/should happily allow non-page-aligned DIO (and
> we only need to worry about the on-disk DIO alignment requirements)
> that'd be wonderful.
>=20
> Then its just a matter of finding where that is broken...
>=20
> Happy to dig into this further if you might nudge me in the right
> direction.
>=20

This is an excellent point. If the memory alignment doesn't matter,
then maybe it's enough to just receive the same way we do today and
just pad out to the correct blocksize in the bvec array if the data is
unaligned vs. the blocksize.

We still have the problem of how to do a proper RMW though to deal with
unaligned writes. A couple of possibilities come to mind:

1. nfsd could just return nfserr_inval when a write is unaligned and
the export is set up for DIO writes. IOW, just project the requirement
about alignment to the client. This might be the safest option, at
least initially. Unaligned writes are pretty uncommon. Most clients
will probably never hit the error.

2. What if we added a new "rmw_iter" operation to file_operations that
could be used for unaligned writes? XFS (for instance) could take the
i_rwsem exclusive, do DIO reads of the end blocks into bounce pages,
copy in the unaligned bits at the ends of the iter, do a DIO write and
release the lock. It'll be slow as hell, but it wouldn't be racy.

Mike, would you be amenable to option #1, at least initially? If we can
come up with a way to do unaligned writes safely, we could relax the
restriction later.

I'm only half serious about rmw_iter, but it does seem like that could
work.
--=20
Jeff Layton <jlayton@kernel.org>

