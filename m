Return-Path: <linux-fsdevel+bounces-6822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5154181D3F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 13:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1BE11F22199
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 12:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E23ADDBE;
	Sat, 23 Dec 2023 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bYzsdHL/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F10D50C;
	Sat, 23 Dec 2023 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231223120909euoutp02e781f7d563a28945cc1ff750cc8257ce~jdKgt2m0K2296122961euoutp02N;
	Sat, 23 Dec 2023 12:09:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231223120909euoutp02e781f7d563a28945cc1ff750cc8257ce~jdKgt2m0K2296122961euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703333349;
	bh=BSmVJXzK146D6e0cSRYQv6lHfyjSf2ksmoUZb9q3Mik=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bYzsdHL/x9bYs41wKBEkx/WyiOnst6iGklk/LE7JSjAXLL68cQ9UfZFat2Ban1cC8
	 TBICcR4xzS/DkVBEwIXCmGvzn0frhfeVhAE4IAHK/U4MOw369gkMCOcrzzTAKjkXFy
	 PQrxu2PJAZ/3YFOW5cyq3ZGraA/nmIpIFYHTUQTk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231223120908eucas1p2f36fd9d33d025fd0a8284c6e2d62ec2d~jdKfXcaWy2664726647eucas1p22;
	Sat, 23 Dec 2023 12:09:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 0C.29.09814.4EDC6856; Sat, 23
	Dec 2023 12:09:08 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231223120907eucas1p20afac63076e1e9d5aee6adaa101c0630~jdKeRjoRP0116901169eucas1p2d;
	Sat, 23 Dec 2023 12:09:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231223120907eusmtrp23c65487912263030f1e4c786f5bb002e~jdKeQ-Urr1757817578eusmtrp2m;
	Sat, 23 Dec 2023 12:09:07 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-a0-6586cde4fe93
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 97.DC.09146.2EDC6856; Sat, 23
	Dec 2023 12:09:06 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231223120906eusmtip2663a12c2cd2cdb40860a0a616d503b1c~jdKeD4U6-3146931469eusmtip2f;
	Sat, 23 Dec 2023 12:09:06 +0000 (GMT)
Received: from localhost (106.210.248.246) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sat, 23 Dec 2023 12:09:05 +0000
Date: Thu, 21 Dec 2023 13:36:44 +0100
From: Joel Granados <j.granados@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Dan Carpenter
	<dan.carpenter@linaro.org>, Julia Lawall <julia.lawall@inria.fr>, Kees Cook
	<keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Iurii Zaikin <yzaikin@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-hardening@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <20231221123644.k57uvfmpcrfo4vfk@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="brxurlnbrxj2ydht"
