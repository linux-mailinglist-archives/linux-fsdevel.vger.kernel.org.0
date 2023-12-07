Return-Path: <linux-fsdevel+bounces-5162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB22808AC5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 15:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FBC328199A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372B741A84
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oDc1LQNs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8F210C2;
	Thu,  7 Dec 2023 06:09:09 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231207140906euoutp01a968583816babe8207af359fc417f762~ekerLmbeQ1200612006euoutp014;
	Thu,  7 Dec 2023 14:09:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231207140906euoutp01a968583816babe8207af359fc417f762~ekerLmbeQ1200612006euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701958146;
	bh=gQOvJwnP4RJmx4q0SMRimq7/pmHWQK9ZyIg5Zdub5FQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=oDc1LQNsSbjh2qqzpnTX3PNzYKwZMKOewQFOhEL+ClVOX1S6nPstiZLNzzdhPtVS9
	 +GEVy8GxMWirtMPW+LSPdlH4TA1BdPZE6RZQuDmtCOepWeJIDoQIrlVU5tSBddL/WU
	 DDlobbou1qcAuuXQyaOzt0I9Fs3XmuSyCtPk5B1U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231207140906eucas1p1ca0d19aed72cacf9fa18fc8a45a98464~ekeq_-Ztj3009030090eucas1p1r;
	Thu,  7 Dec 2023 14:09:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 37.51.09539.202D1756; Thu,  7
	Dec 2023 14:09:06 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231207140905eucas1p1b4a4b5df08ed08727df6094d9f84dd69~ekeqW7qsv3251532515eucas1p1S;
	Thu,  7 Dec 2023 14:09:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231207140905eusmtrp2f080007a2612533b23a8b01f3fb466cc~ekeqWGZzi2087320873eusmtrp2T;
	Thu,  7 Dec 2023 14:09:05 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-61-6571d202bd44
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id B6.61.09274.102D1756; Thu,  7
	Dec 2023 14:09:05 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231207140905eusmtip20883ecdcf0cb7e5beb49b4056b777b70~ekeqKjJA20797807978eusmtip2V;
	Thu,  7 Dec 2023 14:09:05 +0000 (GMT)
Received: from localhost (106.210.248.38) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 7 Dec 2023 14:09:05 +0000
Date: Thu, 7 Dec 2023 15:09:03 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin
	<yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 03/18] sysctl: drop sysctl_is_perm_empty_ctl_table
