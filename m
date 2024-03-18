Return-Path: <linux-fsdevel+bounces-14739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A385B87E948
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 13:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E38282DCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 12:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDDE383B2;
	Mon, 18 Mar 2024 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uwSX7F02"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585838398;
	Mon, 18 Mar 2024 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710764768; cv=none; b=X6dGUzhZa2VbLV9RqnzDHflnVqrqDhO9k+9vsNxHiC/scUUX3hYZiWl3wzoOfuGDoXmF6XWM/0MY8RLunHT0LDwUX0CH42BpA/EkMK2PzxkLF9o2GJMRihC/ybZ93DKC2gh2abG/Ht/qpEGo9L03TER7JcFUTnRLEwdhtc0MhUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710764768; c=relaxed/simple;
	bh=rF1nYQfJZtAcNucGFaDUMYIM4wo5rd2ny9Mj7iywuuU=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:References; b=oRuBk+86EJ6jS3BrDF5kKVRrsacDyq7cqKL9SsCoEltkjfwkeqUOhpm+paVmcTlzaQSPvXi+tiGSHpCKvdBmnDPfcvajUo7TLX3XCj0kB6uVW7+FiLJN+SKL1/71ysd/EIfWIrFxVrWziXuchh0gef9vlbF/EWtHfVIj5vYmOGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uwSX7F02; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240318122603euoutp02cadfea3ae7254f90e7dd3135fdc01cd8~923zxVhds1192611926euoutp02x;
	Mon, 18 Mar 2024 12:26:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240318122603euoutp02cadfea3ae7254f90e7dd3135fdc01cd8~923zxVhds1192611926euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710764763;
	bh=9ISV03sLSYg+Ji4RYTLq5+G6F3VX+0M358tsX375Hio=;
	h=Date:From:To:CC:Subject:References:From;
	b=uwSX7F02yPSTh85dqfYMtbNtMbEpWDUAcb928qHkcwkasmN/cuuFDD0Y0LAarSVw4
	 uv90TtaqBed1r6buusvLijFAfU7BdVWG5tdF1DSrGX/olu2YRq2hpEDWzys4BN2DEY
	 XLLVwN3pwN0rhbAO8f/4to2MkifzsltCDeViCTTg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240318122602eucas1p2a61c9af9795fe9ce42e12c65077fea4c~923zaxcht3248932489eucas1p22;
	Mon, 18 Mar 2024 12:26:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 2F.E8.09539.AD238F56; Mon, 18
	Mar 2024 12:26:02 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240318122602eucas1p1d7761ac44909f55a8bb369982d2e0adb~923y-TqyT1057110571eucas1p18;
	Mon, 18 Mar 2024 12:26:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240318122602eusmtrp243bc7dea7dcd83a9154d3bf7fc8e9b74~923y_c9Gw2904929049eusmtrp2g;
	Mon, 18 Mar 2024 12:26:02 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-c2-65f832da7a4b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id B0.C8.09146.AD238F56; Mon, 18
	Mar 2024 12:26:02 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240318122602eusmtip276a91ecf423c8f17d9af802e6a472968~923yxn1ZV3160831608eusmtip2H;
	Mon, 18 Mar 2024 12:26:02 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 18 Mar 2024 12:26:01 +0000
Date: Mon, 18 Mar 2024 13:25:59 +0100
From: Joel Granados <j.granados@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	Thomas =?utf-8?B?V2Vp77+9c2NodWg=?= <linux@weissschuh.net>, Christian
	Brauner <brauner@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, Joel Granados <j.granados@samsung.com>
