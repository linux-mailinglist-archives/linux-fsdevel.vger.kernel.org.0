Return-Path: <linux-fsdevel+bounces-19497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FEA8C620F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 09:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91D51F221C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 07:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9630E4D9E0;
	Wed, 15 May 2024 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MQrGR2ZE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A94C61C;
	Wed, 15 May 2024 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759317; cv=none; b=r+eAWa2XjK1ouUs4Uvs8D8q5StTUyjA7b7/8u174vGJkktoyWztAhu2fQJqKi/fTmJYyVkP2nykALfnVGvCaIEKYJeM0djZ7ngbIovpGytnl8iw2Kf4QOC1Usgn/KWX98P6xr/1IsuPIpH7R3wnPlfwTsJrKHgFeSKQOSbZSI1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759317; c=relaxed/simple;
	bh=L+EtalBx050GUcRTBDs5CyTU3A4dY5J5H6NqthsqOAg=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=MZs+Pd3ki5DN/f8xcUozjvkz7qq+ZcQ6wHZZQcreGmY1ZWlvgo/c48TQcx1dVCWT+Fu2w4+pWp8Jii4YaoiGT49uCh1bNpOvVngNfAcCD3oVxLzGlHbrT39iDBKFBJQVEOWRtDT//uFrPZXeBlnaaD9mkVwqB9vxp4Mgq84AuWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MQrGR2ZE; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240515074831euoutp0258090f9b2aa48961a96b57cde374bcb4~PmgC_-YLD1085310853euoutp02k;
	Wed, 15 May 2024 07:48:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240515074831euoutp0258090f9b2aa48961a96b57cde374bcb4~PmgC_-YLD1085310853euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715759311;
	bh=L+EtalBx050GUcRTBDs5CyTU3A4dY5J5H6NqthsqOAg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=MQrGR2ZEXb4YYN4zG0ap5F6S14ex7vo2Dl59Nzw2Es2mraalvuiFljcXTKR40z8Al
	 dU2gK0FFswWLqZXflvYUWVgmutgvK4w+wMGh/W8yWwzuBhoCiKb8eAuoK50gug8iEt
	 FDzUqatK6p+en9ntQaIK+9KiRoQlXQ8gP/d7k3zE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240515074830eucas1p17a73c921e92a77ed51bb27cc4f481c1e~PmgCzjSbx3216832168eucas1p1r;
	Wed, 15 May 2024 07:48:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id A8.A4.09624.EC864466; Wed, 15
	May 2024 08:48:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240515074830eucas1p234221fa03210bdc7d16a4f0e7594e1b8~PmgCdLDHy2525825258eucas1p2b;
	Wed, 15 May 2024 07:48:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240515074830eusmtrp15b8e0ebd6f8fc58dd9ce8949c7803f32~PmgCci_c50644306443eusmtrp1C;
	Wed, 15 May 2024 07:48:30 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-a7-664468cea736
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C6.26.08810.EC864466; Wed, 15
	May 2024 08:48:30 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240515074830eusmtip2783d36eab21c5cd6b9dbc07d1dbaa9fd~PmgCRH87R0432804328eusmtip2C;
	Wed, 15 May 2024 07:48:30 +0000 (GMT)
Received: from localhost (106.210.248.3) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 15 May 2024 08:48:29 +0100
Date: Tue, 14 May 2024 15:40:04 +0200
From: Joel Granados <j.granados@samsung.com>
To: Kees Cook <keescook@chromium.org>
CC: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Luis
	Chamberlain <mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] sysctl: constify ctl_table arguments of utility
 function
