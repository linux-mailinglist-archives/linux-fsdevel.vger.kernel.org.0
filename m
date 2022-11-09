Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4190C623232
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 19:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiKISQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 13:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiKISQk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:16:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE1F275FC;
        Wed,  9 Nov 2022 10:16:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F891B81F69;
        Wed,  9 Nov 2022 18:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD045C433D6;
        Wed,  9 Nov 2022 18:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668017795;
        bh=SSPp1uWE1pQRfUVUJqFuEI67QwMnoQhhVwUZ4jgsZZ8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=m+TfqQPElzshm1/1JuuqL4OonP7TwjEEG0cl7ejIBvZiNu4YUmuez1x9f3wMn+S7z
         75+9iQ8pQ6f+djbBz/Ga/kjy6HuvAlYwceHbryhfB5VtNxpg9vumy+nG06tt+zZkpA
         nSs8BP1c58GBD9/gunBujaCRWwQnU5cYVLK2Fh9pd1m3KgyOSbADMnO1wPsq6aHEcU
         yJBwdEJBmL06apOuj6MPBvZICYJPgSPIdDQEWbZtP2nXuNYHzmeww500sbVFjdyPVf
         xvDPtOSBTsgn/Au2BjHJzPohWFbQtytq3um5iOLjv3FlNBXhypERUeQcLPBt7p//T5
         AuWJiRmshnImw==
Subject: [PATCH 09/14] iomap: pass iter to ->iomap_end implementations
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org
Date:   Wed, 09 Nov 2022 10:16:35 -0800
Message-ID: <166801779522.3992140.4135946031734299717.stgit@magnolia>
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

Clean up the ->iomap_end call sites by passing a pointer to the iter
structure into the iomap_end functions.  This isn't strictly needed,
but it cleans up the callsites neatly.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/btrfs/inode.c      |    8 +++++---
 fs/erofs/data.c       |    4 ++--
 fs/ext2/inode.c       |    8 ++++++--
 fs/ext4/inode.c       |    6 +++---
 fs/fuse/dax.c         |    5 ++---
 fs/gfs2/bmap.c        |    7 +++++--
 fs/iomap/iter.c       |    5 ++---
 fs/xfs/xfs_iomap.c    |   28 ++++++++++++++--------------
 include/linux/iomap.h |    4 ++--
 9 files changed, 41 insertions(+), 34 deletions(-)


diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d1030128769b..50afc8a3a5da 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7770,10 +7770,12 @@ static int btrfs_dio_iomap_begin(const struct iomap_iter *iter,
 	return ret;
 }
 