Subject: [GIT PULL] sysctl changes for v6.9-rc1
Message-ID: <20240318122559.jedemqmrgms2wmgq@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="f7ih5wzwo5v4lgn4"
Content-Disposition: inline
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djP87q3jH6kGqxbqmnx+vAnRosz3bkW
	e/aeZLG4vGsOm8XvH8+YLG5MeMpo8ajvLbsDu8fshossHptWdbJ5nJjxm8Xj8yY5j/7uY+wB
	rFFcNimpOZllqUX6dglcGbN+nGIrWCJVsWdZI0sD41qxLkZODgkBE4m9DxYwdjFycQgJrGCU
	+L59MjuE84VR4nz/YVaQKiGBz4wS/4/UwnQc2t3OBFG0nFHiysWnUO1ARSeP7YNyNjNKLLn1
	Gaidg4NFQFVi5pQYkG42AR2J82/uMIPYIgJGEp9fXGEFqWcWmMckseXQW7CEsIC+RN+V1Ywg
	Nq+Ag8Tz21tYIWxBiZMzn7CA2MwCFRKnt25jBpnPLCAtsfwfB8R1ihJfF99jgbBrJU5tuQV2
	qYTAfw6Jvdt/s0EkXCTmXTjCBGELS7w6voUdwpaR+L9zPlTDZEaJ/f8+sEM4qxklljV+heqw
	lmi58gSqw1Gitf0O2JcSAnwSN94KQhzHJzFp23RmiDCvREebEES1msTqe29YIMIyEuc+8U1g
	VJqF5LNZSD6bhfAZRFhTonX7b3YMYW2JZQtfM0PYthLr1r1nWcDIvopRPLW0ODc9tdgwL7Vc
	rzgxt7g0L10vOT93EyMwkZ3+d/zTDsa5rz7qHWJk4mA8xKgC1Pxow+oLjFIsefl5qUoivK5i
	X1OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ86qmyKcKCaQnlqRmp6YWpBbBZJk4OKUamFKPTWps
	fvYprLKrYcu9eIGkVQu4ZcK/yre7SGR9O+29JcHtfIdLa8DE1y/t/uk25VdKlHG9u3LS/Vl+
	OluB+R/tRylu57Uee5UkMCvvyPGN4Hg1o+/J33dfedueCdqnrgv+ySlrYHHxeszt7+e+BvI8
	NxTOWfCoiG+R006Wg8wbpvyq2z15KduR6xITFNkj3vAqnNrJtsxfpr60SuD/p1iZM7ybJXsT
	ni07oX1Q9cuqG9feyF8veKkp5F6hEMYzI2hWz7d9zdKOllJnHBYfXvPsonTcrsTCtG9afn7W
	VVM3VgT4XvqVtuajSaDdxIXBnFf5HTbon4hUUYlf+7V+da/e4TNfuv4dED7JNqtqoRJLcUai
	oRZzUXEiAFyzLJnfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7q3jH6kGlxey2Px+vAnRosz3bkW
	e/aeZLG4vGsOm8XvH8+YLG5MeMpo8ajvLbsDu8fshossHptWdbJ5nJjxm8Xj8yY5j/7uY+wB
	rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GR8/
	SBYskqp4sbCVpYFxtVgXIyeHhICJxKHd7UxdjFwcQgJLGSXmzP/EBJGQkdj45SorhC0s8eda
	FxtE0UdGic6195lBEkICmxkl7vbbdzFycLAIqErMnBIDEmYT0JE4/+YOWImIgJHE5xdXWEF6
	mQXmMUlMPPwGbKiwgL5E35XVjCA2r4CDxPPbW1ghbEGJkzOfsIDMZBYok+ieaglhSkss/8cB
	cY6ixNfF91gg7FqJz3+fMU5gFJyFpHkWQvMshGYIU11i/TwhFFFOIFNbYtnC18wQtq3EunXv
	WRYwsq9iFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjMptx35u3sE479VHvUOMTByMhxhVgDof
	bVh9gVGKJS8/L1VJhNdV7GuqEG9KYmVValF+fFFpTmrxIUZTYEhNZJYSTc4Hpou8knhDMwNT
	QxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQamsLwMya2cWckF8mkbRIouPbFI
	bng/tfS90oKEWueWloNLmUwqjot/M7qVcmSeg9bbbylGdqI6Ur+Tfmv78B7WF3N52GzsoTaL
	++ryOnl25huxl6zX7lJUUu6f0LtQxHVmj5kqI9uGk1q3P4dmGN9g2Lh2rV5P0FmRD8+ZlTTZ
	fDZmHfivZfwo+ctZyUfaGke2/2NfdnPLp+Wbr/K/v1oZImlT6L3qh0/eyYknRO+vkhWfJ3P+
	pWdyzM/Q5U5PPjOFLc6wcv45KeuSXethk7zMuOMx2kZ7ufaL8MkeSM0/e2xq/4zOaboy37un
	mB5kTAs78IbnTeWhKa0v75Yc8zvlYr0nxenEjReL3KRqwpcosRRnJBpqMRcVJwIACMwyZl8D
	AAA=
