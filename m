Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A92C611D95
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Oct 2022 00:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJ1Wr6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 18:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJ1Wrw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:47:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3CA1DE3EC;
        Fri, 28 Oct 2022 15:47:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 96F1ECE2E9D;
        Fri, 28 Oct 2022 22:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852E9C433C1;
        Fri, 28 Oct 2022 22:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666997265;
        bh=VW5aZRk1huDTCtbCmGpJGoCeXgBsbnpg155mA0KV1kQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NJVR/go3W3ypambxplTwMR8r3kzYCni6zocP1INmAZjYGixr6dL3t+Qr8Qp5FJ1Bl
         LflDOmWA5YjF+qr5w5oRGI8BzPlEflKtekKOWZn7JBXcYqkfF3k3ledDocHMCPZxxg
         DB1GEXpQMN+o3AjoORXxxk5EKsY+MBHdfF0FDLbcc6YCfxV7v3XiwhIRSIbqCJQptt
         f5e1ZBufyv+WX+gXPUU3SiqIgqMkvRfqoCqu9rBO2IHlU03PxplUXVPDDP83CnMCXs
         Qp9reaRQVs5CawVjuCbtltER+X3tvyT3KXgKuHCnoY1JhPSuzZHxnzBuMn6X+gbXAn
         YCdezFaDTNljQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] fsverity: support verification with tree block size < PAGE_SIZE
Date:   Fri, 28 Oct 2022 15:45:34 -0700
Message-Id: <20221028224539.171818-2-ebiggers@kernel.org>
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

Add support for verifying data from verity files whose Merkle tree block
size is less than the page size.  The main use case for this is to allow
a single Merkle tree block size to be used across all systems, so that
only one set of fsverity file digests and signatures is needed.

To do this, eliminate various assumptions that the Merkle tree block
size and the page size are the same:

- Make fsverity_verify_page() a wrapper around a new function
  fsverity_verify_blocks() which verifies one or more blocks in a page.

- When a Merkle tree block is needed, get the corresponding page and
  only verify and use the needed portion.  (The Merkle tree continues to
  be read and cached in page-sized chunks; that doesn't need to change.)

- When the Merkle tree block size and page size differ, use a bitmap
  fsverity_info::hash_block_verified to keep track of which Merkle tree
  blocks have been verified, as PageChecked cannot be used directly.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fsverity.rst |  49 ++--
 fs/verity/enable.c                     |   4 +-
 fs/verity/fsverity_private.h           |  15 +-
 fs/verity/hash_algs.c                  |  24 +-
 fs/verity/open.c                       |  93 +++++--
 fs/verity/verify.c                     | 325 +++++++++++++++++--------
 include/linux/fsverity.h               |  11 +-
 7 files changed, 355 insertions(+), 166 deletions(-)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index cb8e7573882a1..70da93595058a 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -571,47 +571,44 @@ For filesystems using Linux's pagecache, the ``->read_folio()`` and
 are marked Uptodate.  Merely hooking ``->read_iter()`` would be
 insufficient, since ``->read_iter()`` is not used for memory maps.
 
-Therefore, fs/verity/ provides a function fsverity_verify_page() which
-verifies a page that has been read into the pagecache of a verity
-inode, but is still locked and not Uptodate, so it's not yet readable
-by userspace.  As needed to do the verification,
-fsverity_verify_page() will call back into the filesystem to read
-Merkle tree pages via fsverity_operations::read_merkle_tree_page().
-
-fsverity_verify_page() returns false if verification failed; in this
+Therefore, fs/verity/ provides the function fsverity_verify_blocks()
+which verifies data that has been read into the pagecache of a verity
+inode.  The containing page must still be locked and not Uptodate, so
+it's not yet readable by userspace.  As needed to do the verification,
+fsverity_verify_blocks() will call back into the filesystem to read
+hash blocks via fsverity_operations::read_merkle_tree_page().
+
+fsverity_verify_blocks() returns false if verification failed; in this
 case, the filesystem must not set the page Uptodate.  Following this,
 as per the usual Linux pagecache behavior, attempts by userspace to
 read() from the part of the file containing the page will fail with
 EIO, and accesses to the page within a memory map will raise SIGBUS.
 
-fsverity_verify_page() currently only supports the case where the
-Merkle tree block size is equal to PAGE_SIZE (often 4096 bytes).
-
-In principle, fsverity_verify_page() verifies the entire path in the
-Merkle tree from the data page to the root hash.  However, for
-efficiency the filesystem may cache the hash pages.  Therefore,
-fsverity_verify_page() only ascends the tree reading hash pages until
-an already-verified hash page is seen, as indicated by the PageChecked
-bit being set.  It then verifies the path to that page.
+In principle, verifying a data block requires verifying the entire
+path in the Merkle tree from the data block to the root hash.
+However, for efficiency the filesystem may cache the hash blocks.
+Therefore, fsverity_verify_blocks() only ascends the tree reading hash
+blocks until an already-verified hash block is seen.  It then verifies
+the path to that block.
 
 This optimization, which is also used by dm-verity, results in
 excellent sequential read performance.  This is because usually (e.g.
-127 in 128 times for 4K blocks and SHA-256) the hash page from the
+127 in 128 times for 4K blocks and SHA-256) the hash block from the
 bottom level of the tree will already be cached and checked from
