Return-Path: <linux-fsdevel+bounces-14821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799E6880115
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 16:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4B11C2244A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 15:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C6765BA0;
	Tue, 19 Mar 2024 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="N2X9DZKV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AC7651BB;
	Tue, 19 Mar 2024 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863383; cv=none; b=KLbhNRckCfTuUNNhvL2o++RAHIHExF+KEIbimqzAbpN8Q1CRmMfik/digFxl0HrJNJc7doJidC08x1F7qo2BSTMsCLBWaDxnIhKyGKlr8I11LlK3Jl9G0BU8P67d9ioEmk/AB62NzK2pbo8YR1kjzr+tkwjes9sJ1IqP6B34oJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863383; c=relaxed/simple;
	bh=G+RyI8R6Qgj38tnCucu0XynPEdraZhcz13+xzt0MGNE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=aTCG1YGyHPiH3T6/6qG8BEiWSSs6NlbIKWJAs762Xy9tt13UrgOW/WdRnyeAGa2w1/Z04osbgWudez0yzZa+U1vKjhYV8TIUrV+85V9gDUDRc/7sJC9ZnHX8FcBINngThmBtZ0VhYt5sU5A4/G5a1PoUb6PFjpNttnSBJgLA18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=N2X9DZKV; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240319154938euoutp015644aac595b3d7ee08af818b062e397e~_NS23ePKD1433914339euoutp01k;
	Tue, 19 Mar 2024 15:49:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240319154938euoutp015644aac595b3d7ee08af818b062e397e~_NS23ePKD1433914339euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710863378;
	bh=R1lP9UztVoNnnxcHKIoyWO6S39gpnGIuUG/nm9i+hWI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=N2X9DZKVIsyaplpFJ6DHxKrJD//AmzA6htkh4+bYkGzJ7chdVtheYhAJHSy467Mne
	 kTOhEDNNoSwMQsZQApKR/9+CXfVNLd2PY9uEoQlEdVHW+CLtySSHXfq6BkCAq9qKOz
	 ZLW2S/v6zusOaVjrtxG9vMxK99TRmm2InQkur3Lk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240319154938eucas1p1701e43711b4cf34ea45a53766c767010~_NS2sxSlJ2048520485eucas1p13;
	Tue, 19 Mar 2024 15:49:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id DF.4B.09814.214B9F56; Tue, 19
	Mar 2024 15:49:38 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240319154938eucas1p10dd98f7dd53f3e91793bc8d0f34df1ec~_NS2SUOJ-0624406244eucas1p1B;
	Tue, 19 Mar 2024 15:49:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240319154938eusmtrp1dc02a9a7f4c4f7469d1668c38438ab0a~_NS2Roa4M0928109281eusmtrp1Z;
	Tue, 19 Mar 2024 15:49:38 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-e4-65f9b412fad0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 20.10.10702.214B9F56; Tue, 19
	Mar 2024 15:49:38 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240319154938eusmtip12e13b71a488975293555f9019ec9c3f1~_NS2FPMQv0255302553eusmtip1E;
	Tue, 19 Mar 2024 15:49:38 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 19 Mar 2024 15:49:37 +0000
