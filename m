Return-Path: <linux-fsdevel+bounces-1380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5B17D9D2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 17:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62DF2824BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 15:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD5BC2FE;
	Fri, 27 Oct 2023 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NleKykxS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6257CD530
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 15:41:19 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D0118F
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 08:41:16 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231027154115euoutp020db2fd9818816d9be27c0444df401a52~SASa6hWvz0284602846euoutp02B
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 15:41:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231027154115euoutp020db2fd9818816d9be27c0444df401a52~SASa6hWvz0284602846euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698421275;
	bh=duCLnfNr42oeVPpKAU731beQ+ZxjGP/ivVYrPM0iY6U=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=NleKykxSD4iZt3R8mAVygmsChVpoSHN4rvRxrT+phM/w8gZ+PRTd3uHooyZ6WVpiC
	 ts1xz7Xqgy2lGvYtBaFSYM+Z7N5q/+d5HAQHgxk4YVxUxGtodFmUykIm6SlnBVES0c
	 PN+STW+z3ko0B4eOgBhOUr+z9vDKjCxyfMy3rC/A=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231027154115eucas1p1aab8b2eeb91c50c8f3583cf60355c8d2~SASardpxl2982129821eucas1p15;
	Fri, 27 Oct 2023 15:41:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 54.B4.11320.A1ADB356; Fri, 27
	Oct 2023 16:41:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231027154114eucas1p1900577736cc1f28699e16ac5df6dd5ca~SASaRPnF_2982129821eucas1p12;
	Fri, 27 Oct 2023 15:41:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231027154114eusmtrp1a73ff046a912413db646b6a6bb96cb87~SASaQmgXk1229612296eusmtrp1w;
	Fri, 27 Oct 2023 15:41:14 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-01-653bda1af9e6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id F4.77.10549.A1ADB356; Fri, 27
	Oct 2023 16:41:14 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231027154114eusmtip23b4d590e1938ac6a6ca1a432384a101f~SASaB_kbr2532925329eusmtip2G;
	Fri, 27 Oct 2023 15:41:14 +0000 (GMT)
Received: from [10.10.2.119] (106.210.248.118) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 27 Oct 2023 16:41:12 +0100
Message-ID: <3d65652f-04c7-4240-9969-ba2d3869dbbf@samsung.com>
Date: Fri, 27 Oct 2023 17:41:10 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: fix iomap_dio_zero() for fs bs > system page
 size
To: Matthew Wilcox <willy@infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <kernel@pankajraghav.com>,
	<linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<djwong@kernel.org>, <mcgrof@kernel.org>, <da.gomez@samsung.com>,
	<gost.dev@samsung.com>, <david@fromorbit.com>
Content-Language: en-US
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <ZTuVVSD1FnQ7qPG5@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.118]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djP87pSt6xTDVZ/t7bYcuweo8XlJ3wW
	K1cfZbI48/Izi8WevSdZLHb92cFucWPCU0aL3z/msDlweJxaJOGxeYWWx6ZVnWweu282sHmc
	Xeno8XmTXABbFJdNSmpOZllqkb5dAlfG22sT2Qvui1Ts3LOBsYFxPl8XIweHhICJxK0tyl2M
	XBxCAisYJa5efcDaxcgJ5HxhlJjwIgci8ZlRYs7G1WAJkIaVE3oZIRLLGSVONdxjhqu69Pwk
	O0T7TkaJzcv0QWxeATuJj0e3MILYLAKqEhv/nGKBiAtKnJz5BMwWFZCXuH9rBlivsIC/xJG5
	J5hAzhMR0JB4s8UIZD6zQAOTxMOOW8wgNcwC4hK3nswHq2ET0JJo7ARr5QQ6ruX1ayaIEk2J
	1u2/2SFseYntb+cwQzygLHHqyQOoZ2olTm25xQRhd3NKfL2nC2G7SDTMWcQGYQtLvDq+hR3C
	lpE4PbmHBcKulnh64zfY7xICLYwS/TvXs0GC1Fqi70wORI2jRFv/ShaIMJ/EjbeCEOfwSUza
	Np15AqPqLKSAmIXksVlIPpiF5IMFjCyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxApPR
	6X/Hv+xgXP7qo94hRiYOxkOMEhzMSiK8kT4WqUK8KYmVValF+fFFpTmpxYcYpTlYlMR5VVPk
	U4UE0hNLUrNTUwtSi2CyTBycUg1MW/NP29qHd+c1VoSn5cWKsXCGyqzP9XcQb3ZzkOVcuFl6
	n0T4olL905y3FKSkrrz2djzZmfRo+xbHJFX1eM3M9pPHKpheLd95wX7tofXZE/eVMa5m/nre
	X7ygciq3x8WVxdZPOSL5+XK9/67V290YdqztS9LSGdpZC/ZdOqJ0qSnJZI91N+OZFW7yohnO
	pzJ4D1keO5IgfCjiUdID546wZfVJHc/ZNpWf/Mz17M2R9UuOiqdxzpI7KbTUy9vCN87mV398
	0JtAdv6/SXU8apM/63pI6jMvLWVuzDIIf7wjnUer7eXx9Qd2fee6J3AkqXPCUrPaydrR57aF
	6Uj7fZp50XKa4o6PqV8kLm5iUFRiKc5INNRiLipOBACRJTMFtQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xe7pSt6xTDQ52ylpsOXaP0eLyEz6L
	lauPMlmcefmZxWLP3pMsFrv+7GC3uDHhKaPF7x9z2Bw4PE4tkvDYvELLY9OqTjaP3Tcb2DzO
	rnT0+LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1
	SN8uQS/j7bWJ7AX3RSp27tnA2MA4n6+LkZNDQsBEYuWEXsYuRi4OIYGljBI9F6+yQSRkJDZ+
	ucoKYQtL/LnWxQZR9JFRonfCArAiIYGdjBLvl4mC2LwCdhIfj25hBLFZBFQlNv45xQIRF5Q4
	OfMJmC0qIC9x/9YMdhBbWMBXYs/EO0A2B4eIgIbEmy1GIPOZBRqYJB523GKGWDYJyLm3GayZ
	WUBc4taT+UwgDWwCWhKNnWBzOIE+aHn9mgmiRFOidftvdghbXmL72znMEA8oS5x68gDqmVqJ
	z3+fMU5gFJ2F5LxZSDbMQjJqFpJRCxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG8rZj
	PzfvYJz36qPeIUYmDsZDjBIczEoivJE+FqlCvCmJlVWpRfnxRaU5qcWHGE2BYTSRWUo0OR+Y
	SvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpiqWvZvFzdNP7fN
	vOh/5/zJphv+nTh96tO3V3Umav+W7brP1ii5NWS7lJ3aic0ap5eFH3fRaX/nZJTvuX2K5+YL
	mW8mCaz+xbP9Uu/+GRXm7VpJ/CUPVzFqe+dv/KT1743Uya360+dEJHHtKrwzJ2X2PZ307PWf
	mPbyfC5WFJj/yHDv8R9/Y+r03DbKeB/tWjZj3Zydlj5zrhvdagxSVZ2l/vj/uqnC1XtX/7a9
	+rmbyfTT7/sLUkVuMBu16Rc4fFt8fBFPa+adR1YT+OU4sje9mHbus7vaJL9nDveYMoN74vuy
	mcTinndpz9JXDs/7V71NbJto2P5fwSZCRyNmpPl97pTQs7zprJFxNdtq/5NVSizFGYmGWsxF
	xYkAiENqsG0DAAA=
