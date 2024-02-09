Return-Path: <linux-fsdevel+bounces-10961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DF884F745
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 15:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFD61F218D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B01A6997E;
	Fri,  9 Feb 2024 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LzdQ56ug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7579369957
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488948; cv=none; b=LxiI0iZZTTxR62nMIhbG9OsrED0CAnJ86o98XWxrly/2FxPAnEQHEvmitKQoqrhrzxk8M/5MyNROow0Z2MzKnU46AVNASqfpgwOXySZB/UoKo1MXNqW/4bXD/g7rHN73r39+g3l0vlUN3Rf1WibMaYrtwZ7JMoiyPp0/49zBvfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488948; c=relaxed/simple;
	bh=jJSsCzIPLDt1dUl38isaDgdPo1XoyXbEHM2UbvgYw/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=K1rOhA6jo/oa/itVC/8gzYEPRPim5QyqjFCup54LKw+m2dQtNR+6k7UNMzvn2HgJ3dGTa8lQ7W40BOBWmGrNJRiBOvYy79E/uJS/XX5nMJEDLkYF/n2l+aW+GweqceGAhplMybsnir/ILViuLS0LIvWGSA05zwfQKs2U3Z2THFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LzdQ56ug; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240209142904euoutp02bb864e26136758fff5bafb9a7cc82c21~yOCX9CqxB2144921449euoutp02N
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240209142904euoutp02bb864e26136758fff5bafb9a7cc82c21~yOCX9CqxB2144921449euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707488944;
	bh=Xp/CDCIv8x19lL1UbiGyRLdd/wr0PppohAnD3gAfH/c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=LzdQ56uglyxjaJchOqqToC0c03bgWaOs+RPDfGhHNU9nsIH+BF6X887k+qb9pBDBM
	 MQgLLEY70ciK0e/b+vB/b4SQGZiKoMEKA77+j6Pyunniki1dNFeugxTTAy4Eml3nR+
	 bF64C58U7sasaiGtG9I6zpBtSo2oSuhVUIoRNCMk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240209142904eucas1p21b3aca7b96105d3b5578a9ff3ae31d1f~yOCXp-XiZ0208902089eucas1p2U;
	Fri,  9 Feb 2024 14:29:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id E8.2E.09552.0B636C56; Fri,  9
	Feb 2024 14:29:04 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240209142903eucas1p17f73779c6b38276cd7cefbe0a40f355e~yOCXQxwuN0937209372eucas1p1W;
	Fri,  9 Feb 2024 14:29:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240209142903eusmtrp2f9b51616ff70cd7034716594c79ec1a4~yOCXQJcRl2110121101eusmtrp2Y;
	Fri,  9 Feb 2024 14:29:03 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-89-65c636b0a566
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 06.6F.09146.FA636C56; Fri,  9
	Feb 2024 14:29:03 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240209142903eusmtip1cba34f5186d87344c625af1f3f3dac53~yOCXDXR-x2720027200eusmtip1v;
	Fri,  9 Feb 2024 14:29:03 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Fri, 9 Feb 2024 14:29:03 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 9 Feb
	2024 14:29:03 +0000
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
Subject: [RFC PATCH 1/9] splice: don't check for uptodate if partially
 uptodate is impl
Thread-Topic: [RFC PATCH 1/9] splice: don't check for uptodate if partially
	uptodate is impl
