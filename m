Return-Path: <linux-fsdevel+bounces-18236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A318B6889
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5752853C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A8912E4E;
	Tue, 30 Apr 2024 03:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbQeO5cO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822DD10A3C;
	Tue, 30 Apr 2024 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447556; cv=none; b=cYKRHnc5SRz0Do0EEyy6ylrNM3qGrWtzpPr3NZN1DDh0MbWRPwLih0z5Kv6kKCQ23NUT5WF1FxaoyBimn9ip7xgBbIxDI7cpl1kk6P/4X/NyKdMyGiZ+fe0m399pxA40dfmzCf2AEv2R4jonzmJDRE32JaQ/s1PvN5hcXHcZs64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447556; c=relaxed/simple;
	bh=S1PjzgbufA/TNfTaTqGtIwiTKAIvd0GVp9pACJGYMSA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMAeRtFddgzEshdrteiu9qtDS3aBchRgoOuEsRkjYnkBYDweZs5IV3HD93wjtCejm8W+kUgfivJmSLphSCeBjWEOK6wsixpuZT1dNoOKxmZDf5c6xWDb4gKJ+swxFoQE2Zc64hGwh7X5CcV+qiCI5VtgJpl+xyCoMuVXBEEHB54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbQeO5cO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ADFC116B1;
	Tue, 30 Apr 2024 03:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447556;
	bh=S1PjzgbufA/TNfTaTqGtIwiTKAIvd0GVp9pACJGYMSA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BbQeO5cOSM636iRCK5DSAQ7nUln7bc0NlBYQWQjUrO1Nac/QkF6VfH7BVIJIsRDXG
	 z/xfw8jqbrWImWJCjpMUnZMqyxh2ujCsCIOdTVtyfhPfP37xJsS35qo/uqgS/mdP7H
	 J2k0ltNGHUS7aMdZnzxVm3H+imQ1B5QR/rTxlYo73jrGrgGG+nEf0kd7XbcS+RbLzm
	 8k/2rrnvN79+fzh+vF7rHCNGbyYx3UQFbhr51Yr5b5LdnKEZfSFWz3NkbHwHObwt3T
	 4pVLPuJVuZLqUtbt0hMkZYMXzt8xAQrrKB/LVGv9Me7MOLUZCuewJEHGIAHXuY7Ihu
	 OwZ9AGTWpr2nw==
Date: Mon, 29 Apr 2024 20:25:55 -0700
Subject: [PATCH 07/26] xfs: do not use xfs_attr3_rmt_hdr for remote verity
 value blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680480.957659.16777864152713160062.stgit@frogsfrogsfrogs>
In-Reply-To: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

I enabled fsverity for a ~250MB file and noticed the following xattr
keys that got created for the merkle tree.  These two merkle tree blocks
are written out in ascending order:

nvlist[52].merkle_off = 0x111000
nvlist[53].valueblk = 0x222
nvlist[53].valuelen = 4096

nvlist[53].merkle_off = 0x112000
nvlist[54].valueblk = 0x224
nvlist[54].valuelen = 4096

Notice that while the valuelen is 4k, the block offset increases by two.
Curious, I then loaded up ablock 0x223:

hdr.magic = 0x5841524d
hdr.offset = 4040
hdr.bytes = 56
hdr.crc = 0xad1b8bd8 (correct)
hdr.uuid = 07d3f25c-e550-4118-8ff5-a45c017ba5ef
hdr.owner = 133
hdr.bno = 442144
hdr.lsn = 0xffffffffffffffff
data = <56 bytes of charns data>

Ugh!  Each 4k merkle tree block takes up two fsblocks due to the remote
value header that XFS puts at the start of each remote value block.
That header is 56 bytes long, which is exactly the length of the
spillover here.  This isn't good.

The first thing that I tried was enabling fsverity on a bunch of files,
extracting the merkle tree blocks one by one, and testing their
compressability with gzip, zstd, and xz.  Merkle tree blocks are nearly
indistinguishable from random data, with the result that 99% of the
blocks I sampled got larger under compression.  So that's out.

