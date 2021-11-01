Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7404421D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 21:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhKAUrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 16:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhKAUrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:47:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EB1C061714;
        Mon,  1 Nov 2021 13:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OIcP1svZql+Ei2OJR80mI+UUHO92YqXyWdaXkXyADaQ=; b=N1cASxa83iAOFqv66Wy6UP3o6k
        Ao+2G1MhhtLwEiDMAf06vYalryL0tL+wxgH9sVDvP1H63tPYD1f1o/ZhBUTAmSxmI6B4BztCM47aD
        01PCWQuySmQTDaLcRmKwmZ/fZ18hoT+a7P6f9W15TYm6SbkblaLygr/0QleMxyxZQq6+/6UoDWlI3
        71YiLYqMyb/tmCO2wWxRJ0YGIs8JxhBYa+0/GFhBXUdvFt9RtQEFQZB/XFRxQg3Cu2/6AyVZq3q3H
        svnvO9TiUadUeqkDKgVeI54O1HEDNy6ji0sB5oAgQM4XR+WVEEC3N0v2Om4sR6+vhsdHWjRj5QtqQ
        pq1wgQ1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhe7S-0040RD-Ga; Mon, 01 Nov 2021 20:42:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 01/21] fs: Remove FS_THP_SUPPORT
Date:   Mon,  1 Nov 2021 20:39:09 +0000
Message-Id: <20211101203929.954622-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211101203929.954622-1-willy@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of setting a bit in the fs_flags to set a bit in the
address_space, set the bit in the address_space directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/inode.c              |  2 --
 include/linux/fs.h      |  1 -
 include/linux/pagemap.h | 16 ++++++++++++++++
 mm/shmem.c              |  3 ++-
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index ed0cab8a32db..bdfbd5962f2b 100644
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
index 0dcb9020a7b3..d6a4eb6cf825 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2515,7 +2515,6 @@ struct file_system_type {
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
-#define FS_THP_SUPPORT		8192	/* Remove once all fs converted */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 013cdc90f5fd..c17058e57aa4 100644
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
index 17e344e26e73..eb7a898f7b0a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2304,6 +2304,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 		INIT_LIST_HEAD(&info->swaplist);
 		simple_xattrs_init(&info->xattrs);
 		cache_no_acl(inode);
+		mapping_set_large_folios(inode->i_mapping);
 
 		switch (mode & S_IFMT) {
 		default:
@@ -3894,7 +3895,7 @@ static struct file_system_type shmem_fs_type = {
 	.parameters	= shmem_fs_parameters,
 #endif
 	.kill_sb	= kill_litter_super,
-	.fs_flags	= FS_USERNS_MOUNT | FS_THP_SUPPORT,
+	.fs_flags	= FS_USERNS_MOUNT,
 };
 
 int __init shmem_init(void)
-- 
2.33.0