-static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
-		ssize_t written, unsigned int flags, struct iomap *iomap)
+static int btrfs_dio_iomap_end(const struct iomap_iter *iter, u64 length,
+		ssize_t written, struct iomap *iomap)
 {
-	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
+	struct inode *inode = iter->inode;
+	loff_t pos = iter->pos;
+	unsigned int flags = iter->flags;
 	struct btrfs_dio_data *dio_data = iter->private;
 	size_t submitted = dio_data->submitted;
 	const bool write = !!(flags & IOMAP_WRITE);
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 093ffbefc027..f3f42ec39c8d 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -312,8 +312,8 @@ static int erofs_iomap_begin(const struct iomap_iter *iter,
 	return 0;
 }
 
-static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
-		ssize_t written, unsigned int flags, struct iomap *iomap)
+static int erofs_iomap_end(const struct iomap_iter *iter, u64 length,
+		ssize_t written, struct iomap *iomap)
 {
 	void *ptr = iomap->private;
 
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 808a6c5a2db1..f28c47e519db 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -845,9 +845,13 @@ static int ext2_iomap_begin(const struct iomap_iter *iter,
 }
 
 static int
-ext2_iomap_end(struct inode *inode, loff_t offset, loff_t length,
-		ssize_t written, unsigned flags, struct iomap *iomap)
+ext2_iomap_end(const struct iomap_iter *iter, u64 length, ssize_t written,
+		struct iomap *iomap)
 {
+	struct inode *inode = iter->inode;
+	loff_t offset = iter->pos;
+	unsigned int flags = iter->flags;
+
 	if (iomap->type == IOMAP_MAPPED &&
 	    written < length &&
 	    (flags & IOMAP_WRITE))
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8d15b83caaca..7d1f512e5187 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3504,8 +3504,8 @@ static int ext4_iomap_overwrite_begin(const struct iomap_iter *iter,
 	return ret;
 }
 
-static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
-			  ssize_t written, unsigned flags, struct iomap *iomap)
+static int ext4_iomap_end(const struct iomap_iter *iter, u64 length,
+			  ssize_t written, struct iomap *iomap)
 {
 	/*
 	 * Check to see whether an error occurred while writing out the data to
@@ -3514,7 +3514,7 @@ static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 	 * the I/O. Any blocks that may have been allocated in preparation for
 	 * the direct I/O will be reused during buffered I/O.
 	 */
-	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
+	if (iter->flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
 		return -ENOTBLK;
 
 	return 0;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 65bf4e35bac3..7fea437246aa 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -635,9 +635,8 @@ static int fuse_iomap_begin(const struct iomap_iter *iter,
 	return 0;
 }
 
-static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t length,
-			  ssize_t written, unsigned int flags,
-			  struct iomap *iomap)
+static int fuse_iomap_end(const struct iomap_iter *iter, u64 length,
+			  ssize_t written, struct iomap *iomap)
 {
 	struct fuse_dax_mapping *dmap = iomap->private;
 
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 1e438e0734d4..f215c0735fa6 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1126,9 +1126,12 @@ static int gfs2_iomap_begin(const struct iomap_iter *iter, struct iomap *iomap,
 	return ret;
 }
 
-static int gfs2_iomap_end(struct inode *inode, loff_t pos, loff_t length,
-			  ssize_t written, unsigned flags, struct iomap *iomap)
+static int gfs2_iomap_end(const struct iomap_iter *iter, u64 length,
+			  ssize_t written, struct iomap *iomap)
 {
+	struct inode *inode = iter->inode;
+	loff_t pos = iter->pos;
+	unsigned int flags = iter->flags;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 
diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 2e84f8be6d8d..494e905844cf 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -76,9 +76,8 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 	int ret;
 
 	if (iter->iomap.length && ops->iomap_end) {
-		ret = ops->iomap_end(iter->inode, iter->pos, iomap_length(iter),
-				iter->processed > 0 ? iter->processed : 0,
-				iter->flags, &iter->iomap);
+		ret = ops->iomap_end(iter, iomap_length(iter),
+				max_t(s64, iter->processed, 0), &iter->iomap);
 		if (ret < 0 && !iter->processed)
 			return ret;
 	}
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index ca88facfd61e..668f66ca84e4 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -881,20 +881,19 @@ const struct iomap_ops xfs_direct_write_iomap_ops = {
 
 static int
 xfs_dax_write_iomap_end(
-	struct inode		*inode,
-	loff_t			pos,
-	loff_t			length,
+	const struct iomap_iter	*iter,
+	u64			mapped_length,
 	ssize_t			written,
-	unsigned		flags,
 	struct iomap		*iomap)
 {
-	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_inode	*ip = XFS_I(iter->inode);
+	loff_t			pos = iter->pos;
 
 	if (!xfs_is_cow_inode(ip))
 		return 0;
 
 	if (!written) {
-		xfs_reflink_cancel_cow_range(ip, pos, length, true);
+		xfs_reflink_cancel_cow_range(ip, pos, mapped_length, true);
 		return 0;
 	}
 
@@ -1291,14 +1290,14 @@ xfs_buffered_write_delalloc_release(
 
 static int
 xfs_buffered_write_iomap_end(
-	struct inode		*inode,
-	loff_t			offset,
-	loff_t			length,
+	const struct iomap_iter	*iter,
+	u64			mapped_length,
 	ssize_t			written,
-	unsigned		flags,
 	struct iomap		*iomap)
 {
-	struct xfs_mount	*mp = XFS_M(inode->i_sb);
+	struct xfs_inode	*ip = XFS_I(iter->inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	loff_t			offset = iter->pos;
 	loff_t			start_byte;
 	loff_t			end_byte;
 	int			error = 0;
@@ -1319,16 +1318,17 @@ xfs_buffered_write_iomap_end(
 		start_byte = round_down(offset, mp->m_sb.sb_blocksize);
 	else
 		start_byte = round_up(offset + written, mp->m_sb.sb_blocksize);
-	end_byte = round_up(offset + length, mp->m_sb.sb_blocksize);
+	end_byte = round_up(offset + mapped_length, mp->m_sb.sb_blocksize);
 
 	/* Nothing to do if we've written the entire delalloc extent */
 	if (start_byte >= end_byte)
 		return 0;
 
-	error = xfs_buffered_write_delalloc_release(inode, start_byte, end_byte);
+	error = xfs_buffered_write_delalloc_release(VFS_I(ip), start_byte,
+			end_byte);
 	if (error && !xfs_is_shutdown(mp)) {
 		xfs_alert(mp, "%s: unable to clean up ino 0x%llx",
-			__func__, XFS_I(inode)->i_ino);
+			__func__, ip->i_ino);
 		return error;
 	}
 	return 0;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 811ea61ba577..7485a5a3af17 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -169,8 +169,8 @@ struct iomap_ops {
 	 * needs to be commited, while the rest needs to be unreserved.
 	 * Written might be zero if no data was written.
 	 */
-	int (*iomap_end)(struct inode *inode, loff_t pos, loff_t length,
-			ssize_t written, unsigned flags, struct iomap *iomap);
+	int (*iomap_end)(const struct iomap_iter *iter, u64 mapped_length,
+			ssize_t written, struct iomap *iomap);
 
 	/*
 	 * Check that the cached iomap still maps correctly to the filesystem's

