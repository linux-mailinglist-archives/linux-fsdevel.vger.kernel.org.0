Return-Path: <linux-fsdevel+bounces-5143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2840A8087CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 13:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D224C2828B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 12:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B9D3454D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Fry04PEM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F768A3;
	Thu,  7 Dec 2023 03:20:02 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231207112000euoutp02629bf037199b58114d617dc158ea9223~eiLB5yu043028230282euoutp02S;
	Thu,  7 Dec 2023 11:20:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231207112000euoutp02629bf037199b58114d617dc158ea9223~eiLB5yu043028230282euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701948000;
	bh=CXEoF01cA0lxJUjcgcpiHuTJ21uaNlVDe1HMzxDBl1M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Fry04PEMo5Lbo5h3A6jv9XprImiaT7JqLmSeGQpxjMGD5YjyNp+K0GS8rzOT+Io8p
	 xxjKYbsO3fNSTqd8toZfD9438zZpYliZ4ZoJn5hcnhiFOWGOEgugopHI1MZZLikv0g
	 DBTHrYBtQygndZlCFryEfFGPHqBTvzwtcNmYzPBk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231207112000eucas1p293f9ec36b36b17599041707c4c5b22cd~eiLBq602-1452414524eucas1p2p;
	Thu,  7 Dec 2023 11:20:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 58.8B.09814.06AA1756; Thu,  7
	Dec 2023 11:20:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231207111959eucas1p2a83929e07821c4311f420eeabf58f553~eiLBJq1J21452414524eucas1p2o;
	Thu,  7 Dec 2023 11:19:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231207111959eusmtrp26676cebfdb0c107e7d6ddee853548b22~eiLBI-hrr2237722377eusmtrp2J;
	Thu,  7 Dec 2023 11:19:59 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-c4-6571aa60a452
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 0D.A5.09274.F5AA1756; Thu,  7
	Dec 2023 11:19:59 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231207111959eusmtip1921e99a998a87ed5d059fee31555b558~eiLA8d6230310103101eusmtip1U;
	Thu,  7 Dec 2023 11:19:59 +0000 (GMT)
Received: from localhost (106.210.248.38) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 7 Dec 2023 11:19:59 +0000
Date: Thu, 7 Dec 2023 12:19:57 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Iurii Zaikin
	<yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <20231207111957.b24ib4hcxr6xufll@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="5z5snkykkq6vptla"
Content-Disposition: inline
In-Reply-To: <d50978d8-d4e7-4767-8ea7-5849f05d3be1@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djPc7oJqwpTDVbulrRoXryezeLXxWms
	Fme6cy327D3JYjFv/U9Gi8u75rBZ/P7xjMnixoSnjBbLdvo5cHrMbrjI4rFgU6nHplWdbB77
	565h9/i8Sc6jv/sYewBbFJdNSmpOZllqkb5dAlfGpvZHLAXNohV/rzawNzDeEexi5OSQEDCR
	uHzwM0sXIxeHkMAKRok7l05DOV8YJW7O3QrlfGaUuPRmFzNMy6b3nWwQieWMEoemgSSgqp6d
	6WeEcDYDDduyg6mLkYODRUBFYs+XBJBuNgEdifNv7oBNEhGwkVj57TM7SD2zwC4miWv7rrOA
	1AsLOEhsa5IEqeEVMJdY33OGGcIWlDg58wkLiM0sUCGx+eFbZpByZgFpieX/OEDCnEAjZzYt
	YYc4VEni8OTPUEfXSpzacosJZJWEwGpOie5XLVAJF4k5Z9ewQdjCEq+Ob4FqlpH4v3M+VMNk
	Ron9/z6wQ3UzSixr/MoEUWUt0XLlCVSHo8Tzqe/ZQS6SEOCTuPFWEOJQPolJ26YzQ4R5JTra
	hCCq1SRW33vDMoFReRaS12YheW0WwmsQYT2JG1OnsGEIa0ssW/iaGcK2lVi37j3LAkb2VYzi
	qaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIFJ7vS/4192MC5/9VHvECMTB+MhRhWg5kcbVl9g
	lGLJy89LVRLhzTmfnyrEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVIID2xJDU7NbUgtQgm
	y8TBKdXANONv5dSzjucL/fLdt67Z+7/GXHMv+1/fgDbNBSxr1JKOXPE7qcvedT72w4fGraWu
	1W577glseDIhWLjsrHzPxByurOpHbDZ+CabH67mY6/bqnBV9EWFcuHaJWpPDnFcLy5e48PnP
	+uIyd6bA7L63Gs4Pf0U+e/CJr+Rk07OT7BHrTjbrRm8R0rQM1Q5ffG1Xg4O2ckf8NGcl3XWT
	lBeuinh73EzkK5vju/zbl4TanXu/Ci9r2MHsHf5OUWHrjZDz+W9/Cka/vHhA66VQj9J7CXEx
	ie2ZLgmhOq/rG+ZFMl2v27vlgfRaOR0Gr6NnTv+wM5n8fBLni5VFoW3v3FfdWX1Rr//rR09f
	m0U88v9fKLEUZyQaajEXFScCAFh4yYjtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsVy+t/xu7rxqwpTDXYeNLJoXryezeLXxWms
	Fme6cy327D3JYjFv/U9Gi8u75rBZ/P7xjMnixoSnjBbLdvo5cHrMbrjI4rFgU6nHplWdbB77
	565h9/i8Sc6jv/sYewBblJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1N
	SmpOZllqkb5dgl7G+8bn7AWNohV9yx4zNTDeEuxi5OSQEDCR2PS+k62LkYtDSGApo8Tpvhns
	EAkZiY1frrJC2MISf651QRV9ZJS4fXUxO4SzmVFizca5QBkODhYBFYk9XxJAGtgEdCTOv7nD
	DGKLCNhIrPz2GayeWWAXk8S1fddZQOqFBRwktjVJgtTwCphLrO85wwwxcwWTxKQjsxghEoIS
	J2c+YQGxmQXKJN7M3cYM0sssIC2x/B8HSJgTaP7MpiVQRytJHJ78mRnCrpX4/PcZ4wRG4VlI
	Js1CMmkWwiSIsI7Ezq132DCEtSWWLXzNDGHbSqxb955lASP7KkaR1NLi3PTcYiO94sTc4tK8
	dL3k/NxNjMBI33bs55YdjCtffdQ7xMjEwXiIUQWo89GG1RcYpVjy8vNSlUR4c87npwrxpiRW
	VqUW5ccXleakFh9iNAUG4kRmKdHkfGAKyiuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnN
	Tk0tSC2C6WPi4JRqYHJwejXZhPl+o9ksiy0mGisUFhxXvZcV18l9aeOxqgmh8fcsfzDrXdZr
	mb3/8cXGUOOlFxS5Gx12n2oV4ZNY8Cly6a3MarXgtHtzdn1fF3bpUaFQffr+cykzTMXWOb80
	7T65Qljnf0A3R2PUj1+vfqvPvX9+3YGIq/ME8/eFX7rrdjrnccKehf+zsiyTL+qqOM7mZ5+5
	wzc6kS1lc0LYwxBPNYP19+9rnt32x190+WVv9W1bJp1WWWq7V8uouP6EtvnWdpfOsuif8b23
	e28feSfUbO68tWC2Ve/Ey+u36hXPzL6i9CBTtaaBJyLuGMeCFYd2/3TdXTqFOzs7/PfC/93d
	Ur+UFVM4l9VlBadUfFRiKc5INNRiLipOBAAdzfBbiQMAAA==
