Return-Path: <linux-fsdevel+bounces-5142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F029E8087C9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 13:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA362829BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 12:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664682D786
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 12:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mxGpFbe7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692E4D53;
	Thu,  7 Dec 2023 03:05:25 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231207110524euoutp01613e40d891be59b320c0ade472d29cf4~eh_RfuRbr0152401524euoutp01U;
	Thu,  7 Dec 2023 11:05:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231207110524euoutp01613e40d891be59b320c0ade472d29cf4~eh_RfuRbr0152401524euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701947124;
	bh=daPuwGpwsCikEu05jfrEZmZPhBfvdaDIM/2Wd7kHU2o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=mxGpFbe7KXsKyseqrH3jNtn2il9wQdQXl/rOGiAa2M9Xyo1/07WsXczlO6mfXp8tU
	 Jc8TpYWfSptZ/65M4wzfyKmjApuSydZ+TtfOMq9FGiR2UxDviI1yeKrHTqgXTBfzlh
	 m/RHd25QI6OIxfkBmTo9PXGnUQjW8K1yR1qoWmzs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231207110523eucas1p1204a194eba3c8a617cef548da848508f~eh_RFEIs72424224242eucas1p12;
	Thu,  7 Dec 2023 11:05:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id A6.43.09552.3F6A1756; Thu,  7
	Dec 2023 11:05:23 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231207110523eucas1p21e6a6ba5cbe0c2f17f7b0d08a50d6aad~eh_QksM9x1784117841eucas1p2u;
	Thu,  7 Dec 2023 11:05:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231207110523eusmtrp190eca1446906b88559f4ac378aac3f40~eh_QkG1IK1166211662eusmtrp1T;
	Thu,  7 Dec 2023 11:05:23 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-2a-6571a6f3ecee
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id BB.A2.09146.2F6A1756; Thu,  7
	Dec 2023 11:05:23 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231207110522eusmtip1d56bff99c4aba8b5fee2428935de0000~eh_QX5JuT2586225862eusmtip19;
	Thu,  7 Dec 2023 11:05:22 +0000 (GMT)
Received: from localhost (106.210.248.38) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 7 Dec 2023 11:05:22 +0000
Date: Thu, 7 Dec 2023 12:05:21 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Iurii Zaikin
	<yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <20231207110521.jeudk6y5ejh6ngf6@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="a7f76owrdx7oxple"
Content-Disposition: inline
In-Reply-To: <b4b0b7ea-d8b3-4538-a5b9-87a23bbdac5f@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7djPc7qflxWmGnxqV7RoXryezeLXxWms
	Fme6cy327D3JYjFv/U9Gi8u75rBZ/P7xjMnixoSnjBbLdvo5cHrMbrjI4rFgU6nHplWdbB77
	565h9/i8Sc6jv/sYewBbFJdNSmpOZllqkb5dAlfGzKZuxoKFIhWLpv1ibGDsF+xi5OSQEDCR
	OD21m62LkYtDSGAFo8SWy/OZIZwvjBIbvx5mgnA+M0o8uLKPHablwL8XUC3LGSW+Xe1hhKu6
	sGU2VMtmRomurussIC0sAioS/69OZAOx2QR0JM6/ucMMYosI2Eis/PaZHaSBWWAXk8S1fSAN
	HBzCAg4S25okQWp4BcwlGtrPskHYghInZz4Bm8ksUCHxZdIWdpByZgFpieX/OEDCnEAj22e9
	gbpUSeLw5M/MEHatxKktt8BukxBYzSlx5/pdVoiEi8SNNaugioQlXh3fAtUsI3F6cg8LRMNk
	Ron9/z6wQ3UzSixr/MoEUWUt0XLlCVSHo8TsX7fAHpAQ4JO48VYQ4lA+iUnbpjNDhHklOtqE
	IKrVJFbfe8MygVF5FpLXZiF5bRbCaxBhPYkbU6ewYQhrSyxb+JoZwraVWLfuPcsCRvZVjOKp
	pcW56anFxnmp5XrFibnFpXnpesn5uZsYgWnu9L/jX3cwrnj1Ue8QIxMH4yFGFaDmRxtWX2CU
	YsnLz0tVEuHNOZ+fKsSbklhZlVqUH19UmpNafIhRmoNFSZxXNUU+VUggPbEkNTs1tSC1CCbL
	xMEp1cDULieoaSkkU5fmGsJqFTTxmKz2kfXitQ+ZDiyekMstFvF0V0WS9b2Orb5eDVvX504q
	9tC691bqyK9HxyaKPpTjWZdztyjQr6OmM3PrhdwZL3WjFP3U6/Q9k/S/u7tV3T+36F5B3l5X
	rWcrL6c9eKa9w8ricOqxbTICLExFMy9GzDtvY8L3ss7ZT6X8UbPhVB3+5+/SNLwe8FZfkhfZ
	vJznRtarHJNw3okNs9RyY96/W8r6aumLZlvBuXohx3z25/z5O/HH/EUsx764T9tULqB/75Bw
	ZiCzoPQiQ1Xx/zefztz/htGyp35S3DbVj1+tVf/MML8UyLDu8hV7J3GfeZwbHnVaO6bdfBF8
	7ZVb6wklluKMREMt5qLiRABd/Gww7gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsVy+t/xu7qflxWmGuzcy2jRvHg9m8Wvi9NY
	Lc5051rs2XuSxWLe+p+MFpd3zWGz+P3jGZPFjQlPGS2W7fRz4PSY3XCRxWPBplKPTas62Tz2
	z13D7vF5k5xHf/cx9gC2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTub
	lNSczLLUIn27BL2MU1NqCuaLVKy7OIGpgbFXsIuRk0NCwETiwL8XbF2MXBxCAksZJZ4enMkE
	kZCR2PjlKiuELSzx51oXVNFHRon3TfsZIZzNjBItLd8YQapYBFQk/l+dyAZiswnoSJx/c4cZ
	xBYRsJFY+e0zO0gDs8AuJolr+66zdDFycAgLOEhsa5IEqeEVMJdoaD8LteEbo0THtGOMEAlB
	iZMzn7CA2MwCZRL3+q6xgvQyC0hLLP/HARLmBJrfPusNO8SlShKHJ39mhrBrJT7/fcY4gVF4
	FpJJs5BMmoUwCSKsI7Fz6x02DGFtiWULXzND2LYS69a9Z1nAyL6KUSS1tDg3PbfYUK84Mbe4
	NC9dLzk/dxMjMNK3Hfu5eQfjvFcf9Q4xMnEwHmJUAep8tGH1BUYplrz8vFQlEd6c8/mpQrwp
	iZVVqUX58UWlOanFhxhNgaE4kVlKNDkfmILySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNL
	UrNTUwtSi2D6mDg4pRqY8h+aHHThWOgc/+pcgKJJ6LGYyCNnBM807NxxONo17dKUukr5ux0B
	+qfMBC8/rZj35ef0KdaOAQEqV2eEmGuwTMsU+S13tMJEbaKCFbv2+o86Z9YJZhzmEbycoy/t
	1HtztUvapaluhneYKth3za2ddHTTyhO3zt59PeO/v6AT11VhHR9WybUOemKWx43nf8qMuPVf
	qaqtpqBdpYlBVLzu26SPOh/TvQRtD+1OSXyWm7Ruwo/re2+V1sWxF6XrnN9tEuen49K2kPeY
	c7T/faHJJ+9Pi9S6UG3Js7X0a1LjTd9EroJZRosOTGh3ehv2RbBSqC5KxsvtzJ9pSY+inv38
	56ld+WHZtyQTT7cJd1yUWIozEg21mIuKEwHO4gDwiQMAAA==
