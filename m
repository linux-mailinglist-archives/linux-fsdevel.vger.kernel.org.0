Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73FA3E0B46
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 02:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbhHEAgg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 20:36:36 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:40296 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236345AbhHEAgf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 20:36:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Ui.Crlc_1628123764;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ui.Crlc_1628123764)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Aug 2021 08:36:20 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Huang Jianan <huangjianan@oppo.com>,
        Tao Ma <boyu.mt@taobao.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 1/3] erofs: iomap support for non-tailpacking DIO
Date:   Thu,  5 Aug 2021 08:35:59 +0800
Message-Id: <20210805003601.183063-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210805003601.183063-1-hsiangkao@linux.alibaba.com>
References: <20210805003601.183063-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Huang Jianan <huangjianan@oppo.com>

Add iomap support for non-tailpacking uncompressed data in order to
support DIO and DAX.

Direct I/O is useful in certain scenarios for uncompressed files.
For example, double pagecache can be avoid by direct I/O when
loop device is used for uncompressed files containing upper layer
compressed filesystem.

This adds iomap DIO support for non-tailpacking cases first and
tail-packing inline files are handled in the follow-up patch.

Cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/Kconfig    |  1 +
 fs/erofs/data.c     | 94 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/inode.c    |  5 ++-
 fs/erofs/internal.h |  1 +
 4 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 906af0c1998c..14b747026742 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -3,6 +3,7 @@
 config EROFS_FS
 	tristate "EROFS filesystem support"
 	depends on BLOCK
+	select FS_IOMAP
 	select LIBCRC32C
 	help
 	  EROFS (Enhanced Read-Only File System) is a lightweight
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 3787a5fb0a42..154bd25da6e2 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -5,6 +5,7 @@
  */
 #include "internal.h"
 #include <linux/prefetch.h>
+#include <linux/iomap.h>
 
 #include <trace/events/erofs.h>
 
@@ -308,9 +309,102 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
 	return 0;
 }
 
+static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	int ret;
+	struct erofs_map_blocks map;
+
+	map.m_la = offset;
+	map.m_llen = length;
+
+	ret = erofs_map_blocks_flatmode(inode, &map, EROFS_GET_BLOCKS_RAW);
+	if (ret < 0)
+		return ret;
+
+	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->offset = map.m_la;
+	iomap->length = map.m_llen;
+	iomap->flags = 0;
+
+	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+		iomap->type = IOMAP_HOLE;
+		iomap->addr = IOMAP_NULL_ADDR;
+		if (!iomap->length)
+			iomap->length = length;
+		return 0;
+	}
+
+	/* that shouldn't happen for now */
+	if (map.m_flags & EROFS_MAP_META) {
+		DBG_BUGON(1);
+		return -ENOTBLK;
+	}
+	iomap->type = IOMAP_MAPPED;
+	iomap->addr = map.m_pa;
+	return 0;
+}
+
+const struct iomap_ops erofs_iomap_ops = {
+	.iomap_begin = erofs_iomap_begin,
+};
+
+static int erofs_prepare_dio(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	loff_t align = iocb->ki_pos | iov_iter_count(to) |
+		iov_iter_alignment(to);
+	struct block_device *bdev = inode->i_sb->s_bdev;
+	unsigned int blksize_mask;
+
+	if (bdev)
+		blksize_mask = (1 << ilog2(bdev_logical_block_size(bdev))) - 1;
+	else
+		blksize_mask = (1 << inode->i_blkbits) - 1;
+
+	if (align & blksize_mask)
+		return -EINVAL;
+
+	/*
+	 * Temporarily fall back tail-packing inline to buffered I/O instead
+	 * since tail-packing inline support relies on an iomap core update.
+	 */
+	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE &&
+	    iocb->ki_pos + iov_iter_count(to) >
+			rounddown(inode->i_size, EROFS_BLKSIZ))
+		return 1;
+	return 0;
+}
+
+static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	/* no need taking (shared) inode lock since it's a ro filesystem */
+	if (!iov_iter_count(to))
+		return 0;
+
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		int err = erofs_prepare_dio(iocb, to);
+
+		if (!err)
+			return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
+					    NULL, 0);
+		if (err < 0)
+			return err;
+	}
+	return filemap_read(iocb, to, 0);
+}
+
 /* for uncompressed (aligned) files and raw access for other files */
 const struct address_space_operations erofs_raw_access_aops = {
 	.readpage = erofs_raw_access_readpage,
 	.readahead = erofs_raw_access_readahead,
 	.bmap = erofs_bmap,
+	.direct_IO = noop_direct_IO,
+};
+
+const struct file_operations erofs_file_fops = {
+	.llseek		= generic_file_llseek,
+	.read_iter	= erofs_file_read_iter,
+	.mmap		= generic_file_readonly_mmap,
+	.splice_read	= generic_file_splice_read,
 };
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index aa8a0d770ba3..f296e1a2661e 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -247,7 +247,10 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_op = &erofs_generic_iops;
-		inode->i_fop = &generic_ro_fops;
+		if (erofs_inode_is_data_compressed(vi->datalayout))
+			inode->i_fop = &generic_ro_fops;
+		else
+			inode->i_fop = &erofs_file_fops;
 		break;
 	case S_IFDIR:
 		inode->i_op = &erofs_dir_iops;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 543c2ff97d30..2669c785d548 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -371,6 +371,7 @@ static inline int z_erofs_map_blocks_iter(struct inode *inode,
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 /* data.c */
+extern const struct file_operations erofs_file_fops;
 struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr);
 
 /* inode.c */
-- 
2.24.4

