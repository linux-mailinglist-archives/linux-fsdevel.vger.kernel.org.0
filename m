Return-Path: <linux-fsdevel+bounces-2369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F977E51F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 09:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC27C1C20D9B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 08:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F622DDBA;
	Wed,  8 Nov 2023 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uwECrOZY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080BBDDA2
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 08:26:55 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A3B10DA;
	Wed,  8 Nov 2023 00:26:55 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231108082651euoutp01322a31e30a1949a58485448ad136f3ee~VmGkvKJK-1292912929euoutp01S;
	Wed,  8 Nov 2023 08:26:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231108082651euoutp01322a31e30a1949a58485448ad136f3ee~VmGkvKJK-1292912929euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1699432012;
	bh=eMo1TU5p3NXnSXpc6X1V4mK9zZsurYCuwe1XJ0Pu4Pk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=uwECrOZYFI5jFdAU0t1qbP0QvYCIRinqIPlTTisFdWjCJC8PSwgECKcBl+ZsH6MV0
	 RVT+W4Ih3xJaXQbIE83w06j0PYNLbidpPo6W4/PjwpDYNCmj6qhwzENO/CjU4h21W1
	 bBH9Vu+ZugsS550igy4H9zVrKaZyRYU7tBsHEzJ0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231108082651eucas1p2c4f8104c585a909712d9bda5c0a07e4e~VmGkcUxwv1343713437eucas1p2L;
	Wed,  8 Nov 2023 08:26:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id C0.03.11320.B464B456; Wed,  8
	Nov 2023 08:26:51 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231108082650eucas1p112dd45481f2cea4037e10dd0f78b3b33~VmGj3dXLl2116521165eucas1p1e;
	Wed,  8 Nov 2023 08:26:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231108082650eusmtrp27043ee302523962dd6adc1db39206447~VmGj0u9lQ0509305093eusmtrp2U;
	Wed,  8 Nov 2023 08:26:50 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-5e-654b464b4a1d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 33.5D.10549.A464B456; Wed,  8
	Nov 2023 08:26:50 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231108082650eusmtip2bceb4048c302fc101d6873288cb4c03a~VmGjfQ1VV0818708187eusmtip2-;
	Wed,  8 Nov 2023 08:26:50 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 8 Nov 2023 08:26:49 +0000
Date: Wed, 8 Nov 2023 09:26:48 +0100
From: Joel Granados <j.granados@samsung.com>
To: Eric Biggers <ebiggers@kernel.org>
CC: Luis Chamberlain <mcgrof@kernel.org>, <willy@infradead.org>,
	<josh@joshtriplett.org>, Kees Cook <keescook@chromium.org>, David Howells
	<dhowells@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Benjamin LaHaise <bcrl@kvack.org>, Eric
	Biederman <ebiederm@xmission.com>, Trond Myklebust
	<trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck
	Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown
	<neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
	Anton Altaparmakov <anton@tuxera.com>, Namjae Jeon <linkinjeon@kernel.org>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, Joseph Qi
	<joseph.qi@linux.alibaba.com>, Iurii Zaikin <yzaikin@google.com>, "Theodore
 Y. Ts'o" <tytso@mit.edu>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick
 J. Wong" <djwong@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
	<coda@cs.cmu.edu>, <linux-cachefs@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-aio@kvack.org>, <linux-mm@kvack.org>, <linux-nfs@vger.kernel.org>,
	<linux-ntfs-dev@lists.sourceforge.net>, <ocfs2-devel@lists.linux.dev>,
	<fsverity@lists.linux.dev>, <linux-xfs@vger.kernel.org>,
	<codalist@telemann.coda.cs.cmu.edu>
Subject: Re: [PATCH 2/4] aio: Remove the now superfluous sentinel elements
 from ctl_table array