Content-Disposition: inline
In-Reply-To: <ZYC37Vco1p4vD8ji@bombadil.infradead.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7djPc7pPzralGtzcz2vxYV4ru0Xz4vVs
	Fr8uTmO1aFrVz2xxpjvXYs/ekywW89b/ZLS4vGsOm8XvH8+YLG5MeMposWynnwO3x+yGiywe
	CzaVekx6cYjFY9OqTjaPO9f2sHnsn7uG3ePzJjmP/u5j7AEcUVw2Kak5mWWpRfp2CVwZX59t
	ZyqYJldxYvdntgbG1xJdjJwcEgImEm33+xm7GLk4hARWMEq86T/FDOF8YZSYOrMdKvOZUeLv
	rNPsMC3HFzazQiSWM0rcnfORHa7q+5kZUC1bGSX+tU4Da2ERUJWYsG8BM4jNJqAjcf7NHTBb
	REBDYt+EXiaQBmaBBcwSVx7tY+li5OAQFnCQ2NYkCVLDK2Au8WbLA1YIW1Di5MwnLCA2s0CF
	xNaWfewg5cwC0hLL/3GAhDkFzCQevtvGCHGpssTNX++YIexaiVNbboGtkhA4zCnRtPIXC0TC
	RaLtYxsbhC0s8er4Fqg3ZST+75wP1TCZUWL/vw/sEM5qRolljV+ZIKqsJVquPIHqcJSYsuMm
	M8hFEgJ8EjfeCkIcyicxadt0qDCvREebEES1msTqe29YJjAqz0Ly2iwkr81CeA0irCdxY+oU
	NgxhbYllC18zQ9i2EuvWvWdZwMi+ilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzAdnv53
	/MsOxuWvPuodYmTiYDzEqALU/GjD6guMUix5+XmpSiK8+TotqUK8KYmVValF+fFFpTmpxYcY
	pTlYlMR5VVPkU4UE0hNLUrNTUwtSi2CyTBycUg1MtqqXbtUHq/85PCF0g5nxjy8pq6ddMxTR
	d+haViaTem/BIlcj1TUnD36O/mS4T005Xkp+ujH/lWS5KZsOG6Q0zXw0Y8059fZz3EuDFgu8
	X78rO9yfyyNzs/BGxrkRjs+XC1i3hzUfWGsss/rSSiNFlZDlNW4Jm9oeZ+5Qil67SVSvdGU9
	r49WyvaQrMsh72YavrQtsxXySWrkPF1z/miiXtVxwxcmRUf9nAv7VPcxbQj8Hbshnz1b2Etz
	Zp2eOPc/ty8X4mruLq7tnFh9Qtcmb+/tdQskDhucX7su8lFWALfjies2bU9DIk98Onv9cUNr
	2fctOzleCf94fsjULulk+6nHiyN0OH24D2mwne5SYinOSDTUYi4qTgQA0mdpSAIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42I5/e/4Pd1HZ9tSDf6xWHyY18pu0bx4PZvF
	r4vTWC2aVvUzW5zpzrXYs/cki8W89T8ZLS7vmsNm8fvHMyaLGxOeMlos2+nnwO0xu+Eii8eC
	TaUek14cYvHYtKqTzePOtT1sHvvnrmH3+LxJzqO/+xh7AEeUnk1RfmlJqkJGfnGJrVK0oYWR
	nqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbkE8fZC6bIVVzu0WxgfCnRxcjJISFg
	InF8YTNrFyMXh5DAUkaJx3O+sEMkZCQ2frnKCmELS/y51sUGUfSRUeLujeXMEM5WRokT37ay
	gVSxCKhKTNi3gBnEZhPQkTj/5g6YLSKgIbFvQi8TiM0ssIBZYsbC8C5GDg5hAQeJbU2SIGFe
	AXOJN1seQF3xilni/ZZZjBAJQYmTM5+wgNQzC5RJzP0jA2FKSyz/xwFSwSlgJvHw3TZGiDuV
	JW7+escMYddKfP77jHECo/AsJINmIQyahTBoFthpOhI7t95hwxDWlli28DUzhG0rsW7de5YF
	jOyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAhPBtmM/N+9gnPfqo94hRiYOxkOMKkCdjzas
	vsAoxZKXn5eqJMKbr9OSKsSbklhZlVqUH19UmpNafIjRFBiEE5mlRJPzgSkqryTe0MzA1NDE
	zNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qB6ci36sp7blNLuO4ssWOb6XpyU45i
	+KsM1oITh62cP5VObpvzTfnq0WN/StmmW0o8tD578+QNzwwDkexFBaVn/vGxXZx9yvbP3kma
	Ykt2XzuduGHm17OZUme6trvf2XiDl1m8MbHcSdKp7Pyn/yIyNxneu4YsUrK6dMwlTXo9U0W6
	7o2rKcyOfrm1+zQt1olbVDX/antzmf9vZ7BAUWHWiUOJKW+S5zSmHcyZMEsmruN9v12xy7eJ
	W+8vMdG51HOlK3eh5q62yZoCCq3cqg4fjObfe+gTuO5DBevl3kvLbZW3GFk0PJBTnF53VuST
	vtGbc6XJxq9azmjOjXr0ojivhSmC79K9R1IB1mFHa1M9lFiKMxINtZiLihMBOJdHYpkDAAA=
X-CMS-MailID: 20231223120907eucas1p20afac63076e1e9d5aee6adaa101c0630
X-Msg-Generator: CA
X-RootMTR: 20231223120907eucas1p20afac63076e1e9d5aee6adaa101c0630
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231223120907eucas1p20afac63076e1e9d5aee6adaa101c0630
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
	<20231207104357.kndqvzkhxqkwkkjo@localhost>
	<fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de>
	<20231208095926.aavsjrtqbb5rygmb@localhost>
	<8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de>
	<20231212090930.y4omk62wenxgo5by@localhost>
	<ZXligolK0ekZ+Zuf@bombadil.infradead.org>
	<20231217120201.z4gr3ksjd4ai2nlk@localhost>
	<908dc370-7cf6-4b2b-b7c9-066779bc48eb@t-8ch.de>
	<ZYC37Vco1p4vD8ji@bombadil.infradead.org>
	<CGME20231223120907eucas1p20afac63076e1e9d5aee6adaa101c0630@eucas1p2.samsung.com>

