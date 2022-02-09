Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB054AFE36
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiBIUWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiBIUWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165BFE040C93
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0t+O+0ytDr+J40tHrYHxp8CVZJF7EdSw9sVncdS6rmA=; b=CL4LJy4a9U9TuMm+/h3iBrOxFf
        tj6JyTOWV5Swh/9n7IpRV7TPHPZ4Fe+6myUX3boK+4NcLPT0ji8Vm1S5MVTgLpnzd4H1qagAE5zIt
        CORNO5KL6/f43YJwN5dUbBPbwq6Ks9AqvRok7AmXO67BxKB0U3/2aQyR1WyCFOcxs0STaFWez1ja1
        3jFXHzeqFAWb1WnGsQqn19eOpi3zdGNkxI7Hgb+cs8tXL4ci7F2J8tyxNhtErm+Kz4lEClynwx0qA
        kdGRGCQoJAvAW0D3b19hP9lwr88+TZZoVPGQTLRueH/OHxZPL4l8GSbtz9NxSfy1Mqfp0utA7X9XO
        VClcyNYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTs-008cpy-DL; Wed, 09 Feb 2022 20:22:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 14/56] iomap: Remove iomap_invalidatepage()
Date:   Wed,  9 Feb 2022 20:21:33 +0000
Message-Id: <20220209202215.2055748-15-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
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

Use iomap_invalidate_folio() in all the iomap-based filesystems
and rename the iomap_invalidatepage tracepoint.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/aops.c         | 2 +-
 fs/iomap/buffered-io.c | 9 +--------
 fs/iomap/trace.h       | 2 +-
 fs/xfs/xfs_aops.c      | 2 +-
 fs/zonefs/super.c      | 2 +-
 include/linux/iomap.h  | 2 --
 6 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 005e920f5d4a..3d54e6101ed1 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -781,7 +781,7 @@ static const struct address_space_operations gfs2_aops = {
 	.readahead = gfs2_readahead,
 	.set_page_dirty = __set_page_dirty_nobuffers,
 	.releasepage = iomap_releasepage,
-	.invalidatepage = iomap_invalidatepage,
+	.invalidate_folio = iomap_invalidate_folio,
 	.bmap = gfs2_bmap,
 	.direct_IO = noop_direct_IO,
 	.migratepage = iomap_migrate_page,
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index da0a7b15a64e..f1df2c9ee584 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -476,7 +476,7 @@ EXPORT_SYMBOL_GPL(iomap_releasepage);
 
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 {
-	trace_iomap_invalidatepage(folio->mapping->host,
+	trace_iomap_invalidate_folio(folio->mapping->host,
 					folio_pos(folio) + offset, len);
 
 	/*
@@ -496,13 +496,6 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 }
 EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
 
-void iomap_invalidatepage(struct page *page, unsigned int offset,
-		unsigned int len)
-{
-	iomap_invalidate_folio(page_folio(page), offset, len);
-}
-EXPORT_SYMBOL_GPL(iomap_invalidatepage);
-
 #ifdef CONFIG_MIGRATION
 int
 iomap_migrate_page(struct address_space *mapping, struct page *newpage,
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 65e39785c284..a6689a563c6e 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -81,7 +81,7 @@ DEFINE_EVENT(iomap_range_class, name,	\
 	TP_ARGS(inode, off, len))
 DEFINE_RANGE_EVENT(iomap_writepage);
 DEFINE_RANGE_EVENT(iomap_releasepage);
-DEFINE_RANGE_EVENT(iomap_invalidatepage);
+DEFINE_RANGE_EVENT(iomap_invalidate_folio);
 DEFINE_RANGE_EVENT(iomap_dio_invalidate_fail);
 
 #define IOMAP_TYPE_STRINGS \
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 9d6a67c7d227..51a040b658cb 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -569,7 +569,7 @@ const struct address_space_operations xfs_address_space_operations = {
 	.writepages		= xfs_vm_writepages,
 	.set_page_dirty		= __set_page_dirty_nobuffers,
 	.releasepage		= iomap_releasepage,
-	.invalidatepage		= iomap_invalidatepage,
+	.invalidate_folio	= iomap_invalidate_folio,
 	.bmap			= xfs_vm_bmap,
 	.direct_IO		= noop_direct_IO,
 	.migratepage		= iomap_migrate_page,
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index b76dfb310ab6..887b39553eb4 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -187,7 +187,7 @@ static const struct address_space_operations zonefs_file_aops = {
 	.writepages		= zonefs_writepages,
 	.set_page_dirty		= __set_page_dirty_nobuffers,
 	.releasepage		= iomap_releasepage,
-	.invalidatepage		= iomap_invalidatepage,
+	.invalidate_folio	= iomap_invalidate_folio,
 	.migratepage		= iomap_migrate_page,
 	.is_partially_uptodate	= iomap_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 3bcbb264f83f..b76f0dd149fb 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -230,8 +230,6 @@ void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 int iomap_releasepage(struct page *page, gfp_t gfp_mask);
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
-void iomap_invalidatepage(struct page *page, unsigned int offset,
-		unsigned int len);
 #ifdef CONFIG_MIGRATION
 int iomap_migrate_page(struct address_space *mapping, struct page *newpage,
 		struct page *page, enum migrate_mode mode);
-- 
2.34.1

