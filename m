Return-Path: <linux-fsdevel+bounces-14591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD1287DE6B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFD9282088
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983831CD15;
	Sun, 17 Mar 2024 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBKBbxg1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016651CAB7;
	Sun, 17 Mar 2024 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692824; cv=none; b=ZUrMD/p7jBNwe0bA5rhgJgRjd9svAxraux3K+fHdm638aO14A0bsWgwi/HiMSOnMstUmo/PImVkNAQy3AU2KHp/ZaPsbsLzASsa8OejXEClxQgiXu2qxKokQDYIV2GUenJdO4iHhO8yY2au79Vubh5jEaTPX6vHxaX4usZCsi1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692824; c=relaxed/simple;
	bh=jRGedbeIlRods6JQW2PoaB61wTVKCCEInceyvQG3spU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXdQTVUXAv5OezPUAXNgZnyCgZiF+ziOg2vuUliOZnQH48qUNrkHEMO/kK2hccaw8Xvf60gAutgGeBO4cefTbdYWRH4r+uFdcFqYR8e8OIC+Gj1V5q5TV3HhPc0xv+bOzlznAXbflGh64cHV7tAKvYyqnOHcwEF7jIhmcpGiPgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBKBbxg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4FAC433F1;
	Sun, 17 Mar 2024 16:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692823;
	bh=jRGedbeIlRods6JQW2PoaB61wTVKCCEInceyvQG3spU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nBKBbxg1jaTqwZ1U98Vlo5oc11n32IJf0olwWEJuWWn96+UQR4FXVqFEB1pneF8Dz
	 M7iZJxZD48VSJYGL9w0g+oSp//QJehweBKMRj2QUGbRrwgkh7ieATZwh8vbSFRusAl
	 DF3lcP0edaSF2zngXHWGL89Jxm3aZ5YFL2VWst9tuWXdOuszSRLN/qQlKyb3QkqegD
	 UN+ryCTevqeHO9VoF+HDwBFxmJLQeV15bYJe8D5nFEupJZKokI9YUNlHfajezljZCe
	 4n50oyyi+tQlEQsLWSYH1iOF7Yky5/2C4TAliGbE9RuJtrfuF+zPAGiH3OP6681XNF
	 ZThrddWnOLzdQ==
Date: Sun, 17 Mar 2024 09:27:02 -0700
Subject: [PATCH 14/40] fsverity: rely on cached block callers to retain
 verified state
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246138.2684506.8836637841022003817.stgit@frogsfrogsfrogs>
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

Using a single contiguous bitmap to record merkle tree block
verification state is unnecessary when we can retain that state in the
merkle tree block cache.  Worse, it doesn't scale well to large verity
files and stresses the memory allocator.

Therefore, add a state bit to fsverity_blockbuf and let the
implementation retain the validated state.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/verity/fsverity_private.h    |    7 ++++---
 fs/verity/verify.c              |   39 +++++++--------------------------------
 include/linux/fsverity.h        |   13 ++++++++-----
 include/trace/events/fsverity.h |   19 -------------------
 4 files changed, 19 insertions(+), 59 deletions(-)


diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index b01343113e8b..de8798f141d4 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -167,14 +167,15 @@ static inline bool fsverity_caches_blocks(const struct inode *inode)
 static inline bool fsverity_uses_bitmap(const struct fsverity_info *vi,
 					const struct inode *inode)
 {
+	if (fsverity_caches_blocks(inode))
+		return false;
+
 	/*
 	 * If fs uses block-based Merkle tree caching, then fs-verity must use
 	 * hash_block_verified bitmap as there's no page to mark it with
 	 * PG_checked.
 	 */
-	if (vi->tree_params.block_size != PAGE_SIZE)
-		return true;
-	return fsverity_caches_blocks(inode);
+	return vi->tree_params.block_size != PAGE_SIZE;
 }
 
 int fsverity_read_merkle_tree_block(struct inode *inode,
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index cd84182f5e43..a61d1c99c485 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -26,12 +26,11 @@ static bool is_hash_block_verified(struct inode *inode,
 	struct page *hpage;
 
 	/*
-	 * If the filesystem uses block-based caching, then
-	 * ->hash_block_verified is always used and the filesystem pushes
-	 * invalidations to it as needed.
+	 * If the filesystem uses block-based caching, then rely on the
+	 * implementation to retain verified status.
 	 */
 	if (fsverity_caches_blocks(inode))
-		return test_bit(hblock_idx, vi->hash_block_verified);
+		return block->verified;
 
 	/* Otherwise, the filesystem uses page-based caching. */
 	hpage = (struct page *)block->context;
@@ -224,7 +223,9 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		 * idempotent, as the same hash block might be verified by
 		 * multiple threads concurrently.
 		 */
-		if (fsverity_uses_bitmap(vi, inode))
+		if (fsverity_caches_blocks(inode))
+			block->verified = true;
+		else if (fsverity_uses_bitmap(vi, inode))
 			set_bit(hblock_idx, vi->hash_block_verified);
 		else
 			SetPageChecked((struct page *)block->context);
@@ -375,33 +376,6 @@ void __init fsverity_init_workqueue(void)
 		panic("failed to allocate fsverity_read_queue");
 }
 
-/**
- * fsverity_invalidate_block() - invalidate Merkle tree block
- * @inode: inode to which this Merkle tree blocks belong
- * @block: block to be invalidated
- *
- * This function invalidates/clears "verified" state of Merkle tree block
- * in the fs-verity bitmap. The block needs to have ->offset set.
- */
-void fsverity_invalidate_block(struct inode *inode,
-		struct fsverity_blockbuf *block)
-{
-	struct fsverity_info *vi = inode->i_verity_info;
-	const unsigned int log_blocksize = vi->tree_params.log_blocksize;
-
-	trace_fsverity_invalidate_block(inode, block);
-
-	if (block->offset >= vi->tree_params.tree_size) {
-		fsverity_err(inode,
-"Trying to invalidate beyond Merkle tree (tree %lld, offset %lld)",
-			     vi->tree_params.tree_size, block->offset);
-		return;
-	}
-
-	clear_bit(block->offset >> log_blocksize, vi->hash_block_verified);
-}
-EXPORT_SYMBOL_GPL(fsverity_invalidate_block);
-
 /**
  * fsverity_read_merkle_tree_block() - read Merkle tree block
  * @inode: inode to which this Merkle tree blocks belong
@@ -436,6 +410,7 @@ int fsverity_read_merkle_tree_block(struct inode *inode,
 			.log_blocksize = params->log_blocksize,
 			.ra_bytes = ra_bytes,
 		};
+		block->verified = false;
 
 		return vops->read_merkle_tree_block(&req, block);
 	}
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 17bc0729119c..026e4f72290e 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -32,6 +32,7 @@
  * @offset: block's offset into Merkle tree
  * @size: the Merkle tree block size
  * @context: filesystem private context
+ * @verified: has this buffer been validated?
  *
  * Buffer containing single Merkle Tree block. These buffers are passed
  *  - to filesystem, when fs-verity is building merkel tree,
@@ -49,6 +50,7 @@
 struct fsverity_blockbuf {
 	void *kaddr;
 	u64 offset;
+	unsigned int verified:1;
 	unsigned int size;
 	void *context;
 };
@@ -168,9 +170,9 @@ struct fsverity_operations {
 	 * This can be called at any time on an open verity file.  It may be
 	 * called by multiple processes concurrently.
 	 *
-	 * In case that block was evicted from the memory filesystem has to use
-	 * fsverity_invalidate_block() to let fsverity know that block's
-	 * verification state is not valid anymore.
+	 * Implementations may cache the @block->verified state in
+	 * ->drop_merkle_tree_block.  They must clear the @block->verified
+	 * flag for a cache miss.
 	 *
 	 * If this function is implemented, ->drop_merkle_tree_block must also
 	 * be implemented.
@@ -204,6 +206,9 @@ struct fsverity_operations {
 	 * This is called when fs-verity is done with a block obtained with
 	 * ->read_merkle_tree_block().
 	 *
+	 * Implementations should cache a @block->verified==1 state to avoid
+	 * unnecessary revalidations during later accesses.
+	 *
 	 * If this function is implemented, ->read_merkle_tree_block must also
 	 * be implemented.
 	 */
@@ -264,8 +269,6 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg);
 bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset);
 void fsverity_verify_bio(struct bio *bio);
 void fsverity_enqueue_verify_work(struct work_struct *work);
-void fsverity_invalidate_block(struct inode *inode,
-		struct fsverity_blockbuf *block);
 
 static inline int fsverity_set_ops(struct super_block *sb,
 				   const struct fsverity_operations *ops)
diff --git a/include/trace/events/fsverity.h b/include/trace/events/fsverity.h
index 763890e47358..1a6ee2a2c3ce 100644
--- a/include/trace/events/fsverity.h
+++ b/include/trace/events/fsverity.h
@@ -109,25 +109,6 @@ TRACE_EVENT(fsverity_merkle_tree_block_verified,
 		__entry->direction == 0 ? "ascend" : "descend")
 );
 
-TRACE_EVENT(fsverity_invalidate_block,
-	TP_PROTO(struct inode *inode, struct fsverity_blockbuf *block),
-	TP_ARGS(inode, block),
-	TP_STRUCT__entry(
-		__field(ino_t, ino)
-		__field(u64, offset)
-		__field(unsigned int, block_size)
-	),
-	TP_fast_assign(
-		__entry->ino = inode->i_ino;
-		__entry->offset = block->offset;
-		__entry->block_size = block->size;
-	),
-	TP_printk("ino %lu block position %llu block size %u",
-		(unsigned long) __entry->ino,
-		__entry->offset,
-		__entry->block_size)
-);
-
 TRACE_EVENT(fsverity_read_merkle_tree_block,
 	TP_PROTO(struct inode *inode, u64 offset, unsigned int log_blocksize),
 	TP_ARGS(inode, offset, log_blocksize),


