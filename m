Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FB5623230
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 19:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiKISQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 13:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiKISQe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:16:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4076275E2;
        Wed,  9 Nov 2022 10:16:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69D2FB81F6A;
        Wed,  9 Nov 2022 18:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E10EC433C1;
        Wed,  9 Nov 2022 18:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668017790;
        bh=NeCbs/ILUqgiyzNF+t8zwGfWX4oDIXdRCDYKOIS0Ys0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=k8u1RtcULrZlVh+BiNa2RFZB2ZkUD8sxFQF3S9kW8+ooB08L0TyeTYX45ZtxleZUM
         Nfv/L2LiyffVQ1pVNz78wzlfqHoGYTnMbMqomrzj7ZK6tmVwkj/GVBAS4c+5/4yAAG
         p5PPCMTfhKtbZwk7rP9qV1LhHYl6TA0CGbbuiSQb/yaeuDoBlpmbCnnJMi2wgZ7lfa
         q/4c/nF15ke48RGwanmr/fxEBG+AJauNeeDaj0HdAKolljk80+Lcj1TVhQwCBWDKKk
         90ZSJ1+A7r9jDVYc7f8tgG4wNjFmwwp5F8/cPteb3JrKAaFgTQYPs9gnMx7FUpHS2J
         lYOjWLa18l2CA==
Subject: [PATCH 08/14] iomap: pass iter to ->iomap_begin implementations
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org
Date:   Wed, 09 Nov 2022 10:16:29 -0800
Message-ID: <166801778962.3992140.13451716594530581376.stgit@magnolia>
In-Reply-To: <166801774453.3992140.241667783932550826.stgit@magnolia>
References: <166801774453.3992140.241667783932550826.stgit@magnolia>
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

Clean up the ->iomap_begin call sites by passing a pointer to the iter
structure into the iomap_begin functions.  This will be needed to clean
up the xfs race condition fixes in the next patch, and will hopefully
reduce register pressure as well.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/btrfs/inode.c      |   10 ++++++----
 fs/erofs/data.c       |    8 ++++++--
 fs/erofs/zmap.c       |    6 ++++--
 fs/ext2/inode.c       |    8 ++++++--
 fs/ext4/extents.c     |    5 +++--
 fs/ext4/inode.c       |   32 +++++++++++++++++++++-----------
 fs/f2fs/data.c        |    9 ++++++---
 fs/fuse/dax.c         |    9 ++++++---
 fs/gfs2/bmap.c        |   18 ++++++++++++------
 fs/hpfs/file.c        |    8 ++++++--
 fs/iomap/iter.c       |    3 +--
 fs/xfs/xfs_iomap.c    |   48 ++++++++++++++++++++++++++----------------------
 fs/zonefs/super.c     |   24 +++++++++++++++++-------
 include/linux/iomap.h |    5 +++--
 14 files changed, 123 insertions(+), 70 deletions(-)


diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0e516aefbf51..d1030128769b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7517,11 +7517,13 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	return ret;
 }
 
-static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
-		loff_t length, unsigned int flags, struct iomap *iomap,
-		struct iomap *srcmap)
+static int btrfs_dio_iomap_begin(const struct iomap_iter *iter,
+		struct iomap *iomap, struct iomap *srcmap)
 {
-	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
+	struct inode *inode = iter->inode;
+	loff_t start = iter->pos;
+	loff_t length = iter->len;
+	unsigned int flags = iter->flags;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_map *em;
 	struct extent_state *cached_state = NULL;
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index fe8ac0e163f7..093ffbefc027 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -249,9 +249,13 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	return 0;
 }
 
-static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
-		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+static int erofs_iomap_begin(const struct iomap_iter *iter,
+		struct iomap *iomap, struct iomap *srcmap)
 {
+	struct inode *inode = iter->inode;
+	loff_t offset = iter->pos;
+	loff_t length = iter->len;
+	unsigned int flags = iter->flags;
 	int ret;
 	struct erofs_map_blocks map;
 	struct erofs_map_dev mdev;
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 0bb66927e3d0..434087cbf467 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -767,10 +767,12 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 	return err;
 }
 
