Return-Path: <linux-fsdevel+bounces-10965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275D984F74C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 15:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBBF1C21B76
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CF569DF0;
	Fri,  9 Feb 2024 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YapIIPGe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC9069965
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488950; cv=none; b=OLTHpkNd11wmYWhSE9ezFrtjOXm43eVSkH+79EELO5DD6BzN6J1qPgMJLlbWsEQadTdpzppI0uwnizcMhOFtxkW6GZHM/XpvHRTUe/ziRmckMyF8Tv308mb/G11ARE3oB59N3Ek+Kc+CofJhwy2BT3wR2CQhZ9orz89hXa14Rsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488950; c=relaxed/simple;
	bh=0O3RfgYbkdJ1kGWT2lEPHUEzW3Hv7N5M06u8M3HTzN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=LGqCrGhZMk7/G2/6BmPPSS1n7U0p7ERa4YrCINAl6tzuguv5Ihwnj5ieWtzzOKjtbK8AxJvpH3tRIJKvAgVWmhVfcA4F4gD+t+QVnh6v00arP2m0rZb4j/xmyngrABrsvPBh4aNhRAvZEvogRO04LB/3TKoRzPzfJZASINNkQ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YapIIPGe; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240209142906euoutp017c7414aa334155c85836cd60f4289fe4~yOCZvF2vI2752227522euoutp01j
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240209142906euoutp017c7414aa334155c85836cd60f4289fe4~yOCZvF2vI2752227522euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707488946;
	bh=yzLVEVoC51q0kiEHcn5lFzpeprpnxNh9RSZm3CgLznw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=YapIIPGeo6UtoKnrOw0E2jh3ReyHWKrHHmEiQyUInlp4KSlYxp/L/OiXftCBNIToZ
	 NdbeJmuIhweJNqmEp5GcJEurA5vwyFzz+vWs/MgtuF8bRGPGRlAWqS0ntDKKKMMxGj
	 2UqNrOu58jjXE2KQXhaCvloLIoReTt24Jj5nLy78=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240209142906eucas1p2d99cf5db5353012f5c7e394c72654656~yOCZbd3hY2346823468eucas1p2b;
	Fri,  9 Feb 2024 14:29:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 6B.2E.09552.1B636C56; Fri,  9
	Feb 2024 14:29:06 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240209142905eucas1p150b096fab4b8a684b416d3beb0df901b~yOCY9kYJh0934709347eucas1p1k;
	Fri,  9 Feb 2024 14:29:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240209142905eusmtrp1db904eebec0428be2c7c1271c40b4f46~yOCY86pwm0528405284eusmtrp10;
	Fri,  9 Feb 2024 14:29:05 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-97-65c636b12cf7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 10.B3.10702.1B636C56; Fri,  9
	Feb 2024 14:29:05 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240209142905eusmtip1bbccce327c924057684231d1edcf32cc~yOCYv0MCC3127531275eusmtip1c;
	Fri,  9 Feb 2024 14:29:05 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Fri, 9 Feb 2024 14:29:04 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 9 Feb
	2024 14:29:04 +0000
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
Subject: [RFC PATCH 4/9] shmem: exit shmem_get_folio_gfp() if block is
 uptodate
Thread-Topic: [RFC PATCH 4/9] shmem: exit shmem_get_folio_gfp() if block is
	uptodate
