Return-Path: <linux-fsdevel+bounces-18231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C24A8B687C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C166E1F22665
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F121094E;
	Tue, 30 Apr 2024 03:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmkyrO8n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0D0F4EB;
	Tue, 30 Apr 2024 03:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447478; cv=none; b=Cl1FRfHEUO/ecMQaq/jidl/KXWXlIlKhHbw6vrdaa5HWcejOw7t83Fp6vD/uKnToKFiZ28uipluSKe1AwXUj141lf7pavwmWtk3al6dWFxA6VxyoYb2te9ZXwgjfzZmbWsD5rR++iaSAth4qjlz9y5TwuStn6bla7gtWFO+2pgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447478; c=relaxed/simple;
	bh=/cPAKbBJYVuUQwTrPKCf3O6gWqbA/S8VlPTmX6vOkxg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnOAMdOb+iJXELzUMZrzqkYyHws5mgJbK0NuZ31q6txp/wgim17BXP3kYSxKHihiG+Y3l+7T1NEp2UBvuOb8rqK80xQzSYblpW4hv9a4kT393aBOwzCaY1mzJTtS/WXSY9ySfIjn1EFn1YAw4nSnzN4VOTVi/hCnbSY0r7Npu+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmkyrO8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F14C116B1;
	Tue, 30 Apr 2024 03:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447478;
	bh=/cPAKbBJYVuUQwTrPKCf3O6gWqbA/S8VlPTmX6vOkxg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hmkyrO8n3hGAiUan4bNbqYdJ4SMwMIjXd2pLRZXDVY8saWuTsLS+sTXXBIZaABUkj
	 G8kii2OCKWjKIRbZJYogcyZyRhjC4Uj1RjEQdbOHvrAfeijigFtAjcxhIpBOF3330/
	 nTTMLCqkt5IMEBk+3xl0LhZbqZJ2EysLH7M3xldfel3sbk35Mkv2qNFJ5Kgk+yKeUx
	 vFipoBwwcrmrhaWQfGxv/FrVb6exLfjhFV3AJ//VGkchu3wNxd5/qb6kUyjvY2lIQC
	 uIKQF5hV/YaAebxRHDpHLGB/yp1dO8obsjrp9IcLWH8XbNe1ZwkbRF9vLaReyMW7la
	 uHqq3GZ7WctlQ==
Date: Mon, 29 Apr 2024 20:24:37 -0700
Subject: [PATCH 02/26] xfs: turn XFS_ATTR3_RMT_BUF_SPACE into a function
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680395.957659.3370622609053473856.stgit@frogsfrogsfrogs>
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

Turn this into a properly typechecked function, and actually use the
correct blocksize for extended attributes.  The function cannot be
static inline because xfsprogs userspace uses it.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_attr_remote.c |   19 ++++++++++++++++---
 fs/xfs/libxfs/xfs_da_format.h   |    4 +---
 2 files changed, 17 insertions(+), 6 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index 1d44ab3e0a506..626fb92d30296 100644
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
@@ -293,7 +306,7 @@ xfs_attr_rmtval_copyout(
 
 	while (len > 0 && *valuelen > 0) {
 		unsigned int hdr_size = 0;
-		unsigned int byte_cnt = XFS_ATTR3_RMT_BUF_SPACE(mp, blksize);
+		unsigned int byte_cnt = xfs_attr3_rmt_buf_space(mp);
 
 		byte_cnt = min(*valuelen, byte_cnt);
 
@@ -342,7 +355,7 @@ xfs_attr_rmtval_copyin(
 
 	while (len > 0 && *valuelen > 0) {
 		unsigned int hdr_size;
-		unsigned int byte_cnt = XFS_ATTR3_RMT_BUF_SPACE(mp, blksize);
+		unsigned int byte_cnt = xfs_attr3_rmt_buf_space(mp);
 
 		byte_cnt = min(*valuelen, byte_cnt);
 		hdr_size = xfs_attr3_rmt_hdr_set(mp, dst, ino, *offset,
diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index ebde6eb1da65d..86de99e2f7570 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -880,9 +880,7 @@ struct xfs_attr3_rmt_hdr {
 
 #define XFS_ATTR3_RMT_CRC_OFF	offsetof(struct xfs_attr3_rmt_hdr, rm_crc)
 
-#define XFS_ATTR3_RMT_BUF_SPACE(mp, bufsize)	\
-	((bufsize) - (xfs_has_crc((mp)) ? \
-			sizeof(struct xfs_attr3_rmt_hdr) : 0))
+unsigned int xfs_attr3_rmt_buf_space(struct xfs_mount *mp);
 
 /* Number of bytes in a directory block. */
 static inline unsigned int xfs_dir2_dirblock_bytes(struct xfs_sb *sbp)


