Return-Path: <linux-fsdevel+bounces-12633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C65D86208B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 00:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66FD1F22279
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 23:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D25199A2;
	Fri, 23 Feb 2024 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Nlq/e1E1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5684B14DFC6
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 23:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708730191; cv=none; b=LPa8F3CA92nM2Kpd14+RSwu2QPorCWBSvQIbRjNjzuC8YjG2oJ/7D0ulOnxWUZo/tNfz78DdFmFc8hvXGKG4zfUSy+funmFfVUhu9louKS8TYig59NrZdRqx/x/haqYevAiLWtWs9882KbOTdj02qyPy6ifeOHRVCyJErIlEGZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708730191; c=relaxed/simple;
	bh=KOuOkxDM/eQDf+jaJBMTfT5yhj2zI/dHokHUYnTQK8A=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=OClKVOCBBOWBOPlTAf9eC8Yz9tYNHiMVbguWN+s2Vkj05c0htiuen8/lZhCPRlONV3OiMt7TcyBpQ5qg4hr11T7PT0Q3GhBoI3ocSKykYnsMP5gF+76yVnLjo29r/D5ybpxJzF3zWzN1B69KF15ezX3Yx7OfVBgxHFR/rflu1zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Nlq/e1E1; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240223231620euoutp02c7d12cf9fd429635dd6974be50d45655~2oQvCyJgO2268022680euoutp02g
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 23:16:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240223231620euoutp02c7d12cf9fd429635dd6974be50d45655~2oQvCyJgO2268022680euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708730180;
	bh=KOuOkxDM/eQDf+jaJBMTfT5yhj2zI/dHokHUYnTQK8A=;
	h=From:To:CC:Subject:Date:References:From;
	b=Nlq/e1E1jNaEwyYofNYsMPl0rAYtScxglI9A7sBvSJm64ScfLP+Sno6uy3Nba28o5
	 fKbFWhWlo80qha7kXM4BxH3bp8bxjFJdBW+G6KTFTURA2j3n9HRdSG6uRUJ5ZcR83+
	 yeSGIRGimBxM6ENsORCbCf4wwSvkJcvomJMjK1oU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240223231619eucas1p272cdbd444e3210e95b966f41debf5c12~2oQuCIHo12069220692eucas1p2l;
	Fri, 23 Feb 2024 23:16:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id F2.5A.09552.34729D56; Fri, 23
	Feb 2024 23:16:19 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240223231618eucas1p1a885347603558c5d6185274b6bd7fc31~2oQs1GmFc0725607256eucas1p1V;
	Fri, 23 Feb 2024 23:16:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240223231618eusmtrp1bdd90a91dd95188a67323fb4b79a50a5~2oQs0hC__2676326763eusmtrp1v;
	Fri, 23 Feb 2024 23:16:18 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-cd-65d92743b7d0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A2.60.10702.14729D56; Fri, 23
	Feb 2024 23:16:18 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240223231617eusmtip1eca7b8b0ff390f43e9b0dbe7077626a9~2oQsnma271598015980eusmtip1G;
	Fri, 23 Feb 2024 23:16:17 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (106.1.227.72) by
	CAMSVWEXC01.scsc.local (106.1.227.71) with Microsoft SMTP Server (TLS) id
	15.0.1497.2; Fri, 23 Feb 2024 23:16:17 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 23 Feb
	2024 23:16:17 +0000
From: Daniel Gomez <da.gomez@samsung.com>
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"hughd@google.com" <hughd@google.com>, "willy@infradead.org"
	<willy@infradead.org>, "david@redhat.com" <david@redhat.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"yosryahmed@google.com" <yosryahmed@google.com>, "jack@suse.cz"
	<jack@suse.cz>, Pankaj Raghav <p.raghav@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: [LSF/MM/BPF TOPIC] shmem/tmpfs: large folios adoption, regression
 tracking and performance testing
Thread-Topic: [LSF/MM/BPF TOPIC] shmem/tmpfs: large folios adoption,
	regression tracking and performance testing
