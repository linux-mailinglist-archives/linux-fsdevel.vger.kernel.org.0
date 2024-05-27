Return-Path: <linux-fsdevel+bounces-20287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9248D107E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 01:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296172825C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 23:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308B9167260;
	Mon, 27 May 2024 23:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LicOQLVt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5341C79
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716851795; cv=none; b=c/GgwqIVajTIpvHTj3cSX+DniYC/TDEapldnGTqa5Cb56eXGfsR9GYa0xSBeIGiOMCVnwbCaIBFZi/IyzjO64XQzltFoT9WT6oNV91XFys3cSO3BaCpxTeqKjSCACskDNgo4OZFyrqMJMSaQDzeEOq7gWY5C3Nj1ewf3lX0/k8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716851795; c=relaxed/simple;
	bh=NyqdcGQz8Lf2o5CehreUDY8O3qP94BaSHhCWI2DGl1M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqtCQSmZux8i993SHtWmRyHRQs7D62F2G/Z9z3fQJ/QyHnMa10ny2FyoZOegXpNf/KtzpjWQU6Ji9u8NBRv9/ELWlTwK6nrJPzsQxVxfM7Ys1biuv+vxFU08Qdz5MhdHnGsIlL9rHnE4AEmLyLSDS9z2/npftB+lqgHw3M5Aw40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=LicOQLVt; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1716851790;
	bh=AL229ncjoHm5OCDMrhxmaMNhHBdr5oSca2LMJo55Th4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LicOQLVtyYHpoIaIQsXeO0l/Y3HxYrA4AAEnwR9IwgvSeS0FjoCKdVjZspT+0G/Wi
	 6SxwcdLcNrvWdOrynpREtxVmCmkUmVozI5umNDmn8mQFLqV8sk+SjpcaLLg9WLCxjD
	 AeMJYdlmpuciE8FRJVA1wGZ3xiud8NK3Ku7iL20KWLbEwy5al5V0IY+8RLt4TshhsE
	 ukRpaUAZ6NYU5j2dUv4uGs7V80tH7HuEQYT1opY+gcl5nYUW5i7bFcGyB4isssQ1er
	 mjSrPrWJR4HY6hv6LZScNie/sqpuQrIc0pwwiaxZPYZXMORc8W7S+ItQu9LXQNyPlM
	 D/7Er5qCbTHig==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VpBNZ0RNpz4wx6;
	Tue, 28 May 2024 09:16:30 +1000 (AEST)
Date: Tue, 28 May 2024 09:16:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: A fs-next branch
Message-ID: <20240528091629.3b8de7e0@canb.auug.org.au>
In-Reply-To: <ZkvCyB1-WpxH7512@casper.infradead.org>
References: <ZkPsYPX2gzWpy2Sw@casper.infradead.org>
	<20240520132326.52392f8d@canb.auug.org.au>
	<ZkvCyB1-WpxH7512@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2kE=BnM5Yw6aYuLIEYm3CkX";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/2kE=BnM5Yw6aYuLIEYm3CkX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Mon, 20 May 2024 22:38:16 +0100 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> As I understand the structure of linux-next right now, you merge one
> tree after another in some order which isn't relevant to me, so I have no
> idea what it is.  What we're asking for is that we end up with a branch
> in your tree called fs-next that is:
>=20
>  - Linus's tree as of that day
>  - plus the vfs trees
>  - plus xfs, btrfs, ext4, nfs, cifs, ...
>=20
> but not, eg, graphics, i2c, tip, networking, etc
>=20
> How we get that branch is really up to you; if you want to start by
> merging all the filesystem trees, tag that, then continue merging all the
> other trees, that would work.  If you want to merge all the filesystem
> trees to fs-next, then merge the fs-next tree at some point in your list
> of trees, that would work too.
>=20
> Also, I don't think we care if it's a branch or a tag.  Just something
> we can call fs-next to all test against and submit patches against.
> The important thing is that we get your resolution of any conflicts.
>=20
> There was debate about whether we wanted to include mm-stable in this
> tree, and I think that debate will continue, but I don't think it'll be
> a big difference to you whether we ask you to include it or not?

OK, I can see how to do that.  I will start on it tomorrow.  The plan
is that you will end up with a branch (fs-next) in the linux-next tree
that will be a merge of the above trees each day and I will merge it
into the -next tree as well.

--=20
Cheers,
Stephen Rothwell

--Sig_/2kE=BnM5Yw6aYuLIEYm3CkX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmZVFE0ACgkQAVBC80lX
0GzMogf/aMbRTE2wlHoiRl1BQ3FYDIhXHR+0j5PwWjnjwuTLk2T+Ty6WodiS+0oU
PqsIkBBeBbVYvSUiaCUahHHvrvR/lAepRZCXM3sDdvkZbtaf/hFwiSR2ln4z27b0
N2pHPAqsUUnZ0Q2/J5XTfk5nlVCMiJEKRke8lesjyQaAG6D4D75uPf61/mOWaOzd
qY7x/KtutvBPyBbdlbkWRrE1jRFpVQUduVk9Pe1r3yLMZa+wS4lYxq+6a9PP7VH5
XCgK8rXQVq0oG2UwBYXpviqfuyNLUGfiblOHI/pjhkaMzUjgiF0RL3liI3FuFgD9
YICoL4JZ6qHmXNLAzsjBzQLNJOKrlA==
=Ot1N
-----END PGP SIGNATURE-----

--Sig_/2kE=BnM5Yw6aYuLIEYm3CkX--

