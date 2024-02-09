Return-Path: <linux-fsdevel+bounces-10969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CDE84F751
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 15:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2411C232A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBCD6D1BA;
	Fri,  9 Feb 2024 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h1JyNx4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7160769D31
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488953; cv=none; b=fgAGXlNylTvNsr3WNr/8a0aoPFBHKHbHLK6f6pk7z/etC5IqqqIZovtIsCZQwPKZDZ9pqDFAZpM0mA04Ef+vhc7EHPqV7/wx5B0szxt1fz/1e1+CVtbrKV9MibzU07zF5kdr18JHO/5RewbUCdDAX+iBLyoGnYPYdbevNyvPN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488953; c=relaxed/simple;
	bh=CPKJ6tUdoDF6Ha2IQ+4O/WOu+/5VM901pX9Tu0quqfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=IVnfLYI2s+fzs2nDRguigkePqbnt2BIIH3sNg29ZVW8eC5LyoWQERhV8SYlcIBvHY3vDZ4YHDXJJpfHqD49mzxUmo79W49yUgkwVYxq3E63E/jTNw9o94mi+D59ZXZESs9QTB9I4vgLJvRC3ceZWKkosV0v12ncQw4KB9DHiC8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=h1JyNx4K; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240209142906euoutp02c903bac6c9424256747b6d949e2eafa8~yOCZ_5i5N2377523775euoutp02d
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:29:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240209142906euoutp02c903bac6c9424256747b6d949e2eafa8~yOCZ_5i5N2377523775euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707488946;
	bh=FCbzId5tUUljaKo+tPW5dyPNAxWuqwZJmK4aFsnXX4M=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=h1JyNx4KMrteOAQd2xuXTYL0v8bGy8abrDejKZj6MfmF7XkTeUYjJO/0mlcML6jxY
	 LVoThPtZVowwXE1i4ym/GrWCFWwXiJyUXv4z+NRkk11J5mp12q17wL1A1sDkfrNlA3
	 SQ5JHpmxkcLYKefpwei3RORrbhDJGjstMZeYyjgw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240209142906eucas1p2e47a246a10373a76799a079725583da1~yOCZtNsY_2329623296eucas1p2e;
	Fri,  9 Feb 2024 14:29:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id FC.F5.09814.2B636C56; Fri,  9
	Feb 2024 14:29:06 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240209142905eucas1p14498619591475e416a8163dbc96c90e4~yOCZTs0l-0937309373eucas1p16;
	Fri,  9 Feb 2024 14:29:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240209142905eusmtrp2a5418fa28a2ffb3a4fc54948ca8a399d~yOCZTFUmN2110121101eusmtrp2b;
	Fri,  9 Feb 2024 14:29:05 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-40-65c636b2e6b8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 59.6F.09146.1B636C56; Fri,  9
	Feb 2024 14:29:05 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240209142905eusmtip2236828047c1df8be3fea7df7e76daca2~yOCZK_AE42332823328eusmtip2R;
	Fri,  9 Feb 2024 14:29:05 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
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
	"Daniel Gomez" <da.gomez@samsung.com>
Subject: [RFC PATCH 5/9] shmem: clear_highpage() if block is not uptodate
Thread-Topic: [RFC PATCH 5/9] shmem: clear_highpage() if block is not
	uptodate
