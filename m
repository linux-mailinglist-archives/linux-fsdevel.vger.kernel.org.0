Return-Path: <linux-fsdevel+bounces-70945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC167CAA900
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 16:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 101DA30B0A42
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DAC2DEA75;
	Sat,  6 Dec 2025 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="Y08LxnbG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079C926056D;
	Sat,  6 Dec 2025 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765034128; cv=none; b=mX1zhh+P+X7n/19UGOlovo1cLC+pofRh4M3dyexoP1xwPx8Ro3+2DLuV2zeumqWVfk4xpJhD+PVYPcAdK1nx3EG37rbkXRTOP3pWntVUY7o+XgU47sgTYFgsLjcEAFq8J4AQAYaxsTPhnllxJJT3j7sL9+ISysrludVfKyKKByA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765034128; c=relaxed/simple;
	bh=KZFZP3kx6PjyeS8vSsvChZpNDzoCxrRGkgYPfKdT3Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3bcyeH0Wvi+MhrtWVR/43PcYV74x4zChgPJFvu71gjoj7UtT9B0dvk5c9blQS0gWJZV2iPeEk7GCHcQaQ1bVWqAxXU8vxxczaVoVt4N0Jw2OPgwFejtBZAd8BTupUyogzAhU+uhe3gI3T9i8VbnP5nTAgyflVeVoo+w92LVBXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=Y08LxnbG; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1765034121;
	bh=KZFZP3kx6PjyeS8vSsvChZpNDzoCxrRGkgYPfKdT3Oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y08LxnbGyuvpFL8xnero7Z+OvguAtqj5WvOGU5sMkPnpuyFqL/Ow3YRyBXssR1eeZ
	 hcu3X3NZJbxsxXlESkG0BA3DqPCOj1jsCMwTRGUZBd3L5lisbKW5do0S1/d1Pe4x/J
	 3LnBpRVRRzGMK0U3HaRToYJiTijj3FRcuBPWFK/BM8vHCeaJKDZvJc2/m5EJoxEz8C
	 4l5jWhFX1Dt4O0NU+BtNyDoVbdpOQK+QZKi5Xl1+Hb0PI2Wfn9vwyTJrqARqAZsdcZ
	 pgGo7b+79Q5CNXgl385bKhFbJn5ryDD0gMETuhFe56PRRM216ejsFCAryQhBusfx2O
	 RH6jKXVSFhWYg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 5A25EE4E8;
	Sat,  6 Dec 2025 16:15:21 +0100 (CET)
Date: Sat, 6 Dec 2025 16:15:21 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: enforce the immutable flag on open files
Message-ID: <7xukn5ime27nvcxxvmddmh7bqc5uoyd7ytrph2ubyhoushhp7x@tarta.nabijaczleweli.xyz>
References: <znhu3eyffewvvhleewehuvod2wrf4tz6vxrouoakiarjtxt5uy@tarta.nabijaczleweli.xyz>
 <aTQnFQIc3ylSci1u@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cgfp6ofqlwp5ih5i"
Content-Disposition: inline
In-Reply-To: <aTQnFQIc3ylSci1u@casper.infradead.org>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--cgfp6ofqlwp5ih5i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 06, 2025 at 12:52:37PM +0000, Matthew Wilcox wrote:
> On Sat, Dec 06, 2025 at 01:03:35PM +0100, Ahelenia Ziemia=C5=84ska wrote:
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index ebd75684cb0a..0b0d5cfbcd44 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -3945,12 +3945,18 @@ EXPORT_SYMBOL(filemap_map_pages);
> > =20
> >  vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
> >  {
> > -	struct address_space *mapping =3D vmf->vma->vm_file->f_mapping;
> > +	struct file *file =3D vmf->vma->vm_file;
> > +	struct address_space *mapping =3D file->f_mapping;
> >  	struct folio *folio =3D page_folio(vmf->page);
> >  	vm_fault_t ret =3D VM_FAULT_LOCKED;
> > =20
> > +	if (unlikely(IS_IMMUTABLE(file_inode(file)))) {
> > +		ret =3D VM_FAULT_SIGBUS;
> > +		goto out;
> I don't believe you tested this code path.  It contains a rather obvious
> bug.
You're right, I tested this on ext4 twice and didn't realise;
this ought just be return VM_FAULT_SIGBUS;.

But even this doesn't work, because shmem{,_anon}_vm_ops
don't have a page_mkwrite callback at all,
much less it being filemap_page_mkwrite().

I'm not sure how I concluded that they do.

Adding a shmem_page_mkwrite() works for the mmap case.

--cgfp6ofqlwp5ih5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmk0SIgACgkQvP0LAY0m
WPEJuw/9Erzsnr20+rOiCsWz5rYiM3TNgbwGsRk18gmS2o+p/08ml/hJlTB/rrAX
2w0kL7ZuFmvicgXhv8XMr+va91MpBfkstKKZfI5ZIT6dQwX46iro+UDdIWW9L4hk
9kpUESrdbiAMtBi1LKSNYhG5WhNPXSPSnnz/rxYGJiZGvOW//G6aS5lvwc4mROmr
j/eJcZQPPItA40Nsuu0WATp4QINtDre5uhOxQx7CR4rupvCcD8Kh6DU817TfI6iF
XrxvqN8udiZkza/x1tHVVgsNq9DHYSxa2Jq9CncnX7v59EdP8EfW+O8el4jPFp0q
G9TamELg4MIvRHYY99tGEwUCbDy/xq3EaPLwgdtEvrcan/9xvMuglPwtzGnCYWrF
5y8+3DpiYo5+f/tsOIEgVwvNt3CQ1VQZLy5USeHUaBht2RpeWmTfTBPHzq9F3D5A
281yLY+khYuHymTbzPm6qAQgo7ZKTg3EWqWkFpaQ6XI8IIF9puoNS38bP2X1DC+I
fBxuIpqmft+o9AgiK5dzGK/fSTqcsyQJQc3Qlu1MCjLSwBtYQaV29MnV1KQEPuvu
ljkh1/gLsngTmFjBQNWOhD5knQXskC2BxslmnYftxYbnrX4YJwVmmX2PnxQHKDW8
cg9pdfgGJ+/KFTxnNrMElCXWC0Y8pTzzNzQ5dvENTBG96fT1r6E=
=3sVJ
-----END PGP SIGNATURE-----

--cgfp6ofqlwp5ih5i--

