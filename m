Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84EF51F196
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbiEHUhm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiEHUgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E92111C22
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=X9aimttSY0SxPLjcKDF5tW7VdcRJaCocGP60OOSbjRI=; b=GWAMwKjE97pdaKldLQrZmqnmEW
        pib8AaMHvNw3LDREL5hGxCoNgXD7tDcydIllPYTO9qAazxxO30HsVbxzk+u4BgMc6OtoEyL3vyFJJ
        1MunBFzgmrDKO+yNs7GkdRYbO/FzSMTITlz4Ez/CYKWVbYkSrdZUFQyuL3/UF06k6DcsLoH/lVEz1
        UHpMwosR2lzhJAumCaEweoJ83amAjUfjql9YuRLA/z3gAXII2azFIHLW5HyCGw2ANpduCVICs3smx
        JM8DQK7HCGI+dfD9y1uj7KYEEbPZtuskiWw674SDmYuwSGI2aCRlzza/75CI6M40IuXsQ3jT33YJw
        Ewu5j8PQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaE-002o1a-5K; Sun, 08 May 2022 20:32:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 11/26] gfs2: Convert to release_folio
Date:   Sun,  8 May 2022 21:32:32 +0100
Message-Id: <20220508203247.668791-12-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203247.668791-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use a folio throughout gfs2_release_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/aops.c    | 42 ++++++++++++++++++++++--------------------
 fs/gfs2/inode.h   |  2 +-
 fs/gfs2/meta_io.c |  4 ++--
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 3d6c5c5eb4f1..95a674d70c04 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -691,38 +691,40 @@ static void gfs2_invalidate_folio(struct folio *folio, size_t offset,
 }
 
 /**
- * gfs2_releasepage - free the metadata associated with a page
- * @page: the page that's being released
+ * gfs2_release_folio - free the metadata associated with a folio
+ * @folio: the folio that's being released
  * @gfp_mask: passed from Linux VFS, ignored by us
  *
- * Calls try_to_free_buffers() to free the buffers and put the page if the
+ * Calls try_to_free_buffers() to free the buffers and put the folio if the
  * buffers can be released.
  *
- * Returns: 1 if the page was put or else 0
+ * Returns: true if the folio was put or else false
  */
 
-int gfs2_releasepage(struct page *page, gfp_t gfp_mask)
+bool gfs2_release_folio(struct folio *folio, gfp_t gfp_mask)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = folio->mapping;
 	struct gfs2_sbd *sdp = gfs2_mapping2sbd(mapping);
 	struct buffer_head *bh, *head;
 	struct gfs2_bufdata *bd;
 
-	if (!page_has_buffers(page))
-		return 0;
+	head = folio_buffers(folio);
+	if (!head)
+		return false;
 
 	/*
-	 * From xfs_vm_releasepage: mm accommodates an old ext3 case where
-	 * clean pages might not have had the dirty bit cleared.  Thus, it can
-	 * send actual dirty pages to ->releasepage() via shrink_active_list().
+	 * mm accommodates an old ext3 case where clean folios might
+	 * not have had the dirty bit cleared.	Thus, it can send actual
+	 * dirty folios to ->release_folio() via shrink_active_list().
 	 *
-	 * As a workaround, we skip pages that contain dirty buffers below.
-	 * Once ->releasepage isn't called on dirty pages anymore, we can warn
-	 * on dirty buffers like we used to here again.
+	 * As a workaround, we skip folios that contain dirty buffers
+	 * below.  Once ->release_folio isn't called on dirty folios
+	 * anymore, we can warn on dirty buffers like we used to here
+	 * again.
 	 */
 
 	gfs2_log_lock(sdp);
-	head = bh = page_buffers(page);
+	bh = head;
 	do {
 		if (atomic_read(&bh->b_count))
 			goto cannot_release;
@@ -732,9 +734,9 @@ int gfs2_releasepage(struct page *page, gfp_t gfp_mask)
 		if (buffer_dirty(bh) || WARN_ON(buffer_pinned(bh)))
 			goto cannot_release;
 		bh = bh->b_this_page;
-	} while(bh != head);
+	} while (bh != head);
 
-	head = bh = page_buffers(page);
+	bh = head;
 	do {
 		bd = bh->b_private;
 		if (bd) {
@@ -755,11 +757,11 @@ int gfs2_releasepage(struct page *page, gfp_t gfp_mask)
 	} while (bh != head);
 	gfs2_log_unlock(sdp);
 
-	return try_to_free_buffers(page);
+	return try_to_free_buffers(&folio->page);
 
 cannot_release:
 	gfs2_log_unlock(sdp);
-	return 0;
+	return false;
 }
 
 static const struct address_space_operations gfs2_aops = {
@@ -785,7 +787,7 @@ static const struct address_space_operations gfs2_jdata_aops = {
 	.dirty_folio = jdata_dirty_folio,
 	.bmap = gfs2_bmap,
 	.invalidate_folio = gfs2_invalidate_folio,
-	.releasepage = gfs2_releasepage,
+	.release_folio = gfs2_release_folio,
 	.is_partially_uptodate = block_is_partially_uptodate,
 	.error_remove_page = generic_error_remove_page,
 };
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index 7b2c1f390db7..0264d514dda7 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -12,7 +12,7 @@
 #include <linux/mm.h>
 #include "util.h"
 
-extern int gfs2_releasepage(struct page *page, gfp_t gfp_mask);
+bool gfs2_release_folio(struct folio *folio, gfp_t gfp_mask);
 extern int gfs2_internal_read(struct gfs2_inode *ip,
 			      char *buf, loff_t *pos, unsigned size);
 extern void gfs2_set_aops(struct inode *inode);
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index d8bd1d48bd78..868dcc71b581 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -92,14 +92,14 @@ const struct address_space_operations gfs2_meta_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.writepage = gfs2_aspace_writepage,
-	.releasepage = gfs2_releasepage,
+	.release_folio = gfs2_release_folio,
 };
 
 const struct address_space_operations gfs2_rgrp_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.writepage = gfs2_aspace_writepage,
-	.releasepage = gfs2_releasepage,
+	.release_folio = gfs2_release_folio,
 };
 
 /**
-- 
2.34.1

