Return-Path: <linux-fsdevel+bounces-18259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 899F48B68CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACA81C218FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFFE11CBD;
	Tue, 30 Apr 2024 03:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKcpn6kg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BAD22615;
	Tue, 30 Apr 2024 03:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447901; cv=none; b=riUryJUIyVycIMfsf8eobqn4T7rWifs1Z229FdZbRznVY9GjnZx5pd3mUL57KWcurnIMb3PqHcDNYbxU4RokTX/NmJ9HZCyFDMGZ/O6wPvbyUFGdVUfsqs+EdNj2rOcBkHslaxR4+7kKiauu4sY2JfqBRxUzr+6voMcKl8OCfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447901; c=relaxed/simple;
	bh=k2jQIZCVO7yIuLYzRtkgP7kPeU403uYKMrRHlWF/yhc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0tmITqkclmYRvLABVPXEHeemtSzXle8Sg1TFizklH8SZQfVuBrQeRoPJ2aH76+WL1q3gGY3+EvdDk9H9YlMGVEP5/YviSLh/e2QpscSzqcl11/TEZjPa6t41x+mb0vOTNhb3cbwpBaHS+IY4l1fj2F6GGZFKe6clVS6H0d+w2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKcpn6kg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E53C4AF14;
	Tue, 30 Apr 2024 03:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447900;
	bh=k2jQIZCVO7yIuLYzRtkgP7kPeU403uYKMrRHlWF/yhc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=aKcpn6kgoHRvlBYmrZpkTrBMjJR849wWKHydEYw1o3VvggqujDi96XpJZ4mKEyqxU
	 00GjKPLdM1ESh3WkNJj7LJ/ShVluvXUN1O13v7CEep1c8/PSp1GhLyPrstlrdPxEbU
	 i2sEnwIAC8csw3L8b+MkCd9TOOPYS+bt1dBhb9P10wO5qbTbBfV9egypdPkae99sfa
	 ew3jFGAfz7pPXwKIksaYmiCqvvoL5Kzrcs5LXZGg73ZtKRjifrLZeKREDKF/tsi2ka
	 fd8O8LQNS0tWJqik7K9owivX9ZW2Y2wL78p0y7ESHwY5cUEpdjU6oVF8B9qF5nhmPv
	 HlecuKTLlZ+UA==
Date: Mon, 29 Apr 2024 20:31:39 -0700
Subject: [PATCH 03/38] xfs: turn XFS_ATTR3_RMT_BUF_SPACE into a function
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683157.960383.17857305480795063902.stgit@frogsfrogsfrogs>
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

Turn this into a properly typechecked function, and actually use the
correct blocksize for extended attributes.  The function cannot be
static inline because xfsprogs userspace uses it.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 db/attr.c                |    2 +-
 db/metadump.c            |    8 ++++----
 libxfs/xfs_attr_remote.c |   19 ++++++++++++++++---
 libxfs/xfs_da_format.h   |    4 +---
 4 files changed, 22 insertions(+), 11 deletions(-)


diff --git a/db/attr.c b/db/attr.c
index a83ee14d0791..0b1f498e457c 100644
--- a/db/attr.c
+++ b/db/attr.c
@@ -221,7 +221,7 @@ attr3_remote_data_count(
 
 	if (hdr->rm_magic != cpu_to_be32(XFS_ATTR3_RMT_MAGIC))
 		return 0;
-	buf_space = XFS_ATTR3_RMT_BUF_SPACE(mp, mp->m_sb.sb_blocksize);
+	buf_space = xfs_attr3_rmt_buf_space(mp);
 	if (be32_to_cpu(hdr->rm_bytes) > buf_space)
 		return buf_space;
 	return be32_to_cpu(hdr->rm_bytes);
diff --git a/db/metadump.c b/db/metadump.c
index 90bec1467623..7337c716fc11 100644
--- a/db/metadump.c
+++ b/db/metadump.c
@@ -1748,7 +1748,7 @@ add_remote_vals(
 		attr_data.remote_vals[attr_data.remote_val_count] = blockidx;
 		attr_data.remote_val_count++;
 		blockidx++;
-		length -= XFS_ATTR3_RMT_BUF_SPACE(mp, mp->m_sb.sb_blocksize);
+		length -= xfs_attr3_rmt_buf_space(mp);
 	}
 
 	if (attr_data.remote_val_count >= MAX_REMOTE_VALS) {
@@ -1785,8 +1785,8 @@ process_attr_block(
 			    attr_data.remote_vals[i] == offset)
 				/* Macros to handle both attr and attr3 */
 				memset(block +
-					(bs - XFS_ATTR3_RMT_BUF_SPACE(mp, bs)),
-				      'v', XFS_ATTR3_RMT_BUF_SPACE(mp, bs));
+					(bs - xfs_attr3_rmt_buf_space(mp)),
+				      'v', xfs_attr3_rmt_buf_space(mp));
 		}
 		return;
 	}