Thread-Index: AQHaZq5MxcWH2k38q0iOhcLY4+el5w==
Date: Fri, 23 Feb 2024 23:16:16 +0000
Message-ID: <4ktpayu66noklllpdpspa3vm5gbmb5boxskcj2q6qn7md3pwwt@kvlu64pqwjzl>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24B3A54AD78420489D7788D68E98FAAE@scsc.local>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUwTdxjH9+tdr9c6wtEaeYJsZjVoREQnGq8JumUydv/o2F++xegBJxAp
	YEuddcl0SAigUdQxsbhRMZQX3+AEaVooSa1CZQSYK0KtbiousYjOljZqhY1yavrf5/t7Xr7f
	PPmRmHxIHEfmFRRzmgI2X0nI8Ou3Xg+u2Lh0jFvVWqKgz129RNATN3yIDlx9g9FPfMdxuvbM
	ERHd1e3E6QeX/hPTtolujB6teoLo0KtzBN1p2fblPMbI65hrTYkM31JBMLzvlITpqwnhzOnR
	RsS8sLkI5nejQ8L4+U8zpNtlqdlcft5+TrNyw25ZrrPejYpcCw6UvbiIDqNpeSWSkkCtAauf
	x8Msp5oQNDYTlUg2y1MIXGV+iSD8CNru/ix+P+G+/AAXCo0IrHwv9qHruGdYJAgewU3rJBJE
	M4Ixo0kSnieoZWBz8nM8n3Jh8NOzpDBjVBG0hapRmBWUGkbv3MSFHg2U9vXNvpOznAzlZggj
	TiXAWfeP4Y4oahP0+J7PpUPUJ/Co+Y1E2BgL7vE6kZA6BupruzCBF8CM5SEhcBIM3B1HAq+C
	jgYbHl4PlBJann4trEkCo9VHCKyCk16rWODlYDo/gQkRYsB5dnzuKEAFpXC0sv3dtdKg3HP/
	na8CvL3tEoHjof/0MbwKLTdERDVE+Bki/AwRfoYIPyMSt6BYTqdV53DalALu+2Qtq9bqCnKS
	swrVPJr9dP0zvQEzavK+TLYjEYnsCEhMOT9qS/wYJ4/KZvUHOU3hLo0un9Pa0UISV8ZGJWQv
	4uRUDlvM7eW4Ik7zvioipXGHRVlJkysy+rZKltTlZf3pzd6z5g/by9CpLzY3RA+kXVysil6c
	NjKll/n1f+187Vqavum5qfrVD4XtrSPTMROTPQGlflj1XeltT+aytVc+oy/kGk44Qvw/7Mpf
	qMzOMbNlR7wu3c3Xlc17WBGMTmlY+/HOLdelbNWIKHOhuti8v3ufKtD1t1NZEnLMlJRfOHDD
	VTuoq9TvCKai36Y852ve+v0H02sOSafPmL6p5nv0JYrB5kMOgyPtK49F9WySHJwxDQyNdvxb
	kSARy7l1eRlHAnSHffjoam+/4tfgHU+KJW79rnutpZ2p9vX1iW1mnWVg+KOKnM3Bb0WP7w3V
	sLXj1n1KXJvLfp6IabTs/zpx1iLjAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0wTaRSG/TrToXUXHQuVT9ZrEyUgTltocYqIl4Rk+kOj0c0G742MFKQU
	p614iRtvawoqURDFgpGioNzUjqJGajV4QRRtjFag0W6iaAJFwYKhArLbOrtJ/z3JOc85b06O
	ABE5+NGCrFwjzeRqciTYRPTZeOu7BctjumjZcAMgK642YKT3gQ+Q366OIORHXxFKlp85xCPt
	d9tQ0tPwD590eO8iZOeJj4Ac9Vdg5K076Ut/oSpZE3X9chzF1hVgFOsrDqOelI2iVEnnJUD1
	O1wY1V75MIwaZGeuEq4jUhi9yUjP1uoNxsWS9XIygZCrSCJBoSLkiQs3JicoJdLUlAw6J2sn
	zUhTtxDatio3yHNN3XWkvx7sBz9EhUAogLgCuhs9aCGYKBDh1QCWVxejXGE6tA25+BxHwLE3
	hViQRfhXAK+NKDmBBdAz3IpwhVoA24+vDjKGx0JHGxsW5EjchcADffFBRvA8aBstBUGOwHWw
	89UjlOth4Cn2ZWCZIMAENN+GQUTxufCs+89gRzi+At7zffkZB+Az4PvakTBuYhR0d5/ncTFx
	eNHuRDgWw54P4//Fj4fPO7oBxzLYVO1Ag+MhLoF1PWncmHhY2ezDOFbBk73NfI7nwxqrF+Ei
	TIFtZ7vREyDaErLZEqJbQnRLiG4J0SsBvw5E0iaDLlNnSCAMGp3BlJtJbNXrWBB4pJuPv9+4
	DWp7vxItgCcALQAKEElk+B/Tu2hReIZm9x6a0W9mTDm0oQUoAxc6iUSLt+oDn5hr3CxPkinl
	iiSVTKlKSpREhavzzBoRnqkx0ttpOo9m/vd4AmH0fp46w2mKbVwoXRaltt1PXPrM9YJ/UGF/
	6E3WDz5PP1pExplvbCqy/t16vUM94zTMUBR/mDc4NmfalJufyrIGbBXJO2qUTd9Y2yJlylqx
	a1sdk3N0Wtri/Nezog7fpz2lh485Np5b04Q1S2v6xn9NF+/LzHbKfwg1W2JaqOHfJ8mzXlzJ
	VneXn5r/qMc8YOL/5mlPZdFIrXuXtG+dvX+oeiDef6xs71/trvxLaW+7si+IhCXKoSUdk2sn
	+JNWOpfs2ECVGEf8Xtmg9eU9cUGhyvJaS694U19fFZsf0ejoXNDjf0q9t45e460s/WwR2e+c
	PmC2FvBUTK9TF7P8U39D1ZgENWg18jiEMWj+BU8fgvrRAwAA
