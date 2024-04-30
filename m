Return-Path: <linux-fsdevel+bounces-18230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6450A8B687A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B6A6B22E03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F77410A3F;
	Tue, 30 Apr 2024 03:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaE9emQM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65536FB1;
	Tue, 30 Apr 2024 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447463; cv=none; b=nv+ejJZsG2t57A9nAq8+zeAGAgg2sOmlRfcZMWGvDQwki5LCgvwb9tM3mLYnN1qDcugYvWNmwQadOJJXmR/PPpsTSRvetvmQ6dfrs5L1uc0pg9r5aP/dOonnlPhQ67hggOSNyLq/MZ32yvTFZMw0Izt8Hd6GJfz+3uH5sHzsoxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447463; c=relaxed/simple;
	bh=HHh9fBNo2BlUy3aEUOX4aLCwPvAv7BH/0w+jH9g480w=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J44WWbj4GdtqcvB/HGQKmEcH9h5ut0a2Bt4GHQLGp8v7iTdbF5LlD2d4Ds6PCImr1u2l7wAdAJZsVgTwpaXi0Ptm8huIlzE3QRkHzQLr1j3uJGOgxKifOUHqZFF7pH/h9/QzmbJxMRuWYL1gFFpfvfnMIWUKWh+P/qnC5c+vEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaE9emQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AEBC116B1;
	Tue, 30 Apr 2024 03:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447462;
	bh=HHh9fBNo2BlUy3aEUOX4aLCwPvAv7BH/0w+jH9g480w=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BaE9emQMK/lkVWI/6slWJcrQXml6kjcvpGaxlHZxA0WvKagTDpJlT3RL9pnzGhgKk
	 TUsXS1KOhr3kSrzX87JtVSpWdJSQoFM5sgMb6eEZoXsojwisRIgNk8N/KW5Cn7RPqu
	 2FmN9zmjs/oT/jRqHLTfGDud4OJ8fcPZTjsTw3f3XEVW914TxValBii4J6xlW+ia4q
	 fRm8WvIWBfPV6xJZTHi7MKQ06lhlHgR5cXPeAS7AbbeE6qrlRlhpgFAzeYe9H2B/K/
	 jtJ+hDuB4IZR5MdtfT1wfZ7MPtOGdhw+bjdtKSxZgufE/FHDI7nwsXfLMiPTUKCKnu
	 vwDrSExrRaBGg==
Date: Mon, 29 Apr 2024 20:24:22 -0700
Subject: [PATCH 01/26] xfs: use unsigned ints for non-negative quantities in
 xfs_attr_remote.c
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680378.957659.14973171617153243991.stgit@frogsfrogsfrogs>
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

In the next few patches we're going to refactor the attr remote code so
that we can support headerless remote xattr values for storing merkle
tree blocks.  For now, let's change the code to use unsigned int to
describe quantities of bytes and blocks that cannot be negative.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_attr_remote.c |   61 +++++++++++++++++++--------------------
 fs/xfs/libxfs/xfs_attr_remote.h |    2 +
 2 files changed, 31 insertions(+), 32 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index a8de9dc1e998a..1d44ab3e0a506 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -47,13 +47,13 @@
  * Each contiguous block has a header, so it is not just a simple attribute
  * length to FSB conversion.
  */