X-CMS-MailID: 20231027154114eucas1p1900577736cc1f28699e16ac5df6dd5ca
X-Msg-Generator: CA
X-RootMTR: 20231027051855eucas1p2e465ca6afc8d45dc0529f0798b8dd669
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231027051855eucas1p2e465ca6afc8d45dc0529f0798b8dd669
References: <20231026140832.1089824-1-kernel@pankajraghav.com>
	<CGME20231027051855eucas1p2e465ca6afc8d45dc0529f0798b8dd669@eucas1p2.samsung.com>
	<20231027051847.GA7885@lst.de>
	<1e7e9810-9b06-48c4-aec8-d4817cca9d17@samsung.com>
	<ZTuVVSD1FnQ7qPG5@casper.infradead.org>

On 27/10/2023 12:47, Matthew Wilcox wrote:
> On Fri, Oct 27, 2023 at 10:03:15AM +0200, Pankaj Raghav wrote:
>> I also noticed this pattern in fscrypt_zeroout_range_inline_crypt().
>> Probably there are more places which could use a ZERO_FOLIO directly
>> instead of iterating with ZERO_PAGE.
>>
>> Chinner also had a similar comment. It would be nice if we can reserve
>> a zero huge page that is the size of MAX_PAGECACHE_ORDER and add it as
>> one folio to the bio.
> 
> i'm on holiday atm.  start looking at mm_get_huge_zero_page()

Thanks for the pointer. I made a rough version of how it might
look like if I use that API:

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bcd3f8cf5ea4..6ae21bd16dbe 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -236,17 +236,43 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
                loff_t pos, unsigned len)
 {
        struct inode *inode = file_inode(dio->iocb->ki_filp);
-       struct page *page = ZERO_PAGE(0);
+       struct page *page = NULL;
+       bool huge_page = false;
+       bool fallback = false;
        struct bio *bio;

-       bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
+       if (len > PAGE_SIZE) {
+               page = mm_get_huge_zero_page(current->mm);
+               if (likely(page))
+                       huge_page = true;
+       }
+
+       if (!huge_page)
+               page = ZERO_PAGE(0);
+
+       fallback = ((len > PAGE_SIZE) && !huge_page);
+
+       bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
+                                 REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
        fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
                                  GFP_KERNEL);
+
        bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
        bio->bi_private = dio;
        bio->bi_end_io = iomap_dio_bio_end_io;

-       __bio_add_page(bio, page, len, 0);
+       if (!fallback) {
+               bio_add_folio_nofail(bio, page_folio(page), len, 0);
+       } else {
+               while (len) {
+                       unsigned int io_len =
+                               min_t(unsigned int, len, PAGE_SIZE);
+
+                       __bio_add_page(bio, page, io_len, 0);
+                       len -= io_len;
+               }
+       }
+
        iomap_dio_submit_bio(iter, dio, bio, pos);
 }

The only issue with mm_get_huge_zero_page() is that it can fail, and we need
to fallback to iteration if it cannot allocate a huge folio.

PS: Enjoy your holidays :)

