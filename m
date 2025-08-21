Return-Path: <linux-fsdevel+bounces-58537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F436B2EA71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14163BAC36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A280320298C;
	Thu, 21 Aug 2025 01:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fydmy9I9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A481E98E6;
	Thu, 21 Aug 2025 01:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739053; cv=none; b=itgXeRahMlCDmRx27R37UFuSsRBGepGuzQABaRDfzZYoUFhBDZZRUnZbP8m+nxnWuQKYom6WkVlSBn3hH+1kbTFG6M0QutPy1OCnYRFaQvXEnEiAfmIvr7IFi1HQphGIg5MObjxDEArwTJWrti7X7YLHEuUP72BjkSGm7kYZSs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739053; c=relaxed/simple;
	bh=SMCkG3mSbF9pn9kc7knuVODFumKPiyN5ncpCE+o2bU4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+U5e6Q6CAd13oVdZgio73oY2JsFBamx57c4JZgKNKayX09oJen9SOzb9Tp/FmqISllit+552QqsgCqLbE7NoqxbE/V/xVNATzSubpdPk1ic/1RGZuREPCLRpLqmnh5ImjEv1KD6X6qFx9QKKWVY2HsdKPnunGiGGmkMvqnP/Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fydmy9I9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73964C113D0;
	Thu, 21 Aug 2025 01:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739052;
	bh=SMCkG3mSbF9pn9kc7knuVODFumKPiyN5ncpCE+o2bU4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fydmy9I9XtB1SDaPRtF3K9MDbnUl+OEwf0bpg2y42cld2ACVJyoYK5euGVa3jnpqV
	 cJHmQhU53Qlf6/P7jHngd014Yi3O6WDpnrbwjruHWls0MvXaKaLCcRqHJ3lGa6zeX7
	 eQD/qrHWKwr5l/U1Yp5PNYOvgCNFLG7cH7g7fmtChemrzuw2R7csYIOHHnvGLmjotD
	 lziQiB/sUMHH9F+pVDBrTgIwpKTmBiNRSdQ3SdiYZwxRJDUSZAdT+NS6ebkRaX1nRE
	 tcILTfPJcZliD3Dgeqlrx2+WuSiNyFXc/gGrIhhm8JFYqE47L6afYz5iIz8M1ZPqls
	 BBwTjrUkifdgQ==
Date: Wed, 20 Aug 2025 18:17:32 -0700
Subject: [PATCH 07/19] fuse2fs: implement direct write support
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713856.21970.12879323697743523642.stgit@frogsfrogsfrogs>
In-Reply-To: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
References: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |  470 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 misc/fuse4fs.c |  473 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 937 insertions(+), 6 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 4a9fda62f99bc2..e8e9056a661e71 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5442,12 +5442,103 @@ static int fuse2fs_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 					    opflags, read);
 }
 
