Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC118A785C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 04:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfIDCKX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 22:10:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727722AbfIDCKW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:10:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8D21EBA2F371D9041CE6;
        Wed,  4 Sep 2019 10:10:20 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:12 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 07/25] erofs: better naming for erofs inode related stuffs
Date:   Wed, 4 Sep 2019 10:08:54 +0800
Message-ID: <20190904020912.63925-8-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904020912.63925-1-gaoxiang25@huawei.com>
References: <20190901055130.30572-1-hsiangkao@aol.com>
 <20190904020912.63925-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

updates inode naming
 - kill is_inode_layout_compression [1]
 - kill magic underscores [2] [3]
 - better naming for datamode & data_mapping_mode [3]
 - better naming erofs_inode_{compact, extended} [4]

[1] https://lore.kernel.org/r/20190829102426.GE20598@infradead.org/
[2] https://lore.kernel.org/r/20190829102426.GE20598@infradead.org/
[3] https://lore.kernel.org/r/20190902122627.GN15931@infradead.org/
[4] https://lore.kernel.org/r/20190902125438.GA17750@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/data.c     |   9 ++--
 fs/erofs/erofs_fs.h |  24 ++++-----
 fs/erofs/inode.c    | 126 +++++++++++++++++++++++++-------------------
 fs/erofs/internal.h |  31 ++++++-----
 fs/erofs/super.c    |   2 +-
 fs/erofs/zmap.c     |   6 +--
 6 files changed, 108 insertions(+), 90 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0983807737fd..4d9b07991d07 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -113,11 +113,12 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	erofs_blk_t nblocks, lastblk;
 	u64 offset = map->m_la;
 	struct erofs_vnode *vi = EROFS_V(inode);
+	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
 
 	trace_erofs_map_blocks_flatmode_enter(inode, map, flags);
 
 	nblocks = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