Message-ID: <20231108082648.nne6k2unowzhhg5m@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="qdy4sfallzzqrze5"
Content-Disposition: inline
In-Reply-To: <20231108034231.GB2482@sol.localdomain>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTf1CTdRzu++7d3gGNexkefp0a1wLKH2ERnd8uDEjTN/XI9LrOOKqdvAHF
	NtlYYHcUESQMUFghMLEtlKGAiBsh48cBQyB+nPzSnPzYKYIUkMjP48dkMV8s7/rveZ7P83zv
	ef74cln8UkLAjZBE0zKJKFLIccQrmhdvvHpg7wH6tf7+DairtBigJKMNR0Z9ORspV8pxNN44
	DVBP0wvINjiKofkSM4aqSx9iSJNv4KCHCcs46h12RraKRAJdrrGyUMqQjYPOZv+AoYL+FDZa
	1BURqPXGPI4u6RYIZNNKUUeqGFUODuMo80wBC/18JgGgqQttBKqpbV19rCqPgywlNjbqqm9n
	o5PJeQBVWSsJlJqZTSBzxghAtZp4HJkst9go4VwdG7UttWHIZvZHSWmLBOp83MJGywurj+iM
	QQHbqLPx3TilvX6QGuk+TF25o+JQRvUgQWn1CspqukpQhotbqb7xXZS+KIVD6adVBGW89xb1
	pyEXUNXaGYxK6GhiUTnTs5xDgk8c/ULpyIivadmOdz53DO98dJk4fsc9tqhpmBMPcgVK4MCF
	pC9szLuKK4Ejl09eBHClU8VhyCyAy/VZGENmADQOqPCnkeGSkTVXIYAZjefZ/7qS1SlrxADg
	qK6HsEdw0gOeyukBdswht8POiQGWEnC560gv2Fzwgd3PIg1OUDnUgNl1V1IENQ1edjuP3AlH
	cjIJBrvA1tzhJy1YZCysUC2x7XYWuREWrnDtssNqub4LZYApKoRzE+lsBsfBtvK+J2sgedsJ
	an6fYDGHPVAzdh9jsCscayknGLwJ2oyatcBPANatPCIYUgyg7vu5tcTbMPHm8FoiEGYqT+P2
	RpB0hua/XZiizlBVkc1iZB5M/pHPuL1gsWUCzwAvqZ+Zpn5mmvq/aYy8HWqrpzn/k7dB3a/j
	LAbvgqWlk7gWEEVgPa2Qi8NouY+EjvGWi8RyhSTM+5hUrAer36h9pWW2EhSOTXmbAMYFJuCx
	Gh4qK+4CAlwildDCdbzH/hTN54WKTnxDy6SfyRSRtNwENnJx4XqeZ6g7zSfDRNH0VzR9nJY9
	vWJcB0E8ZkgX7pXetWzYUXbkoNuHLwe4djxI+CVIEXX92LniQ6Z7IaalgORRd0n20dQp979C
	90U1u4z+oUmq3/+cb+t9hWmuN+5LrOZ06Amxnvfubr/iEMkRtW/EYa3fkvANeqT9TYnYrXYm
	2vnSHvM+n/mGsOUVT6fN7dK+nUPBSc13358LnJRbv9is6tnS2a8dS/z2vMLtRfBA+tHkplf2
	O81mhXl8pwytjuHnx3QHX8uzDqRmnYoNPLnQULDbxzf+Y92n4/lRHK9bgvEC/zqx52zaleW4
	wOcn0oIWZFaLf0BIekbVTcw7q22LydzdS4f/VmRlW5oypyyuVjLGcNTU/J4VWINvXxPi8nDR
	61tZMrnoH1QLzKDBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0xTVxzHPbe3vQXDuLQYj51OVp3bYBbKy1MG6LJsu6JjBF1iXAg2cgdE
	aKGloMYZVsRRQCKPABaEagS1vKRlrEVUZDwGGEEWZn3QbUJ1ikN5jPHuWuoyk/33zff3+37O
	73dyDpvB6WHx2PGSFFomESfwWc5433K3eWvYp7toH0OdLxqorwEo02jFkVHXxETZy004Gvtx
	EqDBzreQdfgJhmZqTRi6Wj+OocrzehYaVy7g6OfRN5C1+QSB6loXGUj1yMpCZSUZGKp6oGKi
	uWotgXpuz+DocvUsgawaKbqVk4gMw6M4yi+uYqCiYiVAExd6CdR6rccGaylnIXOtlYkG2vqY
	6LuscoBaFg0EyskvIZDptAWga5XpOGo3DzGR8uwNJuqd78WQ1bQdZebOEah/qZuJFmZtkGpj
	+A4vqiz9Dk5pOnZTljuRVMO9AhZlVA8TlEanoBbbGwlKf8mTuj8WQum0KhalmywgKOPvIuoP
	/RlAXdVMYZTyVieDKp2cZkXw9guCZVJFCu0RJ5WnhPC/EiJfgVCEBL7+IoHQb1tUkG8A3zs0
	OIZOiE+lZd6hBwRxyzmnmEl3Nx5W/d2ApYMSXjZwYkPSH47WWljZwJnNIasA1H1fjTkK62Hj
	9BDToblw8ZfsV00TAJqG5nF7gUPqAeycW2fXOLkZ5pUOArtmkR/A/ucPGdmAzXYnt8Cuqi/s
	WQapXw2LfjWu+FxSDCtvbrG3u5DboKU0n3Dwz2KwOeMu01Fwgz1nRlfOYpCpMP1b5UqWQb4J
	Ly6z7baTbYH7F64Ax5x8+NfzU69m/gZOLT0GpwFX/RpJ/RpJ/R/JYXtC0/JT7H+2F6w+N8Zw
	6BBYX/8C1wBCC9xphTwxNlEuFMjFiXKFJFZwUJqoA7Z33Nw1pzeAimcTgnaAsUE72GxLPrpS
	MwB4uEQqofnuLkvbKZrjEiM+cpSWSaNligRa3g4CbJeYz+CtOSi1fQpJSrQw0CdA6B8o8gkQ
	Bfrx17rsTMoSc8hYcQp9iKaTaNm/OYztxEvHvvYAnL2d7yZ8PpKX25hQyJvXYHuvB1uoxfLZ
	ix/HHFp1buFGcv9xXZv8oyepvVFfDiZ/MjuvXiq7PCdd3xrJyezymzcc1lpUPwwfD9og2bP/
	3nR3UZvZ7bdVq28a1GkROx5jL7m9Xmk7+8K2RnwWzPEuHOBSFQXBD7oD9l13mQqJP2pqfP/k
	UyeqheVKKVzXfRgzHZ3n5he057bzO8SSJHpDUfhu9oJ6xjUW+QX1c8OPZYQfyHJ/+Oz8e3Vr
	Rio2mSnE6RvpmDkCJ4c8IlXKtfvM6pqXUdrOnpywE2k+2tym1LcVG0OLO06q8/9six3nYsf6
	LmWBZFEDapQqXuhyfirk4/I4sdCTIZOL/wENyV5RXAQAAA==
