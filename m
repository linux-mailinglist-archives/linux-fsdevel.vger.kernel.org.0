Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A42184D2CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 18:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbfFTQI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 12:08:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18653 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731986AbfFTQIa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:08:30 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1C9F0CD9F86689AB3D98;
        Fri, 21 Jun 2019 00:08:22 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 21 Jun
 2019 00:08:13 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, Du Wei <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 4/8] staging: erofs: move stagingpage operations to compress.h
Date:   Fri, 21 Jun 2019 00:07:15 +0800
Message-ID: <20190620160719.240682-5-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620160719.240682-1-gaoxiang25@huawei.com>
References: <20190620160719.240682-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

stagingpages are behaved as bounce pages for temporary use.
Move to compress.h since the upcoming decompressor will
allocate stagingpages as well.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/compress.h  | 40 +++++++++++++++++++++++++++++++
 drivers/staging/erofs/unzip_vle.c | 11 +++++----
 drivers/staging/erofs/unzip_vle.h | 20 ----------------
 3 files changed, 46 insertions(+), 25 deletions(-)
 create mode 100644 drivers/staging/erofs/compress.h

diff --git a/drivers/staging/erofs/compress.h b/drivers/staging/erofs/compress.h
new file mode 100644
index 000000000000..1dcfc3b35118
--- /dev/null
+++ b/drivers/staging/erofs/compress.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * linux/drivers/staging/erofs/compress.h
+ *
+ * Copyright (C) 2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#ifndef __EROFS_FS_COMPRESS_H
+#define __EROFS_FS_COMPRESS_H
+
+/*
+ * - 0x5A110C8D ('sallocated', Z_EROFS_MAPPING_STAGING) -
+ * used to mark temporary allocated pages from other
+ * file/cached pages and NULL mapping pages.
+ */
+#define Z_EROFS_MAPPING_STAGING         ((void *)0x5A110C8D)
+
+/* check if a page is marked as staging */
+static inline bool z_erofs_page_is_staging(struct page *page)
+{
+	return page->mapping == Z_EROFS_MAPPING_STAGING;
+}
+
+static inline bool z_erofs_put_stagingpage(struct list_head *pagepool,
+					   struct page *page)
+{
+	if (!z_erofs_page_is_staging(page))
+		return false;
+
+	/* staging pages should not be used by others at the same time */
+	if (page_ref_count(page) > 1)
+		put_page(page);
+	else
+		list_add(&page->lru, pagepool);
+	return true;
+}
+
+#endif
+
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 08f2d4302ecb..d95f985936b6 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -11,6 +11,7 @@
  * distribution for more details.
  */
 #include "unzip_vle.h"
+#include "compress.h"
 #include <linux/prefetch.h>
 
 #include <trace/events/erofs.h>
@@ -855,7 +856,7 @@ static inline void z_erofs_vle_read_endio(struct bio *bio)
 		DBG_BUGON(PageUptodate(page));
 		DBG_BUGON(!page->mapping);
 
-		if (unlikely(!sbi && !z_erofs_is_stagingpage(page))) {
+		if (unlikely(!sbi && !z_erofs_page_is_staging(page))) {
 			sbi = EROFS_SB(page->mapping->host->i_sb);
 
 			if (time_to_inject(sbi, FAULT_READ_IO)) {
@@ -947,7 +948,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 		DBG_BUGON(!page);
 		DBG_BUGON(!page->mapping);
 
-		if (z_erofs_gather_if_stagingpage(page_pool, page))
+		if (z_erofs_put_stagingpage(page_pool, page))
 			continue;
 
 		if (page_type == Z_EROFS_VLE_PAGE_TYPE_HEAD)
@@ -977,7 +978,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 		DBG_BUGON(!page);
 		DBG_BUGON(!page->mapping);
 
-		if (!z_erofs_is_stagingpage(page)) {
+		if (!z_erofs_page_is_staging(page)) {
 			if (erofs_page_is_managed(sbi, page)) {
 				if (unlikely(!PageUptodate(page)))
 					err = -EIO;
@@ -1055,7 +1056,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 			continue;
 
 		/* recycle all individual staging pages */
-		(void)z_erofs_gather_if_stagingpage(page_pool, page);
+		(void)z_erofs_put_stagingpage(page_pool, page);
 
 		WRITE_ONCE(compressed_pages[i], NULL);
 	}
@@ -1068,7 +1069,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 		DBG_BUGON(!page->mapping);
 
 		/* recycle all individual staging pages */
-		if (z_erofs_gather_if_stagingpage(page_pool, page))
+		if (z_erofs_put_stagingpage(page_pool, page))
 			continue;
 
 		if (unlikely(err < 0))
diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/unzip_vle.h
index 9c53009700cf..6c3e0deb63e7 100644
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/drivers/staging/erofs/unzip_vle.h
@@ -16,26 +16,6 @@
 #include "internal.h"
 #include "unzip_pagevec.h"
 
-/*
- *  - 0x5A110C8D ('sallocated', Z_EROFS_MAPPING_STAGING) -
- * used for temporary allocated pages (via erofs_allocpage),
- * in order to seperate those from NULL mapping (eg. truncated pages)
- */
-#define Z_EROFS_MAPPING_STAGING		((void *)0x5A110C8D)
-
-#define z_erofs_is_stagingpage(page)	\
-	((page)->mapping == Z_EROFS_MAPPING_STAGING)
-
-static inline bool z_erofs_gather_if_stagingpage(struct list_head *page_pool,
-						 struct page *page)
-{
-	if (z_erofs_is_stagingpage(page)) {
-		list_add(&page->lru, page_pool);
-		return true;
-	}
-	return false;
-}
-
 /*
  * Structure fields follow one of the following exclusion rules.
  *
-- 
2.17.1

