Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C5D6EC597
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 07:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjDXFw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 01:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjDXFwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:52:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9EE49E9;
        Sun, 23 Apr 2023 22:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZxrNtpoBTvtP7plF9L87gD1yTRTHFh9iF/vNVL4siZQ=; b=svYyaAsphxiqnP9jqAOpBkttbR
        N4Ce8N0Ipc/1VxOyM21RB2j/4GE46fi7rPsZ/z1UMNlV0FENWCFo4TFofunTPQab63OS+vC8+0r4z
        hNJjpAId1J1jbvucbaAE6fV27/R4fhpVu5H1IriwlKdIaxd8UWY0fze6AeJoC5Wux4wA6DOdBfJV/
        9QBAIqYsEHvTTGlu3tsn7/reirVjk9O5IcYBT4D3udLtU/4kwAjJc3xmhDgsmL5rDcCgwN2uJGzDG
        KQwVXSDnqxUa58BQqn6skOJxcFlaZ/v1U7wXLo1TLgUnW2kFsMlx1Z5MV0IO7GbI68rB6QW8Dmxth
        S+MAaziw==;
Received: from [2001:4bb8:189:a74f:e8a5:5f73:6d2:23b8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pqp5h-00FPEY-0T;
        Mon, 24 Apr 2023 05:50:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] fs: add CONFIG_BUFFER_HEAD
Date:   Mon, 24 Apr 2023 07:49:26 +0200
Message-Id: <20230424054926.26927-18-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424054926.26927-1-hch@lst.de>
References: <20230424054926.26927-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new config option that controls building the buffer_head code, and
select it from all file systems and stacking drivers that need it.

For the block device nodes and alternative iomap based buffered I/O path
is provided when buffer_head support is not enabled, and iomap needs a
little tweak to be able to compile out the buffer_head based code path.

Otherwise this is just Kconfig and ifdef changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c                 | 71 +++++++++++++++++++++++++++++++-----
 drivers/md/Kconfig           |  1 +
 fs/Kconfig                   |  4 ++
 fs/Makefile                  |  2 +-
 fs/adfs/Kconfig              |  1 +
 fs/affs/Kconfig              |  1 +
 fs/befs/Kconfig              |  1 +
 fs/bfs/Kconfig               |  1 +
 fs/efs/Kconfig               |  1 +
 fs/exfat/Kconfig             |  1 +
 fs/ext2/Kconfig              |  1 +
 fs/ext4/Kconfig              |  1 +
 fs/f2fs/Kconfig              |  1 +
 fs/fat/Kconfig               |  1 +
 fs/freevxfs/Kconfig          |  1 +
 fs/gfs2/Kconfig              |  1 +
 fs/hfs/Kconfig               |  1 +
 fs/hfsplus/Kconfig           |  1 +
 fs/hpfs/Kconfig              |  1 +
 fs/iomap/buffered-io.c       | 12 ++++--
 fs/isofs/Kconfig             |  1 +
 fs/jfs/Kconfig               |  1 +
 fs/minix/Kconfig             |  1 +
 fs/nilfs2/Kconfig            |  1 +
 fs/ntfs/Kconfig              |  1 +
 fs/ntfs3/Kconfig             |  1 +
 fs/ocfs2/Kconfig             |  1 +
 fs/omfs/Kconfig              |  1 +
 fs/qnx4/Kconfig              |  1 +
 fs/qnx6/Kconfig              |  1 +
 fs/reiserfs/Kconfig          |  1 +
 fs/sysv/Kconfig              |  1 +
 fs/udf/Kconfig               |  1 +
 fs/ufs/Kconfig               |  1 +
 include/linux/buffer_head.h  | 32 ++++++++--------
 include/trace/events/block.h |  2 +
 mm/migrate.c                 |  4 +-
 37 files changed, 125 insertions(+), 32 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 7910636f8df33b..524b8a828aad3d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -24,15 +24,6 @@ static inline struct inode *bdev_file_inode(struct file *file)
 	return file->f_mapping->host;
 }
 
