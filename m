Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5981F5CCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgFJUQd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbgFJUNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71236C008630;
        Wed, 10 Jun 2020 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=uGAtnGn+n3Jc24Na5BRkCaH/Nj1ojalZsrf8LfvpEMU=; b=f5bKWcgHXW6o+ZzSODjgwHECEx
        kwYqPQcdX6oIPqpA9AwddVLy3KemXyT6U7H9Eg2T6tgrdQzfYt3ELn//qswyYA2t2iLPZoZ0JRwf8
        T9/6oztx0bbqmdTxt6LAimS9X662A3SjVQg2hFdPOYkuo1LX7BtqF9KgZuA80RH7LUcGgox7apGtd
        kcaKvJk1QqL7Ezopq+nxRFQV0ZVS2wQhQf7NOzwIll2N//HVWD74aUcfMCijB8UBy8GzeJDYBMTn9
        mssXAS0c4e36NoolqwB9ARdAE+g3dA4mwF9lOd6KStg0UlMy1Gi7w2g14uIx27Njlyk4Q++SGt8ol
        NWZKkKIA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76a-0003Vo-AB; Wed, 10 Jun 2020 20:13:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 27/51] iomap: Change calling convention for zeroing
Date:   Wed, 10 Jun 2020 13:13:21 -0700
Message-Id: <20200610201345.13273-28-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Pass the full length to iomap_zero() and dax_iomap_zero(), then have
them return how many bytes they actually handled.  This is prepatory
work for handling THP, although it looks like DAX could actually take
advantage of it if there's a larger contiguous area.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/dax.c               | 13 ++++++-------
 fs/iomap/buffered-io.c | 33 +++++++++++++++------------------
 include/linux/dax.h    |  3 +--
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 11b16729b86f..18e9b5f0dedf 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1038,18 +1038,18 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
 	return ret;
 }
 
-int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
-		   struct iomap *iomap)
+ssize_t dax_iomap_zero(loff_t pos, loff_t length, struct iomap *iomap)
 {
 	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
 	pgoff_t pgoff;
 	long rc, id;
 	void *kaddr;
 	bool page_aligned = false;
-
+	unsigned offset = offset_in_page(pos);
+	unsigned size = min_t(loff_t, PAGE_SIZE - offset, length);
 
 	if (IS_ALIGNED(sector << SECTOR_SHIFT, PAGE_SIZE) &&
-	    IS_ALIGNED(size, PAGE_SIZE))
+	    (size == PAGE_SIZE))
 		page_aligned = true;
 
 	rc = bdev_dax_pgoff(iomap->bdev, sector, PAGE_SIZE, &pgoff);
@@ -1059,8 +1059,7 @@ int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
 	id = dax_read_lock();
 
 	if (page_aligned)
-		rc = dax_zero_page_range(iomap->dax_dev, pgoff,
-					 size >> PAGE_SHIFT);
+		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
 	else
 		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
 	if (rc < 0) {
@@ -1073,7 +1072,7 @@ int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
 		dax_flush(iomap->dax_dev, kaddr + offset, size);
 	}
 	dax_read_unlock(id);
-	return 0;
+	return size;
 }
 
 static loff_t
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fffdf5906e99..8d690ad68657 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -928,11 +928,13 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 }
 EXPORT_SYMBOL_GPL(iomap_file_unshare);
 
-static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
-		unsigned bytes, struct iomap *iomap, struct iomap *srcmap)
+static ssize_t iomap_zero(struct inode *inode, loff_t pos, loff_t length,
+		struct iomap *iomap, struct iomap *srcmap)
 {
 	struct page *page;
 	int status;
+	unsigned offset = offset_in_page(pos);
+	unsigned bytes = min_t(loff_t, PAGE_SIZE - offset, length);
 
 	status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap, srcmap);
 	if (status)
@@ -944,38 +946,33 @@ static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
 	return iomap_write_end(inode, pos, bytes, bytes, page, iomap, srcmap);
 }
 
-static loff_t
-iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+static loff_t iomap_zero_range_actor(struct inode *inode, loff_t pos,
+		loff_t length, void *data, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	bool *did_zero = data;
 	loff_t written = 0;
-	int status;
 
 	/* already zeroed?  we're done. */
 	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
-		return count;
+		return length;
 
 	do {
-		unsigned offset, bytes;
-
-		offset = offset_in_page(pos);
-		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
+		ssize_t bytes;
 
 		if (IS_DAX(inode))
-			status = dax_iomap_zero(pos, offset, bytes, iomap);
+			bytes = dax_iomap_zero(pos, length, iomap);
 		else
-			status = iomap_zero(inode, pos, offset, bytes, iomap,
-					srcmap);
-		if (status < 0)
-			return status;
+			bytes = iomap_zero(inode, pos, length, iomap, srcmap);
+		if (bytes < 0)
+			return bytes;
 
 		pos += bytes;
-		count -= bytes;
+		length -= bytes;
 		written += bytes;
 		if (did_zero)
 			*did_zero = true;
-	} while (count > 0);
+	} while (length > 0);
 
 	return written;
 }
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 6904d4e0b2e0..0ba618aeec98 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -214,8 +214,7 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
-int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
-			struct iomap *iomap);
+ssize_t dax_iomap_zero(loff_t pos, loff_t length, struct iomap *iomap);
 static inline bool dax_mapping(struct address_space *mapping)
 {
 	return mapping->host && IS_DAX(mapping->host);
-- 
2.26.2

