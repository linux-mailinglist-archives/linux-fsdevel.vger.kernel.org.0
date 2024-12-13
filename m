Return-Path: <linux-fsdevel+bounces-37306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 653939F0EF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180A3189059C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833C61E0DE5;
	Fri, 13 Dec 2024 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="P5BYZq0V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759C3383
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734099426; cv=none; b=AKv9Q1xaOFLfBdrdB+JLVEP4Z8fFPCx/fEmI4BSso/UkGyIa4ndNVv+knMyDiwmcx5w0GWCoBvZYQbKQ+VLCdupT7VBR30AiOBT1tGcLPeUNVZISIuMqhinrOkfAFmKgfvLDm8NekuLSm8uPrtvLaPFteA+VjYLoGQg3b0yefxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734099426; c=relaxed/simple;
	bh=Hjnps881gvjk3qTL1yTDzis5ufh+vMoQ48cUME4GNJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=AYsctvdVU92uyTPdx60Qr2IYhaPlslN3o7o21tLr/rAyIC9zJxHWAZU9mmktZrfJUpxlbMF2jo3yxRpeJjcZUQODVuEmFvZuHYW76Z21Xc/UnzCI/QnNmRuxi2cUU3IwPgguHjxBv+CaLdlsq1SWuVzf3yl0VKGneWOMmSNik2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=P5BYZq0V; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241213141656euoutp02ef3cafd0696b461639e1028ebd985dc5~Qwjs9o5JK0870508705euoutp020
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:16:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241213141656euoutp02ef3cafd0696b461639e1028ebd985dc5~Qwjs9o5JK0870508705euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734099416;
	bh=uGP21Q2NDdvtdVw5VtQSnPV2rG4nyxiYGjThMFWTypk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=P5BYZq0VXlHpMe/M8sbhifCoCabtxuiOHyY1Pt6AHZ7qT4xrj1HdZu5X8l8WZSZut
	 A/2ewxfam3y5jrK12hjqJyqusqEiCFqNN/FR9WPNtU1uQMX1IF0iWdMl2cTv7GFotz
	 Xc040R1DgYECZjArowy2aKfbTTJSzn084YBbuM9U=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241213141656eucas1p2c0acf501b6cac22d439be9d4be54d6c4~QwjsxVz3i3072930729eucas1p2K;
	Fri, 13 Dec 2024 14:16:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 7F.B5.20409.7D14C576; Fri, 13
	Dec 2024 14:16:55 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241213141655eucas1p22da0e3b4379e27059f7e71e8bd644bcd~Qwjsbf-AD3070030700eucas1p2J;
	Fri, 13 Dec 2024 14:16:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241213141655eusmtrp22fb517eeab642dbc9d9b7ff19d4503e3~QwjsbAp0o0922309223eusmtrp2c;
	Fri, 13 Dec 2024 14:16:55 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-d2-675c41d79db9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id BD.BE.19920.7D14C576; Fri, 13
	Dec 2024 14:16:55 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241213141654eusmtip29970661c3fbc561ce6ee2968e634b35d~QwjrmzjU80593905939eusmtip2u;
	Fri, 13 Dec 2024 14:16:54 +0000 (GMT)
