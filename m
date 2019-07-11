Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64838659C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 16:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfGKO73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 10:59:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2257 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729221AbfGKO6r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:58:47 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 774B971A5E119F639DE1;
        Thu, 11 Jul 2019 22:58:43 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 11 Jul
 2019 22:58:32 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 13/24] erofs: add compression indexes support
Date:   Thu, 11 Jul 2019 22:57:44 +0800
Message-ID: <20190711145755.33908-14-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711145755.33908-1-gaoxiang25@huawei.com>
References: <20190711145755.33908-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds EROFS compression indexes support,
including legacy and compacted 2/4B indexes.

In addition, it introduces an iterable L2P mapping
operation called 'z_erofs_map_blocks_iter'.

Compared with 'erofs_map_blocks', it avoids a number
of redundant 'release and regrab' processes if they
request the same meta page.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/Kconfig             |   9 +
 fs/erofs/Makefile            |   1 +
 fs/erofs/inode.c             |   2 +-
 fs/erofs/internal.h          |  35 ++-
 fs/erofs/zmap.c              | 460 +++++++++++++++++++++++++++++++++++
 include/trace/events/erofs.h |  17 +-
 6 files changed, 521 insertions(+), 3 deletions(-)
 create mode 100644 fs/erofs/zmap.c

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index b6a4384936b3..f6b6eb0250b8 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -80,3 +80,12 @@ config EROFS_FS_SECURITY
 
 	  If you are not using a security module, say N.
 
+config EROFS_FS_ZIP
+	bool "EROFS Data Compresssion Support"
+	depends on EROFS_FS
+	select LZ4_DECOMPRESS
+	help
+	  Enable fixed-sized output compression for EROFS.
+
+	  If you don't want to enable compression feature, say N.
+
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index fc5d1cd3345f..9ab4ccc9328e 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -7,4 +7,5 @@ ccflags-y += -DEROFS_VERSION=\"$(EROFS_VERSION)\"
 obj-$(CONFIG_EROFS_FS) += erofs.o
 erofs-objs := super.o inode.o data.o namei.o dir.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
+erofs-$(CONFIG_EROFS_FS_ZIP) += zmap.o
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 8fa5cdf6c0de..3b916008b620 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -205,7 +205,7 @@ static int fill_inode(struct inode *inode, int isdir)
 		}
 
 		if (is_inode_layout_compression(inode)) {
-			err = -ENOTSUPP;
+			err = z_erofs_fill_inode(inode);
 			goto out_unlock;
 		}
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index ccef7f2a7cf3..f0a5fd316e09 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -171,9 +171,12 @@ static inline erofs_off_t iloc(struct erofs_sb_info *sbi, erofs_nid_t nid)
 
 /* atomic flag definitions */
 #define EROFS_V_EA_INITED_BIT	0
+#define EROFS_V_Z_INITED_BIT	1
 
 /* bitlock definitions (arranged in reverse order) */
 #define EROFS_V_BL_XATTR_BIT	(BITS_PER_LONG - 1)
