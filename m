Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C89767D64C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjAZUYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjAZUY1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16810521D8;
        Thu, 26 Jan 2023 12:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2sAKchd+/xLc3BTWuGB2vL7TWMKySAwLf+zsISLSa+4=; b=XrvaJPi5N4vo6xrhVJNQNLbi+p
        sixnmZflWuhamZzLSk0LhcfdB8zy0TifCcHG1SxfbuWaxNP4LHJ5NBCsF4/hGnN6Ys8hIoU3ECYGM
        IpBJskeN82izFHNAUwzpz0fJIlvHrRWTm1wl1lKfH/SJFPhFoY/tXfCJI89/SV5ryGXwZ52wbB9dI
        MzlxjIqFaFJSYv25pioFkoicbFrfFy8W14mFqzgP0s3PtrVffafrpYfCVLhsluPHPCL6y7288lklq
        y612KmKTXQ/wwDIdAZIJt2j94zHxHzGh1jGLdJJX3XJhcZbJOCt44YosbK/9muXbH2uIJ7x+h05oY
        bkQmj4FA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nC-0073jM-Id; Thu, 26 Jan 2023 20:24:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/31] fs: Add FGP_WRITEBEGIN
Date:   Thu, 26 Jan 2023 20:23:45 +0000
Message-Id: <20230126202415.1682629-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230126202415.1682629-1-willy@infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This particular combination of flags is used by most filesystems
in their ->write_begin method, although it does find use in a
few other places.  Before folios, it warranted its own function
(grab_cache_page_write_begin()), but I think that just having specialised
flags is enough.  It certainly helps the few places that have been
converted from grab_cache_page_write_begin() to __filemap_get_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/move_extent.c    | 5 ++---
 fs/iomap/buffered-io.c   | 2 +-
 fs/netfs/buffered_read.c | 3 +--
 include/linux/pagemap.h  | 2 ++
 mm/folio-compat.c        | 4 +---
 5 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 2de9829aed63..0cb361f0a4fe 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -126,7 +126,6 @@ mext_folio_double_lock(struct inode *inode1, struct inode *inode2,
 {
 	struct address_space *mapping[2];
 	unsigned int flags;
-	unsigned fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
 
 	BUG_ON(!inode1 || !inode2);
 	if (inode1 < inode2) {
@@ -139,14 +138,14 @@ mext_folio_double_lock(struct inode *inode1, struct inode *inode2,
 	}
 
 	flags = memalloc_nofs_save();
-	folio[0] = __filemap_get_folio(mapping[0], index1, fgp_flags,
+	folio[0] = __filemap_get_folio(mapping[0], index1, FGP_WRITEBEGIN,
 			mapping_gfp_mask(mapping[0]));
 	if (!folio[0]) {
 		memalloc_nofs_restore(flags);
 		return -ENOMEM;
 	}
 
-	folio[1] = __filemap_get_folio(mapping[1], index2, fgp_flags,
+	folio[1] = __filemap_get_folio(mapping[1], index2, FGP_WRITEBEGIN,
 			mapping_gfp_mask(mapping[1]));
 	memalloc_nofs_restore(flags);
 	if (!folio[1]) {
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6f4c97a6d7e9..10a203515583 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -467,7 +467,7 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
  */
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
 {
-	unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
+	unsigned fgp = FGP_WRITEBEGIN | FGP_NOFS;
 	struct folio *folio;
 
 	if (iter->flags & IOMAP_NOWAIT)
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 7679a68e8193..e3d754a9e1b0 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -341,14 +341,13 @@ int netfs_write_begin(struct netfs_inode *ctx,
 {
 	struct netfs_io_request *rreq;
 	struct folio *folio;
-	unsigned int fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
 	pgoff_t index = pos >> PAGE_SHIFT;
 	int ret;
 
 	DEFINE_READAHEAD(ractl, file, NULL, mapping, index);
 
 retry:
-	folio = __filemap_get_folio(mapping, index, fgp_flags,
+	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
 				    mapping_gfp_mask(mapping));
 	if (!folio)
 		return -ENOMEM;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 9f1081683771..47069662f4b8 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -507,6 +507,8 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 #define FGP_ENTRY		0x00000080
 #define FGP_STABLE		0x00000100
 
+#define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
+
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		int fgp_flags, gfp_t gfp);
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 18c48b557926..668350748828 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -106,9 +106,7 @@ EXPORT_SYMBOL(pagecache_get_page);
 struct page *grab_cache_page_write_begin(struct address_space *mapping,
 					pgoff_t index)
 {
-	unsigned fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
-
-	return pagecache_get_page(mapping, index, fgp_flags,
+	return pagecache_get_page(mapping, index, FGP_WRITEBEGIN,
 			mapping_gfp_mask(mapping));
 }
 EXPORT_SYMBOL(grab_cache_page_write_begin);
-- 
2.35.1

