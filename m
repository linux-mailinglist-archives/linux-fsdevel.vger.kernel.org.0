Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05978325AD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 01:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhBZAZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 19:25:13 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:8517 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232923AbhBZAY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 19:24:59 -0500
X-IronPort-AV: E=Sophos;i="5.81,207,1610380800"; 
   d="scan'208";a="104882816"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Feb 2021 08:20:59 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 684AB4CE76F5;
        Fri, 26 Feb 2021 08:20:54 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 26 Feb 2021 08:20:54 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 26 Feb 2021 08:20:54 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <linux-btrfs@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>
Subject: [PATCH v2 04/10] fsdax: Introduce dax_iomap_cow_copy()
Date:   Fri, 26 Feb 2021 08:20:24 +0800
Message-ID: <20210226002030.653855-5-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 684AB4CE76F5.A57CA
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the case where the iomap is a write operation and iomap is not equal
to srcmap after iomap_begin, we consider it is a CoW operation.

The destance extent which iomap indicated is new allocated extent.
So, it is needed to copy the data from srcmap to new allocated extent.
In theory, it is better to copy the head and tail ranges which is
outside of the non-aligned area instead of copying the whole aligned
range. But in dax page fault, it will always be an aligned range.  So,
we have to copy the whole range in this case.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 5 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 1459ef4095fb..748dfb89fb41 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1037,6 +1037,53 @@ static int dax_iomap_direct_access(struct iomap *iomap, loff_t pos, size_t size,
 	return rc;
 }
 
+/*
+ * Copy the head and tail part of the pages not included in the write but
+ * required for CoW, because pos/pos+length are not page aligned.  But in dax
+ * page fault case, the range is page aligned, we need to copy the whole range
+ * of data.  Use copy_edge to distinguish these cases.
+ */
+static int dax_iomap_cow_copy(loff_t pos, loff_t length, size_t align_size,
+		struct iomap *srcmap, void *daddr, bool copy_edge)
+{
+	loff_t head_off = pos & (align_size - 1);
+	size_t size = ALIGN(head_off + length, align_size);
+	loff_t end = pos + length;
+	loff_t pg_end = round_up(end, align_size);
+	void *saddr = 0;
+	int ret = 0;
+
+	ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
+	if (ret)
+		return ret;
+
+	if (!copy_edge) {
+		ret = copy_mc_to_kernel(daddr, saddr, length);
+		return ret;
+	}
+
+	/* Copy the head part of the page.  Note: we pass offset as length. */
+	if (head_off) {
+		if (saddr)
+			ret = copy_mc_to_kernel(daddr, saddr, head_off);
+		else
+			memset(daddr, 0, head_off);
+	}
+	/* Copy the tail part of the range */
+	if (end < pg_end) {
+		loff_t tail_off = head_off + length;
+		loff_t tail_len = pg_end - end;
+
+		if (saddr)
+			ret = copy_mc_to_kernel(daddr + tail_off,
+					saddr + tail_off, tail_len);
+		else
+			memset(daddr + tail_off, 0, tail_len);
+	}
+
+	return ret;
+}
+
 /*
  * The user has performed a load from a hole in the file.  Allocating a new
  * page in the file would cause excessive storage usage for workloads with
@@ -1106,11 +1153,12 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	struct dax_device *dax_dev = iomap->dax_dev;
 	struct iov_iter *iter = data;
 	loff_t end = pos + length, done = 0;
+	bool write = iov_iter_rw(iter) == WRITE;
 	ssize_t ret = 0;
 	size_t xfer;
 	int id;
 
-	if (iov_iter_rw(iter) == READ) {
+	if (!write) {
 		end = min(end, i_size_read(inode));
 		if (pos >= end)
 			return 0;
@@ -1119,7 +1167,8 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			return iov_iter_zero(min(length, end - pos), iter);
 	}
 
-	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED))
+	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED &&
+			!(iomap->flags & IOMAP_F_SHARED)))
 		return -EIO;
 
 	/*
@@ -1158,6 +1207,13 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			break;
 		}
 
+		if (write && srcmap->addr != iomap->addr) {
+			ret = dax_iomap_cow_copy(pos, length, PAGE_SIZE, srcmap,
+						 kaddr, true);
+			if (ret)
+				break;
+		}
+
 		map_len = PFN_PHYS(map_len);
 		kaddr += offset;
 		map_len -= offset;
@@ -1169,7 +1225,7 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		 * validated via access_ok() in either vfs_read() or
 		 * vfs_write(), depending on which operation we are doing.
 		 */
-		if (iov_iter_rw(iter) == WRITE)
+		if (write)
 			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
 		else
@@ -1350,6 +1406,7 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
 	vm_fault_t ret = 0;
 	int err = 0;
 	pfn_t pfn;
+	void *kaddr;
 
 	/* if we are reading UNWRITTEN and HOLE, return a hole. */
 	if (!write &&
@@ -1360,18 +1417,24 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
 			return dax_pmd_load_hole(xas, vmf, iomap, &entry);
 	}
 
-	if (iomap->type != IOMAP_MAPPED) {
+	if (iomap->type != IOMAP_MAPPED && !(iomap->flags & IOMAP_F_SHARED)) {
 		WARN_ON_ONCE(1);
 		return VM_FAULT_SIGBUS;
 	}
 
-	err = dax_iomap_direct_access(iomap, pos, size, NULL, &pfn);
+	err = dax_iomap_direct_access(iomap, pos, size, &kaddr, &pfn);
 	if (err)
 		goto error_fault;
 
 	entry = dax_insert_entry(xas, mapping, vmf, entry, pfn, 0,
 				 write && !sync);
 
+	if (write && srcmap->addr != iomap->addr) {
+		err = dax_iomap_cow_copy(pos, size, size, srcmap, kaddr, false);
+		if (err)
+			goto error_fault;
+	}
+
 	if (sync)
 		return dax_fault_synchronous_pfnp(pfnp, pfn);
 
-- 
2.30.1



