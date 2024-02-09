Return-Path: <linux-fsdevel+bounces-10967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BF884F74F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 15:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70931F22530
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCBA6A351;
	Fri,  9 Feb 2024 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RBme5bg9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B520369DE5
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488952; cv=none; b=Q6eNJ2Cj4ek5Xji0bcU/SUlsIXhJ0h/3MkahE8YbYL5D9+jveuHnsTmYaglAeLkQ3H+05KIoIA/0hDbsgHG9y+GRX1KDWLy8YyAdlbuZmVmKaxGH0Mf6R6H5192kPIaVgCHLl6PECTk8lQWy3rsBIqUwarCkpegdPPI7c2D/1v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488952; c=relaxed/simple;
	bh=oTRfFe+/EH7DLR5K66X2qKeSonuT+RMKMk6eYxbGvf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=cLKVBUVXQsNYOHRm/Ju3wMsRXIhhThWb0RqiV7d5ScgmIThczkchC45CyBO9GSKnLS1IeMrettVwLhUWCjO0Gbf8b3Wxn+FNG9TJrzJK8pk90mA9VIm9l5gDXTU/HSC7wC9trLp3NMv4ViIeavMa3XfpsESQJZRzdKPI40NlTjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RBme5bg9; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240209142907euoutp02e232d7037cd6f60204e5a0a839f1f81f~yOCa8b1k22142421424euoutp02O
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240209142907euoutp02e232d7037cd6f60204e5a0a839f1f81f~yOCa8b1k22142421424euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707488947;
	bh=2ukBs3XODipZcH9UMRwa+Bu+eJvhDnac4gizoogX/Is=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=RBme5bg9CdOVU1oMxV4Ybb5Xo1Nj93LPn/TZtYuGuDM8JoXqabMx1IU3QdKo7ub71
	 br84AeHS1lrt3ijAYBC6HuMLYGxyp0VVNLhcqZ+bvQl9HOZFq7OxWRJ+FKG5t7UoD+
	 ozfa6KR1lEkjdqiPt4HA+LzBQOIeV3uqHiwc+BsA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240209142907eucas1p22dc004862a93d76c2817fc28c5432e48~yOCapm-8m0060200602eucas1p2G;
	Fri,  9 Feb 2024 14:29:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 9D.2E.09552.3B636C56; Fri,  9
	Feb 2024 14:29:07 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240209142907eucas1p2024d2809a150c6e58082de0937596290~yOCaQYIdi0486804868eucas1p2E;
	Fri,  9 Feb 2024 14:29:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240209142906eusmtrp1ee69ff838c2b80b9dc3c11119a3a418b~yOCaPfpUX0528405284eusmtrp1C;
	Fri,  9 Feb 2024 14:29:06 +0000 (GMT)
X-AuditID: cbfec7f5-0bd9da8000002550-a1-65c636b3a878
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 04.B3.10702.2B636C56; Fri,  9
	Feb 2024 14:29:06 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240209142906eusmtip2e2024a73a312042137f498874cbdbfe6~yOCaHDNtj0196001960eusmtip2P;
	Fri,  9 Feb 2024 14:29:06 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Fri, 9 Feb 2024 14:29:06 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 9 Feb
	2024 14:29:06 +0000
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
	"Daniel Gomez" <da.gomez@samsung.com>
Subject: [RFC PATCH 7/9] shmem: check if a block is uptodate before splice
 into pipe
Thread-Topic: [RFC PATCH 7/9] shmem: check if a block is uptodate before
	splice into pipe
