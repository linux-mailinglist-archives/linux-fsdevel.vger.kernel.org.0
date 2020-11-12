Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493DD2B1050
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 22:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgKLV1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 16:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbgKLV1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:27:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE5DC0613D1;
        Thu, 12 Nov 2020 13:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=adf3HaAGq3GYSYScBgfrGImWJpmiJMbnVTcYKwTbD/g=; b=DjSUCPuPtO63YmeC25BzRezanj
        p34lGa1kjErYiI7HZAZ+rMUDmRDGm4SY3OitbXv6N4ePjRWsjMLnBjXGozzU2qt3mLuquHsJCV/2c
        kH+/3QvTENN9IXRCnYS4/8ht0+ySf/RAC2eNAzdq8qFbTmu4r8UktfVtT0yBlDu2UUS+iDe3bnHMY
        NrRxt1Fv2ujNUNMXtTFdwWhrR+sIXpixOk9fMF8y4DdrD7OFh9Hry12iofIXK4D/2nqJuA/pU3Lyw
        kkaP0Gj8WVq+/Bo5eEjv/i2cx0XHJl766fqreFvaEIAAx+URtpabb2LOJQHc2MslcbbFB2+tpzmJo
        oi3NFk8g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdK7C-0007GZ-3g; Thu, 12 Nov 2020 21:26:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v4 07/16] mm/filemap: Add mapping_seek_hole_data