X-CMS-MailID: 20231207110523eucas1p21e6a6ba5cbe0c2f17f7b0d08a50d6aad
X-Msg-Generator: CA
X-RootMTR: 20231205080416eucas1p241d86dda65c0009ca352673e1ca5b26d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231205080416eucas1p241d86dda65c0009ca352673e1ca5b26d
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
	<ZW66FhWx7W67Y9rP@bombadil.infradead.org>
	<CGME20231205080416eucas1p241d86dda65c0009ca352673e1ca5b26d@eucas1p2.samsung.com>
	<b4b0b7ea-d8b3-4538-a5b9-87a23bbdac5f@t-8ch.de>

--a7f76owrdx7oxple
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 09:04:08AM +0100, Thomas Wei=DFschuh wrote:
> On 2023-12-04 21:50:14-0800, Luis Chamberlain wrote:
> > On Mon, Dec 04, 2023 at 08:52:13AM +0100, Thomas Wei=DFschuh wrote:
> > > Tested by booting and with the sysctl selftests on x86.
> >=20
> > Can I trouble you to rebase on sysctl-next?
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=
=3Dsysctl-next
>=20
> Will do.
>=20
> Note:
>=20
> I noticed that patch "sysctl: move sysctl type to ctl_table_header" from
> this series seems to be the better alternative to
> commit fd696ee2395755a ("sysctl: Fix out of bounds access for empty sysct=
l registers")
> which is currently on sysctl-next.
Indeed. By taking this out of the ctl_table, we would not need to make
sure that we don't touch that (potentially non-existing) first element.

This is what I think should be done (@Luis @Kees chime in if you have any
thoughts):
1. Leave the current fix for 6.7. AFAIK, it is already queued for that
   release and it is a bit late in the cycle to put anything new in.
2. I think this patch has value on its own as a better solution to the
   "access invalid memory" issue. @thomas: remove this patch from your
   const set and send it in a different patch series.
3. const patchset would need to go on top of the new set.

Having it on its own will allow it to go in faster and make it easier to
review without having to thinkg about the const stuff as well.

Best
>=20
> The patch from the series should only depend on
> "sysctl: drop sysctl_is_perm_empty_ctl_table" from my series.
>=20
> Thomas

--=20

Joel Granados

--a7f76owrdx7oxple
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVxpu8ACgkQupfNUreW
QU/DNAv/TDQMJUs4oKgPcr+aoFQ/sng5W4yFQY5GA7FAsG3lAFqEcPFG6YB8XWO6
pUmcI9ZvnpNMaQdN4PBYCo25B165jbGnm4qlyOQ/vCTECPzIESXwC42lNOCblQUQ
mM0LarwaqRHcUzh0/9EyTdh/8M3n0O3foisGm/3JmKBkMoFrt81ucKW01fyasptR
GIhFpi4WdbMsb/uRjImsMmJza8oPSa7uTU4Vhs9fMmhRIKwp4/fAW38z+LPZkf60
/nspxC6IRu1xA9fByp25sv+P/uAu5dx+VVrDFGfAyIyxAJLU1IIgeTLAzWmNKp0M
/BLnEEJ/8FD59zHUWRYE//yUKO/tfMfenQ9U69x13CeT2aeFEMT+jB3z1XcmaAG6
l5nycPXZZQsx8Nb0ayfWLaWSmeA5/Vh8Jc8QXCZmO7xLGftipyLWpZcGhjcOwaUi
upyI4hAm+GL2Gm7BbWUpjgeB34pbhTSCQPDNyGJeWT2x9l6qKKmlUG36eKx6q2NO
AXRuEQwr
=YKxV
-----END PGP SIGNATURE-----

--a7f76owrdx7oxple--

