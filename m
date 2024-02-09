Return-Path: <linux-fsdevel+bounces-10966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C5A84F74E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 15:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C540EB241D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3265469D23;
	Fri,  9 Feb 2024 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VXwvMZgq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F72469D3B
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488952; cv=none; b=JYdX+ko/4Pe2LChy44KvEjokuu3mjFwKVMlKyRkt5YSnMQlsGfFrBmoyC8vApf6rd/7jN2zAGDTKo4i6OzXzuwpwXjsDWQOOQLrTtApC/DA0UJwvoaz5t92JTs5aDGrMJPRtp/SE6VN/PFjUMW9yMZbC+PEXpTSk1oIkFj1gANs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488952; c=relaxed/simple;
	bh=DCzY/JGjb8mhsUf+XcmDhjOxoBtl8L/RsfsIsrJ7IU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=nTpPni/pI1FvzqlYwPfSdc4a/chNVcBZkaMUyAh790TEtR9bXfv0DX6+L644/cRXNqpO/xG+svqP6EHZdPKeDQv8YFUkgZgEpRhvdm0QMOd6v3f/TONbGH3xA3c0rY8NapqxfXElJWiL/a/6qAx8n4oAErWMULx4lmknplENrV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VXwvMZgq; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240209142907euoutp02932ad7824267f58fcaee7f30d0677d3f~yOCamuuvf2144221442euoutp02i
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240209142907euoutp02932ad7824267f58fcaee7f30d0677d3f~yOCamuuvf2144221442euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707488947;
	bh=oOOPXQ1C4QLRnGizBlTW9/7mF80l1aSAxMsYloK3g+M=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=VXwvMZgqJhlzJrEbIdatR1upBBp2x0B0+/RtlptwGIxcD8Harg5N3Nq6kHxKB/GM3
	 VIz96cDx5AmzDsB+lRObwNrhSQb7C9zQCrxGXbhD7YEE1CqhR61cKdNQBj19jlo5au
	 mgLa/TVfh9EinFtfloyomR5OIR+3qwQRH59aVKL8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240209142907eucas1p2072a6f2e9410ced2ddb2e9a8c7628edf~yOCaQzec22618526185eucas1p2C;
	Fri,  9 Feb 2024 14:29:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id FD.F5.09814.2B636C56; Fri,  9
	Feb 2024 14:29:06 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240209142906eucas1p2c31598bf448077f04eef66319ae2f3a1~yOCZzbmxq0060200602eucas1p2_;
	Fri,  9 Feb 2024 14:29:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240209142906eusmtrp1552e5b8ad10b0382bfcbdd74d7755208~yOCZyxTrv0528405284eusmtrp19;
	Fri,  9 Feb 2024 14:29:06 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-42-65c636b241f9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id B2.B3.10702.2B636C56; Fri,  9
	Feb 2024 14:29:06 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240209142906eusmtip11fa07a35bc26d35a2936315444ab40e3~yOCZorTLt0114301143eusmtip1L;
	Fri,  9 Feb 2024 14:29:06 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Fri, 9 Feb 2024 14:29:05 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 9 Feb
	2024 14:29:05 +0000
From: Daniel Gomez <da.gomez@samsung.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
	"hughd@google.com" <hughd@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "dagmcr@gmail.com" <dagmcr@gmail.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"willy@infradead.org" <willy@infradead.org>, "hch@infradead.org"
	<hch@infradead.org>, "mcgrof@kernel.org" <mcgrof@kernel.org>, Pankaj Raghav
	<p.raghav@samsung.com>, "gost.dev@samsung.com" <gost.dev@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>