X-CMS-MailID: 20231108082650eucas1p112dd45481f2cea4037e10dd0f78b3b33
X-Msg-Generator: CA
X-RootMTR: 20231108034239eucas1p2e5dacae548e47694184df217ee168da9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231108034239eucas1p2e5dacae548e47694184df217ee168da9
References: <20231107-jag-sysctl_remove_empty_elem_fs-v1-0-7176632fea9f@samsung.com>
	<20231107-jag-sysctl_remove_empty_elem_fs-v1-2-7176632fea9f@samsung.com>
	<CGME20231108034239eucas1p2e5dacae548e47694184df217ee168da9@eucas1p2.samsung.com>
	<20231108034231.GB2482@sol.localdomain>

--qdy4sfallzzqrze5
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 07:42:31PM -0800, Eric Biggers wrote:
> On Tue, Nov 07, 2023 at 02:44:21PM +0100, Joel Granados via B4 Relay wrot=
e:
> > [PATCH 2/4] aio: Remove the now superfluous sentinel elements from ctl_=
table array
>=20
> The commit prefix should be "fs:".
Will do

>=20
> > Remove sentinel elements ctl_table struct. Special attention was placed=
 in
> > making sure that an empty directory for fs/verity was created when
> > CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not defined. In this case we use=
 the