Message-ID: <20240514134004.vrykjaynv2f5p2fx@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="u33zp4qhf56xbdna"
Content-Disposition: inline
In-Reply-To: <202405131246.C27D85E1@keescook>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djPc7rnMlzSDF4/07c4051rsWfvSRaL
	y7vmsFn8/vGMyeLGhKeMDqwesxsusnhsWtXJ5vF5k5xHf/cx9gCWKC6blNSczLLUIn27BK6M
	eR92sxX85av41LSfpYHxA08XIyeHhICJxJ8vM1m7GLk4hARWMEqs/TGVGcL5wihxtGMWI4Tz
	mVFiz+0/LDAtB9cfgKpazigx5/BPhKptx05BZTYzSqw6+gishUVAVWLZ5+esIDabgI7E+Td3
	mEFsEaD490vNYA3MIKN+zl3KCJIQFvCX6P26HKyBV8BBYvLUdnYIW1Di5MwnYEOZBSokOlv/
	A9kcQLa0xPJ/HCBhTgFdiQOrlrFDnKoose78FaizayVObbnFBLJLQuA/h8S2jv2MEAkXiUf/
	H7BB2MISr45vgWqWkTg9uYcFomEyo8T+fx/YIZzVjBLLGr8yQVRZS7RceQLV4Six8fxfdpCL
	JAT4JG68FYQ4lE9i0rbpzBBhXomONiGIajWJ1ffesExgVJ6F5LVZSF6bhfAaRFhTonX7b3YM
	YW2JZQtfM0PYthLr1r1nWcDIvopRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwYZ3+d/zT
	Dsa5rz7qHWJk4mA8xKgC1Pxow+oLjFIsefl5qUoivCJpzmlCvCmJlVWpRfnxRaU5qcWHGKU5
	WJTEeVVT5FOFBNITS1KzU1MLUotgskwcnFINTIXOG+7nbXl5S+L6WaEAm50tJTs93U8s4r3+
	sWn6JpUst2Vagotd5t/ctvr+i/8C7LP+v3xtH3aab+f/gCdaFwuZhHeufiN8rsQrbNUM/7Uz
	I/fEuC0XlStL0PVRWze7677AijPPP/G/TfuQGtjS9JTTurK77PXEHocfS7it7qTkH0ld7584
	ads21WDRExo7XZ9c95wh/mHVLZ7VXTfUelh+eOcVBXuviUi03bfvrHPSNhFB3jsZrkkrcy/d
	Cfj47VPngwbzTj2eLUtP3IqKMWSyesJzp+ny2saitTr3vhtNb357RqUtsOpr2nwpu4TTIRtu
	ej+sOCN19l3w831BsvXeelfYfMOtr32cVm64R0uJpTgj0VCLuag4EQDg7C6m0wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xe7rnMlzSDE7tEbc4051rsWfvSRaL
	y7vmsFn8/vGMyeLGhKeMDqwesxsusnhsWtXJ5vF5k5xHf/cx9gCWKD2bovzSklSFjPziElul
	aEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MaTevMRX85qto2zaHrYHxHU8X
	IyeHhICJxMH1B5i7GLk4hASWMkpcfLmWHSIhI7Hxy1VWCFtY4s+1LjaIoo+MEr/uTmCEcDYz
	Suzv/AZWxSKgKrHs83Mwm01AR+L8mzvMILYIUPz7pWYwm1lgOaNEx/JqEFtYwFdi65sDTCA2
	r4CDxOSp7ewQQ08wSjw7t58VIiEocXLmExaI5jKJ/+3zgM7gALKlJZb/4wAJcwroShxYtQzq
	akWJdeevsEDYtRKf/z5jnMAoPAvJpFlIJs1CmARhqkusnyeEIgpSrC2xbOFrZgjbVmLduvcs
	CxjZVzGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG7LZjPzfvYJz36qPeIUYmDsZDjCpAnY82
	rL7AKMWSl5+XqiTCK5LmnCbEm5JYWZValB9fVJqTWnyI0RQYiBOZpUST84GpJK8k3tDMwNTQ
	xMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgelEhf6pmXHJ65evbpNa/eKeU076
	wlca84quz5s9e0vrwXJmlTmCt26LXpnbtyeifC9P8Y28xIkXhRu3mXFvt/H4efpqTvyemoz1
	UedFMhZzRp3t3H3qT/Ye17TqPVr7t09ZvezwsQbTX0clGvp3KAaseuTx4yyLDmu+tjRPXme3
	97YQua59ia9ijzN43/6Tu/wGU3udZrjqzdtBH1ulp1xQ8v+UXKW8Nva44UXjkq0G725ucN7r
	sVUudNmsqw2SlubPdBamLm6/9uGv9pmFR8w+Pd4b6ha9y+hJSmmbeOauTS/e9v+dz7G99sIE
	46vyvc3LDB5OyZ73/v6LNaGZMyTW+k2X8eqzrl6aeK6mK0FYiaU4I9FQi7moOBEAYi4sVW0D
	AAA=
