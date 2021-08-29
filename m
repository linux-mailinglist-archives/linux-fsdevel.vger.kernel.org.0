Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D5F3FAB5B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 14:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhH2M0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 08:26:37 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:56535 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235297AbhH2M03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 08:26:29 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A7Ux0964OELSYhhYtlwPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.84,361,1620662400"; 
   d="scan'208";a="113656445"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Aug 2021 20:25:31 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id A5C6C4D0D9D6;
        Sun, 29 Aug 2021 20:25:29 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 29 Aug 2021 20:25:32 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 29 Aug 2021 20:25:28 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <djwong@kernel.org>, <hch@lst.de>, <linux-xfs@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>
Subject: [PATCH v8 2/7] fsdax: Introduce dax_iomap_cow_copy()
Date:   Sun, 29 Aug 2021 20:25:12 +0800
Message-ID: <20210829122517.1648171-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829122517.1648171-1-ruansy.fnst@fujitsu.com>
References: <20210829122517.1648171-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: A5C6C4D0D9D6.A481C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the case where the iomap is a write operation and iomap is not equal
to srcmap after iomap_begin, we consider it is a CoW operation.

In this case, the destination (iomap->addr) points to a newly allocated
extent.  It is needed to copy the data from srcmap to the extent.  In
theory, it is better to copy the head and tail ranges which is outside
of the non-aligned area instead of copying the whole aligned range. But
in dax page fault, it will always be an aligned range. So copy the whole
range in this case.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 5 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 9fb6218f42be..792116b14782 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1050,6 +1050,60 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 	return rc;
 }
 
+/**
+ * dax_iomap_cow_copy - Copy the data from source to destination before write
+ * @pos:	address to do copy from.
+ * @length:	size of copy operation.
+ * @align_size:	aligned w.r.t align_size (either PMD_SIZE or PAGE_SIZE)
+ * @srcmap:	iomap srcmap
+ * @daddr:	destination address to copy to.
+ *
+ * This can be called from two places. Either during DAX write fault (page
+ * aligned), to copy the length size data to daddr. Or, while doing normal DAX
+ * write operation, dax_iomap_actor() might call this to do the copy of either
+ * start or end unaligned address. In the latter case the rest of the copy of
+ * aligned ranges is taken care by dax_iomap_actor() itself.
+ */
+static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,
+		const struct iomap *srcmap, void *daddr)
+{
+	loff_t head_off = pos & (align_size - 1);
+	size_t size = ALIGN(head_off + length, align_size);
+	loff_t end = pos + length;
+	loff_t pg_end = round_up(end, align_size);
+	bool copy_all = head_off == 0 && end == pg_end;
+	void *saddr = 0;
+	int ret = 0;
+
+	ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
+	if (ret)
+		return ret;
+
+	if (copy_all) {
+		ret = copy_mc_to_kernel(daddr, saddr, length);
+		return ret ? -EIO : 0;
+	}
+
+	/* Copy the head part of the range */
+	if (head_off) {
+		ret = copy_mc_to_kernel(daddr, saddr, head_off);
+		if (ret)
+			return -EIO;
+	}
+
+	/* Copy the tail part of the range */
+	if (end < pg_end) {
+		loff_t tail_off = head_off + length;
+		loff_t tail_len = pg_end - end;
+
+		ret = copy_mc_to_kernel(daddr + tail_off, saddr + tail_off,
+					tail_len);
+		if (ret)
+			return -EIO;
+	}
+	return 0;
+}
+
 /*
  * The user has performed a load from a hole in the file.  Allocating a new
  * page in the file would cause excessive storage usage for workloads with
@@ -1175,16 +1229,18 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		struct iov_iter *iter)
 {
 	const struct iomap *iomap = &iomi->iomap;
+	const struct iomap *srcmap = &iomi->srcmap;
 	loff_t length = iomap_length(iomi);
 	loff_t pos = iomi->pos;
 	struct block_device *bdev = iomap->bdev;
 	struct dax_device *dax_dev = iomap->dax_dev;
 	loff_t end = pos + length, done = 0;
+	bool write = iov_iter_rw(iter) == WRITE;
 	ssize_t ret = 0;
 	size_t xfer;
 	int id;
 
-	if (iov_iter_rw(iter) == READ) {
+	if (!write) {
 		end = min(end, i_size_read(iomi->inode));
 		if (pos >= end)
 			return 0;
@@ -1193,7 +1249,12 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 			return iov_iter_zero(min(length, end - pos), iter);
 	}
 
-	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED))
+	/*
+	 * In DAX mode, enforce either pure overwrites of written extents, or
+	 * writes to unwritten extents as part of a copy-on-write operation.
+	 */
+	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED &&
+			!(iomap->flags & IOMAP_F_SHARED)))
 		return -EIO;
 
 	/*
@@ -1232,6 +1293,14 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 			break;
 		}
 
+		if (write &&
+		    srcmap->addr != IOMAP_HOLE && srcmap->addr != iomap->addr) {
+			ret = dax_iomap_cow_copy(pos, length, PAGE_SIZE, srcmap,
+						 kaddr);
+			if (ret)
+				break;
+		}
+
 		map_len = PFN_PHYS(map_len);
 		kaddr += offset;
 		map_len -= offset;
@@ -1243,7 +1312,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		 * validated via access_ok() in either vfs_read() or
 		 * vfs_write(), depending on which operation we are doing.
 		 */
-		if (iov_iter_rw(iter) == WRITE)
+		if (write)
 			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
 		else
@@ -1385,6 +1454,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	const struct iomap *iomap = &iter->iomap;
+	const struct iomap *srcmap = &iter->srcmap;
 	size_t size = pmd ? PMD_SIZE : PAGE_SIZE;
 	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
@@ -1392,6 +1462,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
 	int err = 0;
 	pfn_t pfn;
+	void *kaddr;
 
 	if (!pmd && vmf->cow_page)
 		return dax_fault_cow_page(vmf, iter);
@@ -1404,18 +1475,25 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 		return dax_pmd_load_hole(xas, vmf, iomap, entry);
 	}
 
-	if (iomap->type != IOMAP_MAPPED) {
+	if (iomap->type != IOMAP_MAPPED && !(iomap->flags & IOMAP_F_SHARED)) {
 		WARN_ON_ONCE(1);
 		return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
 	}
 
-	err = dax_iomap_direct_access(&iter->iomap, pos, size, NULL, &pfn);
+	err = dax_iomap_direct_access(iomap, pos, size, &kaddr, &pfn);
 	if (err)
 		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
 
 	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn, entry_flags,
 				  write && !sync);
 
+	if (write &&
+	    srcmap->addr != IOMAP_HOLE && srcmap->addr != iomap->addr) {
+		err = dax_iomap_cow_copy(pos, size, size, srcmap, kaddr);
+		if (err)
+			return dax_fault_return(err);
+	}
+
 	if (sync)
 		return dax_fault_synchronous_pfnp(pfnp, pfn);
 
-- 
2.32.0



