Return-Path: <linux-fsdevel+bounces-57170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EED2B1F438
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 12:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF1C5604AD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 10:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE5B26B0B3;
	Sat,  9 Aug 2025 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDqKTywn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC41D5ACE;
	Sat,  9 Aug 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754736178; cv=none; b=PEeV4fHjIDwDzoDxt03vmFj7s0Eee/kRWC0jzfKDv8mzoz5lxPxpvmgmjLTt8ESx2VVRWz6ocQK4zW/ml+7PhdcFe0Qp/Wrk/o/HBpk1Pb+bEiR/xlay4NcAi9/UG9AiWH8aIYVfCEIPaibM7yKvQtHnkCPMhwZOhNJG8vlLMbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754736178; c=relaxed/simple;
	bh=a8+UN8/ZSBO/sg2c/xViTOsohY3HngjC+LoJbCHsVEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfNd/JCBQ6PzTSuYILtEmkJPYgJvgMHvMu/LEOFQMUZ3K6Cbk+uQvm1ADTzJfBTNL/H8huenSm2xAU7XGs5nJTA40tIHcg2HT/DU/3TOg1yo0Ko23Psmwi1J/3qxcCwRvs7YFgO3rahYkzKkmh9TjhywzaQ8EDnyeW/VR4XD6xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDqKTywn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F15C4CEE7;
	Sat,  9 Aug 2025 10:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754736178;
	bh=a8+UN8/ZSBO/sg2c/xViTOsohY3HngjC+LoJbCHsVEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDqKTywnRc8WgKFRX1w9DZ3/NL4s3ZkX6W5/rlg/5WFN87tXrkrpeIVLb+hfnoGeC
	 7B4znkqz0L4jJkvotDRFDR8Roi+O9GruyarmlJRoadFPSzcBKpR+J22EJA0127pcVC
	 mchr+wxMc4WgE+32mw1HTdV3G1eVrWq0r4isB81lIDonS3lxt6ipVG9mrt1PlYm4Ji
	 R9MTZ3HwBWHSrGy5Gvp3noLR5btNMKi1BLVtu2K87kLmtVjybFAz+pYCL1Kftg72Nm
	 96NhX8jTpot1/TkbKYoEP1HzmhJ47NDk+elNKPWbaUWDzi8IpoYmH/95YpDERMqtz2
	 ttnAiY2zK2SjQ==
Date: Sat, 9 Aug 2025 12:42:47 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Askar Safin <safinaskar@zohomail.com>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 01/11] mount_setattr.2: document glibc >= 2.36 syscall
 wrappers
Message-ID: <j57inuu7wzzh2tm7sxfnhdogg4u7f4gf3vktmla4qlafuknh3p@ypu3peu3g5k6>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-1-558a27b8068c@cyphar.com>
 <19888fe1066.fcb132d640137.7051727418921685299@zohomail.com>
 <2025-08-08.1754653930-iffy-pickled-agencies-mother-K0e7Hn@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ad66n3krjtkx2hx6"
Content-Disposition: inline
In-Reply-To: <2025-08-08.1754653930-iffy-pickled-agencies-mother-K0e7Hn@cyphar.com>


--ad66n3krjtkx2hx6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Askar Safin <safinaskar@zohomail.com>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 01/11] mount_setattr.2: document glibc >= 2.36 syscall
 wrappers
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-1-558a27b8068c@cyphar.com>
 <19888fe1066.fcb132d640137.7051727418921685299@zohomail.com>
 <2025-08-08.1754653930-iffy-pickled-agencies-mother-K0e7Hn@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <2025-08-08.1754653930-iffy-pickled-agencies-mother-K0e7Hn@cyphar.com>

Hi Aleksa, Askar,

On Fri, Aug 08, 2025 at 09:55:10PM +1000, Aleksa Sarai wrote:
> On 2025-08-08, Askar Safin <safinaskar@zohomail.com> wrote:
> > When I render "mount_setattr" from this (v2) pathset, I see weird quote=
 mark. I. e.:
> >=20
> > $ MANWIDTH=3D10000 man /path/to/mount_setattr.2
> > ...
> > SYNOPSIS
> >        #include <fcntl.h>       /* Definition of AT_* constants */
> >        #include <sys/mount.h>
> >=20
> >        int mount_setattr(int dirfd, const char *path, unsigned int flag=
s,
> >                          struct mount_attr *attr, size_t size);"
> > ...
>=20
> Ah, my bad. "make -R lint-man" told me to put end quotes on the synopsis
> lines, but I missed that there was a separate quote missing. This should
> fix it:
>=20
> diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
> index d44fafc93a20..46fcba927dd8 100644
> --- a/man/man2/mount_setattr.2
> +++ b/man/man2/mount_setattr.2
> @@ -14,7 +14,7 @@ .SH SYNOPSIS
>  .B #include <sys/mount.h>
>  .P
>  .BI "int mount_setattr(int " dirfd ", const char *" path ", unsigned int=
 " flags ","
> -.BI "                  struct mount_attr *" attr ", size_t " size );"
> +.BI "                  struct mount_attr *" attr ", size_t " size ");"

Actually, I'd use

=2EBI "                  struct mount_attr *" attr ", size_t " size );

>  .fi
>  .SH DESCRIPTION
>  The

Hmmm, thanks for the catch!  My CI server is down until I come back home
and have a chance to fix it.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--ad66n3krjtkx2hx6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmiXJicACgkQ64mZXMKQ
wqnnbw//WMHggmA4jUE/nRABMPtJLZDCGULhgMy1N4WDcF/+TKjDOt0ExRzUDVru
ItgtH8RM8Pp3sDxwaq3BonhA6gzg/JHKIJ8jxVJy5jpEOD+ovNOpCYbD7n1KCnAy
efvU3E27J4t4liHsA05PPqugb0Ndu20snWa7eaVPKnBWVTAEzTYl6NNgjvE5K7i1
noOwofQZt8wzNtAZzQyOfTh3RnamwJ0G/f9r15KiFOZ7Sq+ZVJJkhY18QS6lQVOO
VjNft+KwyOXGF+vHnFVkDBUr8sRe2UiFbQkS+jB12Rp0YGGjk+eirsLMRSqTxlLo
MBEq16FTOD8HPEgTn9Unvuml09SSluevUQlMOa8Hbnu62148zqL9ApGa0JS8ButU
JRXrJCZOwqRtOgNlusc4e5Xhej7Gpvw5tbl+2AJpxRrnZGOxTXkRZFv4pRp6mOcz
8kgMMZuZwuYyHYn5W3R5MXLHs/mkCLkcJXQXU0PwHiDDH/6RIwChUTJ2qha61Fqa
Wkfln9v94TDWVVGCBKNy7A9TPS8+mAK8cVfYn/iqdWm5NpL18223l32qjw5rQt3Y
0R+WgxjLdpjRRjcV4b1wGN5raLE7/yKUB0y3MR71q+oS7s8hj7t21LgZaxE4TiI3
iN15mSC7sAns/N56Ig3367Hm9b8xr4/eZWfN0zVCWqzYg2Z4Cdk=
=TkZt
-----END PGP SIGNATURE-----

--ad66n3krjtkx2hx6--

