Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF413ECE4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 08:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbhHPGFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 02:05:02 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:38862 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233376AbhHPGFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:05:01 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AZ6rcZa82sk4fShoPMLduk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="112944860"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Aug 2021 14:04:29 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 82D764D0D4BF;
        Mon, 16 Aug 2021 14:04:28 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 16 Aug 2021 14:04:25 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 16 Aug 2021 14:04:21 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <djwong@kernel.org>, <hch@lst.de>, <linux-xfs@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH v7 4/8] fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
Date:   Mon, 16 Aug 2021 14:03:55 +0800
Message-ID: <20210816060359.1442450-5-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816060359.1442450-1-ruansy.fnst@fujitsu.com>
References: <20210816060359.1442450-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 82D764D0D4BF.A3AC4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Punch hole on a reflinked file needs dax_iomap_cow_copy() too.
Otherwise, data in not aligned area will be not correct.  So, add the
srcmap to dax_iomap_zero() and replace memset() as dax_iomap_cow_copy().

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c               | 25 +++++++++++++++----------
 fs/iomap/buffered-io.c |  4 ++--
 include/linux/dax.h    |  3 ++-
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index e49ba68cc7e4..91ceb518f66a 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1198,7 +1198,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 }
 #endif /* CONFIG_FS_DAX_PMD */
 
-s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
+s64 dax_iomap_zero(loff_t pos, u64 length, const struct iomap *iomap,
+		const struct iomap *srcmap)
 {
 	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
 	pgoff_t pgoff;
@@ -1220,19 +1221,23 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 
 	if (page_aligned)
 		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
-	else
+	else {
 		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
-	if (rc < 0) {
-		dax_read_unlock(id);
-		return rc;
-	}
-
-	if (!page_aligned) {
-		memset(kaddr + offset, 0, size);
+		if (rc < 0)
+			goto out;
+		if (iomap->addr != srcmap->addr) {
+			rc = dax_iomap_cow_copy(pos, size, PAGE_SIZE, srcmap,
+						kaddr);
+			if (rc < 0)
+				goto out;
+		} else
+			memset(kaddr + offset, 0, size);
 		dax_flush(iomap->dax_dev, kaddr + offset, size);
 	}
+
+out:
 	dax_read_unlock(id);
-	return size;
+	return rc < 0 ? rc : size;
 }
 
 static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 71b4806266d7..6e8d40877d01 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -889,7 +889,7 @@ static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
 
 static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
-	struct iomap *iomap = &iter->iomap;
+	const struct iomap *iomap = &iter->iomap;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
@@ -903,7 +903,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		s64 bytes;
 
 		if (IS_DAX(iter->inode))
-			bytes = dax_iomap_zero(pos, length, iomap);
+			bytes = dax_iomap_zero(pos, length, iomap, srcmap);
 		else
 			bytes = __iomap_zero_iter(iter, pos, length);
 		if (bytes < 0)
diff --git a/include/linux/dax.h b/include/linux/dax.h
index b52f084aa643..c63559605369 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -237,7 +237,8 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
-s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap);
+s64 dax_iomap_zero(loff_t pos, u64 length, const struct iomap *iomap,
+		const struct iomap *srcmap);
 static inline bool dax_mapping(struct address_space *mapping)
 {
 	return mapping->host && IS_DAX(mapping->host);
-- 
2.32.0