+static int fuse2fs_iomap_write_allocate(struct fuse2fs *ff, ext2_ino_t ino,
+				     struct ext2_inode_large *inode, off_t pos,
+				     uint64_t count, uint32_t opflags,
+				     struct fuse_file_iomap *read, bool *dirty)
+{
+	ext2_filsys fs = ff->fs;
+	blk64_t startoff = FUSE2FS_B_TO_FSBT(ff, pos);
+	blk64_t stopoff = FUSE2FS_B_TO_FSB(ff, pos + count);
+	blk64_t old_iblocks;
+	errcode_t err;
+	int ret;
+
+	dbg_printf(ff, "%s: write_alloc ino=%u startoff 0x%llx blockcount 0x%llx\n",
+		   __func__, ino, startoff, stopoff - startoff);
+
+	if (!fs_can_allocate(ff, stopoff - startoff))
+		return -ENOSPC;
+
+	old_iblocks = ext2fs_get_stat_i_blocks(fs, EXT2_INODE(inode));
+	err = ext2fs_fallocate(fs, EXT2_FALLOCATE_FORCE_UNINIT, ino,
+			       EXT2_INODE(inode), ~0ULL, startoff,
+			       stopoff - startoff);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	/*
+	 * New allocations for file data blocks on indirect mapped files are
+	 * zeroed through the IO manager so we have to flush it to disk.
+	 */
+	if (!(inode->i_flags & EXT4_EXTENTS_FL) &&
+	    old_iblocks != ext2fs_get_stat_i_blocks(fs, EXT2_INODE(inode))) {
+		err = io_channel_flush(fs->io);
+		if (err)
+			return translate_error(fs, ino, err);
+	}
+
+	/* pick up the newly allocated mapping */
+	ret = fuse2fs_iomap_begin_read(ff, ino, inode, pos, count, opflags,
+				       read);
+	if (ret)
+		return ret;
+
+	read->flags |= FUSE_IOMAP_F_DIRTY;
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
-				     struct fuse_file_iomap *read)
+				     struct fuse_file_iomap *read,
+				     bool *dirty)
 {
-	return -ENOSYS;
+	off_t max_size = fuse2fs_max_file_size(ff, inode);
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
+				       read);
+	if (ret)
+		return ret;
+
+	if (fuse_iomap_need_write_allocate(opflags, read)) {
+		ret = fuse2fs_iomap_write_allocate(ff, ino, inode, pos, count,
+						   opflags, read, dirty);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
@@ -5459,6 +5550,7 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 	struct ext2_inode_large inode;
 	ext2_filsys fs;
 	errcode_t err;
+	bool dirty = false;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -5484,7 +5576,7 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 						 count, opflags, read);
 	else if (fuse_iomap_is_write(opflags))
 		ret = fuse2fs_iomap_begin_write(ff, attr_ino, &inode, pos,
-						count, opflags, read);
+						count, opflags, read, &dirty);
 	else
 		ret = fuse2fs_iomap_begin_read(ff, attr_ino, &inode, pos,
 					       count, opflags, read);
@@ -5506,6 +5598,14 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 			  read->offset + read->length <= pos))
 		fuse2fs_dump_extents(ff, attr_ino, &inode, "BAD DATA");
 
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
@@ -5643,6 +5743,369 @@ static int op_iomap_config(uint64_t flags, off_t maxbytes,
 	if (ret)
 		goto out_unlock;
 
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
+	struct fuse2fs *ff = fuse2fs_get();
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
+	/* should never see these ioend types */
+	if (ioendflags & FUSE_IOMAP_IOEND_SHARED) {
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
@@ -5713,6 +6176,7 @@ static struct fuse_operations fs_ops = {
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,
 	.iomap_config = op_iomap_config,
+	.iomap_ioend = op_iomap_ioend,
 #endif /* HAVE_FUSE_IOMAP */
 };
 
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 0ac5de90498dac..ff50182b929974 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -5850,12 +5850,106 @@ static int fuse4fs_iomap_begin_read(struct fuse4fs *ff, ext2_ino_t ino,
 					    opflags, read);
 }
 
+static int fuse4fs_iomap_write_allocate(struct fuse4fs *ff, ext2_ino_t ino,
+					struct ext2_inode_large *inode,
+					off_t pos, uint64_t count,
+					uint32_t opflags,
+					struct fuse_file_iomap *read,
+					bool *dirty)
+{
+	ext2_filsys fs = ff->fs;
+	blk64_t startoff = FUSE4FS_B_TO_FSBT(ff, pos);
+	blk64_t stopoff = FUSE4FS_B_TO_FSB(ff, pos + count);
+	blk64_t old_iblocks;
+	errcode_t err;
+	int ret;
+
+	dbg_printf(ff,
+ "%s: ino=%d startoff 0x%llx blockcount 0x%llx\n",
+		   __func__, ino, startoff, stopoff - startoff);
+
+	if (!fuse4fs_can_allocate(ff, stopoff - startoff))
+		return -ENOSPC;
+
+	old_iblocks = ext2fs_get_stat_i_blocks(fs, EXT2_INODE(inode));
+	err = ext2fs_fallocate(fs, EXT2_FALLOCATE_FORCE_UNINIT, ino,
+			       EXT2_INODE(inode), ~0ULL, startoff,
+			       stopoff - startoff);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	/*
+	 * New allocations for file data blocks on indirect mapped files are
+	 * zeroed through the IO manager so we have to flush it to disk.
+	 */
+	if (!(inode->i_flags & EXT4_EXTENTS_FL) &&
+	    old_iblocks != ext2fs_get_stat_i_blocks(fs, EXT2_INODE(inode))) {
+		err = io_channel_flush(fs->io);
+		if (err)
+			return translate_error(fs, ino, err);
+	}
+
+	/* pick up the newly allocated mapping */
+	ret = fuse4fs_iomap_begin_read(ff, ino, inode, pos, count, opflags,
+				       read);
+	if (ret)
+		return ret;
+
+	read->flags |= FUSE_IOMAP_F_DIRTY;
+	*dirty = true;
+	return 0;
+}
+
+static off_t fuse4fs_max_file_size(const struct fuse4fs *ff,
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
+	return FUSE4FS_FSB_TO_B(ff, max_map_block) + (fs->blocksize - 1);
+}
+
 static int fuse4fs_iomap_begin_write(struct fuse4fs *ff, ext2_ino_t ino,
 				     struct ext2_inode_large *inode, off_t pos,
 				     uint64_t count, uint32_t opflags,
-				     struct fuse_file_iomap *read)
+				     struct fuse_file_iomap *read,
+				     bool *dirty)
 {
-	return -ENOSYS;
+	off_t max_size = fuse4fs_max_file_size(ff, inode);
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
+	ret = fuse4fs_iomap_begin_read(ff, ino, inode, pos, count, opflags,
+				       read);
+	if (ret)
+		return ret;
+
+	if (fuse_iomap_need_write_allocate(opflags, read)) {
+		ret = fuse4fs_iomap_write_allocate(ff, ino, inode, pos, count,
+						   opflags, read, dirty);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
@@ -5867,6 +5961,7 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 	ext2_filsys fs;
 	ext2_ino_t ino;
 	errcode_t err;
+	bool dirty = false;
 	int ret = 0;
 
 	FUSE4FS_CHECK_CONTEXT(req);
@@ -5890,7 +5985,7 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 						 opflags, &read);
 	else if (fuse_iomap_is_write(opflags))
 		ret = fuse4fs_iomap_begin_write(ff, ino, &inode, pos, count,
-						opflags, &read);
+						opflags, &read, &dirty);
 	else
 		ret = fuse4fs_iomap_begin_read(ff, ino, &inode, pos, count,
 					       opflags, &read);