Date: Tue, 19 Mar 2024 16:49:35 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/4] sysctl: move sysctl type to ctl_table_header
Message-ID: <20240319154935.a3ase52pvuvrqz22@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="zeom3d6o35odsrdw"
Content-Disposition: inline
In-Reply-To: <20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djPc7pCW36mGvQ9Ubf4v62F3eJMd67F
	nr0nWSwu75rDZvH7xzMmixsTnjI6sHnMbrjI4rFpVSebx+dNch793cfYPaYcamcJYI3isklJ
	zcksSy3St0vgypi+dg97wQ7hioY3H1kbGG8LdDFyckgImEj8unyRqYuRi0NIYAWjxJqNR6Gc
	L4wSa2e1s0A4nxkl1k3fwQzTMq9xIStEYjmjxKyJ+5ngqg4/nQXVspVR4t+K5YwgLSwCqhKz
	n51nB7HZBHQkzr+5AzZKRMBGYuW3z+wgDcwCe4FGvZgPViQs4Cpxr+ceWBGvgIPE1KPzoGxB
	iZMzn7CA2MwCFRJTfz8DsjmAbGmJ5f84QMKcAp4S6zdMZYE4VVni+r7FbBB2rcSpLbfALpUQ
	6OeU6Hv8F6rIRaL1/xyoImGJV8e3sEPYMhKnJ/ewQDRMZpTY/+8DO4SzmlFiWeNXJogqa4mW
	K0/YQa6QEHCUWNnnAmHySdx4KwhxJ5/EpG3TmSHCvBIdbUIQjWoSq++9YZnAqDwLyWezkHw2
	C+EziLCexI2pU9gwhLUlli18zQxh20qsW/eeZQEj+ypG8dTS4tz01GKjvNRyveLE3OLSvHS9
	5PzcTYzAFHb63/EvOxiXv/qod4iRiYPxEKMKUPOjDasvMEqx5OXnpSqJ8LJz/0wV4k1JrKxK
	LcqPLyrNSS0+xCjNwaIkzquaIp8qJJCeWJKanZpakFoEk2Xi4JRqYHLZpbFw1QymF+yzog91
	GOzI3l95y2bGXF7jUo9zr7YfW/k4tcv8XH74BJm5FbaLnp5PWqx1Yel098BrOxhNziUyVSyJ
	EjSamjPNbdu2yApp/4z6+s3lIfknlr94ED/nmqJZ5LW3/J0VQgpf9v+P/7JPRNH8MOdk99g0
	7kMFCXk9F8/2af1T1l0hdDwhetMM4bKjMgusk8TYLTn7zNXmP321nm/Jnr3RGp+65WVF+SU2
	7Njc7/Ayal9E2VvFLudbTx9euTm1Myjhxt1rv7c8sb9r/L3hwMUPOo+2sMzkbJjqzpMSql2o
	ovI8X+zkgYneE9wTNRO219/aY/W/bkbFq927rLSLXqhUVLzKnZqWdk2JpTgj0VCLuag4EQAX
	2oZe3AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xu7pCW36mGkw/xWXxf1sLu8WZ7lyL
	PXtPslhc3jWHzeL3j2dMFjcmPGV0YPOY3XCRxWPTqk42j8+b5Dz6u4+xe0w51M4SwBqlZ1OU
	X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7G617Rgm3BF
	+6JnzA2MNwW6GDk5JARMJOY1LmTtYuTiEBJYyihxbP8OdoiEjMTGL1dZIWxhiT/Xutggij4y
	Sizb3ckEkhAS2MooMfFEKIjNIqAqMfvZebBmNgEdifNv7jCD2CICNhIrv31mB2lmFtjLKDHr
	xXywImEBV4l7PffAingFHCSmHp3HDDHUQ+L/8X1QcUGJkzOfsIDYzAJlEo/OTgayOYBsaYnl
	/zhAwpwCnhLrN0xlgThUWeL6vsVsEHatxOe/zxgnMArPQjJpFpJJsxAmQYR1JHZuvcOGIawt
	sWzha2YI21Zi3br3LAsY2VcxiqSWFuem5xYb6RUn5haX5qXrJefnbmIExvC2Yz+37GBc+eqj
	3iFGJg7GQ4wqQJ2PNqy+wCjFkpefl6okwsvO/TNViDclsbIqtSg/vqg0J7X4EKMpMBQnMkuJ
	JucDk0teSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAPTSst9nkw2
	s+UPrZ63baWy4UX1e2oWbWdDnqeJWSXKHIhZx32o/beEm4ngy1lKjXyfZlT/2HGBIz7wd+zf
	Y+uXyb1QCqi2+vzihmQ6779oRpfq+LWRyeqqZVc5ZlyQu1Fv/2AV+45nQWHOnM1OTlaCs/fP
	u5K5aauWbAy/TWLztrpnbddVzyx7GlnK8pbju5Df8lL5/oPzJ6+bq/bz9dvX15bzn0iMSnHf
	qTj7vN/b2Tc2LPdXSchZ3BXEmFsRyf7Ecy5nnG/8gWDeeI7EU9H+SwV2VjX/qgvoVWjauTQp
	7Lzdx321nw/GTJlXOFc6+mCI/x62y2pqX52+sk1zTIxVCpPoLORNET508OOhszlKLMUZiYZa
	zEXFiQCjkdkgdgMAAA==
