Return-Path: <linux-fsdevel+bounces-20593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E008D567F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 01:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1CA1F27844
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 23:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126A81836FE;
	Thu, 30 May 2024 23:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ia3t8wAy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0648817D34C
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717113026; cv=none; b=bZeEDJyiK3Hfp2PCA0FRCXoAszb8xt/kvwLqtaJi9S1oPNpACqG6MntbQ1WNh3EWU1Xz4PIZNJF+9YzADcyGuaKi1fPBPQhMooE4SzCOSkklPRP8OJx+i1wniBks0Ln8KSUywPlxmnvGnxnIGHbeVTQlqcXOxbhxX1fnbi50g+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717113026; c=relaxed/simple;
	bh=3oMQrN7+llrIzC71guTnvRyRlEnGWhLn57AZzYVvqjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nKHsCYLA2d9wDfS3oQtQQPjWcoCF+gIeAgxgifbiFgEBLLDtaPoe54X+hRvDcnWFw3tOoPqfjg7jU3KHajTljL7OB4CNDJ4i0uuBgOGZIIejLzxRvLVB7d36fnijBayqHPjEYme+Spj7W0AXRHuZEDqASKmOz5ujro81UopRCxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ia3t8wAy; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1717113022;
	bh=fXxnDKh2ljyzqMIs2sbZGqxXl6RI6CadTxvgW4BP8k8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ia3t8wAyFDVXcMj5SUzJqL3LvvT2oEsBX5TU02lp2ipsBWP2oQ4Ojl2h7U4j6MZbM
	 2HYiO4BjyWuypEOQ1raTMee++TmolUPSEzq1f9bsEazUfFBow298Uqc8epLWXqeWGs
	 nx8XtuorgzrnsMSG5rg0SlWQHlkVfdxYi9NyeEQL+rg7jP4TwiTVqViQylq95uaJA+
	 q/CvepOKGl4c9Nnu1Pi8NVm5wVImj7yM6kJ7aczSNLJOGbScU4SemiPtiPVEjOc958
	 nyAg2tnLAzvXo9YTONjRvyT8En8XG/BKNTE5+sCwKjPMxAVg8jqpYP1trNtwfY0e6r
	 xJzpOL6lX3+4Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Vr30F4dw9z4wcC;
	Fri, 31 May 2024 09:50:21 +1000 (AEST)
Date: Fri, 31 May 2024 09:50:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: A fs-next branch
Message-ID: <20240531095019.560f0644@canb.auug.org.au>
In-Reply-To: <20240529-teesieb-frieren-c432407f5543@brauner>
References: <ZkPsYPX2gzWpy2Sw@casper.infradead.org>
	<20240520132326.52392f8d@canb.auug.org.au>
	<ZkvCyB1-WpxH7512@casper.infradead.org>
	<20240528091629.3b8de7e0@canb.auug.org.au>
	<20240529143558.4e1fc740@canb.auug.org.au>
	<20240529-teesieb-frieren-c432407f5543@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4D+tl.HjnMYyJu89kTzvp4p";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/4D+tl.HjnMYyJu89kTzvp4p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Wed, 29 May 2024 13:12:15 +0200 Christian Brauner <brauner@kernel.org> w=
rote:
>=20
> Could you please add
> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.fixes to fs=
-current
> as well. Thanks!

Done from today.  Called vfs-brauner-fixes.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--=20
Cheers,
Stephen Rothwell

--Sig_/4D+tl.HjnMYyJu89kTzvp4p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmZZELsACgkQAVBC80lX
0GwjUgf/cTrSBt9ZHlGoPPRSobYIOt3zMgR5B4oTxYQ+exXzQ+UDzVgtZ25Dmhtk
nQobk8Zmumq7WYDNN76uSAHKhcA8MfeYbywdsMzAbdsS3APQVnSsJTi95ZAyQH5+
SKKUpkSQnGQG9coG6Nzg+SIKRgGNQe/iFI/yFobNWuQFf7bcsKYkgh+lC5Sx3fig
BQd6/H9z1RJnIPsGNszIznxnkak2KzPqDGaew6e2hHxy4rz5ICzJTOyhPVvlrk3Z
54/YW9Io0q695QZmiogmTHniQ31kXYoXvnDmG9t1raC1YqVIpJGenXVdSy352r4b
UXCtmC55OomXj6uXGFjrz0FWGKzBhA==
=eFN2
-----END PGP SIGNATURE-----

--Sig_/4D+tl.HjnMYyJu89kTzvp4p--

