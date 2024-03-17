Return-Path: <linux-fsdevel+bounces-14607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8941587DEA1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E97C3B20BDF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F5F4C84;
	Sun, 17 Mar 2024 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbaHRvSl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8471CD11;
	Sun, 17 Mar 2024 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693074; cv=none; b=nzUeEqyaHa8oPZbfI2HkUO2NPUnynBFOUKqZieyg71jk4yQ+/RgzyBpIocIzlpYjz5x+7DfglA/nacvuQnWRHWL9HFCMWmOH84H5fgQMzIDcGOo1Gfo3EpGOx59+HVjjZ86phzXTN20iOM6OHTqx6RTRFVoCL/TG+tGVH2GPGvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693074; c=relaxed/simple;
	bh=xXMKW41WqkCzoTjVEyZi8pdjn3znKDc09/ezHh58SNI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=objUQ1PQLOLXK8C4Bq3eWQwKw1dXdBeAMIyWuCA45Q4YH2ffa9QQ2A5buDlrcDC4DGvMNhtu4t6sUwCIQJ+zisaCBlZR0RDnTUEfA8IeFhY4Hp+1MAFe7q9NHufhkrCoJylleZpxr0LGP2DydRiFvR9u9TllVSaCNheCoZAjIf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbaHRvSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C490CC433C7;
	Sun, 17 Mar 2024 16:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693073;
	bh=xXMKW41WqkCzoTjVEyZi8pdjn3znKDc09/ezHh58SNI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FbaHRvSl34yOjqsf8iWA5aEvhNbaHUKL89zSiCK69A5t7+wBKVQmjtjxAXLFrRcZq
	 owiGEr+/OqNaieM75fHn79E/zmGkGEl1DdsGyeoyp+0Sv3o2C5lYGuhdCZd9PHRz4X
	 n4GjiQyn/kqdmc+V4UiLWRfHW+xhD9NZNhBKQ1DicLUxETjMhUilStlfl4f+u5z2Ow
	 ST5iJEPaEyK5bvWRhOrREzWj+5KLBsl5JJtOdXIPmJRM5kz9ipXr8hxgLQ+IkFeLwS
	 slGvaCMpso7IdexDnL/Nc7i9AXGppxLW/koAGcEcWtZZdXpKYE38wUKHlWecuuYZXa
	 jjCmHvHH7KgCw==
Date: Sun, 17 Mar 2024 09:31:13 -0700
Subject: [PATCH 30/40] xfs: clean up stale fsverity metadata before starting
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246392.2684506.14484170564314714404.stgit@frogsfrogsfrogs>
In-Reply-To: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
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

Before we let fsverity begin writing merkle tree blocks to the file,
let's perform a minor effort to clean up any stale metadata from a
previous attempt to enable fsverity.  This can only happen if the system
crashes /and/ the file shrinks, which is unlikely.  But we could do a
better job of cleaning up anyway.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_verity.c |   42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)


diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
index c19fa47d1f76..db43e017f10e 100644
--- a/fs/xfs/xfs_verity.c
+++ b/fs/xfs/xfs_verity.c
@@ -413,6 +413,44 @@ xfs_verity_get_descriptor(
 	return args.valuelen;
 }
 
+/*
+ * Clear out old fsverity metadata before we start building a new one.  This
+ * could happen if, say, we crashed while building fsverity data.
+ */
+static int
+xfs_verity_drop_old_metadata(
+	struct xfs_inode		*ip,
+	u64				new_tree_size,
+	unsigned int			tree_blocksize)
+{
+	struct xfs_verity_merkle_key	name;
+	struct xfs_da_args		args = {
+		.dp			= ip,
+		.whichfork		= XFS_ATTR_FORK,
+		.attr_filter		= XFS_ATTR_VERITY,
+		.op_flags		= XFS_DA_OP_REMOVE,
+		.name			= (const uint8_t *)&name,
+		.namelen		= sizeof(struct xfs_verity_merkle_key),
+		/* NULL value make xfs_attr_set remove the attr */
+		.value			= NULL,
+	};
+	u64				offset;
+	int				error = 0;
+
+	/*
+	 * Delete as many merkle tree blocks in increasing blkno order until we
+	 * don't find any more.  That ought to be good enough for avoiding
+	 * dead bloat without excessive runtime.
+	 */
+	for (offset = new_tree_size; !error; offset += tree_blocksize) {
+		xfs_verity_merkle_key_to_disk(&name, offset);
+		error = xfs_attr_set(&args);
+	}
+	if (error == -ENOATTR)
+		return 0;
+	return error;
+}
+
 static int
 xfs_verity_begin_enable(
 	struct file		*filp,
@@ -421,7 +459,6 @@ xfs_verity_begin_enable(
 {
 	struct inode		*inode = file_inode(filp);
 	struct xfs_inode	*ip = XFS_I(inode);
-	int			error = 0;
 
 	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
 
@@ -431,7 +468,8 @@ xfs_verity_begin_enable(
 	if (xfs_iflags_test_and_set(ip, XFS_VERITY_CONSTRUCTION))
 		return -EBUSY;
 
-	return error;
+	return xfs_verity_drop_old_metadata(ip, merkle_tree_size,
+			tree_blocksize);
 }
 
 static int


