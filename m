Return-Path: <linux-fsdevel+bounces-28221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65CC9682F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 11:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025251C2096C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 09:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D398A1C2DCF;
	Mon,  2 Sep 2024 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z/jGXbD2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421EB1C0DEA
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268816; cv=none; b=LY1kwuvohDVpluYB8mWDHWkDb2zN5ekynqvgbOmUHpAa+pY/rg3dwVUJE90K070pGxySy2IR9c8u6PDIL7NgVF97UQqCIHxaY2XeLjLedfw3ezcSxGbN3hDKNo6Rh4IYCs0QAVPOqEo3pBQ7K58Skjq/AZdG6dX02LaeV7/Pas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268816; c=relaxed/simple;
	bh=JvMM200wwmg0a0pA6z93JHpy14mApdoUVfxh1+uRqug=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=ig1TG3tu4tuny7pRSwAW1rHezG8hmEVuUZtiSe/CcuxL1LzBSuDemT3tPqXdHGrxYQSerj49PkkmToiDLNt+8WrmmcKk2PUcukTKUljY5jyeaGC9Yp1t/rGbD3CoJLW/D7Jis0z80+mI7I3L8SswoOISD5KUg9Cqn5Xh+EJLo5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Z/jGXbD2; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240902092012euoutp02a9f2cba2f270c3a548e1cb0642c5bf3a~xYtgZXzjv0917609176euoutp024
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 09:20:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240902092012euoutp02a9f2cba2f270c3a548e1cb0642c5bf3a~xYtgZXzjv0917609176euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725268812;
	bh=m5ERDXvm/e0P42wGNCE+IJxiECsJwJfb5bILlAF1580=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Z/jGXbD2guPZBKvuyb7kmz31IZWg8eBtREHjck868C/jMfNUJ96vufx5nz93oXQ0B
	 h+D2oCV8VsCoWNg+fCtapeqgZZ8xxysNpvhUrkPTeiRvPxd/Tcrm39rLxJyPrTxxOe
	 Xh6BBDDsKz7vFGmZQR0tBgUbBRMGu0RsNl2oqPb4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240902092011eucas1p1bc93717556550f3a8439e52dc81c23d6~xYtf3vgS21567115671eucas1p1K;
	Mon,  2 Sep 2024 09:20:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 75.8D.09620.B4385D66; Mon,  2
	Sep 2024 10:20:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240902092011eucas1p183edada5872e19c71d9fdfd49b752499~xYtfYUgio1814718147eucas1p1E;
	Mon,  2 Sep 2024 09:20:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240902092011eusmtrp2cad280d647787b5ebda5f44e4dd4da3e~xYtfXUCCJ2554725547eusmtrp2J;
	Mon,  2 Sep 2024 09:20:11 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-42-66d5834b95ab
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id AB.D6.14621.B4385D66; Mon,  2
	Sep 2024 10:20:11 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240902092011eusmtip124d5cdec17832e5753681f0ef970cf48~xYtfG7wjI1102011020eusmtip1S;
	Mon,  2 Sep 2024 09:20:11 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 2 Sep 2024 10:20:09 +0100
Date: Mon, 2 Sep 2024 11:19:31 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
	Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] sysctl: avoid spurious permanent empty tables
