Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7A86C8436
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjCXSCg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjCXSCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5631DB8E;
        Fri, 24 Mar 2023 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sXqAKBPFYOmgT3qHrDj0dGwSijkViypLlqJYIvRlOnY=; b=Pq0bg/KXOfy+GZY8DhQz5VcLJK
        FIOG35W924WGMFzJVuB6souKEexkgWDft92qhjJslCVw+/Y/lWhdK1gynglKWkW3MfcSWUMu8Fx/5
        UH21LyyFwS44Hd8eSfIkOp+YBlD0qzO+f1kM7NSQkZVBSj595IwRpbJopnI+5GQ9NV5CHLtAaMdyL
        SZu83AssPGed+xsdnFqR7EoqIrdN4BdcgbGMEaUmkxYY7E3iej/JbbS2qGc8UVKAuHX9K9G146glr
        ebbixHZlXNIpxmfDWez41Hy8/nwImLaaL7pOuu4qY8uNz8HIdgKpqKrmZ5CJQ+4dsp3Sa5hvr8Axh
        egnrtyUA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljK-0057Yp-S0; Fri, 24 Mar 2023 18:01:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 01/29] fs: Add FGP_WRITEBEGIN
Date:   Fri, 24 Mar 2023 18:01:01 +0000
Message-Id: <20230324180129.1220691-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230324180129.1220691-1-willy@infradead.org>
References: <20230324180129.1220691-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 fs/ext4/move_extent.c    |  5 ++---
 fs/iomap/buffered-io.c   |  2 +-
 fs/netfs/buffered_read.c |  3 +--
 fs/nfs/file.c            | 12 ++----------
 include/linux/pagemap.h  |  2 ++
 mm/folio-compat.c        |  4 +---
 6 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 7bf6d069199c..a84a794fed56 100644
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
 	if (IS_ERR(folio[0])) {
 		memalloc_nofs_restore(flags);
 		return PTR_ERR(folio[0]);
 	}
 
-	folio[1] = __filemap_get_folio(mapping[1], index2, fgp_flags,
+	folio[1] = __filemap_get_folio(mapping[1], index2, FGP_WRITEBEGIN,
 			mapping_gfp_mask(mapping[1]));
 	memalloc_nofs_restore(flags);
 	if (IS_ERR(folio[1])) {
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 96bb56c203f4..063133ec77f4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -467,7 +467,7 @@ EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
  */
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos)
 {
-	unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
+	unsigned fgp = FGP_WRITEBEGIN | FGP_NOFS;
 
 	if (iter->flags & IOMAP_NOWAIT)
 		fgp |= FGP_NOWAIT;
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 209726a9cfdb..3404707ddbe7 100644
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
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 1d03406e6c03..dd9ef0655716 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -306,15 +306,6 @@ static bool nfs_want_read_modify_write(struct file *file, struct folio *folio,
 	return false;
 }
 
-static struct folio *
-nfs_folio_grab_cache_write_begin(struct address_space *mapping, pgoff_t index)
-{
-	unsigned fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
-
-	return __filemap_get_folio(mapping, index, fgp_flags,
-				   mapping_gfp_mask(mapping));
-}
-
 /*
  * This does the "real" work of the write. We must allocate and lock the
  * page to be sent back to the generic routine, which then copies the
@@ -335,7 +326,8 @@ static int nfs_write_begin(struct file *file, struct address_space *mapping,
 		file, mapping->host->i_ino, len, (long long) pos);
 
 start:
-	folio = nfs_folio_grab_cache_write_begin(mapping, pos >> PAGE_SHIFT);
+	folio = __filemap_get_folio(mapping, pos >> PAGE_SHIFT, FGP_WRITEBEGIN,
+				   mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 	*pagep = &folio->page;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index fdcd595d2294..a56308a9d1a4 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -506,6 +506,8 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 #define FGP_FOR_MMAP		0x00000040
 #define FGP_STABLE		0x00000080
 
+#define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
+
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
 struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		int fgp_flags, gfp_t gfp);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 2511c055a35f..c6f056c20503 100644
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
2.39.2

