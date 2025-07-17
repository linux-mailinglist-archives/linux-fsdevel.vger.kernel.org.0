Return-Path: <linux-fsdevel+bounces-55374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F8FB09852
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C343AFBBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB39241676;
	Thu, 17 Jul 2025 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+XpcqIM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054EABE46;
	Thu, 17 Jul 2025 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795719; cv=none; b=NQ/U3RBrH0JDu93WlZ8kim7R0uvk2Cs2smqf8eekvgujCii5vLdtMCmcMvXMw5L2UpDCKj20vtFz3fynEV1JD1BtqCOUiuVcrNVuQvL5aJ5mODdA5EsFVuNFp/0EFvmiYPqKK9jSmtxpzCF1Jqd0ueEWpwLXtePTTSzZAUrgA+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795719; c=relaxed/simple;
	bh=JoCUmHGvz3g/K6wXWXJLKc2BdofSjXBFz+BBGNG4Npo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqwTHC3UMxEqWCoLf+priJL7phA++4gUUjvYxDnsXM/ZG1SHZ/BfhzUeg+vUiERnprdscDPlVVK1o74vH2DhowadJa747j36gVuAnz0Y3zZyE9EY2Cx+hrFPGY0WslzzSY9eOm/45OWA/CYNZ3s4wySqnD0zZi7hdWO+pYxLDXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+XpcqIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D76C4CEE3;
	Thu, 17 Jul 2025 23:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795718;
	bh=JoCUmHGvz3g/K6wXWXJLKc2BdofSjXBFz+BBGNG4Npo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Q+XpcqIMheMXTdEWNJOba2s6aAUeotIpv99YHmhvjAf1+Z1nDCIvI9r30dV1IY0BO
	 qbsykNdkvDVmv1iNKK2lEyGr5YFqNwusgV3UXuop5Qp+RAe5G66Dh7F1oKQEjD1gXl
	 ga+u9A2OV+VrEOZ77EAwB+CQ3dIoAPDohJF5znBevqzFpNAnIPMrTpRhxSG9V3wPFM
	 b4LGCrPGmBEDvSGlD8JFplw1pGYJ0zUMQ2oXY7+YJQUMSDiTzcjC6jlK3v3dTpF6zE
	 y0izt5FA9PJiouRSPg20t1aDFSQ79oj8LOWQA6y2Mjwc3DEeFb4aEGmn83O9C/9NU5
	 LZn8VM1+EyGuQ==
Date: Thu, 17 Jul 2025 16:41:58 -0700
Subject: [PATCH 10/22] fuse2fs: implement direct write support
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461214.715479.6461411447508224403.stgit@frogsfrogsfrogs>
In-Reply-To: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
References: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Wire up an iomap_begin method that can allocate into holes so that we
can do directio writes.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |  482 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 479 insertions(+), 3 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 0137403b7a25b9..8c3cc7adc72579 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5259,12 +5259,100 @@ static int fuse2fs_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 					    opflags, read_iomap);
 }
 
+static int fuse2fs_iomap_write_allocate(struct fuse2fs *ff, ext2_ino_t ino,
+				     struct ext2_inode_large *inode, off_t pos,
+				     uint64_t count, uint32_t opflags, struct
+				     fuse_iomap *read_iomap, bool *dirty)
+{
+	ext2_filsys fs = ff->fs;
+	blk64_t startoff = FUSE2FS_B_TO_FSBT(ff, pos);
+	blk64_t stopoff = FUSE2FS_B_TO_FSB(ff, pos + count);
+	errcode_t err;
+	int ret;
+
+	dbg_printf(ff, "%s: write_alloc ino=%u startoff 0x%llx blockcount 0x%llx\n",
+		   __func__, ino, startoff, stopoff - startoff);
+
+	if (!fs_can_allocate(ff, stopoff - startoff))
+		return -ENOSPC;
+
+	err = ext2fs_fallocate(fs, EXT2_FALLOCATE_FORCE_UNINIT, ino,
+			       EXT2_INODE(inode), ~0ULL, startoff,
+			       stopoff - startoff);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	/* pick up the newly allocated mapping */
+	ret = fuse2fs_iomap_begin_read(ff, ino, inode, pos, count, opflags,
+				       read_iomap);
+	if (ret)
+		return ret;
+
+	read_iomap->flags |= FUSE_IOMAP_F_DIRTY;
+	*dirty = true;
+	return 0;
+}
+
+static off_t fuse2fs_max_file_size(const struct fuse2fs *ff,
+				   const struct ext2_inode_large *inode)
+{
+	ext2_filsys fs = ff->fs;
+	blk64_t addr_per_block, max_map_block;
+
+	if (inode->i_flags & EXT4_EXTENTS_FL) {
+		max_map_block = (1ULL << 32) - 1;
+	} else {
+		addr_per_block = fs->blocksize >> 2;
+		max_map_block = addr_per_block;
+		max_map_block += addr_per_block * addr_per_block;
+		max_map_block += addr_per_block * addr_per_block * addr_per_block;
+		max_map_block += 12;
+	}
+
+	return FUSE2FS_FSB_TO_B(ff, max_map_block) + (fs->blocksize - 1);
+}
+
 static int fuse2fs_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,
 				     struct ext2_inode_large *inode, off_t pos,
 				     uint64_t count, uint32_t opflags,