Next I decided to try eliminating the xfs_attr3_rmt_hdr header, which
would make verity remote values align perfectly with filesystem blocks.
Because remote value blocks are written out with xfs_bwrite, the lsn
field isn't useful.  The merkle tree is itself a bunch of hashes of data
blocks or other merkle tree blocks, which means that a bitflip will
result in a verity failure somewhere in the file.  Hence we don't need
to store an explicit crc, and we could just XOR the ondisk merkle tree
contents with selected attributes.

In the end I decided to create a smaller header structure containing
only a magic, the fsuuid, the inode owner, and the ondisk block number.
These values get XORd into the beginning of the merkle tree block to
detect lost writes when we're writing remote XFS_ATTR_VERITY values to
disk, and XORd out when reading them back in.

With this format change applied, the fsverity overhead halves.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_attr.c        |    6 +-
 fs/xfs/libxfs/xfs_attr_leaf.c   |    5 +-
 fs/xfs/libxfs/xfs_attr_remote.c |  125 ++++++++++++++++++++++++++++++++++-----
 fs/xfs/libxfs/xfs_attr_remote.h |    8 ++
 fs/xfs/libxfs/xfs_da_format.h   |   22 +++++++
 fs/xfs/libxfs/xfs_ondisk.h      |    2 +
 fs/xfs/libxfs/xfs_shared.h      |    1 
 fs/xfs/xfs_attr_inactive.c      |    2 -
 8 files changed, 148 insertions(+), 23 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index e0be8d0c1ffdc..1b9d9ffb16833 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -342,7 +342,8 @@ xfs_attr_calc_size(
 		 * Out of line attribute, cannot double split, but
 		 * make room for the attribute value itself.
 		 */
-		uint	dblocks = xfs_attr3_rmt_blocks(mp, args->valuelen);
+		uint	dblocks = xfs_attr3_rmt_blocks(mp, args->attr_filter,
+						       args->valuelen);
 		nblks += dblocks;
 		nblks += XFS_NEXTENTADD_SPACE_RES(mp, dblocks, XFS_ATTR_FORK);
 	}
@@ -1056,7 +1057,8 @@ xfs_attr_set(
 		}
 
 		if (!local)
-			rmt_blks = xfs_attr3_rmt_blocks(mp, args->valuelen);
+			rmt_blks = xfs_attr3_rmt_blocks(mp, args->valuelen,
+					args->valuelen);
 		break;
 	case XFS_ATTRUPDATE_REMOVE:
 		XFS_STATS_INC(mp, xs_attr_remove);
diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index 6aaec1246c950..fd4a5ace52c64 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -1566,7 +1566,8 @@ xfs_attr3_leaf_add_work(
 		name_rmt->valuelen = 0;
 		name_rmt->valueblk = 0;
 		args->rmtblkno = 1;
-		args->rmtblkcnt = xfs_attr3_rmt_blocks(mp, args->valuelen);
+		args->rmtblkcnt = xfs_attr3_rmt_blocks(mp, args->attr_filter,
+				args->valuelen);
 		args->rmtvaluelen = args->valuelen;
 	}
 	xfs_trans_log_buf(args->trans, bp,
@@ -2501,6 +2502,7 @@ xfs_attr3_leaf_lookup_int(
 			args->rmtblkno = be32_to_cpu(name_rmt->valueblk);
 			args->rmtblkcnt = xfs_attr3_rmt_blocks(
 							args->dp->i_mount,
+							args->attr_filter,
 							args->rmtvaluelen);
 			return -EEXIST;
 		}
@@ -2549,6 +2551,7 @@ xfs_attr3_leaf_getvalue(
 	args->rmtvaluelen = be32_to_cpu(name_rmt->valuelen);
 	args->rmtblkno = be32_to_cpu(name_rmt->valueblk);
 	args->rmtblkcnt = xfs_attr3_rmt_blocks(args->dp->i_mount,
+					       args->attr_filter,
 					       args->rmtvaluelen);
 	return xfs_attr_copy_value(args, NULL, args->rmtvaluelen);
 }
diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index 0566733b6da45..6accc8ae46c45 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -43,14 +43,23 @@
  * the logging system and therefore never have a log item.
  */
 
+static inline bool
+xfs_attr3_rmt_has_header(
+	struct xfs_mount	*mp,
+	unsigned int		attrns)
+{
+	return xfs_has_crc(mp) && !(attrns & XFS_ATTR_VERITY);
+}
+
 /* How many bytes can be stored in a remote value buffer? */
 inline unsigned int
 xfs_attr3_rmt_buf_space(
-	struct xfs_mount	*mp)
+	struct xfs_mount	*mp,
+	unsigned int		attrns)
 {
 	unsigned int		blocksize = mp->m_attr_geo->blksize;
 
-	if (xfs_has_crc(mp))
+	if (xfs_attr3_rmt_has_header(mp, attrns))
 		return blocksize - sizeof(struct xfs_attr3_rmt_hdr);
 
 	return blocksize;
@@ -60,14 +69,15 @@ xfs_attr3_rmt_buf_space(
 unsigned int
 xfs_attr3_rmt_blocks(
 	struct xfs_mount	*mp,
+	unsigned int		attrns,
 	unsigned int		attrlen)
 {
 	/*
 	 * Each contiguous block has a header, so it is not just a simple
 	 * attribute length to FSB conversion.
 	 */
-	if (xfs_has_crc(mp))
-		return howmany(attrlen, xfs_attr3_rmt_buf_space(mp));
+	if (xfs_attr3_rmt_has_header(mp, attrns))
+		return howmany(attrlen, xfs_attr3_rmt_buf_space(mp, attrns));
 
 	return XFS_B_TO_FSB(mp, attrlen);
 }
@@ -248,6 +258,42 @@ const struct xfs_buf_ops xfs_attr3_rmt_buf_ops = {
 	.verify_struct = xfs_attr3_rmt_verify_struct,
 };
 
+static void
+xfs_attr3_rmtverity_read_verify(
+	struct xfs_buf	*bp)
+{
+}
+
+static xfs_failaddr_t
+xfs_attr3_rmtverity_verify_struct(
+	struct xfs_buf	*bp)
+{
+	return NULL;
+}
+
+static void
+xfs_attr3_rmtverity_write_verify(
+	struct xfs_buf	*bp)
+{
+}
+
+const struct xfs_buf_ops xfs_attr3_rmtverity_buf_ops = {
+	.name = "xfs_attr3_remote_verity",
+	.magic = { 0, 0 },
+	.verify_read = xfs_attr3_rmtverity_read_verify,
+	.verify_write = xfs_attr3_rmtverity_write_verify,
+	.verify_struct = xfs_attr3_rmtverity_verify_struct,
+};
+
+inline const struct xfs_buf_ops *
+xfs_attr3_remote_buf_ops(
+	unsigned int		attrns)
+{
+	if (attrns & XFS_ATTR_VERITY)
+		return &xfs_attr3_rmtverity_buf_ops;
+	return &xfs_attr3_rmt_buf_ops;
+}
+
 STATIC int
 xfs_attr3_rmt_hdr_set(
 	struct xfs_mount	*mp,
@@ -284,6 +330,40 @@ xfs_attr3_rmt_hdr_set(
 	return sizeof(struct xfs_attr3_rmt_hdr);
 }
 
+static void
+xfs_attr_rmtverity_transform(
+	struct xfs_buf		*bp,
+	xfs_ino_t		ino,
+	void			*buf,
+	unsigned int		byte_cnt)
+{
+	struct xfs_mount	*mp = bp->b_mount;
+	struct xfs_attr3_rmtverity_hdr	*hdr = buf;
+	char			*dst;
+	const char		*src;
+	unsigned int		i;
+
+	if (byte_cnt >= offsetofend(struct xfs_attr3_rmtverity_hdr, rmv_owner))
+		hdr->rmv_owner ^= cpu_to_be64(ino);
+
+	if (byte_cnt >= offsetofend(struct xfs_attr3_rmtverity_hdr, rmv_blkno))
+		hdr->rmv_blkno ^= cpu_to_be64(xfs_buf_daddr(bp));
+
+	if (byte_cnt >= offsetofend(struct xfs_attr3_rmtverity_hdr, rmv_magic))
+		hdr->rmv_magic ^= cpu_to_be32(XFS_ATTR3_RMTVERITY_MAGIC);
+
+	if (byte_cnt <= offsetof(struct xfs_attr3_rmtverity_hdr, rmv_uuid))
+		return;
+
+	byte_cnt -= offsetof(struct xfs_attr3_rmtverity_hdr, rmv_uuid);
+	byte_cnt = min(byte_cnt, sizeof(uuid_t));
+
+	dst = (void *)&hdr->rmv_uuid;
+	src = (void *)&mp->m_sb.sb_meta_uuid;
+	for (i = 0; i < byte_cnt; i++)
+		dst[i] ^= src[i];
+}
+
 /*
  * Helper functions to copy attribute data in and out of the one disk extents
  */
@@ -293,6 +373,7 @@ xfs_attr_rmtval_copyout(
 	struct xfs_buf		*bp,
 	struct xfs_inode	*dp,
 	xfs_ino_t		owner,
+	unsigned int		attrns,
 	unsigned int		*offset,
 	unsigned int		*valuelen,
 	uint8_t			**dst)
@@ -306,11 +387,11 @@ xfs_attr_rmtval_copyout(
 
 	while (len > 0 && *valuelen > 0) {
 		unsigned int hdr_size = 0;
-		unsigned int byte_cnt = xfs_attr3_rmt_buf_space(mp);
+		unsigned int byte_cnt = xfs_attr3_rmt_buf_space(mp, attrns);
 
 		byte_cnt = min(*valuelen, byte_cnt);
 
-		if (xfs_has_crc(mp)) {
+		if (xfs_attr3_rmt_has_header(mp, attrns)) {
 			if (xfs_attr3_rmt_hdr_ok(src, owner, *offset,
 						  byte_cnt, bno)) {
 				xfs_alert(mp,
@@ -324,6 +405,10 @@ xfs_attr_rmtval_copyout(
 
 		memcpy(*dst, src + hdr_size, byte_cnt);
 
+		if (attrns & XFS_ATTR_VERITY)
+			xfs_attr_rmtverity_transform(bp, dp->i_ino, *dst,
+					byte_cnt);
+
 		/* roll buffer forwards */
 		len -= blksize;
 		src += blksize;
@@ -342,6 +427,7 @@ xfs_attr_rmtval_copyin(
 	struct xfs_mount *mp,
 	struct xfs_buf	*bp,
 	xfs_ino_t	ino,
+	unsigned int	attrns,
 	unsigned int	*offset,
 	unsigned int	*valuelen,
 	uint8_t		**src)
@@ -354,15 +440,20 @@ xfs_attr_rmtval_copyin(
 	ASSERT(len >= blksize);
 
 	while (len > 0 && *valuelen > 0) {
-		unsigned int hdr_size;
-		unsigned int byte_cnt = xfs_attr3_rmt_buf_space(mp);
+		unsigned int hdr_size = 0;
+		unsigned int byte_cnt = xfs_attr3_rmt_buf_space(mp, attrns);
 
 		byte_cnt = min(*valuelen, byte_cnt);
-		hdr_size = xfs_attr3_rmt_hdr_set(mp, dst, ino, *offset,
-						 byte_cnt, bno);
+		if (xfs_attr3_rmt_has_header(mp, attrns))
+			hdr_size = xfs_attr3_rmt_hdr_set(mp, dst, ino, *offset,
+					byte_cnt, bno);
 
 		memcpy(dst + hdr_size, *src, byte_cnt);
 
+		if (attrns & XFS_ATTR_VERITY)
+			xfs_attr_rmtverity_transform(bp, ino, dst + hdr_size,
+					byte_cnt);
+
 		/*
 		 * If this is the last block, zero the remainder of it.
 		 * Check that we are actually the last block, too.
@@ -407,6 +498,7 @@ xfs_attr_rmtval_get(
 	unsigned int		blkcnt = args->rmtblkcnt;
 	int			i;
 	unsigned int		offset = 0;
+	const struct xfs_buf_ops *ops = xfs_attr3_remote_buf_ops(args->attr_filter);
 
 	trace_xfs_attr_rmtval_get(args);
 
@@ -432,14 +524,15 @@ xfs_attr_rmtval_get(
 			dblkno = XFS_FSB_TO_DADDR(mp, map[i].br_startblock);
 			dblkcnt = XFS_FSB_TO_BB(mp, map[i].br_blockcount);
 			error = xfs_buf_read(mp->m_ddev_targp, dblkno, dblkcnt,
-					0, &bp, &xfs_attr3_rmt_buf_ops);
+					0, &bp, ops);
 			if (xfs_metadata_is_sick(error))
 				xfs_dirattr_mark_sick(args->dp, XFS_ATTR_FORK);
 			if (error)
 				return error;
 
 			error = xfs_attr_rmtval_copyout(mp, bp, args->dp,
-					args->owner, &offset, &valuelen, &dst);
+					args->owner, args->attr_filter,
+					&offset, &valuelen, &dst);
 			xfs_buf_relse(bp);
 			if (error)
 				return error;
@@ -472,7 +565,7 @@ xfs_attr_rmt_find_hole(
 	 * straight byte to FSB conversion and have to take the header space
 	 * into account.
 	 */
-	blkcnt = xfs_attr3_rmt_blocks(mp, args->rmtvaluelen);
+	blkcnt = xfs_attr3_rmt_blocks(mp, args->attr_filter, args->rmtvaluelen);
 	error = xfs_bmap_first_unused(args->trans, args->dp, blkcnt, &lfileoff,
 						   XFS_ATTR_FORK);
 	if (error)
@@ -531,10 +624,10 @@ xfs_attr_rmtval_set_value(
 		error = xfs_buf_get(mp->m_ddev_targp, dblkno, dblkcnt, &bp);
 		if (error)
 			return error;
-		bp->b_ops = &xfs_attr3_rmt_buf_ops;
+		bp->b_ops = xfs_attr3_remote_buf_ops(args->attr_filter);
 
-		xfs_attr_rmtval_copyin(mp, bp, args->owner, &offset, &valuelen,
-				&src);
+		xfs_attr_rmtval_copyin(mp, bp, args->owner, args->attr_filter,
+				&offset, &valuelen, &src);
 
 		error = xfs_bwrite(bp);	/* GROT: NOTE: synchronous write */
 		xfs_buf_relse(bp);
diff --git a/fs/xfs/libxfs/xfs_attr_remote.h b/fs/xfs/libxfs/xfs_attr_remote.h
index e3c6c7d774bf9..344fea1b9b50e 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.h
+++ b/fs/xfs/libxfs/xfs_attr_remote.h
@@ -6,12 +6,13 @@
 #ifndef __XFS_ATTR_REMOTE_H__
 #define	__XFS_ATTR_REMOTE_H__
 
-unsigned int xfs_attr3_rmt_blocks(struct xfs_mount *mp, unsigned int attrlen);
+unsigned int xfs_attr3_rmt_blocks(struct xfs_mount *mp, unsigned int attrns,
+		unsigned int attrlen);
 
 /* Number of rmt blocks needed to store the maximally sized attr value */
 static inline unsigned int xfs_attr3_max_rmt_blocks(struct xfs_mount *mp)
 {
-	return xfs_attr3_rmt_blocks(mp, XFS_XATTR_SIZE_MAX);
+	return xfs_attr3_rmt_blocks(mp, 0, XFS_XATTR_SIZE_MAX);
 }
 
 int xfs_attr_rmtval_get(struct xfs_da_args *args);
@@ -23,4 +24,7 @@ int xfs_attr_rmt_find_hole(struct xfs_da_args *args);
 int xfs_attr_rmtval_set_value(struct xfs_da_args *args);
 int xfs_attr_rmtval_set_blk(struct xfs_attr_intent *attr);
 int xfs_attr_rmtval_find_space(struct xfs_attr_intent *attr);
+
+const struct xfs_buf_ops *xfs_attr3_remote_buf_ops(unsigned int attrns);
+
 #endif /* __XFS_ATTR_REMOTE_H__ */
diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 27b9ad9f8b2e4..c84b94da3f321 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -885,7 +885,27 @@ struct xfs_attr3_rmt_hdr {
 
 #define XFS_ATTR3_RMT_CRC_OFF	offsetof(struct xfs_attr3_rmt_hdr, rm_crc)
 
-unsigned int xfs_attr3_rmt_buf_space(struct xfs_mount *mp);
+unsigned int xfs_attr3_rmt_buf_space(struct xfs_mount *mp, unsigned int attrns);
+
+/*
+ * XFS_ATTR_VERITY remote attribute block format definition
+ *
+ * fsverity stores blocks of a merkle tree in the extended attributes.  The
+ * size of these blocks are a power of two, so we'd like to reduce overhead by
+ * not storing a remote header at the start of each ondisk block.  Because
+ * merkle tree blocks are themselves hashes of other merkle tree or data
+ * blocks, we can detect bitflips without needing our own checksum.  Settle for
+ * XORing the owner, blkno, magic, and metauuid into the start of each ondisk
+ * merkle tree block.
+ */
+#define XFS_ATTR3_RMTVERITY_MAGIC	0x5955434B	/* YUCK */
+
+struct xfs_attr3_rmtverity_hdr {
+	__be64	rmv_owner;
+	__be64	rmv_blkno;
+	__be32	rmv_magic;
+	uuid_t	rmv_uuid;
+} __packed;
 
 /* Number of bytes in a directory block. */
 static inline unsigned int xfs_dir2_dirblock_bytes(struct xfs_sb *sbp)
diff --git a/fs/xfs/libxfs/xfs_ondisk.h b/fs/xfs/libxfs/xfs_ondisk.h
index 653ea6d643489..7a312aed23373 100644
--- a/fs/xfs/libxfs/xfs_ondisk.h
+++ b/fs/xfs/libxfs/xfs_ondisk.h
@@ -59,6 +59,7 @@ xfs_check_ondisk_structs(void)
 	XFS_CHECK_STRUCT_SIZE(struct xfs_attr3_leaf_hdr,	80);
 	XFS_CHECK_STRUCT_SIZE(struct xfs_attr3_leafblock,	80);
 	XFS_CHECK_STRUCT_SIZE(struct xfs_attr3_rmt_hdr,		56);
+	XFS_CHECK_STRUCT_SIZE(struct xfs_attr3_rmtverity_hdr,	36);
 	XFS_CHECK_STRUCT_SIZE(struct xfs_da3_blkinfo,		56);
 	XFS_CHECK_STRUCT_SIZE(struct xfs_da3_intnode,		64);
 	XFS_CHECK_STRUCT_SIZE(struct xfs_da3_node_hdr,		64);
@@ -207,6 +208,7 @@ xfs_check_ondisk_structs(void)
 	XFS_CHECK_VALUE(XFS_DQ_BIGTIME_EXPIRY_MIN << XFS_DQ_BIGTIME_SHIFT, 4);
 	XFS_CHECK_VALUE(XFS_DQ_BIGTIME_EXPIRY_MAX << XFS_DQ_BIGTIME_SHIFT,
 			16299260424LL);
+
 }
 
 #endif /* __XFS_ONDISK_H */
diff --git a/fs/xfs/libxfs/xfs_shared.h b/fs/xfs/libxfs/xfs_shared.h
index 40a4826603074..eb3a674fe1615 100644
--- a/fs/xfs/libxfs/xfs_shared.h
+++ b/fs/xfs/libxfs/xfs_shared.h
@@ -26,6 +26,7 @@ extern const struct xfs_buf_ops xfs_agfl_buf_ops;
 extern const struct xfs_buf_ops xfs_agi_buf_ops;
 extern const struct xfs_buf_ops xfs_attr3_leaf_buf_ops;
 extern const struct xfs_buf_ops xfs_attr3_rmt_buf_ops;
+extern const struct xfs_buf_ops xfs_attr3_rmtverity_buf_ops;
 extern const struct xfs_buf_ops xfs_bmbt_buf_ops;
 extern const struct xfs_buf_ops xfs_bnobt_buf_ops;
 extern const struct xfs_buf_ops xfs_cntbt_buf_ops;
diff --git a/fs/xfs/xfs_attr_inactive.c b/fs/xfs/xfs_attr_inactive.c
index 24fb12986a568..93fa78a230d04 100644
--- a/fs/xfs/xfs_attr_inactive.c
+++ b/fs/xfs/xfs_attr_inactive.c
@@ -110,7 +110,7 @@ xfs_attr3_leaf_inactive(
 		if (!name_rmt->valueblk)
 			continue;
 
-		blkcnt = xfs_attr3_rmt_blocks(dp->i_mount,
+		blkcnt = xfs_attr3_rmt_blocks(dp->i_mount, entry->flags,
 				be32_to_cpu(name_rmt->valuelen));
 		error = xfs_attr3_rmt_stale(dp,
 				be32_to_cpu(name_rmt->valueblk), blkcnt);


