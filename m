Return-Path: <linux-fsdevel+bounces-6824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4EF81D3F4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 13:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3F22838D8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 12:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA34CD265;
	Sat, 23 Dec 2023 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jYW5N5cz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76328DF6E;
	Sat, 23 Dec 2023 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231223120913euoutp01e45e30867db386b6d66da064199d8f73~jdKj79Zjk1577115771euoutp01B;
	Sat, 23 Dec 2023 12:09:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231223120913euoutp01e45e30867db386b6d66da064199d8f73~jdKj79Zjk1577115771euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703333353;
	bh=xpy0HiagjRFRHGaHNhA86jcAbAONjlu60zMifziYNVQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=jYW5N5czuo1qsVyn7ywk+i4nBKlVNz8xQKf4nsby+llHeE35Fn55X2ruvtnUFO0zD
	 pkzdOaDjws4XffJ/MQCyhgtsd/4DDSAUkNduBgJDduRQ7OTKsdcGBmrkyC0kh5HB7s
	 DRXSXysXQFaovjJQ0WYfu8Z3O7k67d6tWcv1fbiU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231223120912eucas1p2d42d5d0317e3cc82b29b33ae42a2da90~jdKjqiHGh0092900929eucas1p2t;
	Sat, 23 Dec 2023 12:09:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id A5.53.09552.8EDC6856; Sat, 23
	Dec 2023 12:09:12 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231223120911eucas1p20908d9c95be9c8f0f352e7e93a5523fc~jdKij7a9S0092900929eucas1p2s;
	Sat, 23 Dec 2023 12:09:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231223120911eusmtrp236ab81812bad979b4088006597842e0a~jdKijZ2rH1783217832eusmtrp2l;
	Sat, 23 Dec 2023 12:09:11 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-f6-6586cde8786a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 58.DC.09146.7EDC6856; Sat, 23
	Dec 2023 12:09:11 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231223120911eusmtip10f7abb041dfce2d08c77559d1e0960b9~jdKiYbb7d0460404604eusmtip1C;
	Sat, 23 Dec 2023 12:09:11 +0000 (GMT)
Received: from localhost (106.210.248.246) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sat, 23 Dec 2023 12:09:10 +0000
Date: Thu, 21 Dec 2023 13:44:21 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Julia Lawall
	<julia.lawall@inria.fr>, Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook
	<keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Iurii Zaikin <yzaikin@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-hardening@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <20231221124421.6zil5v3nhiidw2a7@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="3r5c7qeptsstdq2m"
