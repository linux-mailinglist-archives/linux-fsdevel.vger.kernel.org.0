Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4EC611D94
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Oct 2022 00:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJ1Wr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 18:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJ1Wru (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:47:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313E81D5577;
        Fri, 28 Oct 2022 15:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B195B82CF7;
        Fri, 28 Oct 2022 22:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6067C433B5;
        Fri, 28 Oct 2022 22:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666997266;
        bh=dJGMEBZvXfrxKJhTn/rgkA4g++Q/5P+YzBK/5zdwN3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p3XIXAPZJZBSD9HswYfHAQrVD9ahA4Y2ogpcufpijOz5QfbCoW1wLRfaz7P4LCaL9
         LG0yCTtdf7r5Q3XtmckEKCl1ypZbahib8m35UQ0FdroDjHLz4rw8+scw6QAhwZbN5d
         gUYSpYal6Uc5+ZQDxu6kWzhVPu2eEn/kTdznK6CUMH5oSaLohBZIYq+uBFHo3y3uCt
         H3UnGzzlNa92wZDf3C0EU8bukjvDZDUziMQgp21UVm6E3rNf8n/jCo5XOxLUYnzDJW
         6lbNAVZl6K0/ReJGIfqcem2RAWBTaoqLjvKeAn16VB+adiQCc+f6wiVG8lV99kTbXE
         ZAkTxVa29eSdw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] fsverity: support enabling with tree block size < PAGE_SIZE
Date:   Fri, 28 Oct 2022 15:45:35 -0700
Message-Id: <20221028224539.171818-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221028224539.171818-1-ebiggers@kernel.org>
References: <20221028224539.171818-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make FS_IOC_ENABLE_VERITY support values of
fsverity_enable_arg::block_size other than PAGE_SIZE.

To make this possible, rework build_merkle_tree(), which was reading
data and hash pages from the file and assuming that they were the same
thing as "blocks".

For reading the data blocks, just replace the direct pagecache access
with __kernel_read(), to naturally read one block at a time.

