Return-Path: <linux-fsdevel+bounces-6874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF10081DBFE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 19:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6168A281E54
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 18:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB109D535;
	Sun, 24 Dec 2023 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iPbb4Hd6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A91D281;
	Sun, 24 Dec 2023 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231224184446euoutp015ac5c80edaab85d6ed1b8d9e4ffc622a~j2NNx6Ghd2830328303euoutp01Q;
	Sun, 24 Dec 2023 18:44:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231224184446euoutp015ac5c80edaab85d6ed1b8d9e4ffc622a~j2NNx6Ghd2830328303euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703443486;
	bh=WmcNjH8U2O7BNNusUw4ykQSItiB592m8UIqj92lf+W0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=iPbb4Hd6pw1RSGqsW6WtdrVT4VM9L7kfZvNor26xAvM2Y3UjK5f3215Uf/pe+NENE
	 SDqcp2+9ab/DFwirsJbOJneN4oCRJgAFEczmqXeMpII7R9pLZ9xk2MrZaJM8c4sOcq
	 RKrNTZyGC0xqxfe538C8xdZGZANX0y/sfzk6nFK8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231224184445eucas1p1a2549dbccace8ee24aa67b0df4d00305~j2NMuzocw0250402504eucas1p10;
	Sun, 24 Dec 2023 18:44:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 82.1D.09814.D1C78856; Sun, 24
	Dec 2023 18:44:45 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231224184444eucas1p14bd6fff17d018ffc3a8f69c38ead0663~j2NMBygGh1881118811eucas1p1R;
	Sun, 24 Dec 2023 18:44:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231224184444eusmtrp1d600ecb75d207ef448e4b518e13a3f4c~j2NMBUQW81680216802eusmtrp1O;
	Sun, 24 Dec 2023 18:44:44 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-23-65887c1d6f87
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 68.53.09274.C1C78856; Sun, 24
	Dec 2023 18:44:44 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231224184444eusmtip1036607261462726616b94b2ddd7a608b~j2NL14pWb0070000700eusmtip1w;
	Sun, 24 Dec 2023 18:44:44 +0000 (GMT)
Received: from localhost (106.210.248.246) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sun, 24 Dec 2023 18:44:43 +0000
Date: Sat, 23 Dec 2023 14:12:24 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	Iurii Zaikin <yzaikin@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] sysctl: remove struct ctl_path
Message-ID: <20231223131224.phe54a3smekirek3@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="6e4yjwcz57irya7w"
Content-Disposition: inline
In-Reply-To: <20231220-sysctl-paths-v1-1-e123e3e704db@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87qyNR2pBidOylqc6c612LP3JIvF
	5V1z2Cx+/3jGZHFjwlNGi2U7/RzYPGY3XGTxWLCp1GPTqk42j8+b5Dz6u4+xB7BGcdmkpOZk
	lqUW6dslcGVsf32VuWC5UMXBC3uZGhh/83cxcnJICJhIvO9YxN7FyMUhJLCCUeLqmt/MEM4X
	Roljhz+yQDifGSXubNjBDNOyZHMLK0RiOaPEpVl7mOCqXsw6BdWylVHi6JTZrCAtLAKqEkdf
	XGYHsdkEdCTOv7kDNkpEwEZi5bfPYNuZBTYzSnyb8BtoFAeHsICxxPZ36SA1vALmEo/372aD
	sAUlTs58wgJiMwtUSPy8uIcNpJxZQFpi+T8OkDCngKtEQ+MVNohLlSVu/noHdXWtxKktt8AO
	lRCYzClxYs0cqCIXifbja5kgbGGJV8e3sEPYMhKnJ/ewQDUwSuz/94EdwlnNKLGs8StUh7VE
	y5UnUB2OEt0zbjKCXCQhwCdx460gxKF8EpO2TWeGCPNKdLQJQVSrSay+94ZlAqPyLCSvzULy
	2iyE1yDCehI3pk7BFNaWWLbwNTOEbSuxbt17lgWM7KsYxVNLi3PTU4uN8lLL9YoTc4tL89L1
	kvNzNzEC09fpf8e/7GBc/uqj3iFGJg7GQ4wqQM2PNqy+wCjFkpefl6okwiur2JEqxJuSWFmV
	WpQfX1Sak1p8iFGag0VJnFc1RT5VSCA9sSQ1OzW1ILUIJsvEwSnVwGTr87bPdWriX9c9G7nf
	dxi8n6z/Kkzo6xbRhdN3qXtZnyuT0V3tf+3dtehyWYEJDAlfQ4yt+ZJc//MUGmnnncv1tlt2
	YuZ9w67/3relui7GCdl9yWWZMEnk65fz0yrWV29zLGjdfPV7lseX06XX7cVl2n5W3Dn+jGdp
	2cPP1ikK25ddWrDJd1H7TbltP/YybfB5Uqayy2TJI616gz8v0uqnV7/wnhK2Ze2qIq16d5bl
	/9Q+uE1tqOlVurXtya/IBo/c5XMWiF4RtE9WECqOOj7ncYzjXl4+8ft5swVf8vpHyuU0tpx4
	vcfONHDRHDMHthNX6ti9d52b7qz8rGuOR4CIwb1UK1N7vV792V0lUUosxRmJhlrMRcWJAE1N
	KvHaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xu7oyNR2pBr/u6lmc6c612LP3JIvF
	5V1z2Cx+/3jGZHFjwlNGi2U7/RzYPGY3XGTxWLCp1GPTqk42j8+b5Dz6u4+xB7BG6dkU5ZeW
	pCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXs/XyPpWCpUMXf
	p49YGhh/8ncxcnJICJhILNncwgpiCwksZZTY/TERIi4jsfHLVVYIW1jiz7Uuti5GLqCaj4wS
	P++tZIdwtjJK/DlxlhGkikVAVeLoi8vsIDabgI7E+Td3mEFsEQEbiZXfPoM1MAtsZpT4NuE3
	UxcjB4ewgLHE9nfpIDW8AuYSj/fvhtowg1HizZuXjBAJQYmTM5+wgNjMAmUS8y6tZwTpZRaQ
	llj+jwMkzCngKtHQeIUN4lJliZu/3jFD2LUSn/8+Y5zAKDwLyaRZSCbNQpgEEdaR2Ln1DhuG
	sLbEsoWvmSFsW4l1696zLGBkX8UoklpanJueW2ykV5yYW1yal66XnJ+7iREYwduO/dyyg3Hl
	q496hxiZOBgPMaoAdT7asPoCoxRLXn5eqpIIr6xiR6oQb0piZVVqUX58UWlOavEhRlNgKE5k
	lhJNzgemlrySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqZtlTHy
	vh8/h/XMEQjbfP+p72sj98yajdv4DLojzm57p+NpGf5R5SZPVoawM0OR9gkXljmbl1o3/T5n
	nMsbZfpt34uZDyI+KjFq9s47v/I9Fzf3nCM6L3NKmLVnVMaHOnQcsWuR5p1d8Hf6kni+Mp1J
	e3JE1kxXaGn+L9A4UWp7UuGV9SuKdjCufTv3W5XQCedFa5fLdbWJlpwS3hdxiOnNg/lHDu66
	o/jvucm+PMkpR/6KdEx50/Cg8lDjlV+l3+YzfTspHtHltfmE+2upsiuRmzP3tS3TO/HM8cvT
	JrMz7qaVvHrCTxa8fGHR3qZnk5Nkwl4Y31iX3mNx9L7Fds9zJqnVvlfWuxi88t8jUqnEUpyR
	aKjFXFScCAC4eQKZdQMAAA==