-static int blkdev_get_block(struct inode *inode, sector_t iblock,
-		struct buffer_head *bh, int create)
-{
-	bh->b_bdev = I_BDEV(inode);
-	bh->b_blocknr = iblock;
-	set_buffer_mapped(bh);
-	return 0;
-}
-
 static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 {
 	blk_opf_t opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
@@ -400,7 +391,8 @@ static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	iomap->type = IOMAP_MAPPED;
 	iomap->addr = iomap->offset;
 	iomap->length = isize - iomap->offset;
-	iomap->flags |= IOMAP_F_BUFFER_HEAD;
+	if (IS_ENABLED(CONFIG_BUFFER_HEAD))
+		iomap->flags |= IOMAP_F_BUFFER_HEAD;
 	return 0;
 }
 
@@ -408,6 +400,16 @@ static const struct iomap_ops blkdev_iomap_ops = {
 	.iomap_begin		= blkdev_iomap_begin,
 };
 
+#ifdef CONFIG_BUFFER_HEAD
+static int blkdev_get_block(struct inode *inode, sector_t iblock,
+		struct buffer_head *bh, int create)
+{
+	bh->b_bdev = I_BDEV(inode);
+	bh->b_blocknr = iblock;
+	set_buffer_mapped(bh);
+	return 0;
+}
+
 static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
 {
 	return block_write_full_page(page, blkdev_get_block, wbc);
@@ -453,6 +455,55 @@ const struct address_space_operations def_blk_aops = {
 	.migrate_folio	= buffer_migrate_folio_norefs,
 	.is_dirty_writeback = buffer_check_dirty_writeback,
 };
+#else /* CONFIG_BUFFER_HEAD */
+static int blkdev_read_folio(struct file *file, struct folio *folio)
+{
+	return iomap_read_folio(folio, &blkdev_iomap_ops);
+}
+
+static void blkdev_readahead(struct readahead_control *rac)
+{
+	iomap_readahead(rac, &blkdev_iomap_ops);
+}
+
+static int blkdev_map_blocks(struct iomap_writepage_ctx *wpc,
+		struct inode *inode, loff_t offset)
+{
+	loff_t isize = i_size_read(inode);
+
+	if (WARN_ON_ONCE(offset >= isize))
+		return -EIO;
+	if (offset >= wpc->iomap.offset &&
+	    offset < wpc->iomap.offset + wpc->iomap.length)
+		return 0;
+	return blkdev_iomap_begin(inode, offset, isize - offset,
+				  IOMAP_WRITE, &wpc->iomap, NULL);
+}
+
+static const struct iomap_writeback_ops blkdev_writeback_ops = {
+	.map_blocks		= blkdev_map_blocks,
+};
+
+static int blkdev_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
+{
+	struct iomap_writepage_ctx wpc = { };
+
+	return iomap_writepages(mapping, wbc, &wpc, &blkdev_writeback_ops);
+}
+
+const struct address_space_operations def_blk_aops = {
+	.dirty_folio	= filemap_dirty_folio,
+	.release_folio		= iomap_release_folio,
+	.invalidate_folio	= iomap_invalidate_folio,
+	.read_folio		= blkdev_read_folio,
+	.readahead		= blkdev_readahead,
+	.writepages		= blkdev_writepages,
+	.is_partially_uptodate  = iomap_is_partially_uptodate,
+	.error_remove_page	= generic_error_remove_page,
+	.migrate_folio		= filemap_migrate_folio,
+};
+#endif /* CONFIG_BUFFER_HEAD */
 
 /*
  * for a block special file file_inode(file)->i_size is zero
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index b0a22e99bade37..9ee18013b1f2ab 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -15,6 +15,7 @@ if MD
 config BLK_DEV_MD
 	tristate "RAID support"
 	select BLOCK_HOLDER_DEPRECATED if SYSFS
+	select BUFFER_HEAD
 	# BLOCK_LEGACY_AUTOLOAD requirement should be removed
 	# after relevant mdadm enhancements - to make "names=yes"
 	# the default - are widely available.
diff --git a/fs/Kconfig b/fs/Kconfig
index e99830c650336a..366d5d5be2784b 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -18,8 +18,12 @@ config VALIDATE_FS_PARSER
 config FS_IOMAP
 	bool
 
+config BUFFER_HEAD
+	bool
+
 # old blockdev_direct_IO implementation.  Use iomap for new code instead
 config LEGACY_DIRECT_IO
+	depends on BUFFER_HEAD
 	bool
 
 if BLOCK
diff --git a/fs/Makefile b/fs/Makefile
index da21e7d0a1cf37..3cd6aa1d2ce387 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -18,7 +18,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		fs_types.o fs_context.o fs_parser.o fsopen.o init.o \
 		kernel_read_file.o mnt_idmapping.o remap_range.o
 
-obj-$(CONFIG_BLOCK)		+= buffer.o mpage.o
+obj-$(CONFIG_BUFFER_HEAD)	+= buffer.o mpage.o
 obj-$(CONFIG_PROC_FS)		+= proc_namespace.o
 obj-$(CONFIG_LEGACY_DIRECT_IO)	+= direct-io.o
 obj-y				+= notify/
diff --git a/fs/adfs/Kconfig b/fs/adfs/Kconfig
index 44738fed66251f..1b97058f0c4a92 100644
--- a/fs/adfs/Kconfig
+++ b/fs/adfs/Kconfig
@@ -2,6 +2,7 @@
 config ADFS_FS
 	tristate "ADFS file system support"
 	depends on BLOCK
+	select BUFFER_HEAD
 	help
 	  The Acorn Disc Filing System is the standard file system of the
 	  RiscOS operating system which runs on Acorn's ARM-based Risc PC
diff --git a/fs/affs/Kconfig b/fs/affs/Kconfig
index 962b86374e1c15..1ae432d266c32f 100644
--- a/fs/affs/Kconfig
+++ b/fs/affs/Kconfig
@@ -2,6 +2,7 @@
 config AFFS_FS
 	tristate "Amiga FFS file system support"
 	depends on BLOCK
+	select BUFFER_HEAD
 	select LEGACY_DIRECT_IO
 	help
 	  The Fast File System (FFS) is the common file system used on hard
diff --git a/fs/befs/Kconfig b/fs/befs/Kconfig
index 9550b6462b8147..5fcfc4024ffe6f 100644
--- a/fs/befs/Kconfig
+++ b/fs/befs/Kconfig
@@ -2,6 +2,7 @@
 config BEFS_FS
 	tristate "BeOS file system (BeFS) support (read only)"
 	depends on BLOCK
+	select BUFFER_HEAD
 	select NLS
 	help
 	  The BeOS File System (BeFS) is the native file system of Be, Inc's
diff --git a/fs/bfs/Kconfig b/fs/bfs/Kconfig
index 3a757805b58568..8e7ef866b62a62 100644
--- a/fs/bfs/Kconfig
+++ b/fs/bfs/Kconfig
@@ -2,6 +2,7 @@
 config BFS_FS
 	tristate "BFS file system support"
 	depends on BLOCK
+	select BUFFER_HEAD
 	help
 	  Boot File System (BFS) is a file system used under SCO UnixWare to
 	  allow the bootloader access to the kernel image and other important
diff --git a/fs/efs/Kconfig b/fs/efs/Kconfig
index 2df1bac8b375b1..0833e533df9d53 100644
--- a/fs/efs/Kconfig
+++ b/fs/efs/Kconfig
@@ -2,6 +2,7 @@
 config EFS_FS
 	tristate "EFS file system support (read only)"
 	depends on BLOCK
+	select BUFFER_HEAD
 	help
 	  EFS is an older file system used for non-ISO9660 CD-ROMs and hard
 	  disk partitions by SGI's IRIX operating system (IRIX 6.0 and newer
diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
index 147edeb044691d..cbeca8e44d9b38 100644
--- a/fs/exfat/Kconfig
+++ b/fs/exfat/Kconfig
@@ -2,6 +2,7 @@
 
 config EXFAT_FS
 	tristate "exFAT filesystem support"
+	select BUFFER_HEAD
 	select NLS
 	select LEGACY_DIRECT_IO
 	help
diff --git a/fs/ext2/Kconfig b/fs/ext2/Kconfig
index 77393fda99af09..74d98965902e16 100644
--- a/fs/ext2/Kconfig
+++ b/fs/ext2/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config EXT2_FS
 	tristate "Second extended fs support"
+	select BUFFER_HEAD
 	select FS_IOMAP
 	select LEGACY_DIRECT_IO
 	help
diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index 86699c8cab281c..e20d59221fc05b 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -28,6 +28,7 @@ config EXT3_FS_SECURITY
 
 config EXT4_FS
 	tristate "The Extended 4 (ext4) filesystem"
+	select BUFFER_HEAD
 	select JBD2
 	select CRC16
 	select CRYPTO
diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 03ef087537c7c4..68a1e23e1557c7 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -2,6 +2,7 @@
 config F2FS_FS
 	tristate "F2FS filesystem support"
 	depends on BLOCK
+	select BUFFER_HEAD
 	select NLS
 	select CRYPTO
 	select CRYPTO_CRC32
diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
index afe83b4e717280..25fae1c83725bc 100644
--- a/fs/fat/Kconfig
+++ b/fs/fat/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config FAT_FS
 	tristate
+	select BUFFER_HEAD
 	select NLS
 	select LEGACY_DIRECT_IO
 	help
diff --git a/fs/freevxfs/Kconfig b/fs/freevxfs/Kconfig
index 0e2fc08f7de492..912107ebea6f40 100644
--- a/fs/freevxfs/Kconfig
+++ b/fs/freevxfs/Kconfig
@@ -2,6 +2,7 @@
 config VXFS_FS
 	tristate "FreeVxFS file system support (VERITAS VxFS(TM) compatible)"
 	depends on BLOCK
+	select BUFFER_HEAD
 	help
 	  FreeVxFS is a file system driver that support the VERITAS VxFS(TM)
 	  file system format.  VERITAS VxFS(TM) is the standard file system
diff --git a/fs/gfs2/Kconfig b/fs/gfs2/Kconfig
index 03c966840422ec..be7f87a8e11ae1 100644
--- a/fs/gfs2/Kconfig
+++ b/fs/gfs2/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config GFS2_FS
 	tristate "GFS2 file system support"
+	select BUFFER_HEAD
 	select FS_POSIX_ACL
 	select CRC32
 	select LIBCRC32C
diff --git a/fs/hfs/Kconfig b/fs/hfs/Kconfig
index d985066006d588..5ea5cd8ecea9c0 100644
--- a/fs/hfs/Kconfig
+++ b/fs/hfs/Kconfig
@@ -2,6 +2,7 @@
 config HFS_FS
 	tristate "Apple Macintosh file system support"
 	depends on BLOCK
+	select BUFFER_HEAD
 	select NLS
 	select LEGACY_DIRECT_IO
 	help
diff --git a/fs/hfsplus/Kconfig b/fs/hfsplus/Kconfig
index 8034e7827a690b..8ce4a33a9ac788 100644
--- a/fs/hfsplus/Kconfig
+++ b/fs/hfsplus/Kconfig
@@ -2,6 +2,7 @@
 config HFSPLUS_FS
 	tristate "Apple Extended HFS file system support"
 	depends on BLOCK
+	select BUFFER_HEAD
 	select NLS
 	select NLS_UTF8
 	select LEGACY_DIRECT_IO
diff --git a/fs/hpfs/Kconfig b/fs/hpfs/Kconfig
index ec975f4668775f..ac1e9318e65a4a 100644
--- a/fs/hpfs/Kconfig
+++ b/fs/hpfs/Kconfig
@@ -2,6 +2,7 @@
 config HPFS_FS
 	tristate "OS/2 HPFS file system support"
 	depends on BLOCK
+	select BUFFER_HEAD
 	select FS_IOMAP
 	help
 	  OS/2 is IBM's operating system for PC's, the same as Warp, and HPFS
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3d5042efda202a..336a9d4542c97a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -42,6 +42,12 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
 	return NULL;
 }
 
+static inline bool iomap_use_buffer_heads(const struct iomap *iomap)
+{
+	return IS_ENABLED(CONFIG_BUFFER_HEAD) &&
+		(iomap->flags & IOMAP_F_BUFFER_HEAD);
+}
+
 static struct bio_set iomap_ioend_bioset;
 
 static struct iomap_page *
@@ -683,7 +689,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 
 	if (srcmap->type == IOMAP_INLINE)
 		status = iomap_write_begin_inline(iter, folio);
-	else if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
+	else if (iomap_use_buffer_heads(srcmap))
 		status = __block_write_begin_int(folio, pos, len, NULL, srcmap);
 	else
 		status = __iomap_write_begin(iter, pos, len, folio);
@@ -753,7 +759,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 
 	if (srcmap->type == IOMAP_INLINE) {
 		ret = iomap_write_end_inline(iter, folio, pos, copied);
-	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
+	} else if (iomap_use_buffer_heads(srcmap)) {
 		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
 				copied, &folio->page, NULL);
 	} else {
@@ -1256,7 +1262,7 @@ static loff_t iomap_folio_mkwrite_iter(struct iomap_iter *iter,
 	loff_t length = iomap_length(iter);
 	int ret;
 
-	if (iter->iomap.flags & IOMAP_F_BUFFER_HEAD) {
+	if (iomap_use_buffer_heads(&iter->iomap)) {
 		ret = __block_write_begin_int(folio, iter->pos, length, NULL,
 					      &iter->iomap);
 		if (ret)
diff --git a/fs/isofs/Kconfig b/fs/isofs/Kconfig
index 08ffd37b9bb8f6..51434f2a471b0f 100644
--- a/fs/isofs/Kconfig
+++ b/fs/isofs/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config ISO9660_FS
 	tristate "ISO 9660 CDROM file system support"
+	select BUFFER_HEAD
 	help
 	  This is the standard file system used on CD-ROMs.  It was previously
 	  known as "High Sierra File System" and is called "hsfs" on other
diff --git a/fs/jfs/Kconfig b/fs/jfs/Kconfig
index 51e856f0e4b8d6..17488440eef1a9 100644
--- a/fs/jfs/Kconfig
+++ b/fs/jfs/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config JFS_FS
 	tristate "JFS filesystem support"
+	select BUFFER_HEAD
 	select NLS
 	select CRC32
 	select LEGACY_DIRECT_IO
diff --git a/fs/minix/Kconfig b/fs/minix/Kconfig
index de2003974ff0d0..90ddfad2a75e8f 100644
--- a/fs/minix/Kconfig
+++ b/fs/minix/Kconfig
@@ -2,6 +2,7 @@
 config MINIX_FS
 	tristate "Minix file system support"
 	depends on BLOCK
+	select BUFFER_HEAD
 	help
 	  Minix is a simple operating system used in many classes about OS's.
 	  The minix file system (method to organize files on a hard disk
diff --git a/fs/nilfs2/Kconfig b/fs/nilfs2/Kconfig
index 7d59567465e121..7dae168e346e30 100644
--- a/fs/nilfs2/Kconfig
+++ b/fs/nilfs2/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NILFS2_FS
 	tristate "NILFS2 file system support"
+	select BUFFER_HEAD
 	select CRC32
 	select LEGACY_DIRECT_IO
 	help
diff --git a/fs/ntfs/Kconfig b/fs/ntfs/Kconfig
index f93e69a612833f..7b2509741735a9 100644
--- a/fs/ntfs/Kconfig
+++ b/fs/ntfs/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NTFS_FS
 	tristate "NTFS file system support"
+	select BUFFER_HEAD
 	select NLS
 	help
 	  NTFS is the file system of Microsoft Windows NT, 2000, XP and 2003.
diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
index 96cc236f7f7bd3..cdfdf51e55d797 100644
--- a/fs/ntfs3/Kconfig
+++ b/fs/ntfs3/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NTFS3_FS
 	tristate "NTFS Read-Write file system support"
+	select BUFFER_HEAD
 	select NLS
 	select LEGACY_DIRECT_IO
 	help
diff --git a/fs/ocfs2/Kconfig b/fs/ocfs2/Kconfig
index 304d12186ccd38..4a8288f7ee8697 100644
--- a/fs/ocfs2/Kconfig
+++ b/fs/ocfs2/Kconfig
@@ -2,6 +2,7 @@
 config OCFS2_FS
 	tristate "OCFS2 file system support"
 	depends on INET && SYSFS && CONFIGFS_FS
+	select BUFFER_HEAD
 	select JBD2
 	select CRC32
 	select QUOTA
diff --git a/fs/omfs/Kconfig b/fs/omfs/Kconfig
index 42b2ec35a05bfb..8470f6c3e64e6a 100644
--- a/fs/omfs/Kconfig
+++ b/fs/omfs/Kconfig
@@ -2,6 +2,7 @@
 config OMFS_FS
 	tristate "SonicBlue Optimized MPEG File System support"
 	depends on BLOCK
+	select BUFFER_HEAD
 	select CRC_ITU_T
 	help
 	  This is the proprietary file system used by the Rio Karma music
diff --git a/fs/qnx4/Kconfig b/fs/qnx4/Kconfig
index 45b5b98376c436..a2eb826e76c602 100644
--- a/fs/qnx4/Kconfig
+++ b/fs/qnx4/Kconfig
@@ -2,6 +2,7 @@
 config QNX4FS_FS
 	tristate "QNX4 file system support (read only)"
 	depends on BLOCK
+	select BUFFER_HEAD
 	help
 	  This is the file system used by the real-time operating systems
 	  QNX 4 and QNX 6 (the latter is also called QNX RTP).
diff --git a/fs/qnx6/Kconfig b/fs/qnx6/Kconfig
index 6a9d6bce158622..8e865d72204e75 100644
--- a/fs/qnx6/Kconfig
+++ b/fs/qnx6/Kconfig
@@ -2,6 +2,7 @@
 config QNX6FS_FS
 	tristate "QNX6 file system support (read only)"
 	depends on BLOCK && CRC32
+	select BUFFER_HEAD
 	help
 	  This is the file system used by the real-time operating systems
 	  QNX 6 (also called QNX RTP).
diff --git a/fs/reiserfs/Kconfig b/fs/reiserfs/Kconfig
index 4d22ecfe0fab65..0e6fe26458fede 100644
--- a/fs/reiserfs/Kconfig
+++ b/fs/reiserfs/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config REISERFS_FS
 	tristate "Reiserfs support (deprecated)"
+	select BUFFER_HEAD
 	select CRC32
 	select LEGACY_DIRECT_IO
 	help
diff --git a/fs/sysv/Kconfig b/fs/sysv/Kconfig
index b4e23e03fbeba3..67b3f90afbfd67 100644
--- a/fs/sysv/Kconfig
+++ b/fs/sysv/Kconfig
@@ -2,6 +2,7 @@
 config SYSV_FS
 	tristate "System V/Xenix/V7/Coherent file system support"
 	depends on BLOCK
+	select BUFFER_HEAD
 	help
 	  SCO, Xenix and Coherent are commercial Unix systems for Intel
 	  machines, and Version 7 was used on the DEC PDP-11. Saying Y
diff --git a/fs/udf/Kconfig b/fs/udf/Kconfig
index 82e8bfa2dfd989..8f7ce30d47fdce 100644
--- a/fs/udf/Kconfig
+++ b/fs/udf/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config UDF_FS
 	tristate "UDF file system support"
+	select BUFFER_HEAD
 	select CRC_ITU_T
 	select NLS
 	select LEGACY_DIRECT_IO
diff --git a/fs/ufs/Kconfig b/fs/ufs/Kconfig
index 6d30adb6b890fc..9301e7ecd09210 100644
--- a/fs/ufs/Kconfig
+++ b/fs/ufs/Kconfig
@@ -2,6 +2,7 @@
 config UFS_FS
 	tristate "UFS file system support (read only)"
 	depends on BLOCK
+	select BUFFER_HEAD
 	help
 	  BSD and derivate versions of Unix (such as SunOS, FreeBSD, NetBSD,
 	  OpenBSD and NeXTstep) use a file system called UFS. Some System V
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 0fcc16b7f02bb4..1ef3915cacfae2 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -16,8 +16,6 @@
 #include <linux/wait.h>
 #include <linux/atomic.h>
 
-#ifdef CONFIG_BLOCK
-
 enum bh_state_bits {
 	BH_Uptodate,	/* Contains valid data */
 	BH_Dirty,	/* Is dirty */
@@ -196,7 +194,6 @@ void mark_buffer_write_io_error(struct buffer_head *bh);
 void touch_buffer(struct buffer_head *bh);
 void set_bh_page(struct buffer_head *bh,
 		struct page *page, unsigned long offset);
-bool try_to_free_buffers(struct folio *);
 struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		bool retry);
 void create_empty_buffers(struct page *, unsigned long,
@@ -207,10 +204,6 @@ void end_buffer_async_write(struct buffer_head *bh, int uptodate);
 
 /* Things to do with buffers at mapping->private_list */
 void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode);