+#define EROFS_V_BL_Z_BIT	(BITS_PER_LONG - 2)
+
 struct erofs_vnode {
 	erofs_nid_t nid;
 
@@ -187,7 +190,17 @@ struct erofs_vnode {
 	unsigned xattr_shared_count;
 	unsigned *xattr_shared_xattrs;
 
-	erofs_blk_t raw_blkaddr;
+	union {
+		erofs_blk_t raw_blkaddr;
+#ifdef CONFIG_EROFS_FS_ZIP
+		struct {
+			unsigned short z_advise;
+			unsigned char  z_algorithmtype[2];
+			unsigned char  z_logical_clusterbits;
+			unsigned char  z_physical_clusterbits[2];
+		};
+#endif
+	};
 	/* the corresponding vfs inode */
 	struct inode vfs_inode;
 };
@@ -260,6 +273,10 @@ enum {
 #define EROFS_MAP_MAPPED	(1 << BH_Mapped)
 /* Located in metadata (could be copied from bd_inode) */
 #define EROFS_MAP_META		(1 << BH_Meta)
+/* The extent has been compressed */
+#define EROFS_MAP_ZIPPED	(1 << BH_Zipped)
+/* The length of extent is full */
+#define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
 
 struct erofs_map_blocks {
 	erofs_off_t m_pa, m_la;
@@ -273,6 +290,22 @@ struct erofs_map_blocks {
 /* Flags used by erofs_map_blocks() */
 #define EROFS_GET_BLOCKS_RAW    0x0001
 
+/* zmap.c */
+#ifdef CONFIG_EROFS_FS_ZIP
+int z_erofs_fill_inode(struct inode *inode);
+int z_erofs_map_blocks_iter(struct inode *inode,
+			    struct erofs_map_blocks *map,
+			    int flags);
+#else
+static inline int z_erofs_fill_inode(struct inode *inode) { return -ENOTSUPP; }
+static inline int z_erofs_map_blocks_iter(struct inode *inode,
+					  struct erofs_map_blocks *map,
+					  int flags)
+{
+	return -ENOTSUPP;
+}
+#endif
+
 /* data.c */
 static inline struct bio *erofs_grab_bio(struct super_block *sb,
 					 erofs_blk_t blkaddr,
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
new file mode 100644
index 000000000000..006f09ce83a1
--- /dev/null
+++ b/fs/erofs/zmap.c
@@ -0,0 +1,460 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * linux/fs/erofs/zmap.c
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#include "internal.h"
+#include <asm/unaligned.h>
+#include <trace/events/erofs.h>
+
+int z_erofs_fill_inode(struct inode *inode)
+{
+	struct erofs_vnode *const vi = EROFS_V(inode);
+
+	if (vi->datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
+		vi->z_advise = 0;
+		vi->z_algorithmtype[0] = 0;
+		vi->z_algorithmtype[1] = 0;
+		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
+		vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits;
+		vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits;
+		set_bit(EROFS_V_Z_INITED_BIT, &vi->flags);
+	}
+	return -ENOTSUPP;
+}
+
+static int fill_inode_lazy(struct inode *inode)
+{
+	struct erofs_vnode *const vi = EROFS_V(inode);
+	struct super_block *const sb = inode->i_sb;
+	int err;
+	erofs_off_t pos;
+	struct page *page;
+	void *kaddr;
+	struct z_erofs_map_header *h;
+
+	if (test_bit(EROFS_V_Z_INITED_BIT, &vi->flags))
+		return 0;
+
+	if (wait_on_bit_lock(&vi->flags, EROFS_V_BL_Z_BIT, TASK_KILLABLE))
+		return -ERESTARTSYS;
+
+	err = 0;
+	if (test_bit(EROFS_V_Z_INITED_BIT, &vi->flags))
+		goto out_unlock;
+
+	DBG_BUGON(vi->datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
+
+	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
+		    vi->xattr_isize, 8);
+	page = erofs_get_meta_page(sb, erofs_blknr(pos), false);
+	if (IS_ERR(page)) {
+		err = PTR_ERR(page);
+		goto out_unlock;
+	}
+
+	kaddr = kmap_atomic(page);
+
+	h = kaddr + erofs_blkoff(pos);
+	vi->z_advise = le16_to_cpu(h->h_advise);
+	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
+	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
+
+	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
+		errln("unknown compression format %u for nid %llu, please upgrade kernel",
+		      vi->z_algorithmtype[0], vi->nid);
+		err = -ENOTSUPP;
+		goto unmap_done;
+	}
+
+	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
+	vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits +
+					((h->h_clusterbits >> 3) & 3);
+
+	if (vi->z_physical_clusterbits[0] != LOG_BLOCK_SIZE) {
+		errln("unsupported physical clusterbits %u for nid %llu, please upgrade kernel",
+		      vi->z_physical_clusterbits[0], vi->nid);
+		err = -ENOTSUPP;
+		goto unmap_done;
+	}
+
+	vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits +
+					((h->h_clusterbits >> 5) & 7);
+unmap_done:
+	kunmap_atomic(kaddr);
+	unlock_page(page);
+	put_page(page);
+
+	set_bit(EROFS_V_Z_INITED_BIT, &vi->flags);
+out_unlock:
+	clear_and_wake_up_bit(EROFS_V_BL_Z_BIT, &vi->flags);
+	return err;
+}
+
+struct z_erofs_maprecorder {
+	struct inode *inode;
+	struct erofs_map_blocks *map;
+	void *kaddr;
+
+	unsigned long lcn;
+	/* compression extent information gathered */
+	u8  type;
+	u16 clusterofs;
+	u16 delta[2];
+	erofs_blk_t pblk;
+};
+
+static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
+				  erofs_blk_t eblk)
+{
+	struct super_block *const sb = m->inode->i_sb;
+	struct erofs_map_blocks *const map = m->map;
+	struct page *mpage = map->mpage;
+
+	if (mpage) {
+		if (mpage->index == eblk) {
+			if (!m->kaddr)
+				m->kaddr = kmap_atomic(mpage);
+			return 0;
+		}
+
+		if (m->kaddr) {
+			kunmap_atomic(m->kaddr);
+			m->kaddr = NULL;
+		}
+		put_page(mpage);
+	}
+
+	mpage = erofs_get_meta_page(sb, eblk, false);
+	if (IS_ERR(mpage)) {
+		map->mpage = NULL;
+		return PTR_ERR(mpage);
+	}
+	m->kaddr = kmap_atomic(mpage);
+	unlock_page(mpage);
+	map->mpage = mpage;
+	return 0;
+}
+
+static int vle_legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
+					     unsigned long lcn)
+{
+	struct inode *const inode = m->inode;
+	struct erofs_vnode *const vi = EROFS_V(inode);
+	const erofs_off_t ibase = iloc(EROFS_I_SB(inode), vi->nid);
+	const erofs_off_t pos =
+		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(ibase + vi->inode_isize +
+					       vi->xattr_isize) +
+		lcn * sizeof(struct z_erofs_vle_decompressed_index);
+	struct z_erofs_vle_decompressed_index *di;
+	unsigned int advise, type;
+	int err;
+
+	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
+	if (err)
+		return err;
+
+	m->lcn = lcn;
+	di = m->kaddr + erofs_blkoff(pos);
+
+	advise = le16_to_cpu(di->di_advise);
+	type = (advise >> Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT) &
+		((1 << Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) - 1);
+	switch (type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		m->clusterofs = 1 << vi->z_logical_clusterbits;
+		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
+		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
+		break;
+	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		m->clusterofs = le16_to_cpu(di->di_clusterofs);
+		m->pblk = le32_to_cpu(di->di_u.blkaddr);
+		break;
+	default:
+		DBG_BUGON(1);
+		return -EIO;
+	}
+	m->type = type;
+	return 0;
+}
+
+static unsigned int decode_compactedbits(unsigned int lobits,
+					 unsigned int lomask,
+					 u8 *in, unsigned int pos, u8 *type)
+{
+	const unsigned int v = get_unaligned_le32(in + pos / 8) >> (pos & 7);
+	const unsigned int lo = v & lomask;
+
+	*type = (v >> lobits) & 3;
+	return lo;
+}
+
+static int unpack_compacted_index(struct z_erofs_maprecorder *m,
+				  unsigned int amortizedshift,
+				  unsigned int eofs)
+{
+	struct erofs_vnode *const vi = EROFS_V(m->inode);
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const unsigned int lomask = (1 << lclusterbits) - 1;
+	unsigned int vcnt, base, lo, encodebits, nblk;
+	int i;
+	u8 *in, type;
+
+	if (1 << amortizedshift == 4)
+		vcnt = 2;
+	else if (1 << amortizedshift == 2 && lclusterbits == 12)
+		vcnt = 16;
+	else
+		return -ENOTSUPP;
+
+	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
+	base = round_down(eofs, vcnt << amortizedshift);
+	in = m->kaddr + base;
+
+	i = (eofs - base) >> amortizedshift;
+
+	lo = decode_compactedbits(lclusterbits, lomask,
+				  in, encodebits * i, &type);
+	m->type = type;
+	if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+		m->clusterofs = 1 << lclusterbits;
+		if (i + 1 != vcnt) {
+			m->delta[0] = lo;
+			return 0;
+		}
+		/*
+		 * since the last lcluster in the pack is special,
+		 * of which lo saves delta[1] rather than delta[0].
+		 * Hence, get delta[0] by the previous lcluster indirectly.
+		 */
+		lo = decode_compactedbits(lclusterbits, lomask,
+					  in, encodebits * (i - 1), &type);
+		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+			lo = 0;
+		m->delta[0] = lo + 1;
+		return 0;
+	}
+	m->clusterofs = lo;
+	m->delta[0] = 0;
+	/* figout out blkaddr (pblk) for HEAD lclusters */
+	nblk = 1;
+	while (i > 0) {
+		--i;
+		lo = decode_compactedbits(lclusterbits, lomask,
+					  in, encodebits * i, &type);
+		if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+			i -= lo;
+
+		if (i >= 0)
+			++nblk;
+	}
+	in += (vcnt << amortizedshift) - sizeof(__le32);
+	m->pblk = le32_to_cpu(*(__le32 *)in) + nblk;
+	return 0;
+}
+
+static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
+					    unsigned long lcn)
+{
+	struct inode *const inode = m->inode;
+	struct erofs_vnode *const vi = EROFS_V(inode);
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const erofs_off_t ebase = ALIGN(iloc(EROFS_I_SB(inode), vi->nid) +
+					vi->inode_isize + vi->xattr_isize, 8) +
+		sizeof(struct z_erofs_map_header);
+	const unsigned int totalidx = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
+	unsigned int compacted_4b_initial, compacted_2b;
+	unsigned int amortizedshift;
+	erofs_off_t pos;
+	int err;
+
+	if (lclusterbits != 12)
+		return -ENOTSUPP;
+
+	if (lcn >= totalidx)
+		return -EINVAL;
+
+	m->lcn = lcn;
+	/* used to align to 32-byte (compacted_2b) alignment */
+	compacted_4b_initial = (32 - ebase % 32) / 4;
+	if (compacted_4b_initial == 32 / 4)
+		compacted_4b_initial = 0;
+
+	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
+		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
+	else
+		compacted_2b = 0;
+
+	pos = ebase;
+	if (lcn < compacted_4b_initial) {
+		amortizedshift = 2;
+		goto out;
+	}
+	pos += compacted_4b_initial * 4;
+	lcn -= compacted_4b_initial;
+
+	if (lcn < compacted_2b) {
+		amortizedshift = 1;
+		goto out;
+	}
+	pos += compacted_2b * 2;
+	lcn -= compacted_2b;
+	amortizedshift = 2;
+out:
+	pos += lcn * (1 << amortizedshift);
+	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
+	if (err)
+		return err;
+	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos));
+}
+
+static int vle_load_cluster_from_disk(struct z_erofs_maprecorder *m,
+				      unsigned int lcn)
+{
+	const unsigned int datamode = EROFS_V(m->inode)->datamode;
+
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+		return vle_legacy_load_cluster_from_disk(m, lcn);
+
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
+		return compacted_load_cluster_from_disk(m, lcn);
+
+	return -EINVAL;
+}
+
+static int vle_extent_lookback(struct z_erofs_maprecorder *m,
+			       unsigned int lookback_distance)
+{
+	struct erofs_vnode *const vi = EROFS_V(m->inode);
+	struct erofs_map_blocks *const map = m->map;
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	unsigned long lcn = m->lcn;
+	int err;
+
+	if (lcn < lookback_distance) {
+		DBG_BUGON(1);
+		return -EIO;
+	}
+
+	/* load extent head logical cluster if needed */
+	lcn -= lookback_distance;
+	err = vle_load_cluster_from_disk(m, lcn);
+	if (err)
+		return err;
+
+	switch (m->type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		return vle_extent_lookback(m, m->delta[0]);
+	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
+		map->m_flags &= ~EROFS_MAP_ZIPPED;
+		/* fallthrough */
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		map->m_la = (lcn << lclusterbits) | m->clusterofs;
+		break;
+	default:
+		errln("unknown type %u at lcn %lu of nid %llu",
+		      m->type, lcn, vi->nid);
+		DBG_BUGON(1);
+		return -EIO;
+	}
+	return 0;
+}
+
+int z_erofs_map_blocks_iter(struct inode *inode,
+			    struct erofs_map_blocks *map,
+			    int flags)
+{
+	struct erofs_vnode *const vi = EROFS_V(inode);
+	struct z_erofs_maprecorder m = {
+		.inode = inode,
+		.map = map,
+	};
+	int err = 0;
+	unsigned int lclusterbits, endoff;
+	unsigned long long ofs, end;
+
+	trace_z_erofs_map_blocks_iter_enter(inode, map, flags);
+
+	/* when trying to read beyond EOF, leave it unmapped */
+	if (unlikely(map->m_la >= inode->i_size)) {
+		map->m_llen = map->m_la + 1 - inode->i_size;
+		map->m_la = inode->i_size;
+		map->m_flags = 0;
+		goto out;
+	}
+
+	err = fill_inode_lazy(inode);
+	if (err)
+		goto out;
+
+	lclusterbits = vi->z_logical_clusterbits;
+	ofs = map->m_la;
+	m.lcn = ofs >> lclusterbits;
+	endoff = ofs & ((1 << lclusterbits) - 1);
+
+	err = vle_load_cluster_from_disk(&m, m.lcn);
+	if (err)
+		goto unmap_out;
+
+	map->m_flags = EROFS_MAP_ZIPPED;	/* by default, compressed */
+	end = (m.lcn + 1ULL) << lclusterbits;
+
+	switch (m.type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
+		if (endoff >= m.clusterofs)
+			map->m_flags &= ~EROFS_MAP_ZIPPED;
+		/* fallthrough */
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		if (endoff >= m.clusterofs) {
+			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
+			break;
+		}
+		/* m.lcn should be >= 1 if endoff < m.clusterofs */
+		if (unlikely(!m.lcn)) {
+			errln("invalid logical cluster 0 at nid %llu",
+			      vi->nid);
+			err = -EIO;
+			goto unmap_out;
+		}
+		end = (m.lcn << lclusterbits) | m.clusterofs;
+		map->m_flags |= EROFS_MAP_FULL_MAPPED;
+		m.delta[0] = 1;
+		/* fallthrough */
+	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		/* get the correspoinding first chunk */
+		err = vle_extent_lookback(&m, m.delta[0]);
+		if (unlikely(err))
+			goto unmap_out;
+		break;
+	default:
+		errln("unknown type %u at offset %llu of nid %llu",
+		      m.type, ofs, vi->nid);
+		err = -EIO;
+		goto unmap_out;
+	}
+
+	map->m_llen = end - map->m_la;
+	map->m_plen = 1 << lclusterbits;
+	map->m_pa = blknr_to_addr(m.pblk);
+	map->m_flags |= EROFS_MAP_MAPPED;
+
+unmap_out:
+	if (m.kaddr)
+		kunmap_atomic(m.kaddr);
+
+out:
+	debugln("%s, m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
+		__func__, map->m_la, map->m_pa,
+		map->m_llen, map->m_plen, map->m_flags);
+
+	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
+
+	/* aggressively BUG_ON iff CONFIG_EROFS_FS_DEBUG is on */
+	DBG_BUGON(err < 0 && err != -ENOMEM);
+	return err;
+}
+
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index 188c28e48289..660c92fc1803 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -20,7 +20,8 @@
 
 #define show_mflags(flags) __print_flags(flags, "",	\
 	{ EROFS_MAP_MAPPED,	"M" },			\
