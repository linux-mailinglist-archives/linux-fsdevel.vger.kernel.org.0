Return-Path: <linux-fsdevel+bounces-28211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CA69680AC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 09:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F96F1C22023
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 07:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5065A155A52;
	Mon,  2 Sep 2024 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IQs2A9+f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C53C00
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262475; cv=none; b=NBAoQHcRQgZIEWa69VJuZU440bAcLgNKfzLQgU2CuVR2oJB3TjOW8/7sCpEEgizioa4rdR7t/0d8SXLabWDeAo1KJk7E1yRJCsfGjP/lyWre7ZbZxuNZuSDq5vax2S8cbSzbLyiHKupN2ep4ql3FzIfesWoh64KS8qgVBIA1Scc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262475; c=relaxed/simple;
	bh=+Gf3BSCtMLY8e+F/23nbA1GXCeZraHCGNHaB4nFbqPE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=HObQgYNtl+/Wb5oq8IEYuOSkvkE25TlD0CrpCNPKjOlkFmHLohduoJQkQ+vL7j3PCvfGnDWBWZEJp/iGAdJ9HZUIgCENkUqoQvJmIuT33uzY0pjSIeVoieEeZle5Zpj95u7qJciHq+wR+s6ozY7I0JECN+AW5tLbnwA0+K4IzXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IQs2A9+f; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240902073430euoutp020e7e3cbb19e70e6cabc89132dd77ff50~xXROT-4La1783717837euoutp028
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 07:34:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240902073430euoutp020e7e3cbb19e70e6cabc89132dd77ff50~xXROT-4La1783717837euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725262470;
	bh=eRLzqlc0A/Q5D/AKX1vieJLPTmkuBope/YuPLoNkJDw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=IQs2A9+fyXKJIeTgfkOvi40owZ3SBWcIbrTlL9d5mKd5sEoBUQbv9VIsR+//06k81
	 5wbPdBtCSmenNWgzjHJn77cjii1NqEM4RKPSjenWhEwBNAgYntdiIz4a/ADMq6Xqur
	 NKMlcPUv33HhxJEBwzpZ7gxMheHslY4eGiRpRSG8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240902073430eucas1p16ae5b6d437a8144163385c503a8ed669~xXRN7reYL2068120681eucas1p1q;
	Mon,  2 Sep 2024 07:34:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id FA.95.09624.68A65D66; Mon,  2
	Sep 2024 08:34:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240902073430eucas1p1057778f64a91f3a9ed3b6608de50204c~xXRNlsL5r2071920719eucas1p1Q;
	Mon,  2 Sep 2024 07:34:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240902073430eusmtrp1e81378247d8eef3ddef6006fabc0ea51~xXRNkvvcs1756817568eusmtrp1C;
	Mon,  2 Sep 2024 07:34:30 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-80-66d56a86e5f1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 7B.81.14621.68A65D66; Mon,  2
	Sep 2024 08:34:30 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240902073429eusmtip2d6f93f845ca50cd22fa2baf309ea6cbd~xXRNbvdl91462214622eusmtip2A;
	Mon,  2 Sep 2024 07:34:29 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 2 Sep 2024 08:34:29 +0100
