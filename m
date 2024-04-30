Return-Path: <linux-fsdevel+bounces-18222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41978B6862
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BCE1F222B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EB3FC02;
	Tue, 30 Apr 2024 03:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYjDnW0s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919A0101C4;
	Tue, 30 Apr 2024 03:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447337; cv=none; b=LxFNoNiWqcA0NMDi/TB4rHXsUYV0SKeCJNlduBjkbB/N0jqZm9IxnzmYGfEE7iPqej1JaGwal/vSWMveWzwYfzOMcEjtKKZfAZ2bDHhOUO8d+oYslIjk++R1jaNDx4Mk34U2ZmdbDw/P5yGyr84Tz4xaGn6vx3tcdVRF6Az6Zg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447337; c=relaxed/simple;
	bh=xGaZw0bnx4vrlQuWe4AYGWcrOo3hueNEr1vu4JCST1Y=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJ5WBKgBRxAWfKhLFARi+8ywXxvWHdM0b+lqf6U0eymNAM7dG5wVbs3Fby95jgWBHSP+rYuILHVBXs/H2ygl6WoLSB5FT+T3yPqKufxit+euQ/cik8ZHDCIS3DnDmi8urmthHJ+hDooeiEarCzer4sSEKJX3bZZ3y/Aef6T527o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYjDnW0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66015C116B1;
	Tue, 30 Apr 2024 03:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447337;
	bh=xGaZw0bnx4vrlQuWe4AYGWcrOo3hueNEr1vu4JCST1Y=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NYjDnW0sssuwema2vg/STXgJ1JusbvObu5mcJb9lL1ssf0xu6WwPivYfeQjD9T9NO
	 nyAIyCdf2t8H/qgH589WFimTc+FrMo5uQGBoSH8rMCdm82Nrj7G3NE6ual9wE40Bso
	 dDWunlvFYyeTwIfc4iwzeTqp5hQpGpm95KJj+s3cqopTPSv43RVQrW0novADINbdHC
	 oKAYDEloAKnAQubpx3Pq9nV/QwuPgdJ2jYPyVX4wvJNtd8rdT1MZ5tgWvkbjL294UV
	 YrydZxGdqHvps3t+Yy80fxujm2iAjrRM/A4RYimz/m5QIE94/VsmvZ5M5TnWPbauC7
	 5F+V6yAMuOjjg==
Date: Mon, 29 Apr 2024 20:22:16 -0700
Subject: [PATCH 11/18] fsverity: pass the zero-hash value to the
 implementation
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444679776.955480.12744028295366753502.stgit@frogsfrogsfrogs>
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

Compute the hash of one filesystem block's worth of zeros and pass a
reference to this to the merkle tree read and write functions.  A
filesystem implementation can decide to elide merkle tree blocks
containing only this hash and synthesize the contents at read time.

Let's pretend that there's a file containing six data blocks and whose
merkle tree looks roughly like this:

root
 +--leaf0
 |   +--data0
 |   +--data1
 |   `--data2
 `--leaf1
     +--data3
     +--data4
     `--data5

If data[0-2] are sparse holes, then leaf0 will contain a repeating
sequence of @zero_digest.  Therefore, leaf0 need not be written to disk
because its contents can be synthesized.

A subsequent xfs patch will use this to reduce the size of the merkle
tree when dealing with sparse gold master disk images and the like.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/verity/enable.c           |    2 ++
 fs/verity/fsverity_private.h |    3 +++
 fs/verity/open.c             |    7 +++++++
 fs/verity/verify.c           |    2 ++
 include/linux/fsverity.h     |    8 ++++++++
 5 files changed, 22 insertions(+)


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
index c1a306fd1f9b4..20208425e56fc 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -47,6 +47,9 @@ struct merkle_tree_params {
 	u64 tree_size;			/* Merkle tree size in bytes */
 	unsigned long tree_pages;	/* Merkle tree size in pages */
 
+	/* the hash of a merkle block-sized buffer of zeroes */
+	u8 zero_digest[FS_VERITY_MAX_DIGEST_SIZE];
+
 	/*
 	 * Starting block index for each tree level, ordered from leaf level (0)
 	 * to root level ('num_levels - 1')
diff --git a/fs/verity/open.c b/fs/verity/open.c
index aa71a4d3cbff1..c9d858d99f4ac 100644
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
index c4c5e1c082de5..0782a69d89f26 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -425,6 +425,8 @@ int fsverity_read_merkle_tree_block(struct inode *inode,
 			.level = level,
 			.num_levels = params->num_levels,
 			.ra_bytes = ra_bytes,
+			.zero_digest = params->zero_digest,
+			.digest_size = params->digest_size,
 		};
 
 		err = vops->read_merkle_tree_block(&req, block);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 710006552804d..dc8f85380b9c7 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -63,12 +63,16 @@ struct fsverity_blockbuf {
  *		if the page at @block->offset isn't already cached.
  *		Implementations may ignore this argument; it's only a
  *		performance optimization.
+ * @zero_digest: the hash of a merkle block-sized buffer of zeroes
+ * @digest_size: size of zero_digest, in bytes
  */
 struct fsverity_readmerkle {
 	struct inode *inode;
 	unsigned long ra_bytes;
 	int level;
 	int num_levels;
+	const u8 *zero_digest;
+	unsigned int digest_size;
 };
 
 #define FSVERITY_STREAMING_READ	(-1)
@@ -76,9 +80,13 @@ struct fsverity_readmerkle {
 /**
  * struct fsverity_writemerkle - Request to write a Merkle Tree block buffer
  * @inode: the inode to read
+ * @zero_digest: the hash of a merkle block-sized buffer of zeroes
+ * @digest_size: size of zero_digest, in bytes
  */
 struct fsverity_writemerkle {
 	struct inode *inode;
+	const u8 *zero_digest;
+	unsigned int digest_size;
 };
 
 /* Verity operations for filesystems */


