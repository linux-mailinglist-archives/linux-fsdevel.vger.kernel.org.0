Return-Path: <linux-fsdevel+bounces-10970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0628784F752
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 15:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D966EB24E14
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324D96D1BF;
	Fri,  9 Feb 2024 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mJJtc+wH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44369DFE
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488953; cv=none; b=doKoq3aTs1fzZrkbJRQT9YzeKDDajDk+ShSbOfyl6apfXvnM1bCY2gNU8ugpK9maZs188JyqQSQLP9lcapeVMjGaLAKMsiu7o78SCp8F9EFcOZwLcKks+cvHR9FvWEvnJSkubfIaOzFUXRfoRXOpi7+lI1m3Qgp0Xzz6Tx0Pb/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488953; c=relaxed/simple;
	bh=r6Ol6y0mnebhEygqGrvK/spAs7z687jAlcbMwM0SB6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=F+nSxyyjm+grZoW+L+Nyf/wVK9ycI5F9vGO2ChGi2jJ49j4+9yD5IeEaEVnMGDkX1SbDDdAG2MtDKvWmFqBd/f0gaiCTDTEzBouIpNUIln2XTMhonQHtYSf2RfZHTI3z3AIAmAvQK0nSwWvcIeTp6jUIKBIe95AW8OgCvcqiJ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mJJtc+wH; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240209142908euoutp0195376e77bb1a57c745ef4f81f16cd928~yOCbzcNBs2868428684euoutp01V
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240209142908euoutp0195376e77bb1a57c745ef4f81f16cd928~yOCbzcNBs2868428684euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707488948;
	bh=in2JJaC6z0hyyXkhiWr41goVesPZul0LbQ6MoMc6gD8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=mJJtc+wHdVtbKLh9QIe7WtgIgcGvC/B7E1+ZDWt2UxA33cabY3UIi4T3tWqSUlyvs
	 yEGnYQKz1wxb/PjnFfzkToMEELRWBnnxFDineTR5mPq9vNfWPgZ4lZfJh6/EYSyx/P
	 ybgJyEjcl+8w1l9CZXdElNkQD12UfNGefzPFdUQI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240209142908eucas1p1973ff851315c007e944feacc1f5a865e~yOCbhG5KR0281802818eucas1p1u;
	Fri,  9 Feb 2024 14:29:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E7.0E.09539.4B636C56; Fri,  9
	Feb 2024 14:29:08 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240209142907eucas1p12155b2fb002df5e0cd617fa74de757b7~yOCbH0wck0925409254eucas1p1e;
	Fri,  9 Feb 2024 14:29:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240209142907eusmtrp227ac3a1f0f02114b44aba3f8379080b8~yOCbG3YFC2110121101eusmtrp2l;
	Fri,  9 Feb 2024 14:29:07 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-20-65c636b4eed0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 8C.6F.09146.3B636C56; Fri,  9
	Feb 2024 14:29:07 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240209142907eusmtip12fe86939f9724620bf04f483aa2a19ca~yOCa96s592720027200eusmtip11;
	Fri,  9 Feb 2024 14:29:07 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
	Server (TLS) id 15.0.1497.2; Fri, 9 Feb 2024 14:29:07 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 9 Feb
	2024 14:29:07 +0000
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
Subject: [RFC PATCH 9/9] shmem: enable per-block uptodate
Thread-Topic: [RFC PATCH 9/9] shmem: enable per-block uptodate
Thread-Index: AQHaW2RVXX84xcoe2UmZR8TV2QDYag==
Date: Fri, 9 Feb 2024 14:29:04 +0000
Message-ID: <20240209142901.126894-10-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7djP87pbzI6lGhxoE7SYs34Nm8Xrw58Y
	Lc72/WazOD1hEZPF0099LBazpzczWezZe5LF4vKuOWwW99b8Z7W4MeEpo8X5v8dZLX7/mMPm
	wOOxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSeweJ2b8ZvE4s+AIu8fnTXIem568ZQrgjOKySUnN
	ySxLLdK3S+DKOHP0NUvBRdaK/gs7WBoY77J0MXJySAiYSKycN5+5i5GLQ0hgBaPEhIMvGSGc
	L4wSU54/Z4VwPjNKNE64zQjTcmTrdRaIxHJGiVXf37HDVfU2t7NBOKcZJd7+7mGCm7x580Jm
	kH42AU2JfSc3gbWICDxnlGjd/RHMYRa4zSwxp30W2BZhAUuJkzMusYLYIgJ2Eu1LzzND2HoS
	J/s62UFsFgEViTU7ToDV8wpYS2yf0gJWwwlkz3u0ng3EZhSQlXi08hdYPbOAuMStJ/OZIL4Q
	lFg0ew8zhC0m8W/XQzYIW0fi7PUnUJ8aSGxdug8aUIoSHcduskHM0ZO4MXUKlK0tsWzha2aI
	GwQlTs58Ag4ZCYE2LolnTc+hBrlItPbvh7KFJV4d38IOYctI/N85n2kCo/YsJPfNQrJjFpId
	s5DsWMDIsopRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMw0Z3+d/zTDsa5rz7qHWJk4mA8
	xCjBwawkwhuy5EiqEG9KYmVValF+fFFpTmrxIUZpDhYlcV7VFPlUIYH0xJLU7NTUgtQimCwT
	B6dUA5NAHP9L//2m562fr1/lnaxgUN/819fAhEllxhopozeCmt/33xTmmnpM0a6Zt93/VrCa
	8oLN9nmHpIziVLv0s45nRgRMzJz8cfEENTHXwMKKT1NyNkTsfcgZ/p67rWi225LXavXX9buS
	OlNke6fNNFgYVye3apX3ts5m8y8m6zS5L9nw8K5o+VKpKbKh9LxneNweg6D06MDzxn8uf5hQ
	ep8pzz/4nXiKBWNauHHqgZWL+4V37psqGrdRp2FD9GPJ+8I1x1+3SsUsPHTqTPnlDqc/F+5f
	qrlW3PHf5Fj3PtE7XyfLzbis8POqFUdwcU1qqE3akum5ykc+nJ2wf2qM/lyxTWfC8w/sWphZ
	Ki7hoMRSnJFoqMVcVJwIAOQFgn/jAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsVy+t/xu7qbzY6lGlzrNrGYs34Nm8Xrw58Y
	Lc72/WazOD1hEZPF0099LBazpzczWezZe5LF4vKuOWwW99b8Z7W4MeEpo8X5v8dZLX7/mMPm
	wOOxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSeweJ2b8ZvE4s+AIu8fnTXIem568ZQrgjNKzKcov
	LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOHP0NUvBRdaK
	/gs7WBoY77J0MXJySAiYSBzZeh3I5uIQEljKKLHuwhImiISMxMYvV1khbGGJP9e62CCKPjJK
	/GmcxgrhnGaUOP9jDTOEs4JRYu2qmcwgLWwCmhL7Tm5iB0mICDxllJj++xDYEmaB28wSc9pn
	MYJUCQtYSpyccQlsiYiAnUT70vPMELaexMm+TnYQm0VARWLNjhNg9bwC1hLbp7SA1QgJWElM
	236aDcTmBIrPe7QezGYUkJV4tPIXWC+zgLjErSfzoR4SkFiyB2K+hICoxMvH/6Ce05E4e/0J
	I4RtILF16T5oyChKdBy7yQYxR0/ixtQpULa2xLKFr5kh7hGUODnzCcsERulZSNbNQtIyC0nL
	LCQtCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgSmqm3Hfm7ewTjv1Ue9Q4xMHIyHGCU4
	mJVEeEOWHEkV4k1JrKxKLcqPLyrNSS0+xGgKDKOJzFKiyfnAZJlXEm9oZmBqaGJmaWBqaWas
	JM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cA0N4J99YyKawouF9Xrm7I00zad+Ov9u/C0kpTU
	Rb3mbuWrzvv9XLYaT30uoJZadHyV6qwL5TOPz6zR2CEsP7Xuz638jdZP3R5kb40LeVWxqC1X
	aaLgrSBdk9OvGxosqtcp2RRKL/rbbW3++/qLj5feuJ9JXvyw7bneLod87ksiBn1vr5gXCa+6
	/0D4r7rl1bSrflJ/b+o2yE/4UB1awRXWIR8q9En6pOqFZ4vY1004euK0xw+uqFv3N0X+r5D7
	wJpTd943Y/VvF64Pdz4Hytj/KLzpcbNseTSz+06pfQVTWOTSFb+t9OmO2J+zbbPJaXHDFu3Y
	oHx9D57/Kxd/SZDccOR4tN8a2c23F1rwf41VYinOSDTUYi4qTgQAc+RC9t4DAAA=
X-CMS-MailID: 20240209142907eucas1p12155b2fb002df5e0cd617fa74de757b7
X-Msg-Generator: CA
X-RootMTR: 20240209142907eucas1p12155b2fb002df5e0cd617fa74de757b7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240209142907eucas1p12155b2fb002df5e0cd617fa74de757b7
References: <20240209142901.126894-1-da.gomez@samsung.com>
	<CGME20240209142907eucas1p12155b2fb002df5e0cd617fa74de757b7@eucas1p1.samsung.com>

In the write_end() function, mark only the blocks that are being written
as uptodate.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 2157a87b2e4b..8ff2d190a9e4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2964,7 +2964,7 @@ shmem_write_end(struct file *file, struct address_spa=
ce *mapping,
 	if (pos + copied > inode->i_size)
 		i_size_write(inode, pos + copied);
=20
-	shmem_set_range_uptodate(folio, 0, folio_size(folio));
+	shmem_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
 	folio_mark_dirty(folio);
 	folio_unlock(folio);
 	folio_put(folio);
--=20
2.43.0

