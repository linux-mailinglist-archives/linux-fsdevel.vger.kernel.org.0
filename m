Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7447E325AE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 01:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhBZA0j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 19:26:39 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:12518 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232237AbhBZA0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 19:26:30 -0500
X-IronPort-AV: E=Sophos;i="5.81,207,1610380800"; 
   d="scan'208";a="104882836"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Feb 2021 08:21:18 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 533554CE76ED;
        Fri, 26 Feb 2021 08:21:17 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 26 Feb 2021 08:21:08 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 26 Feb 2021 08:21:07 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <linux-btrfs@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>
Subject: [PATCH v2 06/10] fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
Date:   Fri, 26 Feb 2021 08:20:26 +0800
Message-ID: <20210226002030.653855-7-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 533554CE76ED.A3477
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Punch hole on a reflinked file needs dax_copy_edge() too.  Otherwise,
data in not aligned area will be not correct.  So, add the srcmap to
dax_iomap_zero() and replace memset() as dax_copy_edge().

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c               | 6 ++++--
 fs/iomap/buffered-io.c | 2 +-
 include/linux/dax.h    | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index ec4b733e0b59..4f6c6ba68e6f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1116,7 +1116,8 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
 	return ret;
 }
 
-s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
+s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
 	pgoff_t pgoff;
@@ -1146,7 +1147,8 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 	}
 
 	if (!page_aligned) {
-		memset(kaddr + offset, 0, size);
+		dax_iomap_cow_copy(offset, size, PAGE_SIZE, srcmap,
+				   kaddr, true);
 		dax_flush(iomap->dax_dev, kaddr + offset, size);
 	}
 	dax_read_unlock(id);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 16a1e82e3aeb..d754b1f1a05d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -933,7 +933,7 @@ static loff_t iomap_zero_range_actor(struct inode *inode, loff_t pos,
 		s64 bytes;
 
 		if (IS_DAX(inode))
-			bytes = dax_iomap_zero(pos, length, iomap);
+			bytes = dax_iomap_zero(pos, length, iomap, srcmap);
 		else
 			bytes = iomap_zero(inode, pos, length, iomap, srcmap);
 		if (bytes < 0)
diff --git a/include/linux/dax.h b/include/linux/dax.h
index b52f084aa643..3275e01ed33d 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -237,7 +237,8 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
-s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap);
+s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
+		struct iomap *srcmap);
 static inline bool dax_mapping(struct address_space *mapping)
 {
 	return mapping->host && IS_DAX(mapping->host);
-- 
2.30.1



