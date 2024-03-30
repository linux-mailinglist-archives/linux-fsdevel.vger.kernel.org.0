Return-Path: <linux-fsdevel+bounces-15712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83261892833
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF37282794
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872301C3E;
	Sat, 30 Mar 2024 00:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/xOxpsV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E182D1851;
	Sat, 30 Mar 2024 00:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758918; cv=none; b=SgukJtoDGzMNQHK+MaT/vjNd5AApvUCMnHYQrOzxBtssYJgBmMB9aPPPmrg26B7/OeYoNFLUSHCF4c+sjPpiHzxfnvthcBQqHZnFDCAsuIpl5u5If9jJRHpVaFlW+LfbsOC+16mjS379s0o6hvJqpgmMBIwosD6uQKCYZfYxsbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758918; c=relaxed/simple;
	bh=JeF+X032QIcM21G487GLEHpX9s+Vv8monq2RZjFwvKM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0R8ihKQBnbvo6xbbWLo5EoCk81OWIzf80NJJcHGeBwmf4+1fJmNQncNTURC9mfJT81hp01Ss5/R+xkjjyoDbtRgWADRiZIS0VisnvPlkyAeSVIkg/iMYgB0GkS1ym55DFf5xk8/354p9uJv0Boo6o0Ds2kAFzaJ2KkDtHQUZTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/xOxpsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F82BC433C7;
	Sat, 30 Mar 2024 00:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711758917;
	bh=JeF+X032QIcM21G487GLEHpX9s+Vv8monq2RZjFwvKM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=s/xOxpsV882/bXluuO/My2TEqaApV/F2m4gbdJLJ96arW1okxT1DgJryzg/JcVzvu
	 sD5esQZ0QynFrxe2ynVsgp+T64dvy5WFWqXv3STg0UdtqcTMSCT8bEu+djWmM6xw9l
	 wY3H97Ts2vRVGA5Ing1zIxym4KCxweZ4fc8mA1AcawMe6KEwRcczvx/Mm2u987gEdF
	 yb6vt66LKi7o6Amvk3KKNgCcmDM9ueZ1Yehl6lbj8UNAIb7bEXD+LflcaeRhfYPHdh
	 94knypqJOqK7+mHdVTQ9ROtTgdR2S978+WB0scYCtRQ/Cix1bz1gi509tHa65A9jdb
	 prRCtit8dR0Gw==
Date: Fri, 29 Mar 2024 17:35:17 -0700
Subject: [PATCH 10/13] fsverity: pass the zero-hash value to the
 implementation
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868031.1987804.13138670908694064691.stgit@frogsfrogsfrogs>
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

Compute the hash of a data block full of zeros, and then supply this to
the merkle tree read and write methods.  A subsequent xfs patch will use
this to reduce the size of the merkle tree when dealing with sparse gold
master disk images and the like.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/verity/enable.c           |    2 ++
 fs/verity/fsverity_private.h |    2 ++
 fs/verity/open.c             |    7 +++++++
 fs/verity/verify.c           |    2 ++
 include/linux/fsverity.h     |    8 ++++++++
 5 files changed, 21 insertions(+)


diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 233b20fb12ff5..8c6fe4b72b14e 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -52,6 +52,8 @@ static int write_merkle_tree_block(struct inode *inode, const u8 *buf,
 {
 	struct fsverity_writemerkle req = {
 		.inode = inode,
+		.zero_digest = params->zero_digest,
+		.digest_size = params->digest_size,
 	};
 	u64 pos = (u64)index << params->log_blocksize;
 	int err;
diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index de8798f141d4a..195a92f203bba 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -47,6 +47,8 @@ struct merkle_tree_params {
 	u64 tree_size;			/* Merkle tree size in bytes */
 	unsigned long tree_pages;	/* Merkle tree size in pages */
 
+	u8 zero_digest[FS_VERITY_MAX_DIGEST_SIZE]; /* hash of zeroed data block */
+
 	/*
 	 * Starting block index for each tree level, ordered from leaf level (0)
 	 * to root level ('num_levels - 1')
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 7a86407732c41..cdf694a261605 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -144,6 +144,13 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 		goto out_err;
 	}
 
+	err = fsverity_hash_block(params, inode, page_address(ZERO_PAGE(0)),
+				   params->zero_digest);
+	if (err) {
+		fsverity_err(inode, "Error %d computing zero digest", err);
+		goto out_err;
+	}
+
 	params->tree_size = offset << log_blocksize;
 	params->tree_pages = PAGE_ALIGN(params->tree_size) >> PAGE_SHIFT;
 	return 0;
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index c4ebf85ba2c79..99b1529bbb50b 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -432,6 +432,8 @@ int fsverity_read_merkle_tree_block(struct inode *inode,
 			.num_levels = params->num_levels,
 			.log_blocksize = params->log_blocksize,
 			.ra_bytes = ra_bytes,
+			.zero_digest = params->zero_digest,
+			.digest_size = params->digest_size,
 		};
 
 		block->verified = false;
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 5dacd30d65353..761a0b76eefec 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -66,6 +66,8 @@ struct fsverity_blockbuf {
  *		if the page at @block->offset isn't already cached.
  *		Implementations may ignore this argument; it's only a
  *		performance optimization.
+ * @zero_digest: the hash for a data block of zeroes
+ * @digest_size: size of zero_digest
  */
 struct fsverity_readmerkle {
 	struct inode *inode;
@@ -73,6 +75,8 @@ struct fsverity_readmerkle {
 	int level;
 	int num_levels;
 	u8 log_blocksize;
+	const u8 *zero_digest;
+	unsigned int digest_size;
 };
 
 /**
@@ -81,12 +85,16 @@ struct fsverity_readmerkle {
  * @level: level of the block; level 0 are the leaves
  * @num_levels: number of levels in the tree total
  * @log_blocksize: log2 of the size of the block
+ * @zero_digest: the hash for a data block of zeroes
+ * @digest_size: size of zero_digest
  */
 struct fsverity_writemerkle {
 	struct inode *inode;
 	int level;
 	int num_levels;
 	u8 log_blocksize;
+	const u8 *zero_digest;
+	unsigned int digest_size;
 };
 
 /* Verity operations for filesystems */


