Return-Path: <linux-fsdevel+bounces-6346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178628162B1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 22:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D03D1C21430
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 21:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167F049F75;
	Sun, 17 Dec 2023 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GBPA4TVp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E56495CC;
	Sun, 17 Dec 2023 21:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231217215726euoutp019e5c3b2b2c71861faad3304a5b37e3b6~hvUbTW8Lj3227732277euoutp01e;
	Sun, 17 Dec 2023 21:57:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231217215726euoutp019e5c3b2b2c71861faad3304a5b37e3b6~hvUbTW8Lj3227732277euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702850246;
	bh=8kL2iu7jHJCnGZQRJQGLye+WnPmV08lVx5qGR/60XIw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=GBPA4TVpw6t9F4C4IStWFu8ZLhNTH69ockfV5zMwv+8YtxhsNEEOCIN4GfZLnBChz
	 UY51mxNo2RxMXT7Z6YcjIKIiBJcCvkP+1SDe8Jho39KChZHF/+at+yBhwl/OxrYrzr
	 pM8gblsY+zQB5erlBwAliJ0ZEqTIVvBT/VJS5shA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231217215725eucas1p1e3521107db514c1322024211c3987946~hvUaYwVuG1248212482eucas1p1q;
	Sun, 17 Dec 2023 21:57:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id F5.6B.09814.4CE6F756; Sun, 17
	Dec 2023 21:57:24 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231217215723eucas1p14b0249669ada55b18e720ed9306e9724~hvUZPZJ6h0989509895eucas1p1_;
	Sun, 17 Dec 2023 21:57:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231217215723eusmtrp1f4d6a976979ac69fe8f83e7c1da6df57~hvUZO3jVI0481104811eusmtrp1e;
	Sun, 17 Dec 2023 21:57:23 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-08-657f6ec4fe46
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 1D.85.09146.3CE6F756; Sun, 17
	Dec 2023 21:57:23 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231217215723eusmtip123b2517557f6daa17d893b14931c74fb~hvUZClgzE1595815958eusmtip1l;
	Sun, 17 Dec 2023 21:57:23 +0000 (GMT)
Received: from localhost (106.210.248.232) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sun, 17 Dec 2023 21:57:22 +0000
Date: Sun, 17 Dec 2023 13:02:01 +0100
From: Joel Granados <j.granados@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Julia Lawall
	<julia.lawall@inria.fr>, Kees Cook <keescook@chromium.org>, Thomas
	=?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Iurii Zaikin <yzaikin@google.com>, Greg
	Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <20231217120201.z4gr3ksjd4ai2nlk@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="mrjpp4nfvufc32be"