X-CMS-MailID: 20240515074830eucas1p234221fa03210bdc7d16a4f0e7594e1b8
X-Msg-Generator: CA
X-RootMTR: 20240513194712eucas1p2f909b8b89a8ea616d8d3defe01000070
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240513194712eucas1p2f909b8b89a8ea616d8d3defe01000070
References: <20240513-jag-constfy_sysctl_proc_args-v1-1-bba870a480d5@samsung.com>
	<CGME20240513194712eucas1p2f909b8b89a8ea616d8d3defe01000070@eucas1p2.samsung.com>
	<202405131246.C27D85E1@keescook>

--u33zp4qhf56xbdna
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 12:47:07PM -0700, Kees Cook wrote:
> On Mon, May 13, 2024 at 11:25:18AM +0200, Joel Granados via B4 Relay wrot=
e:
> > From: Thomas Wei=DFschuh <linux@weissschuh.net>
> >=20
> > In a future commit the proc_handlers themselves will change to
> > "const struct ctl_table". As a preparation for that adapt the internal
> > helper.
> >=20
> > Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
>=20
> Yup, looks good. At what point is this safe to apply to Linus's tree?
> i.e. what prerequisite patches need to land before this?

I was planning to queue this for v6.11. I expect the other patches (1/11 - =
9/11)
will make it to mainline at that point.

This patchset has no dependencies and can easily go into v6.11 as it is tri=
vial,
the generated assember (in x86_64 at least) is unchanged and it has been te=
sted
it in 0-day.

>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>
>=20
> --=20
> Kees Cook

--=20

Joel Granados

--u33zp4qhf56xbdna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmZDaa8ACgkQupfNUreW
QU86cAv/U6DPcIOJ418D9RK38qE1Q4PZx5w896pOud5Hn2URsq03PFwLhj8TfODc
WV6zyKo5KCmoMLJ4DBHFb4ojXYCeRdc5Ne8Q7VW25r4R6iW0w5qxUCcT7sCJ5A7L
eN/B4E20FkAECNlo/BFsznDhAKdAXtw3PqQPddpAslYh/v0guTB+JflFzddrnhPL
w1pYuTCpg0cL33Fp0lQPmcF5xZ2aamL7WOBxtIofav3IWRkQsQ8TV7U6CW7I1k7H
L23nYJgXiZ3K92+Y7OCgWC9PY3lGgncZLunE1wvg/mC4HD/VLAqEYVYhL6375HUs
rN13BYhhwnIGeNNicLHHBFC1xpr9ADKDqoH9gLV1F4xQaOSfVjv3OVz8IFXJHRSV
EhuidPdDdIH8qU08rE4OUoi6qGp/0uzM0j489K/ldaxKoJszfbHUKyBcsDGv+Yua
b7OdfeiWKqrYLQ4qAF+38LVbhkHPdx3hehsi6kS3OXPbXl4/G5To+x4I6Ii67aSp
QpsREEkh
=nYJa
-----END PGP SIGNATURE-----

--u33zp4qhf56xbdna--

