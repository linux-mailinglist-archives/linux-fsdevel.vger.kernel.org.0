Return-Path: <linux-fsdevel+bounces-49643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEF1AC012E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0056F7AE4FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C87420EB;
	Thu, 22 May 2025 00:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TD54yP6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80A0195;
	Thu, 22 May 2025 00:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872776; cv=none; b=lEAeSYqroPoYodTG3g9OdA0L2q6FTGH0NSKwQeb9QPz5pu9GTHA7LRU9m/z2sf5VQr4ZlKfdKHI3SUf0KgBwX6c3DV7XExmI8GfVRPaM2pfEmMjmzJogKUCVGygArPWZrRLZriNxiORkNkaav3MJB2Ht5eCkGfy+mnc4gTo6Kn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872776; c=relaxed/simple;
	bh=BR3Fjlo/UdbeIBeG7hNpZWEHXbuwxRjDYXWmrkyZu50=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SalPptUqDgqMZ3xzmagqcLPYr57k0Qj9ubOqjlhrmdqcick1tksVQnjFsTHvC6aKLm5gnWb8PIOb4RPMrxWo0hJNdNrxbWYAztNAarU4oDu8cFMd+GRQ2zDfhcxTXfNxDt5sfle0CFLFEcnNBgfd7h8DQKV+chG3xAtM8RNyvUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TD54yP6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D10C4CEE4;
	Thu, 22 May 2025 00:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872776;
	bh=BR3Fjlo/UdbeIBeG7hNpZWEHXbuwxRjDYXWmrkyZu50=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TD54yP6kDvLL3alFnnhRLnAaQFCOo461h6uE8p3PBHb0Jxoa3UeKi78LlumO6fneP
	 cAUi64K7h2TtmTBL/VC5VpUKP5iSDCJhmQkRrCUN17ntofZfpzshpQjGHC/CaMCSEE
	 o4nov/ekDk2DiPQouVgeIjoSdfjIns0el/Xl0EmsQip/m1/zxLNRZfSFP8gKzZ0q3V
	 lOd/q1vVXTSpKSJgGUgSHjRl4xqHmC8eaeCQGrLTMCSdA9IUMBRfizcnUNMtosfXus
	 b8ASiOpvIwEK3x/KY//8Rqpn/oWcHkUVm4B0OzPGeUdcQkDk6du8ZT1OOCyjNZe8BH
	 R+g/U9ROSp93g==
Date: Wed, 21 May 2025 17:12:56 -0700
Subject: [PATCH 08/16] fuse2fs: implement direct write support
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198577.1484996.17653820720539195692.stgit@frogsfrogsfrogs>
In-Reply-To: <174787198370.1484996.3340565971108603226.stgit@frogsfrogsfrogs>
References: <174787198370.1484996.3340565971108603226.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |  481 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 478 insertions(+), 3 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 7e9095766c6624..ec17f6203b4b70 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5037,12 +5037,99 @@ static int fuse_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 				    read_iomap);
 }
 
+static int fuse_iomap_write_allocate(struct fuse2fs *ff, ext2_ino_t ino,
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
+			       EXT2_INODE(inode), 0, startoff,
+			       stopoff - startoff);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	/* pick up the newly allocated mapping */
+	ret = fuse_iomap_begin_read(ff, ino, inode, pos, count, opflags,
+				     read_iomap);
+	if (ret)
+		return ret;
+
+	read_iomap->flags |= FUSE_IOMAP_F_DIRTY;
+	*dirty = true;
+	return 0;
+}
+
+static off_t max_file_size(const struct fuse2fs *ff,
+			   const struct ext2_inode_large *inode)
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
 static int fuse_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,
 				  struct ext2_inode_large *inode, off_t pos,
 				  uint64_t count, uint32_t opflags,
