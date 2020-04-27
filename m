Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9BB1B9AB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 10:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgD0Iso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 04:48:44 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:3151 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726786AbgD0Ism (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:48:42 -0400
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; 
   d="scan'208";a="90547653"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Apr 2020 16:48:32 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 1A32F4BCC88C;
        Mon, 27 Apr 2020 16:37:52 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 27 Apr 2020 16:48:34 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 27 Apr 2020 16:48:34 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>,
        <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 3/8] fs/dax: Introduce dax_copy_edges() for COW
Date:   Mon, 27 Apr 2020 16:47:45 +0800
Message-ID: <20200427084750.136031-4-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 1A32F4BCC88C.AF766
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add address output in dax_iomap_pfn() in order to perform a memcpy() in CoW
case.  Since this function both output address and pfn, rename it to
dax_iomap_direct_access().

dax_copy_edges() is a helper functions performs a copy from one part of
the device to another for data not page aligned.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/dax.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 2f996c566103..8107ed10c851 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1111,8 +1111,8 @@ static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
 	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
 }
 
-static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
-			 pfn_t *pfnp)
+static int dax_iomap_direct_access(struct iomap *iomap, loff_t pos, size_t size,
+			 pfn_t *pfnp, void **addr)
 {
 	const sector_t sector = dax_iomap_sector(iomap, pos);
 	pgoff_t pgoff;
@@ -1123,12 +1123,14 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
 	if (rc)
 		return rc;
 	id = dax_read_lock();
-	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
-				   NULL, pfnp);
+	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size), addr,
+				   pfnp);
 	if (length < 0) {
 		rc = length;
 		goto out;
 	}
+	if (!pfnp)
+		goto out_check_addr;
 	rc = -EINVAL;
 	if (PFN_PHYS(length) < size)
 		goto out;
@@ -1138,11 +1140,59 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
 	if (length > 1 && !pfn_t_devmap(*pfnp))
 		goto out;
 	rc = 0;
+
+out_check_addr:
+	if (!addr)
+		goto out;
+	if (!*addr)
+		rc = -EFAULT;
 out:
 	dax_read_unlock(id);
 	return rc;
 }
 
+/*
+ * dax_copy_edges - Copies the part of the pages not included in
+ *		    the write, but required for CoW because
+ *		    offset/offset+length are not page aligned.
+ */
+static int dax_copy_edges(loff_t pos, loff_t length, struct iomap *srcmap,
+			  void *daddr, bool pmd)
+{
+	size_t page_size = pmd ? PMD_SIZE : PAGE_SIZE;
+	loff_t offset = pos & (page_size - 1);
+	size_t size = ALIGN(offset + length, page_size);
+	loff_t end = pos + length;
+	loff_t pg_end = round_up(end, page_size);
+	void *saddr = 0;
+	int ret = 0;
+
+	ret = dax_iomap_direct_access(srcmap, pos, size, NULL, &saddr);
+	if (ret)
+		return ret;
+	/*
+	 * Copy the first part of the page
+	 * Note: we pass offset as length
+	 */
+	if (offset) {
+		if (saddr)
+			ret = memcpy_mcsafe(daddr, saddr, offset);
+		else
+			memset(daddr, 0, offset);
+	}
+
+	/* Copy the last part of the range */
+	if (end < pg_end) {
+		if (saddr)
+			ret = memcpy_mcsafe(daddr + offset + length,
+			       saddr + offset + length,	pg_end - end);
+		else
+			memset(daddr + offset + length, 0,
+					pg_end - end);
+	}
+	return ret;
+}
+
 /*
  * The user has performed a load from a hole in the file.  Allocating a new
  * page in the file would cause excessive storage usage for workloads with
@@ -1462,7 +1512,8 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
 			major = VM_FAULT_MAJOR;
 		}
-		error = dax_iomap_pfn(&iomap, pos, PAGE_SIZE, &pfn);
+		error = dax_iomap_direct_access(&iomap, pos, PAGE_SIZE, &pfn,
+						NULL);
 		if (error < 0)
 			goto error_finish_iomap;
 
@@ -1680,7 +1731,8 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 
 	switch (iomap.type) {
 	case IOMAP_MAPPED:
-		error = dax_iomap_pfn(&iomap, pos, PMD_SIZE, &pfn);
+		error = dax_iomap_direct_access(&iomap, pos, PMD_SIZE, &pfn,
+						NULL);
 		if (error < 0)
 			goto finish_iomap;
 
-- 
2.26.2



