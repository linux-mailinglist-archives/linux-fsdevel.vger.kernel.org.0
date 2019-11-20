Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6FD103444
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 07:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfKTGXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 01:23:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:49722 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfKTGXh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 01:23:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 22:23:37 -0800
X-IronPort-AV: E=Sophos;i="5.69,220,1571727600"; 
   d="scan'208";a="204625878"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 22:23:37 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] mm: Clean up filemap_write_and_wait()
Date:   Tue, 19 Nov 2019 22:23:34 -0800
Message-Id: <20191120062334.24687-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

At some point filemap_write_and_wait() and
filemap_write_and_wait_range() got the exact same implementation with
the exception of the range being specified in *_range()

Similar to other functions in fs.h which call
*_range(..., 0, LLONG_MAX), change filemap_write_and_wait() to be a
static inline which calls filemap_write_and_wait_range()

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/fs.h |  6 +++++-
 mm/filemap.c       | 34 ++++++----------------------------
 2 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1175815da3df..1007742711e5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2745,7 +2745,6 @@ static inline int filemap_fdatawait(struct address_space *mapping)
 
 extern bool filemap_range_has_page(struct address_space *, loff_t lstart,
 				  loff_t lend);
-extern int filemap_write_and_wait(struct address_space *mapping);
 extern int filemap_write_and_wait_range(struct address_space *mapping,
 				        loff_t lstart, loff_t lend);
 extern int __filemap_fdatawrite_range(struct address_space *mapping,
@@ -2755,6 +2754,11 @@ extern int filemap_fdatawrite_range(struct address_space *mapping,
 extern int filemap_check_errors(struct address_space *mapping);
 extern void __filemap_set_wb_err(struct address_space *mapping, int err);
 
+static inline int filemap_write_and_wait(struct address_space *mapping)
+{
+	return filemap_write_and_wait_range(mapping, 0, LLONG_MAX);
+}
+
 extern int __must_check file_fdatawait_range(struct file *file, loff_t lstart,
 						loff_t lend);
 extern int __must_check file_check_and_advance_wb_err(struct file *file);
diff --git a/mm/filemap.c b/mm/filemap.c
index 1f5731768222..f4d1a4fb63a6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -632,33 +632,6 @@ static bool mapping_needs_writeback(struct address_space *mapping)
 	return mapping->nrpages;
 }
 
-int filemap_write_and_wait(struct address_space *mapping)
-{
-	int err = 0;
-
-	if (mapping_needs_writeback(mapping)) {
-		err = filemap_fdatawrite(mapping);
-		/*
-		 * Even if the above returned error, the pages may be
-		 * written partially (e.g. -ENOSPC), so we wait for it.
-		 * But the -EIO is special case, it may indicate the worst
-		 * thing (e.g. bug) happened, so we avoid waiting for it.
-		 */
-		if (err != -EIO) {
-			int err2 = filemap_fdatawait(mapping);
-			if (!err)
-				err = err2;
-		} else {
-			/* Clear any previously stored errors */
-			filemap_check_errors(mapping);
-		}
-	} else {
-		err = filemap_check_errors(mapping);
-	}
-	return err;
-}
-EXPORT_SYMBOL(filemap_write_and_wait);
-
 /**
  * filemap_write_and_wait_range - write out & wait on a file range
  * @mapping:	the address_space for the pages
@@ -680,7 +653,12 @@ int filemap_write_and_wait_range(struct address_space *mapping,
 	if (mapping_needs_writeback(mapping)) {
 		err = __filemap_fdatawrite_range(mapping, lstart, lend,
 						 WB_SYNC_ALL);
-		/* See comment of filemap_write_and_wait() */
+		/*
+		 * Even if the above returned error, the pages may be
+		 * written partially (e.g. -ENOSPC), so we wait for it.
+		 * But the -EIO is special case, it may indicate the worst
+		 * thing (e.g. bug) happened, so we avoid waiting for it.
+		 */
 		if (err != -EIO) {
 			int err2 = filemap_fdatawait_range(mapping,
 						lstart, lend);
-- 
2.21.0

