Return-Path: <linux-fsdevel+bounces-54228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1DBAFC487
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 09:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE97188BDC5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 07:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE55929B228;
	Tue,  8 Jul 2025 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BbKuXHVC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96AB298999;
	Tue,  8 Jul 2025 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960992; cv=none; b=JdjweoVUPnHSHT8k8dpBlajcHBtniIO4k2aD46UWoOiCKrR81CAkHkLJeZnDp4AGd++WNEWlsB+uBVqthq7rrJptU8IqLUALGHznXhr46u9KVEydBVN9oFgvGL+R0VT3nbJoIz63EW8XecBqJ/6bB44snamjkKyHcBIr5efIm6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960992; c=relaxed/simple;
	bh=0AMpQTfpxSLjgAs3N/PqckJJjy63x3iJFVIaAUZ7x4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llCmOG6bVSulOBnoupd8kERX+riuqTHqEdYcXZ5ilmy39FXNQVfdETVCc+AqEtySXBiPhzOZOxHqU56Ceto/WTPDq0N6WncleGS1YL0/MSPXMrvTBo2cGIZ051r+JO17JdA3By/8oHRCl7TeFGBOwMwt+VGXKDOC4R5U9+egeBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=BbKuXHVC; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1751960925;
	bh=wQMAZs9JG+dlk9X0QeLB39JyST3UKWFpkDlOJSOaYzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BbKuXHVCp2IkMhY9fuRXKzRC+L7K/xINkkLRoyuMqwoNlq+9R4VXFt4rwkb3zpZsL
	 FzjLNs1uXFKkshMAyw7G4glQ7OrS8cDso/HRqE5Yt8R9fZtrQLNueztNayr3s3KxDs
	 xNFzaJEib3920YD+Ite8LOhYlI+OfI/yRR1Kjhi6IeKjU8LPnza8xS9ynrG7VsUrvM
	 XAo665NmHkyPyvzHCrATOnJsIIccOiveMGNl4MydF5SSTQCM/2wtVNHLE5gsTbXKNS
	 R8snKoACfvG2muoW6gZvZ0orZgFAUlTfX7nnm7Q+A2UNN464VCGUGCNddu9QdVbDpX
	 JaceTwC6L4aZA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bbtX94m3lz4wbW;
	Tue,  8 Jul 2025 17:48:41 +1000 (AEST)
Date: Tue, 8 Jul 2025 17:49:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthias Maennich <maennich@google.com>, Jonathan Corbet
 <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, Daniel
 Gomez <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier
 <nicolas.schier@linux.dev>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Christoph
 Hellwig <hch@infradead.org>, Peter Zijlstra <peterz@infradead.org>, David
 Hildenbrand <david@redhat.com>, Shivank Garg <shivankg@amd.com>, "Jiri
 Slaby (SUSE)" <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org, Greg KH
 <greg@kroah.com>
Subject: Re: [PATCH 0/2] Restrict module namespace to in-tree modules and
 rename macro
Message-ID: <20250708174938.0d02040c@canb.auug.org.au>
In-Reply-To: <20250708-export_modules-v1-0-fbf7a282d23f@suse.cz>
References: <20250708-export_modules-v1-0-fbf7a282d23f@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fBozBVZ.Do+zD1PDuhFmP=r";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/fBozBVZ.Do+zD1PDuhFmP=r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vlastimil,

On Tue, 08 Jul 2025 09:28:56 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
>
> Christian asked [1] for EXPORT_SYMBOL_FOR_MODULES() without the _GPL_
> part to avoid controversy converting selected existing EXPORT_SYMBOL().
> Christoph argued [2] that the _FOR_MODULES() export is intended for
> in-tree modules and thus GPL is implied anyway and can be simply dropped
> from the export macro name. Peter agreed [3] about the intention for
> in-tree modules only, although nothing currently enforces it.
>=20
> It seems straightforward to add this enforcement, so patch 1 does that.
> Patch 2 then drops the _GPL_ from the name and so we're left with
> EXPORT_SYMBOL_FOR_MODULES() restricted to in-tree modules only.
>=20
> Current -next has some new instances of EXPORT_SYMBOL_GPL_FOR_MODULES()
> in drivers/tty/serial/8250/8250_rsa.c by commit b20d6576cdb3 ("serial:
> 8250: export RSA functions"). Hopefully it's resolvable by a merge
> commit fixup and we don't need to provide a temporary alias.

Thanks for the heads up and it seems easy enough.  You probably should
have cc'd Greg KH (the maintainer for the tty tree), though (done now).

>=20
> [1] https://lore.kernel.org/all/20250623-warmwasser-giftig-ff656fce89ad@b=
rauner/
> [2] https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/
> [3] https://lore.kernel.org/all/20250623142836.GT1613200@noisy.programmin=
g.kicks-ass.net/
>=20
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> Vlastimil Babka (2):
>       module: Restrict module namespace access to in-tree modules
>       module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to EXPORT_SYMBOL_FOR_M=
ODULES
>=20
>  Documentation/core-api/symbol-namespaces.rst | 11 ++++++-----
>  fs/anon_inodes.c                             |  2 +-
>  include/linux/export.h                       |  2 +-
>  kernel/module/main.c                         |  3 ++-
>  scripts/mod/modpost.c                        |  6 +++++-
>  5 files changed, 15 insertions(+), 9 deletions(-)
> ---
> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> change-id: 20250708-export_modules-12908fa41006
>=20
> Best regards,
> --=20
> Vlastimil Babka <vbabka@suse.cz>

--=20
Cheers,
Stephen Rothwell

--Sig_/fBozBVZ.Do+zD1PDuhFmP=r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmhszZIACgkQAVBC80lX
0GzKFQf+KKCk9pBJo1BlSjyo+VaXJN7IvCyQg5Xws4YX8jPtr2chs0topNP6fKKU
bbgAWe/rurPbpPJ5L3zP5Z2pNPr4akBc8r0PiEG9U5PAErDOpgJwEJSWx+ZE0ftE
XsvFyHsF/Shz4WBaWYuD+EsNdl4uVuoQBCOkzTSxuv6y0DyxiDi0BQV4I439N0tc
YyCkNz3EE9SZwoE7R4qqTIDSr1k2XDGpGJebo7cHdwQqejLdrh9zUcLN1DAAyrrR
LH3KJ9hf4b29EftQx5sVJNkh/2FKFNxHpPci2TuNGm61sKx1t8quDRXCVWTd1/Fm
SU5/FVVz/h1Yw7xhAwR6pAziLBoulg==
=kNBu
-----END PGP SIGNATURE-----

--Sig_/fBozBVZ.Do+zD1PDuhFmP=r--

