Return-Path: <linux-fsdevel+bounces-18264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B751C8B68DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97B81C21892
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80B0182C3;
	Tue, 30 Apr 2024 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4WBdd9m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3596810A01;
	Tue, 30 Apr 2024 03:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447979; cv=none; b=OBRigLcFX0jOob0JSmBOdABwEK1VN5W1DEfh6NbZgaV0JItHxyzdqd3f0vsalKx20JeB++FUVIjyDqCjCDRDceZeksYCFaNhTsqk8RyK1YpefLVcZO+6OSOl3NZVyA96t4VceZCHVrrh3P8fhlAZzn+rk0M1THrZpXnRKrajQmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447979; c=relaxed/simple;
	bh=j8PStW8TI5qtFE6cRFelKUdqofC5Ko8TXpbj1jKPbMY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFRm/7rol2CmVNdY8qJZROymvkKCs22PcubgCQtZykz/qE6gIOMgQIxCS7Y/PuGnca9HlXVpT/vYuZGaYSlXref8kkFQIBa5DyaNQYX7cmJqLq6byI2tWE2ncD4WZjPn7zbzoxpfBxN/zV5u4W9V9g+O/DZFTN6VGN/rIEhz58k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4WBdd9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF8BC116B1;
	Tue, 30 Apr 2024 03:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447978;
	bh=j8PStW8TI5qtFE6cRFelKUdqofC5Ko8TXpbj1jKPbMY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=c4WBdd9mJP8TLmkH5mlRhnSfB/0ngd+jjsIEUoPnQ9wPgzyhPX47eeHRq4KkxJLPw
	 hrxXnS1FBPicabEEqOI1mTJx1CzTXkmH3En+Uwhp0/NVP1AtnR8WKLwQrGZOeKpPYj
	 NrHHzdpv8B7rKcY+aCv3MIr9opLbUJ9sKX5aDYfstvJE8WcfIiy/OTjnERLyyvKtPT
	 L3z88abbcaps025OlRTamjiBMBtk/kIv/oZ2V4oN67tKqVjveLiuA+KB3mUGBzN+K6
	 0BqGFM+gOc5YKFsSitvzkajM0DDlrFMz9h6eeZqSzC8Q+Ysf7fxf2Wkpylu6kf+ZVd
	 GxefnvU5yq/HA==
Date: Mon, 29 Apr 2024 20:32:58 -0700
Subject: [PATCH 08/38] xfs: do not use xfs_attr3_rmt_hdr for remote verity
 value blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683235.960383.12956402365593793781.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
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
 db/attr.c                |    2 -
 db/metadump.c            |    8 +--
 include/platform_defs.h  |    9 +++
 libxfs/libxfs_api_defs.h |    1 
 libxfs/xfs_attr.c        |    6 +-
 libxfs/xfs_attr_leaf.c   |    5 +-
 libxfs/xfs_attr_remote.c |  125 ++++++++++++++++++++++++++++++++++++++++------
 libxfs/xfs_attr_remote.h |    8 ++-
 libxfs/xfs_da_format.h   |   22 ++++++++
 libxfs/xfs_ondisk.h      |    2 +
 libxfs/xfs_shared.h      |    1 
 11 files changed, 162 insertions(+), 27 deletions(-)


diff --git a/db/attr.c b/db/attr.c
index 0b1f498e457c..8e2bce7b7e02 100644
--- a/db/attr.c
+++ b/db/attr.c
@@ -221,7 +221,7 @@ attr3_remote_data_count(
 
 	if (hdr->rm_magic != cpu_to_be32(XFS_ATTR3_RMT_MAGIC))
 		return 0;
-	buf_space = xfs_attr3_rmt_buf_space(mp);
+	buf_space = xfs_attr3_rmt_buf_space(mp, 0);
 	if (be32_to_cpu(hdr->rm_bytes) > buf_space)
 		return buf_space;
 	return be32_to_cpu(hdr->rm_bytes);
diff --git a/db/metadump.c b/db/metadump.c
index 7337c716fc11..23defaee929f 100644
--- a/db/metadump.c
+++ b/db/metadump.c
@@ -1748,7 +1748,7 @@ add_remote_vals(
 		attr_data.remote_vals[attr_data.remote_val_count] = blockidx;
 		attr_data.remote_val_count++;
 		blockidx++;
-		length -= xfs_attr3_rmt_buf_space(mp);
+		length -= xfs_attr3_rmt_buf_space(mp, 0);
 	}
 
 	if (attr_data.remote_val_count >= MAX_REMOTE_VALS) {
@@ -1785,8 +1785,8 @@ process_attr_block(
 			    attr_data.remote_vals[i] == offset)
 				/* Macros to handle both attr and attr3 */
 				memset(block +
-					(bs - xfs_attr3_rmt_buf_space(mp)),
-				      'v', xfs_attr3_rmt_buf_space(mp));
+					(bs - xfs_attr3_rmt_buf_space(mp, 0)),
+				      'v', xfs_attr3_rmt_buf_space(mp, 0));
 		}
 		return;
 	}
