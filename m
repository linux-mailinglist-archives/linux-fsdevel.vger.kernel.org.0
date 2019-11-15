Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5ABFE283
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 17:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfKOQRd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 11:17:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:36822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727461AbfKOQRb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:17:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7517B150;
        Fri, 15 Nov 2019 16:17:29 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 2/7] btrfs: basic direct I/O read operation
Date:   Fri, 15 Nov 2019 10:16:55 -0600
Message-Id: <20191115161700.12305-3-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191115161700.12305-1-rgoldwyn@suse.de>
References: <20191115161700.12305-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

We will be getting rid of calling blockdev_direct_io. So, we need
to make sure we perform btrfs_direct_read() to cover the reads.

Introduce iomap begin function which calls get_iomap() to convert
the position to iomap. Use iomap_dio_rw() to perform the direct
reads.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 435a502a3226..eede9dcbb4b6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -16,6 +16,7 @@
 #include <linux/btrfs.h>
 #include <linux/uio.h>
 #include <linux/iversion.h>
+#include <linux/iomap.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
@@ -3415,6 +3416,57 @@ static int find_desired_extent(struct inode *inode, loff_t *offset, int whence)
 	return ret;
 }
 
+/*
+ * get_iomap: Get the block map and fill the iomap structure
+ * @pos: file position
+ * @length: I/O length
+ * @iomap: The iomap structure to fill
+ */
+
+static int get_iomap(struct inode *inode, loff_t pos, loff_t length,
+		struct iomap *iomap)
+{
+	struct extent_map *em;
+	iomap->addr = IOMAP_NULL_ADDR;
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, pos, length, 0);
+	if (IS_ERR(em))
+		return PTR_ERR(em);
+	/* XXX Do we need to check for em->flags here? */
+	if (em->block_start == EXTENT_MAP_HOLE) {
+		iomap->type = IOMAP_HOLE;
+	} else {
+		iomap->addr = em->block_start;
+		iomap->type = IOMAP_MAPPED;
+	}
+	iomap->offset = em->start;
+	iomap->bdev = em->bdev;
+	iomap->length = em->len;
+	free_extent_map(em);
+	return 0;
+}
+
+static int btrfs_dio_iomap_begin(struct inode *inode, loff_t pos,
+		loff_t length, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap)
+{
+	return get_iomap(inode, pos, length, iomap);
+}
+
+static const struct iomap_ops btrfs_dio_iomap_ops = {
+	.iomap_begin            = btrfs_dio_iomap_begin,
+};
+
+static ssize_t btrfs_dio_iomap_read(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	ssize_t ret;
+	inode_lock_shared(inode);
+	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, NULL,
+			is_sync_kiocb(iocb));
+	inode_unlock_shared(inode);
+	return ret;
+}
+
 static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
@@ -3452,9 +3504,20 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 	return generic_file_open(inode, filp);
 }
 
+static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	ssize_t ret = 0;
+	if (iocb->ki_flags & IOCB_DIRECT)
+		ret = btrfs_dio_iomap_read(iocb, to);
+	if (ret < 0)
+		return ret;
+
+	return generic_file_buffered_read(iocb, to, ret);
+}
+
 const struct file_operations btrfs_file_operations = {
 	.llseek		= btrfs_file_llseek,
-	.read_iter      = generic_file_read_iter,
+	.read_iter      = btrfs_file_read_iter,
 	.splice_read	= generic_file_splice_read,
 	.write_iter	= btrfs_file_write_iter,
 	.mmap		= btrfs_file_mmap,
-- 
2.16.4