Content-Disposition: inline
In-Reply-To: <ZXligolK0ekZ+Zuf@bombadil.infradead.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7djPc7pH8upTDWbPsbb4MK+V3aJ58Xo2
	i18Xp7FaNK3qZ7Y4051rsWfvSRaLeet/Mlpc3jWHzeL3j2dMFjcmPGW0WLbTz4HbY3bDRRaP
	BZtKPSa9OMTisWlVJ5vHnWt72Dz2z13D7vF5k5xHf/cx9gCOKC6blNSczLLUIn27BK6Mz1+/
	shfsl6zo+vaKpYFxlmgXIyeHhICJRMPhNYxdjFwcQgIrGCVmHu5nhXC+MEo0b37LClIlJPCZ
	UeLmPR6YjkNvO6CKljNKzFr/kx3CASpqnPONHaJjK6PE243iIDaLgKpE+/6bTCA2m4COxPk3
	d5hBbBEBDYl9E3qZQJqZBRYxS0w8/pali5GDQ1jAQWJbkyRIDa+AucTKg/fZIGxBiZMzn7CA
	2MwCFRKz9uwDK2cWkJZY/o8DJMwpYCZxc9NGJohDlSWuz3wBZddKnNpyC2yVhMApTomnXTvZ
	IBIuEg8n/GGFsIUlXh3fwg5hy0icntzDAtEwmVFi/78P7BDOakaJZY1focZaS7RceQLV4Six
	bu5SVpCLJAT4JG68FYQ4lE9i0rbpzBBhXomONiGIajWJ1ffesExgVJ6F5LVZSF6bhfAaRFhH
	YsHuT2wYwtoSyxa+ZoawbSXWrXvPsoCRfRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZg
	Kjz97/iXHYzLX33UO8TIxMF4iFEFqPnRhtUXGKVY8vLzUpVEeBesrU4V4k1JrKxKLcqPLyrN
	SS0+xCjNwaIkzquaIp8qJJCeWJKanZpakFoEk2Xi4JRqYCrh+83Cf/NOvsxzc7MyR+92591y
	D2x+zXl+IPE619clcSfWPwi8uPf88607vK99vx++pZVxm8snO6Znp+dumvkloiVkjuJl89oI
	pfL4v1q2bUEM9RJCbOF8i6r37//dkXnmtYHmOz9toWc3Duj0O7xat7i3vFdZ/WJ7yVqO1oPq
	Ey+FfbonF7r8nGzLG1nnN6JvMs8fLzjdOOP88nWZk04LvFlwODKh4QiHxBouM2H9Rq76fdZb
	0ytbIr7l6rpeundp6aEDnS+j5vxcuYd58YPE+Mt5N9jzluu9aD/OGtmuaSk2pd5vQ+3Oxpap
	3usu8xi0198vftGe//iDlqrOuxwR8YORJYL7eO/s2Pf6moYSS3FGoqEWc1FxIgAtY1N6AAQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42I5/e/4Xd3DefWpBlvatC0+zGtlt2hevJ7N
	4tfFaawWTav6mS3OdOda7Nl7ksVi3vqfjBaXd81hs/j94xmTxY0JTxktlu30c+D2mN1wkcVj
	waZSj0kvDrF4bFrVyeZx59oeNo/9c9ewe3zeJOfR332MPYAjSs+mKL+0JFUhI7+4xFYp2tDC
	SM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/jyNU21oK9khUbF7azNTDOEO1i5OSQ
	EDCROPS2g7WLkYtDSGApo8TRpgPsEAkZiY1frrJC2MISf651sUEUfWSU2NZ1hhEkISSwlVHi
	59YkEJtFQFWiff9NJhCbTUBH4vybO8wgtoiAhsS+Cb1MIM3MAouYJWY2XwdKcHAICzhIbGuS
	BKnhFTCXWHnwPhvEzE3MEptvBEDEBSVOznzCAmIzC5RJrJq9iAmklVlAWmL5Pw6QMKeAmcTN
	TRuZIO5Ulrg+8wWUXSvx+e8zxgmMwrOQTJqFZNIshEkQYS2JG/9eYgprSyxb+JoZwraVWLfu
	PcsCRvZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgelg27Gfm3cwznv1Ue8QIxMH4yFGFaDO
	RxtWX2CUYsnLz0tVEuFdsLY6VYg3JbGyKrUoP76oNCe1+BCjKTAQJzJLiSbnAxNVXkm8oZmB
	qaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDU0L3oY+NZ25/YOz2ELI5FS57
	517w5gA9M85Z7zgWrxMVaTgpJ/vq1AOBdrPTN+1Vd28pXqnCctahR9xuWb/QNM8rv//OcFvo
	8OnFxEprQbWAVLZjdodLQjjlNGfkS253fHPB9bbkH/0H8StenHu+j7d77vkQtmny8i+MrJ4G
	z2lJ6XM1Nj3ywuDngUlrO60rErd98XcOYa/lurhx/eugTz3JDjXbd298lfHySdm+ktLEPWz7
	VBdeNGrS6LgWfuh/iG+MxYH+qRzs95YubDTWnh1Uxbt1fuKrR9cXpK9+wJhxrNPJoHH7ZF0V
	lhOPTuQ7SDkwZcpIOF8Kv7U97NEr7djIjBON3sFZJhOq36v2KrEUZyQaajEXFScCAM/7cMyc
	AwAA
