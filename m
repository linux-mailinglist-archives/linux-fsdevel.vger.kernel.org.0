Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8322746765
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 20:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfFNSRQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 14:17:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18579 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726262AbfFNSRP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:17:15 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 63A722D84C7D13AC2B30;
        Sat, 15 Jun 2019 02:17:13 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 15 Jun
 2019 02:17:04 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     <chao@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [RFC PATCH 1/8] staging: erofs: add compacted ondisk compression indexes
Date:   Sat, 15 Jun 2019 02:16:12 +0800
Message-ID: <20190614181619.64905-2-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614181619.64905-1-gaoxiang25@huawei.com>
References: <20190614181619.64905-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces new compacted compression indexes.

In contract to legacy compression indexes that
   each 4k logical cluster has an 8-byte index,
compacted ondisk compression indexes will have
   amortized 2 bytes for each 4k logical cluster (compacted 2B)
   amortized 4 bytes for each 4k logical cluster (compacted 4B)

In detail, several continuous clusters will be encoded in
a compacted pack with cluster types, offsets, and one blkaddr
at the end of the pack to leave 4-byte margin for better
decoding performance, as illustrated below:
   _____________________________________________
  |___@_____ encoded bits __________|_ blkaddr _|
  0       .                                     amortized * vcnt
  .          .
  .             .                   amortized * vcnt - 4
  .                .
  .___________________.
  |_type_|_clusterofs_|

Note that compacted 2 / 4B should be aligned with 32 / 8 bytes
in order to avoid each pack crossing page boundary.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/data.c      |  4 +--
 drivers/staging/erofs/erofs_fs.h  | 57 +++++++++++++++++++++++++------
 drivers/staging/erofs/inode.c     |  5 +--
 drivers/staging/erofs/internal.h  | 11 ++----
 drivers/staging/erofs/unzip_vle.c |  8 ++---
 5 files changed, 56 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
index 746685f90564..cc31c3e5984c 100644
--- a/drivers/staging/erofs/data.c
+++ b/drivers/staging/erofs/data.c
@@ -124,7 +124,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	trace_erofs_map_blocks_flatmode_enter(inode, map, flags);
 
 	nblocks = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
