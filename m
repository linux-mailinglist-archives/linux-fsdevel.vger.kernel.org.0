Return-Path: <linux-fsdevel+bounces-5145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6138087CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 13:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC89B21481
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 12:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32E437D07
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pKSDTFZ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E98A10DF;
	Thu,  7 Dec 2023 03:23:26 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231207112325euoutp027a3fb34ac3039778584482f733e7de25~eiOAWlDOW0096800968euoutp02y;
	Thu,  7 Dec 2023 11:23:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231207112325euoutp027a3fb34ac3039778584482f733e7de25~eiOAWlDOW0096800968euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701948205;
	bh=mv2E/4ghW3Y614By89oI+rnRJ/EeSCDukuyif0pKhY4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=pKSDTFZ3/rIy3m9CeF5f6TFVZifRRljyHp/8x1U6uaJTUVVAE7dTrTJaMWTCyEGga
	 6st2LdETFYxT7dNjFoQOexZQhzys9Eq1b9Ho0crjnP3FYAmTCH+tuaoe6XM6eqm8sK
	 7jDSjLbHDjZdNXY3pSiPB+diZjc1h18uDB3YLdgU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231207112324eucas1p294e7836b2f95a621f5c5da4417fbd944~eiOAHv0101543615436eucas1p28;
	Thu,  7 Dec 2023 11:23:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 6D.1C.09814.C2BA1756; Thu,  7
	Dec 2023 11:23:24 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231207112324eucas1p2962efea55f2a1f49f6efb3b06fd1a582~eiN-e9jzy0304903049eucas1p29;
	Thu,  7 Dec 2023 11:23:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231207112324eusmtrp1ba25d583adfbb1f4832c2ef714986ac0~eiN-eNB2i2178921789eusmtrp1p;
	Thu,  7 Dec 2023 11:23:24 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-4b-6571ab2cba0b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id BD.36.09274.C2BA1756; Thu,  7
	Dec 2023 11:23:24 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231207112324eusmtip2d0ba42d1464b1fac01f073106bd847d0~eiN-Qu0pa0917909179eusmtip2-;
	Thu,  7 Dec 2023 11:23:24 +0000 (GMT)
Received: from localhost (106.210.248.38) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 7 Dec 2023 11:23:23 +0000
Date: Thu, 7 Dec 2023 12:23:22 +0100
From: Joel Granados <j.granados@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Kees Cook
	<keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Iurii Zaikin <yzaikin@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-hardening@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <20231207112322.uac2my3u4aafnxl2@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="2b7bopsuuvobq6c5"
