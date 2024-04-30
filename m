Return-Path: <linux-fsdevel+bounces-18286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01F38B690B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1A81C21D26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0270610A3E;
	Tue, 30 Apr 2024 03:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qc46nFgG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B66410799;
	Tue, 30 Apr 2024 03:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448323; cv=none; b=jfdd0T/D+P80OcyrgEJWGiU5mp1w5DnicVsfWBKiWN6bb9W/j/LgUjuABwcXPhID6G7scIo/92f++JW6BMhXPQ1ND/fmIDKwdi368rsJG9iypgxoYK+bHoYEU99GWfGN/InwMb1NTvujvPQ/ocu7+j8JG8256OtryPRcBxq/Ab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448323; c=relaxed/simple;
	bh=dR/W6WzKRI+ml7jGuTYXn0rHKLmrO3zSmalDGWazBaI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxOLkM066J2aZZyD/lVB+nhmZaH3T2W7DIzJZzm0YWS6/m/uI/aD3/kIyCvmWZzL/OM+THv1TIPbukNU+H2Hn8w+3JKQjHXPixEa/xYZlZZ/geQQomYa/+wsZe5SSKtDTvUnAWVJsX0aI2SKMsF74B33l8fFrmffCh9WuESwbMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qc46nFgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D603C116B1;
	Tue, 30 Apr 2024 03:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448323;
	bh=dR/W6WzKRI+ml7jGuTYXn0rHKLmrO3zSmalDGWazBaI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qc46nFgGWzCMExtT/Xk2cF8/lD1vtCdzPwkEN2cgL3ZSCpBWlqJ6xXQTcpa2tHMAG
	 vZaDa2FAcpw7LcxH3b5i7ZouPuNNwE3GsIy040RD3flrbbXS1bNDzTep2h6VVRVYWV
	 eyLmJO+ysnOPc+vslZY4+QksPsD+ZPX/SPmODz4EIixtfZ9xW/kunumITN6iU+QaAA
	 imbJdYxKkjY5U2gJNiBNadXU2fSRwwJr+TsxeqG+KjCnmJRVPYe7dXXUiS0NWhLK8D
	 TJZB5FOCLuTthpE/Bj3YYQ1tFwcA+ZBJ5Et2wIgNeyJY/cdspx8+t7b5QPrVfwPkth
	 CycmBPNUQ3yvQ==
Date: Mon, 29 Apr 2024 20:38:42 -0700
Subject: [PATCH 30/38] xfs_repair: handle verity remote attrs
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683571.960383.7291165413166367611.stgit@frogsfrogsfrogs>
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

Teach xfs_repair to handle remote verity xattr values.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 repair/attr_repair.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)


diff --git a/repair/attr_repair.c b/repair/attr_repair.c
index 898eb3edfd12..2d0df492f71a 100644
--- a/repair/attr_repair.c
+++ b/repair/attr_repair.c
@@ -428,8 +428,14 @@ process_shortform_attr(
  * many blocks per remote value, so one by one is sufficient.
  */
 static int
-rmtval_get(xfs_mount_t *mp, xfs_ino_t ino, blkmap_t *blkmap,
-		xfs_dablk_t blocknum, int valuelen, char* value)
+rmtval_get(
+	struct xfs_mount	*mp,
+	xfs_ino_t		ino,
+	unsigned int		attrns,
+	blkmap_t		*blkmap,
+	xfs_dablk_t		blocknum,
+	int			valuelen,
+	char*			value)
 {
 	xfs_fsblock_t	bno;
 	struct xfs_buf	*bp;
@@ -437,12 +443,14 @@ rmtval_get(xfs_mount_t *mp, xfs_ino_t ino, blkmap_t *blkmap,
 	int		hdrsize = 0;
 	int		error;
 
-	if (xfs_has_crc(mp))
+	if (xfs_has_crc(mp) && !(attrns & XFS_ATTR_VERITY))
 		hdrsize = sizeof(struct xfs_attr3_rmt_hdr);
 
 	/* ASSUMPTION: valuelen is a valid number, so use it for looping */
 	/* Note that valuelen is not a multiple of blocksize */
 	while (amountdone < valuelen) {
+		const struct xfs_buf_ops	*ops;
+
 		bno = blkmap_get(blkmap, blocknum + i);
 		if (bno == NULLFSBLOCK) {
 			do_warn(
@@ -450,9 +458,11 @@ rmtval_get(xfs_mount_t *mp, xfs_ino_t ino, blkmap_t *blkmap,
 			clearit = 1;
 			break;
 		}
+
+		ops = libxfs_attr3_remote_buf_ops(attrns);
 		error = -libxfs_buf_read(mp->m_dev, XFS_FSB_TO_DADDR(mp, bno),
 				XFS_FSB_TO_BB(mp, 1), LIBXFS_READBUF_SALVAGE,
-				&bp, &xfs_attr3_rmt_buf_ops);
+				&bp, ops);
 		if (error) {
 			do_warn(
 	_("can't read remote block for attributes of inode %" PRIu64 "\n"), ino);
@@ -623,7 +633,8 @@ process_leaf_attr_remote(
 		do_warn(_("SKIPPING this remote attribute\n"));
 		goto out;
 	}
-	if (rmtval_get(mp, ino, blkmap, be32_to_cpu(remotep->valueblk),
+	if (rmtval_get(mp, ino, entry->flags, blkmap,
+				be32_to_cpu(remotep->valueblk),
 				be32_to_cpu(remotep->valuelen), value)) {
 		do_warn(
 	_("remote attribute get failed for entry %d, inode %" PRIu64 "\n"),