X-CMS-MailID: 20240318122602eucas1p1d7761ac44909f55a8bb369982d2e0adb
X-Msg-Generator: CA
X-RootMTR: 20240318122602eucas1p1d7761ac44909f55a8bb369982d2e0adb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240318122602eucas1p1d7761ac44909f55a8bb369982d2e0adb
References: <CGME20240318122602eucas1p1d7761ac44909f55a8bb369982d2e0adb@eucas1p1.samsung.com>

--f7ih5wzwo5v4lgn4
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Note: Since I'm new, you probably need to pull in my PGP key; its located
in keys/5895FAAC338C6E77.asc in https://git.kernel.org/pub/scm/docs/kernel/=
pgpkeys.git

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sys=
ctl-6.9-rc1

for you to fetch changes up to 4f1136a55dc8e2c27d51e934d0675e12331c7291:

  scripts: check-sysctl-docs: handle per-namespace sysctls (2024-02-23 12:1=
3:09 +0100)

----------------------------------------------------------------
sysctl changes for v6.9-rc1

I'm sending you the sysctl pull request after following Luis' suggestion to
become a maintainer. If you see that something is missing, get back to me w=
ith
how to improve and I'll include your feedback in the following PRs.

Here is a summary of the changes included in this PR:
* New shared repo for sysctl maintenance
* check-sysctl-docs adjustment for API changes by Thomas Wei=DFschuh

This is a non-functional PR. Additional testing is required for the rest of=
 the
pending changes. Future kernel pull requests will include the removal of the
empty elements (sentinels) from sysctl arrays in the kernel/, net/, mm/ and
security/ dirs. After that, the superfluous check for procname =3D=3D NULL =
will be
removed. And the push to avoid bloating the kernel as these arrays move out=
 of
kernel/sysctl.c will be completed.

Even though Thomas' changes went into sysctl-next after v6.8-rc5 (3 weeks in
linux-next), I include them as they contained no functional changes and
therefore have little chance of resulting in an error/regression. Finally t=
he
new shared repo is now picked up by linux-next and is the source for upcomi=
ng
sysctl changes.

----------------------------------------------------------------
Joel Granados (1):
      MAINTAINERS: Update sysctl tree location

Thomas Wei=DFschuh (3):
      scripts: check-sysctl-docs: adapt to new API
      ipc: remove linebreaks from arguments of __register_sysctl_table
      scripts: check-sysctl-docs: handle per-namespace sysctls

 MAINTAINERS               |  2 +-
 ipc/ipc_sysctl.c          |  3 +--
 scripts/check-sysctl-docs | 65 +++++++++++++++++++++++--------------------=
----
 3 files changed, 34 insertions(+), 36 deletions(-)

--f7ih5wzwo5v4lgn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX4Ms4ACgkQupfNUreW
QU/cswwAkrOHgNASPamOkHPqYwtOgFftXM4NVFODehDyBn/99dHTOYRARoZM3R5m
Mxp+3NutRMLhLp2DPXHwLwPZAX6GrJSlG2NWR4p16dawl2No4ZyBuE956Yq6e1Ut
6FuL79Co5Lk1hPknd6cdHT0ZEBEBV2/zSfAG9T63zUCJVfzlx47hGWJcrv040QJ9
70gcm9SE8X38FcIKWxO+eX+2XqVxdtDyGHS6A3EIJsUaAurElWdlOl9ImfjrXdme
H+hXMRdJxlgorkce11cAi4HkVOK9YEA1Sfd63WMm76IQRHaKKlip9eRHraceIXYT
LEPEGH/8d7RTSyamZyeuaqIJiI/Wjd2cbJzpHWEMAfhDqVHjzZjbsmCfSFn6E+Rj
u9smEweF2wl2E2mV4LL+AULlKmSiSCCd7SxUCQx63Ltrt3/xp4hAt/5EC8jMm8mg
19Rq07eTbRwwdaNY0umlqOxTI+qtdKD9CnI5raN9c/bUcXFgQgZ4yan9ScMVRi8+
33aPoJoa
=jzod
-----END PGP SIGNATURE-----

--f7ih5wzwo5v4lgn4--