@@ -5912,6 +6007,14 @@ static void op_iomap_begin(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
 			  read.offset + read.length <= pos))
 		fuse4fs_dump_extents(ff, ino, &inode, "BAD DATA");
 
+	if (dirty) {
+		err = fuse4fs_write_inode(fs, ino, &inode);
+		if (err) {
+			ret = translate_error(fs, ino, err);
+			goto out_unlock;
+		}
+	}
+
 out_unlock:
 	fuse4fs_finish(ff, ret);
 	if (ret)
@@ -6059,6 +6162,369 @@ static void op_iomap_config(fuse_req_t req, uint64_t flags, uint64_t maxbytes)
 	else
 		fuse_reply_iomap_config(req, &cfg);
 }
+
+static inline bool fuse4fs_can_merge_mappings(const struct ext2fs_extent *left,
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
+static int fuse4fs_try_merge_mappings(struct fuse4fs *ff, ext2_ino_t ino,
+				      ext2_extent_handle_t handle,
+				      blk64_t startoff)
+{
+	ext2_filsys fs = ff->fs;
+	struct ext2fs_extent left, right;
+	errcode_t err;
+
+	/* Look up the mappings before startoff */
+	err = fuse4fs_get_mapping_at(ff, handle, startoff - 1, &left);
+	if (err == EXT2_ET_EXTENT_NOT_FOUND)
+		return 0;
+	if (err)
+		return translate_error(fs, ino, err);
+
+	/* Look up the mapping at startoff */
+	err = fuse4fs_get_mapping_at(ff, handle, startoff, &right);
+	if (err == EXT2_ET_EXTENT_NOT_FOUND)
+		return 0;
+	if (err)
+		return translate_error(fs, ino, err);
+
+	/* Can we combine them? */
+	if (!fuse4fs_can_merge_mappings(&left, &right))
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
+static int fuse4fs_convert_unwritten_mapping(struct fuse4fs *ff,
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
+	err = fuse4fs_get_mapping_at(ff, handle, startoff, &extent);
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
+		err = fuse4fs_get_next_mapping(ff, handle, startoff, &extent);
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
+		err = fuse4fs_try_merge_mappings(ff, ino, handle, startoff);
+		if (err)
+			return translate_error(fs, ino, err);
+	}
+
+	*cursor = extent.e_lblk + extent.e_len;
+	return 0;
+}
+
+static int fuse4fs_convert_unwritten_mappings(struct fuse4fs *ff,
+					      ext2_ino_t ino,
+					      struct ext2_inode_large *inode,
+					      off_t pos, size_t written)
+{
+	ext2_extent_handle_t handle;
+	ext2_filsys fs = ff->fs;
+	blk64_t startoff = FUSE4FS_B_TO_FSBT(ff, pos);
+	const blk64_t stopoff = FUSE4FS_B_TO_FSB(ff, pos + written);
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
+		ret = fuse4fs_convert_unwritten_mapping(ff, ino, inode, handle,
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
+	ret = fuse4fs_try_merge_mappings(ff, ino, handle, stopoff);
+out_handle:
+	ext2fs_extent_free(handle);
+	return ret;
+}
+
+static void op_iomap_ioend(fuse_req_t req, fuse_ino_t fino, uint64_t dontcare,
+			   off_t pos, size_t written, uint32_t ioendflags,
+			   int error, uint64_t new_addr)
+{
+	struct fuse4fs *ff = fuse4fs_get(req);
+	struct ext2_inode_large inode;
+	ext2_filsys fs;
+	ext2_ino_t ino;
+	errcode_t err;
+	bool dirty = false;
+	int ret = 0;
+
+	FUSE4FS_CHECK_CONTEXT(req);
+	FUSE4FS_CONVERT_FINO(req, &ino, fino);
+
+	dbg_printf(ff,
+ "%s: ino=%d pos=0x%llx written=0x%zx ioendflags=0x%x error=%d new_addr=0x%llx\n",
+		   __func__, ino,
+		   (unsigned long long)pos,
+		   written,
+		   ioendflags,
+		   error,
+		   (unsigned long long)new_addr);
+
+	if (error) {
+		fuse_reply_err(req, -error);
+		return;
+	}
+
+	fs = fuse4fs_start(ff);
+
+	/* should never see these ioend types */
+	if (ioendflags & FUSE_IOMAP_IOEND_SHARED) {
+		ret = translate_error(fs, ino, EXT2_ET_FILESYSTEM_CORRUPTED);
+		goto out_unlock;
+	}
+
+	err = fuse4fs_read_inode(fs, ino, &inode);
+	if (err) {
+		ret = translate_error(fs, ino, err);
+		goto out_unlock;
+	}
+
+	if (ioendflags & FUSE_IOMAP_IOEND_UNWRITTEN) {
+		/* unwritten extents are only supported on extents files */
+		if (!(inode.i_flags & EXT4_EXTENTS_FL)) {
+			ret = translate_error(fs, ino,
+					      EXT2_ET_FILESYSTEM_CORRUPTED);
+			goto out_unlock;
+		}
+
+		ret = fuse4fs_convert_unwritten_mappings(ff, ino, &inode,
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
+				ret = translate_error(fs, ino, err);
+				goto out_unlock;
+			}
+
+			dirty = true;
+		}
+	}
+
+	if (dirty) {
+		err = fuse4fs_write_inode(fs, ino, &inode);
+		if (err) {
+			ret = translate_error(fs, ino, err);
+			goto out_unlock;
+		}
+	}
+
+out_unlock:
+	fuse4fs_finish(ff, ret);
+	fuse_reply_err(req, -ret);
+}
 #endif /* HAVE_FUSE_IOMAP */
 
 static struct fuse_lowlevel_ops fs_ops = {
@@ -6108,6 +6574,7 @@ static struct fuse_lowlevel_ops fs_ops = {
 	.iomap_begin = op_iomap_begin,
 	.iomap_end = op_iomap_end,
 	.iomap_config = op_iomap_config,
+	.iomap_ioend = op_iomap_ioend,
 #endif /* HAVE_FUSE_IOMAP */
 };
 


