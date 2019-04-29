Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24B29E8E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 19:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfD2R1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 13:27:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:58054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728798AbfD2R1O (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:27:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E5F2DAD78;
        Mon, 29 Apr 2019 17:27:11 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     kilobyte@angband.pl, linux-fsdevel@vger.kernel.org, jack@suse.cz,
        david@fromorbit.com, willy@infradead.org, hch@lst.de,
        darrick.wong@oracle.com, dsterba@suse.cz, nborisov@suse.com,
        linux-nvdimm@lists.01.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 03/18] btrfs: basic dax read
Date:   Mon, 29 Apr 2019 12:26:34 -0500
Message-Id: <20190429172649.8288-4-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190429172649.8288-1-rgoldwyn@suse.de>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Perform a basic read using iomap support. The btrfs_iomap_begin()
finds the extent at the position and fills the iomap data
structure with the values.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/Makefile |  1 +
 fs/btrfs/ctree.h  |  5 +++++
 fs/btrfs/dax.c    | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/file.c   | 11 ++++++++++-
 4 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 fs/btrfs/dax.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index ca693dd554e9..1fa77b875ae9 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -12,6 +12,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o
 
+btrfs-$(CONFIG_FS_DAX) += dax.o
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
 btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9512f49262dd..b7bbe5130a3b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3795,6 +3795,11 @@ int btrfs_reada_wait(void *handle);
 void btrfs_reada_detach(void *handle);
 int btree_readahead_hook(struct extent_buffer *eb, int err);
 
+#ifdef CONFIG_FS_DAX
+/* dax.c */
+ssize_t btrfs_file_dax_read(struct kiocb *iocb, struct iov_iter *to);
+#endif /* CONFIG_FS_DAX */
+
 static inline int is_fstree(u64 rootid)
 {
 	if (rootid == BTRFS_FS_TREE_OBJECTID ||
diff --git a/fs/btrfs/dax.c b/fs/btrfs/dax.c
new file mode 100644
index 000000000000..bf3d46b0acb6
--- /dev/null
+++ b/fs/btrfs/dax.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DAX support for BTRFS
+ *
+ * Copyright (c) 2019  SUSE Linux
+ * Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
+ */
+
+#ifdef CONFIG_FS_DAX
+#include <linux/dax.h>
+#include <linux/iomap.h>
+#include "ctree.h"
+#include "btrfs_inode.h"
+
+static int btrfs_iomap_begin(struct inode *inode, loff_t pos,
+		loff_t length, unsigned flags, struct iomap *iomap)
+{
+	struct extent_map *em;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, pos, length, 0);
+	if (em->block_start == EXTENT_MAP_HOLE) {
+		iomap->type = IOMAP_HOLE;
+		return 0;
+	}
+	iomap->type = IOMAP_MAPPED;
+	iomap->bdev = em->bdev;
+	iomap->dax_dev = fs_info->dax_dev;
+	iomap->offset = em->start;
+	iomap->length = em->len;
+	iomap->addr = em->block_start;
+	return 0;
+}
+
+static const struct iomap_ops btrfs_iomap_ops = {
+	.iomap_begin		= btrfs_iomap_begin,
+};
+
+ssize_t btrfs_file_dax_read(struct kiocb *iocb, struct iov_iter *to)
+{
+	ssize_t ret;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	inode_lock_shared(inode);
+	ret = dax_iomap_rw(iocb, to, &btrfs_iomap_ops);
+	inode_unlock_shared(inode);
+
+	return ret;
+}
+#endif /* CONFIG_FS_DAX */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 34fe8a58b0e9..9194591f9eea 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3288,9 +3288,18 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 	return generic_file_open(inode, filp);
 }
 
+static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+#ifdef CONFIG_FS_DAX
+	if (IS_DAX(file_inode(iocb->ki_filp)))
+		return btrfs_file_dax_read(iocb, to);
+#endif
+	return generic_file_read_iter(iocb, to);
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