-int inode_has_buffers(struct inode *);
-void invalidate_inode_buffers(struct inode *);
-int remove_inode_buffers(struct inode *inode);
-int sync_mapping_buffers(struct address_space *mapping);
 void clean_bdev_aliases(struct block_device *bdev, sector_t block,
 			sector_t len);
 static inline void clean_bdev_bh_alias(struct buffer_head *bh)
@@ -230,9 +223,6 @@ void __bforget(struct buffer_head *);
 void __breadahead(struct block_device *, sector_t block, unsigned int size);
 struct buffer_head *__bread_gfp(struct block_device *,
 				sector_t block, unsigned size, gfp_t gfp);
-void invalidate_bh_lrus(void);
-void invalidate_bh_lrus_cpu(void);
-bool has_bh_in_lru(int cpu, void *dummy);
 struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
 void free_buffer_head(struct buffer_head * bh);
 void unlock_buffer(struct buffer_head *bh);
@@ -248,8 +238,6 @@ int __bh_read(struct buffer_head *bh, blk_opf_t op_flags, bool wait);
 void __bh_read_batch(int nr, struct buffer_head *bhs[],
 		     blk_opf_t op_flags, bool force_lock);
 
-extern int buffer_heads_over_limit;
-
 /*
  * Generic address_space_operations implementations for buffer_head-backed
  * address_spaces.
@@ -294,8 +282,6 @@ extern int buffer_migrate_folio_norefs(struct address_space *,
 #define buffer_migrate_folio_norefs NULL
 #endif
 
-void buffer_init(void);
-
 /*
  * inline definitions
  */