-				     struct fuse_iomap *read_iomap)
+				     struct fuse_iomap *read_iomap,
+				     bool *dirty)
 {
-	return -ENOSYS;
+	off_t max_size = fuse2fs_max_file_size(ff, inode);
+	errcode_t err;
+	int ret;
+
+	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
+		return -ENOSYS;
+
+	if (pos >= max_size)
+		return -EFBIG;
+
+	if (pos >= max_size - count)
+		count = max_size - pos;
+
+	ret = fuse2fs_iomap_begin_read(ff, ino, inode, pos, count, opflags,
+				       read_iomap);
+	if (ret)
+		return ret;
+
+	if (read_iomap->type == FUSE_IOMAP_TYPE_HOLE &&
+	    !(opflags & FUSE_IOMAP_OP_ZERO)) {
+		ret = fuse2fs_iomap_write_allocate(ff, ino, inode, pos, count,
+						   opflags, read_iomap, dirty);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * flush and invalidate the file's io_channel buffers before iomap
+	 * writes them
+	 */
+	err = io_channel_invalidate_tag(ff->fs->io, ino);
+	if (err)
+		return translate_error(ff->fs, ino, err);
+
+	return 0;
 }
 
 static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
@@ -5277,6 +5365,7 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 	struct ext2_inode_large inode;
 	ext2_filsys fs;
 	errcode_t err;
+	bool dirty = false;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -5302,7 +5391,8 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 						 count, opflags, read_iomap);
 	else if (opflags & (FUSE_IOMAP_OP_WRITE | FUSE_IOMAP_OP_ZERO))
 		ret = fuse2fs_iomap_begin_write(ff, attr_ino, &inode, pos,
-						count, opflags, read_iomap);
+						count, opflags, read_iomap,
+						&dirty);
 	else
 		ret = fuse2fs_iomap_begin_read(ff, attr_ino, &inode, pos,
 					       count, opflags, read_iomap);
@@ -5319,6 +5409,14 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 		   (unsigned long long)read_iomap->length,
 		   read_iomap->type);
 
+	if (dirty) {
+		err = fuse2fs_write_inode(fs, attr_ino, &inode);
+		if (err) {
+			ret = translate_error(fs, attr_ino, err);
+			goto out_unlock;
+		}
+	}
+
 out_unlock:
 	fuse2fs_finish(ff, ret);
 	return ret;
@@ -5460,6 +5558,383 @@ static int op_iomap_config(uint32_t flags, off_t maxbytes,
 		goto out_unlock;
 	}
 