-static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
-				loff_t length, unsigned int flags,
+static int z_erofs_iomap_begin_report(const struct iomap_iter *iter,
 				struct iomap *iomap, struct iomap *srcmap)
 {
+	struct inode *inode = iter->inode;
+	loff_t offset = iter->pos;
+	loff_t length = iter->len;
 	int ret;
 	struct erofs_map_blocks map = { .m_la = offset };
 
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 918ab2f9e4c0..808a6c5a2db1 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -799,9 +799,13 @@ int ext2_get_block(struct inode *inode, sector_t iblock,
 
 }
 
-static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
-		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
+static int ext2_iomap_begin(const struct iomap_iter *iter,
+		struct iomap *iomap, struct iomap *srcmap)
 {
+	struct inode *inode = iter->inode;
+	loff_t offset = iter->pos;
+	loff_t length = iter->len;
+	unsigned int flags = iter->flags;
 	unsigned int blkbits = inode->i_blkbits;
 	unsigned long first_block = offset >> blkbits;
 	unsigned long max_blocks = (length + (1 << blkbits) - 1) >> blkbits;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f1956288307f..d462188cd2db 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4903,10 +4903,11 @@ static int ext4_iomap_xattr_fiemap(struct inode *inode, struct iomap *iomap)
 	return error;
 }
 
-static int ext4_iomap_xattr_begin(struct inode *inode, loff_t offset,
-				  loff_t length, unsigned flags,
+static int ext4_iomap_xattr_begin(const struct iomap_iter *iter,
 				  struct iomap *iomap, struct iomap *srcmap)
 {
+	struct inode *inode = iter->inode;
+	loff_t offset = iter->pos;
 	int error;
 
 	error = ext4_iomap_xattr_fiemap(inode, iomap);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2b5ef1b64249..8d15b83caaca 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3428,10 +3428,12 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 	return ret;
 }
 
-
-static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
-		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
+static int __ext4_iomap_begin(const struct iomap_iter *iter, unsigned int flags,
+		struct iomap *iomap, struct iomap *srcmap)
 {
+	struct inode *inode = iter->inode;
+	loff_t offset = iter->pos;
+	loff_t length = iter->len;
 	int ret;
 	struct ext4_map_blocks map;
 	u8 blkbits = inode->i_blkbits;
@@ -3481,18 +3483,23 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
-static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
-		loff_t length, unsigned flags, struct iomap *iomap,
-		struct iomap *srcmap)
+static int ext4_iomap_begin(const struct iomap_iter *iter,
+		struct iomap *iomap, struct iomap *srcmap)
 {
-	int ret;
+	return __ext4_iomap_begin(iter, iter->flags, iomap, srcmap);
+}
 
+static int ext4_iomap_overwrite_begin(const struct iomap_iter *iter,
+		struct iomap *iomap, struct iomap *srcmap)
+{
 	/*
 	 * Even for writes we don't need to allocate blocks, so just pretend
 	 * we are reading to save overhead of starting a transaction.
 	 */
-	flags &= ~IOMAP_WRITE;
-	ret = ext4_iomap_begin(inode, offset, length, flags, iomap, srcmap);
+	unsigned int flags = iter->flags & ~IOMAP_WRITE;
+	int ret;
+
+	ret = __ext4_iomap_begin(iter, flags, iomap, srcmap);
 	WARN_ON_ONCE(iomap->type != IOMAP_MAPPED);
 	return ret;
 }
@@ -3546,10 +3553,13 @@ static bool ext4_iomap_is_delalloc(struct inode *inode,
 	return true;
 }
 
-static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
-				   loff_t length, unsigned int flags,
+static int ext4_iomap_begin_report(const struct iomap_iter *iter,
 				   struct iomap *iomap, struct iomap *srcmap)
 {
+	struct inode *inode = iter->inode;
+	loff_t offset = iter->pos;
+	loff_t length = iter->len;
+	unsigned int flags = iter->flags;
 	int ret;
 	bool delalloc = false;
 	struct ext4_map_blocks map;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a71e818cd67b..ea79fda6aaa9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4105,10 +4105,13 @@ void f2fs_destroy_bio_entry_cache(void)
 	kmem_cache_destroy(bio_entry_slab);
 }
 
-static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
-			    unsigned int flags, struct iomap *iomap,
-			    struct iomap *srcmap)
+static int f2fs_iomap_begin(const struct iomap_iter *iter,
+			    struct iomap *iomap, struct iomap *srcmap)
 {
+	struct inode *inode = iter->inode;
+	loff_t offset = iter->pos;
+	loff_t length = iter->len;
+	unsigned int flags = iter->flags;
 	struct f2fs_map_blocks map = {};
 	pgoff_t next_pgofs = 0;
 	int err;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index e23e802a8013..65bf4e35bac3 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -558,10 +558,13 @@ static int fuse_upgrade_dax_mapping(struct inode *inode, loff_t pos,
 /* This is just for DAX and the mapping is ephemeral, do not use it for other
  * purposes since there is no block device with a permanent mapping.
  */
-static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
-			    unsigned int flags, struct iomap *iomap,
-			    struct iomap *srcmap)
+static int fuse_iomap_begin(const struct iomap_iter *iter,
+			    struct iomap *iomap, struct iomap *srcmap)
 {
+	struct inode *inode = iter->inode;
+	loff_t pos = iter->pos;
+	loff_t length = iter->len;
+	unsigned int flags = iter->flags;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_dax_mapping *dmap;
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 3bdb2c668a71..1e438e0734d4 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -991,12 +991,15 @@ static const struct iomap_page_ops gfs2_iomap_page_ops = {
 	.page_done = gfs2_iomap_page_done,
 };
 
-static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
-				  loff_t length, unsigned flags,
+static int gfs2_iomap_begin_write(const struct iomap_iter *iter,
 				  struct iomap *iomap,
 				  struct metapath *mp)
 {
-	struct gfs2_inode *ip = GFS2_I(inode);
+	struct inode *inode = iter->inode;
+	loff_t pos = iter->pos;
+	loff_t length = iter->len;
+	unsigned int flags = iter->flags;
+ 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	bool unstuff;
 	int ret;
@@ -1076,10 +1079,13 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
 	return ret;
 }
 
-static int gfs2_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
-			    unsigned flags, struct iomap *iomap,
+static int gfs2_iomap_begin(const struct iomap_iter *iter, struct iomap *iomap,
 			    struct iomap *srcmap)
 {
+	struct inode *inode = iter->inode;
+	loff_t pos = iter->pos;
+	loff_t length = iter->len;
+	unsigned int flags = iter->flags;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct metapath mp = { .mp_aheight = 1, };
 	int ret;
@@ -1112,7 +1118,7 @@ static int gfs2_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
 		goto out_unlock;
 	}
 
-	ret = gfs2_iomap_begin_write(inode, pos, length, flags, iomap, &mp);
+	ret = gfs2_iomap_begin_write(iter, iomap, &mp);
 
 out_unlock:
 	release_metapath(&mp);
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index f7547a62c81f..43f727d650c6 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -117,9 +117,13 @@ static int hpfs_get_block(struct inode *inode, sector_t iblock, struct buffer_he
 	return r;
 }
 
-static int hpfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
-		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
+static int hpfs_iomap_begin(const struct iomap_iter *iter,
+		struct iomap *iomap, struct iomap *srcmap)
 {
+	struct inode *inode = iter->inode;
+	loff_t offset = iter->pos;
+	loff_t length = iter->len;
+	unsigned int flags = iter->flags;
 	struct super_block *sb = inode->i_sb;
 	unsigned int blkbits = inode->i_blkbits;
 	unsigned int n_secs;
diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 79a0614eaab7..2e84f8be6d8d 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -88,8 +88,7 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 	if (ret <= 0)
 		return ret;
 
-	ret = ops->iomap_begin(iter->inode, iter->pos, iter->len, iter->flags,
-			       &iter->iomap, &iter->srcmap);
+	ret = ops->iomap_begin(iter, &iter->iomap, &iter->srcmap);
 	if (ret < 0)
 		return ret;
 	iomap_iter_done(iter);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 8e7e51c5f56d..ca88facfd61e 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -734,13 +734,14 @@ imap_spans_range(
 
 static int
 xfs_direct_write_iomap_begin(
-	struct inode		*inode,
-	loff_t			offset,
-	loff_t			length,
-	unsigned		flags,
+	const struct iomap_iter	*iter,
 	struct iomap		*iomap,
 	struct iomap		*srcmap)
 {
+	struct inode		*inode = iter->inode;
+	loff_t			offset = iter->pos;
+	loff_t			length = iter->len;
+	unsigned int		flags = iter->flags;
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_bmbt_irec	imap, cmap;
@@ -907,13 +908,14 @@ const struct iomap_ops xfs_dax_write_iomap_ops = {
 
 static int
 xfs_buffered_write_iomap_begin(
-	struct inode		*inode,
-	loff_t			offset,
-	loff_t			count,
-	unsigned		flags,
+	const struct iomap_iter *iter,
 	struct iomap		*iomap,
 	struct iomap		*srcmap)
 {
+	struct inode		*inode = iter->inode;
+	loff_t			offset = iter->pos;
+	loff_t			count = iter->len;
+	unsigned int		flags = iter->flags;
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
@@ -932,8 +934,7 @@ xfs_buffered_write_iomap_begin(
 
 	/* we can't use delayed allocations when using extent size hints */
 	if (xfs_get_extsz_hint(ip))
-		return xfs_direct_write_iomap_begin(inode, offset, count,
-				flags, iomap, srcmap);
+		return xfs_direct_write_iomap_begin(iter, iomap, srcmap);
 
 	ASSERT(!XFS_IS_REALTIME_INODE(ip));
 
@@ -1366,13 +1367,14 @@ const struct iomap_ops xfs_page_mkwrite_iomap_ops = {
 
 static int
 xfs_read_iomap_begin(
-	struct inode		*inode,
-	loff_t			offset,
-	loff_t			length,
-	unsigned		flags,
+	const struct iomap_iter	*iter,
 	struct iomap		*iomap,
 	struct iomap		*srcmap)
 {
+	struct inode		*inode = iter->inode;
+	loff_t			offset = iter->pos;
+	loff_t			length = iter->len;
+	unsigned int		flags = iter->flags;
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_bmbt_irec	imap;
@@ -1411,13 +1413,14 @@ const struct iomap_ops xfs_read_iomap_ops = {
 
 static int
 xfs_seek_iomap_begin(
-	struct inode		*inode,
-	loff_t			offset,
-	loff_t			length,
-	unsigned		flags,
+	const struct iomap_iter	*iter,
 	struct iomap		*iomap,
 	struct iomap		*srcmap)
 {
+	struct inode		*inode = iter->inode;
+	loff_t			offset = iter->pos;
+	loff_t			length = iter->len;
+	unsigned int		flags = iter->flags;
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
@@ -1497,13 +1500,14 @@ const struct iomap_ops xfs_seek_iomap_ops = {
 
 static int
 xfs_xattr_iomap_begin(
-	struct inode		*inode,
-	loff_t			offset,
-	loff_t			length,
-	unsigned		flags,
+	const struct iomap_iter	*iter,
 	struct iomap		*iomap,
 	struct iomap		*srcmap)
 {
+	struct inode		*inode = iter->inode;
+	loff_t			offset = iter->pos;
+	loff_t			length = iter->len;
+	unsigned int		flags = iter->flags;
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 860f0b1032c6..9a8e261ece8b 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -109,10 +109,12 @@ static inline void zonefs_i_size_write(struct inode *inode, loff_t isize)
 	}
 }
 
-static int zonefs_read_iomap_begin(struct inode *inode, loff_t offset,
-				   loff_t length, unsigned int flags,
+static int zonefs_read_iomap_begin(const struct iomap_iter *iter,
 				   struct iomap *iomap, struct iomap *srcmap)
 {
+	struct inode *inode = iter->inode;
+	loff_t offset = iter->pos;
+	loff_t length = iter->len;
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct super_block *sb = inode->i_sb;
 	loff_t isize;
@@ -145,9 +147,9 @@ static const struct iomap_ops zonefs_read_iomap_ops = {
 	.iomap_begin	= zonefs_read_iomap_begin,
 };
 
-static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
-				    loff_t length, unsigned int flags,
-				    struct iomap *iomap, struct iomap *srcmap)
+static int __zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
+		loff_t length, unsigned int flags, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct super_block *sb = inode->i_sb;
@@ -190,6 +192,13 @@ static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
 	return 0;
 }
 
+static int zonefs_write_iomap_begin(const struct iomap_iter *iter,
+				    struct iomap *iomap, struct iomap *srcmap)
+{
+	return __zonefs_write_iomap_begin(iter->inode, iter->pos, iter->len,
+			iter->flags, iomap, srcmap);
+}
+
 static const struct iomap_ops zonefs_write_iomap_ops = {
 	.iomap_begin	= zonefs_write_iomap_begin,
 };
@@ -223,8 +232,9 @@ static int zonefs_write_map_blocks(struct iomap_writepage_ctx *wpc,
 	    offset < wpc->iomap.offset + wpc->iomap.length)
 		return 0;
 
-	return zonefs_write_iomap_begin(inode, offset, zi->i_max_size - offset,
-					IOMAP_WRITE, &wpc->iomap, NULL);
+	return __zonefs_write_iomap_begin(inode, offset,
+			zi->i_max_size - offset, IOMAP_WRITE, &wpc->iomap,
+			NULL);
 }
 
 static const struct iomap_writeback_ops zonefs_writeback_ops = {
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 308931f0840a..811ea61ba577 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -152,14 +152,15 @@ struct iomap_page_ops {
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
 
+struct iomap_iter;
+
 struct iomap_ops {
 	/*
 	 * Return the existing mapping at pos, or reserve space starting at
 	 * pos for up to length, as long as we can do it as a single mapping.
 	 * The actual length is returned in iomap->length.
 	 */
-	int (*iomap_begin)(struct inode *inode, loff_t pos, loff_t length,
-			unsigned flags, struct iomap *iomap,
+	int (*iomap_begin)(const struct iomap_iter *iter, struct iomap *iomap,
 			struct iomap *srcmap);
 
 	/*