X-CMS-MailID: 20231207111959eucas1p2a83929e07821c4311f420eeabf58f553
X-Msg-Generator: CA
X-RootMTR: 20231205171700eucas1p17edbc33ec1d0be37573b1977b76b9ce6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231205171700eucas1p17edbc33ec1d0be37573b1977b76b9ce6
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
	<ZW66FhWx7W67Y9rP@bombadil.infradead.org>
	<b4b0b7ea-d8b3-4538-a5b9-87a23bbdac5f@t-8ch.de>
	<CGME20231205171700eucas1p17edbc33ec1d0be37573b1977b76b9ce6@eucas1p1.samsung.com>
	<d50978d8-d4e7-4767-8ea7-5849f05d3be1@t-8ch.de>

--5z5snkykkq6vptla
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 06:16:53PM +0100, Thomas Wei=DFschuh wrote:
> Hi Luis, Joel,
>=20
> On 2023-12-05 09:04:08+0100, Thomas Wei=DFschuh wrote:
> > On 2023-12-04 21:50:14-0800, Luis Chamberlain wrote:
> > > On Mon, Dec 04, 2023 at 08:52:13AM +0100, Thomas Wei=DFschuh wrote:
> > > > Tested by booting and with the sysctl selftests on x86.
> > >=20
> > > Can I trouble you to rebase on sysctl-next?
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/=
?h=3Dsysctl-next
> >=20
> > Will do.
>=20
> The rebased series is now available at
> https://git.sr.ht/~t-8ch/linux b4/const-sysctl
>=20
> Nothing much has changed in contrast to v2.
> The only functional change so far is the initialization of
> ctl_table_header::type in init_header().
>=20
> I'll wait for Joels and maybe some more reviews before resending it.
>=20
> > [..]
>=20
> For the future I think it would make sense to combine the tree-wide const=
ification
> of the structs with the removal of the sentinel values.
I don't see how these two would fit. And this is why:
1. The "remove sentinel" stuff is almost done. With the sets going into
   6.7 we would only be missing everything under net/*. So you would not
   be able to combine them (except for the net stuff)
2. The motivation for the two sets is differnt. This would confuse
   rather than simplify the process.
3. In order to introduce the const stuff we would have to go through
   another round of "convincing" which can potentially derail the
   "remove sentinel" stuff.

I would *not* like to combine them. I think the const set can stand on
its own.
>=20
> This would reduce the impacts of the maintainers.
>=20
>=20
> Thomas

--=20

Joel Granados

--5z5snkykkq6vptla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVxqlwACgkQupfNUreW
QU8frQwAmVCgALk4OWR4ZO/s1n4rLY7ci247QjM9Bmg1WdksPWp70HkrU5eSmb9t
BiHrNBMb9edU00xHbC0553m/HaeOq1sERcubT2LXmjagnshZzR4JHPj4qWi2k20k
Bwnsd8n/ZMY33T7Vq97o3rW2W5aPMBiqeY/fdBPqG3ArlXUISGtonYFmGERiNhyu
eZ6JBtjl5+Q50CwH01HbRm0uFLNWrZA3tBoJssnFJt06AaoYAYK302UL2DirCCuu
fCLSIsiz3CngsVs+cJHLZaOWB5lXLPGoQjjGJ0Lvdy8Q5Xlgx/ckugTw9AzDN9B+
y7Q22g7TY+Eg8aspEvICKEIuQYo1fi0WmqgS63t+Ttvdw/VpeEId2p15eRz3PJGz
KY0oOKoS2Xy52uNhxsL6zGtMqKM/hL3WJXtNyOeshXQWY2qrsF+t5+OckxODOCgR
5FFILM1DVgj5zJM2b7LC308T+ULLhU7HllJ9oLG6QzWotSx+M0TcbVmmNneN1nI8
BhCGk6c+
=2W1o
-----END PGP SIGNATURE-----

--5z5snkykkq6vptla--

