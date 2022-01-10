Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7B8489B28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jan 2022 15:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiAJOUl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 09:20:41 -0500
Received: from pv50p00im-ztdg10021901.me.com ([17.58.6.55]:51318 "EHLO
        pv50p00im-ztdg10021901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235416AbiAJOUl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1641824440; bh=0X2uzKh83j7IEUUxGXCiACxYLjL/D0J7zHLxW88WBV0=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=zM8hrO+u+z4JGP/krkL++EKjgeS9mhVGXLNq78ga29qhu6h/WB8rAUGoZ+nvDUKKh
         U7f3VMt8pjb1Dth5snYO9+YlxFykltMdt+C2j6J7EvNG/7wkEcEQvzck4glySVAhxP
         BPUxnad7vy938eKhcGttFtxfZ+hC9hbkmNQMYaOYscyZBa2ClZ3Qh6nh16c94I5jzC
         3AHXR2F1HsqILYzn6UECwMTRUBERFjgpV0NV3URlX8jzJCAwZR1FaPX5oJ0KYUwh1L
         urVIuaIY0RB9i8LiXVIHTYAubAdQsDd5at/kuNHEyy6hgPxjba9imKmKh1+FhAnW2r
         c7z68im8wn3Fg==
Received: from xiongwei.. (unknown [120.245.2.119])
        by pv50p00im-ztdg10021901.me.com (Postfix) with ESMTPSA id 301EC819A2;
        Mon, 10 Jan 2022 14:20:35 +0000 (UTC)
From:   sxwjean@me.com
To:     akpm@linux-foundation.org, david@redhat.com, mhocko@suse.com,
        dan.j.williams@intel.com, osalvador@suse.de,
        naoya.horiguchi@nec.com, thunder.leizhen@huawei.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v2 1/2] mm/memremap.c: Add pfn_to_devmap_page() to get page in ZONE_DEVICE
Date:   Mon, 10 Jan 2022 22:19:56 +0800
Message-Id: <20220110141957.259022-2-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220110141957.259022-1-sxwjean@me.com>
References: <20220110141957.259022-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2022-01-10_06:2022-01-10,2022-01-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2201100101
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

when requesting page information by /proc/kpage*, the pages in ZONE_DEVICE
are missed. We need a function to help on this.

The pfn_to_devmap_page() function like pfn_to_online_page(), but only
concerns the pages in ZONE_DEVICE.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
v2: Simplify pfn_to_devmap_page().
---
 include/linux/memremap.h |  8 ++++++++
 mm/memremap.c            | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index c0e9d35889e8..621723e9c4a5 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -137,6 +137,8 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
 void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
 struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 		struct dev_pagemap *pgmap);
+struct page *pfn_to_devmap_page(unsigned long pfn,
+		struct dev_pagemap **pgmap);
 bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
 
 unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
@@ -166,6 +168,12 @@ static inline struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 	return NULL;
 }
 
+static inline struct page *pfn_to_devmap_page(unsigned long pfn,
+		struct dev_pagemap **pgmap)
+{
+	return NULL;
+}
+
 static inline bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn)
 {
 	return false;
diff --git a/mm/memremap.c b/mm/memremap.c
index 5a66a71ab591..f59994fe01a9 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -494,6 +494,24 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 }
 EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
+/**
+ * pfn_to_devmap_page - get page pointer which belongs to dev_pagemap by @pfn
+ * @pfn: page frame number to lookup page_map
+ * @pgmap: to save pgmap address which is for putting reference
+ *
+ * If @pgmap is non-NULL, then pfn is on ZONE_DEVICE and return page pointer.
+ */
+struct page *pfn_to_devmap_page(unsigned long pfn, struct dev_pagemap **pgmap)
+{
+	if (pfn_valid(pfn)) {
+		*pgmap = get_dev_pagemap(pfn, NULL);
+		if (*pgmap)
+			return pfn_to_page(pfn);
+	}
+
+	return NULL;
+}
+
 #ifdef CONFIG_DEV_PAGEMAP_OPS
 void free_devmap_managed_page(struct page *page)
 {
-- 
2.30.2

