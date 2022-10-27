Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FED60F291
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Oct 2022 10:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiJ0Ig5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 04:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbiJ0IgM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:36:12 -0400
Received: from out199-9.us.a.mail.aliyun.com (out199-9.us.a.mail.aliyun.com [47.90.199.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883EB9411F;
        Thu, 27 Oct 2022 01:36:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VTAkmCy_1666859758;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VTAkmCy_1666859758)
          by smtp.aliyun-inc.com;
          Thu, 27 Oct 2022 16:35:59 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, jlayton@kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] fscache,netfs: move PageFsCache() family helpers to fscache.h
Date:   Thu, 27 Oct 2022 16:35:46 +0800
Message-Id: <20221027083547.46933-9-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20221027083547.46933-1-jefflexu@linux.alibaba.com>
References: <20221027083547.46933-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Later all structures transformed with "fscache_" prefix will be moved to
fscache.h from netfs.h, and then netfs.h will include fscache.h rather
than the other way around.  If that's the case, the PageFsCache() family
helpers also needs to be moved to fscache.h, since end_page_fscache() is
referenced inside fscache.

Besides, it's also quite reasonable to move these helpers to fscache.h
given their names.

This is a cleanup without logic change.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/linux/fscache.h | 90 +++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h   | 89 ----------------------------------------
 2 files changed, 90 insertions(+), 89 deletions(-)

diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 9df2988be804..034d009c0de7 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -17,6 +17,7 @@
 #include <linux/fs.h>
 #include <linux/netfs.h>
 #include <linux/writeback.h>
+#include <linux/pagemap.h>
 
 #if defined(CONFIG_FSCACHE) || defined(CONFIG_FSCACHE_MODULE)
 #define __fscache_available (1)
@@ -695,4 +696,93 @@ void fscache_note_page_release(struct fscache_cookie *cookie)
 		clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
 }
 
+/*
+ * Overload PG_private_2 to give us PG_fscache - this is used to indicate that
+ * a page is currently backed by a local disk cache
+ */
+#define folio_test_fscache(folio)	folio_test_private_2(folio)
+#define PageFsCache(page)		PagePrivate2((page))
+#define SetPageFsCache(page)		SetPagePrivate2((page))
+#define ClearPageFsCache(page)		ClearPagePrivate2((page))
+#define TestSetPageFsCache(page)	TestSetPagePrivate2((page))
+#define TestClearPageFsCache(page)	TestClearPagePrivate2((page))
+
+/**
+ * folio_start_fscache - Start an fscache write on a folio.
+ * @folio: The folio.
+ *
+ * Call this function before writing a folio to a local cache.  Starting a
+ * second write before the first one finishes is not allowed.
+ */
+static inline void folio_start_fscache(struct folio *folio)
+{
+	VM_BUG_ON_FOLIO(folio_test_private_2(folio), folio);
+	folio_get(folio);
+	folio_set_private_2(folio);
+}
+
+/**
+ * folio_end_fscache - End an fscache write on a folio.
+ * @folio: The folio.
+ *
+ * Call this function after the folio has been written to the local cache.
+ * This will wake any sleepers waiting on this folio.
+ */
+static inline void folio_end_fscache(struct folio *folio)
+{
+	folio_end_private_2(folio);
+}
+
+/**
+ * folio_wait_fscache - Wait for an fscache write on this folio to end.
+ * @folio: The folio.
+ *
+ * If this folio is currently being written to a local cache, wait for
+ * the write to finish.  Another write may start after this one finishes,
+ * unless the caller holds the folio lock.
+ */
+static inline void folio_wait_fscache(struct folio *folio)
+{
+	folio_wait_private_2(folio);
+}
+
+/**
+ * folio_wait_fscache_killable - Wait for an fscache write on this folio to end.
+ * @folio: The folio.
+ *
+ * If this folio is currently being written to a local cache, wait
+ * for the write to finish or for a fatal signal to be received.
+ * Another write may start after this one finishes, unless the caller
+ * holds the folio lock.
+ *
+ * Return:
+ * - 0 if successful.
+ * - -EINTR if a fatal signal was encountered.
+ */
+static inline int folio_wait_fscache_killable(struct folio *folio)
+{
+	return folio_wait_private_2_killable(folio);
+}
+
+static inline void set_page_fscache(struct page *page)
+{
+	folio_start_fscache(page_folio(page));
+}
+
+static inline void end_page_fscache(struct page *page)
+{
+	folio_end_private_2(page_folio(page));
+}
+
+static inline void wait_on_page_fscache(struct page *page)
+{
+	folio_wait_private_2(page_folio(page));
+}
+
+static inline int wait_on_page_fscache_killable(struct page *page)
+{
+	return folio_wait_private_2_killable(page_folio(page));
+}
+
+
 #endif /* _LINUX_FSCACHE_H */
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 146a13e6a9d2..2ad4e1e88106 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -16,98 +16,9 @@
 
 #include <linux/workqueue.h>
 #include <linux/fs.h>