> > register sysctl call that expects a size.
> [...]
> > diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> > index d071a6e32581..8191bf7ad706 100644
> > --- a/fs/verity/fsverity_private.h
> > +++ b/fs/verity/fsverity_private.h
> > @@ -122,8 +122,8 @@ void __init fsverity_init_info_cache(void);
> > =20
> >  /* signature.c */
> > =20
> > -#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> >  extern int fsverity_require_signatures;
> > +#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> >  int fsverity_verify_signature(const struct fsverity_info *vi,
> >  			      const u8 *signature, size_t sig_size);
> > =20
> > diff --git a/fs/verity/init.c b/fs/verity/init.c
> > index a29f062f6047..e31045dd4f6c 100644
> > --- a/fs/verity/init.c
> > +++ b/fs/verity/init.c
> > @@ -13,7 +13,6 @@
> >  static struct ctl_table_header *fsverity_sysctl_header;
> > =20
> >  static struct ctl_table fsverity_sysctl_table[] =3D {
> > -#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> >  	{
> >  		.procname       =3D "require_signatures",
> >  		.data           =3D &fsverity_require_signatures,
> > @@ -23,14 +22,17 @@ static struct ctl_table fsverity_sysctl_table[] =3D=
 {
> >  		.extra1         =3D SYSCTL_ZERO,
> >  		.extra2         =3D SYSCTL_ONE,
> >  	},
> > -#endif
> > -	{ }
> >  };
> > =20
> >  static void __init fsverity_init_sysctl(void)
> >  {
> > +#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> >  	fsverity_sysctl_header =3D register_sysctl("fs/verity",
> >  						 fsverity_sysctl_table);
> > +#else
> > +	fsverity_sysctl_header =3D register_sysctl_sz("fs/verity",
> > +						 fsverity_sysctl_table, 0);
> > +#endif
> >  	if (!fsverity_sysctl_header)
> >  		panic("fsverity sysctl registration failed");
>=20
> This does not make sense, and it causes a build error when CONFIG_FS_VERI=
TY=3Dy
> and CONFIG_FS_VERITY_BUILTIN_SIGNATURES=3Dn.
>=20
> I think all you need to do is delete the sentinel element, the same as
> everywhere else.  I just tested it, and it works fine.
Indeed. good catch and thx for testing. I'll adjust it on my V2.

>=20
> BTW, the comments for register_sysctl_sz() and __register_sysctl_table() =
are
> outdated, as they still say "A completely 0 filled entry terminates the t=
able."
For now this is still "technically" correct. However, this will be
removed on the last patchset when we actually delete the check for the
sentinel element.
For now I'll leave it like it is, but I'll double check to make sure
that I remove it at the end.

Best
>=20
> - Eric

--=20

Joel Granados

--qdy4sfallzzqrze5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVLRjsACgkQupfNUreW
QU/+QQv+JAZ2egwDryj1fBPctk+jcFkv5AFT95mMW0Hy10yYejq2clAC6/4VpFPL
Zw7EKmOW7gx/ZH4lLvjKbK0w9MZyUigYGBml+WQjyHoVFnm9Lij3PZ2nUEbZHMbC
xYYt3TfWlMd9EKSsZu248QyT1QYUqdVsPadtMciHeLOHJUKwbq16BUgkIQ2uL7yw
+rNN7XjYxwwdHhOdOW9+CaqzKkTTxYm3jwCUB1g/Lb01yhky+pgOlnKSGRj11WSo
mVOSdQmMiN90KkTYfqF8pXi7snELIRo6Bjfp2v3pa6ea6DFkj4IA8Eh0SMu9eDOL
yffPi1tzs7GHx87Rz4Xw3HL+PGsKwE5jVh+WI/NOR3ECMieTEHyeBP0b6CctG1Qz
Y1cX1rzSae8Y+NfQ/uML6S+L6d++SbVUuNFim3hAslWjQzSfp6OxsD/3YJpQvWNU
H6yInkAYVBv9kXJdpylR0tiRthbrKul+NEjL1/FvJVi2460ZC3QzEThsT/wNhLJ2
cXMro6Zk
=sgbZ
-----END PGP SIGNATURE-----

--qdy4sfallzzqrze5--

