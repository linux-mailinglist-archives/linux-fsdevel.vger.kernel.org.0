Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11656447945
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbhKHEVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhKHEVg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:21:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6523C061570;
        Sun,  7 Nov 2021 20:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=D2M552hJRlzsyjLhjjW08hd3rhvcI9FywyUGRhDOmUg=; b=I2EeqPuJsPJB9V9yWlpgseuT9w
        5UuAMYtDWyNlNa5+ILGyUATz0pR7ehbTwZTp90RDrxEKxt2UNpV7MIvhdcTTRPM3mUx83HbisXwhC
        fKGjJjj9dGptaZ6gxokeo0PdzA66ZiHUezWUfc+eT7nvAAGNGvlC1qrSEzY5vzORuQR9xlh6XmRfZ
        FcmV2KfwxrTwyv9d8wYlhNP6P4e/XWe8DgQHUS01Ir6Q8uJMKM96G/yDdnId0or349zLLJBRuVvud
        upxPmwKctx2ALHNAhW7KY/j6U+rXs6/+xix3D6VdkPzS+xwPpdMVIVf0YHSnbCIi5iq16PSOSqORK
        JBkKWOxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjw1Y-0089aT-Qr; Mon, 08 Nov 2021 04:13:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 03/28] fs: Remove FS_THP_SUPPORT
Date:   Mon,  8 Nov 2021 04:05:26 +0000
Message-Id: <20211108040551.1942823-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of setting a bit in the fs_flags to set a bit in the
address_space, set the bit in the address_space directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/inode.c              |  2 --
 include/linux/fs.h      |  1 -
 include/linux/pagemap.h | 16 ++++++++++++++++
 mm/shmem.c              |  3 ++-
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9abc88d7959c..d6386b6d5a6e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -180,8 +180,6 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	mapping->a_ops = &empty_aops;
 	mapping->host = inode;
 	mapping->flags = 0;
-	if (sb->s_type->fs_flags & FS_THP_SUPPORT)
-		__set_bit(AS_THP_SUPPORT, &mapping->flags);
 	mapping->wb_err = 0;
 	atomic_set(&mapping->i_mmap_writable, 0);
 #ifdef CONFIG_READ_ONLY_THP_FOR_FS
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4137a9bfae7a..3c2fcabf9d12 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2518,7 +2518,6 @@ struct file_system_type {
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
-#define FS_THP_SUPPORT		8192	/* Remove once all fs converted */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index db2c3e3eb1cf..471f0c422831 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -126,6 +126,22 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 	m->gfp_mask = mask;
 }
 
+/**
+ * mapping_set_large_folios() - Indicate the file supports multi-page folios.
+ * @mapping: The file.
+ *
+ * The filesystem should call this function in its inode constructor to
+ * indicate that the VFS can use multi-page folios to cache the contents
+ * of the file.
+ *
+ * Context: This should not be called while the inode is active as it
+ * is non-atomic.
+ */
+static inline void mapping_set_large_folios(struct address_space *mapping)
+{
+	__set_bit(AS_THP_SUPPORT, &mapping->flags);
+}
+
 static inline bool mapping_thp_support(struct address_space *mapping)
 {
 	return test_bit(AS_THP_SUPPORT, &mapping->flags);
diff --git a/mm/shmem.c b/mm/shmem.c
index 23c91a8beb78..54422933fa2d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2303,6 +2303,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 		INIT_LIST_HEAD(&info->swaplist);
 		simple_xattrs_init(&info->xattrs);
 		cache_no_acl(inode);
+		mapping_set_large_folios(inode->i_mapping);
 
 		switch (mode & S_IFMT) {
 		default:
@@ -3920,7 +3921,7 @@ static struct file_system_type shmem_fs_type = {
 	.parameters	= shmem_fs_parameters,
 #endif
 	.kill_sb	= kill_litter_super,
-	.fs_flags	= FS_USERNS_MOUNT | FS_THP_SUPPORT,
+	.fs_flags	= FS_USERNS_MOUNT,
 };
 
 int __init shmem_init(void)
-- 
2.33.0