-#include <linux/pagemap.h>
 
 enum netfs_sreq_ref_trace;
 
-/*
- * Overload PG_private_2 to give us PG_fscache - this is used to indicate that
- * a page is currently backed by a local disk cache
- */
-#define folio_test_fscache(folio)	folio_test_private_2(folio)
-#define PageFsCache(page)		PagePrivate2((page))
-#define SetPageFsCache(page)		SetPagePrivate2((page))
-#define ClearPageFsCache(page)		ClearPagePrivate2((page))
-#define TestSetPageFsCache(page)	TestSetPagePrivate2((page))
-#define TestClearPageFsCache(page)	TestClearPagePrivate2((page))
-
-/**
- * folio_start_fscache - Start an fscache write on a folio.
- * @folio: The folio.
- *
- * Call this function before writing a folio to a local cache.  Starting a
- * second write before the first one finishes is not allowed.
- */
-static inline void folio_start_fscache(struct folio *folio)
-{
-	VM_BUG_ON_FOLIO(folio_test_private_2(folio), folio);
-	folio_get(folio);
-	folio_set_private_2(folio);
-}
-
-/**
- * folio_end_fscache - End an fscache write on a folio.
- * @folio: The folio.
- *
- * Call this function after the folio has been written to the local cache.
- * This will wake any sleepers waiting on this folio.
- */
-static inline void folio_end_fscache(struct folio *folio)
-{
-	folio_end_private_2(folio);
-}
-
-/**
- * folio_wait_fscache - Wait for an fscache write on this folio to end.
- * @folio: The folio.
- *
- * If this folio is currently being written to a local cache, wait for
- * the write to finish.  Another write may start after this one finishes,
- * unless the caller holds the folio lock.
- */
-static inline void folio_wait_fscache(struct folio *folio)
-{
-	folio_wait_private_2(folio);
-}
-
-/**
- * folio_wait_fscache_killable - Wait for an fscache write on this folio to end.
- * @folio: The folio.
- *
- * If this folio is currently being written to a local cache, wait
- * for the write to finish or for a fatal signal to be received.
- * Another write may start after this one finishes, unless the caller
- * holds the folio lock.
- *
- * Return:
- * - 0 if successful.
- * - -EINTR if a fatal signal was encountered.
- */
-static inline int folio_wait_fscache_killable(struct folio *folio)
-{
-	return folio_wait_private_2_killable(folio);
-}
-
-static inline void set_page_fscache(struct page *page)
-{
-	folio_start_fscache(page_folio(page));
-}
-
-static inline void end_page_fscache(struct page *page)
-{
-	folio_end_private_2(page_folio(page));
-}
-
-static inline void wait_on_page_fscache(struct page *page)
-{
-	folio_wait_private_2(page_folio(page));
-}
-
-static inline int wait_on_page_fscache_killable(struct page *page)
-{
-	return folio_wait_private_2_killable(page_folio(page));
-}
-
 enum fscache_io_source {
 	FSCACHE_FILL_WITH_ZEROES,
 	FSCACHE_DOWNLOAD_FROM_SERVER,
-- 
2.19.1.6.gb485710b