-reading a previous data page.  However, random reads perform worse.
+reading a previous data block.  However, random reads perform worse.
 
 Block device based filesystems
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Block device based filesystems (e.g. ext4 and f2fs) in Linux also use
 the pagecache, so the above subsection applies too.  However, they
-also usually read many pages from a file at once, grouped into a
+also usually read many data blocks from a file at once, grouped into a
 structure called a "bio".  To make it easier for these types of
 filesystems to support fs-verity, fs/verity/ also provides a function
-fsverity_verify_bio() which verifies all pages in a bio.
+fsverity_verify_bio() which verifies all data blocks in a bio.
 
 ext4 and f2fs also support encryption.  If a verity file is also
-encrypted, the pages must be decrypted before being verified.  To
+encrypted, the data must be decrypted before being verified.  To
 support this, these filesystems allocate a "post-read context" for
 each bio and store it in ``->bi_private``::
 
@@ -630,10 +627,10 @@ verification.  Finally, pages where no decryption or verity error
 occurred are marked Uptodate, and the pages are unlocked.
 
 On many filesystems, files can contain holes.  Normally,
-``->readahead()`` simply zeroes holes and sets the corresponding pages
-Uptodate; no bios are issued.  To prevent this case from bypassing
-fs-verity, these filesystems use fsverity_verify_page() to verify hole
-pages.
+``->readahead()`` simply zeroes hole blocks and considers the
+corresponding data to be up-to-date; no bios are issued.  To prevent
+this case from bypassing fs-verity, filesystems use
+fsverity_verify_blocks() to verify hole blocks.
 
 Filesystems also disable direct I/O on verity files, since otherwise
 direct I/O would bypass fs-verity.
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index df6b499bf6a14..5eb2f1c5a7a57 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -103,8 +103,8 @@ static int build_merkle_tree_level(struct file *filp, unsigned int level,
 			}
 		}
 
-		err = fsverity_hash_page(params, inode, req, src_page,
-					 &pending_hashes[pending_size]);
+		err = fsverity_hash_block(params, inode, req, src_page, 0,
+					  &pending_hashes[pending_size]);
 		put_page(src_page);
 		if (err)
 			return err;
diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index dbe1ce5b450a8..f9fe1e7e2ba1e 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -41,17 +41,19 @@ struct merkle_tree_params {
 	unsigned int digest_size;	/* same as hash_alg->digest_size */
 	unsigned int block_size;	/* size of data and tree blocks */
 	unsigned int hashes_per_block;	/* number of hashes per tree block */
+	unsigned int blocks_per_page;	/* PAGE_SIZE / block_size */
 	unsigned int log_blocksize;	/* log2(block_size) */
 	unsigned int log_arity;		/* log2(hashes_per_block) */
+	unsigned int log_blocks_per_page; /* log2(blocks_per_page) */
 	unsigned int num_levels;	/* number of levels in Merkle tree */
 	u64 tree_size;			/* Merkle tree size in bytes */
-	unsigned long level0_blocks;	/* number of blocks in tree level 0 */
+	unsigned long tree_pages;	/* Merkle tree size in pages */
 
 	/*
 	 * Starting block index for each tree level, ordered from leaf level (0)
 	 * to root level ('num_levels - 1')
 	 */
-	u64 level_start[FS_VERITY_MAX_LEVELS];
+	unsigned long level_start[FS_VERITY_MAX_LEVELS];
 };
 
 /*
@@ -68,9 +70,10 @@ struct fsverity_info {
 	u8 root_hash[FS_VERITY_MAX_DIGEST_SIZE];
 	u8 file_digest[FS_VERITY_MAX_DIGEST_SIZE];
 	const struct inode *inode;
+	unsigned long *hash_block_verified;
+	spinlock_t hash_page_init_lock;
 };
 
-
 #define FS_VERITY_MAX_SIGNATURE_SIZE	(FS_VERITY_MAX_DESCRIPTOR_SIZE - \
 					 sizeof(struct fsverity_descriptor))
 
@@ -86,9 +89,9 @@ void fsverity_free_hash_request(struct fsverity_hash_alg *alg,
 				struct ahash_request *req);
 const u8 *fsverity_prepare_hash_state(struct fsverity_hash_alg *alg,
 				      const u8 *salt, size_t salt_size);
-int fsverity_hash_page(const struct merkle_tree_params *params,
-		       const struct inode *inode,
-		       struct ahash_request *req, struct page *page, u8 *out);
+int fsverity_hash_block(const struct merkle_tree_params *params,
+			const struct inode *inode, struct ahash_request *req,
+			struct page *page, unsigned int offset, u8 *out);
 int fsverity_hash_buffer(struct fsverity_hash_alg *alg,
 			 const void *data, size_t size, u8 *out);
 void __init fsverity_check_hash_algs(void);
diff --git a/fs/verity/hash_algs.c b/fs/verity/hash_algs.c
index 71d0fccb6d4c4..4ac9c1b46ab6f 100644
--- a/fs/verity/hash_algs.c
+++ b/fs/verity/hash_algs.c
@@ -218,35 +218,33 @@ const u8 *fsverity_prepare_hash_state(struct fsverity_hash_alg *alg,
 }
 
 /**
- * fsverity_hash_page() - hash a single data or hash page
+ * fsverity_hash_block() - hash a single data or hash block
  * @params: the Merkle tree's parameters
  * @inode: inode for which the hashing is being done
  * @req: preallocated hash request
- * @page: the page to hash
+ * @page: the page containing the block to hash
+ * @offset: the offset of the block within @page
  * @out: output digest, size 'params->digest_size' bytes
  *
- * Hash a single data or hash block, assuming block_size == PAGE_SIZE.
- * The hash is salted if a salt is specified in the Merkle tree parameters.
+ * Hash a single data or hash block.  The hash is salted if a salt is specified
+ * in the Merkle tree parameters.
  *
  * Return: 0 on success, -errno on failure
  */
