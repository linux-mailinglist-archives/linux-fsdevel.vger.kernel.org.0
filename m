Return-Path: <linux-fsdevel+bounces-14348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4779587B0B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB44A1F248CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB755A4D8;
	Wed, 13 Mar 2024 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2BhzbXA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115764D135;
	Wed, 13 Mar 2024 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352762; cv=none; b=cbkC9kNKI3suv5voo5OMFhUSn5Uy8tCmbJ8hkEoOuc+c1HSdacldDUmEYqTruWhCiq7MWLogecDEeRuCexSM6AS4k++L6ZAZIGlwx+4T/hKx34tboaK2ItTUTcTOS8RF24y/q6ztR9TSkaKi20XV9DPsS7TrgNAQsufi29w2bTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352762; c=relaxed/simple;
	bh=dZH6mab6ory8PxMFPpIIz5eqeCK/0qXhs2JYxBc+knc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFPe+vlBcd/d8Cwz4Yh2dJ3vImPznMxXAGtR3iRBtY8Qz3VtddA+NkNnba+ucDGwjXWZWcBhqJyss0yDhQJsjdf8xnHuy+XnPwYwHAo7xgzGcCxJ+qgdrT7Ami6EzLdRSTmJSMUr1PsaXbkrx9cY4K1clLY7HePNays2N0H4nD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2BhzbXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B909C433F1;
	Wed, 13 Mar 2024 17:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352761;
	bh=dZH6mab6ory8PxMFPpIIz5eqeCK/0qXhs2JYxBc+knc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=l2BhzbXAOSaKjbIzL2WynuZSP6EEIDMOJvkjtm39pY60n7XUTW5dvRaZ+7Z61iox/
	 u7AGobpLy+1GLgxaiHcTAhsw5NiqZp7G7bnS5IoUXG+QfGrTOCusKHr5FGg/+1/xj2
	 4yV1PDjZLSreaD8gKjux6yWnaE349TyaRemwTRuzEuGR4BDVKPVH9WTm4+q95mhfPo
	 2pvVzBYnllTQRw8Q8xOlrBWWupQmvzhvBNIawmGetqcMRBivnmN51iQmMohT1OPEJ6
	 UUaxtdS+YF2IJd4C7bt8hc6ydaxBnoxxooKPnBtbtvot4Sd+Wsy1GWc2p61K4AsrJ+
	 ES2vtZo5Byzlw==
Date: Wed, 13 Mar 2024 10:59:21 -0700
Subject: [PATCH 26/29] xfs: better reporting and error handling in
 xfs_drop_merkle_tree
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171035223773.2613863.987001035342644557.stgit@frogsfrogsfrogs>
In-Reply-To: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
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

xfs_drop_merkle_tree is responsible for removing the fsverity metadata
after a failed attempt to enable fsverity for a file.  However, if the
enablement process fails before the verity descriptor is written to the
file, the cleanup function will trip the WARN_ON.  The error code in
that case is ENOATTR, which isn't worth logging about.

Fix that return code handling, fix the tree block removal loop not to
return early with ENOATTR, and improve the logging so that we actually
capture what kind of error occurred.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_verity.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)


diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
index cfa50534bfc4..3dcc2af084fc 100644
--- a/fs/xfs/xfs_verity.c
+++ b/fs/xfs/xfs_verity.c
@@ -481,15 +481,14 @@ xfs_verity_begin_enable(
 			tree_blocksize);
 }
 
+/* Try to remove all the fsverity metadata after a failed enablement. */
 static int
-xfs_drop_merkle_tree(
+xfs_verity_drop_incomplete_tree(
 	struct xfs_inode		*ip,
 	u64				merkle_tree_size,
 	unsigned int			tree_blocksize)
 {
 	struct xfs_fsverity_merkle_key	name;
-	int				error = 0;
-	u64				offset = 0;
 	struct xfs_da_args		args = {
 		.dp			= ip,
 		.whichfork		= XFS_ATTR_FORK,
@@ -500,6 +499,8 @@ xfs_drop_merkle_tree(
 		/* NULL value make xfs_attr_set remove the attr */
 		.value			= NULL,
 	};
+	u64				offset;
+	int				error;
 
 	if (!merkle_tree_size)
 		return 0;
@@ -507,6 +508,8 @@ xfs_drop_merkle_tree(
 	for (offset = 0; offset < merkle_tree_size; offset += tree_blocksize) {
 		xfs_fsverity_merkle_key_to_disk(&name, offset);
 		error = xfs_attr_set(&args);
+		if (error == -ENOATTR)
+			error = 0;
 		if (error)
 			return error;
 	}
@@ -514,7 +517,8 @@ xfs_drop_merkle_tree(
 	args.name = (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME;
 	args.namelen = XFS_VERITY_DESCRIPTOR_NAME_LEN;
 	error = xfs_attr_set(&args);
-
+	if (error == -ENOATTR)
+		return 0;
 	return error;
 }
 
@@ -573,9 +577,16 @@ xfs_verity_end_enable(
 		inode->i_flags |= S_VERITY;
 
 out:
-	if (error)
-		WARN_ON_ONCE(xfs_drop_merkle_tree(ip, merkle_tree_size,
-						  tree_blocksize));
+	if (error) {
+		int	error2;
+
+		error2 = xfs_verity_drop_incomplete_tree(ip, merkle_tree_size,
+				tree_blocksize);
+		if (error2)
+			xfs_alert(ip->i_mount,
+ "ino 0x%llx failed to clean up new fsverity metadata, err %d",
+					ip->i_ino, error2);
+	}
 
 	xfs_iflags_clear(ip, XFS_VERITY_CONSTRUCTION);
 	return error;