Content-Disposition: inline
In-Reply-To: <ZW+juEWLSTybbujk@bombadil.infradead.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7djP87o6qwtTDVp+GFo0L17PZvHr4jRW
	izPduRZ79p5ksZi3/iejxeVdc9gsfv94xmRxY8JTRotlO/0cOD1mN1xk8ViwqdRj06pONo/9
	c9ewe3zeJOfR332MPYAtissmJTUnsyy1SN8ugSvj1OcT7AUHJCt+HPvD2sDYL9rFyMEhIWAi
	8exiQRcjF4eQwApGiVu7rrJBOF8YJc7vWcIM4XxmlFg37RE7TMfpB5kQ8eWMEneXL0Qo+vhw
	GiuEs5lRYu77U4xdjJwcLAIqEttm/WIDsdkEdCTOv7nDDGKLCGhI7JvQywTSwCxwjklixYnr
	rCArhAUcJLY1SYLU8AqYS7yZ9p0RwhaUODnzCQuIzSxQIXH+6ixGkHJmAWmJ5f84QMKcAmYS
	H9c9ZgWxJQSUJA5P/swMYddKnNpyC2yVhMB6TomNv/azQHzjIjGlIQqiRlji1fEt7BC2jMTp
	yT0sEPWTGSX2//vADuGsZpRY1viVCaLKWqLlyhOoDkeJBYdfsUIM5ZO48VYQ4k4+iUnbpjND
	hHklOtqEIKrVJFbfe8MygVF5FpLPZiH5bBbCZxBhPYkbU6ewYQhrSyxb+JoZwraVWLfuPcsC
	RvZVjOKppcW56anFRnmp5XrFibnFpXnpesn5uZsYgQnu9L/jX3YwLn/1Ue8QIxMH4yFGFaDm
	RxtWX2CUYsnLz0tVEuHNOZ+fKsSbklhZlVqUH19UmpNafIhRmoNFSZxXNUU+VUggPbEkNTs1
	tSC1CCbLxMEp1cAU99plnshDrTVXbNdc2xvTaK8iH84lztQZc9k1+uruh/aMDw5u1z7VkfHO
	2Vo3ysuwb9fVG4zMwddXv2A1ELN3/GbZy3Xwwq6a2k8s109yBk6UeZd36ZXe0oXVxkEHjuxd
	ubb8l2XAGw3NO7X1zHdeeTF8v9l1/8GJFceD2RLehWa4+M+8N9/0n5fKuqkcLnXzi26Xuyju
	P3qIR9diKpvQey2HTwob9Hy+xfItvKXHJzPLJczAabl+fLBns/bR6bVTS4z39S7cwvrob7Gb
	2Jx7PmYX6n59el04ce0f1qdrj005fbLz/hrpor+xZ3+zMajIh/7ivG4s7flU/7sTQ//X/463
	n57RX+9dI+xtPue7EktxRqKhFnNRcSIAADfIqusDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsVy+t/xe7o6qwtTDbZM5rJoXryezeLXxWms
	Fme6cy327D3JYjFv/U9Gi8u75rBZ/P7xjMnixoSnjBbLdvo5cHrMbrjI4rFgU6nHplWdbB77
	565h9/i8Sc6jv/sYewBblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1N
	SmpOZllqkb5dgl7GyZtXWQr2SVbsebeLuYGxV7SLkYNDQsBE4vSDzC5GLg4hgaWMEp1bvrF1
	MXICxWUkNn65ygphC0v8udbFBlH0kVFiz7I/zBDOZkaJb3/3M4JUsQioSGyb9Qusm01AR+L8
	mzvMILaIgIbEvgm9TCANzALnmCR2bbvKDLJaWMBBYluTJEgNr4C5xJtp3xkhhl5hkph/cQ8b
	REJQ4uTMJywg9cwCZRK/V8ZDmNISy/9xgFRwCphJfFz3GOpQJYnDkz8zQ9i1Ep//PmOcwCg8
	C8mgWQiDZiEMAqlgBrp559Y7bBjC2hLLFr5mhrBtJdate8+ygJF9FaNIamlxbnpusZFecWJu
	cWleul5yfu4mRmCUbzv2c8sOxpWvPuodYmTiYDzEqALU+WjD6guMUix5+XmpSiK8OefzU4V4
	UxIrq1KL8uOLSnNSiw8xmgLDcCKzlGhyPjD95JXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQn
	lqRmp6YWpBbB9DFxcEo1MPkrCby3zPB7HiVkw/cmqMPDrLomT0Tr6JHdhxmep/Ss8k20LNg5
	d9rBlwoyxzQ/5Ms9O379w4wLPL2sIRumHEtl63FLuTfde/emldGlc/ftfi63ZMVuoQ8qbMuZ
	2VNfXXOQjbYsl3youcNvN/unPL6V/7QXFqlOvbb14OxD1ab/lxbeEn22RTx5g5rW1/rvp7dm
	/z03f1XSVfE9a4I4LiovqHF12tNXpbWT5eCzTT7HLMrFDy0v/PdObs37X80Hr3xvNZw14fmb
	+Wz6f2d7eqQW9yedyr0ybSurw57sjplPNBkXzD3KKd+181lM6gw1le839535MY37mvf9yzXx
	cwpTtTQqny832qRwW6H/4ntLJZbijERDLeai4kQA4FkMaYcDAAA=
X-CMS-MailID: 20231207112324eucas1p2962efea55f2a1f49f6efb3b06fd1a582
X-Msg-Generator: CA
X-RootMTR: 20231205222712eucas1p109566babf1072328184c818d1b6965b5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231205222712eucas1p109566babf1072328184c818d1b6965b5
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
	<ZW66FhWx7W67Y9rP@bombadil.infradead.org>
	<b4b0b7ea-d8b3-4538-a5b9-87a23bbdac5f@t-8ch.de>
	<d50978d8-d4e7-4767-8ea7-5849f05d3be1@t-8ch.de>
	<CGME20231205222712eucas1p109566babf1072328184c818d1b6965b5@eucas1p1.samsung.com>
	<ZW+juEWLSTybbujk@bombadil.infradead.org>

