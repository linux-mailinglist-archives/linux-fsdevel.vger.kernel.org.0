Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE00F41A8D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 08:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbhI1GZ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 02:25:29 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6259 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239030AbhI1GZZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 02:25:25 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AFCzbTqm+M5KPVD6GhCmDkxHo5gz6J0RdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzJUzTAaDWGCPvnYY2D9KNoiPdni9ENXvZCAxtdrTFM4+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuWJQUVUj/nSH+KtUr6?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ0shEs4ehD?=
 =?us-ascii?q?wkvJbHklvkfUgVDDmd1OqguFLrveCHi6Z3Nnh2bG5fr67A0ZK0sBqUU8/h2DUl?=
 =?us-ascii?q?A7/sdLyoHbwzFjOWzqJqkS+1ol+wiKsfxNY8Ss30myivWZd4qSJaFQePV5Ntc3?=
 =?us-ascii?q?T41nehPG+rTY4wSbj8HRBjCfBpJNX8UBYg4kePugWPwGxVetl6UoK8f52nI0Bc?=
 =?us-ascii?q?31LnrLcqTdtGULe1VlUawonnauWj0ajkAO9ubxSWU9Fq3m/TC2y/2MKoWFbul5?=
 =?us-ascii?q?rtkm1Ge2GEXIAMZWEH9ovSjjEO6HdVFJCQ8/isosLh390GxSNT5dwO3rWTCvRM?=
 =?us-ascii?q?GXddUVeog52mlzqvS/hbcFmYfZiBOZcZgt8IsQzEukFiTkLvBGz11t5WHRHSc6?=
 =?us-ascii?q?PGQrDWvKW4SN2BEeCxscOevy7EPu6lq1lSWEIklS/Xz07XI9fjL62jihEADa38?=
 =?us-ascii?q?71qbnD5mGwG0=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AfjO2la6PIcLhzZZ/4gPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.85,328,1624291200"; 
   d="scan'208";a="115096985"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Sep 2021 14:23:45 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 83B3D4D0DC7F;
        Tue, 28 Sep 2021 14:23:43 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Sep 2021 14:23:37 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 28 Sep 2021 14:23:36 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <dan.j.williams@intel.com>, <djwong@kernel.org>, <hch@lst.de>,
        <linux-xfs@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, <david@fromorbit.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <rgoldwyn@suse.de>,
        <viro@zeniv.linux.org.uk>, <willy@infradead.org>
Subject: [PATCH v10 4/8] fsdax: Convert dax_iomap_zero to iter model
Date:   Tue, 28 Sep 2021 14:23:07 +0800
Message-ID: <20210928062311.4012070-5-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928062311.4012070-1-ruansy.fnst@fujitsu.com>
References: <20210928062311.4012070-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 83B3D4D0DC7F.A110A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let dax_iomap_zero() support iter model.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/dax.c               | 3 ++-
 fs/iomap/buffered-io.c | 3 +--
 include/linux/dax.h    | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index b437badfe0dd..debe459680f2 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1209,8 +1209,9 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 }
 #endif /* CONFIG_FS_DAX_PMD */
 
-s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
+s64 dax_iomap_zero(const struct iomap_iter *iter, loff_t pos, u64 length)
 {
+	const struct iomap *iomap = &iter->iomap;
 	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
 	pgoff_t pgoff;
 	long rc, id;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9cc5798423d1..84a861d3b3e0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -889,7 +889,6 @@ static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
 
 static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
-	struct iomap *iomap = &iter->iomap;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
@@ -903,7 +902,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		s64 bytes;
 
 		if (IS_DAX(iter->inode))
-			bytes = dax_iomap_zero(pos, length, iomap);
+			bytes = dax_iomap_zero(iter, pos, length);
 		else
 			bytes = __iomap_zero_iter(iter, pos, length);
 		if (bytes < 0)
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 2619d94c308d..b6f5d0d30065 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -13,6 +13,7 @@ typedef unsigned long dax_entry_t;
 
 struct iomap_ops;
 struct iomap;
+struct iomap_iter;
 struct dax_device;
 struct dax_operations {
 	/*
@@ -210,7 +211,7 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
-s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap);
+s64 dax_iomap_zero(const struct iomap_iter *iter, loff_t pos, u64 length);
 static inline bool dax_mapping(struct address_space *mapping)
 {
 	return mapping->host && IS_DAX(mapping->host);
-- 
2.33.0



