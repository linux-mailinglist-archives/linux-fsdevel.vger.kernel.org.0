Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D41D36987
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 03:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfFFBpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 21:45:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:36145 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfFFBpU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 21:45:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 18:45:19 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 05 Jun 2019 18:45:18 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>, Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH RFC 06/10] fs/ext4: Teach dax_layout_busy_page() to operate on a sub-range
Date:   Wed,  5 Jun 2019 18:45:39 -0700
Message-Id: <20190606014544.8339-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606014544.8339-1-ira.weiny@intel.com>
References: <20190606014544.8339-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Callers of dax_layout_busy_page() are only rarely operating on the
entire file of concern.

Teach dax_layout_busy_page() to operate on a sub-range of the
address_space provided.  Specifying 0 - ULONG_MAX however, will continue
to operate on the "entire file" and XFS is split out to a separate patch
by this method.

This could potentially speed up dax_layout_busy_page() as well.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/dax.c            | 15 +++++++++++----
 fs/ext4/ext4.h      |  2 +-
 fs/ext4/extents.c   |  6 +++---
 fs/ext4/inode.c     | 19 ++++++++++++-------
 fs/xfs/xfs_file.c   |  3 ++-
 include/linux/dax.h |  3 ++-
 6 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 29ff3b683657..abd77b184879 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -568,8 +568,11 @@ bool dax_mapping_is_dax(struct address_space *mapping)
 EXPORT_SYMBOL_GPL(dax_mapping_is_dax);
 
 /**
- * dax_layout_busy_page - find first pinned page in @mapping
+ * dax_layout_busy_page - find first pinned page in @mapping within
+ *                        the range @off - @off + @len
  * @mapping: address space to scan for a page with ref count > 1
+ * @off: offset to start at
+ * @len: length to scan through
  *
  * DAX requires ZONE_DEVICE mapped pages. These pages are never
  * 'onlined' to the page allocator so they are considered idle when
@@ -582,9 +585,13 @@ EXPORT_SYMBOL_GPL(dax_mapping_is_dax);
  * to be able to run unmap_mapping_range() and subsequently not race
  * mapping_mapped() becoming true.
  */
-struct page *dax_layout_busy_page(struct address_space *mapping)
+struct page *dax_layout_busy_page(struct address_space *mapping,
+				  loff_t off, loff_t len)
 {
-	XA_STATE(xas, &mapping->i_pages, 0);
+	unsigned long start_idx = off >> PAGE_SHIFT;
+	unsigned long end_idx = (len == ULONG_MAX) ? ULONG_MAX
+				: start_idx + (len >> PAGE_SHIFT);
+	XA_STATE(xas, &mapping->i_pages, start_idx);
 	void *entry;
 	unsigned int scanned = 0;
 	struct page *page = NULL;
@@ -607,7 +614,7 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 	unmap_mapping_range(mapping, 0, 0, 1);
 
 	xas_lock_irq(&xas);
-	xas_for_each(&xas, entry, ULONG_MAX) {
+	xas_for_each(&xas, entry, end_idx) {
 		if (WARN_ON_ONCE(!xa_is_value(entry)))
 			continue;
 		if (unlikely(dax_is_locked(entry)))
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1cb67859e051..ba5920c21023 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2530,7 +2530,7 @@ extern int ext4_get_inode_loc(struct inode *, struct ext4_iloc *);
 extern int ext4_inode_attach_jinode(struct inode *inode);
 extern int ext4_can_truncate(struct inode *inode);
 extern int ext4_truncate(struct inode *);
-extern int ext4_break_layouts(struct inode *);
+extern int ext4_break_layouts(struct inode *inode, loff_t offset, loff_t len);
 extern int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length);
 extern int ext4_truncate_restart_trans(handle_t *, struct inode *, int nblocks);
 extern void ext4_set_inode_flags(struct inode *);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index d40ed940001e..9ddb117d8beb 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4736,7 +4736,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		 */
 		down_write(&EXT4_I(inode)->i_mmap_sem);
 
-		ret = ext4_break_layouts(inode);
+		ret = ext4_break_layouts(inode, offset, len);
 		if (ret) {
 			up_write(&EXT4_I(inode)->i_mmap_sem);
 			goto out_mutex;
@@ -5419,7 +5419,7 @@ int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	 */
 	down_write(&EXT4_I(inode)->i_mmap_sem);
 
-	ret = ext4_break_layouts(inode);
+	ret = ext4_break_layouts(inode, offset, len);
 	if (ret)
 		goto out_mmap;
 
@@ -5572,7 +5572,7 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	 */
 	down_write(&EXT4_I(inode)->i_mmap_sem);
 
-	ret = ext4_break_layouts(inode);
+	ret = ext4_break_layouts(inode, offset, len);
 	if (ret)
 		goto out_mmap;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c7c99f51961f..75f543f384e4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4232,7 +4232,7 @@ static void ext4_wait_dax_page(struct ext4_inode_info *ei)
 	down_write(&ei->i_mmap_sem);
 }
 
-int ext4_break_layouts(struct inode *inode)
+int ext4_break_layouts(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct page *page;
@@ -4246,7 +4246,7 @@ int ext4_break_layouts(struct inode *inode)
 		break_layout(inode, true);
 
 	do {
-		page = dax_layout_busy_page(inode->i_mapping);
+		page = dax_layout_busy_page(inode->i_mapping, offset, len);
 		if (!page)
 			return 0;
 
@@ -4333,7 +4333,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 	 */
 	down_write(&EXT4_I(inode)->i_mmap_sem);
 
-	ret = ext4_break_layouts(inode);
+	ret = ext4_break_layouts(inode, offset, length);
 	if (ret)
 		goto out_dio;
 
@@ -5605,10 +5605,15 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 
 		down_write(&EXT4_I(inode)->i_mmap_sem);
 
-		rc = ext4_break_layouts(inode);
-		if (rc) {
-			up_write(&EXT4_I(inode)->i_mmap_sem);
-			return rc;
+		if (shrink) {
+			loff_t off = attr->ia_size;
+			loff_t len = inode->i_size - attr->ia_size;
+
+			rc = ext4_break_layouts(inode, off, len);
+			if (rc) {
+				up_write(&EXT4_I(inode)->i_mmap_sem);
+				return rc;
+			}
 		}
 
 		if (attr->ia_size != inode->i_size) {
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 76748255f843..ebddf911644c 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -746,7 +746,8 @@ xfs_break_dax_layouts(
 
 	ASSERT(xfs_isilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL));
 
-	page = dax_layout_busy_page(inode->i_mapping);
+	/* We default to the "whole file" */
+	page = dax_layout_busy_page(inode->i_mapping, 0, ULONG_MAX);
 	if (!page)
 		return 0;
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index ee6cbd56ddc4..3c3ab8dd76c6 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -107,7 +107,8 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 		struct block_device *bdev, struct writeback_control *wbc);
 
 bool dax_mapping_is_dax(struct address_space *mapping);
-struct page *dax_layout_busy_page(struct address_space *mapping);
+struct page *dax_layout_busy_page(struct address_space *mapping,
+				  loff_t off, loff_t len);
 dax_entry_t dax_lock_page(struct page *page);
 void dax_unlock_page(struct page *page, dax_entry_t cookie);
 #else
-- 
2.20.1

