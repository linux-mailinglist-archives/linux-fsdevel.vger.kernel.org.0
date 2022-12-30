Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968CC659E7F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbiL3XmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbiL3Xly (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:41:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3481DDE7;
        Fri, 30 Dec 2022 15:41:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2B8661C17;
        Fri, 30 Dec 2022 23:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B25DC433D2;
        Fri, 30 Dec 2022 23:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672443711;
        bh=kgd2HV4W1zeAMYGsDmb9nU9cAfHBExoPhOalx9fzpOA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W19AReN/9oSCycIloiaL+zX/v6TrcadKLFGaPVr/blPhzgJLAEMgIDsdyFyZZCyUA
         ixsaTPZZh63QRqNrdX0jyLks41iAK5rPwgpMFigfExsQUlrPq7zKbmI1ALcZWx/34b
         sL1Wee7m7GRduW/NzbZHdhv8fCg0Wq84XVh8CXG5JhnmvY70J6CK5wJV2khs9quiI2
         N7IOi27geJCieix8/jMe3GqjGD3nM3borJXoDHMInd6Lv9RZSHKc1oBnZasJ4jNf/s
         BTxOjRQDy5hSOfpwxzcviUkgDasEz/fCNQB7GURFS/VzymfGZvVMyrh/FSMsWPy4Jx
         aGoBHL63/4bkA==
Subject: [PATCH 3/7] xfs: support in-memory buffer cache targets
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:26 -0800
Message-ID: <167243840641.696535.16094394391484791125.stgit@magnolia>
In-Reply-To: <167243840589.696535.4812770109109400531.stgit@magnolia>
References: <167243840589.696535.4812770109109400531.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 fs/xfs/Kconfig           |    4 ++
 fs/xfs/scrub/xfile.h     |   15 +++++++++
 fs/xfs/xfs_aops.c        |    5 ++-
 fs/xfs/xfs_bmap_util.c   |    8 ++---
 fs/xfs/xfs_buf.c         |   80 +++++++++++++++++++++++++++++++++++++++++++---
 fs/xfs/xfs_buf.h         |   71 +++++++++++++++++++++++++++++++++++++++--
 fs/xfs/xfs_discard.c     |    8 ++---
 fs/xfs/xfs_file.c        |    6 ++-
 fs/xfs/xfs_ioctl.c       |    3 +-
 fs/xfs/xfs_iomap.c       |    4 +-
 fs/xfs/xfs_log.c         |    4 +-
 fs/xfs/xfs_log_cil.c     |    3 +-
 fs/xfs/xfs_log_recover.c |    3 +-
 fs/xfs/xfs_super.c       |    4 +-
 14 files changed, 188 insertions(+), 30 deletions(-)


diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
index 54806c2b80d4..2373324be997 100644
--- a/fs/xfs/Kconfig
+++ b/fs/xfs/Kconfig
@@ -101,6 +101,9 @@ config XFS_LIVE_HOOKS
 	bool
 	select JUMP_LABEL if HAVE_ARCH_JUMP_LABEL
 
+config XFS_IN_MEMORY_FILE
+	bool
+
 config XFS_ONLINE_SCRUB
 	bool "XFS online metadata check support"
 	default n
@@ -108,6 +111,7 @@ config XFS_ONLINE_SCRUB
 	depends on TMPFS && SHMEM
 	select XFS_LIVE_HOOKS
 	select XFS_DRAIN_INTENTS
+	select XFS_IN_MEMORY_FILE
 	help
 	  If you say Y here you will be able to check metadata on a
 	  mounted XFS filesystem.  This feature is intended to reduce
diff --git a/fs/xfs/scrub/xfile.h b/fs/xfs/scrub/xfile.h
index b7f046016b1b..99b6db838612 100644
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
@@ -76,5 +78,18 @@ int xfile_get_page(struct xfile *xf, loff_t offset, unsigned int len,
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
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 41734202796f..c3a9df0c0eab 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -562,7 +562,10 @@ xfs_iomap_swapfile_activate(
 	struct file			*swap_file,
 	sector_t			*span)
 {
-	sis->bdev = xfs_inode_buftarg(XFS_I(file_inode(swap_file)))->bt_bdev;
+	struct xfs_inode		*ip = XFS_I(file_inode(swap_file));
+	struct xfs_buftarg		*btp = xfs_inode_buftarg(ip);
+
+	sis->bdev = xfs_buftarg_bdev(btp);
 	return iomap_swapfile_activate(sis, swap_file, span,
 			&xfs_read_iomap_ops);
 }
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 867645b74d88..e094932869f6 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -62,10 +62,10 @@ xfs_zero_extent(
 	xfs_daddr_t		sector = xfs_fsb_to_db(ip, start_fsb);
 	sector_t		block = XFS_BB_TO_FSBT(mp, sector);
 
-	return blkdev_issue_zeroout(target->bt_bdev,
-		block << (mp->m_super->s_blocksize_bits - 9),
-		count_fsb << (mp->m_super->s_blocksize_bits - 9),
-		GFP_NOFS, 0);
+	return xfs_buftarg_zeroout(target,
+			block << (mp->m_super->s_blocksize_bits - 9),
+			count_fsb << (mp->m_super->s_blocksize_bits - 9),
+			GFP_NOFS, 0);
 }
 
 #ifdef CONFIG_XFS_RT
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 7dfc1db566fa..2ec8d39def9c 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -21,6 +21,7 @@
 #include "xfs_errortag.h"
 #include "xfs_error.h"
 #include "xfs_ag.h"
+#include "scrub/xfile.h"
 
 struct kmem_cache *xfs_buf_cache;
 
@@ -1554,6 +1555,36 @@ xfs_buf_ioapply_map(
 
 }
 
+static inline void
+xfs_buf_ioapply_in_memory(
+	struct xfs_buf		*bp)
+{
+	struct xfile		*xfile = bp->b_target->bt_xfile;
+	loff_t			pos = BBTOB(xfs_buf_daddr(bp));
+	size_t			size = BBTOB(bp->b_length);
+	int			error;
+
+	atomic_inc(&bp->b_io_remaining);
+
+	if (bp->b_map_count > 1) {
+		/* We don't need or support multi-map buffers. */
+		ASSERT(0);
+		error = -EIO;
+	} else if (bp->b_flags & XBF_WRITE) {
+		error = xfile_obj_store(xfile, bp->b_addr, size, pos);
+	} else {
+		error = xfile_obj_load(xfile, bp->b_addr, size, pos);
+	}
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
@@ -1611,6 +1642,11 @@ _xfs_buf_ioapply(
 	/* we only use the buffer cache for meta-data */
 	op |= REQ_META;
 
+	if (bp->b_target->bt_flags & XFS_BUFTARG_IN_MEMORY) {
+		xfs_buf_ioapply_in_memory(bp);
+		return;
+	}
+
 	/*
 	 * Walk all the vectors issuing IO on them. Set up the initial offset
 	 * into the buffer and the desired IO size before we start -
@@ -1978,9 +2014,11 @@ xfs_free_buftarg(
 	if (btp->bt_flags & XFS_BUFTARG_SELF_CACHED)
 		rhashtable_destroy(&btp->bt_bufhash);
 
-	blkdev_issue_flush(btp->bt_bdev);
-	invalidate_bdev(btp->bt_bdev);
-	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
+	if (!(btp->bt_flags & XFS_BUFTARG_IN_MEMORY)) {
+		blkdev_issue_flush(btp->bt_bdev);
+		invalidate_bdev(btp->bt_bdev);
+		fs_put_dax(btp->bt_daxdev, btp->bt_mount);
+	}
 
 	kmem_free(btp);
 }
@@ -2024,12 +2062,13 @@ xfs_setsize_buftarg_early(
 static struct xfs_buftarg *
 __xfs_alloc_buftarg(
 	struct xfs_mount	*mp,
-	unsigned int		flags)
+	unsigned int		flags,
+	xfs_km_flags_t		km_flags)
 {
 	struct xfs_buftarg	*btp;
 	int			error;
 
-	btp = kmem_zalloc(sizeof(*btp), KM_NOFS);
+	btp = kmem_zalloc(sizeof(*btp), KM_NOFS | km_flags);
 	if (!btp)
 		return NULL;
 
@@ -2090,7 +2129,7 @@ xfs_alloc_buftarg(
 	ops = &xfs_dax_holder_operations;
 #endif
 
-	btp = __xfs_alloc_buftarg(mp, 0);
+	btp = __xfs_alloc_buftarg(mp, 0, 0);
 	if (!btp)
 		return NULL;
 
@@ -2109,6 +2148,35 @@ xfs_alloc_buftarg(
 	return NULL;
 }
 
+#ifdef CONFIG_XFS_IN_MEMORY_FILE
+/* Allocate a buffer cache target for a memory-backed file. */
+int
+xfs_alloc_memory_buftarg(
+	struct xfs_mount	*mp,
+	struct xfile		*xfile,
+	struct xfs_buftarg	**btpp)
+{
+	struct xfs_buftarg	*btp;
+
+	btp = __xfs_alloc_buftarg(mp,
+			XFS_BUFTARG_SELF_CACHED | XFS_BUFTARG_IN_MEMORY,
+			KM_MAYFAIL);
+	if (!btp)
+		return -ENOMEM;
+
+	btp->bt_xfile = xfile;
+	btp->bt_dev = (dev_t)-1U;
+
+	btp->bt_meta_sectorsize = SECTOR_SIZE;
+	btp->bt_meta_sectormask = SECTOR_SIZE - 1;
+	btp->bt_logical_sectorsize = SECTOR_SIZE;
+	btp->bt_logical_sectormask = SECTOR_SIZE - 1;
+
+	*btpp = btp;
+	return 0;
+}
+#endif /* CONFIG_XFS_IN_MEMORY_FILE */
+
 /*
  * Cancel a delayed write list.
  *
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index d7bf7f657e99..dcae77dabdcc 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -21,6 +21,7 @@ extern struct kmem_cache *xfs_buf_cache;
  *	Base types
  */
 struct xfs_buf;
+struct xfile;
 
 #define XFS_BUF_DADDR_NULL	((xfs_daddr_t) (-1LL))
 
@@ -99,7 +100,10 @@ typedef unsigned int xfs_buf_flags_t;
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
@@ -124,6 +128,20 @@ typedef struct xfs_buftarg {
 /* the xfs_buftarg indexes buffers via bt_buf_hash */
 #define XFS_BUFTARG_SELF_CACHED	(1U << 0)
 
+/* in-memory buftarg via bt_xfile */
+#ifdef CONFIG_XFS_IN_MEMORY_FILE
+# define XFS_BUFTARG_IN_MEMORY	(1U << 1)
+#else
+# define XFS_BUFTARG_IN_MEMORY	(0)
+#endif
+
+static inline bool
+xfs_buftarg_in_memory(
+	struct xfs_buftarg	*btp)
+{
+	return btp->bt_flags & XFS_BUFTARG_IN_MEMORY;
+}
+
 #define XB_PAGES	2
 
 struct xfs_buf_map {
@@ -372,13 +390,60 @@ xfs_buf_update_cksum(struct xfs_buf *bp, unsigned long cksum_offset)
  */
 struct xfs_buftarg *xfs_alloc_buftarg(struct xfs_mount *mp,
 		struct block_device *bdev);
+#ifdef CONFIG_XFS_IN_MEMORY_FILE
+int xfs_alloc_memory_buftarg(struct xfs_mount *mp, struct xfile *xfile,
+		struct xfs_buftarg **btpp);
+#endif
 extern void xfs_free_buftarg(struct xfs_buftarg *);
 extern void xfs_buftarg_wait(struct xfs_buftarg *);
 extern void xfs_buftarg_drain(struct xfs_buftarg *);
 extern int xfs_setsize_buftarg(struct xfs_buftarg *, unsigned int);
 
-#define xfs_getsize_buftarg(buftarg)	block_size((buftarg)->bt_bdev)
-#define xfs_readonly_buftarg(buftarg)	bdev_read_only((buftarg)->bt_bdev)
+static inline struct block_device *
+xfs_buftarg_bdev(struct xfs_buftarg *btp)
+{
+	if (btp->bt_flags & XFS_BUFTARG_IN_MEMORY)
+		return NULL;
+	return btp->bt_bdev;
+}
+
+static inline unsigned int
+xfs_getsize_buftarg(struct xfs_buftarg *btp)
+{
+	if (btp->bt_flags & XFS_BUFTARG_IN_MEMORY)
+		return SECTOR_SIZE;
+	return block_size(btp->bt_bdev);
+}
+
+static inline bool
+xfs_readonly_buftarg(struct xfs_buftarg *btp)
+{
+	if (btp->bt_flags & XFS_BUFTARG_IN_MEMORY)
+		return false;
+	return bdev_read_only(btp->bt_bdev);
+}
+
+static inline int
+xfs_buftarg_flush(struct xfs_buftarg *btp)
+{
+	if (btp->bt_flags & XFS_BUFTARG_IN_MEMORY)
+		return 0;
+	return blkdev_issue_flush(btp->bt_bdev);
+}
+
+static inline int
+xfs_buftarg_zeroout(
+	struct xfs_buftarg	*btp,
+	sector_t		sector,
+	sector_t		nr_sects,
+	gfp_t			gfp_mask,
+	unsigned		flags)
+{
+	if (btp->bt_flags & XFS_BUFTARG_IN_MEMORY)
+		return -EOPNOTSUPP;
+	return blkdev_issue_zeroout(btp->bt_bdev, sector, nr_sects, gfp_mask,
+			flags);
+}
 
 int xfs_buf_reverify(struct xfs_buf *bp, const struct xfs_buf_ops *ops);
 bool xfs_verify_magic(struct xfs_buf *bp, __be32 dmagic);
diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
index 3fa6b0ab9ed6..44658cc7d3f2 100644
--- a/fs/xfs/xfs_discard.c
+++ b/fs/xfs/xfs_discard.c
@@ -29,7 +29,7 @@ xfs_trim_extents(
 	xfs_daddr_t		minlen,
 	uint64_t		*blocks_trimmed)
 {
-	struct block_device	*bdev = mp->m_ddev_targp->bt_bdev;
+	struct block_device	*bdev = xfs_buftarg_bdev(mp->m_ddev_targp);
 	struct xfs_btree_cur	*cur;
 	struct xfs_buf		*agbp;
 	struct xfs_agf		*agf;
@@ -154,8 +154,8 @@ xfs_ioc_trim(
 	struct xfs_mount		*mp,
 	struct fstrim_range __user	*urange)
 {
-	unsigned int		granularity =
-		bdev_discard_granularity(mp->m_ddev_targp->bt_bdev);
+	struct block_device	*bdev = xfs_buftarg_bdev(mp->m_ddev_targp);
+	unsigned int		granularity = bdev_discard_granularity(bdev);
 	struct fstrim_range	range;
 	xfs_daddr_t		start, end, minlen;
 	xfs_agnumber_t		start_agno, end_agno, agno;
@@ -164,7 +164,7 @@ xfs_ioc_trim(
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	if (!bdev_max_discard_sectors(mp->m_ddev_targp->bt_bdev))
+	if (!bdev_max_discard_sectors(bdev))
 		return -EOPNOTSUPP;
 
 	/*
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 595a5bcf46b9..c4bdadd8fa71 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -164,9 +164,9 @@ xfs_file_fsync(
 	 * inode size in case of an extending write.
 	 */
 	if (XFS_IS_REALTIME_INODE(ip))
-		error = blkdev_issue_flush(mp->m_rtdev_targp->bt_bdev);
+		error = xfs_buftarg_flush(mp->m_rtdev_targp);
 	else if (mp->m_logdev_targp != mp->m_ddev_targp)
-		error = blkdev_issue_flush(mp->m_ddev_targp->bt_bdev);
+		error = xfs_buftarg_flush(mp->m_ddev_targp);
 
 	/*
 	 * Any inode that has dirty modifications in the log is pinned.  The
@@ -189,7 +189,7 @@ xfs_file_fsync(
 	 */
 	if (!log_flushed && !XFS_IS_REALTIME_INODE(ip) &&
 	    mp->m_logdev_targp == mp->m_ddev_targp) {
-		err2 = blkdev_issue_flush(mp->m_ddev_targp->bt_bdev);
+		err2 = xfs_buftarg_flush(mp->m_ddev_targp);
 		if (err2 && !error)
 			error = err2;
 	}
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 020111f0f2a2..4b2a02a08dfa 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1762,6 +1762,7 @@ xfs_ioc_setlabel(
 	char			__user *newlabel)
 {
 	struct xfs_sb		*sbp = &mp->m_sb;
+	struct block_device	*bdev = xfs_buftarg_bdev(mp->m_ddev_targp);
 	char			label[XFSLABEL_MAX + 1];
 	size_t			len;
 	int			error;
@@ -1808,7 +1809,7 @@ xfs_ioc_setlabel(
 	error = xfs_update_secondary_sbs(mp);
 	mutex_unlock(&mp->m_growlock);
 
-	invalidate_bdev(mp->m_ddev_targp->bt_bdev);
+	invalidate_bdev(bdev);
 
 out:
 	mnt_drop_write_file(filp);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index c2ba03281daf..99a7c271c353 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -129,7 +129,7 @@ xfs_bmbt_to_iomap(
 	if (mapping_flags & IOMAP_DAX)
 		iomap->dax_dev = target->bt_daxdev;
 	else
-		iomap->bdev = target->bt_bdev;
+		iomap->bdev = xfs_buftarg_bdev(target);
 	iomap->flags = iomap_flags;
 
 	if (xfs_ipincount(ip) &&
@@ -154,7 +154,7 @@ xfs_hole_to_iomap(
 	iomap->type = IOMAP_HOLE;
 	iomap->offset = XFS_FSB_TO_B(ip->i_mount, offset_fsb);
 	iomap->length = XFS_FSB_TO_B(ip->i_mount, end_fsb - offset_fsb);
-	iomap->bdev = target->bt_bdev;
+	iomap->bdev = xfs_buftarg_bdev(target);
 	iomap->dax_dev = target->bt_daxdev;
 }
 
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index fc61cc024023..b32a8e57f576 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1938,7 +1938,7 @@ xlog_write_iclog(
 	 * writeback throttle from throttling log writes behind background
 	 * metadata writeback and causing priority inversions.
 	 */
-	bio_init(&iclog->ic_bio, log->l_targ->bt_bdev, iclog->ic_bvec,
+	bio_init(&iclog->ic_bio, xfs_buftarg_bdev(log->l_targ), iclog->ic_bvec,
 		 howmany(count, PAGE_SIZE),
 		 REQ_OP_WRITE | REQ_META | REQ_SYNC | REQ_IDLE);
 	iclog->ic_bio.bi_iter.bi_sector = log->l_logBBstart + bno;
@@ -1959,7 +1959,7 @@ xlog_write_iclog(
 		 * avoid shutdown re-entering this path and erroring out again.
 		 */
 		if (log->l_targ != log->l_mp->m_ddev_targp &&
-		    blkdev_issue_flush(log->l_mp->m_ddev_targp->bt_bdev)) {
+		    xfs_buftarg_flush(log->l_mp->m_ddev_targp)) {
 			xlog_force_shutdown(log, SHUTDOWN_LOG_IO_ERROR);
 			return;
 		}
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index eccbfb99e894..12cd2874048f 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -742,7 +742,8 @@ xlog_discard_busy_extents(
 		trace_xfs_discard_extent(mp, busyp->agno, busyp->bno,
 					 busyp->length);
 
-		error = __blkdev_issue_discard(mp->m_ddev_targp->bt_bdev,
+		error = __blkdev_issue_discard(
+				xfs_buftarg_bdev(mp->m_ddev_targp),
 				XFS_AGB_TO_DADDR(mp, busyp->agno, busyp->bno),
 				XFS_FSB_TO_BB(mp, busyp->length),
 				GFP_NOFS, &bio);
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 322eb2ee6c55..6b1f37bc3e95 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -137,7 +137,8 @@ xlog_do_io(
 	nbblks = round_up(nbblks, log->l_sectBBsize);
 	ASSERT(nbblks > 0);
 
-	error = xfs_rw_bdev(log->l_targ->bt_bdev, log->l_logBBstart + blk_no,
+	error = xfs_rw_bdev(xfs_buftarg_bdev(log->l_targ),
+			log->l_logBBstart + blk_no,
 			BBTOB(nbblks), data, op);
 	if (error && !xlog_is_shutdown(log)) {
 		xfs_alert(log->l_mp,
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 020ff2d93f23..8841947bdce7 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -397,13 +397,13 @@ xfs_close_devices(
 	struct xfs_mount	*mp)
 {
 	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
-		struct block_device *logdev = mp->m_logdev_targp->bt_bdev;
+		struct block_device *logdev = xfs_buftarg_bdev(mp->m_logdev_targp);
 
 		xfs_free_buftarg(mp->m_logdev_targp);
 		xfs_blkdev_put(logdev);
 	}
 	if (mp->m_rtdev_targp) {
-		struct block_device *rtdev = mp->m_rtdev_targp->bt_bdev;
+		struct block_device *rtdev = xfs_buftarg_bdev(mp->m_rtdev_targp);
 
 		xfs_free_buftarg(mp->m_rtdev_targp);
 		xfs_blkdev_put(rtdev);