Message-ID: <fb8a52ae-8366-4122-b2ad-2d0fbc669be8@samsung.com>
Date: Fri, 13 Dec 2024 15:16:54 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/2] pidfs: use maple tree
To: Christian Brauner <brauner@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox
	<willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20241213-untypisch-bildmaterial-413504dd3a53@brauner>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djPc7rXHWPSDXZcs7J4ffgTo8X2hgfs
	Fnv2nmSx2LCygcni9485bA6sHptXaHlsWtXJ5rF5Sb3Hx6e3WDw+b5ILYI3isklJzcksSy3S
	t0vgytg0Yxd7wRb+igMPJBoYj/N0MXJySAiYSLydfZuxi5GLQ0hgBaNEy6+z7BDOF0aJTzP+
	sIFUCQl8ZpT4eygVpuPE84PMEEXLGSUmbbvOCFH0kVFiwgrfLkYODl4BO4ldR2VBwiwCqhJ3
	Vu1iAbF5BQQlTs58AmaLCshL3L81gx3EFhYwlbhy5SQriC0ioCXRtOgjE8h8ZoEZjBLvvzwG
	K2IWEJe49WQ+E4jNJmAo0fW2C+w4TgFniQd797JA1MhLbH87B+w4CYErHBJfTjcxQ1ztIjHl
	2092CFtY4tXxLVC2jMT/nfOZIBraGSUW/L4P5UxglGh4fosRospa4s65X2wgrzELaEqs36UP
	EXaUeHS3mxkkLCHAJ3HjrSDEEXzAQJkOFeaV6GgTgqhWk5h1fB3c2oMXLjFPYFSahRQus5C8
	OQvJO7MQ9i5gZFnFKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kRmGhO/zv+ZQfj8lcf9Q4x
	MnEwHmKU4GBWEuG9YR+ZLsSbklhZlVqUH19UmpNafIhRmoNFSZxXNUU+VUggPbEkNTs1tSC1
	CCbLxMEp1cAkLKOo+zvUYZF8RWG0xyye1ecv3cqa8faS8xTNbG39Vo/znFOSr63IPjlFTPh1
	qldpxrfodIEr9rNZtj5uy+10Vz13LCh97uIU9x3KfqpbJq67ky+keEbyl8OKl2Wzp/L/OPbm
	KUfa4t6uWLYEyTNbdaQMvs+uXLyQb0r6ba2GL+5Xw/7efvQlzfhK8CHmlvJzFox6CosfP1xs
	XT6V5c772OKZzNYHc/YHlR+/+cJRJflQrPXt52srzWPfHS5tWbDM1nWNU4uZwqX+jfO/cHKE
	r3bu0xO4LCGxbdFeridVPv8fzlGZaG1zLIHvqfamOpfA+Vefer1k7j/9ymtlX9XUsqC9Cy5u
	nnjB5rLJ9UvGSizFGYmGWsxFxYkAPRx1/aMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xe7rXHWPSDY7elrd4ffgTo8X2hgfs
	Fnv2nmSx2LCygcni9485bA6sHptXaHlsWtXJ5rF5Sb3Hx6e3WDw+b5ILYI3SsynKLy1JVcjI
	Ly6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy9g0Yxd7wRb+igMPJBoY
	j/N0MXJySAiYSJx4fpC5i5GLQ0hgKaPEh0Wz2CESMhInpzWwQtjCEn+udbGB2EIC7xkljp70
	62Lk4OAVsJPYdVQWJMwioCpxZ9UuFhCbV0BQ4uTMJ2C2qIC8xP1bM8BGCguYSly5chJspIiA
	lkTToo9MIHuZBWYwSvxc0swEccRpJolj3ceYQaqYBcQlbj2ZzwRiswkYSnS9hTiCU8BZ4sHe
	vSwQNWYSXVu7GCFseYntb+cwT2AUmoXkkFlIRs1C0jILScsCRpZVjCKppcW56bnFhnrFibnF
	pXnpesn5uZsYgbG17djPzTsY5736qHeIkYmD8RCjBAezkgjvDfvIdCHelMTKqtSi/Pii0pzU
	4kOMpsDQmMgsJZqcD4zuvJJ4QzMDU0MTM0sDU0szYyVxXrfL59OEBNITS1KzU1MLUotg+pg4
	OKUamDLjHX7naSZ+tOB67P0n+09rjWZxE9PJA+o39qbH7a+ZN2tt7XM9k/4zFydd4tdR3nOT
	Z5bz8fdzO16U/PnA9TDNtoQhRn5VNOvuPx1r1j6w+bWJZ9VC5p7ZyyuSQvOucIhdkihfWBGo
	fsxM7U/AjkYR86z9dyxmWO9wNYm5MuV94P5H4X77Ty7KOPrr/CtFuYyAlz6Lv3goZj/Nej9x
	yrT0wl12517eubk6boOd+HfnnezWRxkaLh0Sef9xZ2vmhVcHXrvxx16dfPaHL5dbOZvmq9kL
	X95nLHp4umaKzNyc1J8Nnxv092rc3XZw1y0tk97TLH+CRW44Vbx8NvnRi4WftBMNhd5UOr7/
	+Wi7SZuiEktxRqKhFnNRcSIABzNNeTYDAAA=
X-CMS-MailID: 20241213141655eucas1p22da0e3b4379e27059f7e71e8bd644bcd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241213103551eucas1p1f97e0ca298e6a9edfc75b287b4c2079e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241213103551eucas1p1f97e0ca298e6a9edfc75b287b4c2079e
References: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
	<20241209-work-pidfs-maple_tree-v2-2-003dbf3bd96b@kernel.org>
	<CGME20241213103551eucas1p1f97e0ca298e6a9edfc75b287b4c2079e@eucas1p1.samsung.com>
	<e3b555c5-4aff-4f0d-b45b-9c46240a02da@samsung.com>
	<20241213-untypisch-bildmaterial-413504dd3a53@brauner>

On 13.12.2024 14:07, Christian Brauner wrote:
> On Fri, Dec 13, 2024 at 11:35:48AM +0100, Marek Szyprowski wrote:
>> On 09.12.2024 14:46, Christian Brauner wrote:
>>> So far we've been using an idr to track pidfs inodes. For some time now
>>> each struct pid has a unique 64bit value that is used as the inode
>>> number on 64 bit. That unique inode couldn't be used for looking up a
>>> specific struct pid though.
>>>
>>> Now that we support file handles we need this ability while avoiding to
>>> leak actual pid identifiers into userspace which can be problematic in
>>> containers.
>>>
>>> So far I had used an idr-based mechanism where the idr is used to
>>> generate a 32 bit number and each time it wraps we increment an upper
>>> bit value and generate a unique 64 bit value. The lower 32 bits are used
>>> to lookup the pid.
>>>
>>> I've been looking at the maple tree because it now has
>>> mas_alloc_cyclic(). Since it uses unsigned long it would simplify the
>>> 64bit implementation and its dense node mode supposedly also helps to
>>> mitigate fragmentation.
>>>
>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>> This patch landed in today's linux-next as commit a2c8e88a30f7 ("pidfs:
>> use maple tree"). In my tests I found that it triggers the following
>> lockdep warning, what probably means that something has not been
>> properly initialized:
> Ah, no, I think the issue that it didn't use irq{save,restore} spin lock
> variants in that codepath as this is free_pid() which needs it.
>
> I pushed a fix. Please yell if this issue persists.

I've applied this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.14.pidfs&id=34a0a75fd0887b599d68088b1dd40b3e48cfdc42

onto next-20241213 and it fixed my issue. Thanks!

Feel free to add:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


