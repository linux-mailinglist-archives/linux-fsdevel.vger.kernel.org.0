Return-Path: <linux-fsdevel+bounces-15726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FDE892852
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F9B282B11
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD321366;
	Sat, 30 Mar 2024 00:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSX4fCLV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046907E2;
	Sat, 30 Mar 2024 00:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759137; cv=none; b=NiFJNBf4sua1AH0rDqaT2TO2xTSmRn6YSXKeULTgucm+h4rlqYLdV0k3zEF8wTtY/6nHCg6MCbVDdqdfjUhJp/I2VMK56YNjNoQYF7GEDfX9+nS8ShDYVpk3gDzcbmKimvsY8MruhlmwAg+/FIHqjVjd4+ce2cn444BrjToM7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759137; c=relaxed/simple;
	bh=ey0KUjuz7Xmh/qMBDMujjHJjpV6GK82pFy7pVs2SohQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYdDR8RrlE7ZDcOu7hZN/LRhElsZjS2EG4VwToroQ0FlGxFrgZTundM95+vJ22OFTQxsLJXP0I23JJVOlU5D1oJBkGP9sBJaoeb4kTf9ALaoBRrzuuRbHnTJCEMUIprzi0hXgelq+Jo9Kao/uEkg0W53Jg3DY+l3K2Qj5KqrKqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSX4fCLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E45DC433C7;
	Sat, 30 Mar 2024 00:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759136;
	bh=ey0KUjuz7Xmh/qMBDMujjHJjpV6GK82pFy7pVs2SohQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HSX4fCLVoykez7S7Ia1fZD0njmnC6uR3OMXVj0Fe1YzE8c6XDbEIJOgJ2cZwHmuEk
	 e5wa9O7qPjAmsOx9Gn4wcXzaDT+wVLiU7h+R3omgp7j4k9xOQl3p15sllE28+sBNQV
	 CTwH5YdIWUeYJH+w1Q0R/A9NHrmAGANuYOOULaH++6ggK4a9FwV2FtRmhPPgA7nvfP
	 ZP1Jnco9g+r437CS5jvNJ4Tts65AErDJSrLWvsn1dkF/4XOqT7cu/geWayiFhjiwWD
	 GolKkjCyiH4kom8z5FF9wJ/zp0kMe167Gqv19NypX/ykWpab8le7Ko13fb5yjMdxoJ
	 pPu7zDrKTYWtA==
Date: Fri, 29 Mar 2024 17:38:56 -0700
Subject: [PATCH 11/29] xfs: disable direct read path for fs-verity files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868742.1988170.15821960950064889556.stgit@frogsfrogsfrogs>
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

From: Andrey Albershteyn <aalbersh@redhat.com>

The direct path is not supported on verity files. Attempts to use direct
I/O path on such files should fall back to buffered I/O path.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: fix braces]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index ce57f5007308a..c0b3e8146b753 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -268,7 +268,8 @@ xfs_file_dax_read(
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
-	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
+	struct inode		*inode = iocb->ki_filp->f_mapping->host;
+	struct xfs_inode	*ip = XFS_I(inode);
 	ssize_t			ret = 0;
 
 	trace_xfs_file_dax_read(iocb, to);
@@ -321,10 +322,18 @@ xfs_file_read_iter(
 
 	if (IS_DAX(inode))
 		ret = xfs_file_dax_read(iocb, to);
-	else if (iocb->ki_flags & IOCB_DIRECT)
+	else if ((iocb->ki_flags & IOCB_DIRECT) && !fsverity_active(inode))
 		ret = xfs_file_dio_read(iocb, to);
-	else
+	else {
+		/*
+		 * In case fs-verity is enabled, we also fallback to the
+		 * buffered read from the direct read path. Therefore,
+		 * IOCB_DIRECT is set and need to be cleared (see
+		 * generic_file_read_iter())
+		 */
+		iocb->ki_flags &= ~IOCB_DIRECT;
 		ret = xfs_file_buffered_read(iocb, to);
+	}
 
 	if (ret > 0)
 		XFS_STATS_ADD(mp, xs_read_bytes, ret);