-	{ EROFS_MAP_META,	"I" })
+	{ EROFS_MAP_META,	"I" },			\
+	{ EROFS_MAP_ZIPPED,	"Z" })
 
 TRACE_EVENT(erofs_lookup,
 
@@ -172,6 +173,13 @@ DEFINE_EVENT(erofs__map_blocks_enter, erofs_map_blocks_flatmode_enter,
 	TP_ARGS(inode, map, flags)
 );
 
+DEFINE_EVENT(erofs__map_blocks_enter, z_erofs_map_blocks_iter_enter,
+	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
+		 unsigned int flags),
+
+	TP_ARGS(inode, map, flags)
+);
+
 DECLARE_EVENT_CLASS(erofs__map_blocks_exit,
 	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
 		 unsigned int flags, int ret),
@@ -217,6 +225,13 @@ DEFINE_EVENT(erofs__map_blocks_exit, erofs_map_blocks_flatmode_exit,
 	TP_ARGS(inode, map, flags, ret)
 );
 
+DEFINE_EVENT(erofs__map_blocks_exit, z_erofs_map_blocks_iter_exit,
+	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
+		 unsigned int flags, int ret),
+
+	TP_ARGS(inode, map, flags, ret)
+);
+
 TRACE_EVENT(erofs_destroy_inode,
 	TP_PROTO(struct inode *inode),
 
-- 
2.17.1