Thread-Index: AQHaW2RUm+AjPQwetUKmMMbff0NR9g==
Date: Fri, 9 Feb 2024 14:29:03 +0000
Message-ID: <20240209142901.126894-6-da.gomez@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djP87qbzI6lGnz7JWYxZ/0aNovXhz8x
	Wpzt+81mcXrCIiaLp5/6WCxmT29mstiz9ySLxeVdc9gs7q35z2pxY8JTRovzf4+zWvz+MYfN
	gcdj56y77B4LNpV6bF6h5bFpVSebx6ZPk9g9Tsz4zeJxZsERdo/Pm+Q8Nj15yxTAGcVlk5Ka
	k1mWWqRvl8CVsfnoYcaCrWwVn2evZ2tgXMDaxcjJISFgInGt5S9TFyMXh5DACkaJH59XM0M4
	XxglXnyZwwLhfGaUuL1yLTNMy7fPr6FaljNKXPr8iQ0kAVY14TovROI0o8TNg9dZ4QafW9fI
	CFLFJqApse/kJnaQhIjAc0aJ1t0fwRxmgdvMEnPaZ4FVCQt4SizqegN2o4hAgMTTM3uYIWw9
	iR3L/oHVsAioSMybspIFxOYVsJJY9fI3E4jNKWAtMe/RerCbGAVkJR6t/MUOYjMLiEvcejKf
	CeIJQYlFs/dAPSQm8W/XQzYIW0fi7PUnjBC2gcTWpftYIGxFiY5jN9kg5uhJ3Jg6BcrWlli2
	8DUzxA2CEidnPgGHmIRAG5fEm2nboRa4SHw7vARqsbDEq+Nb2CFsGYn/O+czTWDUnoXkvllI
	dsxCsmMWkh0LGFlWMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBKa50/+Of9nBuPzVR71D
	jEwcjIcYJTiYlUR4Q5YcSRXiTUmsrEotyo8vKs1JLT7EKM3BoiTOq5oinyokkJ5YkpqdmlqQ
	WgSTZeLglGpg2t5TWf4iSZh9092XzwPKirbc858nMGv3Bq84hrhUHXueczUiH/8KhifxflTZ
	8XHP1qz//Oa50Te7BHP+XqjWkXt0tc/yr5aV2fJgf88dhcp7PgWktv/Jf3p/2/Mmya8ti7O8
	L34zDvtSpN/A4vTqcalFA8vCnA87Wpn7uKdl3JozKYO5zCXh95tLCyU5Hi9cyqAbUXx+y+Na
	zZXLpYMmBy46UvFOfOIeldmfHormvO4LFa6a/ECjvIIlfq//Yec5G29eV5hhmMI3tXIr8/PP
	asrXGrdtDnDzsLCdx3rP9N/JmVdtgl4uOiqrkLNYauPqub3bN4T9k3l99ei07mUOp+qXTjgZ
	bHKW5bbC9kTmCUosxRmJhlrMRcWJALwbYEziAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsVy+t/xe7obzY6lGqx6bGExZ/0aNovXhz8x
	Wpzt+81mcXrCIiaLp5/6WCxmT29mstiz9ySLxeVdc9gs7q35z2pxY8JTRovzf4+zWvz+MYfN
	gcdj56y77B4LNpV6bF6h5bFpVSebx6ZPk9g9Tsz4zeJxZsERdo/Pm+Q8Nj15yxTAGaVnU5Rf
	WpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXsfnoYcaCrWwV
	n2evZ2tgXMDaxcjJISFgIvHt82umLkYuDiGBpYwSP67sYYFIyEhs/HIVqkhY4s+1LjaIoo+M
	Ej3z10I5pxklnjy+zw7hrGCUOPP+N1gLm4CmxL6Tm8ASIgJPGSWm/z7EAuIwC9xmlpjTPosR
	pEpYwFNiUdcbsA4RAT+J/3u3s0DYehI7lv0Dq2ERUJGYN2UlWJxXwEpi1cvfTCC2EJA9bftp
	NhCbU8BaYt6j9WA2o4CsxKOVv9hBbGYBcYlbT+YzQTwhILFkz3lmCFtU4uXjf1DP6Uicvf6E
	EcI2kNi6dB80ABQlOo7dZIOYoydxY+oUKFtbYtnC18wQ9whKnJz5hGUCo/QsJOtmIWmZhaRl
	FpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQJT1bZjPzfvYJz36qPeIUYmDsZDjBIc
	zEoivCFLjqQK8aYkVlalFuXHF5XmpBYfYjQFhtFEZinR5HxgsswriTc0MzA1NDGzNDC1NDNW
	Euf1LOhIFBJITyxJzU5NLUgtgulj4uCUamDqlV++q2Ov5rY+4XmZ6z8EnFx4pn3Gs+PLT91Z
	wZ7cMFFqgQ63sErWhyMsi/bPWiHE5su7aZ93p6fto1IbgaoPh6rOSC4TuT7Bjr3v7hKToyqv
	fvzmnXvU5oZg9/alcesN96txxYeEq+//4W8X81v15vdLX39EdQoXXjZavcs64DGTYa7njvI/
	frq9vB8OR98yWiBWKpc5m/froW83QzusZu3/JDUreqv51QSF7+Xi84Pljm2493lqyJKbbPPa
	lhf66uzaySRnd1Rrl8SFnRofzpZ/qHAJrYroF3igEDzJpNvzQJvnRPcJroVOj9b2cFf8320z
	J2ORsxp/mdMZbg8LP76fGUKJnwPLH11v+SWrxFKckWioxVxUnAgAorJ4Z94DAAA=
X-CMS-MailID: 20240209142905eucas1p14498619591475e416a8163dbc96c90e4
X-Msg-Generator: CA
X-RootMTR: 20240209142905eucas1p14498619591475e416a8163dbc96c90e4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240209142905eucas1p14498619591475e416a8163dbc96c90e4
References: <20240209142901.126894-1-da.gomez@samsung.com>
	<CGME20240209142905eucas1p14498619591475e416a8163dbc96c90e4@eucas1p1.samsung.com>

clear_highpage() is called for all the subpages (blocks) in a large
folio when the folio is not uptodate. Do clear the subpages only when
they are not uptodate.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 mm/shmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 614cda767298..b6f9a60b179b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2253,7 +2253,8 @@ static int shmem_get_folio_gfp(struct inode *inode, p=
goff_t index,
 		long i, n =3D folio_nr_pages(folio);
=20
 		for (i =3D 0; i < n; i++)
-			clear_highpage(folio_page(folio, i));
+			if (!shmem_is_block_uptodate(folio, i))
+				clear_highpage(folio_page(folio, i));
 		flush_dcache_folio(folio);
 		shmem_set_range_uptodate(folio, 0, folio_size(folio));
 	}
--=20
2.43.0