Thread-Index: AQHaW2RTk/uEtIw1W0yBH2EezPFdkg==
Date: Fri, 9 Feb 2024 14:29:02 +0000
Message-ID: <20240209142901.126894-2-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURSFfTPT6VBtGAqRJ66AK9IKwehEjZGocRKMQYMmGBeqjHVpETpU
	kERFAVEkFQluhUBVEFAitioqm9pioRbDDyOCUZZaRFFBioBaBWkHE/59991z7zk3eQQqauT5
	EAdi4hlljFTuhwuwCtOvJvHdZSYmSK0RUHnlZTj1xWgH1Eu1A6csWdcRqsuuxqjcyykIVV1j
	xqhXlXk41VY2yqNasroA1fS3nkc5fubha6bQjzXv+bRWr6LvlQTQ+ltncVpvz+bTDVccGN2o
	rePTA/pZtN72DQl32y5YFc3IDxxhlEtWRwn2tw7U8mMz3RNPvhjGksH3yRnAjYDkUlh6LxnJ
	AAJCRJYAWP68DOeKHwBaU/swp0pEDgDY/3TH/4mK7AKUey8GsP3dNG5gTDNythTjCguAP9su
	8jjV2F7DOy8n4+QiWGvW850iL7IbwLSqfleBkq0obH7dNGZOEJ5kJLydss054EXugrcr0hCO
	JfD+07euSBg5F2qL2l0xhOQKWKbrd2ncyJUw31qOOxmQM6G19DffySjpDd/aChDuBA94Pbca
	5XgqHKnsxDkOhC/f2ADHQfBBUS3GsS88Y2rFuT0S2HIxZ5wXw5vXvoxn8IDmqzbX9ZDMEEDj
	k6Fxs3XQ+Kdl3MAT9tTf53M8A44+LkCywGLNhHyaCR6aCR6aCR5agN0C3oyKVcgYNiSGSZCw
	UgWripFJ9h5W6MHYh7OM1A8+AiU9/RIDQAhgAJBA/byEEYV1jEgYLT2axCgP71aq5AxrANMJ
	zM9bOC96NiMiZdJ45hDDxDLK/12EcPNJRk5Z1nYEnLjj+Nh4p3tIc9JenqpjfRsa8iMjrBsS
	H84R//KdygZHBgZ1V4t1uqr0uGnhO0/dKLSt1W0pVmxJ68DT5722mGtS5T57Pxf6SxslvTU5
	gwnxYUWhjLU9dDDjtN0e0jts67o8SXgBkW2uKxDmfJ3f1NFjjvoUmiAJ3rjv2J6Ku31b02cF
	t23QBa04tMhRG6dYsF40n4dqfZbPWSMbyr7RvO/ZOTT5oe8D9fI3RFWf2PD8iMrg72Gsu5TZ
	2ZzGk8Xu7hz+nhTmGfc3M2p1ZeemhexVD5N7ZdLo0fzzowfDjOJw/YeQ4+qE3sDc0MQU/6Um
	+/aAHHd5VGb0t/chfhi7XxocgCpZ6T8WE4qB3wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsVy+t/xu7rrzY6lGnxep2kxZ/0aNovXhz8x
	Wpzt+81mcXrCIiaLp5/6WCxmT29mstiz9ySLxeVdc9gs7q35z2pxY8JTRovzf4+zWvz+MYfN
	gcdj56y77B4LNpV6bF6h5bFpVSebx6ZPk9g9Tsz4zeJxZsERdo/Pm+Q8Nj15yxTAGaVnU5Rf
	WpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXcfPzPvaCHv6K
	xlPfWRoYP3B3MXJySAiYSGybNJ+5i5GLQ0hgKaPE25YnrBAJGYmNX65C2cISf651sUEUfWSU
	eP63BarjNKPEux+3GCGcFYwS/3dPYAZpYRPQlNh3chM7SEJE4CmjxPTfh1hAEswCN5klvrwR
	62Lk4BAWiJRY3RwGEhYRiJOYd24bC4StJ7HlwC0wm0VARWLB0vtgM3kFrCTWbPzIBGILAdnT
	tp9mA7E5Bawl5j1aD2YzCshKPFr5ix1ilbjErSfzmSBeEJBYsuc8M4QtKvHy8T+o13Qkzl5/
	wghhG0hsXbqPBcJWlOg4dpMNYo6exI2pU6BsbYllC19D3SMocXLmE5YJjNKzkKybhaRlFpKW
	WUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAhMU9uO/dy8g3Heq496hxiZOBgPMUpw
	MCuJ8IYsOZIqxJuSWFmVWpQfX1Sak1p8iNEUGEYTmaVEk/OBiTKvJN7QzMDU0MTM0sDU0sxY
	SZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoFJ4kvLg00v1ULcvLft8L5jveKF97XaNV/uLPh0
	dt3KuJr6asOH8S+v3F4d6Hjq5Ytjq55c7X8nnyasYP/pwIpjtZOyPJPXnSpN3i+hMf/474/H
	mv48Tp2daSt08d7+N36bYx/WMD3s3bGvPccl/TP/t5bsmJ8H+t4YX3SdX2C6oOHJ7h23nI5H
	HT3HkPpq+sr596enssyZZsx5ZP7jtLVrXkZNTlT/+uLL7bM/jj5w/ZFjWx6RZV6bvmaZVwxD
	3/NG8ZU8a37r/HUuuckkwdX07oF28sMs7c9v/GdMskmqFpjEcqEpft3GXVxmV5eIt7Xzx1eb
	lR/8/jPYv1heifkQ+5zVaq/fR/4p8BYrtGqRPa7EUpyRaKjFXFScCAAnnUg83AMAAA==
X-CMS-MailID: 20240209142903eucas1p17f73779c6b38276cd7cefbe0a40f355e
X-Msg-Generator: CA
X-RootMTR: 20240209142903eucas1p17f73779c6b38276cd7cefbe0a40f355e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240209142903eucas1p17f73779c6b38276cd7cefbe0a40f355e
References: <20240209142901.126894-1-da.gomez@samsung.com>
	<CGME20240209142903eucas1p17f73779c6b38276cd7cefbe0a40f355e@eucas1p1.samsung.com>

From: Pankaj Raghav <p.raghav@samsung.com>

When huge_page=3Dalways is set in tmpfs, it will zero out the whole page ev=
en
if only a small part of it is written, and it updates the uptodate flag of =
the
whole huge page.

Once the per-block uptodate tracking is implemented for tmpfs hugepages,
pipe_buf_confirm only needs to check the range it needs to splice to be
uptodate and not the whole folio as we don't set uptodate flag for partial
writes.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---

Other option here is to have a separate implementation of
page_cache_pipe_buf_ops  for tmpfs instead of changing the
page_cache_pipe_buf_confirm.

 fs/splice.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 218e24b1ac40..e6ac57795590 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -120,7 +120,9 @@ static int page_cache_pipe_buf_confirm(struct pipe_inod=
e_info *pipe,
 				       struct pipe_buffer *buf)
 {
 	struct folio *folio =3D page_folio(buf->page);
+	const struct address_space_operations *ops;
 	int err;
+	off_t off =3D folio_page_idx(folio, buf->page) * PAGE_SIZE + buf->offset;
=20
 	if (!folio_test_uptodate(folio)) {
 		folio_lock(folio);
@@ -134,12 +136,21 @@ static int page_cache_pipe_buf_confirm(struct pipe_in=
ode_info *pipe,
 			goto error;
 		}
=20
+		ops =3D folio->mapping->a_ops;
 		/*
 		 * Uh oh, read-error from disk.
 		 */
-		if (!folio_test_uptodate(folio)) {
-			err =3D -EIO;
-			goto error;
+		if (!ops->is_partially_uptodate) {
+			if (!folio_test_uptodate(folio)) {
+				err =3D -EIO;
+				goto error;
+			}
+		} else {
+			if (!ops->is_partially_uptodate(folio, off,
+							buf->len)) {
+				err =3D -EIO;
+				goto error;
+			}
 		}
=20
 		/* Folio is ok after all, we are done */
--=20
2.43.0

