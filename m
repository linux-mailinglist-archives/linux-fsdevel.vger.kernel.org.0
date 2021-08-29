Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558D43FAB65
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 14:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbhH2M0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 08:26:51 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:56552 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235395AbhH2M0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 08:26:44 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Aom/8n6xe1hAuYF2p9C7SKrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.84,361,1620662400"; 
   d="scan'208";a="113656459"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Aug 2021 20:25:50 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id A9CD64D0D9D0;
        Sun, 29 Aug 2021 20:25:43 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 29 Aug 2021 20:25:39 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 29 Aug 2021 20:25:37 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <djwong@kernel.org>, <hch@lst.de>, <linux-xfs@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH v8 5/7] fsdax: Dedup file range to use a compare function
Date:   Sun, 29 Aug 2021 20:25:15 +0800
Message-ID: <20210829122517.1648171-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829122517.1648171-1-ruansy.fnst@fujitsu.com>
References: <20210829122517.1648171-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: A9CD64D0D9D0.A3367
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With dax we cannot deal with readpage() etc. So, we create a dax
comparison function which is similar with
vfs_dedupe_file_range_compare().
And introduce dax_remap_file_range_prep() for filesystem use.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c             | 79 ++++++++++++++++++++++++++++++++++++++++++++
 fs/remap_range.c     | 39 +++++++++++++++++-----
 fs/xfs/xfs_reflink.c |  8 +++--
 include/linux/dax.h  |  8 +++++
 include/linux/fs.h   | 12 ++++---
 5 files changed, 132 insertions(+), 14 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index b294900e574e..a1232d6b7e37 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1813,3 +1813,82 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 	return dax_insert_pfn_mkwrite(vmf, pfn, order);
 }
 EXPORT_SYMBOL_GPL(dax_finish_sync_fault);
+
+static loff_t dax_range_compare_iter(struct iomap_iter *it_src,
+		struct iomap_iter *it_dest, bool *same)
+{
+	const struct iomap *smap = &it_src->iomap;
+	const struct iomap *dmap = &it_dest->iomap;
+	loff_t pos1 = it_src->pos, pos2 = it_dest->pos;
+	loff_t len = min(smap->length, dmap->length);
+	void *saddr, *daddr;
+	int id, ret;
+
+	if (smap->type == IOMAP_HOLE && dmap->type == IOMAP_HOLE) {
+		*same = true;
+		return len;
+	}
+
+	if (smap->type == IOMAP_HOLE || dmap->type == IOMAP_HOLE) {
+		*same = false;
+		return 0;
+	}
+
+	id = dax_read_lock();
+	ret = dax_iomap_direct_access(smap, pos1, ALIGN(pos1 + len, PAGE_SIZE),
+				      &saddr, NULL);
+	if (ret < 0)
+		goto out_unlock;
+
+	ret = dax_iomap_direct_access(dmap, pos2, ALIGN(pos2 + len, PAGE_SIZE),
+				      &daddr, NULL);
+	if (ret < 0)
+		goto out_unlock;
+
+	*same = !memcmp(saddr, daddr, len);
+	if (!*same)
+		len = 0;
+	dax_read_unlock(id);
+	return len;
+
+out_unlock:
+	dax_read_unlock(id);
+	return -EIO;
+}
+
+int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
+		struct inode *dst, loff_t dstoff, loff_t len, bool *same,
+		const struct iomap_ops *ops)
+{
+	struct iomap_iter src_iter = {
+		.inode		= src,
+		.pos		= srcoff,
+		.len		= len,
+	};
+	struct iomap_iter dst_iter = {
+		.inode		= dst,
+		.pos		= dstoff,
+		.len		= len,
+	};
+	int ret;
+
+	while ((ret = iomap_iter(&src_iter, ops)) > 0) {
+		while ((ret = iomap_iter(&dst_iter, ops)) > 0) {
+			dst_iter.processed = dax_range_compare_iter(&src_iter,
+						&dst_iter, same);
+		}
+		if (ret <= 0)
+			src_iter.processed = ret;
+	}
+	return ret;
+}
+
+int dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
+			      struct file *file_out, loff_t pos_out,
+			      loff_t *len, unsigned int remap_flags,
+			      const struct iomap_ops *ops)
+{
+	return __generic_remap_file_range_prep(file_in, pos_in, file_out,
+					       pos_out, len, remap_flags, ops);
+}
+EXPORT_SYMBOL_GPL(dax_remap_file_range_prep);
diff --git a/fs/remap_range.c b/fs/remap_range.c
index e4a5fdd7ad7b..b68a29562902 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -14,6 +14,7 @@
 #include <linux/compat.h>
 #include <linux/mount.h>
 #include <linux/fs.h>
