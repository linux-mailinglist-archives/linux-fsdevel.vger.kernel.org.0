Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D90362F50
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 12:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbhDQKli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Apr 2021 06:41:38 -0400
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:1390 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236006AbhDQKlg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Apr 2021 06:41:36 -0400
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mike Rapoport <rppt@kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Peter Enderborg <peter.enderborg@sony.com>
Subject: [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
Date:   Sat, 17 Apr 2021 12:40:32 +0200
Message-ID: <20210417104032.5521-1-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEG-SpamProfiler-Analysis: v=2.3 cv=crzlbGwi c=1 sm=1 tr=0 a=fZcToFWbXLKijqHhjJ02CA==:117 a=3YhXtTcJ-WEA:10 a=z6gsHLkEAAAA:8 a=tkJolnyHCId0vxgkOZ0A:9 a=d-OLMTCWyvARjPbQ-enb:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds a total used dma-buf memory. Details
can be found in debugfs, however it is not for everyone
and not always available. dma-buf are indirect allocated by
userspace. So with this value we can monitor and detect
userspace applications that have problems.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 drivers/dma-buf/dma-buf.c | 13 +++++++++++++
 fs/proc/meminfo.c         |  5 ++++-
 include/linux/dma-buf.h   |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index f264b70c383e..197e5c45dd26 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -37,6 +37,7 @@ struct dma_buf_list {
 };
 
 static struct dma_buf_list db_list;
+static atomic_long_t dma_buf_global_allocated;
 
 static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
 {
@@ -79,6 +80,7 @@ static void dma_buf_release(struct dentry *dentry)
 	if (dmabuf->resv == (struct dma_resv *)&dmabuf[1])
 		dma_resv_fini(dmabuf->resv);
 
+	atomic_long_sub(dmabuf->size, &dma_buf_global_allocated);
 	module_put(dmabuf->owner);
 	kfree(dmabuf->name);
 	kfree(dmabuf);
@@ -586,6 +588,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 	mutex_lock(&db_list.lock);
 	list_add(&dmabuf->list_node, &db_list.head);
 	mutex_unlock(&db_list.lock);
+	atomic_long_add(dmabuf->size, &dma_buf_global_allocated);
 
 	return dmabuf;
 
@@ -1346,6 +1349,16 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
 }
 EXPORT_SYMBOL_GPL(dma_buf_vunmap);
 
+/**
+ * dma_buf_allocated_pages - Return the used nr of pages
+ * allocated for dma-buf
+ */
+long dma_buf_allocated_pages(void)
+{
+	return atomic_long_read(&dma_buf_global_allocated) >> PAGE_SHIFT;
+}
+EXPORT_SYMBOL_GPL(dma_buf_allocated_pages);
+
 #ifdef CONFIG_DEBUG_FS
 static int dma_buf_debug_show(struct seq_file *s, void *unused)
 {
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 6fa761c9cc78..ccc7c40c8db7 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -16,6 +16,7 @@
 #ifdef CONFIG_CMA
 #include <linux/cma.h>
 #endif
+#include <linux/dma-buf.h>
 #include <asm/page.h>
 #include "internal.h"
 
@@ -145,7 +146,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "CmaFree:        ",
 		    global_zone_page_state(NR_FREE_CMA_PAGES));
 #endif
-
+#ifdef CONFIG_DMA_SHARED_BUFFER
+	show_val_kb(m, "DmaBufTotal:    ", dma_buf_allocated_pages());
+#endif
 	hugetlb_report_meminfo(m);
 
 	arch_report_meminfo(m);
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index efdc56b9d95f..5b05816bd2cd 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -507,4 +507,5 @@ int dma_buf_mmap(struct dma_buf *, struct vm_area_struct *,
 		 unsigned long);
 int dma_buf_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
 void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
+long dma_buf_allocated_pages(void);
 #endif /* __DMA_BUF_H__ */
-- 
2.17.1

