Return-Path: <linux-fsdevel+bounces-27363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563609609DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 14:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899E71C22BE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 12:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD8F1A0B08;
	Tue, 27 Aug 2024 12:18:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352D819F466;
	Tue, 27 Aug 2024 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761133; cv=none; b=ukJz7s6ZdBtOQZ3HXbOxXyrxz6jGf7ORNCEg14jBnbZ9TA5O799dcaZ340F76vgH+QECPKywCZEAfbG/bDXedkG3mwIm+n3ObKdB7fEfMVvQAxrBewsPGrv/BzgXRWsRUNDj780fRAo7/YojdjmZMH/+S9Kqcg0daaP3JnyZSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761133; c=relaxed/simple;
	bh=aepOSfjAE0/4/STeaK9DfgC3Tuqxfkj3mGK+g0Exu7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8rlj/C+M0cVW0ucnZTMp17FPH/QEr3HMASarbTscCxfblATS9ruG8cVgrHqT05KlLw7qrWP9P/7yDRqPDdwvD746x/RaaAwzNPrTyj6Tm3x9ZBcMwcqsAgBVt45zOULvOkgJKhqrBOqq2835mrARaw8MWn3R6Q3TLTW6Xm1tJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 520F91C0082; Tue, 27 Aug 2024 14:18:43 +0200 (CEST)
Date: Tue, 27 Aug 2024 14:18:42 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <kees@kernel.org>,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH AUTOSEL 4.19 06/14] ELF: fix kernel.randomize_va_space
 double read
Message-ID: <Zs3EIrnulQ38qJ6o@duo.ucw.cz>
References: <20240801004037.3939932-1-sashal@kernel.org>
 <20240801004037.3939932-6-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0H/kKR1q4BOCT0lu"
Content-Disposition: inline
In-Reply-To: <20240801004037.3939932-6-sashal@kernel.org>


--0H/kKR1q4BOCT0lu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 2a97388a807b6ab5538aa8f8537b2463c6988bd2 ]
>=20
> ELF loader uses "randomize_va_space" twice. It is sysctl and can change
> at any moment, so 2 loads could see 2 different values in theory with
> unpredictable consequences.
>=20
> Issue exactly one load for consistent value across one exec.
>=20
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> Link: https://lore.kernel.org/r/3329905c-7eb8-400a-8f0a-d87cff979b5b@p183
> Signed-off-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/binfmt_elf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index c41c568ad1b8a..af8830878fa0b 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -876,7 +876,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	if (elf_read_implies_exec(loc->elf_ex, executable_stack))
>  		current->personality |=3D READ_IMPLIES_EXEC;
> =20
> -	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
> +	const int snapshot_randomize_va_space =3D READ_ONCE(randomize_va_space);
> +	if (!(current->personality & ADDR_NO_RANDOMIZE) && snapshot_randomize_v=
a_space)
>  		current->flags |=3D PF_RANDOMIZE;
> =20
>  	setup_new_exec(bprm);

We normally put variable declaration at start of the function. I'd not
be surprised if this broke with older compilers.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0H/kKR1q4BOCT0lu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZs3EIgAKCRAw5/Bqldv6
8rWzAKCw9WxXBUQFNz70zssjVcP983gl5gCfWUO5DlUA2oNoLPx9KUEZXqVmqRo=
=PKkY
-----END PGP SIGNATURE-----

--0H/kKR1q4BOCT0lu--