-	lastblk = nblocks - is_inode_flat_inline(inode);
+	lastblk = nblocks - tailendpacking;
 
 	if (offset >= inode->i_size) {
 		/* leave out-of-bound access unmapped */
@@ -132,7 +133,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	if (offset < blknr_to_addr(lastblk)) {
 		map->m_pa = blknr_to_addr(vi->raw_blkaddr) + map->m_la;
 		map->m_plen = blknr_to_addr(lastblk) - offset;
-	} else if (is_inode_flat_inline(inode)) {
+	} else if (tailendpacking) {
 		/* 2 - inode inline B: inode, [xattrs], inline last blk... */
 		struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 
@@ -169,7 +170,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 int erofs_map_blocks(struct inode *inode,
 		     struct erofs_map_blocks *map, int flags)
 {
-	if (is_inode_layout_compression(inode)) {
+	if (erofs_inode_is_data_compressed(EROFS_V(inode)->datalayout)) {
 		int err = z_erofs_map_blocks_iter(inode, map, flags);
 
 		if (map->mpage) {
@@ -403,7 +404,7 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
 
-	if (is_inode_flat_inline(inode)) {
+	if (EROFS_V(inode)->datalayout == EROFS_INODE_FLAT_INLINE) {
 		erofs_blk_t blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
 
 		if (block >> LOG_SECTORS_PER_BLOCK >= blks)
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index b2aef3bc377d..18689e916e94 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -41,7 +41,7 @@ struct erofs_super_block {
 };
 
 /*
- * erofs inode data mapping:
+ * erofs inode datalayout:
  * 0 - inode plain without inline data A:
  * inode, [xattrs], ... | ... | no-holed data
  * 1 - inode VLE compression B (legacy):
@@ -57,7 +57,7 @@ enum {
 	EROFS_INODE_FLAT_COMPRESSION_LEGACY	= 1,
 	EROFS_INODE_FLAT_INLINE			= 2,
 	EROFS_INODE_FLAT_COMPRESSION		= 3,
-	EROFS_INODE_LAYOUT_MAX
+	EROFS_INODE_DATALAYOUT_MAX
 };
 
 static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
@@ -68,14 +68,14 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 
 /* bit definitions of inode i_advise */
 #define EROFS_I_VERSION_BITS            1
-#define EROFS_I_DATA_MAPPING_BITS       3
+#define EROFS_I_DATALAYOUT_BITS         3
 
 #define EROFS_I_VERSION_BIT             0
-#define EROFS_I_DATA_MAPPING_BIT        1
+#define EROFS_I_DATALAYOUT_BIT          1
 
 /* 32-byte reduced form of an ondisk inode */
-struct erofs_inode_v1 {
-	__le16 i_advise;	/* inode hints */
+struct erofs_inode_compact {
+	__le16 i_format;	/* inode format hints */
 
 /* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
 	__le16 i_xattr_icount;
@@ -98,13 +98,13 @@ struct erofs_inode_v1 {
 };
 
 /* 32 bytes on-disk inode */
-#define EROFS_INODE_LAYOUT_V1   0
+#define EROFS_INODE_LAYOUT_COMPACT	0
 /* 64 bytes on-disk inode */
-#define EROFS_INODE_LAYOUT_V2   1
+#define EROFS_INODE_LAYOUT_EXTENDED	1
 
 /* 64-byte complete form of an ondisk inode */
-struct erofs_inode_v2 {
-	__le16 i_advise;	/* inode hints */
+struct erofs_inode_extended {
+	__le16 i_format;	/* inode format hints */
 
 /* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
 	__le16 i_xattr_icount;
@@ -299,8 +299,8 @@ struct erofs_dirent {
 static inline void erofs_check_ondisk_layout_definitions(void)
 {
 	BUILD_BUG_ON(sizeof(struct erofs_super_block) != 128);
-	BUILD_BUG_ON(sizeof(struct erofs_inode_v1) != 32);
-	BUILD_BUG_ON(sizeof(struct erofs_inode_v2) != 64);
+	BUILD_BUG_ON(sizeof(struct erofs_inode_compact) != 32);
+	BUILD_BUG_ON(sizeof(struct erofs_inode_extended) != 64);
 	BUILD_BUG_ON(sizeof(struct erofs_xattr_ibody_header) != 12);
 	BUILD_BUG_ON(sizeof(struct erofs_xattr_entry) != 4);
 	BUILD_BUG_ON(sizeof(struct z_erofs_map_header) != 8);
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 3fc4f764b387..494b35e5830a 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -12,73 +12,90 @@
 static int read_inode(struct inode *inode, void *data)
 {
 	struct erofs_vnode *vi = EROFS_V(inode);
-	struct erofs_inode_v1 *v1 = data;
-	const unsigned int advise = le16_to_cpu(v1->i_advise);
+	struct erofs_inode_compact *dic = data;
+	struct erofs_inode_extended *die;
+
+	const unsigned int ifmt = le16_to_cpu(dic->i_format);
+	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 	erofs_blk_t nblks = 0;
 
-	vi->datamode = __inode_data_mapping(advise);
+	vi->datalayout = erofs_inode_datalayout(ifmt);
 
-	if (vi->datamode >= EROFS_INODE_LAYOUT_MAX) {
-		errln("unsupported data mapping %u of nid %llu",
-		      vi->datamode, vi->nid);
+	if (vi->datalayout >= EROFS_INODE_DATALAYOUT_MAX) {
+		errln("unsupported datalayout %u of nid %llu",
+		      vi->datalayout, vi->nid);
 		DBG_BUGON(1);
 		return -EOPNOTSUPP;
 	}
 
-	if (__inode_version(advise) == EROFS_INODE_LAYOUT_V2) {
-		struct erofs_inode_v2 *v2 = data;
+	switch (erofs_inode_version(ifmt)) {
+	case EROFS_INODE_LAYOUT_EXTENDED:
+		die = data;
 
-		vi->inode_isize = sizeof(struct erofs_inode_v2);
-		vi->xattr_isize = erofs_xattr_ibody_size(v2->i_xattr_icount);
+		vi->inode_isize = sizeof(struct erofs_inode_extended);
+		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
 
-		inode->i_mode = le16_to_cpu(v2->i_mode);
-		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
-		    S_ISLNK(inode->i_mode))
-			vi->raw_blkaddr = le32_to_cpu(v2->i_u.raw_blkaddr);
-		else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+		inode->i_mode = le16_to_cpu(die->i_mode);
+		switch (inode->i_mode & S_IFMT) {
+		case S_IFREG:
+		case S_IFDIR:
+		case S_IFLNK:
+			vi->raw_blkaddr = le32_to_cpu(die->i_u.raw_blkaddr);
+			break;
+		case S_IFCHR:
+		case S_IFBLK:
 			inode->i_rdev =
-				new_decode_dev(le32_to_cpu(v2->i_u.rdev));
-		else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
+				new_decode_dev(le32_to_cpu(die->i_u.rdev));
+			break;
+		case S_IFIFO:
+		case S_IFSOCK:
 			inode->i_rdev = 0;
-		else
+			break;
+		default:
 			goto bogusimode;
-
-		i_uid_write(inode, le32_to_cpu(v2->i_uid));
-		i_gid_write(inode, le32_to_cpu(v2->i_gid));
-		set_nlink(inode, le32_to_cpu(v2->i_nlink));
+		}
+		i_uid_write(inode, le32_to_cpu(die->i_uid));
+		i_gid_write(inode, le32_to_cpu(die->i_gid));
+		set_nlink(inode, le32_to_cpu(die->i_nlink));
 
 		/* ns timestamp */
 		inode->i_mtime.tv_sec = inode->i_ctime.tv_sec =
-			le64_to_cpu(v2->i_ctime);
+			le64_to_cpu(die->i_ctime);
 		inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec =
-			le32_to_cpu(v2->i_ctime_nsec);
+			le32_to_cpu(die->i_ctime_nsec);
 
-		inode->i_size = le64_to_cpu(v2->i_size);
+		inode->i_size = le64_to_cpu(die->i_size);
 
 		/* total blocks for compressed files */
-		if (is_inode_layout_compression(inode))
-			nblks = le32_to_cpu(v2->i_u.compressed_blocks);
-	} else if (__inode_version(advise) == EROFS_INODE_LAYOUT_V1) {
-		struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
-
-		vi->inode_isize = sizeof(struct erofs_inode_v1);
-		vi->xattr_isize = erofs_xattr_ibody_size(v1->i_xattr_icount);
-
-		inode->i_mode = le16_to_cpu(v1->i_mode);
-		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
-		    S_ISLNK(inode->i_mode))
-			vi->raw_blkaddr = le32_to_cpu(v1->i_u.raw_blkaddr);
-		else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+		if (erofs_inode_is_data_compressed(vi->datalayout))
+			nblks = le32_to_cpu(die->i_u.compressed_blocks);
+		break;
+	case EROFS_INODE_LAYOUT_COMPACT:
+		vi->inode_isize = sizeof(struct erofs_inode_compact);
+		vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
+
+		inode->i_mode = le16_to_cpu(dic->i_mode);
+		switch (inode->i_mode & S_IFMT) {
+		case S_IFREG:
+		case S_IFDIR:
+		case S_IFLNK:
+			vi->raw_blkaddr = le32_to_cpu(dic->i_u.raw_blkaddr);
+			break;
+		case S_IFCHR:
+		case S_IFBLK:
 			inode->i_rdev =
-				new_decode_dev(le32_to_cpu(v1->i_u.rdev));
-		else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
+				new_decode_dev(le32_to_cpu(dic->i_u.rdev));
+			break;
+		case S_IFIFO:
+		case S_IFSOCK:
 			inode->i_rdev = 0;
-		else
+			break;
+		default:
 			goto bogusimode;
-
-		i_uid_write(inode, le16_to_cpu(v1->i_uid));
-		i_gid_write(inode, le16_to_cpu(v1->i_gid));
-		set_nlink(inode, le16_to_cpu(v1->i_nlink));
+		}
+		i_uid_write(inode, le16_to_cpu(dic->i_uid));
+		i_gid_write(inode, le16_to_cpu(dic->i_gid));
+		set_nlink(inode, le16_to_cpu(dic->i_nlink));
 
 		/* use build time to derive all file time */
 		inode->i_mtime.tv_sec = inode->i_ctime.tv_sec =
@@ -86,12 +103,13 @@ static int read_inode(struct inode *inode, void *data)
 		inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec =
 			sbi->build_time_nsec;
 
-		inode->i_size = le32_to_cpu(v1->i_size);
-		if (is_inode_layout_compression(inode))
-			nblks = le32_to_cpu(v1->i_u.compressed_blocks);
-	} else {
+		inode->i_size = le32_to_cpu(dic->i_size);
+		if (erofs_inode_is_data_compressed(vi->datalayout))
+			nblks = le32_to_cpu(dic->i_u.compressed_blocks);
+		break;
+	default:
 		errln("unsupported on-disk inode version %u of nid %llu",
-		      __inode_version(advise), vi->nid);
+		      erofs_inode_version(ifmt), vi->nid);
 		DBG_BUGON(1);
 		return -EOPNOTSUPP;
 	}
@@ -125,8 +143,8 @@ static int fill_inline_data(struct inode *inode, void *data,
 	struct erofs_vnode *vi = EROFS_V(inode);
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
 
-	/* should be inode inline C */
-	if (!is_inode_flat_inline(inode))
+	/* should be tail-packing data inline */
+	if (vi->datalayout != EROFS_INODE_FLAT_INLINE)
 		return 0;
 
 	/* fast symlink (following ext4) */
@@ -216,7 +234,7 @@ static int fill_inode(struct inode *inode, int isdir)
 			goto out_unlock;
 		}
 
-		if (is_inode_layout_compression(inode)) {
+		if (erofs_inode_is_data_compressed(vi->datalayout)) {
 			err = z_erofs_fill_inode(inode);
 			goto out_unlock;
 		}
@@ -299,7 +317,7 @@ int erofs_getattr(const struct path *path, struct kstat *stat,
 {
 	struct inode *const inode = d_inode(path->dentry);
 
-	if (is_inode_layout_compression(inode))
+	if (erofs_inode_is_data_compressed(EROFS_V(inode)->datalayout))
 		stat->attributes |= STATX_ATTR_COMPRESSED;
 
 	stat->attributes |= STATX_ATTR_IMMUTABLE;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 7ff36f404ec3..0f5cbf0a7570 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -285,7 +285,7 @@ struct erofs_vnode {
 	/* atomic flags (including bitlocks) */
 	unsigned long flags;
 
-	unsigned char datamode;
+	unsigned char datalayout;
 	unsigned char inode_isize;
 	unsigned short xattr_isize;
 
@@ -310,31 +310,30 @@ struct erofs_vnode {
 #define EROFS_V(ptr)	\
 	container_of(ptr, struct erofs_vnode, vfs_inode)
 
-#define __inode_advise(x, bit, bits) \
-	(((x) >> (bit)) & ((1 << (bits)) - 1))
-
-#define __inode_version(advise)	\
-	__inode_advise(advise, EROFS_I_VERSION_BIT,	\
-		EROFS_I_VERSION_BITS)
-
-#define __inode_data_mapping(advise)	\
-	__inode_advise(advise, EROFS_I_DATA_MAPPING_BIT,\
-		EROFS_I_DATA_MAPPING_BITS)
-
 static inline unsigned long inode_datablocks(struct inode *inode)
 {
 	/* since i_size cannot be changed */
 	return DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
 }
 
-static inline bool is_inode_layout_compression(struct inode *inode)
+static inline unsigned int erofs_bitrange(unsigned int value, unsigned int bit,
+					  unsigned int bits)
+{
+
+	return (value >> bit) & ((1 << bits) - 1);
+}
+
+
+static inline unsigned int erofs_inode_version(unsigned int value)
 {
-	return erofs_inode_is_data_compressed(EROFS_V(inode)->datamode);
+	return erofs_bitrange(value, EROFS_I_VERSION_BIT,
+			      EROFS_I_VERSION_BITS);
 }
 
-static inline bool is_inode_flat_inline(struct inode *inode)
+static inline unsigned int erofs_inode_datalayout(unsigned int value)
 {
-	return EROFS_V(inode)->datamode == EROFS_INODE_FLAT_INLINE;
+	return erofs_bitrange(value, EROFS_I_DATALAYOUT_BIT,
+			      EROFS_I_DATALAYOUT_BITS);
 }
 
 extern const struct super_operations erofs_sops;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6a7ab194783c..8d9f38d56b3b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -121,7 +121,7 @@ static int superblock_read(struct super_block *sb)
 #ifdef CONFIG_EROFS_FS_XATTR
 	sbi->xattr_blkaddr = le32_to_cpu(layout->xattr_blkaddr);
 #endif
-	sbi->islotbits = ffs(sizeof(struct erofs_inode_v1)) - 1;
+	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
 	sbi->root_nid = le16_to_cpu(layout->root_nid);
 	sbi->inos = le64_to_cpu(layout->inos);
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 850e0e3d57a8..6a06fb80ef3f 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -12,7 +12,7 @@ int z_erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_vnode *const vi = EROFS_V(inode);
 
-	if (vi->datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
+	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
@@ -46,7 +46,7 @@ static int fill_inode_lazy(struct inode *inode)
 	if (test_bit(EROFS_V_Z_INITED_BIT, &vi->flags))
 		goto out_unlock;
 
-	DBG_BUGON(vi->datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
+	DBG_BUGON(vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
 
 	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
 		    vi->xattr_isize, 8);
@@ -314,7 +314,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 static int vle_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 				      unsigned int lcn)
 {
-	const unsigned int datamode = EROFS_V(m->inode)->datamode;
+	const unsigned int datamode = EROFS_V(m->inode)->datalayout;
 
 	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
 		return vle_legacy_load_cluster_from_disk(m, lcn);
-- 
2.17.1

