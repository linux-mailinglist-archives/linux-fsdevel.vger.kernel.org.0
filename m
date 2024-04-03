Return-Path: <linux-fsdevel+bounces-16157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE1B899573
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 08:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 628B5B23A4B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 06:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158801EB2A;
	Fri,  5 Apr 2024 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A93aV5xc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AF51C290;
	Fri,  5 Apr 2024 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298938; cv=none; b=HSOEBatqzc8o3kn0+QAE5OdyQnVN/r2BRTy0jzk5DM3NuQsdtfnoujEJLzQKEDbXVf9zl2bFfTwcZaPt9Sc0Q7E9hFt8DFOJZ3sJca7RKjyhOGD71MGoeiyaYQc40+r9F+cVesyRHPGqWtdVUjTDuOab2cz66szDg5eK7KRU28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298938; c=relaxed/simple;
	bh=suf1mVujLn3+yGE5KasTJjYKM5qv2X+Fh0eM98WQZ2U=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=AJt4M7EwVNwvlcCZB9ozm0/JHVXm4hA7pkUeKc7XGBvcRFPZgAHoaJk8Qf0mgp6ptVZC0+/TNMWILKn96q/i3eKSfwoomDegijqrt0PtkJRoJHjhSxaeZBYoA8DBAn1I6RrgoCn4gdZXNSAmEGjjlezfn4BLYRwkX+prdKsW7gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=A93aV5xc; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240405063533euoutp026d6e961c592d70aac5e0bd7921704a80~DTs7sEzzr2969329693euoutp02P;
	Fri,  5 Apr 2024 06:35:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240405063533euoutp026d6e961c592d70aac5e0bd7921704a80~DTs7sEzzr2969329693euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712298934;
	bh=jV9qZk2sxguKtofPRk3C7atwnLQ8qh+K+KafT+ZU8Cc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=A93aV5xcBeiSbqp4/VJcxPFyb9//+UDiOFiw8QFCzb0j2dajKo8izcmHn7cw1pl0N
	 gHFTtkJhmsVvoVy1klY8a63XVIUP1TXkGkj475vbytoVM17/vUjcFqMfP/0FQ+CuxR
	 kn2kMfE7ekl9rW4Ep31M1SFFg6WQBBcgzB8PqfXQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240405063533eucas1p2e3e06d08e24ffcdda96a08fd19144189~DTs7jQXT71221112211eucas1p2Y;
	Fri,  5 Apr 2024 06:35:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 96.75.09552.5BB9F066; Fri,  5
	Apr 2024 07:35:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240405063533eucas1p210c3a02a389498fc7f84a0a5b0c8892b~DTs7PJtom3107131071eucas1p2B;
	Fri,  5 Apr 2024 06:35:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240405063533eusmtrp1ba6e61243ee13e6cf96915e6d7e1320a~DTs7OqdEi2494624946eusmtrp17;
	Fri,  5 Apr 2024 06:35:33 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-fd-660f9bb5dd19
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 17.B2.10702.5BB9F066; Fri,  5
	Apr 2024 07:35:33 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240405063533eusmtip13de6021537473006b2bce7f92fd2e890~DTs7D9jAt1339713397eusmtip1P;
	Fri,  5 Apr 2024 06:35:33 +0000 (GMT)
