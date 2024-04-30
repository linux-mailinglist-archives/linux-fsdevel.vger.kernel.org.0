Return-Path: <linux-fsdevel+bounces-18215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B25A8B6854
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DFB71C2172F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F80101C4;
	Tue, 30 Apr 2024 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVsrsm7p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F0DDDA;
	Tue, 30 Apr 2024 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447228; cv=none; b=ZsgvXjgBb/mXMAE4dMndF1kucip4M3zrW5tGHdpiiQJ0Vw7X6oiqdieVhBuWJUk3giKB8lN71NK5E0t8IdnXaGgJRXpr50DNABE3TsHGbj/eGGwQvrZ/IjibBaFskMwUtqx9QzPajt9TKcIps60dK6UcaDoz4P1Fbcb5ghXlNFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447228; c=relaxed/simple;
	bh=4ybTm3INCnVztzEM64YwY6iwBMTrW6FzecdyEJKYHHE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXECAer67Y+U4nsLjV5HNrvawzUwPrf9G69PgPLuJpEsQ6U+MC+fylb+bRxEs1PV2cBQ4CX1MBDFsh12ke0F3cneEOzbNw8TQgS87/85NU6iYVzOgU/+D7/Edtri9w17rN4zilB0PmlwFuJeHQBzbgLs12NtQvuLps1GgnQymgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVsrsm7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06673C116B1;
	Tue, 30 Apr 2024 03:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447228;
	bh=4ybTm3INCnVztzEM64YwY6iwBMTrW6FzecdyEJKYHHE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SVsrsm7pWW8D+pDDYD60WF7TY7AXT1Aa01w8kGOd1ha8S8nvTYxPiaubvrjKFt4x4
	 RJq5Q4DRhoJhJl4+1J1B0w3Fw3UetjIj8N6t3hxRd1OVhDCS4ilQqEMdPBg7Wf4Qpn
	 icmiJvQEw7hBN6PeLKZnBleLjZuvh0Qn3Ft2JvvMnKHK54g7/T1coWnkjzNGGY5mDU
	 +Rmh8ihps0MFUqcp8Y2yXa9D5SZ3KLHmnWhC1EQ919/jZOvBwUHaj6IMtQblW/xxnv
	 xkzZuQBv0FmmhqTOSVBP3JltqekwlrEJHrh3/NzcXxsejQNEM1lyk4I9vg0663WQNO
	 yggZe2xFIe+cg==
Date: Mon, 29 Apr 2024 20:20:27 -0700
Subject: [PATCH 04/18] fsverity: support block-based Merkle tree caching
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444679658.955480.4637262867075831070.stgit@frogsfrogsfrogs>
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

From: Andrey Albershteyn <aalbersh@redhat.com>

In the current implementation fs-verity expects filesystem to provide
PAGEs filled with Merkle tree blocks. Then, when fs-verity is done with
processing the blocks, reference to PAGE is freed. This doesn't fit well
with the way XFS manages its memory.

To allow XFS integrate fs-verity this patch adds ability to fs-verity
verification code to take Merkle tree blocks instead of PAGE reference.
This way ext4, f2fs, and btrfs are still able to pass PAGE references
and XFS can pass reference to Merkle tree blocks stored in XFS's
extended attribute infrastructure.

To achieve this, the XFS implementation will implement its own incore
merkle tree block cache.  These blocks will be passed to fsverity when
it needs to read a merkle tree block, and dropped  by fsverity when
validation completes.  The cache will keep track of whether or not a
given block has already been verified, which will improve performance on
random reads.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
[djwong: fix uninit err variable, remove dependency on bitmap, apply
 various suggestions from maintainer, tighten changelog]
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/verity/open.c         |   22 +++++++++++++++-
 fs/verity/verify.c       |   41 +++++++++++++++++++++++++++--
 include/linux/fsverity.h |   64 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 120 insertions(+), 7 deletions(-)


