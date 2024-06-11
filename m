Return-Path: <linux-fsdevel+bounces-21480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C08904732
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 00:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12521F24CB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 22:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C5B1553B5;
	Tue, 11 Jun 2024 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="B85v919D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF219475
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718146296; cv=none; b=JephMhJvef9JB+4brmda7smrQ1SInuGFTQVBALcf52p15dFBEG4kJyFaCN/Oy6j4T/EouP40yvPtJx+u0jYsRjQ1PSvY3Cji9ckaSs4ryTSlaeNstbmvljh9jPw92hyhVTw37VQPlguZhSYcp/cOElkvKTCV6w2gYhPTbka8i6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718146296; c=relaxed/simple;
	bh=LBOuVfuzYD4OJOoHZ6LFhnQVyyZSROJefF3M5V9SiE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwLIZ6r/e7vOiy29Q3/qCi6OxM7loc02Rgt4zbup/KtcKtGHqFpEZs2DRxLMzqCssCDwzgw/jwbop+Rm0CeXZkB44Vf0c53cbH5yE0W7lRhPwxFZQ222iLgmL0w5igS2POkqKODmnyBHBryMLpIV5Zki56KOf4T86dfDBbmVVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=B85v919D; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1718146286;
	bh=fuAd9FMkiHXcAb9fXok8nqwfgM5yhxd3m4OHg8csZFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B85v919DFD1A1cZYIvRuZg64hMOAJa579QZyIkmlR+jpzEOoOR26AFackUwF+UaTv
	 QTKgrIzhE/Kged893Th9deGv9XR0tLiYVtIVhsBwMOwvS0QZ+L3aESX8hZSGXibR1M
	 MGL47iZW1D0LYeSjpznC6oJL7SL2PfXCZ7AnIdhpfmz0Ut9waaYefcohEEo8/InMNF
	 3C+ZS96azFDUhMUeruZE4Sx2X1BPhyk6wBtEYox0NuR0oel87Nfl7U1OjY43WJwtBP
	 Bqx6KDzUyeU0T5YOaNkLGqpZpkCPeAauT6k+SIVPW9cK8Qs/QeqnB+3oQQNqxnWzl4
	 39JvyNT+TETLg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VzP6k0dP3z4wb2;
	Wed, 12 Jun 2024 08:51:26 +1000 (AEST)
Date: Wed, 12 Jun 2024 08:51:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, Christian Brauner
 <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, David Teigland
 <teigland@redhat.com>
Subject: Re: A fs-next branch
Message-ID: <20240612085124.42e63859@canb.auug.org.au>
In-Reply-To: <ZmfKJsxTz3nwMwrh@casper.infradead.org>
References: <ZkPsYPX2gzWpy2Sw@casper.infradead.org>
	<20240520132326.52392f8d@canb.auug.org.au>
	<ZkvCyB1-WpxH7512@casper.infradead.org>
	<20240528091629.3b8de7e0@canb.auug.org.au>
	<20240529143558.4e1fc740@canb.auug.org.au>
	<20240610131539.685670-1-agruenba@redhat.com>
	<20240611081657.27aa51b5@canb.auug.org.au>
	<ZmfKJsxTz3nwMwrh@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0OFiGlbcI8gOd6MEdvNqc5_";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/0OFiGlbcI8gOd6MEdvNqc5_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 11 Jun 2024 04:53:10 +0100 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> On Tue, Jun 11, 2024 at 08:16:57AM +1000, Stephen Rothwell wrote:
> >=20
> > On Mon, 10 Jun 2024 15:15:38 +0200 Andreas Gruenbacher <agruenba@redhat=
.com> wrote: =20
> > >
> > > I don't know if it's relevant, but gfs2 is closely related to dlm, an=
d dlm
> > > isn't included here.  Would it make sense to either move dlm into fs-=
next, or
> > > move gfs2 out of it, to where dlm is merged? =20
> >=20
> > I don't know the answer to those questions, sorry. Hopefully someone
> > can advise us. =20
>=20
> I would add the DLM tree to fs-next since it's a normal dependency of gfs=
2.

I have done that from today.

--=20
Cheers,
Stephen Rothwell

--Sig_/0OFiGlbcI8gOd6MEdvNqc5_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmZo1OwACgkQAVBC80lX
0GyDAQf/XI61dx1Ihi4VV+GcEbLuVrm7IDQXur/xoT2H38o211qM2qOBJvetw1et
a9iLoYTHkn1bD+8+Ja599aIHiXnr76ql8SiY/nTNC3glqd4jyuACSqgR3EMsZ3K3
eZSFL6GmX61tQEjB6a8vJ63a/j07hIKt5K6Xm29hZ7LHjOjqca6kMHFO1R5aoW9y
SQpR8QeDyQZv7d6gnm0q3NoIhAapox2cLwHN3HUh/1X9QfKvVQ6yRbLMZiw+VGjP
40P+Zdt6Egh4Sf25bnkZ1aLfEbYXEoVkTjoB4zgkHdgHO7T1bXs9H3ZENGTAeKlz
qzwo8wKRyGFzG79Lbp6zP81n2jTXYg==
=9nIh
-----END PGP SIGNATURE-----

--Sig_/0OFiGlbcI8gOd6MEdvNqc5_--

