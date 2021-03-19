Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA42341270
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 02:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhCSBxb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 21:53:31 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41484 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231475AbhCSBxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:53:14 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ApE5d1aAKLoV80fXlHelM55DYdL4zR+YMi2QD?=
 =?us-ascii?q?/UZ3VBBTb4ikh9mj9c5rsSPcpRQwfDUbmd6GMLSdWn+0z/NIyKQYILvKZmfbkU?=
 =?us-ascii?q?SlIIxo5YHhhx3McheVysdzzqFlGpIeNPTVLXxXyfn3+xO5FdFI+qjjzImNif3F?=
 =?us-ascii?q?x3lgCSFGApsQjDtRMQqQHk1oSAQuP/NQe6a03NZNpDarZB0sH6aGL0QCNtKim/?=
 =?us-ascii?q?T70LriYTMjQyUs8RSyi1qTg4LSIly12Qg/Xlp0rYsfzQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,259,1610380800"; 
   d="scan'208";a="105876689"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Mar 2021 09:53:12 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 5AF5E4CEA871;
        Fri, 19 Mar 2021 09:53:09 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 19 Mar 2021 09:53:09 +0800
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 19 Mar 2021 09:53:09 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 19 Mar 2021 09:53:08 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <linux-btrfs@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>
Subject: [PATCH v3 06/10] fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
Date:   Fri, 19 Mar 2021 09:52:33 +0800
Message-ID: <20210319015237.993880-7-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5AF5E4CEA871.A38BC
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
 fs/dax.c               | 9 +++++++--
 fs/iomap/buffered-io.c | 2 +-
 include/linux/dax.h    | 3 ++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index cfe513eb111e..348297b38f76 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1174,7 +1174,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 }
 #endif /* CONFIG_FS_DAX_PMD */
 
-s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
+s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
 	pgoff_t pgoff;
@@ -1204,7 +1205,11 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 	}
 
 	if (!page_aligned) {
-		memset(kaddr + offset, 0, size);
+		if (iomap->addr != srcmap->addr)
+			dax_iomap_cow_copy(offset, size, PAGE_SIZE, srcmap,
+					   kaddr, true);
+		else
+			memset(kaddr + offset, 0, size);
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