@@ -455,7 +441,20 @@ __bread(struct block_device *bdev, sector_t block, unsigned size)
 
 bool block_dirty_folio(struct address_space *mapping, struct folio *folio);
 
-#else /* CONFIG_BLOCK */
+#ifdef CONFIG_BUFFER_HEAD
+
+void buffer_init(void);
+bool try_to_free_buffers(struct folio *folio);
+int inode_has_buffers(struct inode *inode);
+void invalidate_inode_buffers(struct inode *inode);
+int remove_inode_buffers(struct inode *inode);
+int sync_mapping_buffers(struct address_space *mapping);
+void invalidate_bh_lrus(void);
+void invalidate_bh_lrus_cpu(void);
+bool has_bh_in_lru(int cpu, void *dummy);
+extern int buffer_heads_over_limit;
+
+#else /* CONFIG_BUFFER_HEAD */
 
 static inline void buffer_init(void) {}
 static inline bool try_to_free_buffers(struct folio *folio) { return true; }
@@ -463,9 +462,10 @@ static inline int inode_has_buffers(struct inode *inode) { return 0; }
 static inline void invalidate_inode_buffers(struct inode *inode) {}
 static inline int remove_inode_buffers(struct inode *inode) { return 1; }
 static inline int sync_mapping_buffers(struct address_space *mapping) { return 0; }