@@ -1798,7 +1798,7 @@ process_attr_block(
 	if (nentries == 0 ||
 	    nentries * sizeof(xfs_attr_leaf_entry_t) +
 			xfs_attr3_leaf_hdr_size(leaf) >
-				xfs_attr3_rmt_buf_space(mp)) {
+				xfs_attr3_rmt_buf_space(mp, 0)) {
 		if (metadump.show_warnings)
 			print_warning("invalid attr count in inode %llu",
 					(long long)metadump.cur_ino);
diff --git a/include/platform_defs.h b/include/platform_defs.h
index c01d4c426746..9c28e2744a8d 100644
--- a/include/platform_defs.h
+++ b/include/platform_defs.h
@@ -121,6 +121,15 @@ static inline size_t __ab_c_size(size_t a, size_t b, size_t c)
 #define struct_size_t(type, member, count)					\
 	struct_size((type *)NULL, member, count)
 
+/**
+ * offsetofend() - Report the offset of a struct field within the struct
+ *
+ * @TYPE: The type of the structure
+ * @MEMBER: The member within the structure to get the end offset of
+ */
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
+
 /*
  * Add the pseudo keyword 'fallthrough' so case statement blocks
  * must end with any of these keywords:
diff --git a/libxfs/libxfs_api_defs.h b/libxfs/libxfs_api_defs.h
index 19b7ecf5798d..1b6efac9290d 100644
--- a/libxfs/libxfs_api_defs.h
+++ b/libxfs/libxfs_api_defs.h
@@ -43,6 +43,7 @@
 
 #define xfs_attr3_leaf_hdr_from_disk	libxfs_attr3_leaf_hdr_from_disk
 #define xfs_attr3_leaf_read		libxfs_attr3_leaf_read
+#define xfs_attr3_remote_buf_ops	libxfs_attr3_remote_buf_ops
 #define xfs_attr_check_namespace	libxfs_attr_check_namespace
 #define xfs_attr_get			libxfs_attr_get
 #define xfs_attr_hashname		libxfs_attr_hashname
diff --git a/libxfs/xfs_attr.c b/libxfs/xfs_attr.c
index 0a9fb396885e..c2c411268904 100644
--- a/libxfs/xfs_attr.c
+++ b/libxfs/xfs_attr.c
@@ -341,7 +341,8 @@ xfs_attr_calc_size(
 		 * Out of line attribute, cannot double split, but
 		 * make room for the attribute value itself.
 		 */
-		uint	dblocks = xfs_attr3_rmt_blocks(mp, args->valuelen);
+		uint	dblocks = xfs_attr3_rmt_blocks(mp, args->attr_filter,
+						       args->valuelen);
 		nblks += dblocks;
 		nblks += XFS_NEXTENTADD_SPACE_RES(mp, dblocks, XFS_ATTR_FORK);
 	}
@@ -1055,7 +1056,8 @@ xfs_attr_set(
 		}
 
 		if (!local)
-			rmt_blks = xfs_attr3_rmt_blocks(mp, args->valuelen);
+			rmt_blks = xfs_attr3_rmt_blocks(mp, args->valuelen,
+					args->valuelen);
 		break;
 	case XFS_ATTRUPDATE_REMOVE:
 		XFS_STATS_INC(mp, xs_attr_remove);
diff --git a/libxfs/xfs_attr_leaf.c b/libxfs/xfs_attr_leaf.c
index 97b71b6500bd..56db9f992fc7 100644
--- a/libxfs/xfs_attr_leaf.c
+++ b/libxfs/xfs_attr_leaf.c
@@ -1563,7 +1563,8 @@ xfs_attr3_leaf_add_work(
 		name_rmt->valuelen = 0;
 		name_rmt->valueblk = 0;
 		args->rmtblkno = 1;
-		args->rmtblkcnt = xfs_attr3_rmt_blocks(mp, args->valuelen);
+		args->rmtblkcnt = xfs_attr3_rmt_blocks(mp, args->attr_filter,
+				args->valuelen);
 		args->rmtvaluelen = args->valuelen;
 	}
 	xfs_trans_log_buf(args->trans, bp,
@@ -2498,6 +2499,7 @@ xfs_attr3_leaf_lookup_int(
 			args->rmtblkno = be32_to_cpu(name_rmt->valueblk);
 			args->rmtblkcnt = xfs_attr3_rmt_blocks(
 							args->dp->i_mount,
+							args->attr_filter,
 							args->rmtvaluelen);
 			return -EEXIST;
 		}
@@ -2546,6 +2548,7 @@ xfs_attr3_leaf_getvalue(
 	args->rmtvaluelen = be32_to_cpu(name_rmt->valuelen);
 	args->rmtblkno = be32_to_cpu(name_rmt->valueblk);
 	args->rmtblkcnt = xfs_attr3_rmt_blocks(args->dp->i_mount,
+					       args->attr_filter,
 					       args->rmtvaluelen);
 	return xfs_attr_copy_value(args, NULL, args->rmtvaluelen);
 }
diff --git a/libxfs/xfs_attr_remote.c b/libxfs/xfs_attr_remote.c
index f9c0da51a8fa..d9c3346f1f5c 100644
--- a/libxfs/xfs_attr_remote.c
+++ b/libxfs/xfs_attr_remote.c
@@ -42,14 +42,23 @@
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
@@ -59,14 +68,15 @@ xfs_attr3_rmt_buf_space(
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
@@ -247,6 +257,42 @@ const struct xfs_buf_ops xfs_attr3_rmt_buf_ops = {
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
@@ -283,6 +329,40 @@ xfs_attr3_rmt_hdr_set(
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
@@ -292,6 +372,7 @@ xfs_attr_rmtval_copyout(
 	struct xfs_buf		*bp,
 	struct xfs_inode	*dp,
 	xfs_ino_t		owner,
+	unsigned int		attrns,
 	unsigned int		*offset,
 	unsigned int		*valuelen,
 	uint8_t			**dst)
@@ -305,11 +386,11 @@ xfs_attr_rmtval_copyout(
 
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
@@ -323,6 +404,10 @@ xfs_attr_rmtval_copyout(
 
 		memcpy(*dst, src + hdr_size, byte_cnt);
 
+		if (attrns & XFS_ATTR_VERITY)
+			xfs_attr_rmtverity_transform(bp, dp->i_ino, *dst,
+					byte_cnt);
+
 		/* roll buffer forwards */
 		len -= blksize;
 		src += blksize;
@@ -341,6 +426,7 @@ xfs_attr_rmtval_copyin(
 	struct xfs_mount *mp,
 	struct xfs_buf	*bp,
 	xfs_ino_t	ino,
+	unsigned int	attrns,
 	unsigned int	*offset,
 	unsigned int	*valuelen,
 	uint8_t		**src)
@@ -353,15 +439,20 @@ xfs_attr_rmtval_copyin(
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
@@ -406,6 +497,7 @@ xfs_attr_rmtval_get(
 	unsigned int		blkcnt = args->rmtblkcnt;
 	int			i;
 	unsigned int		offset = 0;
+	const struct xfs_buf_ops *ops = xfs_attr3_remote_buf_ops(args->attr_filter);
 
 	trace_xfs_attr_rmtval_get(args);
 
@@ -431,14 +523,15 @@ xfs_attr_rmtval_get(
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
@@ -471,7 +564,7 @@ xfs_attr_rmt_find_hole(
 	 * straight byte to FSB conversion and have to take the header space
 	 * into account.
 	 */
-	blkcnt = xfs_attr3_rmt_blocks(mp, args->rmtvaluelen);
+	blkcnt = xfs_attr3_rmt_blocks(mp, args->attr_filter, args->rmtvaluelen);
 	error = xfs_bmap_first_unused(args->trans, args->dp, blkcnt, &lfileoff,
 						   XFS_ATTR_FORK);
 	if (error)
@@ -530,10 +623,10 @@ xfs_attr_rmtval_set_value(
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
diff --git a/libxfs/xfs_attr_remote.h b/libxfs/xfs_attr_remote.h
index e3c6c7d774bf..344fea1b9b50 100644
--- a/libxfs/xfs_attr_remote.h
+++ b/libxfs/xfs_attr_remote.h
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
diff --git a/libxfs/xfs_da_format.h b/libxfs/xfs_da_format.h
index 27b9ad9f8b2e..c84b94da3f32 100644
--- a/libxfs/xfs_da_format.h
+++ b/libxfs/xfs_da_format.h
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
diff --git a/libxfs/xfs_ondisk.h b/libxfs/xfs_ondisk.h
index 653ea6d64348..7a312aed2337 100644
--- a/libxfs/xfs_ondisk.h
+++ b/libxfs/xfs_ondisk.h
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
diff --git a/libxfs/xfs_shared.h b/libxfs/xfs_shared.h
index 40a482660307..eb3a674fe161 100644
--- a/libxfs/xfs_shared.h
+++ b/libxfs/xfs_shared.h
@@ -26,6 +26,7 @@ extern const struct xfs_buf_ops xfs_agfl_buf_ops;
 extern const struct xfs_buf_ops xfs_agi_buf_ops;
 extern const struct xfs_buf_ops xfs_attr3_leaf_buf_ops;
 extern const struct xfs_buf_ops xfs_attr3_rmt_buf_ops;
+extern const struct xfs_buf_ops xfs_attr3_rmtverity_buf_ops;
 extern const struct xfs_buf_ops xfs_bmbt_buf_ops;
 extern const struct xfs_buf_ops xfs_bnobt_buf_ops;
 extern const struct xfs_buf_ops xfs_cntbt_buf_ops;


