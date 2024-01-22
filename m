Return-Path: <linux-fsdevel+bounces-8436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB05483658F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 15:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9D01F23F7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 14:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C5C3D551;
	Mon, 22 Jan 2024 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ezw9RlgD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737C43D54C
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934187; cv=none; b=bX3K4dORP1LXHr5S3MObe8r/lDCMLqiQNgc/fY1U5fCw8lHC9J1uBvgdpysPhqHAhCqqzWVafLolHAsot2gRaFch7Vj+y3bqVOtg1x4Lk5xxLGwZgKqyTppuNaKskvt3kSYJTq8M8IZ/dXVyRtu1q+dhn+2ZR2cVNBy3xTdO8pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934187; c=relaxed/simple;
	bh=hWwnmdsaDIltjO/kAhSmxJjrD61/SefdAICjMEeaDQA=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type:
	 References; b=oVnx+jh2BlkW7KEMcEi76BCwfaJB5KrOCZdzv2YY+dyrgD3dvBlouDl0R1Oorl5HHAnUANXZRQB7gJ+ZKrsA2mdhIMpmsKhGKZK3FeLnyDX1T0J/e5xU8cZ42h0E8LaPD+zn7gjK8hnSsba9YmD5wTAf89buXDg3nI0rpv0wMns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ezw9RlgD; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240122143621euoutp0216a17b8133534765466bacc4612cb29f~sshmDYNCD1302713027euoutp02H
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 14:36:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240122143621euoutp0216a17b8133534765466bacc4612cb29f~sshmDYNCD1302713027euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705934181;
	bh=NDzSNzUJOtudQVOrepQlpxa4rhFiebnysL6HB30n4Mg=;
	h=Date:To:CC:Reply-To:From:Subject:References:From;
	b=ezw9RlgD5WyRMZqzRUThh6JhtqSV4kGHHA+Rh51/a7NlIb/AaAfG0yJBv4BjiQJub
	 SfYn/O/36EzgXHda3ges1IQQSQ4258XW/7OW1BsOLICi/VGxb61RRQnTHHDzN68AaQ
	 lDuBgBo3lSEw8nAlz4DrVHoyGBWVwfIXsHJ0v5wA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240122143621eucas1p1bae07a8040ccdcdbf615621eeba15332~sshlph4ok2362223622eucas1p18;
	Mon, 22 Jan 2024 14:36:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id D2.39.09552.46D7EA56; Mon, 22
	Jan 2024 14:36:20 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240122143620eucas1p1017072128a3b497fd95b796ebaad71a2~sshlT8kSP0249002490eucas1p1B;
	Mon, 22 Jan 2024 14:36:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240122143620eusmtrp1315c8ac6473241dd298d711659781130~sshlRR2Do2588225882eusmtrp1m;
	Mon, 22 Jan 2024 14:36:20 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-a0-65ae7d64721d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 78.F2.09146.46D7EA56; Mon, 22
	Jan 2024 14:36:20 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240122143620eusmtip117218ec26851728e8b496272f999794d~sshlD4nXc0437404374eusmtip17;
	Mon, 22 Jan 2024 14:36:20 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 22 Jan 2024 14:36:19 +0000
Message-ID: <6b93a509-fbaa-4311-8ee9-fd98e2fd2546@samsung.com>
Date: Mon, 22 Jan 2024 15:36:19 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<hughd@google.com>, <slava@dubeyko.com>, <kirill.shutemov@linux.intel.com>,
	<mcgrof@kernel.org>, <hare@suse.com>, "Darrick J. Wong" <djwong@kernel.org>
