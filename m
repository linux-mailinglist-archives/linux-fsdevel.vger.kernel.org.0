Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8761B9AB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 10:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgD0Isq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 04:48:46 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:3151 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726842AbgD0Isq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:48:46 -0400
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; 
   d="scan'208";a="90547663"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Apr 2020 16:48:38 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id AB4104BCC88F;
        Mon, 27 Apr 2020 16:37:55 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 27 Apr 2020 16:48:38 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 27 Apr 2020 16:48:37 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>,
        <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 6/8] fs/dax: dedup file range to use a compare function
Date:   Mon, 27 Apr 2020 16:47:48 +0800
Message-ID: <20200427084750.136031-7-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: AB4104BCC88F.A0635
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With dax we cannot deal with readpage() etc. So, we create a
funciton callback to perform the file data comparison and pass
it to generic_remap_file_range_prep() so it can use iomap-based
functions.

This may not be the best way to solve this. Suggestions welcome.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/dax.c             | 60 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ocfs2/file.c      |  2 +-
 fs/read_write.c      | 11 ++++----
 fs/xfs/xfs_reflink.c |  2 +-
 include/linux/dax.h  |  5 ++++
 include/linux/fs.h   |  9 ++++++-
 6 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 12096edb2569..ab6be7749105 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -31,6 +31,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/fs_dax.h>
 
+#define MIN(a, b) (((a) < (b)) ? (a) : (b))
+
 static inline unsigned int pe_order(enum page_entry_size pe_size)
 {
 	if (pe_size == PE_SIZE_PTE)
@@ -1942,3 +1944,61 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 	return dax_insert_pfn_mkwrite(vmf, pfn, order);
 }
 EXPORT_SYMBOL_GPL(dax_finish_sync_fault);
+
+int dax_file_range_compare(struct inode *src, loff_t srcoff, struct inode *dest,
+		loff_t destoff, loff_t len, bool *is_same, const struct iomap_ops *ops)
+{
+	void *saddr, *daddr;
+	struct iomap s_iomap = {0};
+	struct iomap d_iomap = {0};
+	bool same = true;
+	loff_t cmp_len;
+	int id, ret = 0;
+
+	id = dax_read_lock();
+	while (len) {
+		ret = ops->iomap_begin(src, srcoff, len, 0, &s_iomap, NULL);
+		if (ret < 0)
+			goto out_src;
+		cmp_len = MIN(len, s_iomap.offset + s_iomap.length - srcoff);
+
+		ret = ops->iomap_begin(dest, destoff, cmp_len, 0, &d_iomap, NULL);
+		if (ret < 0)
+			goto out_dest;
+		cmp_len = MIN(cmp_len, d_iomap.offset + d_iomap.length - destoff);
+
+		ret = dax_iomap_direct_access(&s_iomap, srcoff,
+					      ALIGN(srcoff + cmp_len, PAGE_SIZE),
+					      NULL, &saddr);
+		if (ret < 0)
+			goto out_dest;
+
+		ret = dax_iomap_direct_access(&d_iomap, destoff,
+					      ALIGN(destoff + cmp_len, PAGE_SIZE),
+					      NULL, &daddr);
+		if (ret < 0)
+			goto out_dest;
+
+		same = !memcmp(saddr, daddr, cmp_len);
+		if (!same)
+			break;
+		len -= cmp_len;
+		srcoff += cmp_len;
+		destoff += cmp_len;
+out_dest:
+		if (ops->iomap_end)
+			ops->iomap_end(dest, destoff, len, 0, 0, &d_iomap);
+out_src:
+		if (ops->iomap_end)
+			ops->iomap_end(src, srcoff, len, 0, 0, &s_iomap);
+
+		if (ret < 0)
+			goto out;
+
+	}
+	*is_same = same;
+out:
+	dax_read_unlock(id);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dax_file_range_compare);
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 6cd5e4924e4d..6fa6e1ac6357 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2591,7 +2591,7 @@ static loff_t ocfs2_remap_file_range(struct file *file_in, loff_t pos_in,
 		goto out_unlock;
 
 	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
-			&len, remap_flags);
+			&len, remap_flags, vfs_dedupe_file_range_compare);
 	if (ret < 0 || len == 0)
 		goto out_unlock;
 
diff --git a/fs/read_write.c b/fs/read_write.c
index bbfa9b12b15e..e08875f35f10 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1908,7 +1908,7 @@ static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
  * Compare extents of two files to see if they are the same.
  * Caller must have locked both inodes to prevent write races.
  */
-static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
+int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 					 struct inode *dest, loff_t destoff,
 					 loff_t len, bool *is_same)
 {
@@ -1989,6 +1989,7 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 out_error:
 	return error;
 }
+EXPORT_SYMBOL_GPL(vfs_dedupe_file_range_compare);
 
 /*
  * Check that the two inodes are eligible for cloning, the ranges make
@@ -2000,7 +2001,8 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
  */
 int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 				  struct file *file_out, loff_t pos_out,
-				  loff_t *len, unsigned int remap_flags)
+				  loff_t *len, unsigned int remap_flags,
+				  compare_range_t compare)
 {
 	struct inode *inode_in = file_inode(file_in);
 	struct inode *inode_out = file_inode(file_out);
@@ -2059,9 +2061,8 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 	 */
 	if (remap_flags & REMAP_FILE_DEDUP) {
 		bool		is_same = false;
-
-		ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
-				inode_out, pos_out, *len, &is_same);
+		ret = (*compare)(inode_in, pos_in,
+			inode_out, pos_out, *len, &is_same);
 		if (ret)
 			return ret;
 		if (!is_same)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 107bf2a2f344..792217cd1e64 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1338,7 +1338,7 @@ xfs_reflink_remap_prep(
 		goto out_unlock;
 
 	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
-			len, remap_flags);
+			len, remap_flags, vfs_dedupe_file_range_compare);
 	if (ret < 0 || *len == 0)
 		goto out_unlock;
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 1e2e81c701b6..f8143fe24bf5 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -223,6 +223,11 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
 int dax_iomap_zero(loff_t pos, unsigned offset, unsigned size,
 			struct iomap *iomap);
+int dax_file_range_compare(struct inode *src, loff_t srcoff,
+			   struct inode *dest, loff_t destoff,
+			   loff_t len, bool *is_same,
+			   const struct iomap_ops *ops);
+
 static inline bool dax_mapping(struct address_space *mapping)
 {
 	return mapping->host && IS_DAX(mapping->host);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f6f59b4f22a..959173cdeb05 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1924,13 +1924,20 @@ extern ssize_t vfs_readv(struct file *, const struct iovec __user *,
 		unsigned long, loff_t *, rwf_t);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 				   loff_t, size_t, unsigned int);
+extern int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
+					 struct inode *dest, loff_t destoff,
+					 loff_t len, bool *is_same);
+typedef int (*compare_range_t)(struct inode *src, loff_t srcpos,
+			       struct inode *dest, loff_t destpos,
+			       loff_t len, bool *is_same);
 extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
 				       struct file *file_out, loff_t pos_out,
 				       size_t len, unsigned int flags);
 extern int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 					 struct file *file_out, loff_t pos_out,
 					 loff_t *count,
-					 unsigned int remap_flags);
+					 unsigned int remap_flags,
+					 compare_range_t cmp);
 extern loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
 				  struct file *file_out, loff_t pos_out,
 				  loff_t len, unsigned int remap_flags);
-- 
2.26.2