Thread-Index: AQHaW2RVHDRO8t3PIUKSo0ZMZU2cLg==
Date: Fri, 9 Feb 2024 14:29:04 +0000
Message-ID: <20240209142901.126894-8-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djPc7qbzY6lGhzsEbeYs34Nm8Xrw58Y
	Lc72/WazOD1hEZPF0099LBazpzczWezZe5LF4vKuOWwW99b8Z7W4MeEpo8X5v8dZLX7/mMPm
	wOOxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSeweJ2b8ZvE4s+AIu8fnTXIem568ZQrgjOKySUnN
	ySxLLdK3S+DK2Nt1ibXgMW/F1u2fGRsY73N1MXJySAiYSDT3bWbtYuTiEBJYwSixdU8vlPOF
	UeLjpW1MEM5nRolHX84wwbSsnzCDBSKxnFHi6ckvjHBVy/a+Z4dwTjNK3AK6G6QFbPKuqeog
	NpuApsS+k5vAikQEnjNKtO7+COYwC9xmlpjTPosRpEpYIEyi8eVldhBbRCBaYsLHZUwQtp7E
	06m/2UBsFgEViTU7ToDV8wpYSdz8uhOsnlPAWmLeo/VgNYwCshKPVv4CizMLiEvcejIf6glB
	iUWz9zBD2GIS/3Y9ZIOwdSTOXn/CCGEbSGxduo8FwlaU6Dh2kw1ijp7EjalToGxtiWULXzND
	3CAocXLmE3DASAi0cUn8WXoRaBAHkOMi8eEPH8QcYYlXx7ewQ9gyEqcn97BMYNSeheS8WUhW
	zEKyYhaSFQsYWVYxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEJrnT/45/3cG44tVHvUOM
	TByMhxglOJiVRHhDlhxJFeJNSaysSi3Kjy8qzUktPsQozcGiJM6rmiKfKiSQnliSmp2aWpBa
	BJNl4uCUamDKYLG9pbXYZZHxnJr3PgpWXVsVTfffPWH6oailKUAkdN6zxGBey78dFW49TjfO
	6i5cEnZY+NmKWaHSkwNMsr4+Y3RyTXVMe3zx4ZzH/3dqGn52/v1ad/WyOwu/yL1ZydL31+iU
	4JFyw1qxVL4MnvrjbuxOO2XMm9MO+CyLOLenpWbBkX2Pp3wVaHg7i1Pi9RyBOa9t71/cVFg9
	b8mJVTbrrkRXiKRkHOoMae2fqvhnk1rzQ7tZJRd/1bWYvTa5tM9OKSvk0Y2ZG6aplO3K8rNP
	mch+dfWkqIl9oX/PrMiN2i/BP/m+6FOVBZeXqpxQEH5wR+tRpW/Bs0oV00enWF4/eCL6m+P3
	6cu6FsfWnTvMp8RSnJFoqMVcVJwIAIAP0zThAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsVy+t/xe7qbzI6lGqw/bGkxZ/0aNovXhz8x
	Wpzt+81mcXrCIiaLp5/6WCxmT29mstiz9ySLxeVdc9gs7q35z2pxY8JTRovzf4+zWvz+MYfN
	gcdj56y77B4LNpV6bF6h5bFpVSebx6ZPk9g9Tsz4zeJxZsERdo/Pm+Q8Nj15yxTAGaVnU5Rf
	WpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXsbfrEmvBY96K
	rds/MzYw3ufqYuTkkBAwkVg/YQZLFyMXh5DAUkaJaweuMEMkZCQ2frnKCmELS/y51sUGUfSR
	UeL/q5tQzmlGiZ4JO5kgnBWMEsc+dLOBtLAJaErsO7mJHSQhIvCUUWL670NgS5gFbjNLzGmf
	xQhSJSwQJtH48jI7iC0iEC1x/dsnZghbT+Lp1N9gk1gEVCTW7DgBVs8rYCVx8+tOsHohIHva
	9tNgNZwC1hLzHq0HsxkFZCUerfwFVsMsIC5x68l8JognBCSW7DkP9ZyoxMvH/6Ce05E4e/0J
	I4RtILF16T4WCFtRouPYTTaIOXoSN6ZOgbK1JZYtfM0McY+gxMmZT1gmMErPQrJuFpKWWUha
	ZiFpWcDIsopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwVW079nPLDsaVrz7qHWJk4mA8xCjB
	wawkwhuy5EiqEG9KYmVValF+fFFpTmrxIUZTYBhNZJYSTc4HJsu8knhDMwNTQxMzSwNTSzNj
	JXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQamHrZNE+tE/n5ST+rf8t4pdfe+hpfaF18a/mAJ
	6jJc6ar0y0CNY9qfh0ff+sstOslotzB9xZUnC8v93RibZiT2Piy/a9Ib6s7W52euIN84+aGC
	rH+dW3pxo/Zyc/NnAifeWU/o2XHtTUv8u1U3w4qUZKSeaH2+3PrCW1ws1k5h4YFynSlCG1nu
	zL0YLv9FRPeBx4eNS1qXp+7MexN0Tn65XkkdZ99bz+zQtGuPg+xfp/MpbHrY7LFx1rc79rNV
	lWL9Wbr0L9blVHez8rG/frrul67L7au7T3JE/Vvn/aC8qNrY44fPshtbanV7ei8s5YjdIu1b
	ZDsxXHvJjXU3CounL41h5OsTfW7yu7htIpMSS3FGoqEWc1FxIgA4VgMl3gMAAA==
X-CMS-MailID: 20240209142907eucas1p2024d2809a150c6e58082de0937596290
X-Msg-Generator: CA
X-RootMTR: 20240209142907eucas1p2024d2809a150c6e58082de0937596290
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240209142907eucas1p2024d2809a150c6e58082de0937596290
References: <20240209142901.126894-1-da.gomez@samsung.com>
	<CGME20240209142907eucas1p2024d2809a150c6e58082de0937596290@eucas1p2.samsung.com>

The splice_read() path assumes folios are always uptodate. Make sure
all blocks in the given range are uptodate or else, splice zeropage into
the pipe. Maximize the number of blocks that can be spliced into pipe at
once by increasing the 'part' to the latest uptodate block found.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 mm/shmem.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 9fa86cb82da9..2d2eeb40f19b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3196,8 +3196,30 @@ static ssize_t shmem_file_splice_read(struct file *i=
n, loff_t *ppos,
 		if (unlikely(*ppos >=3D isize))
 			break;
 		part =3D min_t(loff_t, isize - *ppos, len);
+		if (folio && folio_test_large(folio) &&
+		    folio_test_private(folio)) {
+			unsigned long from =3D offset_in_folio(folio, *ppos);
+			unsigned int bfirst =3D from >> inode->i_blkbits;
+			unsigned int blast, blast_upd;
+
+			len =3D min(folio_size(folio) - from, len);
+			blast =3D (from + len - 1) >> inode->i_blkbits;
+
+			blast_upd =3D sfs_get_last_block_uptodate(folio, bfirst,
+								blast);
+			if (blast_upd <=3D blast) {
+				unsigned int bsize =3D 1 << inode->i_blkbits;
+				unsigned int blks =3D blast_upd - bfirst + 1;
+				unsigned int bbytes =3D blks << inode->i_blkbits;
+				unsigned int boff =3D (*ppos % bsize);
+
+				part =3D min_t(loff_t, bbytes - boff, len);
+			}
+		}
=20
-		if (folio) {
+		if (folio && shmem_is_block_uptodate(
+				     folio, offset_in_folio(folio, *ppos) >>
+						    inode->i_blkbits)) {
 			/*
 			 * If users can be writing to this page using arbitrary
 			 * virtual addresses, take care about potential aliasing
--=20
2.43.0