Reply-To: <20231206204442.771430-1-willy@infradead.org>
From: Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] mm: Support order-1 folios in the page cache
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfVCLcRz32/O0Pc2tHkP7Kuwac+TMS+GJZNHxuBOF83pexp4StbqtKG7k
	1J3CNsVhdczhSlKa9bKIk7tSojsmMy51erm6iMbFRbE9cf33ue/n5ff9fO9HYMJiD18iVpXE
	qFWKOAmXj5fX/myao9QWM/PSWkKoV+1elKm3mkt19Otw6m1XHk49qK7HqZaiYQ/KbuhAVL8l
	l0MN/sjjyj3pxyW9OG0yJ9P3CgJoc2Emlzb3Z/PoK/VRdInlNU47zVMjie38ECUTF3uIUc8N
	3cPfb7t3A0u08lL0DVvS0KBHFvIkgAyCzowObhbiE0KyAEFuUSvPRQjJbwj015Qs4URgariI
	/3OU5t5HLJGPwHEmA/1XtRif4KzdisD6QeDCAjIUTg1XcLIQQeCkFJ7qKHY8Duovt7vlE0kx
	fHBccr+MkSJwtF91yyeQM6HXssAVj5HNCEprHuGuuZBcDAOmMBfkkgFwItPtHE8ug7aBJg6b
	MgsyKgZHEsVQ8SkPY9f3h+y3fSPltdBgcXBc8UDmeELlkMn9LJDhkKWnWc146Kmz8Fg8GZ7l
	nBk5w1HosA9irDf9762sJVzWuxR0jXEsDAPr3QMs9AL7p3HsNl6QXX4RMyCpcdQZjKOqG0cV
	MI4qYEJ4IRIxyZr4GEYTqGIOyzSKeE2yKka2LyHejP5+qWdDdd8rUUHPV1kN4hCoBgGBSSYI
	7JOKGaFAqUg9wqgTdquT4xhNDfIjcIlIIFWKGSEZo0hiDjJMIqP+x3IIT980jvfhhVt5bdKm
	szDb5+jMjaqKxNCEhB5xsW/wev8L6Vpb1K0mfWDSkTel07wkIqszRWYr716XXXd7Q6FPYXiQ
	uTlixvHosrYrkY2C05wImc/ASaHIb+90268Z6LngScvHTZ1mW7V8gXpf43vDjqoX3y58rn+f
	XtbrvfPLu7AiOnd96vFmw67hKfpg6FoSKDdGODM735Q//cXP32nIX5s6tuR367na1ZNuUpU/
	dKqbzpff7YvumKKObevfnDMUoYtWrXqYEuXX93Pza27sg/NVBcset/aJfbThkXkx8mmO5bdT
	/Lu6V3Y/CpHKU4Orzk9Zs1Bbu9R7xVhT8Jay6UH+0ddfjbkkwTX7FfMDMLVG8QeTviJPwQMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xu7optetSDa4/ULS4/ITPYsGbvWwW
	Tz/1sVjcfD6HxWLP3pMsFvfW/Ge1uDHhKaPFpy2zmSx+/5jD5sDpcXD9GxaPBZtKPTav0PLY
	tKqTzWPTp0nsHvNOBnqs33KVxePzJrkAjig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1D
	Y/NYKyNTJX07m5TUnMyy1CJ9uwS9jCublzAX7GSv6D8V3sD4m7WLkZNDQsBEYuPs3YxdjFwc
	QgJLGSXePG1kg0jISGz8chWqSFjiz7UusLiQwEdGid+/3SEadjJKXD74khEkwStgJ9HxfztT
	FyMHB4uAqsSJPguIsKDEyZlPWEBsUQF5ifu3ZrCD2MwC4hK3nswHKxcR0JB4s8UIInyNUeLD
	u1KQsJCAucT3BY4gJpuAlkRjJ1ijsICtxMPv55kgqjUlWrf/hhooL7H97RxmiIMVJSbdfA91
	fK3E57/PGCcwisxCcs8sJDfMQjJqFpJRCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG
	8bZjPzfvYJz36qPeIUYmDsZDjBIczEoivDck16UK8aYkVlalFuXHF5XmpBYfYjQFhslEZinR
	5HxgGskriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamByeZKv+/jk
	0uWL3rB+8FqcklIsOT/b6a7SzSvWSs0vmmpmnl8yo28Jo9XJb9H5lad//52anyGxpkTyxczX
	Ime3ztu/dZakY0W6sJ923L3U9ZMsFu7U+n+aoef015y7cW7b8pkUwwQrjlmVTTGdaSd4+eSP
	2mi5WUtL9/Geqd418f2iaWZntn5PEWlwjg4/MlVjxeljl2+mZR3YpjzPeWXjpksRR8+3Gv2+
	NGHK90bF1IUMy2UWnVtt53uD8eXKegvbbTuzF5jVn9phHsxy4fp1/98hcyTWhG/p5fTdJdv6
	+5O1vdGUo7JND440p91mjmP5FiW3/GPciudBrw8cMo1hvh6hyjerb+qbzsX65v+rTiqxFGck
	GmoxFxUnAgBU84zFawMAAA==
X-CMS-MailID: 20240122143620eucas1p1017072128a3b497fd95b796ebaad71a2
X-Msg-Generator: CA
X-RootMTR: 20240122143620eucas1p1017072128a3b497fd95b796ebaad71a2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240122143620eucas1p1017072128a3b497fd95b796ebaad71a2
References: <CGME20240122143620eucas1p1017072128a3b497fd95b796ebaad71a2@eucas1p1.samsung.com>

> Folios of order 1 have no space to store the deferred list.  This is
> not a problem for the page cache as file-backed folios are never
> placed on the deferred list.  All we need to do is prevent the core
> MM from touching the deferred list for order 1 folios and remove the
> code which prevented us from allocating order 1 folios.
>
> Link: https://lore.kernel.org/linux-mm/90344ea7-4eec-47ee-5996-0c22f42d6a6a@google.com/
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

This is something I was looking forward to while developing the LBS support for XFS.

As I am preparing the next version of LBS patches for XFS, I could add this patch on top
and start running fstest for 8k block size on a system with 4k page size. I will let you
know if something blows up.

I haven't seen any new version of this series, so I will use this patch as a starting point
to test 8k filesystem blocksize.

-- 
Regards,
Pankaj