Date:   Thu, 12 Nov 2020 21:26:32 +0000
Message-Id: <20201112212641.27837-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201112212641.27837-1-willy@infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rewrite shmem_seek_hole_data() and move it to filemap.c.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 75 +++++++++++++++++++++++++++++++++++++++++
 mm/shmem.c              | 74 +++-------------------------------------
 3 files changed, 81 insertions(+), 70 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 55e1bff1c4b9..9f1f4ab9612a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -759,6 +759,8 @@ extern void __delete_from_page_cache(struct page *page, void *shadow);
 int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask);
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct pagevec *pvec);
+loff_t mapping_seek_hole_data(struct address_space *, loff_t start, loff_t end,
+		int whence);
 
 /*
  * Like add_to_page_cache_locked, but used to add newly allocated pages:
diff --git a/mm/filemap.c b/mm/filemap.c
index e0d9cfa2ae90..ab7103eb7e11 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2586,6 +2586,81 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 }
 EXPORT_SYMBOL(generic_file_read_iter);
 
+static inline bool page_seek_match(struct page *page, bool seek_data)
+{
+	if (xa_is_value(page) || PageUptodate(page))
+		return seek_data;
+	return !seek_data;
+}
+
+static inline
+unsigned int seek_page_size(struct xa_state *xas, struct page *page)
+{
+	if (xa_is_value(page))
+		return PAGE_SIZE << xa_get_order(xas->xa, xas->xa_index);
+	return thp_size(page);
+}
+
+/**
+ * mapping_seek_hole_data - Seek for SEEK_DATA / SEEK_HOLE in the page cache.
+ * @mapping: Address space to search.
+ * @start: First byte to consider.
+ * @end: Limit of search (exclusive).
+ * @whence: Either SEEK_HOLE or SEEK_DATA.
+ *
+ * If the page cache knows which blocks contain holes and which blocks
+ * contain data, your filesystem can use this function to implement
+ * SEEK_HOLE and SEEK_DATA.  This is useful for filesystems which are
+ * entirely memory-based such as tmpfs, and filesystems which support
+ * unwritten extents.
+ *
+ * Return: The requested offset on successs, or -ENXIO if @whence specifies
+ * SEEK_DATA and there is no data after @start.  There is an implicit hole
+ * after @end - 1, so SEEK_HOLE returns @end if all the bytes between @start
+ * and @end contain data.
+ */
+loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
+		loff_t end, int whence)
+{
+	XA_STATE(xas, &mapping->i_pages, start >> PAGE_SHIFT);
+	pgoff_t max = (end - 1) / PAGE_SIZE;
+	bool seek_data = (whence == SEEK_DATA);
+	struct page *page;
+
+	if (end <= start)
+		return -ENXIO;
+
+	rcu_read_lock();
+	while ((page = find_get_entry(&xas, max, XA_PRESENT))) {
+		loff_t pos = xas.xa_index * PAGE_SIZE;
+
+		if (start < pos) {
+			if (!seek_data)
+				goto unlock;
+			start = pos;
+		}
+
+		if (page_seek_match(page, seek_data))
+			goto unlock;
+		start = pos + seek_page_size(&xas, page);
+		put_page(page);
+	}
+	rcu_read_unlock();
+
+	if (seek_data)
+		return -ENXIO;
+	goto out;
+
+unlock:
+	rcu_read_unlock();
+	if (!xa_is_value(page))
+		put_page(page);
+out:
+	if (start > end)
+		return end;
+	return start;
+}
+
 #ifdef CONFIG_MMU
 #define MMAP_LOTSAMISS  (100)
 /*
diff --git a/mm/shmem.c b/mm/shmem.c
index c4feb05425f2..6afea99a0dc0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2694,86 +2694,20 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return retval ? retval : error;
 }
 
-/*
- * llseek SEEK_DATA or SEEK_HOLE through the page cache.
- */
-static pgoff_t shmem_seek_hole_data(struct address_space *mapping,
-				    pgoff_t index, pgoff_t end, int whence)
-{
-	struct page *page;
-	struct pagevec pvec;
-	pgoff_t indices[PAGEVEC_SIZE];
-	bool done = false;
-	int i;
-
-	pagevec_init(&pvec);
-	pvec.nr = 1;		/* start small: we may be there already */
-	while (!done) {
-		pvec.nr = find_get_entries(mapping, index,
-					pvec.nr, pvec.pages, indices);
-		if (!pvec.nr) {
-			if (whence == SEEK_DATA)
-				index = end;
-			break;
-		}
-		for (i = 0; i < pvec.nr; i++, index++) {
-			if (index < indices[i]) {
-				if (whence == SEEK_HOLE) {
-					done = true;
-					break;
-				}
-				index = indices[i];
-			}
-			page = pvec.pages[i];
-			if (page && !xa_is_value(page)) {
-				if (!PageUptodate(page))
-					page = NULL;
-			}
-			if (index >= end ||
-			    (page && whence == SEEK_DATA) ||
-			    (!page && whence == SEEK_HOLE)) {
-				done = true;
-				break;
-			}
-		}
-		pagevec_remove_exceptionals(&pvec);
-		pagevec_release(&pvec);
-		pvec.nr = PAGEVEC_SIZE;
-		cond_resched();
-	}
-	return index;
-}
-
 static loff_t shmem_file_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
-	pgoff_t start, end;
-	loff_t new_offset;
 
 	if (whence != SEEK_DATA && whence != SEEK_HOLE)
 		return generic_file_llseek_size(file, offset, whence,
 					MAX_LFS_FILESIZE, i_size_read(inode));
+	if (offset < 0)
+		return -ENXIO;
+
 	inode_lock(inode);
 	/* We're holding i_mutex so we can access i_size directly */
-
-	if (offset < 0 || offset >= inode->i_size)
-		offset = -ENXIO;
-	else {
-		start = offset >> PAGE_SHIFT;
-		end = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
-		new_offset = shmem_seek_hole_data(mapping, start, end, whence);
-		new_offset <<= PAGE_SHIFT;
-		if (new_offset > offset) {
-			if (new_offset < inode->i_size)
-				offset = new_offset;
-			else if (whence == SEEK_DATA)
-				offset = -ENXIO;
-			else
-				offset = inode->i_size;
-		}
-	}
-
+	offset = mapping_seek_hole_data(mapping, offset, inode->i_size, whence);
 	if (offset >= 0)
 		offset = vfs_setpos(file, offset, MAX_LFS_FILESIZE);
 	inode_unlock(inode);
-- 
2.28.0