+out_unlock:
+	fuse2fs_finish(ff, ret);
+	return ret;
+}
+
+static inline bool fuse2fs_can_merge_mappings(const struct ext2fs_extent *left,
+					      const struct ext2fs_extent *right)
+{
+	uint64_t max_len = (left->e_flags & EXT2_EXTENT_FLAGS_UNINIT) ?
+				EXT_UNINIT_MAX_LEN : EXT_INIT_MAX_LEN;
+
+	return left->e_lblk + left->e_len == right->e_lblk &&
+	       left->e_pblk + left->e_len == right->e_pblk &&
+	       (left->e_flags & EXT2_EXTENT_FLAGS_UNINIT) ==
+	        (right->e_flags & EXT2_EXTENT_FLAGS_UNINIT) &&
+	       (uint64_t)left->e_len + right->e_len <= max_len;
+}
+
+static int fuse2fs_try_merge_mappings(struct fuse2fs *ff, ext2_ino_t ino,
+				      ext2_extent_handle_t handle,
+				      blk64_t startoff)
+{
+	ext2_filsys fs = ff->fs;
+	struct ext2fs_extent left, right;
+	errcode_t err;
+
+	/* Look up the mappings before startoff */
+	err = fuse2fs_get_mapping_at(ff, handle, startoff - 1, &left);
+	if (err == EXT2_ET_EXTENT_NOT_FOUND)
+		return 0;
+	if (err)
+		return translate_error(fs, ino, err);
+
+	/* Look up the mapping at startoff */
+	err = fuse2fs_get_mapping_at(ff, handle, startoff, &right);
+	if (err == EXT2_ET_EXTENT_NOT_FOUND)
+		return 0;
+	if (err)
+		return translate_error(fs, ino, err);
+
+	/* Can we combine them? */
+	if (!fuse2fs_can_merge_mappings(&left, &right))
+		return 0;
+
+	/*
+	 * Delete the mapping after startoff because libext2fs cannot handle
+	 * overlapping mappings.
+	 */
+	err = ext2fs_extent_delete(handle, 0);
+	DUMP_EXTENT(ff, "remover", startoff, err, &right);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = ext2fs_extent_fix_parents(handle);
+	DUMP_EXTENT(ff, "fixremover", startoff, err, &right);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	/* Move back and lengthen the mapping before startoff */
+	err = ext2fs_extent_goto(handle, left.e_lblk);
+	DUMP_EXTENT(ff, "movel", startoff - 1, err, &left);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	left.e_len += right.e_len;
+	err = ext2fs_extent_replace(handle, 0, &left);
+	DUMP_EXTENT(ff, "replacel", startoff - 1, err, &left);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = ext2fs_extent_fix_parents(handle);
+	DUMP_EXTENT(ff, "fixreplacel", startoff - 1, err, &left);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	return 0;
+}
+
+static int fuse2fs_convert_unwritten_mapping(struct fuse2fs *ff,
+					     ext2_ino_t ino,
+					     struct ext2_inode_large *inode,
+					     ext2_extent_handle_t handle,
+					     blk64_t *cursor, blk64_t stopoff)
+{
+	ext2_filsys fs = ff->fs;
+	struct ext2fs_extent extent;
+	blk64_t startoff = *cursor;
+	errcode_t err;
+
+	/*
+	 * Find the mapping at startoff.  Note that we can find holes because
+	 * the mapping data can change due to racing writes.
+	 */
+	err = fuse2fs_get_mapping_at(ff, handle, startoff, &extent);
+	if (err == EXT2_ET_EXTENT_NOT_FOUND) {
+		/*
+		 * If we didn't find any mappings at all then the file is
+		 * completely sparse.  There's nothing to convert.
+		 */
+		*cursor = stopoff;
+		return 0;
+	}
+	if (err)
+		return translate_error(fs, ino, err);
+
+	/*
+	 * The mapping is completely to the left of the range that we want.
+	 * Let's see what's in the next extent, if there is one.
+	 */
+	if (startoff >= extent.e_lblk + extent.e_len) {
+		/*
+		 * Mapping ends to the left of the current position.  Try to
+		 * find the next mapping.  If there is no next mapping, then
+		 * we're done.
+		 */
+		err = fuse2fs_get_next_mapping(ff, handle, startoff, &extent);
+		if (err == EXT2_ET_EXTENT_NOT_FOUND) {
+			*cursor = stopoff;
+			return 0;
+		}
+		if (err)
+			return translate_error(fs, ino, err);
+	}
+
+	/*
+	 * The mapping is completely to the right of the range that we want,
+	 * so we're done.
+	 */
+	if (extent.e_lblk >= stopoff) {
+		*cursor = stopoff;
+		return 0;
+	}
+
+	/*
+	 * At this point, we have a mapping that overlaps (startoff, stopoff].
+	 * If the mapping is already written, move on to the next one.
+	 */
+	if (!(extent.e_flags & EXT2_EXTENT_FLAGS_UNINIT))
+		goto next;
+
+	if (startoff > extent.e_lblk) {
+		struct ext2fs_extent newex = extent;
+
+		/*
+		 * Unwritten mapping starts before startoff.  Shorten
+		 * the previous mapping...
+		 */
+		newex.e_len = startoff - extent.e_lblk;
+		err = ext2fs_extent_replace(handle, 0, &newex);
+		DUMP_EXTENT(ff, "shortenp", startoff, err, &newex);
+		if (err)
+			return translate_error(fs, ino, err);
+
+		err = ext2fs_extent_fix_parents(handle);
+		DUMP_EXTENT(ff, "fixshortenp", startoff, err, &newex);
+		if (err)
+			return translate_error(fs, ino, err);
+
+		/* ...and create new written mapping at startoff. */
+		extent.e_len -= newex.e_len;
+		extent.e_lblk += newex.e_len;
+		extent.e_pblk += newex.e_len;
+		extent.e_flags = newex.e_flags & ~EXT2_EXTENT_FLAGS_UNINIT;
+
+		err = ext2fs_extent_insert(handle,
+					   EXT2_EXTENT_INSERT_AFTER,
+					   &extent);
+		DUMP_EXTENT(ff, "insertx", startoff, err, &extent);
+		if (err)
+			return translate_error(fs, ino, err);
+
+		err = ext2fs_extent_fix_parents(handle);
+		DUMP_EXTENT(ff, "fixinsertx", startoff, err, &extent);
+		if (err)
+			return translate_error(fs, ino, err);
+	}
+
+	if (extent.e_lblk + extent.e_len > stopoff) {
+		struct ext2fs_extent newex = extent;
+
+		/*
+		 * Unwritten mapping ends after stopoff.  Shorten the current
+		 * mapping...
+		 */
+		extent.e_len = stopoff - extent.e_lblk;
+		extent.e_flags &= ~EXT2_EXTENT_FLAGS_UNINIT;
+
+		err = ext2fs_extent_replace(handle, 0, &extent);
+		DUMP_EXTENT(ff, "shortenn", startoff, err, &extent);
+		if (err)
+			return translate_error(fs, ino, err);
+
+		err = ext2fs_extent_fix_parents(handle);
+		DUMP_EXTENT(ff, "fixshortenn", startoff, err, &extent);
+		if (err)
+			return translate_error(fs, ino, err);
+
+		/* ..and create a new unwritten mapping at stopoff. */
+		newex.e_pblk += extent.e_len;
+		newex.e_lblk += extent.e_len;
+		newex.e_len -= extent.e_len;
+		newex.e_flags |= EXT2_EXTENT_FLAGS_UNINIT;
+
+		err = ext2fs_extent_insert(handle,
+					   EXT2_EXTENT_INSERT_AFTER,
+					   &newex);
+		DUMP_EXTENT(ff, "insertn", startoff, err, &newex);
+		if (err)
+			return translate_error(fs, ino, err);
+
+		err = ext2fs_extent_fix_parents(handle);
+		DUMP_EXTENT(ff, "fixinsertn", startoff, err, &newex);
+		if (err)
+			return translate_error(fs, ino, err);
+	}
+
+	/* Still unwritten?  Update the state. */
+	if (extent.e_flags & EXT2_EXTENT_FLAGS_UNINIT) {
+		extent.e_flags &= ~EXT2_EXTENT_FLAGS_UNINIT;
+
+		err = ext2fs_extent_replace(handle, 0, &extent);
+		DUMP_EXTENT(ff, "replacex", startoff, err, &extent);
+		if (err)
+			return translate_error(fs, ino, err);
+
+		err = ext2fs_extent_fix_parents(handle);
+		DUMP_EXTENT(ff, "fixreplacex", startoff, err, &extent);
+		if (err)
+			return translate_error(fs, ino, err);
+	}
+
+next:
+	/* Try to merge with the previous extent */
+	if (startoff > 0) {
+		err = fuse2fs_try_merge_mappings(ff, ino, handle, startoff);
+		if (err)
+			return translate_error(fs, ino, err);
+	}
+
+	*cursor = extent.e_lblk + extent.e_len;
+	return 0;
+}
+
+static int fuse2fs_convert_unwritten_mappings(struct fuse2fs *ff,
+					      ext2_ino_t ino,
+					      struct ext2_inode_large *inode,
+					      off_t pos, size_t written)
+{
+	ext2_extent_handle_t handle;
+	ext2_filsys fs = ff->fs;
+	blk64_t startoff = FUSE2FS_B_TO_FSBT(ff, pos);
+	const blk64_t stopoff = FUSE2FS_B_TO_FSB(ff, pos + written);
+	errcode_t err;
+	int ret;
+
+	err = ext2fs_extent_open2(fs, ino, EXT2_INODE(inode), &handle);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	/* Walk every mapping in the range, converting them. */
+	while (startoff < stopoff) {
+		blk64_t old_startoff = startoff;
+
+		ret = fuse2fs_convert_unwritten_mapping(ff, ino, inode, handle,
+							&startoff, stopoff);
+		if (ret)
+			goto out_handle;
+		if (startoff <= old_startoff) {
+			/* Do not go backwards. */
+			ret = translate_error(fs, ino, EXT2_ET_INODE_CORRUPTED);
+			goto out_handle;
+		}
+	}
+
+	/* Try to merge the right edge */
+	ret = fuse2fs_try_merge_mappings(ff, ino, handle, stopoff);
+out_handle:
+	ext2fs_extent_free(handle);
+	return ret;
+}
+
+static int op_iomap_ioend(const char *path, uint64_t nodeid, uint64_t attr_ino,
+			  off_t pos, size_t written, uint32_t ioendflags,
+			  int error, uint64_t new_addr)
+{
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	struct ext2_inode_large inode;
+	ext2_filsys fs;
+	errcode_t err;
+	bool dirty = false;
+	int ret = 0;
+
+	FUSE2FS_CHECK_CONTEXT(ff);
+
+	dbg_printf(ff,
+ "%s: path=%s nodeid=%llu attr_ino=%llu pos=0x%llx written=0x%zx ioendflags=0x%x error=%d new_addr=%llu\n",
+		   __func__, path,
+		   (unsigned long long)nodeid,
+		   (unsigned long long)attr_ino,
+		   (unsigned long long)pos,
+		   written,
+		   ioendflags,
+		   error,
+		   (unsigned long long)new_addr);
+
+	fs = fuse2fs_start(ff);
+	if (error) {
+		ret = error;
+		goto out_unlock;
+	}
+
+	/*
+	 * flush and invalidate the file's io_channel buffers again now that
+	 * iomap wrote them
+	 */
+	if (written > 0) {
+		err = io_channel_invalidate_tag(ff->fs->io, attr_ino);
+		if (err) {
+			ret = translate_error(ff->fs, attr_ino, err);
+			goto out_unlock;
+		}
+	}
+
+	/* should never see these ioend types */
+	if ((ioendflags & FUSE_IOMAP_IOEND_SHARED) ||
+	    new_addr != FUSE_IOMAP_NULL_ADDR) {
+		ret = translate_error(fs, attr_ino,
+				      EXT2_ET_FILESYSTEM_CORRUPTED);
+		goto out_unlock;
+	}
+
+	err = fuse2fs_read_inode(fs, attr_ino, &inode);
+	if (err) {
+		ret = translate_error(fs, attr_ino, err);
+		goto out_unlock;
+	}
+
+	if (ioendflags & FUSE_IOMAP_IOEND_UNWRITTEN) {
+		/* unwritten extents are only supported on extents files */
+		if (!(inode.i_flags & EXT4_EXTENTS_FL)) {
+			ret = translate_error(fs, attr_ino,
+					      EXT2_ET_FILESYSTEM_CORRUPTED);
+			goto out_unlock;
+		}
+
+		ret = fuse2fs_convert_unwritten_mappings(ff, attr_ino, &inode,
+							 pos, written);
+		if (ret)
+			goto out_unlock;
+
+		dirty = true;
+	}
+
+	if (ioendflags & FUSE_IOMAP_IOEND_APPEND) {
+		ext2_off64_t isize = EXT2_I_SIZE(&inode);
+
+		if (pos + written > isize) {
+			err = ext2fs_inode_size_set(fs, EXT2_INODE(&inode),
+						    pos + written);
+			if (err) {
+				ret = translate_error(fs, attr_ino, err);
+				goto out_unlock;
+			}
+
+			dirty = true;
+		}
+	}
+
+	if (dirty) {
+		err = fuse2fs_write_inode(fs, attr_ino, &inode);
+		if (err) {
+			ret = translate_error(fs, attr_ino, err);
+			goto out_unlock;
+		}
+	}
+
 out_unlock:
 	fuse2fs_finish(ff, ret);
 	return ret;
@@ -5530,6 +6005,7 @@ static struct fuse_operations fs_ops = {
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,
 	.iomap_config = op_iomap_config,
+	.iomap_ioend = op_iomap_ioend,
 #endif /* HAVE_FUSE_IOMAP */
 };
 