Subject: [RFC PATCH 6/9] shmem: set folio uptodate when reclaim
Thread-Topic: [RFC PATCH 6/9] shmem: set folio uptodate when reclaim
Thread-Index: AQHaW2RUZLM8QyQXnk2QIeewqLmB5Q==
Date: Fri, 9 Feb 2024 14:29:03 +0000
Message-ID: <20240209142901.126894-7-da.gomez@samsung.com>
In-Reply-To: <20240209142901.126894-1-da.gomez@samsung.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djP87qbzI6lGixYZ2kxZ/0aNovXhz8x
	Wpzt+81mcXrCIiaLp5/6WCxmT29mstiz9ySLxeVdc9gs7q35z2pxY8JTRovzf4+zWvz+MYfN
	gcdj56y77B4LNpV6bF6h5bFpVSebx6ZPk9g9Tsz4zeJxZsERdo/Pm+Q8Nj15yxTAGcVlk5Ka
	k1mWWqRvl8CV8WDpN5aCGWwVu7vvMzUw9rN2MXJySAiYSEy68Zu9i5GLQ0hgBaNE2/RfzBDO
	F0aJ9o2vWCCcz4wSW96/YYRp2fjnKxtEYjlQ1Y5tjHBVR47dARssJHCaUeLgngC4wefWNYK1
	swloSuw7uQlso4jAc0aJ1t0fwRxmgZvMEteunmcDqRIWsJfY9+gP2CgRAReJW98msUDYehJX
	F34Ai7MIqEjMm7ISKM7BwStgJTFrES9ImFPAWmLeo/VgYxgFZCUerfzFDmIzC4hL3Hoynwni
	B0GJRbP3MEPYYhL/dj1kg7B1JM5efwL1p4HE1qX7WCBsRYmOYzfZIOboSdyYOgXK1pZYtvA1
	2BxeoJknZz4BB5iEQBuXxL8tC6GGukgsPrEWyhaWeHV8CzuELSNxenIPywRG7VlI7puFZMcs
	JDtmIdmxgJFlFaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmCSO/3v+JcdjMtffdQ7xMjE
	wXiIUYKDWUmEN2TJkVQh3pTEyqrUovz4otKc1OJDjNIcLErivKop8qlCAumJJanZqakFqUUw
	WSYOTqkGJk7DbxLFMQ4z67InWjw5UfZ57nONuvhfj5WbrFyPrhL2N+g8UXEvmpFbalr3sZcp
	e6cvDeSf4u56zsXwRsvbsGtGXqbaYcnPF7yb8FXo+zGJC/GLDm6/fcH2aY339boDLBfNvhlV
	czSeceJ47e7V1Jrc0FbFLPFz1Z0041yGt42fPfwkXm26m/n207f83wU3MmQ2G26YdGPW19So
	1axrGpX+OU50eLK7UeOX7zyuoizJbQq37r88xOY1PUCWMfflBwUz55ATn886sZr97rT5vde/
	ar7fw1vzas5UHJ92YG29/Q6jyIYdW7enMcx1XtCxO/HeBZPEkkebjqhuvHsoc8uxS7d9T7y6
	f9ZwxXumwkYlluKMREMt5qLiRACxqyeE4QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsVy+t/xu7qbzI6lGuw/IW0xZ/0aNovXhz8x
	Wpzt+81mcXrCIiaLp5/6WCxmT29mstiz9ySLxeVdc9gs7q35z2pxY8JTRovzf4+zWvz+MYfN
	gcdj56y77B4LNpV6bF6h5bFpVSebx6ZPk9g9Tsz4zeJxZsERdo/Pm+Q8Nj15yxTAGaVnU5Rf
	WpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8WDpN5aCGWwV
	u7vvMzUw9rN2MXJySAiYSGz885Wti5GLQ0hgKaNE+5IHbBAJGYmNX65CFQlL/LnWBVX0kVGi
	4cEpVgjnNKNE74lnjBDOCkaJM+9/g7WwCWhK7Du5iR0kISLwlFFi+u9DLCAJZoGbzBJf3oiB
	2MIC9hL7Hv0BaxARcJG49W0SC4StJ3F14QewOIuAisS8KSuB4hwcvAJWErMW8YKEhYDMadtP
	g53KKWAtMe/RejCbUUBW4tHKX+wQq8Qlbj2ZzwTxgoDEkj3nmSFsUYmXj/9BvaYjcfb6E0YI
	20Bi69J9LBC2okTHsZtsEHP0JG5MnQJla0ssW/gabA6vgKDEyZlPWCYwSs9Csm4WkpZZSFpm
	IWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzBNbTv2c8sOxpWvPuodYmTiYDzEKMHB
	rCTCG7LkSKoQb0piZVVqUX58UWlOavEhRlNgEE1klhJNzgcmyrySeEMzA1NDEzNLA1NLM2Ml
	cV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqZ5ho5S/3nX7Nx7V/NZhbc57+qVRxvS5P85r512
	JmzDIan0bfFn9l6f9Dh4rvOr5TXP3qewsBx6yPfj3K58dXvNq6/uBf7f8jrIt27Kozenvwdv
	+2S+0ObVt7s/bU4K7zGbplkzg4F7y0fZK3/KJiguzb166Ns8A5PamyvT9Y55GkYH7pjoyTgz
	Y/GcOcW8S47oLdYO+3Oh6Z+Jyt6WOadSyiX6d3QqP96cO51dV1XvvGTkvAfRObvf7Xyieum1
	SGzs7fRg/yJ5tj+Mybyp2R1WtzOvWQt1H9jHY/m85+H/H8nK+f4st9eyr28/LRe2Sp1nj56q
	3ddt4rY2EWHvv9jkCJ82+r3jkNkJ36JlJ9cnKLEUZyQaajEXFScCADcGFbrcAwAA
X-CMS-MailID: 20240209142906eucas1p2c31598bf448077f04eef66319ae2f3a1
X-Msg-Generator: CA
X-RootMTR: 20240209142906eucas1p2c31598bf448077f04eef66319ae2f3a1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240209142906eucas1p2c31598bf448077f04eef66319ae2f3a1
References: <20240209142901.126894-1-da.gomez@samsung.com>
	<CGME20240209142906eucas1p2c31598bf448077f04eef66319ae2f3a1@eucas1p2.samsung.com>

When reclaiming some space by splitting a large folio through
shmem_unused_huge_shrink(), a large folio is split regardless of its
uptodate status. Mark all the blocks as uptodate in the reclaim path so
split_folio() can release the folio private struct (shmem_folio_state).

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 mm/shmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index b6f9a60b179b..9fa86cb82da9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -836,6 +836,7 @@ static unsigned long shmem_unused_huge_shrink(struct sh=
mem_sb_info *sbinfo,
 			goto move_back;
 		}
=20
+		shmem_set_range_uptodate(folio, 0, folio_size(folio));
 		ret =3D split_folio(folio);
 		folio_unlock(folio);
 		folio_put(folio);
--=20
2.43.0

