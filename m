Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1945151F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379687AbiD2RaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379549AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5866FA147C
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kLHvtK2PEJqV3VRmzYKvwtRC8J4WDZZsodUTyXD7yXw=; b=oykdJTp2d5NpASn7vYY6GAVW/a
        Ov7QgJpIdkhdsB08mMzSGq511s1V/iyNogwoftcPuWvX8I2LG2gJj35JJ+tNluK0J+bGVOWSqDiCL
        STgq708PE3hY+f5Xc/cW4OmKC55+zG2JPq0vI+Ujfr7HPT5Xy8ufIJryVbbejQsB4AeUjlzL8Lyvi
        Y1K9shA2ZZTxs+DXiLP+mswgjmLJ2+OSZ5k0txlxOPyULgQ94M+ZP5Ob9z5OWeg5DfX5mImdTBNpW
        nYDEVODyh1+xYkA4/t1bsCYW0cWfEGMIMLnhDjq6U1hK5+iDf4jzZiGZe6oh/hvf8X68CqPx8QJR3
        BYfxQlmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNa-00Cda3-Db; Fri, 29 Apr 2022 17:26:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 35/69] fs: Convert netfs_readpage to netfs_read_folio
Date:   Fri, 29 Apr 2022 18:25:22 +0100
Message-Id: <20220429172556.3011843-36-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
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

This is straightforward because netfs already worked in terms of folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/9p/vfs_addr.c         |  2 +-
 fs/afs/file.c            |  2 +-
 fs/ceph/addr.c           |  2 +-
 fs/netfs/buffered_read.c | 15 +++++++--------
 include/linux/netfs.h    |  2 +-
 5 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index a2d57112f53e..3a84167f4893 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -336,7 +336,7 @@ static bool v9fs_dirty_folio(struct address_space *mapping, struct folio *folio)
 #endif
 
 const struct address_space_operations v9fs_addr_operations = {
-	.readpage = netfs_readpage,
+	.read_folio = netfs_read_folio,
 	.readahead = netfs_readahead,
 	.dirty_folio = v9fs_dirty_folio,
 	.writepage = v9fs_vfs_writepage,
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 26292a110a8f..e277fbe55262 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -50,7 +50,7 @@ const struct inode_operations afs_file_inode_operations = {
 };
 
 const struct address_space_operations afs_file_aops = {
-	.readpage	= netfs_readpage,
+	.read_folio	= netfs_read_folio,
 	.readahead	= netfs_readahead,
 	.dirty_folio	= afs_dirty_folio,
 	.launder_folio	= afs_launder_folio,
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e65541a51b68..3acd33da6d8c 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1372,7 +1372,7 @@ static int ceph_write_end(struct file *file, struct address_space *mapping,
 }
 
 const struct address_space_operations ceph_aops = {
-	.readpage = netfs_readpage,
+	.read_folio = netfs_read_folio,
 	.readahead = netfs_readahead,
 	.writepage = ceph_writepage,
 	.writepages = ceph_writepages_start,
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 1d44509455a5..8742d22dfd2b 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -198,22 +198,21 @@ void netfs_readahead(struct readahead_control *ractl)
 EXPORT_SYMBOL(netfs_readahead);
 
 /**
- * netfs_readpage - Helper to manage a readpage request
+ * netfs_read_folio - Helper to manage a read_folio request
  * @file: The file to read from
- * @subpage: A subpage of the folio to read
+ * @folio: The folio to read
  *
- * Fulfil a readpage request by drawing data from the cache if possible, or the
- * netfs if not.  Space beyond the EOF is zero-filled.  Multiple I/O requests
- * from different sources will get munged together.
+ * Fulfil a read_folio request by drawing data from the cache if
+ * possible, or the netfs if not.  Space beyond the EOF is zero-filled.
+ * Multiple I/O requests from different sources will get munged together.
  *
  * The calling netfs must initialise a netfs context contiguous to the vfs
  * inode before calling this.
  *
  * This is usable whether or not caching is enabled.
  */
-int netfs_readpage(struct file *file, struct page *subpage)
+int netfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct folio *folio = page_folio(subpage);
 	struct address_space *mapping = folio_file_mapping(folio);
 	struct netfs_io_request *rreq;
 	struct netfs_i_context *ctx = netfs_i_context(mapping->host);
@@ -245,7 +244,7 @@ int netfs_readpage(struct file *file, struct page *subpage)
 	folio_unlock(folio);
 	return ret;
 }
-EXPORT_SYMBOL(netfs_readpage);
+EXPORT_SYMBOL(netfs_read_folio);
 
 /*
  * Prepare a folio for writing without reading first
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 1c29f317d907..4bd5ee709daa 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -274,7 +274,7 @@ struct netfs_cache_ops {
 
 struct readahead_control;
 extern void netfs_readahead(struct readahead_control *);
-extern int netfs_readpage(struct file *, struct page *);
+int netfs_read_folio(struct file *, struct folio *);
 extern int netfs_write_begin(struct file *, struct address_space *,
 			     loff_t, unsigned int, struct folio **,
 			     void **);
-- 
2.34.1

