Return-Path: <linux-fsdevel+bounces-18233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BEB8B6881
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B637B2190E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC6A10799;
	Tue, 30 Apr 2024 03:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olINY9A3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7627F4EB;
	Tue, 30 Apr 2024 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447510; cv=none; b=jzsuiuGry/g5zr6u4KUaOezuYYAvpJyRRWkS1+i9iIcbvXlDlzWR4cGoCQEHcv+bsjaPj116c5LecPqKjFiZwxfY3uPXxhl12TFqVyDHyZ6Ns1ZPanmURzbdwBdyLhvGZ1bwEk8G5Lk5w2HDd8ZTT/blD1kkgMYRhqTIY4W6wiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447510; c=relaxed/simple;
	bh=IhEEb+44aavBeVYUEr2VfhO+8qPPbT1Po9wyWcBXCKU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kneonoSc8KbQsnd10db/20NX5M2o3aAJc/3x3mNHCI6PzvgOZkLq8Nrp/yIsgJe32ZPyvWvjmbUW4Z6sq6WMQ3wFs2rKBlgxhycj21NCm/EmuxMc85iU2osI2iyS9FdBdM3FentxFiqKj0ifFHJEcm6QTPzuu57UW7ltgceUSjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olINY9A3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D601C116B1;
	Tue, 30 Apr 2024 03:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447509;
	bh=IhEEb+44aavBeVYUEr2VfhO+8qPPbT1Po9wyWcBXCKU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=olINY9A3ZZradGROe8jiwZP8h3vawkb0of8TqLmkihLmAMGlCtS32qU+Mi6efLVFa
	 fHK8Q9mX9TKw5xx7SLHwRICa5AX4y0WIyXKs8O0TbRuMZrShbzosl2euNAngOf7TLk
	 6xzSUQNj/wIRaKrpvY/+l2STydFpu6Q9MRlYM8VxCTSbND+2iMquyVpjMp7J4mcYTI
	 REL/5g0kPMPfDmfXWNX+4ahbeYSKqrFZ+1yU+K6mUDI8KB3WPrD+1GdwwfE159VMlB
	 yAkxkPUaKO29sFfVb/jCucVVrIPylPM3p/Re3uAubzhPjX0WIEf9366Nyg0r+58Gws
	 AwkHnYy3qM6OQ==
Date: Mon, 29 Apr 2024 20:25:08 -0700
Subject: [PATCH 04/26] xfs: minor cleanups of xfs_attr3_rmt_blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680429.957659.11765566491777130541.stgit@frogsfrogsfrogs>
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

Clean up the type signature of this function since we don't have
negative attr lengths or block counts.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_attr_remote.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index 626fb92d30296..0566733b6da45 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -56,19 +56,19 @@ xfs_attr3_rmt_buf_space(
 	return blocksize;
 }
 
-/*
- * Each contiguous block has a header, so it is not just a simple attribute
- * length to FSB conversion.
- */
+/* Compute number of fsblocks needed to store a remote attr value */
 unsigned int
 xfs_attr3_rmt_blocks(
 	struct xfs_mount	*mp,
 	unsigned int		attrlen)
 {
-	if (xfs_has_crc(mp)) {
-		unsigned int buflen = xfs_attr3_rmt_buf_space(mp);
-		return (attrlen + buflen - 1) / buflen;
-	}
+	/*
+	 * Each contiguous block has a header, so it is not just a simple
+	 * attribute length to FSB conversion.
+	 */
+	if (xfs_has_crc(mp))
+		return howmany(attrlen, xfs_attr3_rmt_buf_space(mp));
+
 	return XFS_B_TO_FSB(mp, attrlen);
 }
 