X-CMS-MailID: 20231217215723eucas1p14b0249669ada55b18e720ed9306e9724
X-Msg-Generator: CA
X-RootMTR: 20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25
References: <CGME20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25@eucas1p2.samsung.com>
	<20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
	<20231207104357.kndqvzkhxqkwkkjo@localhost>
	<fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de>
	<20231208095926.aavsjrtqbb5rygmb@localhost>
	<8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de>
	<20231212090930.y4omk62wenxgo5by@localhost>
	<ZXligolK0ekZ+Zuf@bombadil.infradead.org>

--mrjpp4nfvufc32be
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Catching up with mail....

On Tue, Dec 12, 2023 at 11:51:30PM -0800, Luis Chamberlain wrote:
> On Tue, Dec 12, 2023 at 10:09:30AM +0100, Joel Granados wrote:
> > My idea was to do something similar to your originl RFC, where you have
> > an temporary proc_handler something like proc_hdlr_const (we would need
> > to work on the name) and move each subsystem to the new handler while
> > the others stay with the non-const one. At the end, the old proc_handler
> > function name would disapear and would be completely replaced by the new
> > proc_hdlr_const.
> >
> > This is of course extra work and might not be worth it if you don't get
> > negative feedback related to tree-wide changes. Therefore I stick to my
> > previous suggestion. Send the big tree-wide patches and only explore
> > this option if someone screams.
>
> I think we can do better, can't we just increase confidence in that we
> don't *need* muttable ctl_cables with something like smatch or
> coccinelle so that we can just make them const?
>
> Seems like a noble endeavor for us to generalize.
>
> Then we just breeze through by first fixing those that *are* using
> mutable tables by having it just de-register and then re-register
So let me see if I understand your {de,re}-register idea:
When we have a situation (like in the networking code) where a ctl_table
is being used in an unmuttable way, we do your {de,re}-register trick.

The trick consists in unregistering an old ctl_table and reregistering
with a whole new const changed table. In this way, whatever we register
is always const.

Once we address all the places where this happens, then we just change
the handler to const and we are done.

Is that correct?

If that is indeed what you are proposing, you might not even need the
un-register step as all the mutability that I have seen occurs before
the register. So maybe instead of re-registering it, you can so a copy
(of the changed ctl_table) to a const pointer and then pass that along
to the register function.

Can't think of anything else off the top of my head. Would have to
actually see the code to evaluate further I think.

> new tables if they need to be changed, and then a new series is sent
> once we fix all those muttable tables.
>=20
>   Luis

best

--=20

Joel Granados

--mrjpp4nfvufc32be
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmV+4ycACgkQupfNUreW
QU9waAv7Bij7q2r+fK7GyD40a3pScuLmF3v3KHlHLzaG9jYC5dY+vvpSIDkJtHyx
VZId3JgPoMl2dSB4Nj0FoRoA/f2SJRex0kLUWU8Xj15+cvfWJ2IreNfDOJRhN0gu
MGFiae6AvEFELn0Z9yMiRnx0bgyUFvaKl7VZCw+9iYKjcMGhEZpagCrmuzUrEkZr
WrhjyUNjJtSL472JDq3nha46nmfSjNV/Yi+MvTBI5acVKUiDtKAc1PBHZp2anyeC
ohVni43geKFEMUBLquqG6H8xmP61Sg+3ByUVvH4jzpI9ys7UAYv27T2fuFexGdoc
qgQz5Z3cMWiulftWlrnpmyrNOL/dsM75k8jAAvdQi9o1Rw0Yi3tG04C0M1nxYEnj
mySmxuSFhfhxDSLhKJfVHLtVIQKbT9lZa2zns6Js3U7YlfCeWUKb5W/vku7JQPoI
sO6NGrTs8mcAvu/oErQf9K1UBxRc6cn6an+P2wyScjGpvq+36EUZ1GCZQv8uJiUz
NyiBFfLp
=d63B
-----END PGP SIGNATURE-----

--mrjpp4nfvufc32be--