X-CMS-MailID: 20240223231618eucas1p1a885347603558c5d6185274b6bd7fc31
X-Msg-Generator: CA
X-RootMTR: 20240223231618eucas1p1a885347603558c5d6185274b6bd7fc31
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240223231618eucas1p1a885347603558c5d6185274b6bd7fc31
References: <CGME20240223231618eucas1p1a885347603558c5d6185274b6bd7fc31@eucas1p1.samsung.com>

Hi,

I want to propose a session to discuss how we should address large folios i=
n
shmem. I have explored the write and fallocate paths [1] (which I will soon=
 post
an updated version), but there are additional aspects that need to be cover=
ed,
such as read and swap paths.

I have started an RFC to track blocks for huge pages (aiming to avoid any
regressions with large folios) that seems to be going in the wrong directio=
n,
according to Hugh's comments. However, there are still some open questions =
for
which I have not yet received a clear answer.

In addition, I've been testing tmpfs with kdevops using recent kernels and
have encountered some known issues. However, I have not found a clear way t=
o
identify them other than through these [3][4] threads. Therefore, having a =
clear
and updated status of all the test profiles and the list of issues would he=
lp
to provide a better understanding. Note that this aligns with kdevops' goal=
.
Additionally, I recently received some patches from Hugh [5] aimed at addre=
ssing
the issues in xfstest-dev.

Luis has also initiated a thread [6] to collaborate with the 0-day team to =
track
regressions in tmpfs (among other efforts). It would be beneficial to discu=
ss
the progress made thus far, potential next steps, and gather insights on th=
is
collaborative effort between 0-day and kdevops.

Finally, I would like to explore alternative methods for performance testin=
g
in tmpfs aside from using fio and/or running kernel build benchmarks. What
are the possible approaches for this? Luis recently reported some findings =
in
the last LBS cabal, where XFS on pmem DAX showed significantly better resul=
ts
compared to tmpfs, regardless of whether huge pages were utilized or not. I=
t
would be beneficial to share these latest findings and consider implementin=
g
methods, possibly integrated into kdevops, to continuously monitor any pote=
ntial
regressions.

[1] shmem: high order folios support in write path
v1: https://lore.kernel.org/all/20230915095042.1320180-1-da.gomez@samsung.c=
om/
v2: https://lore.kernel.org/all/20230919135536.2165715-1-da.gomez@samsung.c=
om/
v3 (RFC): https://lore.kernel.org/all/20231028211518.3424020-1-da.gomez@sam=
sung.com/
[2] shmem: fix llseek in hugepages
RFC: https://lore.kernel.org/all/20240209142901.126894-1-da.gomez@samsung.c=
om/
[3] https://lore.kernel.org/all/alpine.LSU.2.11.2104211723580.3299@eggly.an=
vils/
[4] https://lore.kernel.org/all/20230713-mgctime-v5-3-9eb795d2ae37@kernel.o=
rg/
[5] xfstests-dev patches from Hugh:
https://gitlab.com/dagmcr/xfstests-dev/-/commits/hughd/tmpfs-fixes/?ref_typ=
e=3Dheads
[6] https://lore.kernel.org/all/CAB=3DNE6VRZFn+jxmxADGb3j7fLzBG9rAJ-9RCddEw=
z0HtwvtHxg@mail.gmail.com/

Are there any other related topics that folks would like to discuss further=
?

Daniel=