+#include <linux/dax.h>
 #include "internal.h"
 
 #include <linux/uaccess.h>
@@ -199,9 +200,9 @@ static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
  * Compare extents of two files to see if they are the same.
  * Caller must have locked both inodes to prevent write races.
  */
-static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
-					 struct inode *dest, loff_t destoff,
-					 loff_t len, bool *is_same)
+int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
+				  struct inode *dest, loff_t destoff,
+				  loff_t len, bool *is_same)
 {
 	loff_t src_poff;
 	loff_t dest_poff;
@@ -280,6 +281,7 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 out_error:
 	return error;
 }
+EXPORT_SYMBOL(vfs_dedupe_file_range_compare);
 
 /*
  * Check that the two inodes are eligible for cloning, the ranges make
@@ -289,9 +291,11 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
  * If there's an error, then the usual negative error code is returned.
  * Otherwise returns 0 with *len set to the request length.
  */
-int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
-				  struct file *file_out, loff_t pos_out,
-				  loff_t *len, unsigned int remap_flags)
+int
+__generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
+				struct file *file_out, loff_t pos_out,
+				loff_t *len, unsigned int remap_flags,
+				const struct iomap_ops *dax_read_ops)
 {
 	struct inode *inode_in = file_inode(file_in);
 	struct inode *inode_out = file_inode(file_out);
@@ -351,8 +355,18 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 	if (remap_flags & REMAP_FILE_DEDUP) {
 		bool		is_same = false;
 
-		ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
-				inode_out, pos_out, *len, &is_same);
+		if (*len == 0)
+			return 0;
+
+		if (!IS_DAX(inode_in))
+			ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
+					inode_out, pos_out, *len, &is_same);
+		else if (dax_read_ops)
+			ret = dax_dedupe_file_range_compare(inode_in, pos_in,
+					inode_out, pos_out, *len, &is_same,
+					dax_read_ops);
+		else
+			return -EINVAL;
 		if (ret)
 			return ret;
 		if (!is_same)
@@ -370,6 +384,15 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 
 	return ret;
 }
+EXPORT_SYMBOL(__generic_remap_file_range_prep);
+
+int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
+				  struct file *file_out, loff_t pos_out,
+				  loff_t *len, unsigned int remap_flags)
+{
+	return __generic_remap_file_range_prep(file_in, pos_in, file_out,
+					       pos_out, len, remap_flags, NULL);
+}
 EXPORT_SYMBOL(generic_remap_file_range_prep);
 
 loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index c256104772cb..28effe537d07 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1332,8 +1332,12 @@ xfs_reflink_remap_prep(
 	if (IS_DAX(inode_in) || IS_DAX(inode_out))
 		goto out_unlock;
 
-	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
-			len, remap_flags);
+	if (!IS_DAX(inode_in))
+		ret = generic_remap_file_range_prep(file_in, pos_in, file_out,
+				pos_out, len, remap_flags);
+	else
+		ret = dax_remap_file_range_prep(file_in, pos_in, file_out,
+				pos_out, len, remap_flags, &xfs_read_iomap_ops);
 	if (ret || *len == 0)
 		goto out_unlock;
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index c63559605369..8ecd125434ef 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -239,6 +239,14 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
 s64 dax_iomap_zero(loff_t pos, u64 length, const struct iomap *iomap,
 		const struct iomap *srcmap);
+int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
+				  struct inode *dest, loff_t destoff,
+				  loff_t len, bool *is_same,
+				  const struct iomap_ops *ops);
+int dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
+			      struct file *file_out, loff_t pos_out,
+			      loff_t *len, unsigned int remap_flags,
+			      const struct iomap_ops *ops);
 static inline bool dax_mapping(struct address_space *mapping)
 {
 	return mapping->host && IS_DAX(mapping->host);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 640574294216..3e9922aac200 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -71,6 +71,7 @@ struct fsverity_operations;
 struct fs_context;
 struct fs_parameter_spec;
 struct fileattr;
+struct iomap_ops;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -2126,10 +2127,13 @@ extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
 				       struct file *file_out, loff_t pos_out,
 				       size_t len, unsigned int flags);
-extern int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
-					 struct file *file_out, loff_t pos_out,
-					 loff_t *count,
-					 unsigned int remap_flags);
+int __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
+				    struct file *file_out, loff_t pos_out,
+				    loff_t *len, unsigned int remap_flags,
+				    const struct iomap_ops *dax_read_ops);
+int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
+				  struct file *file_out, loff_t pos_out,
+				  loff_t *count, unsigned int remap_flags);
 extern loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
 				  struct file *file_out, loff_t pos_out,
 				  loff_t len, unsigned int remap_flags);
-- 
2.32.0



