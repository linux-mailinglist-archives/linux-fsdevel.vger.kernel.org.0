Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4F940C3D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 12:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbhIOKrR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 06:47:17 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:56889 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237433AbhIOKrM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 06:47:12 -0400
IronPort-Data: =?us-ascii?q?A9a23=3A8vwYx6lERr+phk+RMGOXIUXo5gyVJ0RdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzYEz2MWXWiHb/bYYTGjc4x3at++pk8EsMXQxtQ1SwA5+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuWJQUVUj/nSH+KtUbO?=
 =?us-ascii?q?cYUideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ0shEs4ehD?=
 =?us-ascii?q?wkvJbHklvkfUgVDDmd1OqguFLrveCHj7JXClxCXG5fr67A0ZK0sBqUU8/h2DUl?=
 =?us-ascii?q?A7/sdLyoHbwzFjOWzqJqkS+1ol+wiKsfxNY8Ss30myivWZd4qSJaFQePV5Ntc3?=
 =?us-ascii?q?T41nehPG+rTY4wSbj8HRBjCfBpJNX8UBYg4kePugWPwGxVetl6UoK8f52nI0Bc?=
 =?us-ascii?q?31LnrLcqTdtGULe1VlUawonnauWj0ajkAO9ubxSWU9Fq3m/TC2yj8Xeo6DrK/8?=
 =?us-ascii?q?vJ1kVu73XEIBVsaWDOTpfi/l177VclTJlIZ/gIwoqUosk+mVN/wW1u/unHslho?=
 =?us-ascii?q?dXcdAVu438geAzoLK7AuDQGsJVDhMbJohrsBebTgr0EKZ2sPnHhRxv7CPD3GQ7?=
 =?us-ascii?q?LGZqXW1Iyd9BXEDfygsXwYD4selpIA1kwKJScxsVrO25uAZsxmYLyui9XB43ut?=
 =?us-ascii?q?My5VQkfjTwLwOuBr0zrChc+L/zlu/srqZ0z5E?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AKcMqVqu7Toj1qSQ3/ShclU8r7skDE9V00zEX?=
 =?us-ascii?q?/kB9WHVpm62j9/xG88536faZslwssRIb+OxoWpPufZq0z/ccirX5VY3SPzUO01?=
 =?us-ascii?q?HFEGgN1+Xf/wE=3D?=
X-IronPort-AV: E=Sophos;i="5.85,295,1624291200"; 
   d="scan'208";a="114519059"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Sep 2021 18:45:51 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 90B3A4D0DC71;
        Wed, 15 Sep 2021 18:45:47 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 15 Sep 2021 18:45:47 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 15 Sep 2021 18:45:46 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <djwong@kernel.org>, <hch@lst.de>, <linux-xfs@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH v9 6/8] fsdax: Dedup file range to use a compare function
Date:   Wed, 15 Sep 2021 18:44:59 +0800
Message-ID: <20210915104501.4146910-7-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com>
References: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 90B3A4D0DC71.A13F7
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
 fs/remap_range.c     | 31 ++++++++++++++---
 fs/xfs/xfs_reflink.c |  8 +++--
 include/linux/dax.h  |  8 +++++
 include/linux/fs.h   | 12 ++++---
 5 files changed, 127 insertions(+), 11 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index ca4308c85988..33b0b9f4b904 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1815,3 +1815,82 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
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
index 6d4a9beaa097..1157169b9d79 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -14,6 +14,7 @@
 #include <linux/compat.h>
 #include <linux/mount.h>
 #include <linux/fs.h>
+#include <linux/dax.h>
 #include "internal.h"
 
 #include <linux/uaccess.h>
@@ -277,9 +278,11 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
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
@@ -339,8 +342,18 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
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
@@ -358,6 +371,14 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 
 	return ret;
 }
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
index 76355f293488..7ecea0311e88 100644
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
index 642de7ef1a10..b975629a8d5b 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -212,6 +212,14 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
 s64 dax_iomap_zero(struct iomap_iter *iter, loff_t pos, u64 length);
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
index e7a633353fd2..670b53c722a7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -71,6 +71,7 @@ struct fsverity_operations;
 struct fs_context;
 struct fs_parameter_spec;
 struct fileattr;
+struct iomap_ops;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -2175,10 +2176,13 @@ extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
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
2.33.0