-int
+unsigned int
 xfs_attr3_rmt_blocks(
-	struct xfs_mount *mp,
-	int		attrlen)
+	struct xfs_mount	*mp,
+	unsigned int		attrlen)
 {
 	if (xfs_has_crc(mp)) {
-		int buflen = XFS_ATTR3_RMT_BUF_SPACE(mp, mp->m_sb.sb_blocksize);
+		unsigned int buflen = XFS_ATTR3_RMT_BUF_SPACE(mp, mp->m_sb.sb_blocksize);
 		return (attrlen + buflen - 1) / buflen;
 	}
 	return XFS_B_TO_FSB(mp, attrlen);
@@ -92,7 +92,6 @@ xfs_attr3_rmt_verify(
 	struct xfs_mount	*mp,
 	struct xfs_buf		*bp,
 	void			*ptr,
-	int			fsbsize,
 	xfs_daddr_t		bno)
 {
 	struct xfs_attr3_rmt_hdr *rmt = ptr;
@@ -103,7 +102,7 @@ xfs_attr3_rmt_verify(
 		return __this_address;
 	if (be64_to_cpu(rmt->rm_blkno) != bno)
 		return __this_address;
-	if (be32_to_cpu(rmt->rm_bytes) > fsbsize - sizeof(*rmt))
+	if (be32_to_cpu(rmt->rm_bytes) > mp->m_attr_geo->blksize - sizeof(*rmt))
 		return __this_address;
 	if (be32_to_cpu(rmt->rm_offset) +
 				be32_to_cpu(rmt->rm_bytes) > XFS_XATTR_SIZE_MAX)
@@ -122,9 +121,9 @@ __xfs_attr3_rmt_read_verify(
 {
 	struct xfs_mount *mp = bp->b_mount;
 	char		*ptr;
-	int		len;
+	unsigned int	len;
 	xfs_daddr_t	bno;
-	int		blksize = mp->m_attr_geo->blksize;
+	unsigned int	blksize = mp->m_attr_geo->blksize;
 
 	/* no verification of non-crc buffers */
 	if (!xfs_has_crc(mp))
@@ -141,7 +140,7 @@ __xfs_attr3_rmt_read_verify(
 			*failaddr = __this_address;
 			return -EFSBADCRC;
 		}
-		*failaddr = xfs_attr3_rmt_verify(mp, bp, ptr, blksize, bno);
+		*failaddr = xfs_attr3_rmt_verify(mp, bp, ptr, bno);
 		if (*failaddr)
 			return -EFSCORRUPTED;
 		len -= blksize;
@@ -186,7 +185,7 @@ xfs_attr3_rmt_write_verify(
 {
 	struct xfs_mount *mp = bp->b_mount;
 	xfs_failaddr_t	fa;
-	int		blksize = mp->m_attr_geo->blksize;
+	unsigned int	blksize = mp->m_attr_geo->blksize;
 	char		*ptr;
 	int		len;
 	xfs_daddr_t	bno;
@@ -203,7 +202,7 @@ xfs_attr3_rmt_write_verify(
 	while (len > 0) {
 		struct xfs_attr3_rmt_hdr *rmt = (struct xfs_attr3_rmt_hdr *)ptr;
 
-		fa = xfs_attr3_rmt_verify(mp, bp, ptr, blksize, bno);
+		fa = xfs_attr3_rmt_verify(mp, bp, ptr, bno);
 		if (fa) {
 			xfs_verifier_error(bp, -EFSCORRUPTED, fa);
 			return;
@@ -281,20 +280,20 @@ xfs_attr_rmtval_copyout(
 	struct xfs_buf		*bp,
 	struct xfs_inode	*dp,
 	xfs_ino_t		owner,
-	int			*offset,
-	int			*valuelen,
+	unsigned int		*offset,
+	unsigned int		*valuelen,
 	uint8_t			**dst)
 {
 	char			*src = bp->b_addr;
 	xfs_daddr_t		bno = xfs_buf_daddr(bp);
-	int			len = BBTOB(bp->b_length);
-	int			blksize = mp->m_attr_geo->blksize;
+	unsigned int		len = BBTOB(bp->b_length);
+	unsigned int		blksize = mp->m_attr_geo->blksize;
 
 	ASSERT(len >= blksize);
 
 	while (len > 0 && *valuelen > 0) {
-		int hdr_size = 0;
-		int byte_cnt = XFS_ATTR3_RMT_BUF_SPACE(mp, blksize);
+		unsigned int hdr_size = 0;
+		unsigned int byte_cnt = XFS_ATTR3_RMT_BUF_SPACE(mp, blksize);
 
 		byte_cnt = min(*valuelen, byte_cnt);
 
@@ -330,20 +329,20 @@ xfs_attr_rmtval_copyin(
 	struct xfs_mount *mp,
 	struct xfs_buf	*bp,
 	xfs_ino_t	ino,
-	int		*offset,
-	int		*valuelen,
+	unsigned int	*offset,
+	unsigned int	*valuelen,
 	uint8_t		**src)
 {
 	char		*dst = bp->b_addr;
 	xfs_daddr_t	bno = xfs_buf_daddr(bp);
-	int		len = BBTOB(bp->b_length);
-	int		blksize = mp->m_attr_geo->blksize;
+	unsigned int	len = BBTOB(bp->b_length);
+	unsigned int	blksize = mp->m_attr_geo->blksize;
 
 	ASSERT(len >= blksize);
 
 	while (len > 0 && *valuelen > 0) {
-		int hdr_size;
-		int byte_cnt = XFS_ATTR3_RMT_BUF_SPACE(mp, blksize);
+		unsigned int hdr_size;
+		unsigned int byte_cnt = XFS_ATTR3_RMT_BUF_SPACE(mp, blksize);
 
 		byte_cnt = min(*valuelen, byte_cnt);
 		hdr_size = xfs_attr3_rmt_hdr_set(mp, dst, ino, *offset,
@@ -389,12 +388,12 @@ xfs_attr_rmtval_get(
 	struct xfs_buf		*bp;
 	xfs_dablk_t		lblkno = args->rmtblkno;
 	uint8_t			*dst = args->value;
-	int			valuelen;
+	unsigned int		valuelen;
 	int			nmap;
 	int			error;
-	int			blkcnt = args->rmtblkcnt;
+	unsigned int		blkcnt = args->rmtblkcnt;
 	int			i;
-	int			offset = 0;
+	unsigned int		offset = 0;
 
 	trace_xfs_attr_rmtval_get(args);
 
@@ -452,7 +451,7 @@ xfs_attr_rmt_find_hole(
 	struct xfs_inode	*dp = args->dp;
 	struct xfs_mount	*mp = dp->i_mount;
 	int			error;
-	int			blkcnt;
+	unsigned int		blkcnt;
 	xfs_fileoff_t		lfileoff = 0;
 
 	/*
@@ -481,11 +480,11 @@ xfs_attr_rmtval_set_value(
 	struct xfs_bmbt_irec	map;
 	xfs_dablk_t		lblkno;
 	uint8_t			*src = args->value;
-	int			blkcnt;
-	int			valuelen;
+	unsigned int		blkcnt;
+	unsigned int		valuelen;
 	int			nmap;
 	int			error;
-	int			offset = 0;
+	unsigned int		offset = 0;
 
 	/*
 	 * Roll through the "value", copying the attribute value to the
@@ -645,7 +644,7 @@ xfs_attr_rmtval_invalidate(
 	struct xfs_da_args	*args)
 {
 	xfs_dablk_t		lblkno;
-	int			blkcnt;
+	unsigned int		blkcnt;
 	int			error;
 
 	/*
diff --git a/fs/xfs/libxfs/xfs_attr_remote.h b/fs/xfs/libxfs/xfs_attr_remote.h
index d097ec6c4dc35..c64b04f91cafd 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.h
+++ b/fs/xfs/libxfs/xfs_attr_remote.h
@@ -6,7 +6,7 @@
 #ifndef __XFS_ATTR_REMOTE_H__
 #define	__XFS_ATTR_REMOTE_H__
 
-int xfs_attr3_rmt_blocks(struct xfs_mount *mp, int attrlen);
+unsigned int xfs_attr3_rmt_blocks(struct xfs_mount *mp, unsigned int attrlen);
 
 int xfs_attr_rmtval_get(struct xfs_da_args *args);
 int xfs_attr_rmtval_stale(struct xfs_inode *ip, struct xfs_bmbt_irec *map,


