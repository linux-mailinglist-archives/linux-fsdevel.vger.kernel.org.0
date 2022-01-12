Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49C348C663
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 15:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354255AbiALOqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 09:46:34 -0500
Received: from mr85p00im-zteg06011501.me.com ([17.58.23.182]:47736 "EHLO
        mr85p00im-zteg06011501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354253AbiALOqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1641998199; bh=J8I1NMVpmtmxYOzkUXhKs7c0idUTGDpRCI8xL5DNgZY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=GafK0KHp7PLgmiiaPBS4vqdd+jk1oZhYM1EyhZqEZ8urPXuTY/hxrt0t2b9cYfrsI
         6k73Jn7DXYfOx5w2TO+M1664IDA3yNJF6AkV2Z+4hygO6LowndI1vo9wMaq0Baxfa1
         hMB8Yxz+z56ut7ipUxrg6LdicrUJw9ogBM7poeyjWqeEs9BX53ONfGWRAUWAY05Uoj
         obAZ3mgOsRD2epz67cIjVlvg/+qkiz1VT8Tbg8IQNuJZMeiZbBXNtN7G/5pW6lnvsJ
         WXM6Z427Lq9qjZGc8BGVPreQHjouLAqvRBu6q9KiyaA1eJ7EZ074CljQrQHDUPp+oq
         y+wnLInHtuysA==
Received: from xiongwei.. (unknown [120.245.2.88])
        by mr85p00im-zteg06011501.me.com (Postfix) with ESMTPSA id 680ED480EE0;
        Wed, 12 Jan 2022 14:36:13 +0000 (UTC)
From:   sxwjean@me.com
To:     akpm@linux-foundation.org, david@redhat.com, mhocko@suse.com,
        dan.j.williams@intel.com, osalvador@suse.de,
        naoya.horiguchi@nec.com, thunder.leizhen@huawei.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v3 1/2] mm/memremap.c: Add pfn_to_devmap_page() to get page in ZONE_DEVICE
Date:   Wed, 12 Jan 2022 22:35:16 +0800
Message-Id: <20220112143517.262143-2-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220112143517.262143-1-sxwjean@me.com>
References: <20220112143517.262143-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F04:2022-01-11=5F01,2022-01-12=5F04,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2201120095
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

when requesting page information by /proc/kpage*, the pages in ZONE_DEVICE
were ignored . We need a function to help on this.

The pfn_to_devmap_page() function like pfn_to_online_page(), but only
concerns the pages in ZONE_DEVICE.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
v3: Before returning page pointer, check validity of page by 
    pgmap_pfn_valid().
v2: Simplify pfn_to_devmap_page() as David suggested.
---
 include/linux/memremap.h |  8 ++++++++
 mm/memremap.c            | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+)

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
index 5a66a71ab591..782309b74d71 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -494,6 +494,25 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 }
 EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
+/**
+ * pfn_to_devmap_page - get page pointer which belongs to dev_pagemap by @pfn
+ * @pfn: page frame number to lookup page_map
+ * @pgmap: to save pgmap address which is for putting reference
+ *
+ * If @pgmap is non-NULL, then pfn is on ZONE_DEVICE. Meanwhile check if
+ * pfn is valid in @pgmap, if yes return page pointer.
+ */
+struct page *pfn_to_devmap_page(unsigned long pfn, struct dev_pagemap **pgmap)
+{
+	if (pfn_valid(pfn)) {
+		*pgmap = get_dev_pagemap(pfn, NULL);
+		if (*pgmap && pgmap_pfn_valid(*pgmap, pfn))
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

