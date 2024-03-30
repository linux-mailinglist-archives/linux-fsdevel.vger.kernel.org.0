Return-Path: <linux-fsdevel+bounces-15717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7088089283D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01743B2286D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8494A3F;
	Sat, 30 Mar 2024 00:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0sThPzo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96AA4685;
	Sat, 30 Mar 2024 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758996; cv=none; b=hE5syoRQi3Kvz57BZryA7qkvNCV1IfS3z3Z8kpCXPZ37RlByFkDy7KwgLPVLuRzjlKcmuGIt/Aox9ZdHafDZ32cu40yeREfe3mdc/Q30G+lxqbq8U05zfGM/+BjlASii4iUExjU03UOd2wNddvXpxP7rwiEilbR7vkn6uDrqpiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758996; c=relaxed/simple;
	bh=nX9fmfpUpo6IYdkZSI6bCLEb+syc4sYBvMlI72ttkw4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JoS1pzqyOOaZ+sat2Nw+X6L4yy0Gf4Gi9IGTdW2tKRLoKm7MHs0eLT96wyC4nS5Jnm6uaMulp6yHQbW9kHkRG5tEAYNtcUr+Hg5F1m//Sx+44IPmhmonmqqWGLD8a2U9uYYewLzlb3zNrS9VN6BlW6yYXpwSQY2spIKlADJUubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0sThPzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD97C43394;
	Sat, 30 Mar 2024 00:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711758995;
	bh=nX9fmfpUpo6IYdkZSI6bCLEb+syc4sYBvMlI72ttkw4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=o0sThPzoleN3hv1uRRRqPdltGRVEwBWAt35ir6fuMCBCmY1C/0GrjA3qpWQAPF1DN
	 0wHY68FAG9OoDbFKLHjq98LEM++5YojcIOBDIT62kuhqRhiTl8nGc2VSCN+yviyJF2
	 R0SqFar8sFIOr8wgDvVOXYaKSnCGniRPQ68PHDKriBYYcXQSYAyfCsya2kDsmVgIeK
	 UxBQ05x+83V7rGvhhH4hhI+nkVELNAEGKZIkz6f7WLyWKBP5U/Pp+n7JHymI9Yhd6w
	 JhA4Xq4Vk+xpxCl3tL47PDXAWvg8oTGwEp/jKBndvHD/bF1Hb0fNtHTOXFMJ/U8AuU
	 lXAS/D6mzPgPQ==
Date: Fri, 29 Mar 2024 17:36:35 -0700
Subject: [PATCH 02/29] xfs: turn XFS_ATTR3_RMT_BUF_SPACE into a function
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868593.1988170.18437361749358268580.stgit@frogsfrogsfrogs>
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

Turn this into a properly typechecked function, and actually use the
correct blocksize for extended attributes.  The function cannot be
static inline because xfsprogs userspace uses it.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_attr_remote.c |   19 ++++++++++++++++---
 fs/xfs/libxfs/xfs_da_format.h   |    4 +---
 2 files changed, 17 insertions(+), 6 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index c778a3a51792e..efecebc20ec46 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -43,6 +43,19 @@
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
@@ -53,7 +66,7 @@ xfs_attr3_rmt_blocks(
 	unsigned int		attrlen)
 {
 	if (xfs_has_crc(mp)) {
-		unsigned int buflen = XFS_ATTR3_RMT_BUF_SPACE(mp, mp->m_sb.sb_blocksize);
+		unsigned int buflen = xfs_attr3_rmt_buf_space(mp);
 		return (attrlen + buflen - 1) / buflen;
 	}
 	return XFS_B_TO_FSB(mp, attrlen);
@@ -294,7 +307,7 @@ xfs_attr_rmtval_copyout(
 
 	while (len > 0 && *valuelen > 0) {
 		unsigned int hdr_size = 0;
-		unsigned int byte_cnt = XFS_ATTR3_RMT_BUF_SPACE(mp, blksize);
+		unsigned int byte_cnt = xfs_attr3_rmt_buf_space(mp);
 
 		byte_cnt = min(*valuelen, byte_cnt);
 
@@ -343,7 +356,7 @@ xfs_attr_rmtval_copyin(
 
 	while (len > 0 && *valuelen > 0) {
 		unsigned int hdr_size;
-		unsigned int byte_cnt = XFS_ATTR3_RMT_BUF_SPACE(mp, blksize);
+		unsigned int byte_cnt = xfs_attr3_rmt_buf_space(mp);
 
 		byte_cnt = min(*valuelen, byte_cnt);
 		hdr_size = xfs_attr3_rmt_hdr_set(mp, dst, ino, *offset,
diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index e67045a66ef8f..30c97aecd8115 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -870,9 +870,7 @@ struct xfs_attr3_rmt_hdr {
 
 #define XFS_ATTR3_RMT_CRC_OFF	offsetof(struct xfs_attr3_rmt_hdr, rm_crc)
 
-#define XFS_ATTR3_RMT_BUF_SPACE(mp, bufsize)	\
-	((bufsize) - (xfs_has_crc((mp)) ? \
-			sizeof(struct xfs_attr3_rmt_hdr) : 0))
+unsigned int xfs_attr3_rmt_buf_space(struct xfs_mount *mp);
 
 /* Number of bytes in a directory block. */
 static inline unsigned int xfs_dir2_dirblock_bytes(struct xfs_sb *sbp)