-int fsverity_hash_page(const struct merkle_tree_params *params,
-		       const struct inode *inode,
-		       struct ahash_request *req, struct page *page, u8 *out)
+int fsverity_hash_block(const struct merkle_tree_params *params,
+			const struct inode *inode, struct ahash_request *req,
+			struct page *page, unsigned int offset, u8 *out)
 {
 	struct scatterlist sg;
 	DECLARE_CRYPTO_WAIT(wait);
 	int err;
 
-	if (WARN_ON(params->block_size != PAGE_SIZE))
-		return -EINVAL;
-
 	sg_init_table(&sg, 1);
-	sg_set_page(&sg, page, PAGE_SIZE, 0);
+	sg_set_page(&sg, page, params->block_size, offset);
 	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP |
 					CRYPTO_TFM_REQ_MAY_BACKLOG,
 				   crypto_req_done, &wait);
-	ahash_request_set_crypt(req, &sg, out, PAGE_SIZE);
+	ahash_request_set_crypt(req, &sg, out, params->block_size);
 
 	if (params->hashstate) {
 		err = crypto_ahash_import(req, params->hashstate);
@@ -262,7 +260,7 @@ int fsverity_hash_page(const struct merkle_tree_params *params,
 
 	err = crypto_wait_req(err, &wait);
 	if (err)
-		fsverity_err(inode, "Error %d computing page hash", err);
+		fsverity_err(inode, "Error %d computing block hash", err);
 	return err;
 }
 
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 81ff94442f7b4..68cf031b93ab6 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -7,6 +7,7 @@
 
 #include "fsverity_private.h"
 
+#include <linux/mm.h>
 #include <linux/slab.h>
 
 static struct kmem_cache *fsverity_info_cachep;
@@ -34,6 +35,7 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 	struct fsverity_hash_alg *hash_alg;
 	int err;
 	u64 blocks;
+	u64 blocks_in_level[FS_VERITY_MAX_LEVELS];
 	u64 offset;
 	int level;
 
@@ -54,7 +56,23 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 		goto out_err;
 	}
 
