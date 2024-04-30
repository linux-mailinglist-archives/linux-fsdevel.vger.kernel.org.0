Return-Path: <linux-fsdevel+bounces-18258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A918B68BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483241C21E2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A2910979;
	Tue, 30 Apr 2024 03:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRuvJSEg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF79E10A0C;
	Tue, 30 Apr 2024 03:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447885; cv=none; b=JdSOgZnrxhrYRYxA0poduR5hK5PT6vTWI/spN2+pJxYfww7ej1q8PiueF2uZQlvlQFVglEkhwF8pAXI2mNoK17MPK8yBbidW0L1Z39ZbfNioFM0vSIa2eAotn/YdB2RyIWkyW4kgb5K8UW33rtOUZM6QnmEfH65SjgZ4SyZJHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447885; c=relaxed/simple;
	bh=Qj19uUa1ftdlYwpbZBOrx6QxLHqvRuyjEYC0CuUPgAY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5X8haEXA8ksf7gbyE6PEuxtUvm4X8ynl3rO9v9iLwAwhICcX2DgurbJmjzl/F39T8mv8X6Yy98oMqvo2WNZ6gUt+v1Wsy3eDNtaO6N9sTRyFyIaxXbpAwhhPFkiR5svZxLudjL8angcAjU8op+piLbKWnZsQFPNmBl3ELsmbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRuvJSEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55ABC116B1;
	Tue, 30 Apr 2024 03:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447884;
	bh=Qj19uUa1ftdlYwpbZBOrx6QxLHqvRuyjEYC0CuUPgAY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QRuvJSEg2HFwB52lxfU/XAXMvW5N/hS67z5qWB9owC4W80mrJOpOWZM7uuHluEoSc
	 3Rj/Hygwdw79micQQ8iESmqhf3l0cK0KDMvi6A2ju61vVSYSuQ+sKYgqVBCLOxtRbP
	 2vN9ubPqT0jFVY7CmKD0M+JnsuBa8ua3Tgv6QXex5TzUwfyMV1XlY58fckSHAPuGcb
	 NY6rWje1b3OgdPk4ygWpFFThi6yfgg+8oUk5EcyXxZyx4jVxohpT23yCcscO+LZejp
	 bYjF6N8/NgdQHbnrNcz/ibOgMPes8Oy6ahu8FczP6M4pJXSwG+nv1Be1Pq9P7sK3Dy
	 GwjfXZK4NnuhQ==
Date: Mon, 29 Apr 2024 20:31:24 -0700
Subject: [PATCH 02/38] xfs: use unsigned ints for non-negative quantities in
 xfs_attr_remote.c
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683141.960383.12488351136918517053.stgit@frogsfrogsfrogs>
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

In the next few patches we're going to refactor the attr remote code so
that we can support headerless remote xattr values for storing merkle
tree blocks.  For now, let's change the code to use unsigned int to
describe quantities of bytes and blocks that cannot be negative.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 libxfs/xfs_attr_remote.c |   61 +++++++++++++++++++++++-----------------------
 libxfs/xfs_attr_remote.h |    2 +-
 2 files changed, 31 insertions(+), 32 deletions(-)