-				  struct fuse_iomap *read_iomap)
+				  struct fuse_iomap *read_iomap, bool *dirty)
 {
-	return -ENOSYS;
+	off_t max_size = max_file_size(ff, inode);
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
+	ret = fuse_iomap_begin_read(ff, ino, inode, pos, count, opflags,
+				    read_iomap);
+	if (ret)
+		return ret;
+
+	if (read_iomap->type == FUSE_IOMAP_TYPE_HOLE &&
+	    !(opflags & FUSE_IOMAP_OP_ZERO)) {
+		ret = fuse_iomap_write_allocate(ff, ino, inode, pos, count,
+						opflags, read_iomap, dirty);
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
 
 static errcode_t config_iomap_devices(struct fuse_context *ctxt,
@@ -5080,6 +5167,7 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 	struct ext2_inode_large inode;
 	ext2_filsys fs;
 	errcode_t err;
+	bool dirty = false;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -5115,7 +5203,7 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 					      opflags, read_iomap);
 	else if (opflags & (FUSE_IOMAP_OP_WRITE | FUSE_IOMAP_OP_ZERO))
 		ret = fuse_iomap_begin_write(ff, attr_ino, &inode, pos, count,
-					     opflags, read_iomap);
+					     opflags, read_iomap, &dirty);
 	else
 		ret = fuse_iomap_begin_read(ff, attr_ino, &inode, pos, count,
 					    opflags, read_iomap);
@@ -5132,6 +5220,14 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
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
 	if (ret < 0)
 		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
@@ -5163,6 +5259,384 @@ static int op_iomap_end(const char *path, uint64_t nodeid, uint64_t attr_ino,
 
 	return 0;
 }
+
+static inline bool can_merge_mappings(const struct ext2fs_extent *left,
+				      const struct ext2fs_extent *right)
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
+static int try_merge_mappings(struct fuse2fs *ff, ext2_ino_t ino,
+			      ext2_extent_handle_t handle, blk64_t startoff)
+{
+	ext2_filsys fs = ff->fs;
+	struct ext2fs_extent left, right;
+	errcode_t err;
+
+	/* Look up the mappings before startoff */
+	err = get_mapping_at(ff, handle, startoff - 1, &left);
+	if (err == EXT2_ET_EXTENT_NOT_FOUND)
+		return 0;
+	if (err)
+		return translate_error(fs, ino, err);
+
+	/* Look up the mapping at startoff */
+	err = get_mapping_at(ff, handle, startoff, &right);
+	if (err == EXT2_ET_EXTENT_NOT_FOUND)
+		return 0;
+	if (err)
+		return translate_error(fs, ino, err);
+
+	/* Can we combine them? */
+	if (!can_merge_mappings(&left, &right))
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
+static int convert_unwritten_mapping(struct fuse2fs *ff, ext2_ino_t ino,
+				     struct ext2_inode_large *inode,
+				     ext2_extent_handle_t handle,
+				     blk64_t *cursor, blk64_t stopoff)
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
+	err = get_mapping_at(ff, handle, startoff, &extent);
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
+		err = get_next_mapping(ff, handle, startoff, &extent);
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
+		err = try_merge_mappings(ff, ino, handle, startoff);
+		if (err)
+			return translate_error(fs, ino, err);
+	}
+
+	*cursor = extent.e_lblk + extent.e_len;
+	return 0;
+}
+
+static int convert_unwritten_mappings(struct fuse2fs *ff, ext2_ino_t ino,
+				      struct ext2_inode_large *inode,
+				      off_t pos, size_t written)
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
+		ret = convert_unwritten_mapping(ff, ino, inode, handle,
+					        &startoff, stopoff);
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
+	ret = try_merge_mappings(ff, ino, handle, stopoff);
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
+	fs = ff->fs;
+
+	pthread_mutex_lock(&ff->bfl);
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
+		ret = convert_unwritten_mappings(ff, attr_ino, &inode, pos,
+						 written);
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
+out_unlock:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
+	pthread_mutex_unlock(&ff->bfl);
+	return ret;
+}
 #endif /* HAVE_FUSE_IOMAP */
 
 static struct fuse_operations fs_ops = {
@@ -5228,6 +5702,7 @@ static struct fuse_operations fs_ops = {
 #ifdef HAVE_FUSE_IOMAP
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,
+	.iomap_ioend = op_iomap_ioend,
 #endif /* HAVE_FUSE_IOMAP */
 };
 