(A disadvantage of the above is that we lose the two optimizations of
hashing the pagecache pages in-place and forcing the maximum readahead.
That shouldn't be very important, though.)

The hash block reads are a bit more difficult to handle, as the only way
to do them is through fsverity_operations::read_merkle_tree_page().

Instead, let's switch to the single-pass tree construction algorithm
that fsverity-utils uses.  This eliminates the need to read back any
hash blocks while the tree is being built, at the small cost of an extra
block-sized memory buffer per Merkle tree level.

Taken together, the above two changes result in page-size independent
code that is also a bit simpler than what we had before.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fsverity.rst |  21 +-
 fs/verity/enable.c                     | 268 ++++++++++++-------------
 fs/verity/fsverity_private.h           |   2 +-
 fs/verity/hash_algs.c                  |  24 ++-
 fs/verity/open.c                       |   8 +-
 include/linux/fsverity.h               |   3 +-
 6 files changed, 160 insertions(+), 166 deletions(-)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 70da93595058a..4c202e0dee102 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -118,10 +118,11 @@ as follows:
 - ``hash_algorithm`` must be the identifier for the hash algorithm to
   use for the Merkle tree, such as FS_VERITY_HASH_ALG_SHA256.  See
   ``include/uapi/linux/fsverity.h`` for the list of possible values.
-- ``block_size`` must be the Merkle tree block size.  Currently, this
-  must be equal to the system page size, which is usually 4096 bytes.
-  Other sizes may be supported in the future.  This value is not
-  necessarily the same as the filesystem block size.
+- ``block_size`` is the Merkle tree block size, in bytes.  In Linux
+  v6.2 and later, this can be any power of 2 between (inclusively)
+  1024 and the minimum of the system page size and the filesystem
+  block size.  In earlier versions, the system page size was the only
+  allowed value.
 - ``salt_size`` is the size of the salt in bytes, or 0 if no salt is
   provided.  The salt is a value that is prepended to every hashed
   block; it can be used to personalize the hashing for a particular
@@ -161,6 +162,7 @@ FS_IOC_ENABLE_VERITY can fail with the following errors:
 - ``EBUSY``: this ioctl is already running on the file
 - ``EEXIST``: the file already has verity enabled
 - ``EFAULT``: the caller provided inaccessible memory
+- ``EFBIG``: the file is too large to enable verity on
 - ``EINTR``: the operation was interrupted by a fatal signal
 - ``EINVAL``: unsupported version, hash algorithm, or block size; or
   reserved bits are set; or the file descriptor refers to neither a
@@ -518,9 +520,7 @@ support paging multi-gigabyte xattrs into memory, and to support
 encrypting xattrs.  Note that the verity metadata *must* be encrypted
 when the file is, since it contains hashes of the plaintext data.
 
-Currently, ext4 verity only supports the case where the Merkle tree
-block size, filesystem block size, and page size are all the same.  It
-also only supports extent-based files.
+ext4 only allows verity on extent-based files.
 
 f2fs
 ----
@@ -538,11 +538,10 @@ Like ext4, f2fs stores the verity metadata (Merkle tree and
 fsverity_descriptor) past the end of the file, starting at the first
 64K boundary beyond i_size.  See explanation for ext4 above.
 Moreover, f2fs supports at most 4096 bytes of xattr entries per inode
-which wouldn't be enough for even a single Merkle tree block.
+which usually wouldn't be enough for even a single Merkle tree block.
 
-Currently, f2fs verity only supports a Merkle tree block size of 4096.
-Also, f2fs doesn't support enabling verity on files that currently
-have atomic or volatile writes pending.
+f2fs doesn't support enabling verity on files that currently have
+atomic or volatile writes pending.
 
 btrfs
 -----
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 5eb2f1c5a7a57..51adda7f0080d 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -7,135 +7,36 @@
 
 #include "fsverity_private.h"
 
-#include <crypto/hash.h>
-#include <linux/backing-dev.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/sched/signal.h>
 #include <linux/uaccess.h>
 
-/*
- * Read a file data page for Merkle tree construction.  Do aggressive readahead,
- * since we're sequentially reading the entire file.
- */
-static struct page *read_file_data_page(struct file *file, pgoff_t index,
-					struct file_ra_state *ra,
-					unsigned long remaining_pages)
-{
-	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, index);
-	struct folio *folio;
-
-	folio = __filemap_get_folio(ractl.mapping, index, FGP_ACCESSED, 0);
-	if (!folio || !folio_test_uptodate(folio)) {
-		if (folio)
-			folio_put(folio);
-		else
-			page_cache_sync_ra(&ractl, remaining_pages);
-		folio = read_cache_folio(ractl.mapping, index, NULL, file);
-		if (IS_ERR(folio))
-			return &folio->page;
-	}
-	if (folio_test_readahead(folio))
-		page_cache_async_ra(&ractl, folio, remaining_pages);
-	return folio_file_page(folio, index);
-}
+struct block_buffer {
+	u32 filled;
+	u8 *data;
+};
 