X-CMS-MailID: 20240319154938eucas1p10dd98f7dd53f3e91793bc8d0f34df1ec
X-Msg-Generator: CA
X-RootMTR: 20240319154938eucas1p10dd98f7dd53f3e91793bc8d0f34df1ec
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240319154938eucas1p10dd98f7dd53f3e91793bc8d0f34df1ec
References: <20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@weissschuh.net>
	<CGME20240319154938eucas1p10dd98f7dd53f3e91793bc8d0f34df1ec@eucas1p1.samsung.com>

--zeom3d6o35odsrdw
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 08:07:35AM +0100, Thomas Wei=DFschuh wrote:
> Praparation series to enable constification of struct ctl_table further
> down the line.
> No functional changes are intended.
Took me some time but I finally got around to it. I just had comments
regarding the commit messages. I'll add this to sysctl testing to get
the ball rolling; I'll add it to sysctl-next after you modify the commit
messages.

Thx.

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
> Thomas Wei=DFschuh (4):
>       sysctl: drop sysctl_is_perm_empty_ctl_table
>       sysctl: move sysctl type to ctl_table_header
>       sysctl: drop now unnecessary out-of-bounds check
>       sysctl: remove unnecessary sentinel element
>=20
>  fs/proc/proc_sysctl.c  | 19 ++++++++-----------
>  include/linux/sysctl.h | 22 +++++++++++-----------
>  2 files changed, 19 insertions(+), 22 deletions(-)
> ---
> base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
> change-id: 20231216-sysctl-empty-dir-71d7631f7bfe
>=20
> Best regards,
> --=20
> Thomas Wei=DFschuh <linux@weissschuh.net>
>=20

--=20

Joel Granados

--zeom3d6o35odsrdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX5tA8ACgkQupfNUreW
QU+3JQv/Vzo9AyQraFidBTpoHTIFJw/b4gouckAz5RkfeG+55wcKHnJjv8gRZG27
Hf9/Bx6O9zchi0jnKT+i0JH5CeXY7yIym09/9Pu7z2EE+rcUnk67pKcU3CtLTsPn
fj/eHMNau4rO3Ozqtg003AbuXDa86sInKtfaDVxOzEIaubM7BYd2sSfp44xwnoZm
XI63wvl76FWgcFacfEizi5UzhZhXrzoT/pipwBUyCgtCccHJUgSXgyAZgOAD5M7J
JG8ytuNrLgpRvdvqQEvizVlxKBnE6qsRvsN0GuTC4iHKFQw3fFqjW5xsiNLoxKCX
o64qSqkzLD7ZyLUj21UtnqrCmrTavxuFj3Eqh3X4ZQXVGkyGhgjr3SiNMahqM19H
r1gkjNTIgV1irklPBM3Yrip7zx27xjOwMJooiBakqavOVdrZbWlh21pcgHR1C79K
wEpqm310ccLwndvmQ2dIQUEYWHjLGWiTZc5jl0gue4n5ruE8Id6RGaxjfmKIRRl0
ZF/E8W+1
=SbYd
-----END PGP SIGNATURE-----

--zeom3d6o35odsrdw--