--2b7bopsuuvobq6c5
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 02:27:04PM -0800, Luis Chamberlain wrote:
> On Tue, Dec 05, 2023 at 06:16:53PM +0100, Thomas Wei=DFschuh wrote:
> > Hi Luis, Joel,
> >=20
> > On 2023-12-05 09:04:08+0100, Thomas Wei=DFschuh wrote:
> > > On 2023-12-04 21:50:14-0800, Luis Chamberlain wrote:
> > > > On Mon, Dec 04, 2023 at 08:52:13AM +0100, Thomas Wei=DFschuh wrote:
> > > > > Tested by booting and with the sysctl selftests on x86.
> > > >=20
> > > > Can I trouble you to rebase on sysctl-next?
> > > >=20
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/lo=
g/?h=3Dsysctl-next
> > >=20
> > > Will do.
> >=20
> > The rebased series is now available at
> > https://git.sr.ht/~t-8ch/linux b4/const-sysctl
>=20
> I've applied this to sysctl-next as this all looks very sensible to me,
> except one patch which I'll chime in on, but I'm merging it to
That is the "move sysctl type to ctl_table_header" right?

> sysctl-next now without a promise to get this in as I really would like
> this to soak in on linux-next for a bit even if it does not get merged
> in the next kernel release. Exposing it on linux-next will surely
> iron out run time issues fast.
+1 for soaking it :)

>=20
> > Nothing much has changed in contrast to v2.
> > The only functional change so far is the initialization of
> > ctl_table_header::type in init_header().
> >=20
> > I'll wait for Joels and maybe some more reviews before resending it.
>=20
> It all is very trivial stuff, except a few patches, but it all is making
> sense, so my ask is to address feedback this week and post next week
> a new set so we can have changes merged as-is for Linux in case this
> really doesn't break anything.
Any thoughts on the size of the tree-wide patches?

>=20
> For some reason I raccall seeing som hacky sysclts that shared and
> modified an entry somewhere but the exact sysctl phases me, and I just
> cannot recall.
Its probably in net/*. There is were they are really taking advantage of
ctl_table.

>=20
> > > [..]
> >=20
> > For the future I think it would make sense to combine the tree-wide con=
stification
> > of the structs with the removal of the sentinel values.
> >=20
> > This would reduce the impacts of the maintainers.
>=20
> Indeed.
>=20
>   Luis

--=20

Joel Granados

--2b7bopsuuvobq6c5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVxqyoACgkQupfNUreW
QU9Mfgv/W62R2aUunsSdN2DFcIRXKePW0Oyyu2RfLLT5I7Utd/1PdHjuhIyyOAGS
/9vP1zfp6ZGhrl/NqZpIIZH3t1E8/zxURK178TDc/d5zC6LzOTu+r7PVgGq0wN9Q
PiiEebBCA5bdfrEO4baxAofR981s92b+EH/914TTzn4McmwPCLkn6+6HujiSakz5
HNz8wIGczjzsnYDrHSWV8DlAH87vs+Zxa8/T9hzBhWm+yb1f0o+XCHhLLmfACfop
q+NEQwlRK/0Tfx3Xug43D5fU6kvZqgm0vJxOhEU3fnZClS08IZj4oVyixBcCtQuK
FQDoy1wy9nBLtea4ENrWbJ6mIhOB2a4N8mq3Nn31+OmcSqw+fr6uEbYGi2hmqcZy
rhkQU4qJL6BD387CrLxiglHbSVJ5SKEDXdZ99ukoXkQi60/zcOdr6ZnxA1NAkzLE
vtyQIcDYBIogDImnnNqSMJo5ETxVM1GxisxECDwK4izJrE0MznDZnPnyDAK+CbAl
6YZXT1C0
=8Yi9
-----END PGP SIGNATURE-----

--2b7bopsuuvobq6c5--

