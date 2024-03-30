Return-Path: <linux-fsdevel+bounces-15710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB83189282F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BC00B21583
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A82B15A5;
	Sat, 30 Mar 2024 00:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZoOkeYx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A3A7E2;
	Sat, 30 Mar 2024 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758886; cv=none; b=pvLeIFrZAiNBs7GsmRHjqGU/x5LakqdFGW+vLhKSkAhyKAOJ3bM5Ron5OhXRMQq+KwycDiMQz8k2aoPIgESch1Fc8n7jOQB2Ko2MuRTdwt0RYyoJxj/dwwll6HGjyaZxGmHkAIAkW99R0Cd3WVozdH1fv/wLnd9CrBlQCmqdVNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758886; c=relaxed/simple;
	bh=xxo5EvCmfH/v7ww4RgxdwOktYkge9I8zSgMzTqpjYP8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcB5bGQoDAOiIEAfJgztJM3LM9EVNtEGTOnqE44kBVqHw0+TCvr5JKATyT0sj1vTUISiCQbfVrMeVJHYrpJf5WlLqeNPjjuhxGyxi4gR0TJB+GrhboCL+EqD+qKcwcSQvgzKKbag/6PueydiYhtVUzKNHfS6Wtd2uAdV0Kne5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZoOkeYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446ADC43390;
	Sat, 30 Mar 2024 00:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711758886;
	bh=xxo5EvCmfH/v7ww4RgxdwOktYkge9I8zSgMzTqpjYP8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tZoOkeYxPLPwBnHe8xT0/+6r2niIFmFMzGUuKDjG0Q8z/bXpajG/0ppAL3Mju6EXv
	 OAWfxsw29fP0rhImvQWP7VmNu7iIH7VB44zPm403cU31Kt2q/b+HtNwN8kjIaKQIkC
	 ozRk65cndJ4HXtry2+iFJa/+zVu43D5HgFEOd9o2cZncYQfqUrKAMwaFSjS+st4NS9
	 X04h2gdpnFH+pS6eotxKFpCTj2gxRLqBbidAOvoJLbyh9ah/qUZAAjKxMn07BAkiPb
	 w07IM6fhIAvY4xHnBZGQJDhtDU4az6JhxXKgCfiYoIsRlwqjnapqsi/qYdrHUNjSqy
	 Bd6mTW0aKRC3A==
Date: Fri, 29 Mar 2024 17:34:45 -0700
Subject: [PATCH 08/13] fsverity: expose merkle tree geometry to callers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175867998.1987804.8334701724660862039.stgit@frogsfrogsfrogs>
In-Reply-To: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
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

Create a function that will return selected information about the
geometry of the merkle tree.  Online fsck for XFS will need this piece
to perform basic checks of the merkle tree.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/verity/open.c         |   26 ++++++++++++++++++++++++++
 include/linux/fsverity.h |    3 +++
 2 files changed, 29 insertions(+)


diff --git a/fs/verity/open.c b/fs/verity/open.c
index 9603b3a404f74..7a86407732c41 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -412,6 +412,32 @@ void __fsverity_cleanup_inode(struct inode *inode)
 }
 EXPORT_SYMBOL_GPL(__fsverity_cleanup_inode);
 
+/**
+ * fsverity_merkle_tree_geometry() - return Merkle tree geometry
+ * @inode: the inode for which the Merkle tree is being built
+ * @block_size: size of a merkle tree block, in bytes
+ * @tree_size: size of the merkle tree, in bytes
+ */
+int fsverity_merkle_tree_geometry(struct inode *inode, unsigned int *block_size,
+				  u64 *tree_size)
+{
+	struct fsverity_info *vi;
+	int error;
+
+	if (!IS_VERITY(inode))
+		return -EOPNOTSUPP;
+
+	error = ensure_verity_info(inode);
+	if (error)
+		return error;
+
+	vi = fsverity_get_info(inode);
+	*block_size = vi->tree_params.block_size;
+	*tree_size = vi->tree_params.tree_size;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fsverity_merkle_tree_geometry);
+
 void __init fsverity_init_info_cache(void)
 {
 	fsverity_info_cachep = KMEM_CACHE_USERCOPY(
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 030d7094d80fc..5b1485a842983 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -245,6 +245,9 @@ int __fsverity_file_open(struct inode *inode, struct file *filp);
 int __fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr);
 void __fsverity_cleanup_inode(struct inode *inode);
 
+int fsverity_merkle_tree_geometry(struct inode *inode, unsigned int *block_size,
+				  u64 *tree_size);
+
 /**
  * fsverity_cleanup_inode() - free the inode's verity info, if present
  * @inode: an inode being evicted


