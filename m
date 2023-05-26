Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532A9711C05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjEZBF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjEZBF4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:05:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ACE125;
        Thu, 25 May 2023 18:05:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 653C6647D0;
        Fri, 26 May 2023 01:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4882C433D2;
        Fri, 26 May 2023 01:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685063153;
        bh=J1D6ggHB8DbIN616QetckYX4EhQV1VenPI7GCUqux8Q=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=Y8ousCEaePNm1yLJYDrN9hi/YUSHMvaFvXp6ZX2VmOvl5oXrdbIp7TwyYGTjvOlTx
         zaHmB2aOpLacHAdLzSJZNvqRL06wumgHo/RY+qnNRdM4oEx7QCJWU5Z1Bv0Usobgor
         Pno5UVrJDw0OIJdvVtjHFO/ypZX6c5/WytSD+cnSN0tkYU0liNmVKQeWQroWRR8xoO
         iteXjJpFPdr65RONBYgUw7aNIGE3hKMevR9jLd8DJsDJ8Xv9igYyC88fVAyDYrlXdW
         l7Rn/r5KQ5pzoglzuCIlC1dqoz7eYk3kFBSmpigOYpDllAAiSnQ/AeGSQPs1w5TeuH
         AqwXHf5FPUeGA==
Date:   Thu, 25 May 2023 18:05:53 -0700
Subject: [PATCH 5/9] xfs: support in-memory buffer cache targets
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Message-ID: <168506061924.3733082.12588796681828249746.stgit@frogsfrogsfrogs>
In-Reply-To: <168506061839.3733082.9818919714772025609.stgit@frogsfrogsfrogs>
References: <168506061839.3733082.9818919714772025609.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Allow the buffer cache to target in-memory files by connecting it to
xfiles.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/Kconfig         |    4 ++
 fs/xfs/Makefile        |    1 +
 fs/xfs/scrub/xfile.h   |   16 +++++++++
 fs/xfs/xfs_buf.c       |   44 ++++++++++++++++++++++--
 fs/xfs/xfs_buf.h       |   26 +++++++++++++-
 fs/xfs/xfs_buf_xfile.c |   89 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_buf_xfile.h |   18 ++++++++++
 7 files changed, 193 insertions(+), 5 deletions(-)
 create mode 100644 fs/xfs/xfs_buf_xfile.c
 create mode 100644 fs/xfs/xfs_buf_xfile.h


diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
index acd56ebe77f9..71fd486eaca1 100644
--- a/fs/xfs/Kconfig
+++ b/fs/xfs/Kconfig
@@ -128,6 +128,9 @@ config XFS_LIVE_HOOKS
 	bool
 	select JUMP_LABEL if HAVE_ARCH_JUMP_LABEL
 
+config XFS_IN_MEMORY_FILE
+	bool
+
 config XFS_ONLINE_SCRUB
 	bool "XFS online metadata check support"
 	default n
@@ -135,6 +138,7 @@ config XFS_ONLINE_SCRUB
 	depends on TMPFS && SHMEM
 	select XFS_LIVE_HOOKS
 	select XFS_DRAIN_INTENTS
+	select XFS_IN_MEMORY_FILE
 	help
 	  If you say Y here you will be able to check metadata on a
 	  mounted XFS filesystem.  This feature is intended to reduce
diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index ea90abdd9941..fc44611cf723 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -138,6 +138,7 @@ endif
 
 xfs-$(CONFIG_XFS_DRAIN_INTENTS)	+= xfs_drain.o
 xfs-$(CONFIG_XFS_LIVE_HOOKS)	+= xfs_hooks.o
+xfs-$(CONFIG_XFS_IN_MEMORY_FILE)	+= xfs_buf_xfile.o
 
 # online scrub/repair
 ifeq ($(CONFIG_XFS_ONLINE_SCRUB),y)
