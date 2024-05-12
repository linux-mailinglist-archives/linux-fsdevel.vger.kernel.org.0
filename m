Return-Path: <linux-fsdevel+bounces-19352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635B78C3823
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 21:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E3D28238F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 19:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01425476B;
	Sun, 12 May 2024 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OuZ7VBPm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844FA50277;
	Sun, 12 May 2024 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715541911; cv=none; b=mu1jsMGIlfef03aKJFPX76dLpdXH/7i1owvtaIRyoMyrEFmnxopzDOBbeVSQJAs/NqysPIKDTe1nNgSQJvecy4FgrIV10WAIORYTUpe1/P+hcz7JP+Gm+yt8/6g1z/ekZxYlEV7WkK0exie2qS/4JTi7yZp5RUZY97xX4wJZBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715541911; c=relaxed/simple;
	bh=AhqJjtjzxCOMPbPhOlZJHNiQIPD1qhMc2zICfWrrYgw=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=qx2kapXrD63OSgc5pR8bfXbqXsvzDAZNozQEKQW7obRknRc/yCbz7cXYuRdOTQJxrrdfFL0rqLD+zb3ZEkminzlYvNnnwrxFFbEOif3FmdlaksM4gqKLOrHQGCULdN5PZIfINQ6wqIky17A90LOCxDYKsp4gRiE3ePEB0De7j9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OuZ7VBPm; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240512192459euoutp02821aac07226f8a2db5194d73dcf99b4e~O1ESVsCJR2437724377euoutp02b;
	Sun, 12 May 2024 19:24:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240512192459euoutp02821aac07226f8a2db5194d73dcf99b4e~O1ESVsCJR2437724377euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715541899;
	bh=AhqJjtjzxCOMPbPhOlZJHNiQIPD1qhMc2zICfWrrYgw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=OuZ7VBPmkb7GFFVnzlX4Xu3m7hSAa0rrviG0vbIWnIKgU+TJgw9zH8nxqiur/bL6o
	 M7OMI4tz1/mWTWbqXXvIrwiyjKVk4zjtChcHQasIaqAhOS2cQTQAMVbVOIHdza6akW
	 58y0JTV9EOsvNU8hQT438Y8v6wllbKKjS29Q7FR8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240512192458eucas1p2eab8e039a414a72a34a339fbe5ca9e81~O1ER0VNb73073930739eucas1p2D;
	Sun, 12 May 2024 19:24:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id EF.31.09875.A8711466; Sun, 12
	May 2024 20:24:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240512192457eucas1p1c2e524298e130efc58f1e66cc0f38039~O1ERRMgkM1116711167eucas1p1G;
	Sun, 12 May 2024 19:24:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240512192457eusmtrp17aafdb49baa334c3f4286e36fb7018cf~O1ERQYpCs2380323803eusmtrp1O;
	Sun, 12 May 2024 19:24:57 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-6e-6641178a9d21
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id BF.A2.08810.98711466; Sun, 12
	May 2024 20:24:57 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240512192457eusmtip1388a0eba49a1f62b378d13466cb997f2~O1EQ_bBsU2825928259eusmtip1W;
	Sun, 12 May 2024 19:24:57 +0000 (GMT)
