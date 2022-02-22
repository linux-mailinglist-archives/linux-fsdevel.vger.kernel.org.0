Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6824C024F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiBVTtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbiBVTsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF42B6D24
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ul4Z3JdPMTd2pd5eqttiYos67YRAtK0J78uliXeUzr8=; b=MQhplv2OVcPK90vECe46vf7tma
        2F2gBr4jyexSl8Joc4/Cqz1l9ID7YyQuZoyCQtuzmmbo6kQe7ymFyOd7clFKJe+Kw4h9Oo5x7Ykw8
        yHvoDIM2pBW0Uq/PI7Cr43EISN2Mp6ANRFFX1J6fBbjJM5FbNEEMC8EYKhzL94Av8JgdOB1KDLjMY
        maBE6PNnDSa9FRsH9M0vYAvJtwL40xu6MfLxgkJq9+Pe+D40HE5x5LV8gSJk8+PErkwRXRrFFXC3N
        LV99R+dfMCw07gDDi1vIKnWVxf9D9+OT8XwFZA+c7zKn/bhMDGT6ey4eRnrIsMdbwjVcxn5m1I1A5
        W5808cGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb95-0035zY-5Y; Tue, 22 Feb 2022 19:48:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 02/22] fs: Move pagecache_write_begin() and pagecache_write_end()
Date:   Tue, 22 Feb 2022 19:48:00 +0000
Message-Id: <20220222194820.737755-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220222194820.737755-1-willy@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
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

These functions are now simple enough to be static inlines.  They
should also be in pagemap.h instead of fs.h because they're
pagecache functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fs.h      | 12 ------------
 include/linux/pagemap.h | 20 ++++++++++++++++++++
 mm/filemap.c            | 21 ---------------------
 3 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 394570a970af..2843f789a6db 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -391,18 +391,6 @@ struct address_space_operations {
 
 extern const struct address_space_operations empty_aops;
 
-/*
- * pagecache_write_begin/pagecache_write_end must be used by general code
- * to write into the pagecache.
- */
-int pagecache_write_begin(struct file *, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned flags,
-				struct page **pagep, void **fsdata);
-
-int pagecache_write_end(struct file *, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned copied,
-				struct page *page, void *fsdata);
-
 /**
  * struct address_space - Contents of a cacheable, mappable object.
  * @host: Owner, either the inode or the block_device.
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 9cd504542c31..76b0ddfef5ba 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -529,6 +529,26 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
 			mapping_gfp_mask(mapping));
 }
 
+/*
+ * pagecache_write_begin/pagecache_write_end must be used by general code
+ * to write into the pagecache.
+ */
+static inline int pagecache_write_begin(struct file *file,
+		struct address_space *mapping, loff_t pos, unsigned len,
+		unsigned flags, struct page **pagep, void **fsdata)
+{
+	return mapping->a_ops->write_begin(file, mapping, pos, len, flags,
+						pagep, fsdata);
+}
+
+static inline int pagecache_write_end(struct file *file,
+		struct address_space *mapping, loff_t pos, unsigned len,
+		unsigned copied, struct page *page, void *fsdata)
+{
+	return mapping->a_ops->write_end(file, mapping, pos, len, copied,
+						page, fsdata);
+}
+
 #define swapcache_index(folio)	__page_file_index(&(folio)->page)
 
 /**
diff --git a/mm/filemap.c b/mm/filemap.c
index c2bef068afab..9e3ccc2e54ee 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3601,27 +3601,6 @@ struct page *read_cache_page_gfp(struct address_space *mapping,
 }
 EXPORT_SYMBOL(read_cache_page_gfp);
 
-int pagecache_write_begin(struct file *file, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned flags,
-				struct page **pagep, void **fsdata)
-{
-	const struct address_space_operations *aops = mapping->a_ops;
-
-	return aops->write_begin(file, mapping, pos, len, flags,
-							pagep, fsdata);
-}
-EXPORT_SYMBOL(pagecache_write_begin);
-
-int pagecache_write_end(struct file *file, struct address_space *mapping,
-				loff_t pos, unsigned len, unsigned copied,
-				struct page *page, void *fsdata)
-{
-	const struct address_space_operations *aops = mapping->a_ops;
-
-	return aops->write_end(file, mapping, pos, len, copied, page, fsdata);
-}
-EXPORT_SYMBOL(pagecache_write_end);
-
 /*
  * Warn about a page cache invalidation failure during a direct I/O write.
  */
-- 
2.34.1