diff --git a/fs/xfs/scrub/xfile.h b/fs/xfs/scrub/xfile.h
index adf5dbdc4c21..083348b4cdaf 100644
--- a/fs/xfs/scrub/xfile.h
+++ b/fs/xfs/scrub/xfile.h
@@ -6,6 +6,8 @@
 #ifndef __XFS_SCRUB_XFILE_H__
 #define __XFS_SCRUB_XFILE_H__
 
+#ifdef CONFIG_XFS_IN_MEMORY_FILE
+
 struct xfile_page {
 	struct page		*page;
 	void			*fsdata;
@@ -24,6 +26,7 @@ static inline pgoff_t xfile_page_index(const struct xfile_page *xfpage)
 
 struct xfile {
 	struct file		*file;
+	struct xfs_buf_cache	bcache;
 };
 
 int xfile_create(struct xfs_mount *mp, const char *description, loff_t isize,
@@ -76,5 +79,18 @@ int xfile_get_page(struct xfile *xf, loff_t offset, unsigned int len,
 int xfile_put_page(struct xfile *xf, struct xfile_page *xbuf);
 
 int xfile_dump(struct xfile *xf);
+#else
+static inline int
+xfile_obj_load(struct xfile *xf, void *buf, size_t count, loff_t offset)
+{
+	return -EIO;
+}
+
+static inline int
+xfile_obj_store(struct xfile *xf, const void *buf, size_t count, loff_t offset)
+{
+	return -EIO;
+}
+#endif /* CONFIG_XFS_IN_MEMORY_FILE */
 
 #endif /* __XFS_SCRUB_XFILE_H__ */
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 19cefed4dca7..e3f24594e575 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -21,6 +21,7 @@
 #include "xfs_errortag.h"
 #include "xfs_error.h"
 #include "xfs_ag.h"
+#include "xfs_buf_xfile.h"
 
 struct kmem_cache *xfs_buf_cache;
 
@@ -1552,6 +1553,30 @@ xfs_buf_ioapply_map(
 
 }
 
+/* Start a synchronous process-context buffer IO. */
+static inline void
+xfs_buf_start_sync_io(
+	struct xfs_buf	*bp)
+{
+	atomic_inc(&bp->b_io_remaining);
+}
+
+/* Finish a synchronous bprocess-context uffer IO. */
+static void
+xfs_buf_end_sync_io(
+	struct xfs_buf	*bp,
+	int		error)
+{
+	if (error)
+		cmpxchg(&bp->b_io_error, 0, error);
+
+	if (!bp->b_error && xfs_buf_is_vmapped(bp) && (bp->b_flags & XBF_READ))
+		invalidate_kernel_vmap_range(bp->b_addr, xfs_buf_vmap_len(bp));
+
+	if (atomic_dec_and_test(&bp->b_io_remaining) == 1)
+		xfs_buf_ioend(bp);
+}
+
 STATIC void
 _xfs_buf_ioapply(
 	struct xfs_buf	*bp)
@@ -1609,6 +1634,15 @@ _xfs_buf_ioapply(
 	/* we only use the buffer cache for meta-data */
 	op |= REQ_META;
 
+	if (bp->b_target->bt_flags & XFS_BUFTARG_XFILE) {
+		int	error;
+
+		xfs_buf_start_sync_io(bp);
+		error = xfile_buf_ioapply(bp);
+		xfs_buf_end_sync_io(bp, error);
+		return;
+	}
+
 	/*
 	 * Walk all the vectors issuing IO on them. Set up the initial offset
 	 * into the buffer and the desired IO size before we start -
@@ -1974,9 +2008,11 @@ xfs_free_buftarg(
 	percpu_counter_destroy(&btp->bt_io_count);
 	list_lru_destroy(&btp->bt_lru);
 
-	blkdev_issue_flush(btp->bt_bdev);
-	invalidate_bdev(btp->bt_bdev);
-	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
+	if (!(btp->bt_flags & XFS_BUFTARG_XFILE)) {
+		blkdev_issue_flush(btp->bt_bdev);
+		invalidate_bdev(btp->bt_bdev);
+		fs_put_dax(btp->bt_daxdev, btp->bt_mount);
+	}
 
 	kvfree(btp);
 }
@@ -2017,7 +2053,7 @@ xfs_setsize_buftarg_early(
 	return xfs_setsize_buftarg(btp, bdev_logical_block_size(bdev));
 }
 
-static struct xfs_buftarg *
+struct xfs_buftarg *
 xfs_alloc_buftarg_common(
 	struct xfs_mount	*mp,
 	const char		*descr)
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index dd7964bc76d7..90b67a11e3c1 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -21,6 +21,7 @@ extern struct kmem_cache *xfs_buf_cache;
  *	Base types
  */
 struct xfs_buf;
+struct xfile;
 
 #define XFS_BUF_DADDR_NULL	((xfs_daddr_t) (-1LL))
 
@@ -106,11 +107,15 @@ void xfs_buf_cache_destroy(struct xfs_buf_cache *bch);
  */
 typedef struct xfs_buftarg {
 	dev_t			bt_dev;
-	struct block_device	*bt_bdev;
+	union {
+		struct block_device	*bt_bdev;
+		struct xfile		*bt_xfile;
+	};
 	struct dax_device	*bt_daxdev;
 	u64			bt_dax_part_off;
 	struct xfs_mount	*bt_mount;
 	struct xfs_buf_cache	*bt_cache;
+	unsigned int		bt_flags;
 	unsigned int		bt_meta_sectorsize;
 	size_t			bt_meta_sectormask;
 	size_t			bt_logical_sectorsize;
@@ -124,6 +129,13 @@ typedef struct xfs_buftarg {
 	struct ratelimit_state	bt_ioerror_rl;
 } xfs_buftarg_t;
 
+#ifdef CONFIG_XFS_IN_MEMORY_FILE
+/* in-memory buftarg via bt_xfile */
+# define XFS_BUFTARG_XFILE	(1U << 0)
+#else
+# define XFS_BUFTARG_XFILE	(0)
+#endif
+
 #define XB_PAGES	2
 
 struct xfs_buf_map {
@@ -371,6 +383,8 @@ xfs_buf_update_cksum(struct xfs_buf *bp, unsigned long cksum_offset)
 /*
  *	Handling of buftargs.
  */
+struct xfs_buftarg *xfs_alloc_buftarg_common(struct xfs_mount *mp,
+		const char *descr);
 struct xfs_buftarg *xfs_alloc_buftarg(struct xfs_mount *mp,
 		struct block_device *bdev);
 extern void xfs_free_buftarg(struct xfs_buftarg *);
@@ -381,24 +395,32 @@ extern int xfs_setsize_buftarg(struct xfs_buftarg *, unsigned int);
 static inline struct block_device *
 xfs_buftarg_bdev(struct xfs_buftarg *btp)
 {
+	if (btp->bt_flags & XFS_BUFTARG_XFILE)
+		return NULL;
 	return btp->bt_bdev;
 }
 
 static inline unsigned int
 xfs_getsize_buftarg(struct xfs_buftarg *btp)
 {
+	if (btp->bt_flags & XFS_BUFTARG_XFILE)
+		return SECTOR_SIZE;
 	return block_size(btp->bt_bdev);
 }
 
 static inline bool
 xfs_readonly_buftarg(struct xfs_buftarg *btp)
 {
+	if (btp->bt_flags & XFS_BUFTARG_XFILE)
+		return false;
 	return bdev_read_only(btp->bt_bdev);
 }
 
 static inline int
 xfs_buftarg_flush(struct xfs_buftarg *btp)
 {
+	if (btp->bt_flags & XFS_BUFTARG_XFILE)
+		return 0;
 	return blkdev_issue_flush(btp->bt_bdev);
 }
 
@@ -410,6 +432,8 @@ xfs_buftarg_zeroout(
 	gfp_t			gfp_mask,
 	unsigned		flags)
 {
+	if (btp->bt_flags & XFS_BUFTARG_XFILE)
+		return -EOPNOTSUPP;
 	return blkdev_issue_zeroout(btp->bt_bdev, sector, nr_sects, gfp_mask,
 			flags);
 }
diff --git a/fs/xfs/xfs_buf_xfile.c b/fs/xfs/xfs_buf_xfile.c
new file mode 100644
index 000000000000..69f1d62e0fcb
--- /dev/null
+++ b/fs/xfs/xfs_buf_xfile.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#include "xfs.h"
+#include "xfs_fs.h"
+#include "xfs_buf.h"
+#include "xfs_buf_xfile.h"
+#include "scrub/xfile.h"
+
+/* Perform a buffer IO to an xfile.  Caller must be in process context. */
+int
+xfile_buf_ioapply(
+	struct xfs_buf		*bp)
+{
+	struct xfile		*xfile = bp->b_target->bt_xfile;
+	loff_t			pos = BBTOB(xfs_buf_daddr(bp));
+	size_t			size = BBTOB(bp->b_length);
+
+	if (bp->b_map_count > 1) {
+		/* We don't need or support multi-map buffers. */
+		ASSERT(0);
+		return -EIO;
+	}
+
+	if (bp->b_flags & XBF_WRITE)
+		return xfile_obj_store(xfile, bp->b_addr, size, pos);
+	return xfile_obj_load(xfile, bp->b_addr, size, pos);
+}
+
+/* Allocate a buffer cache target for a memory-backed file. */
+int
+xfile_alloc_buftarg(
+	struct xfs_mount	*mp,
+	const char		*descr,
+	struct xfs_buftarg	**btpp)
+{
+	struct xfs_buftarg	*btp;
+	struct xfile		*xfile;
+	int			error;
+
+	error = xfile_create(mp, descr, 0, &xfile);
+	if (error)
+		return error;
+
+	error = xfs_buf_cache_init(&xfile->bcache);
+	if (error)
+		goto out_xfile;
+
+	btp = xfs_alloc_buftarg_common(mp, descr);
+	if (!btp) {
+		error = -ENOMEM;
+		goto out_bcache;
+	}
+
+	btp->bt_xfile = xfile;
+	btp->bt_dev = (dev_t)-1U;
+	btp->bt_flags |= XFS_BUFTARG_XFILE;
+	btp->bt_cache = &xfile->bcache;
+
+	btp->bt_meta_sectorsize = SECTOR_SIZE;
+	btp->bt_meta_sectormask = SECTOR_SIZE - 1;
+	btp->bt_logical_sectorsize = SECTOR_SIZE;
+	btp->bt_logical_sectormask = SECTOR_SIZE - 1;
+
+	*btpp = btp;
+	return 0;
+
+out_bcache:
+	xfs_buf_cache_destroy(&xfile->bcache);
+out_xfile:
+	xfile_destroy(xfile);
+	return error;
+}
+
+/* Free a buffer cache target for a memory-backed file. */
+void
+xfile_free_buftarg(
+	struct xfs_buftarg	*btp)
+{
+	struct xfile		*xfile = btp->bt_xfile;
+
+	ASSERT(btp->bt_flags & XFS_BUFTARG_XFILE);
+
+	xfs_free_buftarg(btp);
+	xfs_buf_cache_destroy(&xfile->bcache);
+	xfile_destroy(xfile);
+}
diff --git a/fs/xfs/xfs_buf_xfile.h b/fs/xfs/xfs_buf_xfile.h
new file mode 100644
index 000000000000..29efaf06a676
--- /dev/null
+++ b/fs/xfs/xfs_buf_xfile.h
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef __XFS_BUF_XFILE_H__
+#define __XFS_BUF_XFILE_H__
+
+#ifdef CONFIG_XFS_IN_MEMORY_FILE
+int xfile_buf_ioapply(struct xfs_buf *bp);
+int xfile_alloc_buftarg(struct xfs_mount *mp, const char *descr,
+		struct xfs_buftarg **btpp);
+void xfile_free_buftarg(struct xfs_buftarg *btp);
+#else
+# define xfile_buf_ioapply(bp)			(-EOPNOTSUPP)
+#endif /* CONFIG_XFS_IN_MEMORY_FILE */
+
+#endif /* __XFS_BUF_XFILE_H__ */