Received: from localhost (106.210.248.15) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sun, 12 May 2024 20:24:56 +0100
Date: Sun, 12 May 2024 21:24:51 +0200
From: Joel Granados <j.granados@samsung.com>
To: Kees Cook <keescook@chromium.org>
CC: Jakub Kicinski <kuba@kernel.org>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
	<linux@weissschuh.net>, Luis Chamberlain <mcgrof@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Dave Chinner <david@fromorbit.com>,
	<linux-fsdevel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-security-module@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-xfs@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <kexec@lists.infradead.org>,
	<linux-hardening@vger.kernel.org>, <bridge@lists.linux.dev>,
	<lvs-devel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>, <linux-sctp@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <apparmor@lists.ubuntu.com>
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <20240512192451.wpswazhpualwvt63@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="3bxd2gyoppot6odw"
Content-Disposition: inline
In-Reply-To: <202405080959.104A73A914@keescook>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSe0xTVxzHPbe395YmdZeKcAYbC+Ux2BTmHvHsIY/FmJtlf2CMMdsSZ5XL
	SyistcBcjIUyQV5jQIQiw4IMCCDOUjsGKA6hDKjCEBjbSHXlIeE1nvIo1LXcupnsv8/ve77f
	c76/5PA4wjHClRclOcNIJeIYEcHHdfr13r0ZLiHhb6xM7EbJejUXLbV3Ekh3NRNDWz+lcZBW
	bwRoXG8ikSEzFjX3rGCoT5fDRZrRIS5qudWFo9Lr6wA9aCohkLHuKRf13enhooGb9TiaaMvG
	kW4plUC5ZUoOGldPc9F8lolA7dfv4ahps5FE5rUJDJlXLVykvLLIQcO54wDp1c4ot74bR/cb
	lrjB7vRlxa843V0OabVGTmtqLhK0ZjGPpBsqztOTDSpA9xaVAXpo+CFOz5p/wei+yhmCXtK4
	099k6slQwaf8D8KYmKgERhoQeIIfqTIo8PgsmNRVs4orwGWnDODAg9Tb8PbjOSID8HlCqhrA
	ztRmkh2WAayusAB2WAIw+eoc91nEMJoGbCykqgCsMYj/NRkKjPaEFsC1oRuYzYVT3rBFWbud
	IKg9sHdmhGNjJ6u+2q/cZg7VR8KR7Agb76JOQO33+dt+ARUMU8bZlwWUI+xSjeGsPwnez6u2
	3s+zshussvBssgMVAMfGp+xFRVCpzwIsn4Pd2j8wWzdIzfOh6cldkj04CEtqpu2BXXCqU2vX
	X4I9+Vk4G8gHsNUyT7JDLYCVySsY63ofpg6M2RMhMN3Yz7E1gtROODzryBbdCfN0hXZZANMv
	CFm3D6w1zuC5wLP4udWKn1ut+L/VWNkPfv2jmfyf/DqsLJvmsHwA1tf/jasBWQNcGLksNoKR
	vSlhEv1l4liZXBLhfyouVgOsn7/H0rncCKqmFvzbAMYDbcDLGjb9UNsHXHFJnIQROQmCvwgK
	FwrCxF+eZaRxn0vlMYysDbjxcJGLwDvsFUZIRYjPMKcZJp6RPjvFeA6uCmzHvqiU8FvYd96H
	g8JPYh+fDD06VXDqiDzYmO3lEV2beExsuSJ8ITrvEwTvlW0dLowMyvnsnO+Fjeabfx6YLOrw
	6Z289kCj9j7/qET5UbFh3dFXdWe01OP0UEvb/Ldp6BLY/2GIc3nZJc+6rT0p8e+ZWvyOuyx4
	FokHkjbe2TscTYcOXiTdf08sFGrbl1s7DpW/vPXWJuocTvfFGnHzXGu4n/Pi/oQCv8SHhXfX
	NmYrWr3cyh0bicEOadSGT96Nx90pHuan8oRWRWipOeNaw4uBC/Rt8ufN9jpw6N011Ygq4eyj
	/h1bAYM5Ft7u40fmfvvKoTDIL9D4l3azaa4+RzGoffKqCJdFive9xpHKxP8Aj3WNUHcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsVy+t/xu7qd4o5pBj2L9S0ajy1gtfh85Dib
	xbbF3UwWf3e2M1tsOXaP0eLpsUfsFme6cy12n/7KZHFhWx+rxabH11gt9uw9yWIxb/1PRovL
	u+awWdxb85/V4sKB06wWV7auY7F4dqiXxWLb5xY2iwkLm5ktni54zWrxoecRm8WR9WdZLHb9
	2cFu8fvHMyaL39//sVo0z//EbHFjwlNGi2MLxCwmrDvFYnFu82dWBzmP2Q0XWTxOLZLwWLCp
	1GPTqk42j02fJrF7bF5S7/Fi80xGj/MzFjJ6XLtxn8Xj7e8TTB4Xlr1h8/i8Sc6jv/sYewBv
	lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G+SuT
	WAq6JCq+TbRsYJwp0sXIySEhYCJx5nE7I4gtJLCUUWLtCVOIuIzExi9XWSFsYYk/17rYuhi5
	gGo+Mko8v3qDCcLZwijR3dzNDFLFIqAqsad5NdgkNgEdifNv7oDFRYDi3y81g9nMAhfYJe70
	poPYwgIJEluWTgar5xVwkGh6+o4V4oo3jBJrpgRDxAUlTs58wgLRWyYx+9UX9i5GDiBbWmL5
	Pw6QMKeAvsSTp6+gDlWSaD7Wwwhh10p8/vuMcQKj8Cwkk2YhmTQLYRKEqS6xfp4QiihIsbbE
	soWvmSFsW4l1696zLGBkX8UoklpanJueW2yoV5yYW1yal66XnJ+7iRGY9rYd+7l5B+O8Vx/1
	DjEycTAeYlQB6ny0YfUFRimWvPy8VCURXodC+zQh3pTEyqrUovz4otKc1OJDjKbAMJzILCWa
	nA9MyHkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUwn/0RUVR94
	fP3czyXKa72Wtdg8WyUpw/jPdFXWjGqVA7+ni7V/3uQ5+96n7aLvdy47sltYLmPi/eVpYmtS
	En2cZS4VW+8Wvv7b+vcNYRtFrl5tsZ+bJgS9/nY8MchyVwgnc9SMAxfyVz/rerUxunpq2bm0
	KeINqm/b7ZzUbmTdaZvOJFS4Q810uv492alZjTvNQiW1JT6lXtyQYLcsY8N2BfFgs6q35wTc
	ZDMncN/se/+wZtcGidvcZo1uiqm29/f+V5d6c3mq39SqXeKtX1/ZRbmcfWd1913vt7Zttfdv
	LfKcZfPt/lI+91vX9nEzzq250ODdrsWzOy5BKDlYcc5j7p/MNXGrrp7UWiQQEjxfiaU4I9FQ
	i7moOBEAd9JerBAEAAA=