@@ -1798,7 +1798,7 @@ process_attr_block(
 	if (nentries == 0 ||
 	    nentries * sizeof(xfs_attr_leaf_entry_t) +
 			xfs_attr3_leaf_hdr_size(leaf) >
-				XFS_ATTR3_RMT_BUF_SPACE(mp, bs)) {
+				xfs_attr3_rmt_buf_space(mp)) {
 		if (metadump.show_warnings)
 			print_warning("invalid attr count in inode %llu",
 					(long long)metadump.cur_ino);
diff --git a/libxfs/xfs_attr_remote.c b/libxfs/xfs_attr_remote.c
index 5f1b9810c5c8..b98805bb5926 100644
--- a/libxfs/xfs_attr_remote.c
+++ b/libxfs/xfs_attr_remote.c
@@ -42,6 +42,19 @@
  * the logging system and therefore never have a log item.
  */
 
+/* How many bytes can be stored in a remote value buffer? */
+inline unsigned int
+xfs_attr3_rmt_buf_space(
+	struct xfs_mount	*mp)
+{
+	unsigned int		blocksize = mp->m_attr_geo->blksize;
+
+	if (xfs_has_crc(mp))
+		return blocksize - sizeof(struct xfs_attr3_rmt_hdr);
+
+	return blocksize;
+}
+
 /*
  * Each contiguous block has a header, so it is not just a simple attribute
  * length to FSB conversion.
@@ -52,7 +65,7 @@ xfs_attr3_rmt_blocks(
 	unsigned int		attrlen)
 {
 	if (xfs_has_crc(mp)) {
-		unsigned int buflen = XFS_ATTR3_RMT_BUF_SPACE(mp, mp->m_sb.sb_blocksize);
+		unsigned int buflen = xfs_attr3_rmt_buf_space(mp);
 		return (attrlen + buflen - 1) / buflen;
 	}
 	return XFS_B_TO_FSB(mp, attrlen);
@@ -292,7 +305,7 @@ xfs_attr_rmtval_copyout(
 
 	while (len > 0 && *valuelen > 0) {
 		unsigned int hdr_size = 0;
-		unsigned int byte_cnt = XFS_ATTR3_RMT_BUF_SPACE(mp, blksize);
+		unsigned int byte_cnt = xfs_attr3_rmt_buf_space(mp);
 
 		byte_cnt = min(*valuelen, byte_cnt);
 
@@ -341,7 +354,7 @@ xfs_attr_rmtval_copyin(
 
 	while (len > 0 && *valuelen > 0) {
 		unsigned int hdr_size;
-		unsigned int byte_cnt = XFS_ATTR3_RMT_BUF_SPACE(mp, blksize);
+		unsigned int byte_cnt = xfs_attr3_rmt_buf_space(mp);
 
 		byte_cnt = min(*valuelen, byte_cnt);
 		hdr_size = xfs_attr3_rmt_hdr_set(mp, dst, ino, *offset,
diff --git a/libxfs/xfs_da_format.h b/libxfs/xfs_da_format.h
index ebde6eb1da65..86de99e2f757 100644
--- a/libxfs/xfs_da_format.h
+++ b/libxfs/xfs_da_format.h
@@ -880,9 +880,7 @@ struct xfs_attr3_rmt_hdr {
 
 #define XFS_ATTR3_RMT_CRC_OFF	offsetof(struct xfs_attr3_rmt_hdr, rm_crc)
 
-#define XFS_ATTR3_RMT_BUF_SPACE(mp, bufsize)	\
-	((bufsize) - (xfs_has_crc((mp)) ? \
-			sizeof(struct xfs_attr3_rmt_hdr) : 0))
+unsigned int xfs_attr3_rmt_buf_space(struct xfs_mount *mp);
 
 /* Number of bytes in a directory block. */
 static inline unsigned int xfs_dir2_dirblock_bytes(struct xfs_sb *sbp)