Message-ID: <20231207140903.dxlazorxcolnhyrf@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="etof6dfa6kluo2qz"
Content-Disposition: inline
In-Reply-To: <20231204-const-sysctl-v2-3-7a5060b11447@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djP87pMlwpTDS51yFs0L17PZvHr4jRW
	izPduRZ79p5ksZi3/iejxeVdc9gsfv94xmRxY8JTRotlO/0cOD1mN1xk8ViwqdRj06pONo/9
	c9ewe3zeJOfR332MPYAtissmJTUnsyy1SN8ugSvj7Y/ZrAUdohXrTxxibGDcJtTFyMkhIWAi
	0Ta5n6WLkYtDSGAFo8SU/XvZIJwvjBIrJq6Gcj4zSvx9c48ZpmXB9F4miMRyRonN97eyIFTd
	WMYK4WxmlPhw4SgTSAuLgIrEmyc9YO1sAjoS59/cAbNFBGwkVn77zA7SwCywi0ni8cO5QA0c
	HMICnhJnHtSD1PAKmEvM3XiLHcIWlDg58wkLiM0sUCExseMhC0g5s4C0xPJ/HCBhTgFXiT8X
	frFCXKokcXjyZ6irayVObbnFBGGv5pTYP4MdwnaRaDr2H8oWlnh1fAuULSPxf+d8sC8lBCYz
	Suz/94EdwlnNKLGs8SvUJGuJlitPoDocJSbcvscOcpCEAJ/EjbeCEHfySUzaNp0ZIswr0dEG
	DXg1idX33rBMYFSeheSzWUg+m4XwGURYT+LG1ClsGMLaEssWvmaGsG0l1q17z7KAkX0Vo3hq
	aXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYJI7/e/4px2Mc1991DvEyMTBeIhRBaj50YbVFxil
	WPLy81KVRHhzzuenCvGmJFZWpRblxxeV5qQWH2KU5mBREudVTZFPFRJITyxJzU5NLUgtgsky
	cXBKNTDZKxy7dWD+F7VtZx+mhScvuqO2IOmloun5aX2vpO/4zREqM49+GrpkUQ2T/n9fqRlp
	fxS2NezhZDxjuMNlrsTxgjrmeRaCCWwb7Bge/F/TqZzfvLP8MfcTAVYXU3GfAgX9rFfi+6Nd
	Rd+f+V587Kbs4qLWFFW7v7H82hZrl7WtnOEpcW5mjNbB8z5CdqkrbCy07FmPVLz753s74/2u
	g1fVJLImMXQ8aejW2b5wfXbq2eKFlh9OcrdNdtmYeK6+YxVX19XMj7ofJHWcbhhwe8p9KuNf
	vqspLok3e+5Mh/g3EembPc3akouZGJj+Ta2ufTt9u7Jw/W42y3qxhNyUsutXjY8b39af2fbi
	aWX3WiWW4oxEQy3mouJEACVGO4ztAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsVy+t/xe7qMlwpTDaZ+NbJoXryezeLXxWms
	Fme6cy327D3JYjFv/U9Gi8u75rBZ/P7xjMnixoSnjBbLdvo5cHrMbrjI4rFgU6nHplWdbB77
	565h9/i8Sc6jv/sYewBblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1N
	SmpOZllqkb5dgl7Goz/nmQraRCvObdrA1MC4RaiLkZNDQsBEYsH0XqYuRi4OIYGljBKvL3xn
	hkjISGz8cpUVwhaW+HOtiw2i6COjRO+RzSwQzmZGib62BrAOFgEViTdPesBsNgEdifNv7oDZ
	IgI2Eiu/fWYHaWAW2MUk8fjhXKB9HBzCAp4SZx7Ug9TwCphLzN14ix1i6GVGiZtrFzBBJAQl
	Ts58wgJiMwuUSTzaf5AZpJdZQFpi+T8OkDCngKvEnwu/oC5Vkjg8+TPUB7USn/8+Y5zAKDwL
	yaRZSCbNQpgEEdaR2Ln1DhuGsLbEsoWvmSFsW4l1696zLGBkX8UoklpanJueW2ykV5yYW1ya
	l66XnJ+7iREY69uO/dyyg3Hlq496hxiZOBgPMaoAdT7asPoCoxRLXn5eqpIIb875/FQh3pTE
	yqrUovz4otKc1OJDjKbAUJzILCWanA9MQnkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp
	2ampBalFMH1MHJxSDUwVSoeqhX6qGVbzLvU9bTdD6uMO622iTtc7Dc7HNxi9DzhwZ2m5BbMO
	t+u2RnfHcyavt17RVTqfxqP0+Vf6tYiJGbaexz6c2d9y7pDk7BnZ9wyX/wzi3SjN5+IY2jcl
	P1XCp+3cNnYrsbzonyemJK6Ze4VTWrBCz5VT689Jpsb/dX9VpNdM432inT53earo019b325a
	MFOOu/3qm8sJE1wdcioFpE1FhSOKDp4K+THzfkGawr8TL2JVQ/PsjVnazlxsd3jhV1o5+dKd
	LZIxWy6uKRGOMKyZylqy2zRloxhf44OJn+/3cX6x+bq3OM9xiW+Uw/9Hcw/tbfDSv6bK/+Tz
	U6/i02+TbvBF13x6k6nEUpyRaKjFXFScCABZDUT2igMAAA==