Date: Mon, 2 Sep 2024 09:34:24 +0200
From: Joel Granados <j.granados@samsung.com>
To: Xingyu Li <xli399@ucr.edu>
CC: Yu Hao <yhao016@ucr.edu>, <mcgrof@kernel.org>, <kees@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: BUG: general protection fault in put_links
Message-ID: <20240902073424.poglyp6cl4dmfxao@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALAgD-5SgEFKD36qtMxWoFci0pLiPxC6Y9Z6rumBr7bGO3x9fQ@mail.gmail.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduzned22rKtpBjPaJS3WvT3ParFn70kW
	i8u75rBZ3JjwlNHixYSdbBbPFpxjdGDz2LSqk81j1uyrTB6fN8kFMEdx2aSk5mSWpRbp2yVw
	ZUxesZ294BNTxctjE1kbGFcwdTFyckgImEgc/jKBrYuRi0NIYAWjRO/HpVDOF0aJL7fnM0I4
	nxklOs/8YoNpaf+2iwkisZxR4mH3EVa4qlsLX7JAOJsYJWZ/fMEC0sIioCIx6dd9VhCbTUBH
	4vybO8wgtoiAnMTU22fBupkF2hklLmxcCrZDWMBc4uHJxWA2r4CDxLn1J1kgbEGJkzOfgNnM
	QIMW7P4EVMMBZEtLLP/HARLmFAiU2H7jECPEqYoSXxffY4GwayVObbkFdraEwBUOif0N06H+
	cZHouLIHqkFY4tXxLewQtozE6ck9LBANkxkl9v/7wA7hrGaUWNb4FRqA1hItV56wg1whIeAo
	8eNXCoTJJ3HjrSDEnXwSk7ZNZ4YI80p0tAlBNKpJrL73hmUCo/IsJJ/NQvLZLITPFjAyr2IU
	Ty0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMKaf/Hf+0g3Huq496hxiZOBgPMUpwMCuJ8C7d
	czFNiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6YklqdmpqQWoRTJaJg1Oqgcnq5/VD
	Rk5fv5ocKxSZdtqO9/Mtf6uPF/bm7gphOVbFereTR3of4yPRX3P/MGUmS2ZWGF1P/iDe1Nxd
	P1H+suizg9Uxd/feWStckPs68a/yk8w7R1e1FvYdnHvH213eqfbxQh9Frav/r8R8mZe/bl27
	PItu9u/U5xG9til57P8YD4nt7Lt3d0P0o/LKuZGy/afTvbSkjBPD32p5Tur+7cVx69ePLXFn
	fnpK9SQl/5Xgfn8uuyYgIOJnC3PKhpaAGJN1/zgTmmddyuc/s5nZKLf3/rOyjg0aUZwTFJdo
	7/mydY6mnVl0+zf9qQvuOz++p33NuVNbuoC5/VuP7Olyju11v239t4bYzcmTL3Y+p8RSnJFo
	qMVcVJwIALkBSTqYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7ptWVfTDBZdYbVY9/Y8q8WevSdZ
	LC7vmsNmcWPCU0aLFxN2slk8W3CO0YHNY9OqTjaPWbOvMnl83iQXwBylZ1OUX1qSqpCRX1xi
	qxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eglzF5xXb2gk9MFS+PTWRtYFzB
	1MXIySEhYCLR/m0XkM3FISSwlFHie+sFVoiEjMTGL1ehbGGJP9e62CCKPjJKfFi4nxnC2cQo
	8XXCJnaQKhYBFYlJv+6DdbAJ6Eicf3OHGcQWEZCTmHr7LCtIA7NAO6PEhY1L2UASwgLmEg9P
	LgazeQUcJM6tP8kCMXURk8Tq9vXMEAlBiZMzn7CA2MxAUxfs/gTUwAFkS0ss/8cBEuYUCJTY
	fuMQI8SpihJfF99jgbBrJT7/fcY4gVF4FpJJs5BMmoUwaQEj8ypGkdTS4tz03GJDveLE3OLS
	vHS95PzcTYzAyNp27OfmHYzzXn3UO8TIxMF4iFGCg1lJhHfpnotpQrwpiZVVqUX58UWlOanF
	hxhNgWExkVlKNDkfGNt5JfGGZgamhiZmlgamlmbGSuK8bpfPpwkJpCeWpGanphakFsH0MXFw
	SjUw2b8LmMP0fsE9u6V7NsRrChefVDjXd3STs4bVAn7VGypLlhxT2Xuybq/ayYMXXrS9O1+t
	vGvXlGzj13tmSx77Y5Ng+c54j6smR4f35JX2J3PWqkurTHx0dMcvtWB1i2XmN3LfnWgxF16X
	mq89MWjv7uY2TX6W15bP7u2/MdFsluWOV8s+BS78w/v1mkRsimRYvuVt406xSS9PLG9aNI87
	6f/fldqCH1ullhYJSoWvbrjzevd2fZWYzDvxdQyGE/rXdm5bV595LM6bzfRpxem7T3qtyg/z
	NLIePRX254LFrKNWsvr3TUK6P5z3v/dW+T1buo3FzKPZ+89++3Bf8bceg7bX9I3Hz69aO4Xj
	0JK7PT+UWIozEg21mIuKEwG/xUCiNQMAAA==
X-CMS-MailID: 20240902073430eucas1p1057778f64a91f3a9ed3b6608de50204c
X-Msg-Generator: CA
X-RootMTR: 20240825050512eucas1p2cadb2e7d7c1428994707fec4d88a5ec4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240825050512eucas1p2cadb2e7d7c1428994707fec4d88a5ec4
References: <CGME20240825050512eucas1p2cadb2e7d7c1428994707fec4d88a5ec4@eucas1p2.samsung.com>
	<CALAgD-4n=bgzbLyyw1Q3C=2aa=wh8FimDgS30ud_ay53hDgYBQ@mail.gmail.com>
	<20240827142749.ibj4fjdp6n7wvz2p@joelS2.panther.com>
	<CALAgD-5SgEFKD36qtMxWoFci0pLiPxC6Y9Z6rumBr7bGO3x9fQ@mail.gmail.com>

On Wed, Aug 28, 2024 at 04:40:45PM -0700, Xingyu Li wrote:
> We use syzkaller to fuzz the linux kernel, and this bug is triggered
> during fuzzing. However, unfortunately, syzkaller did not generate
> reproducing source codes.
It would be great to have the reproducing script. Something that
consistently fails would be preferable.

Best

-- 

Joel Granados