Received: from localhost (106.210.248.50) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 5 Apr 2024 07:35:21 +0100
Date: Wed, 3 Apr 2024 11:01:22 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] sysctl: move sysctl type to ctl_table_header
Message-ID: <20240403090122.yajcqnwu6dosjvax@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="3lizhmz35mf362ct"
Content-Disposition: inline
In-Reply-To: <20240322-sysctl-empty-dir-v2-0-e559cf8ec7c0@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djPc7pbZ/OnGRzt17X4v62F3eJMd67F
	nr0nWSwu75rDZvH7xzMmixsTnjI6sHnMbrjI4rFpVSebx+dNch793cfYPaYcamcJYI3isklJ
	zcksSy3St0vgyrjW8JCloEOkom/GWuYGxtWCXYwcHBICJhInJnp3MXJxCAmsYJTYee0RM4Tz
	hVFi9oEXLBDOZ0aJfXfa2LsYOcE6Pu28xwqRWM4ocWbJeSa4qk/zl0I5mxklek7uYgJpYRFQ
	kZgxs58FxGYT0JE4/+YOM4gtImAjsfLbZ3aQBmaBvYwSs17MB9shLOAhcfPZRDaQC3kFHCTu
	tcmAhHkFBCVOznwCNodZoELizv7FrCAlzALSEsv/cYCEOQU8JV6d3MoK8ZuSxPfVXhBH10qc
	2nIL7DQJgemcEr2Tn0J94yLx9M03NghbWOLV8S1QcRmJ05N7WCAaJjNK7P/3gR3CWc0osazx
	KxNElbVEy5UnUB2OEj+mTYfazCdx460gxJ18EpO2TWeGCPNKdLQJQVSrSay+94ZlAqPyLCSf
	zULy2SyEzyDCehI3pk5hwxDWlli28DUzhG0rsW7de5YFjOyrGMVTS4tz01OLjfNSy/WKE3OL
	S/PS9ZLzczcxAtPX6X/Hv+5gXPHqo94hRiYOxkOMKkDNjzasvsAoxZKXn5eqJMLb7cCbJsSb
	klhZlVqUH19UmpNafIhRmoNFSZxXNUU+VUggPbEkNTs1tSC1CCbLxMEp1cBkvvnEd7HL76XD
	/BnWHwiVzPe6oPSooU1qRc51AUaGLcxZ+XsVzy8Ql1k4+X/S5lUm0rI5Cxketl8q3b7o5JYf
	+Tt2Pl03UflHcdCqKt6HX9/VPvkZuURx/v33nAW8LHF3pptEOjqxhk3R7Ht2eX+i9hqdHbmH
	GuIsS44ZFC9yun9F7m7tJBN703VvXRPsdadIfZ0t9/Dptcds1dr9214mZrmrd840u7lyD+ds
	K/G04zuPxFZsMPuokKzbtIpZ4MVmKVunM97/BIz2l8zlifIyWX+mvDUu/+PuovrX6woVvwd8
	rUr+Ip4Z99vX7+6rpMCLl/c+4+i0eGo2d87fvzlsJ05fPRdl4pp4sd0kvuizEktxRqKhFnNR
	cSIAgJWtbdoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xu7pbZ/OnGcz+LmHxf1sLu8WZ7lyL
	PXtPslhc3jWHzeL3j2dMFjcmPGV0YPOY3XCRxWPTqk42j8+b5Dz6u4+xe0w51M4SwBqlZ1OU
	X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3Hh3lPWgjaR
	in1NW9gbGFcKdjFyckgImEh82nmPtYuRi0NIYCmjROuu/UwQCRmJjV+uskLYwhJ/rnWxQRR9
	ZJSY+eM+VMdmRomj52eCdbAIqEjMmNnPAmKzCehInH9zhxnEFhGwkVj57TM7SAOzwF5GiVkv
	5rODJIQFPCRuPpsINJaDg1fAQeJemwzE0DmMEiuOTmcDqeEVEJQ4OfMJ2FBmgTKJeasmM4HU
	MwtISyz/xwES5hTwlHh1cisrSFhCQEni+2oviKNrJT7/fcY4gVF4FpJBs5AMmoUwCCKsI7Fz
	6x02DGFtiWULXzND2LYS69a9Z1nAyL6KUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMIq3Hfu5
	ZQfjylcf9Q4xMnEwHmJUAep8tGH1BUYplrz8vFQlEd5uB940Id6UxMqq1KL8+KLSnNTiQ4ym
	wECcyCwlmpwPTC95JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1M
	8pYlnx4uj2T6OS8+7kK9gs7seZeOM18NlA7/e2D3FZuos4dS4gymut0Iiqw14Px+t4DtQu3k
	lKlRRQc+xZ6Mfib3tNn6gqtD3xYmWTMn9XmBcYFiuc6KRnfeNuuLFjA4pc+JvFO7647T8h7L
	OR/VdhYKTHgfovld43tg6oQoa69nN46uWPquzUi38mvgk5tsxnpZKypWlTYuu+9t9fht3IOz
	/a9mHnnfLV3B1j4z94u8sXrQZ6lX02cLzvuVcH+6YVIeo9dH35xO1k2r4kr/5b6ab7pqymmD
	59e2az6+4SsjU8o5Q1lJOaT0wxOmmU5vC5tnXUk5/uKp4gzzhNjmkxNSo6srgu78SJc/aBqk
	xFKckWioxVxUnAgAe6V5FncDAAA=