-	if (log_blocksize != PAGE_SHIFT) {
+	/*
+	 * fs/verity/ directly assumes that the Merkle tree block size is a
+	 * power of 2 less than or equal to PAGE_SIZE.  Another restriction
+	 * arises from the interaction between fs/verity/ and the filesystems
+	 * themselves: filesystems expect to be able to verify a single
+	 * filesystem block of data at a time.  Therefore, the Merkle tree block
+	 * size must also be less than or equal to the filesystem block size.
+	 *
+	 * The above are the only hard limitations, so in theory the Merkle tree
+	 * block size could be as small as twice the digest size.  However,
+	 * that's not useful, and it would result in some unusually deep and
+	 * large Merkle trees.  So we currently require that the Merkle tree
+	 * block size be at least 1024 bytes.  That's small enough to test the
+	 * sub-page block case on systems with 4K pages, but not too small.
+	 */
+	if (log_blocksize < 10 || log_blocksize > PAGE_SHIFT ||
+	    log_blocksize > inode->i_blkbits) {
 		fsverity_warn(inode, "Unsupported log_blocksize: %u",
 			      log_blocksize);
 		err = -EINVAL;
@@ -62,6 +80,8 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 	}
 	params->log_blocksize = log_blocksize;
 	params->block_size = 1 << log_blocksize;
+	params->log_blocks_per_page = PAGE_SHIFT - log_blocksize;
+	params->blocks_per_page = 1 << params->log_blocks_per_page;
 
 	if (WARN_ON(!is_power_of_2(params->digest_size))) {
 		err = -EINVAL;
@@ -77,9 +97,9 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 	params->log_arity = params->log_blocksize - ilog2(params->digest_size);
 	params->hashes_per_block = 1 << params->log_arity;
 
-	pr_debug("Merkle tree uses %s with %u-byte blocks (%u hashes/block), salt=%*phN\n",
+	pr_debug("Merkle tree uses %s with %u-byte blocks (%u hashes/block, %u blocks/page), salt=%*phN\n",
 		 hash_alg->name, params->block_size, params->hashes_per_block,
-		 (int)salt_size, salt);
+		 params->blocks_per_page, (int)salt_size, salt);
 
 	/*
 	 * Compute the number of levels in the Merkle tree and create a map from
@@ -94,27 +114,44 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 	while (blocks > 1) {
 		if (params->num_levels >= FS_VERITY_MAX_LEVELS) {
 			fsverity_err(inode, "Too many levels in Merkle tree");
-			err = -EINVAL;
+			err = -EFBIG;
 			goto out_err;
 		}
 		blocks = (blocks + params->hashes_per_block - 1) >>
 			 params->log_arity;
-		/* temporarily using level_start[] to store blocks in level */
-		params->level_start[params->num_levels++] = blocks;
+		blocks_in_level[params->num_levels++] = blocks;
 	}
-	params->level0_blocks = params->level_start[0];
 
 	/* Compute the starting block of each level */
 	offset = 0;
 	for (level = (int)params->num_levels - 1; level >= 0; level--) {
-		blocks = params->level_start[level];
 		params->level_start[level] = offset;
 		pr_debug("Level %d is %llu blocks starting at index %llu\n",
-			 level, blocks, offset);
-		offset += blocks;
+			 level, blocks_in_level[level], offset);
+		offset += blocks_in_level[level];
+	}
+
+	/*
+	 * With block_size != PAGE_SIZE, an in-memory bitmap will need to be
+	 * allocated to track the "verified" status of hash blocks.  Don't allow
+	 * this bitmap to get too large.  For now, limit it to 1 MiB, which
+	 * limits the file size to about 4.4 TB with SHA-256 and 4K blocks.
+	 *
+	 * Together with the fact that the data, and thus also the Merkle tree,
+	 * cannot have more than ULONG_MAX pages, this implies that hash block
+	 * indices can always fit in an 'unsigned long'.  But to be safe, we
+	 * explicitly check for that too.  Note, this is only for hash block
+	 * indices; data block indices might not fit in an 'unsigned long'.
+	 */
+	if ((params->block_size != PAGE_SIZE && offset > 1 << 23) ||
+	    offset > ULONG_MAX) {
+		fsverity_err(inode, "Too many blocks in Merkle tree");
+		err = -EFBIG;
+		goto out_err;
 	}
 
 	params->tree_size = offset << log_blocksize;
+	params->tree_pages = PAGE_ALIGN(params->tree_size) >> PAGE_SHIFT;
 	return 0;
 
 out_err:
@@ -165,7 +202,7 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 		fsverity_err(inode,
 			     "Error %d initializing Merkle tree parameters",
 			     err);
-		goto out;
+		goto fail;
 	}
 
 	memcpy(vi->root_hash, desc->root_hash, vi->tree_params.digest_size);
@@ -174,7 +211,7 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 				  vi->file_digest);
 	if (err) {
 		fsverity_err(inode, "Error %d computing file digest", err);
-		goto out;
+		goto fail;
 	}
 	pr_debug("Computed file digest: %s:%*phN\n",
 		 vi->tree_params.hash_alg->name,
@@ -182,12 +219,35 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 
 	err = fsverity_verify_signature(vi, desc->signature,
 					le32_to_cpu(desc->sig_size));
-out:
-	if (err) {
-		fsverity_free_info(vi);
-		vi = ERR_PTR(err);
+	if (err)
+		goto fail;
+
+	if (vi->tree_params.block_size != PAGE_SIZE) {
+		/*
+		 * When the Merkle tree block size and page size differ, we use
+		 * a bitmap to keep track of which hash blocks have been
+		 * verified.  This bitmap must contain one bit per hash block,
+		 * including alignment to a page boundary at the end.
+		 */
+		unsigned long num_bits =
+			vi->tree_params.tree_pages <<
+			vi->tree_params.log_blocks_per_page;
+
+		vi->hash_block_verified = kvmalloc_array(
+				BITS_TO_LONGS(num_bits), sizeof(unsigned long),
+				GFP_KERNEL | __GFP_ZERO);
+		if (!vi->hash_block_verified) {
+			err = -ENOMEM;
+			goto fail;
+		}
+		spin_lock_init(&vi->hash_page_init_lock);
 	}
+
 	return vi;
+
+fail:
+	fsverity_free_info(vi);
+	return ERR_PTR(err);
 }
 
 void fsverity_set_info(struct inode *inode, struct fsverity_info *vi)
@@ -214,6 +274,7 @@ void fsverity_free_info(struct fsverity_info *vi)
 	if (!vi)
 		return;
 	kfree(vi->tree_params.hashstate);
+	kvfree(vi->hash_block_verified);
 	kmem_cache_free(fsverity_info_cachep, vi);
 }
 
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 961ba248021f9..e4534b49380be 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -13,32 +13,6 @@
 
 static struct workqueue_struct *fsverity_read_workqueue;
 
