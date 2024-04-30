Return-Path: <linux-fsdevel+bounces-18220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0868B685E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACB91C210E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493BCFC02;
	Tue, 30 Apr 2024 03:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvyi1OSi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F210965;
	Tue, 30 Apr 2024 03:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447307; cv=none; b=nk/G52bhTtss3y5vP6ZLoMEHcfAP34ULcppE4n+sF9vJkEEXKEh1Vln8Xmtp96VsFc3xlgNMZj/UQHuSq4O1pCOZVaIfOhv60jhVtBpyu3xOZbnygtCCmW/MT55bxyECBINWJ6DMC9wiDnD7ETqETroNdZ8n3Sl5jNAXysiXgoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447307; c=relaxed/simple;
	bh=Hhy5ojl7CO/xI4mGmWOgc7QlqdMpzX2ltRaghtMw6wQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHUn+HVoBvzCsJdRKaJoAkqzVNWtsnJNAGgnQaBqMFg71RotMSRnaRd3zHKQFpGp+/VDfVHyT5wGlxuW7LSMK0cRXY/BneiP8eF5nCCpNe/wtYSHRkIwZnR+nao9DF1174km6jCTzAl8VLlScWs1BJ3T5h2a0wDk1uyQgQPF2OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvyi1OSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C89C116B1;
	Tue, 30 Apr 2024 03:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447306;
	bh=Hhy5ojl7CO/xI4mGmWOgc7QlqdMpzX2ltRaghtMw6wQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tvyi1OSiiX6MhzZF5ksB5sNN+qeGnC5Cr9Jrg2/sSZSG9/MsDWODbqzhkPTYlowVA
	 7qvukux4ikecPpyediHfFhWQ8Azs3rdiWOYdUZz5E+9o7bb2C4aoJIOd4CVw119Ceh
	 vxpFweib7uBf/eMqsBQs7Ge3djQqqe/cjShZlGOc3ButPBMcA27s8aor8ru6/cEPs9
	 CudOty8XJX4e9HxSbkOhjRlXyieV1lXSRmU9Ku42rjLS30yWt5SWSEte7+qDdWd3cC
	 BAQNN/xxFynEYchuiNP1PpLsKGMR5Gjf5sEbfCwMutaQ9exbtg2M173aXP1/7D76yM
	 Ld/EpprHEXVqQ==
Date: Mon, 29 Apr 2024 20:21:45 -0700
Subject: [PATCH 09/18] fsverity: expose merkle tree geometry to callers
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444679743.955480.15973526839381497958.stgit@frogsfrogsfrogs>
In-Reply-To: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
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
 fs/verity/open.c         |   32 ++++++++++++++++++++++++++++++++
 include/linux/fsverity.h |   10 ++++++++++
 2 files changed, 42 insertions(+)


diff --git a/fs/verity/open.c b/fs/verity/open.c
index 4777130322866..aa71a4d3cbff1 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -427,6 +427,38 @@ void __fsverity_cleanup_inode(struct inode *inode)
 }
 EXPORT_SYMBOL_GPL(__fsverity_cleanup_inode);
 
+/**
+ * fsverity_merkle_tree_geometry() - return Merkle tree geometry
+ * @inode: the inode to query
+ * @block_size: will be set to the size of a merkle tree block, in bytes
+ * @tree_size: will be set to the size of the merkle tree, in bytes
+ *
+ * Callers are not required to have opened the file.
+ *
+ * Return: 0 for success, -ENODATA if verity is not enabled, or any of the
+ * error codes that can result from loading verity information while opening a
+ * file.
+ */
+int fsverity_merkle_tree_geometry(struct inode *inode, unsigned int *block_size,
+				  u64 *tree_size)
+{
+	struct fsverity_info *vi;
+	int error;
+
+	if (!IS_VERITY(inode))
+		return -ENODATA;
+
+	error = ensure_verity_info(inode);
+	if (error)
+		return error;
+
+	vi = inode->i_verity_info;
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
index 7c51d7cf835ec..a3a5b68bed0d3 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -243,6 +243,9 @@ int __fsverity_file_open(struct inode *inode, struct file *filp);
 int __fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr);
 void __fsverity_cleanup_inode(struct inode *inode);
 
+int fsverity_merkle_tree_geometry(struct inode *inode, unsigned int *block_size,
+				  u64 *tree_size);
+
 /**
  * fsverity_cleanup_inode() - free the inode's verity info, if present
  * @inode: an inode being evicted
@@ -326,6 +329,13 @@ static inline void fsverity_cleanup_inode(struct inode *inode)
 {
 }
 
+static inline int fsverity_merkle_tree_geometry(struct inode *inode,
+						unsigned int *block_size,
+						u64 *tree_size)
+{
+	return -EOPNOTSUPP;
+}
+
 /* read_metadata.c */
 
 static inline int fsverity_ioctl_read_metadata(struct file *filp,


