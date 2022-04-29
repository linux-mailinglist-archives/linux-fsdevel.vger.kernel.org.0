Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFFE5151EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379681AbiD2RaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379546AbiD2R3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37268985B6
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ACrrQU8hDoFkSs7Skuwk/HVCT6svdmLE6NpycilctPs=; b=UAB41RWrYQsgAoe6GofjVQ46vU
        5zMDjpcMnICYKxcce/ekDk3y47+wQdri5KS6OfOUI4lGJ61tQwTWabANs75NQX1lwyXTW434n5tSr
        ntHplMe+lh6ZAnMZpr706usrcplYz7sQ8b1hknV1SeWSBMbj2rW3JwjUgb3eGk8h6+Skquvn8G/r2
        JfdRbPPZH8yTMw6obRRbZzTXR31kd+egJDfatmYAjov5nx5EI/6BDc0G2JC1bpuIxY4s0V/W0qVWX
        hcQpK91qA97yDGmuLcpnafzUUm1TWh+NyWaCRpYV/NlCXv2OMKrnDX7Xi612pHw649QVxijtvAzZq
        fGPLLBMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNa-00CdZs-6E; Fri, 29 Apr 2022 17:26:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 33/69] fs: Introduce aops->read_folio
Date:   Fri, 29 Apr 2022 18:25:20 +0100
Message-Id: <20220429172556.3011843-34-willy@infradead.org>
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

The ->readpage and ->read_folio operations are always called with the
same set of bits; it's only the type which differs.  Use a union to
help with the transition and convert all the callers to use ->read_folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c        |  2 +-
 include/linux/fs.h |  5 ++++-
 mm/filemap.c       |  6 +++---
 mm/readahead.c     | 10 +++++-----
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9737e0dbe3ec..5826ef29fe70 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2824,7 +2824,7 @@ int nobh_truncate_page(struct address_space *mapping,
 
 	/* Ok, it's mapped. Make sure it's up-to-date */
 	if (!folio_test_uptodate(folio)) {
-		err = mapping->a_ops->readpage(NULL, &folio->page);
+		err = mapping->a_ops->read_folio(NULL, folio);
 		if (err) {
 			folio_put(folio);
 			goto out;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2be852661a29..5ecc4b74204d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -335,7 +335,10 @@ static inline bool is_sync_kiocb(struct kiocb *kiocb)
 
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
-	int (*readpage)(struct file *, struct page *);
+	union {
+		int (*readpage)(struct file *, struct page *);
+		int (*read_folio)(struct file *, struct folio *);
+	};
 
 	/* Write back some dirty pages from this mapping. */
 	int (*writepages)(struct address_space *, struct writeback_control *);
diff --git a/mm/filemap.c b/mm/filemap.c
index c15cfc28f9ce..132015e42384 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2419,7 +2419,7 @@ static int filemap_read_folio(struct file *file, struct address_space *mapping,
 	 */
 	folio_clear_error(folio);
 	/* Start the actual read. The read will unlock the page. */
-	error = mapping->a_ops->readpage(file, &folio->page);
+	error = mapping->a_ops->read_folio(file, folio);
 	if (error)
 		return error;
 
@@ -3447,7 +3447,7 @@ int generic_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct address_space *mapping = file->f_mapping;
 
-	if (!mapping->a_ops->readpage)
+	if (!mapping->a_ops->read_folio)
 		return -ENOEXEC;
 	file_accessed(file);
 	vma->vm_ops = &generic_file_vm_ops;
@@ -3506,7 +3506,7 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 		if (filler)
 			err = filler(data, &folio->page);
 		else
-			err = mapping->a_ops->readpage(data, &folio->page);
+			err = mapping->a_ops->read_folio(data, folio);
 
 		if (err < 0) {
 			folio_put(folio);
diff --git a/mm/readahead.c b/mm/readahead.c
index 947a7a1fd867..2004aa58ae24 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -15,7 +15,7 @@
  * explicitly requested by the application.  Readahead only ever
  * attempts to read folios that are not yet in the page cache.  If a
  * folio is present but not up-to-date, readahead will not try to read
- * it. In that case a simple ->readpage() will be requested.
+ * it. In that case a simple ->read_folio() will be requested.
  *
  * Readahead is triggered when an application read request (whether a
  * system call or a page fault) finds that the requested folio is not in
@@ -78,7 +78,7 @@
  * address space operation, for which mpage_readahead() is a canonical
  * implementation.  ->readahead() should normally initiate reads on all
  * folios, but may fail to read any or all folios without causing an I/O
- * error.  The page cache reading code will issue a ->readpage() request
+ * error.  The page cache reading code will issue a ->read_folio() request
  * for any folio which ->readahead() did not read, and only an error
  * from this will be final.
  *
@@ -110,7 +110,7 @@
  * were not fetched with readahead_folio().  This will allow a
  * subsequent synchronous readahead request to try them again.  If they
  * are left in the page cache, then they will be read individually using
- * ->readpage() which may be less efficient.
+ * ->read_folio() which may be less efficient.
  */
 
 #include <linux/kernel.h>
@@ -172,7 +172,7 @@ static void read_pages(struct readahead_control *rac)
 		}
 	} else {
 		while ((folio = readahead_folio(rac)))
-			aops->readpage(rac->file, &folio->page);
+			aops->read_folio(rac->file, folio);
 	}
 
 	blk_finish_plug(&plug);
@@ -302,7 +302,7 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	unsigned long max_pages, index;
 
-	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readahead))
+	if (unlikely(!mapping->a_ops->read_folio && !mapping->a_ops->readahead))
 		return;
 
 	/*
-- 
2.34.1