+static inline void invalidate_bh_lrus(void) {}
 static inline void invalidate_bh_lrus_cpu(void) {}
 static inline bool has_bh_in_lru(int cpu, void *dummy) { return false; }
 #define buffer_heads_over_limit 0
 
-#endif /* CONFIG_BLOCK */
+#endif /* CONFIG_BUFFER_HEAD */
 #endif /* _LINUX_BUFFER_HEAD_H */
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 7f4dfbdf12a6f1..a0503f387104a1 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -12,6 +12,7 @@
 
 #define RWBS_LEN	8
 
+#ifdef CONFIG_BUFFER_HEAD
 DECLARE_EVENT_CLASS(block_buffer,
 
 	TP_PROTO(struct buffer_head *bh),
@@ -61,6 +62,7 @@ DEFINE_EVENT(block_buffer, block_dirty_buffer,
 
 	TP_ARGS(bh)
 );
+#endif /* CONFIG_BUFFER_HEAD */
 
 /**
  * block_rq_requeue - place block IO request back on a queue
diff --git a/mm/migrate.c b/mm/migrate.c
index db3f154446af4e..9f9a81d43fc8f2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -692,7 +692,7 @@ int migrate_folio(struct address_space *mapping, struct folio *dst,
 }
 EXPORT_SYMBOL(migrate_folio);
 
-#ifdef CONFIG_BLOCK
+#ifdef CONFIG_BUFFER_HEAD
 /* Returns true if all buffers are successfully locked */
 static bool buffer_migrate_lock_buffers(struct buffer_head *head,
 							enum migrate_mode mode)
@@ -850,7 +850,7 @@ int buffer_migrate_folio_norefs(struct address_space *mapping,
 	return __buffer_migrate_folio(mapping, dst, src, mode, true);
 }
 EXPORT_SYMBOL_GPL(buffer_migrate_folio_norefs);
-#endif
+#endif /* CONFIG_BUFFER_HEAD */
 
 int filemap_migrate_folio(struct address_space *mapping,
 		struct folio *dst, struct folio *src, enum migrate_mode mode)
-- 
2.39.2

