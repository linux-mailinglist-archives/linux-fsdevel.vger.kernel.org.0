Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15974443B01
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 02:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhKCB2h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 2 Nov 2021 21:28:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:30905 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhKCB2g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 21:28:36 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HkTVy11MXzcZyC;
        Wed,  3 Nov 2021 09:21:14 +0800 (CST)
Received: from dggeme751-chm.china.huawei.com (10.3.19.97) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Wed, 3 Nov 2021 09:25:58 +0800
Received: from dggeme751-chm.china.huawei.com ([169.254.210.30]) by
 dggeme751-chm.china.huawei.com ([169.254.210.30]) with mapi id
 15.01.2308.015; Wed, 3 Nov 2021 09:25:58 +0800
From:   "wangjianjian (C)" <wangjianjian3@huawei.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
CC:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: RE: [PATCH 02/21] block: Add bio_add_folio()
Thread-Topic: [PATCH 02/21] block: Add bio_add_folio()
Thread-Index: AQHXz2GCGZfotygsu0GMr7Q1z+eru6vxBCEA
Date:   Wed, 3 Nov 2021 01:25:57 +0000
Message-ID: <d1d037a13796462a968b5de97c459ecc@huawei.com>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-3-willy@infradead.org>
In-Reply-To: <20211101203929.954622-3-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.108.234.122]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

diff --git a/block/bio.c b/block/bio.c
index 15ab0d6d1c06..0e911c4fb9f2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1033,6 +1033,28 @@ int bio_add_page(struct bio *bio, struct page *page,  }  EXPORT_SYMBOL(bio_add_page);
 
+/**
+ * bio_add_folio - Attempt to add part of a folio to a bio.
+ * @bio: BIO to add to.
+ * @folio: Folio to add.
+ * @len: How many bytes from the folio to add.
+ * @off: First byte in this folio to add.
+ *
+ * Filesystems that use folios can call this function instead of 
+calling
+ * bio_add_page() for each page in the folio.  If @off is bigger than
+ * PAGE_SIZE, this function can create a bio_vec that starts in a page
+ * after the bv_page.  BIOs do not support folios that are 4GiB or larger.
+ *
+ * Return: Whether the addition was successful.
+ */
+bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
+		size_t off)
+{
+	if (len > UINT_MAX || off > UINT_MAX)
+		return 0;
+	return bio_add_page(bio, &folio->page, len, off) > 0; }
+


Newline.