--brxurlnbrxj2ydht
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 01:21:49PM -0800, Luis Chamberlain wrote:
> So we can split this up concentually in two:
>=20
>  * constificaiton of the table handlers
>  * constification of the table struct itself
>=20
> On Sun, Dec 17, 2023 at 11:10:15PM +0100, Thomas Wei=DFschuh wrote:
> > The handlers can already be made const as shown in this series,
>=20
> The series did already produce issues with some builds, and so
> Julia's point is confirmed that the series only proves hanlders
> which you did build and for which 0-day has coverage for.
>=20
> The challenge here was to see if we could draw up a test case
> that would prove this without build tests, and what occurred to
> me was coccinelle or smatch.
>=20
> > > If that is indeed what you are proposing, you might not even need the
> > > un-register step as all the mutability that I have seen occurs before
> > > the register. So maybe instead of re-registering it, you can so a copy
> > > (of the changed ctl_table) to a const pointer and then pass that along
> > > to the register function.
> >=20
> > Tables that are modified, but *not* through the handler, would crop
> > during the constification of the table structs.
> > Which should be a second step.
>=20
> Instead of "croping up" at build time again, I wonder if we can do
> better with coccinelle / smatch.
>=20
> Joel, and yes, what you described is what I was suggesting, that is to
> avoid having to add a non-const handler a first step, instead we modify
> those callers which do require to modify the table by first a
> deregistration and later a registration. In fact to make this even
> easier a new call would be nice so to aslo be able to git grep when
> this is done in the kernel.
>=20
> But if what you suggest is true that there are no registrations which
> later modify the table, we don't need that. It is the uncertainty that
> we might have that this is a true statment that I wanted to challenge
> to see if we could do better. Can we avoid this being a stupid
> regression later by doing code analysis with coccinelle / smatch?
That would be amazing! Having an analysis (coccinelle or smatch) that
prevents the regression would be the cherry on top.

So to further clarify: what you propose is an additional patch in the
series that adds this regression prevention.
Or do you want a general analysis that prevents changing a variable
variable that was defined as const.

>=20
> The template of the above endeavor seems useful not only to this use
> case but to any place in the kernel where this previously has been done
> before, and hence my suggestion that this seems like a sensible thing
> to think over to see if we could generalize.
A generalized analysis for inadvertent de-constification would be great.
It would point to places where we need remove the const qualifier or add
it.

>=20
>   Luis

--=20

Joel Granados

--brxurlnbrxj2ydht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmWEMU4ACgkQupfNUreW
QU+gqQv/cDd/9us9hD8vyW098KoGCIcBbMRHiVL+SKCPxwm/2uurRVr0kwyaAAXz
WczZRYjOMTCBV35W7pqe4TvsE22QmSua+NcttmkNEU1gH+Yxy/fWSp5so7FQ2EO9
Z6NMYBYwntja/Mz/sOfPBbLBn3SILLfudVKBA5AA5OjqN6hqvnKQyIvFLqXpOcPK
weKWk7iq7n7Zht/1mBqVNWG/lMONqurUPj3crYd0wbLY/FvPBCDKXX+bT12Xa2+A
FdBw40R26p8BrfK/zfMRcOCwMx9QLVGr+gN0gs7kryWuyiI+dhXvOvq7cSFskxfg
vRIuEWeMbO8JD1EWE399BlQrjzPmEtEzlBzDzTw25g3k8w89jw5YNLrU9cteGUO2
DVg2qQn4slGjTl9D3mxyFFJy1/F/pnsXK379F0qm8C5WQB0R/tmPlgxJB24mYsmL
A4ygA2gMG/gYGGkYdWx4E0r7eIod/n5JxMRuFl4n43U80fiDIhpedhSWYGWFPE9d
6zd+JFPc
=KObS
-----END PGP SIGNATURE-----

--brxurlnbrxj2ydht--