-/**
- * hash_at_level() - compute the location of the block's hash at the given level
- *
- * @params:	(in) the Merkle tree parameters
- * @dindex:	(in) the index of the data block being verified
- * @level:	(in) the level of hash we want (0 is leaf level)
- * @hindex:	(out) the index of the hash block containing the wanted hash
- * @hoffset:	(out) the byte offset to the wanted hash within the hash block
- */
-static void hash_at_level(const struct merkle_tree_params *params,
-			  pgoff_t dindex, unsigned int level, pgoff_t *hindex,
-			  unsigned int *hoffset)
-{
-	pgoff_t position;
-
-	/* Offset of the hash within the level's region, in hashes */
-	position = dindex >> (level * params->log_arity);
-
-	/* Index of the hash block in the tree overall */
-	*hindex = params->level_start[level] + (position >> params->log_arity);
-
-	/* Offset of the wanted hash (in bytes) within the hash block */
-	*hoffset = (position & ((1 << params->log_arity) - 1)) <<
-		   (params->log_blocksize - params->log_arity);
-}
-
 static inline int cmp_hashes(const struct fsverity_info *vi,
 			     const u8 *want_hash, const u8 *real_hash,
 			     pgoff_t index, int level)
@@ -56,152 +30,308 @@ static inline int cmp_hashes(const struct fsverity_info *vi,
 	return -EBADMSG;
 }
 
+static bool data_is_zeroed(struct inode *inode, struct page *page,
+			   unsigned int len, unsigned int offset)
+{
+	void *virt = kmap_local_page(page);
+
+	if (memchr_inv(virt + offset, 0, len)) {
+		kunmap_local(virt);
+		fsverity_err(inode, "FILE CORRUPTED!  Data past EOF is not zeroed");
+		return false;
+	}
+	kunmap_local(virt);
+	return true;
+}
+
 /*
- * Verify a single data page against the file's Merkle tree.
+ * Returns true if the hash block with index @hblock_idx in the tree, located in
+ * @hpage, has already been verified.
+ */
+static bool hash_block_verified(struct fsverity_info *vi, struct page *hpage,
+				unsigned long hblock_idx)
+{
+	bool verified;
+	unsigned int blocks_per_page;
+	unsigned int i;
+
+	/*
+	 * When the Merkle tree block size and page size are the same, then the
+	 * ->hash_block_verified bitmap isn't allocated, and we use PG_checked
+	 * to directly indicate whether the page's block has been verified.
+	 *
+	 * Using PG_checked also guarantees that we re-verify hash pages that
+	 * get evicted and re-instantiated from the backing storage, as new
+	 * pages always start out with PG_checked cleared.
+	 */
+	if (!vi->hash_block_verified)
+		return PageChecked(hpage);
+
+	/*
+	 * When the Merkle tree block size and page size differ, we use a bitmap
+	 * to indicate whether each hash block has been verified.
+	 *
+	 * However, we still need to ensure that hash pages that get evicted and
+	 * re-instantiated from the backing storage are re-verified.  To do
+	 * this, we use PG_checked again, but now it doesn't really mean
+	 * "checked".  Instead, now it just serves as an indicator for whether
+	 * the hash page is newly instantiated or not.
+	 *
+	 * The first thread that sees PG_checked=0 must clear the corresponding
+	 * bitmap bits, then set PG_checked=1.  This requires a spinlock.  To
+	 * avoid having to take this spinlock in the common case of
+	 * PG_checked=1, we start with an opportunistic lockless read.
+	 */
+	if (PageChecked(hpage)) {
+		/*
+		 * A read memory barrier is needed here to give ACQUIRE
+		 * semantics to the above PageChecked() test.
+		 */
+		smp_rmb();
+		return test_bit(hblock_idx, vi->hash_block_verified);
+	}
+	spin_lock(&vi->hash_page_init_lock);
+	if (PageChecked(hpage)) {
+		verified = test_bit(hblock_idx, vi->hash_block_verified);
+	} else {
+		blocks_per_page = vi->tree_params.blocks_per_page;
+		hblock_idx = round_down(hblock_idx, blocks_per_page);
+		for (i = 0; i < blocks_per_page; i++)
+			clear_bit(hblock_idx + i, vi->hash_block_verified);
+		/*
+		 * A write memory barrier is needed here to give RELEASE
+		 * semantics to the below SetPageChecked() operation.
+		 */
+		smp_wmb();
+		SetPageChecked(hpage);
+		verified = false;
+	}
+	spin_unlock(&vi->hash_page_init_lock);
+	return verified;
+}
+
+/*
+ * Verify a single data block against the Merkle tree.
  *
  * In principle, we need to verify the entire path to the root node.  However,
- * for efficiency the filesystem may cache the hash pages.  Therefore we need
- * only ascend the tree until an already-verified page is seen, as indicated by
- * the PageChecked bit being set; then verify the path to that page.
+ * for efficiency the filesystem may cache the hash blocks.  Therefore we need
+ * only ascend the tree until an already-verified hash block is seen, and then
+ * verify the path to that block.
  *
- * This code currently only supports the case where the verity block size is
- * equal to PAGE_SIZE.  Doing otherwise would be possible but tricky, since we
- * wouldn't be able to use the PageChecked bit.
- *
- * Note that multiple processes may race to verify a hash page and mark it
- * Checked, but it doesn't matter; the result will be the same either way.
- *
- * Return: true if the page is valid, else false.
+ * Return: %true if the data block is valid, else %false.
  */
