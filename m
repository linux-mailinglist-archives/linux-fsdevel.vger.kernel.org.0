Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4316C25007B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 17:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgHXPKI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 11:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgHXPIh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:08:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5993AC061798;
        Mon, 24 Aug 2020 07:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wD3WKtFt1cnznRgdSUY1WyUqGEQPEbuG+Sb3tBG4EoM=; b=l/Qk/h0H2fjqi6K2zYdHPAKr12
        d6PzknXLBGxZ/gT7/Eu1anApPwE6pY3qW4VqmbGLIBj6NQ6X931vhSuTyFR+idWNrg98/skHqAlQm
        GDLGfyFw0//Eka3eMNkkdR0yVgNhf0MZqMekWfiAwzg2WUnPKM/VYKHOQ2V7e5tMwXlqrWQ5vynvl
        Yl01RbK/AIX5fm8VwjQn3QWFdM9hiW72ZMzaAv4HhyBuYt0S86OiRYNRlTNXws7j/RWoQAXCA8Tsj
        anISLBlS6GUBVN1zFkZmQsh9fl1jv3WLZRz6piJFC3e/mxW3Ig5F9vbXRMj/187Cgw8j8z8+quAWD
        +neMTvag==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kADsR-0002mn-NG; Mon, 24 Aug 2020 14:55:15 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] iomap: Change calling convention for zeroing
Date:   Mon, 24 Aug 2020 15:55:10 +0100
Message-Id: <20200824145511.10500-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200824145511.10500-1-willy@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass the full length to iomap_zero() and dax_iomap_zero(), and have
them return how many bytes they actually handled.  This is preparatory
work for handling THP, although it looks like DAX could actually take
advantage of it if there's a larger contiguous area.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/dax.c               | 13 ++++++-------
 fs/iomap/buffered-io.c | 33 +++++++++++++++------------------
 include/linux/dax.h    |  3 +--
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 95341af1a966..f2b912cb034e 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1037,18 +1037,18 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
 	return ret;
 }
 
-int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
-		   struct iomap *iomap)
+loff_t dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 {
 	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
 	pgoff_t pgoff;
 	long rc, id;
 	void *kaddr;
 	bool page_aligned = false;
-
+	unsigned offset = offset_in_page(pos);
+	unsigned size = min_t(u64, PAGE_SIZE - offset, length);
 
 	if (IS_ALIGNED(sector << SECTOR_SHIFT, PAGE_SIZE) &&
-	    IS_ALIGNED(size, PAGE_SIZE))
+	    (size == PAGE_SIZE))
 		page_aligned = true;
 
 	rc = bdev_dax_pgoff(iomap->bdev, sector, PAGE_SIZE, &pgoff);
@@ -1058,8 +1058,7 @@ int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
 	id = dax_read_lock();
 
 	if (page_aligned)
-		rc = dax_zero_page_range(iomap->dax_dev, pgoff,
-					 size >> PAGE_SHIFT);
+		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
 	else
 		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
 	if (rc < 0) {
@@ -1072,7 +1071,7 @@ int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
 		dax_flush(iomap->dax_dev, kaddr + offset, size);
 	}
 	dax_read_unlock(id);
-	return 0;
+	return size;
 }
 
 static loff_t
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7f618ab4b11e..2dba054095e8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -901,11 +901,13 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 }
 EXPORT_SYMBOL_GPL(iomap_file_unshare);
 
-static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
-		unsigned bytes, struct iomap *iomap, struct iomap *srcmap)
+static loff_t iomap_zero(struct inode *inode, loff_t pos, u64 length,
+		struct iomap *iomap, struct iomap *srcmap)
 {
 	struct page *page;
 	int status;
+	unsigned offset = offset_in_page(pos);
+	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
 
 	status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap, srcmap);
 	if (status)
@@ -917,38 +919,33 @@ static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
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
+		loff_t bytes;
 
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
index 6904d4e0b2e0..80f17946f940 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -214,8 +214,7 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
-int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
-			struct iomap *iomap);
+loff_t dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap);
 static inline bool dax_mapping(struct address_space *mapping)
 {
 	return mapping->host && IS_DAX(mapping->host);
-- 
2.28.0

