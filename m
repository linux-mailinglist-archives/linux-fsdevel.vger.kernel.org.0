Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EFE44A8DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244239AbhKIIgl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244178AbhKIIgf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:36:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC0FC061205;
        Tue,  9 Nov 2021 00:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mfMDb5n97/RHD98fzJck6QJCWRVIOtc8ifMZjDMd/kQ=; b=Jeyxv3tsyyzZnJxRVCO2TB86Ws
        w+QW/DSGu6mPXAbKWCOMHiAmNN5rK3FhaDN94URftiwooYE6Kz+gz8a1HfSlssB02QBDy9aJwX46c
        NDXerTZam1l2Ml3fw83VloMPreSlSXJm/jzRom9zjYEnt43pMde3L43bArtupfVvuk4O+f8AQph7l
        Kj3jYG42Lvn+DXbfwPw5jj3lpKQh72Cd06FD0JbEYC1NX2yES5mwAwZHyF2oVjSOtBAbNtBoXMeDR
        vbug0yVOpp8HDFIdvP9bfctKCkHC9LPNUxlsH4CvmgS1IONxvcj5qU2yhGCBnm1dXQO4vmrrrzMZ9
        YK5BQzmw==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMZd-000s62-5h; Tue, 09 Nov 2021 08:33:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 18/29] fsdax: decouple zeroing from the iomap buffered I/O code
Date:   Tue,  9 Nov 2021 09:32:58 +0100
Message-Id: <20211109083309.584081-19-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109083309.584081-1-hch@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unshare the DAX and iomap buffered I/O page zeroing code.  This code
previously did a IS_DAX check deep inside the iomap code, which in
fact was the only DAX check in the code.  Instead move these checks
into the callers.  Most callers already have DAX special casing anyway
and XFS will need it for reflink support as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/dax.c               | 77 ++++++++++++++++++++++++++++++++++--------
 fs/ext2/inode.c        |  6 ++--
 fs/ext4/inode.c        |  4 +--
 fs/iomap/buffered-io.c | 35 +++++++------------
 fs/xfs/xfs_iomap.c     |  6 ++++
 include/linux/dax.h    |  6 +++-
 6 files changed, 91 insertions(+), 43 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index dc9ebeff850ab..5b52b878124ac 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1135,24 +1135,73 @@ static int dax_memzero(struct dax_device *dax_dev, pgoff_t pgoff,
 	return rc;
 }
 
-s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
+static loff_t dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
-	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
-	long rc, id;
-	unsigned offset = offset_in_page(pos);
-	unsigned size = min_t(u64, PAGE_SIZE - offset, length);
+	const struct iomap *iomap = &iter->iomap;
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
+	loff_t pos = iter->pos;
+	loff_t length = iomap_length(iter);
+	loff_t written = 0;
+
+	/* already zeroed?  we're done. */
+	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
+		return length;
+
+	do {
+		unsigned offset = offset_in_page(pos);
+		unsigned size = min_t(u64, PAGE_SIZE - offset, length);
+		pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
+		long rc;
+		int id;
 
-	id = dax_read_lock();
-	if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
-		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
-	else
-		rc = dax_memzero(iomap->dax_dev, pgoff, offset, size);
-	dax_read_unlock(id);
+		id = dax_read_lock();
+		if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
+			rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
+		else
+			rc = dax_memzero(iomap->dax_dev, pgoff, offset, size);
+		dax_read_unlock(id);
 
-	if (rc < 0)
-		return rc;
-	return size;
+		if (rc < 0)
+			return rc;
+		pos += size;
+		length -= size;
+		written += size;
+		if (did_zero)
+			*did_zero = true;
+	} while (length > 0);
+
+	return written;
+}
+
+int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
+		const struct iomap_ops *ops)
+{
+	struct iomap_iter iter = {
+		.inode		= inode,
+		.pos		= pos,
+		.len		= len,
+		.flags		= IOMAP_ZERO,
+	};
+	int ret;
+
+	while ((ret = iomap_iter(&iter, ops)) > 0)
+		iter.processed = dax_zero_iter(&iter, did_zero);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dax_zero_range);
+
+int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
+		const struct iomap_ops *ops)
+{
+	unsigned int blocksize = i_blocksize(inode);
+	unsigned int off = pos & (blocksize - 1);
+
+	/* Block boundary? Nothing to do */
+	if (!off)
+		return 0;
+	return dax_zero_range(inode, pos, blocksize - off, did_zero, ops);
 }
