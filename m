Return-Path: <linux-fsdevel+bounces-14593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7420D87DE7D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4E528157C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1281CD29;
	Sun, 17 Mar 2024 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwIwpuhY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3584A20334;
	Sun, 17 Mar 2024 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692855; cv=none; b=kVahut/qJ9A2goXz0mahGeCMgHUVv3p5lXnGAAZwHIVD4AMzy46zLnBs2qdkp+24efj+SPgUZuw47gqoIISsM/D2opFUrOBPvr5hCkMb1OS99mKglA/ESHkN4Hwh+qbVntKK7YtkCmJNVT6xbBcGTlGNalgF5YRpSP5XTAn52BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692855; c=relaxed/simple;
	bh=c1vdnxhyPun7CrTbGxk929f0S+WGN8I99JUAs57DDe8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRX8zyZGHaln0fVHEDufyfguGVBe7D5Mm3UUuj/jGYT6gWQ75geyeqxJAoHlcj+n/FjZVehMri2KAArryZ2Lj5lAZrkqLhblnq+uCpErdmKpiYOFTJXG32IwMryZdgyx3onDN5iauhGGrNYj0U4+xOYnVrsoU/1wMPqXAsnfi+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwIwpuhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2575C433C7;
	Sun, 17 Mar 2024 16:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692854;
	bh=c1vdnxhyPun7CrTbGxk929f0S+WGN8I99JUAs57DDe8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=iwIwpuhYCNW0cTGfBRYHqRxVJgbpCib7S7bdYEyl8fR9Ra+F3UtE6cVClrIDDcrdi
	 JbNUp1n7gbSzrY0rcvSGT+T7fB6J94CIba88QELKmp0wX4sy1vNT6Ag9xpKhOpZo2s
	 skR7D2BIO9vcuekBYmsRBL5CO55ne+C9Wn48MGb1QnollrDW3swaxjer6/h59A5Vb9
	 4tJlgjqvCXQMVJdO1i9U7xRym+S89F6rsn97m2Fm13bVvB5cp/CwY5YWtByiFnukdT
	 igKiTwXhoJtVyG5yLFdl41h0StGOclbQZ+FuDO/NFRHmDdebvE+nhu/EvZmCKp1gZj
	 VZA+gH0VH/cCQ==
Date: Sun, 17 Mar 2024 09:27:34 -0700
Subject: [PATCH 16/40] fsverity: pass the zero-hash value to the
 implementation
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246170.2684506.16175333193381403848.stgit@frogsfrogsfrogs>
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
index 8dcfefc848ee..06b769dd1bdf 100644
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
index de8798f141d4..195a92f203bb 100644
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
index 7a86407732c4..433a70eeca55 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -144,6 +144,13 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 		goto out_err;
 	}
 
+	err = fsverity_hash_buffer(params->hash_alg, page_address(ZERO_PAGE(0)),
+				   i_blocksize(inode), params->zero_digest);
+	if (err) {
+		fsverity_err(inode, "Error %d computing zero digest", err);
+		goto out_err;
+	}
+
 	params->tree_size = offset << log_blocksize;
 	params->tree_pages = PAGE_ALIGN(params->tree_size) >> PAGE_SHIFT;
 	return 0;
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index a61d1c99c485..494225f60608 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -409,6 +409,8 @@ int fsverity_read_merkle_tree_block(struct inode *inode,
 			.num_levels = params->num_levels,
 			.log_blocksize = params->log_blocksize,
 			.ra_bytes = ra_bytes,
+			.zero_digest = params->zero_digest,
+			.digest_size = params->digest_size,
 		};
 		block->verified = false;
 
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 0dded1fcf2b1..da23f1e30151 100644
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