X-CMS-MailID: 20240405063533eucas1p210c3a02a389498fc7f84a0a5b0c8892b
X-Msg-Generator: CA
X-RootMTR: 20240322170605eucas1p2efc8b108034476c5e6f637b0dcf0671d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240322170605eucas1p2efc8b108034476c5e6f637b0dcf0671d
References: <CGME20240322170605eucas1p2efc8b108034476c5e6f637b0dcf0671d@eucas1p2.samsung.com>
	<20240322-sysctl-empty-dir-v2-0-e559cf8ec7c0@weissschuh.net>

--3lizhmz35mf362ct
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Added this to the constfy branch Thx

On Fri, Mar 22, 2024 at 06:05:55PM +0100, Thomas Wei=DFschuh wrote:
> Praparation series to enable constification of struct ctl_table further
> down the line.
> No functional changes are intended.
>=20
> These changes have been split out and reworked from my original
> const sysctl patchset [0].
> I'm resubmitting the patchset in smaller chunks for easier review.
> Each split-out series is meant to be useful on its own.
>=20
> Changes since the original series:
> * Explicit initializartion of header->type in init_header()
> * Some additional cleanups
>=20
> [0] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-0-7a5060b11447@=
weissschuh.net/
>=20
> ---
> Changes in v2:
> - Rebase onto next-20240322 without changes
> - Squash patch 4 into patch 3 (Joel)
> - Rework commit messages as per Joels requests
> - Link to v1: https://lore.kernel.org/r/20240222-sysctl-empty-dir-v1-0-45=
ba9a6352e8@weissschuh.net
>=20
> ---
> Thomas Wei=DFschuh (3):
>       sysctl: drop sysctl_is_perm_empty_ctl_table
>       sysctl: move sysctl type to ctl_table_header
>       sysctl: drop now unnecessary out-of-bounds check
>=20
>  fs/proc/proc_sysctl.c  | 19 ++++++++-----------
>  include/linux/sysctl.h | 22 +++++++++++-----------
>  2 files changed, 19 insertions(+), 22 deletions(-)
> ---
> base-commit: 13ee4a7161b6fd938aef6688ff43b163f6d83e37
> change-id: 20231216-sysctl-empty-dir-71d7631f7bfe
>=20
> Best regards,
> --=20
> Thomas Wei=DFschuh <linux@weissschuh.net>
>=20

Signed-off-by: Joel Granados <j.granados@samsung.com>

--=20

Joel Granados

--3lizhmz35mf362ct
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYNGuEACgkQupfNUreW
QU8T3Av/eJ+5OOSngvwI7dB4IXr3PHn/rErRErjheLd9rG+pPC1olHnLPWrD47Fd
cKVZ2wIJcsdCG7MATLNSjGTKG40bBcfd03Y+cDRN5Lz6wU6BLZnrK1TB/iRQXtDY
Xn8CLclZqixyXku7QBheYAQNmwZG5zFHMQQf+4OPEBuVJK/nmYlcIbIbokO7YF+2
eBnJoIyoKBK/9zQrx6AlFtrs0e6tktmWMA5bhpuInkMxu4CiU7zuQFQ125xv/cTi
2emghc3HLsQKLoWtn0o/+lAXdSKAO0eWZrsPgLcR2Und2H8lYG6FgqWxALrA5hkv
boYooXwmcYt+NootCz9yuzZN/OGvKnE5l3fq8ATPtFhI2j5D5g//HzUcRnZoMOB+
PPfSTuXeEDusuDgTHMN0xlYPFqBlnqUfOmh3vamqrJX6bKA/Odt/dPp4+qzuVQx6
jY66k0Ubf15iuAt8lKc16i4wlk+WNhV5fsGFKRpyQfHJYJW90CCVc0iyRHt+13Eq
bGFYoZ+W
=62z1
-----END PGP SIGNATURE-----

--3lizhmz35mf362ct--