Content-Disposition: inline
In-Reply-To: <a0d96e7b-544f-42d5-b8da-85bc4ca087a9@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7djPc7ovzralGrz+ZGjxYV4ru0Xz4vVs
	Fr8uTmO1aFrVz2xxpjvXYs/ekywW89b/ZLS4vGsOm8XvH8+YLG5MeMposWynnwO3x+yGiywe
	CzaVekx6cYjFY9OqTjaPO9f2sHnsn7uG3ePzJjmP/u5j7AEcUVw2Kak5mWWpRfp2CVwZE46s
	Zym4J1xx6sh75gbG7wJdjJwcEgImEvOn3GbqYuTiEBJYwSix5/F9VpCEkMAXRollf6ESnxkl
	Nj6czA7TMfncXxaIxHJGiU37LrLCVX37tQAqs5VRYtKaZ0wgLSwCqhITNp4Ds9kEdCTOv7nD
	DGKLCNhIrPz2mR2kgVmgh1li98KfjF2MHBzCAg4S25okQUxeAXOJzuOqIOW8AoISJ2c+YQGx
	mQUqJE4dughWzSwgLbH8HwdImBNo4trnU1kgDlWWuPnrHTOEXStxasstsG8kBE5xSqzb8IYV
	IuEicWvTRqgGYYlXx7dAfSkj8X/nfKiGyYwS+/99YIdwVgPDpfErE0SVtUTLlSdQHY4Sc7Y+
	ZgK5SEKAT+LGW0GIQ/kkJm2bzgwR5pXoaBOCqFaTWH3vDcsERuVZSF6bheS1WQivQYT1JG5M
	ncKGIawtsWzha2YI21Zi3br3LAsY2VcxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEpsLT
	/45/3cG44tVHvUOMTByMhxhVgJofbVh9gVGKJS8/L1VJhDdfpyVViDclsbIqtSg/vqg0J7X4
	EKM0B4uSOK9qinyqkEB6YklqdmpqQWoRTJaJg1OqgWnW1eUHhWtZNnhM8Vg2M9GypSxOeZLC
	jtqI2e/CnkSpfHw1f3GpR7SyCMdx28zgm+XeSuXXblp8ljq2/vPrhpiCFOXPhmLitSl/p9zd
	sDNU/455krTsOSlnjk9389Ytj/7DKCj44d1H8wzOdoOtM+K0g9TiwpaL3n/ZcD+wr/zZh6pP
	utlyaW7Xj6lviU1//9n9Y/TLz4p6agtOzJU6GH4iuFDDwLn6b2ZGdvzi43OW53zcdvP051vL
	Jp5fa9tsm3lv7ZXfqbe6c9sMZiS3TfrprHVrH/MJo5M3tmS6RfEtvvv0gMB93wfvSg4rTz2U
	zD97x4rGzQpt+/i/GS2vevJmR8arY30zLoe91Tn9z+CpEktxRqKhFnNRcSIAYtFzkgAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42I5/e/4Xd3nZ9tSDW50qlt8mNfKbtG8eD2b
	xa+L01gtmlb1M1uc6c612LP3JIvFvPU/GS0u75rDZvH7xzMmixsTnjJaLNvp58DtMbvhIovH
	gk2lHpNeHGLx2LSqk83jzrU9bB77565h9/i8Sc6jv/sYewBHlJ5NUX5pSapCRn5xia1StKGF
	kZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GhfdH2QruCFe0dj1gamD8KtDFyMkh
	IWAiMfncX5YuRi4OIYGljBK9q+4zQyRkJDZ+ucoKYQtL/LnWxQZR9JFRonP2U1YIZyujxOkv
	u9hBqlgEVCUmbDzHBGKzCehInH9zB2ySiICNxMpvn9lBGpgFepglXq+/BJTg4BAWcJDY1iQJ
	YvIKmEt0HleFmNnOIvHt8kuwXl4BQYmTM5+wgNjMAmUS008uZwOpZxaQllj+jwMkzAk0fu3z
	qSwQhypL3Pz1DuqBWonPf58xTmAUnoVk0iwkk2YhTIII60js3HoHU1hbYtnC18wQtq3EunXv
	WRYwsq9iFEktLc5Nzy021CtOzC0uzUvXS87P3cQITAjbjv3cvINx3quPeocYmTgYDzGqAHU+
	2rD6AqMUS15+XqqSCG++TkuqEG9KYmVValF+fFFpTmrxIUZTYCBOZJYSTc4Hpqq8knhDMwNT
	QxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQYm3aRJ6leYWDtesO42XRjFpJnx
	w/ae/yqWWm+h88lbVXea7FNomTP3X6m7kvmmrjLucm/miiNMDyxCAi2mRtXcYOjQjT5xLKLq
	wwHR8E+GT5L5Smo+v4+b8KA1tWHSe+8VE72ijq9b4bloq87RkuCeqKirq+eXrBVL8dv9zPap
	9ZPoQr8TO+7XbC2zYolVO1VYLeFYpP165dKZEaKmh3Yfnadrau+bNrdx+uzmVTN/nfdJlciY
	ZJHLvaihS/nnpIZ9n45E5W2/PUvlyN+++2GFWpv/9lp7Z17dp9a794Xly/AjU6IFZVuuuB+U
	erx5kaeeCWtsQM+b65OfRvIIHItq9hFQ2vGD23ln6oVXT5YqsRRnJBpqMRcVJwIAx5lmPJ0D
	AAA=