-	lastblk = nblocks - is_inode_layout_inline(inode);
+	lastblk = nblocks - is_inode_flat_inline(inode);
 
 	if (unlikely(offset >= inode->i_size)) {
 		/* leave out-of-bound access unmapped */
@@ -139,7 +139,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	if (offset < blknr_to_addr(lastblk)) {
 		map->m_pa = blknr_to_addr(vi->raw_blkaddr) + map->m_la;
 		map->m_plen = blknr_to_addr(lastblk) - offset;
-	} else if (is_inode_layout_inline(inode)) {
+	} else if (is_inode_flat_inline(inode)) {
 		/* 2 - inode inline B: inode, [xattrs], inline last blk... */
 		struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 
diff --git a/drivers/staging/erofs/erofs_fs.h b/drivers/staging/erofs/erofs_fs.h
index 8ddb2b3e7d39..a05139f1df60 100644
--- a/drivers/staging/erofs/erofs_fs.h
+++ b/drivers/staging/erofs/erofs_fs.h
@@ -49,19 +49,29 @@ struct erofs_super_block {
  * erofs inode data mapping:
  * 0 - inode plain without inline data A:
  * inode, [xattrs], ... | ... | no-holed data
- * 1 - inode VLE compression B:
+ * 1 - inode VLE compression B (legacy):
  * inode, [xattrs], extents ... | ...
  * 2 - inode plain with inline data C:
  * inode, [xattrs], last_inline_data, ... | ... | no-holed data
- * 3~7 - reserved
+ * 3 - inode compression D:
+ * inode, [xattrs], map_header, extents ... | ...
+ * 4~7 - reserved
  */
 enum {
-	EROFS_INODE_LAYOUT_PLAIN,
-	EROFS_INODE_LAYOUT_COMPRESSION,
-	EROFS_INODE_LAYOUT_INLINE,
+	EROFS_INODE_FLAT_PLAIN,
+	EROFS_INODE_FLAT_COMPRESSION_LEGACY,
+	EROFS_INODE_FLAT_INLINE,
+	EROFS_INODE_FLAT_COMPRESSION,
 	EROFS_INODE_LAYOUT_MAX
 };
 
+static bool erofs_inode_is_data_compressed(unsigned int datamode)
+{
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
+		return true;
+	return datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+}
+
 /* bit definitions of inode i_advise */
 #define EROFS_I_VERSION_BITS            1
 #define EROFS_I_DATA_MAPPING_BITS       3
@@ -176,11 +186,37 @@ struct erofs_xattr_entry {
 	sizeof(struct erofs_xattr_entry) + \
 	(entry)->e_name_len + le16_to_cpu((entry)->e_value_size))
 
-/* have to be aligned with 8 bytes on disk */
-struct erofs_extent_header {
-	__le32 eh_checksum;
-	__le32 eh_reserved[3];
-} __packed;
+/* available compression algorithm types */
+enum {
+	Z_EROFS_COMPRESSION_LZ4,
+	Z_EROFS_COMPRESSION_MAX
+};
+
+/*
+ * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
+ *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
+ *                                  (4B) + 2B + (4B) if compacted 2B is on.
+ */
+#define Z_EROFS_ADVISE_COMPACTED_2B_BIT         0
+
+#define Z_EROFS_ADVISE_COMPACTED_2B     (1 << Z_EROFS_ADVISE_COMPACTED_2B_BIT)
+
+struct z_erofs_map_header {
+	__le32	h_reserved1;
+	__le16	h_advise;
+	/*
+	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
+	 * bit 4-7 : algorithm type of head 2 (logical cluster type 11).
+	 */
+	__u8	h_algorithmtype;
+	/*
+	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
+	 * bit 3-4 : (physical - logical) cluster bits of head 1:
+	 *       For example, if logical clustersize = 4096, 1 for 8192.
+	 * bit 5-7 : (physical - logical) cluster bits of head 2.
+	 */
+	__u8	h_clusterbits;
+};
 
 /*
  * Z_EROFS Variable-sized Logical Extent cluster type:
@@ -270,7 +306,6 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 	BUILD_BUG_ON(sizeof(struct erofs_inode_v2) != 64);
 	BUILD_BUG_ON(sizeof(struct erofs_xattr_ibody_header) != 12);
 	BUILD_BUG_ON(sizeof(struct erofs_xattr_entry) != 4);
-	BUILD_BUG_ON(sizeof(struct erofs_extent_header) != 16);
 	BUILD_BUG_ON(sizeof(struct z_erofs_vle_decompressed_index) != 8);
 	BUILD_BUG_ON(sizeof(struct erofs_dirent) != 12);
 
diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index e51348f7e838..3539290b8e45 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -127,12 +127,9 @@ static int fill_inline_data(struct inode *inode, void *data,
 {
 	struct erofs_vnode *vi = EROFS_V(inode);
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
-	const int mode = vi->datamode;
-
-	DBG_BUGON(mode >= EROFS_INODE_LAYOUT_MAX);
 
 	/* should be inode inline C */
-	if (mode != EROFS_INODE_LAYOUT_INLINE)
+	if (!is_inode_flat_inline(inode))
 		return 0;
 
 	/* fast symlink (following ext4) */
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 1666cceecb3c..c851d0be6cf6 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -382,19 +382,14 @@ static inline unsigned long inode_datablocks(struct inode *inode)
 	return DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
 }
 
-static inline bool is_inode_layout_plain(struct inode *inode)
-{
-	return EROFS_V(inode)->datamode == EROFS_INODE_LAYOUT_PLAIN;
-}
-
 static inline bool is_inode_layout_compression(struct inode *inode)
 {
-	return EROFS_V(inode)->datamode == EROFS_INODE_LAYOUT_COMPRESSION;
+	return erofs_inode_is_data_compressed(EROFS_V(inode)->datamode);
 }
 
-static inline bool is_inode_layout_inline(struct inode *inode)
+static inline bool is_inode_flat_inline(struct inode *inode)
 {
-	return EROFS_V(inode)->datamode == EROFS_INODE_LAYOUT_INLINE;
+	return EROFS_V(inode)->datamode == EROFS_INODE_FLAT_INLINE;
 }
 
 extern const struct super_operations erofs_sops;
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index f3d0d2c03939..0db9bc50f67c 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1643,8 +1643,8 @@ vle_extent_blkaddr(struct inode *inode, pgoff_t index)
 	struct erofs_vnode *vi = EROFS_V(inode);
 
 	unsigned int ofs = Z_EROFS_VLE_EXTENT_ALIGN(vi->inode_isize +
-		vi->xattr_isize) + sizeof(struct erofs_extent_header) +
-		index * sizeof(struct z_erofs_vle_decompressed_index);
+						    vi->xattr_isize) +
+		16 + index * sizeof(struct z_erofs_vle_decompressed_index);
 
 	return erofs_blknr(iloc(sbi, vi->nid) + ofs);
 }
@@ -1656,8 +1656,8 @@ vle_extent_blkoff(struct inode *inode, pgoff_t index)
 	struct erofs_vnode *vi = EROFS_V(inode);
 
 	unsigned int ofs = Z_EROFS_VLE_EXTENT_ALIGN(vi->inode_isize +
-		vi->xattr_isize) + sizeof(struct erofs_extent_header) +
-		index * sizeof(struct z_erofs_vle_decompressed_index);
+						    vi->xattr_isize) +
+		16 + index * sizeof(struct z_erofs_vle_decompressed_index);
 
 	return erofs_blkoff(iloc(sbi, vi->nid) + ofs);
 }
-- 
2.17.1