Message-ID: <20240902091931.7al44ccdbbez2v3q@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef0dd949-e8a3-4b61-9d2d-3593b139cc4f@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7djPc7rezVfTDC6+MLH4/ns2s8WXn7fZ
	LT4fOc5msXjhN2aLGytmMFscOr6f3aJpxwomiyNTZjFbrHt7ntXi+b5eJos9e0+yWFzeNYfN
	4vePZ0wWazpXslrcmPCU0eLqzF1MFseX/2WzWLDxEaPFg9XbWB2EPW7sO8XksXPWXXaPBZtK
	PbpuXGL22LSqk81jYcNUZo/Pm+Q8+ruPsQdwRHHZpKTmZJalFunbJXBlPJ86l7FgMW9Fy/uL
	rA2MB7i6GDk5JARMJJ71XGMHsYUEVjBKrFqp2MXIBWR/YZS4u2QHC4TzmVHix7YZrDAdjzdc
	ZIJILAfqmLSHDa7q5u3v7BDOJkaJZY/vsoG0sAioSJybvQvMZhPQkTj/5g4ziC0iYCOx8ttn
	sAZmgR8sEj+fLwbawcEhLOApsfu6KEgNr4CDxNqLy9kgbEGJkzOfsIDYzAJ6EjemTmEDKWcW
	kJZY/o8DIiwv0bx1Nth4TqDxz9Y+ZYO4WlHi6+J7LBB2rcSpLbfAPpAQeMUp0X/sEjtEwkVi
	a/dHqDeFJV4d3wIVl5H4v3M+VMNkRon9/z6wQzirgb5s/MoEUWUt0XLlCVSHo0Tr8auMINdJ
	CPBJ3HgrCHEdn8SkbdOZIcK8Eh1tQhMYVWYheW0WktdmIbw2C8lrCxhZVjGKp5YW56anFhvn
	pZbrFSfmFpfmpesl5+duYgSmxtP/jn/dwbji1Ue9Q4xMHIyHGCU4mJVEeJfuuZgmxJuSWFmV
	WpQfX1Sak1p8iFGag0VJnFc1RT5VSCA9sSQ1OzW1ILUIJsvEwSnVwLT2uXGRUKXj/U/cfZpr
	hXcmWE7fXnIg7o5fmfURl9RXdvzvNa7Gvbq84UfZWavfrmu3Z3y98ESNbbHX0j2Wq+/0xpwJ
	MXvkznyG7eeNwNfKV/8ceBf6Q815bdKDvOOe9ZcfrOnUTArecGC5/NL1d7L2OPLPSbvL/WKJ
	D5fH/oJYIQ+pN5lfphs3qom1bvi2OMHhu/lppheTQsMyzkq7vXv16nvGqs8FggdezfaUT434
	nM3y4vC5+Ik5i7d+F9iavvHFqrfRIXqcd102aM/+H9LWK7NIcccS0zLbhxxv5WSN7nC1uJ54
	NN3z01Wxg+ot9sHPvoXtSTdu3/zUmtOoV2bvOltGw9elnRXJYjs0emyVWIozEg21mIuKEwHd
	go4U/AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsVy+t/xu7rezVfTDBbvE7H4/ns2s8WXn7fZ
	LT4fOc5msXjhN2aLGytmMFscOr6f3aJpxwomiyNTZjFbrHt7ntXi+b5eJos9e0+yWFzeNYfN
	4vePZ0wWazpXslrcmPCU0eLqzF1MFseX/2WzWLDxEaPFg9XbWB2EPW7sO8XksXPWXXaPBZtK
	PbpuXGL22LSqk81jYcNUZo/Pm+Q8+ruPsQdwROnZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY
	6hkam8daGZkq6dvZpKTmZJalFunbJehlPJ86l7FgMW9Fy/uLrA2MB7i6GDk5JARMJB5vuMjU
	xcjFISSwlFFiybqd7BAJGYmNX66yQtjCEn+udbFBFH1klNg1/QA7hLOJUaJl5QEmkCoWARWJ
	c7N3sYHYbAI6Euff3GEGsUUEbCRWfvsM1sAs8INFYm7PRpYuRg4OYQFPid3XRUFqeAUcJNZe
	XA61oZdJ4k93LxNEQlDi5MwnLCA2s4CexI2pU9hAepkFpCWW/+OACMtLNG+dDbaLE2jXs7VP
	2SCuVpT4uvgeC4RdK/H57zPGCYwis5BMnYVk6iyEqbOQTF3AyLKKUSS1tDg3PbfYUK84Mbe4
	NC9dLzk/dxMjMHFsO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMK7dM/FNCHelMTKqtSi/Pii0pzU
	4kOMpsAgmsgsJZqcD0xdeSXxhmYGpoYmZpYGppZmxkrivG6Xz6cJCaQnlqRmp6YWpBbB9DFx
	cEo1MBWzlnxXne1vvXnjNe4vRRU/D7hJrU6LEI72fp6n+Xddw4bn7h3lDxgOuB3bxeRamC++
	caYlW8PZuQqR+XyzznYecAgTeqSpWSWRZnXg4uZT5be/bnee+u7ez2/byx9GzZSVV9p3fAfL
	/QrTPRMi/y47b7mes/zMJNHqTUn+BfOMTdl3S6l/WZw9rWLGvTqpAPvJp15MiHoRJNuVtzxk
	/uVHClUSr6JOLDZJ/yNpFTZT83zvZPuJE8I8v24Qa6jdbp+cN3H6FWarOvUN71/YyfI/c7u6
	fXP3C5UwDZtZQc99XzrciL62v7bwjumu2iP/Q78s+dD96u9j10eMLjpr8raHbZtbk2U0R0x6
	7YVfq/4osRRnJBpqMRcVJwIAGePB7aUDAAA=
X-CMS-MailID: 20240902092011eucas1p183edada5872e19c71d9fdfd49b752499
X-Msg-Generator: CA
X-RootMTR: 20240824180517eucas1p1534e7cc27c4b7f5fdfe76313e2a12cf4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240824180517eucas1p1534e7cc27c4b7f5fdfe76313e2a12cf4
References: <20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net>
	<20240805-sysctl-const-api-v2-1-52c85f02ee5e@weissschuh.net>
	<CGME20240824180517eucas1p1534e7cc27c4b7f5fdfe76313e2a12cf4@eucas1p1.samsung.com>
	<ef0dd949-e8a3-4b61-9d2d-3593b139cc4f@t-8ch.de>

On Sat, Aug 24, 2024 at 08:05:08PM +0200, Thomas Weiﬂschuh wrote:
> Hi Joel,
> 
> On 2024-08-05 11:39:35+0000, Thomas Weiﬂschuh wrote:
> > The test if a table is a permanently empty one, inspects the address of
> > the registered ctl_table argument.
> > However as sysctl_mount_point is an empty array and does not occupy and
> > space it can end up sharing an address with another object in memory.
> > If that other object itself is a "struct ctl_table" then registering
> > that table will fail as it's incorrectly recognized as permanently empty.
> > 
> > Avoid this issue by adding a dummy element to the array so that is not
> > empty anymore.
> > Explicitly register the table with zero elements as otherwise the dummy
> > element would be recognized as a sentinel element which would lead to a
> > runtime warning from the sysctl core.
> > 
> > While the issue seems not being encountered at this time, this seems
> > mostly to be due to luck.
> > Also a future change, constifying sysctl_mount_point and root_table, can
> > reliably trigger this issue on clang 18.
> > 
> > Given that empty arrays are non-standard in the first place it seems
> > prudent to avoid them if possible.
> > 
> > Fixes: 4a7b29f65094 ("sysctl: move sysctl type to ctl_table_header")
> > Fixes: a35dd3a786f5 ("sysctl: drop now unnecessary out-of-bounds check")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> Any updates on this?
> I fear it can theoretically also happen on v6.11.
> 
This is already in next and will probably make it for v6.11. The "fixed"
tag will make is so it is ported to 6.10.

Best

-- 

Joel Granados