Thread-Index: AQHaW2RUvpPeBHpDT0yQa2xBM9HYnQ==
Date: Fri, 9 Feb 2024 14:29:03 +0000
Message-ID: <20240209142901.126894-5-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djP87qbzI6lGvQcZbSYs34Nm8Xrw58Y
	Lc72/WazOD1hEZPF0099LBazpzczWezZe5LF4vKuOWwW99b8Z7W4MeEpo8X5v8dZLX7/mMPm
	wOOxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSeweJ2b8ZvE4s+AIu8fnTXIem568ZQrgjOKySUnN
	ySxLLdK3S+DK6Nl9ga1gG1fF0kVr2RsY93J0MXJySAiYSPzoP8XUxcjFISSwglHi0K9djBDO
	F0aJJe0P2SCcz4wSOy/NYe5i5ABrmX9BBSK+nFFi4dQ3zHBFm9bPguo4zShxec5PdrjBRxf+
	ZQfZyCagKbHv5CawhIjAc0aJ1t0fwRxmgZvMEteunmcDqRIWCJT4OO8xE4gtIhAmsXrCMXYI
	W0/i/ru9LCA2i4CKxLwpK1lAjuIVsJJoa6wACXMKWEvMe7QebAyjgKzEo5W/wFqZBcQlbj2Z
	zwTxtqDEotl7mCFsMYl/ux6yQdg6EmevP2GEsA0kti7dxwJhK0p0HLvJBjFHT+LG1ClQtrbE
	soWvwebwAs08OfMJC8gvEgJdXBIreuawQjS7SDTMeQ81VFji1fEt7BC2jMTpyT0sExi1ZyG5
	bxaSHbOQ7JiFZMcCRpZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsYgUnu9L/jX3cwrnj1
	Ue8QIxMH4yFGCQ5mJRHekCVHUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzqqbIpwoJpCeWpGan
	phakFsFkmTg4pRqY5r9+oPgwNvgm07wX8YHhbHfKOB/5cusuUBBOO/7vy9+VivN5772PnGTG
	fcArct2fsvNHn8xq/+SpNHd6UV8z89up0gWbtQr3Hf263nJ+r+s2U2vx2Tw7BXf++1vhe730
	2rFX29r1fa2nrr3KInH4r0iAxQx11l/7X7Opiy4/2WRs+kPASFzSXoPzRnfV9Hf6bwzCbWVe
	2MzaLdHx1mLvXEPvfwsZ10V4bXRj1H3HwcB4YdbJXc/i5T0W1fHslPj5N7/0qk9IWrszQ8TH
	zJVtD83+TFdLPmxS+FxBtfWA9TarpmCXXXuPzfEvz+v5ft2jKHrq8gmHwuucOi3nz31+w/jF
	+uYaxhXRr4+atpT4KLEUZyQaajEXFScCADmCe0DhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsVy+t/xu7obzY6lGrxaI2cxZ/0aNovXhz8x
	Wpzt+81mcXrCIiaLp5/6WCxmT29mstiz9ySLxeVdc9gs7q35z2pxY8JTRovzf4+zWvz+MYfN
	gcdj56y77B4LNpV6bF6h5bFpVSebx6ZPk9g9Tsz4zeJxZsERdo/Pm+Q8Nj15yxTAGaVnU5Rf
	WpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX0bP7AlvBNq6K
	pYvWsjcw7uXoYuTgkBAwkZh/QaWLkYtDSGApo8SLdWeYuhg5geIyEhu/XGWFsIUl/lzrYoMo
	+sgosbt7BliRkMBpRomL50ohEisYJboWrQRLsAloSuw7uYkdJCEi8JRRYvrvQywgCWaBm8wS
	X96IgdjCAoESH+c9BmsQEQiT6D/XzwZh60ncf7cXrJ5FQEVi3pSVLCCn8gpYSbQ1VkAstpKY
	tv00WDmngLXEvEfrwWxGAVmJRyt/sUOsEpe49WQ+1DcCEkv2nGeGsEUlXj7+B/WZjsTZ608Y
	IWwDia1L97FA2IoSHcduskHM0ZO4MXUKlK0tsWzha7A5vAKCEidnPmGZwCg9C8m6WUhaZiFp
	mYWkZQEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAFLXt2M8tOxhXvvqod4iRiYPxEKME
	B7OSCG/IkiOpQrwpiZVVqUX58UWlOanFhxhNgUE0kVlKNDkfmCTzSuINzQxMDU3MLA1MLc2M
	lcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYJvBIXfz2wOyYmnndl92bzx85trB8vd6cPV2H
	k98umZs256ByTdDzA2rF0qlvp3rtd6y5fKhp8d6csuUtIg7z1nKYbbxxauVyq1UGpzgvhZ07
	frcw/9phERGNNuF1O7Yys606IDyjfHFzZr3rP7HrLOd3iS+av+OwR/GssGu6Oo5ymSf7T9nf
	C3vJxeqskzsnd997x9svn2VYlMwsuXxHJ5bPfcKZKe9/FF9x1E4tsF5pr/Sbe0JE6vzPt85v
	tZdgMavf8c7sfXL4+bYpAndVd3zjP7ct3PaKo8i1wlqRb1N954Xwbryoe/nNHsfTBmGGc2f/
	f8m/Ze2Snca6gs5zr9dWJHmf+5wssHa59yTmzplKLMUZiYZazEXFiQDLC80l2gMAAA==
X-CMS-MailID: 20240209142905eucas1p150b096fab4b8a684b416d3beb0df901b
X-Msg-Generator: CA
X-RootMTR: 20240209142905eucas1p150b096fab4b8a684b416d3beb0df901b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240209142905eucas1p150b096fab4b8a684b416d3beb0df901b
References: <20240209142901.126894-1-da.gomez@samsung.com>
	<CGME20240209142905eucas1p150b096fab4b8a684b416d3beb0df901b@eucas1p1.samsung.com>

When we get a folio from the page cache with filemap_get_entry() and
is uptodate we exit from shmem_get_folio_gfp(). Replicate the same
behaviour if the block is uptodate in the index we are operating on.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 mm/shmem.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 3bddf7a89c18..614cda767298 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -256,6 +256,16 @@ static inline bool shmem_is_any_uptodate(struct folio =
*folio)
 	return folio_test_uptodate(folio);
 }
=20
+static inline bool shmem_is_block_uptodate(struct folio *folio,
+					   unsigned int block)
+{
+	struct shmem_folio_state *sfs =3D folio->private;
+
+	if (folio_test_large(folio) && sfs)
+		return sfs_is_block_uptodate(sfs, block);
+	return folio_test_uptodate(folio);
+}
+
 static void shmem_set_range_uptodate(struct folio *folio, size_t off,
 				     size_t len)
 {
@@ -2143,7 +2153,7 @@ static int shmem_get_folio_gfp(struct inode *inode, p=
goff_t index,
 		}
 		if (sgp =3D=3D SGP_WRITE)
 			folio_mark_accessed(folio);
-		if (folio_test_uptodate(folio))
+		if (shmem_is_block_uptodate(folio, index - folio_index(folio)))
 			goto out;
 		/* fallocated folio */
 		if (sgp !=3D SGP_READ)
--=20
2.43.0

