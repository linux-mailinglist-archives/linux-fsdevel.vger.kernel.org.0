Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1EB737DA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 10:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjFUIig (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 04:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFUIib (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:38:31 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C351710E6
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 01:38:28 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230621083827euoutp02879bb0ed861808457e1b540386e969f1~qn8ugi5uS0616906169euoutp02D
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 08:38:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230621083827euoutp02879bb0ed861808457e1b540386e969f1~qn8ugi5uS0616906169euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687336707;
        bh=p+ceLN5ku7io/26SFBn3OjERPGRRlK1fZyar/4zm1hE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Pbg9tlpu43bSlPstWN1z2aHRMRhP9yYMjrT+938dBQS2kg+pCATCsv3EssKYLsNwR
         0zrQlqCEa/36bbVctj8ZPghsV+jBGds3qGACru66FQPhTXg1j+tbruTzQxgvOgBzVM
         3gkqs7EiMZ1n/sn3pcg1uq5n4lT55wVo4xKKCLkw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621083826eucas1p10a3c96207c0a16f84fd975a996fe662a~qn8uHF7p82121821218eucas1p1X;
        Wed, 21 Jun 2023 08:38:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6A.7C.37758.207B2946; Wed, 21
        Jun 2023 09:38:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230621083826eucas1p11fc8d3e023caafa8b30fd04c66c9c7d0~qn8tyilf71725417254eucas1p1_;
        Wed, 21 Jun 2023 08:38:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230621083826eusmtrp1ebc64a4952224c75cae2a6bbd5708f81~qn8twaleB0064800648eusmtrp1C;
        Wed, 21 Jun 2023 08:38:26 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-be-6492b702d655
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9A.D8.10549.207B2946; Wed, 21
        Jun 2023 09:38:26 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230621083826eusmtip2c5a952dde2b7c93e4a70881e76d21c04~qn8tjM7TM0773907739eusmtip20;
        Wed, 21 Jun 2023 08:38:26 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 09:38:25 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     <hare@suse.de>, <willy@infradead.org>, <david@fromorbit.com>
CC:     <gost.dev@samsung.com>, <mcgrof@kernel.org>, <hch@lst.de>,
        <jwong@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 1/4] fs: Allow fine-grained control of folio sizes
Date:   Wed, 21 Jun 2023 10:38:20 +0200
Message-ID: <20230621083823.1724337-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621083823.1724337-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xScRTe7168XWjU9VrjpGWLVX/Qoqy27grL1mP0Mre27LWK4KYkkuNq
        L7NhmqU9Jcsg2ir/0HRlApYkpZEJiGmPaVjr/ZjLXCt1SbWWeK3533e+851zvm87JE6bwyJJ
        rT6dNehVOikhEtxsDLZOx26ZNDO7mmYwjsZXiHFdMWHM1YoHGNPefBxjXHd8AubpbSvBBE5/
        RMyvfisRRyqbroDSXiZT2srzCWVth5FQ2v2Zyh5bdAKxUaTQsDrtbtYwY8E2UXKtvyEs7cz4
        vdYqK2FENkkBEpJAzQHj8ypBARKRNFWGoL7wRhhf9CIo6csfwRc9CJznHejfyBtb/9BIKYJ+
        zy38vyrb4h1U0ZQDgSeYWIBIkqBkkB3aJCTHUHFgr7IOnsAp18C97O9YqBEx0HBVBwZFAmoK
        5FzLJ0JYTM0H78snYaE9QE2EkjcQooWUAqqu3kO8JBx85g+CEMYHJDnVF3AeA9zr7MR501Iw
        2psFPM6CJsdzLOQBqH4S3IcfDyVbAqXXnUOiCPjscYzg8Xjwnzk+xGfCx8AvnB/ORXDKWUnw
        5ubDyWYdr1kEroJWxNOjINAdzvsZBaabxThPi+FoHn0aTbYMS2AZlsAyLMElhJcjCZvBpSax
        3Gw9u0fOqVK5DH2SXL0r1YYGvsf/x9NXg8o+f5O7EUYiNwISl44RT7CZNLRYo9q3nzXs2mrI
        0LGcG0WRAqlEPC3Wp6apJFU6m8KyaazhXxcjhZFGzBnTnfDzmIYeKYuv7u2snNXIBKPfT+Z8
        Dxaqn0bNnXfw8pOinS2KonrtiQ5t3tfEF1GLDitSltEHNFrm7pqy2+90dtm+lottX7d8iZzo
        bl+qW1+4QhEZ5Iql6XXfW+RdyKNP7zD92etc0m1+Kd9xdtIGqW/CdvHUSTW9yfSmdcvp7sKx
        Xc9E0HNupjfKnLbincQo8caerH29OcLHHMkxVzelBjMbcqM73Vlo7KfR8XNjFbMLT7wV3njf
        9rYid9XqT4/67D/aHnt3bj6VF5e2EI8ZV1Lxe39dTUDdfmhtVlJ+YP0le9H9+AZ1a31J8e+G
        hz3+NUd7Awrj4hSTJXpl3bJjUgGXrIqR4QZO9RdSoL9orAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xe7pM2yelGCxeLGGx5dg9Ros9iyYx
        WaxcfZTJ4tqZHiaLPXtPslhc3jWHzeLGhKeMFr9/zGFz4PA4tUjCY/MKLY9NqzrZPHbfbGDz
        2Hy62uPzJrkAtig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jN2nj7AWTJapmLNxDlsD4ybxLkZODgkBE4kHm36wdDFycQgJLGWUmDmhlx0iISOx
        8ctVVghbWOLPtS42iKKPjBLXpj9lAkkICWxhlFh/s7yLkYODTUBLorETrFdEwEFi88Y5rCD1
        zAJ7GCUONH4CqxcGSuzZegOsiEVAVaJ5bScbiM0rYC1x4u4lVpA5EgLyEosfSICEOQVsJDau
        PMgIscpaov34VHaIckGJkzOfsIDYzEDlzVtnM0PYEhIHX7xghrhZSaJh8xkWCLtW4vPfZ4wT
        GEVmIWmfhaR9FpL2BYzMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQIjc9uxn5t3MM579VHv
        ECMTB+MhRgkOZiURXtlNk1KEeFMSK6tSi/Lji0pzUosPMZoCvTmRWUo0OR+YGvJK4g3NDEwN
        TcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpj2PCussruv7/q9iPm1RFbCFvHX
        oYbmGaabuN+fCzmz9JVjqfw0//UWV1KfGH9POCs65+GVWTs2cmUe39EaV6x/gWlbA2uLx/re
        t1/3bAqM5S76eW2xXZy7yoazcVk2Pa3fvidILb3nu7aKd0FO3TZW78aYBKYmHyeGTc8kszgE
        VsXvCo8y1s6e1PPu8BQlPeE5HczbNEN9dxrHhJVcfGHWbqKpKVs88c1SoeVnv3lZfI4Q333v
        nYhy8aHCQ15NmeU2FzdWTcw5sLtuM8fZo/euJpS+WCQrwNw6KZyrYPPVvemMH6w85U3PhE6S
        3r15XWPCs+duz9+43/jSvkPNM6Nlm7KUi1JEt7/11ZmT65RYijMSDbWYi4oTAStx/jBVAwAA
X-CMS-MailID: 20230621083826eucas1p11fc8d3e023caafa8b30fd04c66c9c7d0
X-Msg-Generator: CA
X-RootMTR: 20230621083826eucas1p11fc8d3e023caafa8b30fd04c66c9c7d0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621083826eucas1p11fc8d3e023caafa8b30fd04c66c9c7d0
References: <20230621083823.1724337-1-p.raghav@samsung.com>
        <CGME20230621083826eucas1p11fc8d3e023caafa8b30fd04c66c9c7d0@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Some filesystems want to be able to limit the maximum size of folios,
and some want to be able to ensure that folios are at least a certain
size.  Add mapping_set_folio_orders() to allow this level of control
(although it is not yet honoured).

[Pankaj]: added mapping_min_folio_order()

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 46 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 716953ee1ebd..462c36c9dd88 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -202,9 +202,15 @@ enum mapping_flags {
 	AS_EXITING	= 4, 	/* final truncate in progress */
 	/* writeback related tags are not used */
 	AS_NO_WRITEBACK_TAGS = 5,
-	AS_LARGE_FOLIO_SUPPORT = 6,
+	AS_FOLIO_ORDER_MIN = 8,
+	AS_FOLIO_ORDER_MAX = 13,
+	/* 8-17 are used for FOLIO_ORDER */
 };
 
+#define AS_FOLIO_ORDER_MIN_MASK	0x00001f00
+#define AS_FOLIO_ORDER_MAX_MASK 0x0002e000
+#define AS_FOLIO_ORDER_MASK (AS_FOLIO_ORDER_MIN_MASK | AS_FOLIO_ORDER_MAX_MASK)
+
 /**
  * mapping_set_error - record a writeback error in the address_space
  * @mapping: the mapping in which an error should be set
@@ -294,6 +300,29 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 	m->gfp_mask = mask;
 }
 
+/**
+ * mapping_set_folio_orders() - Set the range of folio sizes supported.
+ * @mapping: The file.
+ * @min: Minimum folio order (between 0-31 inclusive).
+ * @max: Maximum folio order (between 0-31 inclusive).
+ *
+ * The filesystem should call this function in its inode constructor to
+ * indicate which sizes of folio the VFS can use to cache the contents
+ * of the file.  This should only be used if the filesystem needs special
+ * handling of folio sizes (ie there is something the core cannot know).
+ * Do not tune it based on, eg, i_size.
+ *
+ * Context: This should not be called while the inode is active as it
+ * is non-atomic.
+ */
+static inline void mapping_set_folio_orders(struct address_space *mapping,
+		unsigned int min, unsigned int max)
+{
+	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
+			(min << AS_FOLIO_ORDER_MIN) |
+			(max << AS_FOLIO_ORDER_MAX);
+}
+
 /**
  * mapping_set_large_folios() - Indicate the file supports large folios.
  * @mapping: The file.
@@ -307,7 +336,17 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  */
 static inline void mapping_set_large_folios(struct address_space *mapping)
 {
-	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+	mapping_set_folio_orders(mapping, 0, 31);
+}
+
+static inline unsigned mapping_max_folio_order(struct address_space *mapping)
+{
+	return (mapping->flags & AS_FOLIO_ORDER_MAX_MASK) >> AS_FOLIO_ORDER_MAX;
+}
+
+static inline unsigned mapping_min_folio_order(struct address_space *mapping)
+{
+	return (mapping->flags & AS_FOLIO_ORDER_MIN_MASK) >> AS_FOLIO_ORDER_MIN;
 }
 
 /*
@@ -316,8 +355,7 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
  */
 static inline bool mapping_large_folio_support(struct address_space *mapping)
 {
-	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+	return mapping_max_folio_order(mapping) > 0;
 }
 
 static inline int filemap_nr_thps(struct address_space *mapping)
-- 
2.39.2

