Return-Path: <linux-fsdevel+bounces-15716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B816C89283B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A529282641
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3F21C0DE3;
	Sat, 30 Mar 2024 00:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Msdre7BP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB01FA2;
	Sat, 30 Mar 2024 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758980; cv=none; b=YXSmgBUfgh7iOYEssmLdczwych/9fUcla2HuSw+BLzAnDJkdY/F/b6xCVLpKZGJLa9d0i+gid3HKqZvLW4vkQ0Vre/RBtjuwwCG9uOR3vFeLKcG7oFMu1jm8XEFt0Xgl4S4Kyz3mC+vd8zfTU31cXKRYmS+m6DVmN5WO4GwXYnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758980; c=relaxed/simple;
	bh=f3ftG9DDkN4s7AMRC5wPnIpscCrbQlSD/O4eOjMD1vE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CitEOsWYvA3xfCtpCbcwt0zmqVX1tE4hp6HnuzZy9iPIvGVmrPEI9F4hte2tX86VWnRkZWNaejPK2i34ww7WQMnK8hsT5yZ13s86ZvNXcamKCPmBT9MNhkxjYC0wgPwHJrzfo8iYc1QUm9SMtlqplsvojPOQIE7KmRX5RGOYCik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Msdre7BP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BF6C433C7;
	Sat, 30 Mar 2024 00:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711758980;
	bh=f3ftG9DDkN4s7AMRC5wPnIpscCrbQlSD/O4eOjMD1vE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Msdre7BPP/l7lDZLw0k/vn7OV3z59VPiW2qbsyMxWZHc+TNlHAzT+RlF53GHwRNYG
	 d+ZV6kwCBT6pmIWE/Fd/BudeI1mWKaGahM+/vhKbYqLInVb/llrktD2DhdQInZIqEt
	 pBwmj7CE/r3oJGMHdhGrF+QBIH0hB4WQ+YXI7+W0ExVP2iEvUJROZPyba0/JK+s7M4
	 /mauM2yhBlegswehIy67ZFB7Fd5EHPm5Nl9PQM1mKgNtayS35VWrT8kjkYoKVPSfy8
	 vWkN7GYN/dW3VCLuQRZ1GC7ntZWksMA1rNx4hg7kpehcwV47S3+tI4WH5LvdlQd+Qe
	 6J6BfI9IG73Bg==
Date: Fri, 29 Mar 2024 17:36:19 -0700
Subject: [PATCH 01/29] xfs: use unsigned ints for non-negative quantities in
 xfs_attr_remote.c
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868577.1988170.1326765772903298581.stgit@frogsfrogsfrogs>
In-Reply-To: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
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
---
 fs/xfs/libxfs/xfs_attr_remote.c |   54 ++++++++++++++++++++-------------------
 fs/xfs/libxfs/xfs_attr_remote.h |    2 +
 2 files changed, 28 insertions(+), 28 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index a8de9dc1e998a..c778a3a51792e 100644
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
@@ -122,9 +122,9 @@ __xfs_attr3_rmt_read_verify(
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
@@ -186,7 +186,7 @@ xfs_attr3_rmt_write_verify(
 {
 	struct xfs_mount *mp = bp->b_mount;
 	xfs_failaddr_t	fa;
-	int		blksize = mp->m_attr_geo->blksize;
+	unsigned int	blksize = mp->m_attr_geo->blksize;
 	char		*ptr;
 	int		len;
 	xfs_daddr_t	bno;
@@ -281,20 +281,20 @@ xfs_attr_rmtval_copyout(
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
 
@@ -330,20 +330,20 @@ xfs_attr_rmtval_copyin(
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
@@ -389,12 +389,12 @@ xfs_attr_rmtval_get(
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
 
@@ -452,7 +452,7 @@ xfs_attr_rmt_find_hole(
 	struct xfs_inode	*dp = args->dp;
 	struct xfs_mount	*mp = dp->i_mount;
 	int			error;
-	int			blkcnt;
+	unsigned int		blkcnt;
 	xfs_fileoff_t		lfileoff = 0;
 
 	/*
@@ -481,11 +481,11 @@ xfs_attr_rmtval_set_value(
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
@@ -645,7 +645,7 @@ xfs_attr_rmtval_invalidate(
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