X-CMS-MailID: 20231223120911eucas1p20908d9c95be9c8f0f352e7e93a5523fc
X-Msg-Generator: CA
X-RootMTR: 20231219192958eucas1p2df4e393960bce2bb5e8e93395f1eee8e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231219192958eucas1p2df4e393960bce2bb5e8e93395f1eee8e
References: <fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de>
	<20231208095926.aavsjrtqbb5rygmb@localhost>
	<8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de>
	<20231212090930.y4omk62wenxgo5by@localhost>
	<ZXligolK0ekZ+Zuf@bombadil.infradead.org>
	<20231217120201.z4gr3ksjd4ai2nlk@localhost>
	<908dc370-7cf6-4b2b-b7c9-066779bc48eb@t-8ch.de>
	<ZYC37Vco1p4vD8ji@bombadil.infradead.org>
	<CGME20231219192958eucas1p2df4e393960bce2bb5e8e93395f1eee8e@eucas1p2.samsung.com>
	<a0d96e7b-544f-42d5-b8da-85bc4ca087a9@t-8ch.de>

--3r5c7qeptsstdq2m
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 08:29:50PM +0100, Thomas Wei=DFschuh wrote:
> Hi Luis and Julia,
>=20
> (Julia, there is a question and context for you inline, marked with your =
name)
>=20
> On 2023-12-18 13:21:49-0800, Luis Chamberlain wrote:
> > So we can split this up concentually in two:
> >=20
> >  * constificaiton of the table handlers
> >  * constification of the table struct itself
<--- snip --->
> > case but to any place in the kernel where this previously has been done
> > before, and hence my suggestion that this seems like a sensible thing
> > to think over to see if we could generalize.
>=20
> I'd like to split the series and submit the part up until and including
> the constification of arguments first and on its own.
> It keeps the subsystem maintainers out of the discussion of the core
> sysctl changes.
quick comment : Note that if this contains the tree-wide patches, it
will inevitably bring in the rest of the maintainers.

>=20
> I'll submit the core sysctl changes after I figure out proper responses
> to all review comments and we can do this in parallel to the tree-wide
> preparation.
>=20
> What do you think Luis and Joel?
Separating all this into patch series that have a defined motivation and
that are self contained is the way to go IMO.

Best
>=20
> [0] https://protect2.fireeye.com/v1/url?k=3D0ddcce36-6d3e536b-0ddd4579-00=
0babd9f1ba-c68841e97c452963&q=3D1&e=3Dd70f9b65-8465-4489-b777-b13eb1ffc99b&=
u=3Dhttps%3A%2F%2Frepo.or.cz%2Fsmatch.git%2Fblob%2FHEAD%3A%2Fsmatch_scripts=
%2Ftest_kernel.sh

--=20

Joel Granados

--3r5c7qeptsstdq2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmWEMyUACgkQupfNUreW
QU+rzgv+J8nF9QAA9UReTxQLhqfaoNE/+chhxBzuTnzY3yAd4cc1353RvYBveDZ9
PL7BAvZxB+cvojI2JzJ3ATKrvh3RryMjqckzjRgbKPk6aDNmXoE2SFJQqw1Is1jG
c1mMMSWBunC6xjlUygMmBdGUMLoxGEPIpXbnPl0ecsk6xqENOjipjQCBhOm/4Coo
2VjGpAApEMujTg+cejAUjkaiEmznH58t2Y1aVz59UjS3b+W3E4bgwt1QTQkRkGuv
f1JSUiZjX0SopSgu/eD6dVBNQC4YzBNPYkqBMT2agV0HqqGzDrmVwqy4vuAuob6+
z+68u39vqojRrfbLpNrZTTc5u6f6iMFwhiB16RjkaAzCr6Nesks2zP9UOwBwDRBz
TIXsw8wYuv1uT0HbjuLopIhqdXM6zVpnmUPeJpOf0TyhqdSFZMU2t/8I82mMbrJ/
wG6Pa3l+s1qjNwDgO99kyRzQgDzYmqHCMQ42u2JsztsNt3Cv7Qmn/QEM+08O135J
n3vu5w4U
=uPzz
-----END PGP SIGNATURE-----

--3r5c7qeptsstdq2m--