X-CMS-MailID: 20231207140905eucas1p1b4a4b5df08ed08727df6094d9f84dd69
X-Msg-Generator: CA
X-RootMTR: 20231204075236eucas1p150b54f5bca6816fb8130a30496a8dbff
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231204075236eucas1p150b54f5bca6816fb8130a30496a8dbff
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
	<CGME20231204075236eucas1p150b54f5bca6816fb8130a30496a8dbff@eucas1p1.samsung.com>
	<20231204-const-sysctl-v2-3-7a5060b11447@weissschuh.net>

--etof6dfa6kluo2qz
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If you are separating the work for permanently empty directories, you
can add this patch to that set. as well as  2/18

Best
On Mon, Dec 04, 2023 at 08:52:16AM +0100, Thomas Wei=DFschuh wrote:
> It is used only once and that caller would be simpler with
> sysctl_is_perm_empty_ctl_header().
> So use this sibling function.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
>  fs/proc/proc_sysctl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 8064ea76f80b..689a30196d0c 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -48,10 +48,8 @@ struct ctl_table_header *register_sysctl_mount_point(c=
onst char *path)
>  }
>  EXPORT_SYMBOL(register_sysctl_mount_point);
> =20
> -#define sysctl_is_perm_empty_ctl_table(tptr)		\
> -	(tptr[0].type =3D=3D SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
>  #define sysctl_is_perm_empty_ctl_header(hptr)		\
> -	(sysctl_is_perm_empty_ctl_table(hptr->ctl_table))
> +	(hptr->ctl_table[0].type =3D=3D SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
>  #define sysctl_set_perm_empty_ctl_header(hptr)		\
>  	(hptr->ctl_table[0].type =3D SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
>  #define sysctl_clear_perm_empty_ctl_header(hptr)	\
> @@ -233,7 +231,7 @@ static int insert_header(struct ctl_dir *dir, struct =
ctl_table_header *header)
>  		return -EROFS;
> =20
>  	/* Am I creating a permanently empty directory? */
> -	if (sysctl_is_perm_empty_ctl_table(header->ctl_table)) {
> +	if (sysctl_is_perm_empty_ctl_header(header)) {
>  		if (!RB_EMPTY_ROOT(&dir->root))
>  			return -EINVAL;
>  		sysctl_set_perm_empty_ctl_header(dir_h);
>=20
> --=20
> 2.43.0
>=20

--=20

Joel Granados

--etof6dfa6kluo2qz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVx0f8ACgkQupfNUreW
QU+GIAv+KWbc8cruumpWQKvgTgVlEGLGgCJVse3Kfb0DYiRjt3V7lGQZv1RSqezm
ZKMsMzljxb1o8OhymJAD1m658hQd/6pqN7z880QwPLQMLRb4SOnO9b0x3uyp+wSH
q9hEl77PaAtXa64un9iY363HUrWYhE7yTCCLRJ26WuVLAFypd7ciX7qkxEK12swX
s42K1APkW3uenFOoZxSb1HKwxGduFQYnjfaQB7/MWm4zwglExu7y9Xy9OnkavjX8
2QgE0RFSQfBUbf59fBWgMui0NdSNg0T5qFtP3yfyav/W4/BBKZiWl/7vsNPtXQ/v
K/rRsOkRxyHtmKu8mZvWoiMhPyyLMWfIuw2KPp2A+QYVVfAfWMhuqJ/9f2UTR/uM
Qmn+KW8szcU1WCM6GrG09HRREk82TROTALV0Rq0x1Vm/WF5UXpT2Sqg/Dc+japov
iF7oYcAvPsBLIm3B1fPxeWlCx6o/l9XrXHrw8FP6GCAmveb7HMpccFJZtdHRL2h9
bi1HXhWK
=NL3C
-----END PGP SIGNATURE-----

--etof6dfa6kluo2qz--

