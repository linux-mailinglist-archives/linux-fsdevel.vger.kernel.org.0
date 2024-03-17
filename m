Return-Path: <linux-fsdevel+bounces-14590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0F987DE69
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD831F21BA7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904CE1CD13;
	Sun, 17 Mar 2024 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7JsmQ4N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF4D1CA96;
	Sun, 17 Mar 2024 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692808; cv=none; b=ZCG5ncbELTBdf9lwRZAspffmRmYKXswt+mU9OKc1196shy1fVIqbZ7R3CBzON4jbcIGXAPxeiG7lq4nXxySBlPjMp3/HngHnfCqqKhPM+6nHw5+bVMidyzRXNH4bGt4zhDSYcQoVVy+OOmoe/Vrq1mJW+oWoHR/Ic1ViMLVoTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692808; c=relaxed/simple;
	bh=f4vax+lrizWDzm1uCMSeA/R3941ZYwTYCDp1kZmtEIA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dejL24F1k5hz1/1dB9slQL7QlyC/pAjDiwvz8L07sxcb/9eQLgf1Ad+LXH261RqYdmTjUX6AKJfK68malHnFawHVeuQlXG7KwjUfQpB7CNaBSRZPCSTRG58ZhylLRFJkM2Mq9zcASpMIbU94snQWt9zfwPASM4mKKW4g0ghLbxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7JsmQ4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6530C433C7;
	Sun, 17 Mar 2024 16:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692807;
	bh=f4vax+lrizWDzm1uCMSeA/R3941ZYwTYCDp1kZmtEIA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=K7JsmQ4NpSiT/lX3EkzOsHb8jH5UWDacn+ehSkJLjYPLWmbZeguPYY384S00ngByV
	 APl8EmwRItB/ta67egBWckXRNqG3F23DszpKwqjvRg59EXg/Oaul1qDQeMiYQ4FuoE
	 knw4D6uJPewl+ozyAN20bTH4byWFAmHut5FA/pwxXZlkD9TCEqL1eqjazuWPINZgeY
	 52OeG1Run6Hg1xFGlj+NQTO3Obu4HbCLOUmg8TZk+gtFmi9+2XbuKvA5iEGCvb38on
	 Ss17C2YN/lpeMtkNlTyhgSXMPP81HJ/A1h9zGtONQvSfnxOMGwJXbOTUTj9NnY/4N/
	 7Viem1g+RUeQQ==
Date: Sun, 17 Mar 2024 09:26:47 -0700
Subject: [PATCH 13/40] fsverity: expose merkle tree geometry to callers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246123.2684506.17802014697868839609.stgit@frogsfrogsfrogs>
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

Create a function that will return selected information about the
geometry of the merkle tree.  Online fsck for XFS will need this piece
to perform basic checks of the merkle tree.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/verity/open.c         |   26 ++++++++++++++++++++++++++
 include/linux/fsverity.h |    3 +++
 2 files changed, 29 insertions(+)


diff --git a/fs/verity/open.c b/fs/verity/open.c
index 9603b3a404f7..7a86407732c4 100644
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
index c5f3564f2cb8..17bc0729119c 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -240,6 +240,9 @@ int __fsverity_file_open(struct inode *inode, struct file *filp);
 int __fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr);
 void __fsverity_cleanup_inode(struct inode *inode);
 
+int fsverity_merkle_tree_geometry(struct inode *inode, unsigned int *block_size,
+				  u64 *tree_size);
+
 /**
  * fsverity_cleanup_inode() - free the inode's verity info, if present
  * @inode: an inode being evicted


