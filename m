Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD8449E288
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 13:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbiA0MlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 07:41:17 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35632 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241277AbiA0MlO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:41:14 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AGv5/a6AcMxHjdRVW/1biw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fVAaw3T0q0j0FyWIaUWiBaa6CZGKhfot0btm28UkCscSAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK79SAmivnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9NljyPhME3xtNWqbS+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZ/UXoeSdfyjXXcu7iheun2HX6/lnEkA6FYMC/eNwG2t?=
 =?us-ascii?q?P6boTLzVlRhCIh8q3xryhQ+Vhj8hlK9PkVKsTs3cmz3fGDPIiQJnGWI3L48NV2?=
 =?us-ascii?q?HE7gcUmNfrceM0fZhJsYQ7GbhkJPU0YYLo6neG1ljz6dhVbtluepuww+We75Ap?=
 =?us-ascii?q?v3LnoNfLRe8eWXoNRn0CFtiTK8nqRKhERNPSb0ibD/n/Eru3Gmy69U4IPPLqi/?=
 =?us-ascii?q?/VujRuYwWl7IBkXU0ar5PeihkOgVtZ3NUMZ4GwtoLI0+UjtScPyNzW8oXiZrls?=
 =?us-ascii?q?fVsBWHukS9g6A0OzX7hyfC2xCSSROAPQitckrVXk62EShgdzkH3psvaeTRHbb8?=
 =?us-ascii?q?a2bxQ5ekwB9wXQqPHdCFFVapYK45txbs/4Gdf47eIbdszE/MWyYL+i2kRUD?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AzY0VGaBKLGQwa/blHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,320,1635177600"; 
   d="scan'208";a="120913268"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Jan 2022 20:41:07 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 43ABB4D169C8;
        Thu, 27 Jan 2022 20:41:03 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 27 Jan 2022 20:41:04 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 27 Jan 2022 20:41:00 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v10 5/9] fsdax: Introduce dax_load_page()
Date:   Thu, 27 Jan 2022 20:40:54 +0800
Message-ID: <20220127124058.1172422-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com>
References: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 43ABB4D169C8.A25E3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current dax_lock_page() locks dax entry by obtaining mapping and
index in page.  To support 1-to-N RMAP in NVDIMM, we need a new function
to lock a specific dax entry corresponding to this file's mapping,index.
And output the page corresponding to the specific dax entry for caller
use.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/dax.c            | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dax.h |  8 ++++++++
 2 files changed, 52 insertions(+)

diff --git a/fs/dax.c b/fs/dax.c
index c8d57080c1aa..964512107c23 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -455,6 +455,50 @@ void dax_unlock_page(struct page *page, dax_entry_t cookie)
 	dax_unlock_entry(&xas, (void *)cookie);
 }
 
+/*
+ * dax_load_page - Load the page corresponding to a (mapping,offset)
+ * @mapping: the file's mapping whose entry we want to load
+ * @index:   the offset within this file
+ * @page:    output the dax page corresponding to this dax entry
+ *
+ * Return: error if it isn't a dax mapping, otherwise 0.
+ */
+int dax_load_page(struct address_space *mapping, pgoff_t index,
+		struct page **page)
+{
+	XA_STATE(xas, &mapping->i_pages, 0);
+	void *entry;
+
+	if (!dax_mapping(mapping))
+		return -EBUSY;
+
+	rcu_read_lock();
+	for (;;) {
+		entry = NULL;
+		xas_lock_irq(&xas);
+		xas_set(&xas, index);
+		entry = xas_load(&xas);
+		if (dax_is_locked(entry)) {
+			rcu_read_unlock();
+			wait_entry_unlocked(&xas, entry);
+			rcu_read_lock();
+			continue;
+		}
+		if (entry &&
+		    !dax_is_zero_entry(entry) && !dax_is_empty_entry(entry)) {
+			/*
+			 * Output the page if the dax entry exists and isn't
+			 * a zero or empty entry.
+			 */
+			*page = pfn_to_page(dax_to_pfn(entry));
+		}
+		xas_unlock_irq(&xas);
+		break;
+	}
+	rcu_read_unlock();
+	return 0;
+}
+
 /*
  * Find page cache entry at given index. If it is a DAX entry, return it
  * with the entry locked. If the page cache doesn't contain an entry at
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 96cfc63b12fd..530ff9733dd9 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -155,6 +155,8 @@ struct page *dax_layout_busy_page(struct address_space *mapping);
 struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
 dax_entry_t dax_lock_page(struct page *page);
 void dax_unlock_page(struct page *page, dax_entry_t cookie);
+int dax_load_page(struct address_space *mapping,
+		unsigned long index, struct page **page);
 #else
 static inline struct page *dax_layout_busy_page(struct address_space *mapping)
 {
@@ -182,6 +184,12 @@ static inline dax_entry_t dax_lock_page(struct page *page)
 static inline void dax_unlock_page(struct page *page, dax_entry_t cookie)
 {
 }
+
+static inline int dax_load_page(struct address_space *mapping,
+		unsigned long index, struct page **page)
+{
+	return 0;
+}
 #endif
 
 int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
-- 
2.34.1



