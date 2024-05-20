Return-Path: <linux-fsdevel+bounces-19740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBB58C9835
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 05:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5AE3B21D7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 03:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E6CDDA3;
	Mon, 20 May 2024 03:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L4xNm95c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875B9D27E
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 03:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716175417; cv=none; b=cpCmcHLFp3pVYZvFsw6Ec04knb7yt3cyYGldNiCMcjaBuxX0ZpZn2bzqU9/NBCbZ/RMSwTYfal+ThdiLfwPNIFL77B3KbGLwpDEvRktj6GspSpkxHiWBLZXo63SBYC7MOF0VW41P0ONj33ysc08SqJdmYeBAS/sB5VbvJeSegG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716175417; c=relaxed/simple;
	bh=hHRFLlFoYn7Vt3P8EjLmhxKNo2sBpvS+lnekSEMiGOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4TB92nDZRMWUu7Sd2w6UoPgLROINeIgQYutUJopn0HnQHPIZYpRSQzoTB7cicyvBYNgPFMtawyE6pcVDw6dSSZ/KGxuggJif/xF5wm0iFbVTRwQGkK/bZcq6e25M+iA9BBPrj+kQSxJrxeNc5XskxiV6nu42djPaU5dYgnhB2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=L4xNm95c; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1716175409;
	bh=5vh+PwSSCgJ/Pm3oHVaVr/L/7U6M04d7Cclt/Z8i+80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L4xNm95ca/QMV7lOaPi5eBfr4MSbVBblcWgiHxRJ8Br5huN+Sn8MP1qfhfkfs3N62
	 8SkQeG9xlX3OTxakg5ttcAp7Ib1RoE4Kcq5E6wooSCFRX8uhTdeGmokWkBJ0XGhC+8
	 RaGN8yHx6oq2F99Abyaq3mZyRwo6OG4Ms4jfG1WsdonPuEdRf6KPjNKGsJrS9sSm6x
	 YJ7m6B+DRqhAzQN7g6ujYqX1BiaRlA44WKOC9sz5wnPJwLbIK02z+IT3BcjTt85/BI
	 OFusiuH7NzLO/BQYtgbnLxuS/ivxQyPV+VhxAG844xd3pJRDs04V7Y/TBQIMQfmDCp
	 a0A4ycmxS670g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VjNFD6VjNz4wny;
	Mon, 20 May 2024 13:23:28 +1000 (AEST)
Date: Mon, 20 May 2024 13:23:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: A fs-next branch
Message-ID: <20240520132326.52392f8d@canb.auug.org.au>
In-Reply-To: <ZkPsYPX2gzWpy2Sw@casper.infradead.org>
References: <ZkPsYPX2gzWpy2Sw@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jC6g_ZeKOSgxHM_LHGKGzaH";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/jC6g_ZeKOSgxHM_LHGKGzaH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Willy,

Sorry for the slow response.

On Tue, 14 May 2024 23:57:36 +0100 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> At LSFMM we're talking about the need to do more integrated testing with
> the various fs trees, the fs infrastructure and the vfs.  We'd like to
> avoid that testing be blocked by a bad patch in, say, a graphics driver.
>=20
> A solution we're kicking around would be for linux-next to include a
> 'fs-next' branch which contains the trees which have opted into this
> new branch.  Would this be tremendously disruptive to your workflow or
> would this be an easy addition?

How would this be different from what happens at the moment with all
the separate file system trees and the various "vfs" trees?  I can
include any tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/jC6g_ZeKOSgxHM_LHGKGzaH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmZKwi4ACgkQAVBC80lX
0GxmDgf/XgPraf5U9CNm2QbGat/ceJsRteHQT4YPv52VQBqMJwVzr+oPF47ZCgq9
LD09HeRR+yA+x6Eyj//qv0otDLSDbY4R1dF2lb/O0ebKpyGKDd2qUffA6DhJre/l
eRp7KrlBAo21UvoU7ppBRQ4bXzbMntn0ms426/q/O4VJpO6TtZU2jaIhAQ6Gp6tf
eRsh2/UgFJE/hJMKdQ6Rw1Aj8r4DelVxL50F2c5okqIvgpVwJHiDA02HzlsXLvYm
mOIk9pCOv0PIGwXzXCOD+cSp5wp2bz0iDoSedvIeDIONKlNHod4BBOYeWBOMxdq0
IXAIZ+1lRs/xfrXSCrfLMB/ycCxvcw==
=ltFo
-----END PGP SIGNATURE-----

--Sig_/jC6g_ZeKOSgxHM_LHGKGzaH--