X-CMS-MailID: 20240512192457eucas1p1c2e524298e130efc58f1e66cc0f38039
X-Msg-Generator: CA
X-RootMTR: 20240508171141eucas1p24462cdbd31dc10d74c5c62478cd6a9e0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240508171141eucas1p24462cdbd31dc10d74c5c62478cd6a9e0
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
	<20240424201234.3cc2b509@kernel.org>
	<CGME20240508171141eucas1p24462cdbd31dc10d74c5c62478cd6a9e0@eucas1p2.samsung.com>
	<202405080959.104A73A914@keescook>

--3bxd2gyoppot6odw
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 10:11:35AM -0700, Kees Cook wrote:
> On Wed, Apr 24, 2024 at 08:12:34PM -0700, Jakub Kicinski wrote:
> > On Tue, 23 Apr 2024 09:54:35 +0200 Thomas Wei=DFschuh wrote:
> > > The series was split from my larger series sysctl-const series [0].
> > > It only focusses on the proc_handlers but is an important step to be
> > > able to move all static definitions of ctl_table into .rodata.
> >=20
> > Split this per subsystem, please.
>=20
Thx for stepping in to move this forward.

> I've done a few painful API transitions before, and I don't think the
> complexity of these changes needs a per-subsystem constification pass. I
> think this series is the right approach, but that patch 11 will need
> coordination with Linus. We regularly do system-wide prototype changes
> like this right at the end of the merge window before -rc1 comes out.
This would be more for 6.11, as I expect the other subsystems to freeze
for the merge window.

>=20
> The requirements are pretty simple: it needs to be a obvious changes
> (this certainly is) and as close to 100% mechanical as possible. I think
> patch 11 easily qualifies. Linus should be able to run the same Coccinelle
> script and get nearly the same results, etc. And all the other changes
The coccinelle script is not enough. But that patch 11 should still be
trivial enough to go in before -rc1. right?

> need to have landed. This change also has no "silent failure" conditions:
> anything mismatched will immediately stand out.
>=20
> So, have patches 1-10 go via their respective subsystems, and once all
> of those are in Linus's tree, send patch 11 as a stand-alone PR.
Thomas: I can take the sysctl subsystem related patches ("[PATCH v3
10/11] sysctl: constify ctl_table arguments of utility function"), while
you push the others to their respective subsystems (If you have not
already)

>=20
> (From patch 11, it looks like the seccomp read/write function changes
> could be split out? I'll do that now...)
I saw that that patch has the necessary reviews. Get back to me if you
need me to take a quick look at it.

--=20

Joel Granados

--3bxd2gyoppot6odw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmZBF4IACgkQupfNUreW
QU9xuQv/YFyBb9/xZK9W6ra0XdeKb8z3ZWpkNSHIv3kTsWlpjHIUGjL9mIouwgtX
ucB2RAOEbwUG/wNKHsedhqti2gFMPnF80bZWiJkwVvBZRx4cuAugLBni1rZLceMm
OTViVchXY8AlHpbOVVvxbIZDNSK+YVZh+Z4b9dhhmHYbQl/dj9vWFPNSRSH0wQp6
hi9DrWsZPQ1eidi2uDK7d7VhOARS7U6VB6vL5UV4tjSVLueGaz3lNucP8HMoxa7Q
jHEXeQelWtXg3jTaoIKF3q6FjulWqte8/D9DaKmbD7WvsHtrVfLeLYITADCwCmul
yadKXGJy6kxxaEnPBB08M8jVy/o2c+VvWBpgyZlYRwSAShf5cPQOV5uGqBU9cdPf
sPEZKG+UfmIEAUVTZYPrtvnha1nI4Nz6Ov4OlTz7PLJWAc0aiQKxBZMsnYdz9HMH
hMZo0JyJNZ0UY4PfA43N223QFB8CD8SeGFCXl2aKBymtgrDOL3PV4IxLh4OsowVy
pKdwnrKn
=zOqJ
-----END PGP SIGNATURE-----

--3bxd2gyoppot6odw--