X-CMS-MailID: 20231224184444eucas1p14bd6fff17d018ffc3a8f69c38ead0663
X-Msg-Generator: CA
X-RootMTR: 20231220212343eucas1p2f905cf62bec100412a4ecdabe8916619
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231220212343eucas1p2f905cf62bec100412a4ecdabe8916619
References: <CGME20231220212343eucas1p2f905cf62bec100412a4ecdabe8916619@eucas1p2.samsung.com>
	<20231220-sysctl-paths-v1-1-e123e3e704db@weissschuh.net>

--6e4yjwcz57irya7w
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 10:23:35PM +0100, Thomas Wei=DFschuh wrote:
> All usages of this struct have been removed from the kernel tree.
>=20
> The struct is still referenced by scripts/check-sysctl-docs but that
> script is broken anyways as it only supports the register_sysctl_paths()
> API and not the currently used register_sysctl() one.
>=20
> Fixes: 0199849acd07 ("sysctl: remove register_sysctl_paths()")
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
>  include/linux/sysctl.h | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 61b40ea81f4d..8084e9132833 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -210,11 +210,6 @@ struct ctl_table_root {
>  	int (*permissions)(struct ctl_table_header *head, struct ctl_table *tab=
le);
>  };
> =20
> -/* struct ctl_path describes where in the hierarchy a table is added */
> -struct ctl_path {
> -	const char *procname;
> -};
> -
>  #define register_sysctl(path, table)	\
>  	register_sysctl_sz(path, table, ARRAY_SIZE(table))
> =20
>=20
> ---
> base-commit: 1a44b0073b9235521280e19d963b6dfef7888f18
> change-id: 20231220-sysctl-paths-474697856a3f
>=20
> Best regards,
> --=20
> Thomas Wei=DFschuh <linux@weissschuh.net>
>=20

LGTM
Reviewed-by: Joel Granados <j.granados@samsung.com>

--=20

Joel Granados

--6e4yjwcz57irya7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmWG3K4ACgkQupfNUreW
QU/WVwv/TO2btpnDtp9v97DpO8pENbO9EQa2espWDa3fGysdCTiumu7W45gzF6s+
r/gf+iukRudvW0qf2AmS7RoHYy22cm2L3DkAyCrSA/wiJj3CQ5VDF6LoWDP+xMsW
pLWatMhJWeB3lO3h4ox4h1EN+XR55nzvmxo/RNupMp6MnUjbVa2Nk0PgqY+VGrZm
rPRHeFBBPgnZ8hTB8NhuCP4dQrMp9N1V/CxZY3+Qd5Pr3fCpvbnfYMj4KKLLyxSa
qvXYIN1GSY9VXkHt088ExRQWEKvxa9E0ifkw1gfEgQeFGcaU3S8wl9SfhabZcr72
ShRpbw1sdn3YiIvbY67nXbs+W1KLC+ORcXgPhMM8+Pb8lIHDoVNMNcRSWiIw0aRC
omJCv/sGe7edb9NMITU3IAFfJvtDQ1iL5xILHzhKueRqFT78Js3jfZa8ibH2gTPc
X582f/AC8ccQcoJwHaa1KZzPUe3sBgV+tjuJ+pfBO9jd17j2IXAhQoVaPB0Oribp
uuqU9bka
=w0Uf
-----END PGP SIGNATURE-----

--6e4yjwcz57irya7w--