-static bool verify_page(struct inode *inode, const struct fsverity_info *vi,
-			struct ahash_request *req, struct page *data_page,
-			unsigned long level0_ra_pages)
+static bool
+verify_data_block(struct inode *inode, struct fsverity_info *vi,
+		  struct ahash_request *req, struct page *data_page,
+		  unsigned int dblock_offset_in_page,
+		  unsigned long max_ra_pages)
 {
 	const struct merkle_tree_params *params = &vi->tree_params;
 	const unsigned int hsize = params->digest_size;
-	const pgoff_t index = data_page->index;
+	const u64 dblock_pos = ((u64)data_page->index << PAGE_SHIFT) +
+			       dblock_offset_in_page;
+	const u64 dblock_idx = dblock_pos >> params->log_blocksize;
 	int level;
 	u8 _want_hash[FS_VERITY_MAX_DIGEST_SIZE];
 	const u8 *want_hash;
 	u8 real_hash[FS_VERITY_MAX_DIGEST_SIZE];
-	struct page *hpages[FS_VERITY_MAX_LEVELS];
-	unsigned int hoffsets[FS_VERITY_MAX_LEVELS];
+	/* The hash blocks that are traversed, indexed by level */
+	struct {
+		/* Page containing the hash block */
+		struct page *page;
+		/* Index of the hash block in the tree overall */
+		unsigned long index;
+		/* Byte offset of the hash block within @page */
+		unsigned int offset_in_page;
+		/* Byte offset of the wanted hash within @page */
+		unsigned int hoffset;
+	} hblocks[FS_VERITY_MAX_LEVELS];
 	int err;
 
-	if (WARN_ON_ONCE(!PageLocked(data_page) || PageUptodate(data_page)))
-		return false;
-
-	pr_debug_ratelimited("Verifying data page %lu...\n", index);
+	if (unlikely(dblock_pos >= inode->i_size)) {
+		/*
+		 * This can happen in the data page spanning EOF when the Merkle
+		 * tree block size is less than the page size.  The Merkle tree
+		 * doesn't cover data blocks fully past EOF.  But the entire
+		 * page spanning EOF can be visible to userspace via a mmap, and
+		 * any part past EOF should be all zeroes.  Therefore, we need
+		 * to verify that any data blocks fully past EOF are all zeroes.
+		 */
+		return data_is_zeroed(inode, data_page, params->block_size,
+				      dblock_offset_in_page);
+	}
 
 	/*
-	 * Starting at the leaf level, ascend the tree saving hash pages along
-	 * the way until we find a verified hash page, indicated by PageChecked;
-	 * or until we reach the root.
+	 * Starting at the leaf level, ascend the tree saving hash blocks along
+	 * the way until we find a hash block that has already been verified, or
+	 * until we reach the root.
 	 */
 	for (level = 0; level < params->num_levels; level++) {
-		pgoff_t hindex;
+		u64 hidx;
+		unsigned long hblock_idx;
+		pgoff_t hpage_idx;
+		unsigned int hblock_offset_in_page;
 		unsigned int hoffset;
 		struct page *hpage;
 
-		hash_at_level(params, index, level, &hindex, &hoffset);
+		/* Offset of the hash within the level's region, in hashes */
+		hidx = dblock_idx >> (level * params->log_arity);
+
+		/* Index of the hash block in the tree overall */
+		hblock_idx = params->level_start[level] +
+			     (hidx >> params->log_arity);
+
+		/* Index of the hash page in the tree overall */
+		hpage_idx = hblock_idx >> params->log_blocks_per_page;
+
+		/* Byte offset of the hash block within the page */
+		hblock_offset_in_page =
+			(hblock_idx & (params->blocks_per_page - 1)) <<
+			params->log_blocksize;
+
+		/* Byte offset of the hash within the page */
+		hoffset = hblock_offset_in_page +
+			  ((hidx & (params->hashes_per_block - 1)) <<
+			   (params->log_blocksize - params->log_arity));
 
-		pr_debug_ratelimited("Level %d: hindex=%lu, hoffset=%u\n",
-				     level, hindex, hoffset);
+		pr_debug_ratelimited("Level %d: hpage_idx=%lu, hoffset=%u\n",
+				     level, hpage_idx, hoffset);
 
-		hpage = inode->i_sb->s_vop->read_merkle_tree_page(inode, hindex,
-				level == 0 ? level0_ra_pages : 0);
+		hpage = inode->i_sb->s_vop->read_merkle_tree_page(inode,
+				hpage_idx, level == 0 ? min(max_ra_pages,
+					params->tree_pages - hpage_idx) : 0);
 		if (IS_ERR(hpage)) {
 			err = PTR_ERR(hpage);
 			fsverity_err(inode,
 				     "Error %d reading Merkle tree page %lu",
-				     err, hindex);
+				     err, hpage_idx);
 			goto out;
 		}
-
-		if (PageChecked(hpage)) {
+		if (hash_block_verified(vi, hpage, hblock_idx)) {
 			memcpy_from_page(_want_hash, hpage, hoffset, hsize);
 			want_hash = _want_hash;
 			put_page(hpage);
-			pr_debug_ratelimited("Hash page already checked, want %s:%*phN\n",
+			pr_debug_ratelimited("Hash block already verified, want %s:%*phN\n",
 					     params->hash_alg->name,
 					     hsize, want_hash);
 			goto descend;
 		}
-		pr_debug_ratelimited("Hash page not yet checked\n");
-		hpages[level] = hpage;
-		hoffsets[level] = hoffset;
+		pr_debug_ratelimited("Hash block not yet verified\n");
+		hblocks[level].page = hpage;
+		hblocks[level].index = hblock_idx;
+		hblocks[level].offset_in_page = hblock_offset_in_page;
+		hblocks[level].hoffset = hoffset;
 	}
 
 	want_hash = vi->root_hash;
 	pr_debug("Want root hash: %s:%*phN\n",
 		 params->hash_alg->name, hsize, want_hash);
 descend:
-	/* Descend the tree verifying hash pages */
+	/* Descend the tree verifying hash blocks. */
 	for (; level > 0; level--) {
-		struct page *hpage = hpages[level - 1];
-		unsigned int hoffset = hoffsets[level - 1];
-
-		err = fsverity_hash_page(params, inode, req, hpage, real_hash);
+		struct page *hpage = hblocks[level - 1].page;
+		unsigned long hblock_idx = hblocks[level - 1].index;
+		unsigned int hblock_offset_in_page =
+			hblocks[level - 1].offset_in_page;
+		unsigned int hoffset = hblocks[level - 1].hoffset;
+
+		err = fsverity_hash_block(params, inode, req, hpage,
+					  hblock_offset_in_page, real_hash);
 		if (err)
 			goto out;
-		err = cmp_hashes(vi, want_hash, real_hash, index, level - 1);
+		err = cmp_hashes(vi, want_hash, real_hash, data_page->index,
+				 level - 1);
 		if (err)
 			goto out;
-		SetPageChecked(hpage);
+		/*
+		 * Mark the hash block as verified.  This must be atomic and
+		 * idempotent, as the same hash block might be verified by
+		 * multiple threads concurrently.
+		 */
+		if (vi->hash_block_verified)
+			set_bit(hblock_idx, vi->hash_block_verified);
+		else
+			SetPageChecked(hpage);
 		memcpy_from_page(_want_hash, hpage, hoffset, hsize);
 		want_hash = _want_hash;
 		put_page(hpage);
-		pr_debug("Verified hash page at level %d, now want %s:%*phN\n",
+		pr_debug("Verified hash block at level %d, now want %s:%*phN\n",
 			 level - 1, params->hash_alg->name, hsize, want_hash);
 	}
 
-	/* Finally, verify the data page */
-	err = fsverity_hash_page(params, inode, req, data_page, real_hash);
+	/* Finally, verify the data block. */
+	err = fsverity_hash_block(params, inode, req, data_page,
+				  dblock_offset_in_page, real_hash);
 	if (err)
 		goto out;
-	err = cmp_hashes(vi, want_hash, real_hash, index, -1);
+	err = cmp_hashes(vi, want_hash, real_hash, data_page->index, -1);
 out:
 	for (; level > 0; level--)
-		put_page(hpages[level - 1]);
+		put_page(hblocks[level - 1].page);
 
 	return err == 0;
 }
 
+static bool
+verify_data_blocks(struct inode *inode, struct fsverity_info *vi,
+		   struct ahash_request *req, struct page *data_page,
+		   unsigned int len, unsigned int offset,
+		   unsigned long max_ra_pages)
+{
+	const unsigned int block_size = vi->tree_params.block_size;
+
+	if (WARN_ON_ONCE(len <= 0 || !IS_ALIGNED(len | offset, block_size)))
+		return false;
+
+	do {
+		if (!verify_data_block(inode, vi, req, data_page, offset,
+				       max_ra_pages))
+			return false;
+		offset += block_size;
+		len -= block_size;
+	} while (len);
+	return true;
+}
+
 /**
- * fsverity_verify_page() - verify a data page
- * @page: the page to verity
+ * fsverity_verify_blocks() - verify data in a page
+ * @page: the page containing the data to verify
+ * @len: the length of the data to verify in the page
+ * @offset: the offset of the data to verify in the page
  *
- * Verify a page that has just been read from a verity file.  The page must be a
- * pagecache page that is still locked and not yet uptodate.
+ * Verify data that has just been read from a verity file.  The data must be
+ * located in a pagecache page that is still locked and not yet uptodate.  The
+ * length and offset of the data must be Merkle tree block size aligned.
  *
- * Return: true if the page is valid, else false.
+ * Return: %true if the data is valid, else %false.
  */
-bool fsverity_verify_page(struct page *page)
+bool fsverity_verify_blocks(struct page *page, unsigned int len,
+			    unsigned int offset)
 {
 	struct inode *inode = page->mapping->host;
-	const struct fsverity_info *vi = inode->i_verity_info;
+	struct fsverity_info *vi = inode->i_verity_info;
 	struct ahash_request *req;
 	bool valid;
 
 	/* This allocation never fails, since it's mempool-backed. */
 	req = fsverity_alloc_hash_request(vi->tree_params.hash_alg, GFP_NOFS);
 
-	valid = verify_page(inode, vi, req, page, 0);
+	valid = verify_data_blocks(inode, vi, req, page, len, offset, 0);
 
 	fsverity_free_hash_request(vi->tree_params.hash_alg, req);
 
 	return valid;
 }
-EXPORT_SYMBOL_GPL(fsverity_verify_page);
+EXPORT_SYMBOL_GPL(fsverity_verify_blocks);
 
 #ifdef CONFIG_BLOCK
 /**
  * fsverity_verify_bio() - verify a 'read' bio that has just completed
  * @bio: the bio to verify
  *
- * Verify a set of pages that have just been read from a verity file.  The pages
- * must be pagecache pages that are still locked and not yet uptodate.  If a
- * page fails verification, then bio->bi_status is set to an error status.
+ * Verify the bio's data against the file's Merkle tree.  All bio data segments
+ * must be aligned to the file's Merkle tree block size.  If any data fails
+ * verification, then bio->bi_status is set to an error status.
  *
  * This is a helper function for use by the ->readahead() method of filesystems
  * that issue bios to read data directly into the page cache.  Filesystems that
@@ -212,15 +342,14 @@ EXPORT_SYMBOL_GPL(fsverity_verify_page);
 void fsverity_verify_bio(struct bio *bio)
 {
 	struct inode *inode = bio_first_page_all(bio)->mapping->host;
-	const struct fsverity_info *vi = inode->i_verity_info;
-	const struct merkle_tree_params *params = &vi->tree_params;
+	struct fsverity_info *vi = inode->i_verity_info;
 	struct ahash_request *req;
 	struct bio_vec *bv;
 	struct bvec_iter_all iter_all;
 	unsigned long max_ra_pages = 0;
 
 	/* This allocation never fails, since it's mempool-backed. */
-	req = fsverity_alloc_hash_request(params->hash_alg, GFP_NOFS);
+	req = fsverity_alloc_hash_request(vi->tree_params.hash_alg, GFP_NOFS);
 
 	if (bio->bi_opf & REQ_RAHEAD) {
 		/*
@@ -232,24 +361,18 @@ void fsverity_verify_bio(struct bio *bio)
 		 * This improves sequential read performance, as it greatly
 		 * reduces the number of I/O requests made to the Merkle tree.
 		 */
-		bio_for_each_segment_all(bv, bio, iter_all)
-			max_ra_pages++;
-		max_ra_pages /= 4;
+		max_ra_pages = bio->bi_iter.bi_size >> (PAGE_SHIFT + 2);
 	}
 
 	bio_for_each_segment_all(bv, bio, iter_all) {
-		struct page *page = bv->bv_page;
-		unsigned long level0_index = page->index >> params->log_arity;
-		unsigned long level0_ra_pages =
-			min(max_ra_pages, params->level0_blocks - level0_index);
-
-		if (!verify_page(inode, vi, req, page, level0_ra_pages)) {
+		if (!verify_data_blocks(inode, vi, req, bv->bv_page, bv->bv_len,
+					bv->bv_offset, max_ra_pages)) {
 			bio->bi_status = BLK_STS_IOERR;
 			break;
 		}
 	}
 
-	fsverity_free_hash_request(params->hash_alg, req);
+	fsverity_free_hash_request(vi->tree_params.hash_alg, req);
 }
 EXPORT_SYMBOL_GPL(fsverity_verify_bio);
 #endif /* CONFIG_BLOCK */
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 40f14e5fed9de..4583ea089abde 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -158,7 +158,8 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg);
 
 /* verify.c */
 
-bool fsverity_verify_page(struct page *page);
+bool fsverity_verify_blocks(struct page *page, unsigned int len,
+			    unsigned int offset);
 void fsverity_verify_bio(struct bio *bio);
 void fsverity_enqueue_verify_work(struct work_struct *work);
 
@@ -218,7 +219,8 @@ static inline int fsverity_ioctl_read_metadata(struct file *filp,
 
 /* verify.c */
 
-static inline bool fsverity_verify_page(struct page *page)
+static inline bool fsverity_verify_blocks(struct page *page, unsigned int len,
+					  unsigned int offset)
 {
 	WARN_ON(1);
 	return false;
@@ -236,6 +238,11 @@ static inline void fsverity_enqueue_verify_work(struct work_struct *work)
 
 #endif	/* !CONFIG_FS_VERITY */
 
+static inline bool fsverity_verify_page(struct page *page)
+{
+	return fsverity_verify_blocks(page, PAGE_SIZE, 0);
+}
+
 /**
  * fsverity_active() - do reads from the inode need to go through fs-verity?
  * @inode: inode to check
-- 
2.38.0