diff --git a/fs/verity/open.c b/fs/verity/open.c
index fdeb95eca3af3..4777130322866 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -180,9 +180,23 @@ static int compute_file_digest(const struct fsverity_hash_alg *hash_alg,
 struct fsverity_info *fsverity_create_info(const struct inode *inode,
 					   struct fsverity_descriptor *desc)
 {
+	const struct fsverity_operations *vops = inode->i_sb->s_vop;
 	struct fsverity_info *vi;
 	int err;
 
+	/*
+	 * If the filesystem implementation supplies Merkle tree content on a
+	 * per-block basis, it must implement both the read and drop functions.
+	 * If it supplies content on a per-page basis, neither should be
+	 * provided.
+	 */
+	if (vops->read_merkle_tree_page)
+		WARN_ON_ONCE(vops->read_merkle_tree_block != NULL ||
+			     vops->drop_merkle_tree_block != NULL);
+	else
+		WARN_ON_ONCE(vops->read_merkle_tree_block == NULL ||
+			     vops->drop_merkle_tree_block == NULL);
+
 	vi = kmem_cache_zalloc(fsverity_info_cachep, GFP_KERNEL);
 	if (!vi)
 		return ERR_PTR(-ENOMEM);
@@ -213,7 +227,13 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 	if (err)
 		goto fail;
 
-	if (vi->tree_params.block_size != PAGE_SIZE) {
+	/*
+	 * If the fs supplies Merkle tree content on a per-page basis and the
+	 * page size doesn't match the block size, fs-verity must use the
+	 * hash_block_verified bitmap instead of PG_checked.
+	 */
+	if (vops->read_merkle_tree_block == NULL &&
+	    vi->tree_params.block_size != PAGE_SIZE) {
 		/*
 		 * When the Merkle tree block size and page size differ, we use
 		 * a bitmap to keep track of which hash blocks have been
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 1c4a7c63c0a1c..55ada2af290ac 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -20,11 +20,22 @@ static bool is_hash_block_verified(struct inode *inode,
 				   struct fsverity_blockbuf *block,
 				   unsigned long hblock_idx)
 {
+	const struct fsverity_operations *vops = inode->i_sb->s_vop;
 	struct fsverity_info *vi = inode->i_verity_info;
-	struct page *hpage = (struct page *)block->context;
+	struct page *hpage;
 	unsigned int blocks_per_page;
 	unsigned int i;
 
+	/*
+	 * If the filesystem supplies Merkle tree content on a per-block basis,
+	 * rely on the implementation to retain verified status.
+	 */
+	if (vops->read_merkle_tree_block)
+		return block->verified;
+
+	/* Otherwise, the filesystem uses page-based caching. */
+	hpage = (struct page *)block->context;
+
 	/*
 	 * When the Merkle tree block size and page size are the same, then the
 	 * ->hash_block_verified bitmap isn't allocated, and we use PG_checked
@@ -96,6 +107,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		  const void *data, u64 data_pos, unsigned long max_ra_bytes)
 {
 	const struct merkle_tree_params *params = &vi->tree_params;
+	const struct fsverity_operations *vops = inode->i_sb->s_vop;
 	const unsigned int hsize = params->digest_size;
 	int level;
 	unsigned long ra_bytes;
@@ -204,7 +216,9 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		 * idempotent, as the same hash block might be verified by
 		 * multiple threads concurrently.
 		 */
-		if (vi->hash_block_verified)
+		if (vops->read_merkle_tree_block)
+			block->verified = true;
+		else if (vi->hash_block_verified)
 			set_bit(hblock_idx, vi->hash_block_verified);
 		else
 			SetPageChecked((struct page *)block->context);
@@ -377,6 +391,19 @@ int fsverity_read_merkle_tree_block(struct inode *inode,
 
 	block->pos = pos;
 	block->size = params->block_size;
+	block->verified = false;
+
+	if (vops->read_merkle_tree_block) {
+		struct fsverity_readmerkle req = {
+			.inode = inode,
+			.ra_bytes = ra_bytes,
+		};
+
+		err = vops->read_merkle_tree_block(&req, block);
+		if (err)
+			goto bad;
+		return 0;
+	}
 
 	index = pos >> params->log_blocksize;
 	page_idx = round_down(index, params->blocks_per_page);
@@ -408,8 +435,14 @@ int fsverity_read_merkle_tree_block(struct inode *inode,
 void fsverity_drop_merkle_tree_block(struct inode *inode,
 				     struct fsverity_blockbuf *block)
 {
-	kunmap_local(block->kaddr);
-	put_page((struct page *)block->context);
+	const struct fsverity_operations *vops = inode->i_sb->s_vop;
+
+	if (vops->drop_merkle_tree_block) {
+		vops->drop_merkle_tree_block(block);
+	} else {
+		kunmap_local(block->kaddr);
+		put_page((struct page *)block->context);
+	}
 	block->kaddr = NULL;
 	block->context = NULL;
 }
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 05f8e89e0f470..ad17f8553f9cf 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -32,17 +32,38 @@
  * @kaddr: virtual address of the block's data
  * @pos: the position of the block in the Merkle tree (in bytes)
  * @size: the Merkle tree block size
+ * @verified: has this buffer been validated?
  *
  * Buffer containing a single Merkle Tree block.  When fs-verity wants to read
  * merkle data from disk, it passes the filesystem a buffer with the @pos,
- * @index, and @size fields filled out.  The filesystem sets @kaddr and
- * @context.
+ * @index, and @size fields filled out.  The filesystem sets @kaddr, @context,
+ * and @verified.
+ *
+ * While reading the tree, fs-verity calls ->read_merkle_tree_block followed by
+ * ->drop_merkle_tree_block to let filesystem know that memory can be freed.
+ *
+ * The context is optional. This field can be used by filesystem to pass
+ * through state from ->read_merkle_tree_block to ->drop_merkle_tree_block.
  */
 struct fsverity_blockbuf {
 	void *context;
 	void *kaddr;
 	loff_t pos;
 	unsigned int size;
+	unsigned int verified:1;
+};
+
+/**
+ * struct fsverity_readmerkle - Request to read a Merkle Tree block buffer
+ * @inode: the inode to read
+ * @ra_bytes: The number of bytes that should be prefetched starting at pos
+ *		if the page at @block->offset isn't already cached.
+ *		Implementations may ignore this argument; it's only a
+ *		performance optimization.
+ */
+struct fsverity_readmerkle {
+	struct inode *inode;
+	unsigned long ra_bytes;
 };
 
 /* Verity operations for filesystems */
@@ -120,12 +141,35 @@ struct fsverity_operations {
 	 *
 	 * Note that this must retrieve a *page*, not necessarily a *block*.
 	 *
+	 * If this function is implemented, do not implement
+	 * ->read_merkle_tree_block or ->drop_merkle_tree_block.
+	 *
 	 * Return: the page on success, ERR_PTR() on failure
 	 */
 	struct page *(*read_merkle_tree_page)(struct inode *inode,
 					      pgoff_t index,
 					      unsigned long num_ra_pages);
 
+	/**
+	 * Read a Merkle tree block of the given inode.
+	 * @req: read request; see struct fsverity_readmerkle
+	 * @block: block buffer for filesystem to point it to the block
+	 *
+	 * This can be called at any time on an open verity file.  It may be
+	 * called by multiple processes concurrently.
+	 *
+	 * Implementations may cache the @block->verified state in
+	 * ->drop_merkle_tree_block.  They must clear the @block->verified
+	 * flag for a cache miss.
+	 *
+	 * If this function is implemented, ->drop_merkle_tree_block must also
+	 * be implemented.
+	 *
+	 * Return: 0 on success, -errno on failure
+	 */
+	int (*read_merkle_tree_block)(const struct fsverity_readmerkle *req,
+				      struct fsverity_blockbuf *block);
+
 	/**
 	 * Write a Merkle tree block to the given inode.
 	 *
@@ -141,6 +185,22 @@ struct fsverity_operations {
 	 */
 	int (*write_merkle_tree_block)(struct inode *inode, const void *buf,
 				       u64 pos, unsigned int size);
+
+	/**
+	 * Release the reference to a Merkle tree block
+	 *
+	 * @block: the block to release
+	 *
+	 * This is called when fs-verity is done with a block obtained with
+	 * ->read_merkle_tree_block().
+	 *
+	 * Implementations should cache a @block->verified==1 state to avoid
+	 * unnecessary revalidations during later accesses.
+	 *
+	 * If this function is implemented, ->read_merkle_tree_block must also
+	 * be implemented.
+	 */
+	void (*drop_merkle_tree_block)(struct fsverity_blockbuf *block);
 };
 
 #ifdef CONFIG_FS_VERITY