-static int build_merkle_tree_level(struct file *filp, unsigned int level,
-				   u64 num_blocks_to_hash,
-				   const struct merkle_tree_params *params,
-				   u8 *pending_hashes,
-				   struct ahash_request *req)
+/* Hash a block, writing the result to the next level's pending block buffer. */
+static int hash_one_block(struct inode *inode,
+			  const struct merkle_tree_params *params,
+			  struct ahash_request *req, struct block_buffer *cur)
 {
-	struct inode *inode = file_inode(filp);
-	const struct fsverity_operations *vops = inode->i_sb->s_vop;
-	struct file_ra_state ra = { 0 };
-	unsigned int pending_size = 0;
-	u64 dst_block_num;
-	u64 i;
+	struct block_buffer *next = cur + 1;
 	int err;
 
-	if (WARN_ON(params->block_size != PAGE_SIZE)) /* checked earlier too */
-		return -EINVAL;
-
-	if (level < params->num_levels) {
-		dst_block_num = params->level_start[level];
-	} else {
-		if (WARN_ON(num_blocks_to_hash != 1))
-			return -EINVAL;
-		dst_block_num = 0; /* unused */
-	}
-
-	file_ra_state_init(&ra, filp->f_mapping);
-
-	for (i = 0; i < num_blocks_to_hash; i++) {
-		struct page *src_page;
-
-		if ((pgoff_t)i % 10000 == 0 || i + 1 == num_blocks_to_hash)
-			pr_debug("Hashing block %llu of %llu for level %u\n",
-				 i + 1, num_blocks_to_hash, level);
-
-		if (level == 0) {
-			/* Leaf: hashing a data block */
-			src_page = read_file_data_page(filp, i, &ra,
-						       num_blocks_to_hash - i);
-			if (IS_ERR(src_page)) {
-				err = PTR_ERR(src_page);
-				fsverity_err(inode,
-					     "Error %d reading data page %llu",
-					     err, i);
-				return err;
-			}
-		} else {
-			unsigned long num_ra_pages =
-				min_t(unsigned long, num_blocks_to_hash - i,
-				      inode->i_sb->s_bdi->io_pages);
-
-			/* Non-leaf: hashing hash block from level below */
-			src_page = vops->read_merkle_tree_page(inode,
-					params->level_start[level - 1] + i,
-					num_ra_pages);
-			if (IS_ERR(src_page)) {
-				err = PTR_ERR(src_page);
-				fsverity_err(inode,
-					     "Error %d reading Merkle tree page %llu",
-					     err, params->level_start[level - 1] + i);
-				return err;
-			}
-		}
-
-		err = fsverity_hash_block(params, inode, req, src_page, 0,
-					  &pending_hashes[pending_size]);
-		put_page(src_page);
-		if (err)
-			return err;
-		pending_size += params->digest_size;
+	/* Zero-pad the block if it's shorter than the block size. */
+	memset(&cur->data[cur->filled], 0, params->block_size - cur->filled);
 
-		if (level == params->num_levels) /* Root hash? */
-			return 0;
-
-		if (pending_size + params->digest_size > params->block_size ||
-		    i + 1 == num_blocks_to_hash) {
-			/* Flush the pending hash block */
-			memset(&pending_hashes[pending_size], 0,
-			       params->block_size - pending_size);
-			err = vops->write_merkle_tree_block(inode,
-					pending_hashes,
-					dst_block_num,
-					params->log_blocksize);
-			if (err) {
-				fsverity_err(inode,
-					     "Error %d writing Merkle tree block %llu",
-					     err, dst_block_num);
-				return err;
-			}
-			dst_block_num++;
-			pending_size = 0;
-		}
-
-		if (fatal_signal_pending(current))
-			return -EINTR;
-		cond_resched();
+	err = fsverity_hash_buffer(params->hashstate, req,
+				   cur->data, params->block_size,
+				   &next->data[next->filled]);
+	if (err) {
+		fsverity_err(inode, "Error %d computing block hash", err);
+		return err;
 	}
+	next->filled += params->digest_size;
+	cur->filled = 0;
 	return 0;
 }
 
@@ -152,13 +53,18 @@ static int build_merkle_tree(struct file *filp,
 			     u8 *root_hash)
 {
 	struct inode *inode = file_inode(filp);
-	u8 *pending_hashes;
+	const u64 data_size = inode->i_size;
+	const int num_levels = params->num_levels;
+	const struct fsverity_operations *vops = inode->i_sb->s_vop;
 	struct ahash_request *req;
-	u64 blocks;
-	unsigned int level;
-	int err = -ENOMEM;
+	struct block_buffer _buffers[1 + FS_VERITY_MAX_LEVELS + 1] = {};
+	struct block_buffer *buffers = &_buffers[1];
+	unsigned long level_offset[FS_VERITY_MAX_LEVELS];
+	int level;
+	u64 offset;
+	int err;
 
-	if (inode->i_size == 0) {
+	if (data_size == 0) {
 		/* Empty file is a special case; root hash is all 0's */
 		memset(root_hash, 0, params->digest_size);
 		return 0;
@@ -167,29 +73,111 @@ static int build_merkle_tree(struct file *filp,
 	/* This allocation never fails, since it's mempool-backed. */
 	req = fsverity_alloc_hash_request(params->hash_alg, GFP_KERNEL);
 
-	pending_hashes = kmalloc(params->block_size, GFP_KERNEL);
-	if (!pending_hashes)
-		goto out;
-
 	/*
-	 * Build each level of the Merkle tree, starting at the leaf level
-	 * (level 0) and ascending to the root node (level 'num_levels - 1').
-	 * Then at the end (level 'num_levels'), calculate the root hash.
+	 * Allocate the block buffers.  Buffer "-1" is for data blocks.
+	 * Buffers 0 <= level < num_levels are for the actual tree levels.
+	 * Buffer 'num_levels' is for the root hash.
 	 */
-	blocks = ((u64)inode->i_size + params->block_size - 1) >>
-		 params->log_blocksize;
-	for (level = 0; level <= params->num_levels; level++) {
-		err = build_merkle_tree_level(filp, level, blocks, params,
-					      pending_hashes, req);
+	for (level = -1; level < num_levels; level++) {
+		buffers[level].data = kzalloc(params->block_size, GFP_KERNEL);
+		if (!buffers[level].data) {
+			err = -ENOMEM;
+			goto out;
+		}
+	}
+	buffers[num_levels].data = root_hash;
+
+	BUILD_BUG_ON(sizeof(level_offset) != sizeof(params->level_start));
+	memcpy(level_offset, params->level_start, sizeof(level_offset));
+
+	/* Hash each data block, also hashing the tree blocks as they fill up */
+	for (offset = 0; offset < data_size; offset += params->block_size) {
+		u64 dblock_idx = offset >> params->log_blocksize;
+		ssize_t bytes_read;
+		loff_t pos = offset;
+
+		if ((unsigned long)dblock_idx % 10000 == 0) {
+			pr_debug("Hashing data block %llu of %llu\n",
+				 dblock_idx,
+				 (data_size + params->block_size - 1) >>
+				 params->log_blocksize);
+		}
+
+		buffers[-1].filled = min_t(u64, params->block_size,
+					   data_size - offset);
+		bytes_read = __kernel_read(filp, buffers[-1].data,
+					   buffers[-1].filled, &pos);
+		if (bytes_read < 0) {
+			err = bytes_read;
+			fsverity_err(inode, "Error %d reading file data", err);
+			goto out;
+		}
+		if (bytes_read != buffers[-1].filled) {
+			err = -EINVAL;
+			fsverity_err(inode, "Short read of file data");
+			goto out;
+		}
+		err = hash_one_block(inode, params, req, &buffers[-1]);
 		if (err)
 			goto out;
-		blocks = (blocks + params->hashes_per_block - 1) >>
-			 params->log_arity;
+		for (level = 0; level < num_levels; level++) {
+			if (buffers[level].filled +
+			    params->digest_size <= params->block_size) {
+				/* Level's next hash block isn't full yet */
+				break;
+			}
+			/* Level's next hash block is full */
+
+			err = hash_one_block(inode, params, req,
+					     &buffers[level]);
+			if (err)
+				goto out;
+			err = vops->write_merkle_tree_block(inode,
+					buffers[level].data,
+					level_offset[level],
+					params->log_blocksize);
+			if (err) {
+				fsverity_err(inode,
+					     "Error %d writing Merkle tree block %lu",
+					     err, level_offset[level]);
+				goto out;
+			}
+			level_offset[level]++;
+		}
+		if (fatal_signal_pending(current)) {
+			err = -EINTR;
+			goto out;
+		}
+		cond_resched();
+	}
+	/* Finish all nonempty pending tree blocks. */
+	for (level = 0; level < num_levels; level++) {
+		if (buffers[level].filled != 0) {
+			err = hash_one_block(inode, params, req,
+					     &buffers[level]);
+			if (err)
+				goto out;
+			err = vops->write_merkle_tree_block(inode,
+					buffers[level].data,
+					level_offset[level],
+					params->log_blocksize);
+			if (err) {
+				fsverity_err(inode,
+					     "Error %d writing Merkle tree block %lu",
+					     err, level_offset[level]);
+				goto out;
+			}
+		}
+	}
+	/* The root hash was filled by the last call to hash_one_block(). */
+	if (WARN_ON(buffers[num_levels].filled != params->digest_size)) {
+		err = -EINVAL;
+		goto out;
 	}
-	memcpy(root_hash, pending_hashes, params->digest_size);
 	err = 0;
 out:
-	kfree(pending_hashes);
+	for (level = -1; level < num_levels; level++)
+		kfree(buffers[level].data);
 	fsverity_free_hash_request(params->hash_alg, req);
 	return err;
 }
@@ -352,7 +340,7 @@ int fsverity_ioctl_enable(struct file *filp, const void __user *uarg)
 	    memchr_inv(arg.__reserved2, 0, sizeof(arg.__reserved2)))
 		return -EINVAL;
 
-	if (arg.block_size != PAGE_SIZE)
+	if (!is_power_of_2(arg.block_size))
 		return -EINVAL;
 
 	if (arg.salt_size > sizeof_field(struct fsverity_descriptor, salt))
diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index f9fe1e7e2ba1e..d8b0eafb35fc9 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -92,7 +92,7 @@ const u8 *fsverity_prepare_hash_state(struct fsverity_hash_alg *alg,
 int fsverity_hash_block(const struct merkle_tree_params *params,
 			const struct inode *inode, struct ahash_request *req,
 			struct page *page, unsigned int offset, u8 *out);
-int fsverity_hash_buffer(struct fsverity_hash_alg *alg,
+int fsverity_hash_buffer(const u8 *initial_state, struct ahash_request *req,
 			 const void *data, size_t size, u8 *out);
 void __init fsverity_check_hash_algs(void);
 
diff --git a/fs/verity/hash_algs.c b/fs/verity/hash_algs.c
index 4ac9c1b46ab6f..0bb57f9dbd41c 100644
--- a/fs/verity/hash_algs.c
+++ b/fs/verity/hash_algs.c
@@ -266,37 +266,39 @@ int fsverity_hash_block(const struct merkle_tree_params *params,
 
 /**
  * fsverity_hash_buffer() - hash some data
- * @alg: the hash algorithm to use
+ * @initial_state: optional salted initial hash state
+ * @req: preallocated hash request
  * @data: the data to hash
  * @size: size of data to hash, in bytes
  * @out: output digest, size 'alg->digest_size' bytes
  *
  * Hash some data which is located in physically contiguous memory (i.e. memory
- * allocated by kmalloc(), not by vmalloc()).  No salt is used.
+ * allocated by kmalloc(), not by vmalloc()).
  *
  * Return: 0 on success, -errno on failure
  */
-int fsverity_hash_buffer(struct fsverity_hash_alg *alg,
+int fsverity_hash_buffer(const u8 *initial_state, struct ahash_request *req,
 			 const void *data, size_t size, u8 *out)
 {
-	struct ahash_request *req;
 	struct scatterlist sg;
 	DECLARE_CRYPTO_WAIT(wait);
 	int err;
 
-	/* This allocation never fails, since it's mempool-backed. */
-	req = fsverity_alloc_hash_request(alg, GFP_KERNEL);
-
 	sg_init_one(&sg, data, size);
 	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP |
 					CRYPTO_TFM_REQ_MAY_BACKLOG,
 				   crypto_req_done, &wait);
 	ahash_request_set_crypt(req, &sg, out, size);
 
-	err = crypto_wait_req(crypto_ahash_digest(req), &wait);
-
-	fsverity_free_hash_request(alg, req);
-	return err;
+	if (initial_state) {
+		err = crypto_ahash_import(req, initial_state);
+		if (err)
+			return err;
+		err = crypto_ahash_finup(req);
+	} else {
+		err = crypto_ahash_digest(req);
+	}
+	return crypto_wait_req(err, &wait);
 }
 
 void __init fsverity_check_hash_algs(void)
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 68cf031b93ab6..d367bd91fe586 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -168,13 +168,19 @@ static int compute_file_digest(struct fsverity_hash_alg *hash_alg,
 			       struct fsverity_descriptor *desc,
 			       u8 *file_digest)
 {
+	struct ahash_request *req;
 	__le32 sig_size = desc->sig_size;
 	int err;
 
+	/* This allocation never fails, since it's mempool-backed. */
+	req = fsverity_alloc_hash_request(hash_alg, GFP_KERNEL);
+
 	desc->sig_size = 0;
-	err = fsverity_hash_buffer(hash_alg, desc, sizeof(*desc), file_digest);
+	err = fsverity_hash_buffer(NULL, req, desc, sizeof(*desc), file_digest);
 	desc->sig_size = sig_size;
 
+	fsverity_free_hash_request(hash_alg, req);
+
 	return err;
 }
 
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 4583ea089abde..093fe7ab454ef 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -93,8 +93,7 @@ struct fsverity_operations {
 	 *		  isn't already cached.  Implementations may ignore this
 	 *		  argument; it's only a performance optimization.
 	 *
-	 * This can be called at any time on an open verity file, as well as
-	 * between ->begin_enable_verity() and ->end_enable_verity().  It may be
+	 * This can be called at any time on an open verity file.  It may be
 	 * called by multiple processes concurrently, even with the same page.
 	 *
 	 * Note that this must retrieve a *page*, not necessarily a *block*.
-- 
2.38.0

