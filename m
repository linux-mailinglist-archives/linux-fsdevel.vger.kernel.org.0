Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523A8488984
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jan 2022 14:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiAINPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jan 2022 08:15:18 -0500
Received: from pv50p00im-hyfv10011601.me.com ([17.58.6.43]:53242 "EHLO
        pv50p00im-hyfv10011601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230512AbiAINPR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jan 2022 08:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1641733546; bh=g6L+kqSc5f6G0SvO3Njd2vpwSi2vmrKCjGly4UmhZ9c=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=RMyeKdCSTClAxoIfpApVBBCKB9wmAQbdhhR0xOTC5ADL/bXfYg4JWD5U8l9f0k0Z4
         gBSzZUgxRr0RIfL/QOQHWG9wrA8sD5As9lbzONjP/gDwjM7CmHkV5IXYFyb1Tjjxj3
         hFvg1hNQ8U+3MwUk1i6HxZF1grjzFCWkGDmuM8h7wC2Xtz/Zb6AecWSojTBwD3ph3h
         OuFBRlPm4H5WYQdX6HgFgm+brakks0vby/hS3EtwuFxN2rqRrWjWB3Q0m0MbrS3jQI
         gzOxg0eodmL5rl+gZ9PEvagHab4LlWkQudY3bh0cbi5LodwcwMQA2QcmEM8S4obwB3
         WYBH4fznkhbeg==
Received: from xiongwei.. (unknown [120.245.2.119])
        by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id B282896022F;
        Sun,  9 Jan 2022 13:05:41 +0000 (UTC)
From:   sxwjean@me.com
To:     akpm@linux-foundation.org, david@redhat.com, mhocko@suse.com,
        dan.j.williams@intel.com, osalvador@suse.de,
        naoya.horiguchi@nec.com, thunder.leizhen@huawei.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH 1/2] mm/memremap.c: Add pfn_to_devmap_page() to get page in ZONE_DEVICE
Date:   Sun,  9 Jan 2022 21:05:14 +0800
Message-Id: <20220109130515.140092-2-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220109130515.140092-1-sxwjean@me.com>
References: <20220109130515.140092-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2022-01-09_04:2022-01-06,2022-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=785 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2201090096
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

when requesting page information by /proc/kpage*, the pages in ZONE_DEVICE
were missed. We need a function to help on this.

The pfn_to_devmap_page() function like pfn_to_online_page(), but only
concerns the pages in ZONE_DEVICE.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 include/linux/memremap.h |  8 ++++++++
 mm/memremap.c            | 42 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

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
index 5a66a71ab591..072dbe6ab81c 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -494,6 +494,48 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
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
+	unsigned long nr = pfn_to_section_nr(pfn);
+	struct mem_section *ms;
+	struct page *page = NULL;
+
+	if (nr >= NR_MEM_SECTIONS)
+		return NULL;
+
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID) && !pfn_valid(pfn))
+		return NULL;
+
+	ms = __nr_to_section(nr);
+	if (!valid_section(ms))
+		return NULL;
+	if (!pfn_section_valid(ms, pfn))
+		return NULL;
+
+	/*
+	 * Two types of sections may include valid pfns:
+	 * - The pfns of section belong to ZONE_DEVICE and ZONE_{NORMAL,MOVABLE}
+	 *   at the same time.
+	 * - All pfns in one section are offline but valid.
+	 */
+	if (!online_device_section(ms) && online_section(ms))
+		return NULL;
+
+	*pgmap = get_dev_pagemap(pfn, NULL);
+	if (*pgmap)
+		page = pfn_to_page(pfn);
+
+	return page;
+}
+EXPORT_SYMBOL_GPL(pfn_to_devmap_page);
+
 #ifdef CONFIG_DEV_PAGEMAP_OPS
 void free_devmap_managed_page(struct page *page)
 {
-- 
2.30.2