+EXPORT_SYMBOL_GPL(dax_truncate_page);
 
 static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		struct iov_iter *iter)
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 333fa62661d56..ae9993018a015 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1297,9 +1297,9 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
 	inode_dio_wait(inode);
 
 	if (IS_DAX(inode)) {
-		error = iomap_zero_range(inode, newsize,
-					 PAGE_ALIGN(newsize) - newsize, NULL,
-					 &ext2_iomap_ops);
+		error = dax_zero_range(inode, newsize,
+				       PAGE_ALIGN(newsize) - newsize, NULL,
+				       &ext2_iomap_ops);
 	} else if (test_opt(inode->i_sb, NOBH))
 		error = nobh_truncate_page(inode->i_mapping,
 				newsize, ext2_get_block);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0f06305167d5a..8c443b753b815 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3783,8 +3783,8 @@ static int ext4_block_zero_page_range(handle_t *handle,
 		length = max;
 
 	if (IS_DAX(inode)) {
-		return iomap_zero_range(inode, from, length, NULL,
-					&ext4_iomap_ops);
+		return dax_zero_range(inode, from, length, NULL,
+				      &ext4_iomap_ops);
 	}
 	return __ext4_block_zero_page_range(handle, mapping, from, length);
 }
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1753c26c8e76e..b1511255b4df8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -870,26 +870,8 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 }
 EXPORT_SYMBOL_GPL(iomap_file_unshare);
 
-static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
-{
-	struct page *page;
-	int status;
-	unsigned offset = offset_in_page(pos);
-	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
-
-	status = iomap_write_begin(iter, pos, bytes, &page);
-	if (status)
-		return status;
-
-	zero_user(page, offset, bytes);
-	mark_page_accessed(page);
-
-	return iomap_write_end(iter, pos, bytes, bytes, page);
-}
-
 static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
-	struct iomap *iomap = &iter->iomap;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
@@ -900,12 +882,19 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		return length;
 
 	do {
-		s64 bytes;
+		unsigned offset = offset_in_page(pos);
+		size_t bytes = min_t(u64, PAGE_SIZE - offset, length);
+		struct page *page;
+		int status;
 
-		if (IS_DAX(iter->inode))
-			bytes = dax_iomap_zero(pos, length, iomap);
-		else
-			bytes = __iomap_zero_iter(iter, pos, length);
+		status = iomap_write_begin(iter, pos, bytes, &page);
+		if (status)
+			return status;
+
+		zero_user(page, offset, bytes);
+		mark_page_accessed(page);
+
+		bytes = iomap_write_end(iter, pos, bytes, bytes, page);
 		if (bytes < 0)
 			return bytes;
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index d6d71ae9f2ae4..604000b6243ec 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1321,6 +1321,9 @@ xfs_zero_range(
 {
 	struct inode		*inode = VFS_I(ip);
 
+	if (IS_DAX(inode))
+		return dax_zero_range(inode, pos, len, did_zero,
+				      &xfs_buffered_write_iomap_ops);
 	return iomap_zero_range(inode, pos, len, did_zero,
 				&xfs_buffered_write_iomap_ops);
 }
@@ -1333,6 +1336,9 @@ xfs_truncate_page(
 {
 	struct inode		*inode = VFS_I(ip);
 
+	if (IS_DAX(inode))
+		return dax_truncate_page(inode, pos, did_zero,
+					&xfs_buffered_write_iomap_ops);
 	return iomap_truncate_page(inode, pos, did_zero,
 				   &xfs_buffered_write_iomap_ops);
 }
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 324363b798ecd..a5cc2f1aa840e 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -14,6 +14,7 @@ typedef unsigned long dax_entry_t;
 struct dax_device;
 struct gendisk;
 struct iomap_ops;
+struct iomap_iter;
 struct iomap;
 
 struct dax_operations {
@@ -124,6 +125,10 @@ struct page *dax_layout_busy_page(struct address_space *mapping);
 struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
 dax_entry_t dax_lock_page(struct page *page);
 void dax_unlock_page(struct page *page, dax_entry_t cookie);
+int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
+		const struct iomap_ops *ops);
+int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
+		const struct iomap_ops *ops);
 #else
 static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
 {
@@ -204,7 +209,6 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
-s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap);
 static inline bool dax_mapping(struct address_space *mapping)
 {
 	return mapping->host && IS_DAX(mapping->host);
-- 
2.30.2