diff --git a/libxfs/xfs_attr_remote.c b/libxfs/xfs_attr_remote.c
index eb15b272b80f..5f1b9810c5c8 100644
--- a/libxfs/xfs_attr_remote.c
+++ b/libxfs/xfs_attr_remote.c
@@ -46,13 +46,13 @@
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
@@ -91,7 +91,6 @@ xfs_attr3_rmt_verify(
 	struct xfs_mount	*mp,
 	struct xfs_buf		*bp,
 	void			*ptr,
-	int			fsbsize,
 	xfs_daddr_t		bno)
 {
 	struct xfs_attr3_rmt_hdr *rmt = ptr;
@@ -102,7 +101,7 @@ xfs_attr3_rmt_verify(
 		return __this_address;
 	if (be64_to_cpu(rmt->rm_blkno) != bno)
 		return __this_address;
-	if (be32_to_cpu(rmt->rm_bytes) > fsbsize - sizeof(*rmt))
+	if (be32_to_cpu(rmt->rm_bytes) > mp->m_attr_geo->blksize - sizeof(*rmt))
 		return __this_address;
 	if (be32_to_cpu(rmt->rm_offset) +
 				be32_to_cpu(rmt->rm_bytes) > XFS_XATTR_SIZE_MAX)
@@ -121,9 +120,9 @@ __xfs_attr3_rmt_read_verify(
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
@@ -140,7 +139,7 @@ __xfs_attr3_rmt_read_verify(
 			*failaddr = __this_address;
 			return -EFSBADCRC;
 		}
-		*failaddr = xfs_attr3_rmt_verify(mp, bp, ptr, blksize, bno);
+		*failaddr = xfs_attr3_rmt_verify(mp, bp, ptr, bno);
 		if (*failaddr)
 			return -EFSCORRUPTED;
 		len -= blksize;
@@ -185,7 +184,7 @@ xfs_attr3_rmt_write_verify(
 {
 	struct xfs_mount *mp = bp->b_mount;
 	xfs_failaddr_t	fa;
-	int		blksize = mp->m_attr_geo->blksize;
+	unsigned int	blksize = mp->m_attr_geo->blksize;
 	char		*ptr;
 	int		len;
 	xfs_daddr_t	bno;
@@ -202,7 +201,7 @@ xfs_attr3_rmt_write_verify(
 	while (len > 0) {
 		struct xfs_attr3_rmt_hdr *rmt = (struct xfs_attr3_rmt_hdr *)ptr;
 
-		fa = xfs_attr3_rmt_verify(mp, bp, ptr, blksize, bno);
+		fa = xfs_attr3_rmt_verify(mp, bp, ptr, bno);
 		if (fa) {
 			xfs_verifier_error(bp, -EFSCORRUPTED, fa);
 			return;
@@ -280,20 +279,20 @@ xfs_attr_rmtval_copyout(
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
 
@@ -329,20 +328,20 @@ xfs_attr_rmtval_copyin(
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
@@ -388,12 +387,12 @@ xfs_attr_rmtval_get(
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
 
@@ -451,7 +450,7 @@ xfs_attr_rmt_find_hole(
 	struct xfs_inode	*dp = args->dp;
 	struct xfs_mount	*mp = dp->i_mount;
 	int			error;
-	int			blkcnt;
+	unsigned int		blkcnt;
 	xfs_fileoff_t		lfileoff = 0;
 
 	/*
@@ -480,11 +479,11 @@ xfs_attr_rmtval_set_value(
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
@@ -644,7 +643,7 @@ xfs_attr_rmtval_invalidate(
 	struct xfs_da_args	*args)
 {
 	xfs_dablk_t		lblkno;
-	int			blkcnt;
+	unsigned int		blkcnt;
 	int			error;
 
 	/*
diff --git a/libxfs/xfs_attr_remote.h b/libxfs/xfs_attr_remote.h
index d097ec6c4dc3..c64b04f91caf 100644
--- a/libxfs/xfs_attr_remote.h
+++ b/libxfs/xfs_attr_remote.h
@@ -6,7 +6,7 @@
 #ifndef __XFS_ATTR_REMOTE_H__
 #define	__XFS_ATTR_REMOTE_H__
 
-int xfs_attr3_rmt_blocks(struct xfs_mount *mp, int attrlen);
+unsigned int xfs_attr3_rmt_blocks(struct xfs_mount *mp, unsigned int attrlen);
 
 int xfs_attr_rmtval_get(struct xfs_da_args *args);
 int xfs_attr_rmtval_stale(struct xfs_inode *ip, struct xfs_bmbt_irec *map,


