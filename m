Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C195E65544E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 21:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiLWUhE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 15:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbiLWUg7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:36:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74B31DA52;
        Fri, 23 Dec 2022 12:36:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 221B061EF8;
        Fri, 23 Dec 2022 20:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D06C433D2;
        Fri, 23 Dec 2022 20:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671827817;
        bh=Z8CoE1PrgXB4eCUJFPaeZnMBi1T65cAAQrdPuKXjbOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eCLe0H2xFKnziAiqA2LNbf2DlfdqUPb/wum6IDM32pPVFT/cKXXtSWm14HjE4+Qjq
         DFVdyJ76MyUk00jJ9ZNdS5Emr5EPZsLOExbHr+EVn6ADX6sznqcDox+alvSDym6qBU
         GaBvJdK1PG2B7ztRY/vTIuTRoTRQoY0T/nmBF7O5b6clLy12I4r18+8EQslc66iPdu
         YUndUmZry26NfrH+dYisSN06/Imxj9koAbw07slDBCXsxxci7v6qjtNQSMMEBYHvrv
         1qGcgrGGbg/Wxz1MmNaw/uXD7VezoenL7uG3JMipXFVsdoFQeeYmcRJpglaKysu5YD
         v8kkjgNQDRqzQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 05/11] fsverity: replace fsverity_hash_page() with fsverity_hash_block()
Date:   Fri, 23 Dec 2022 12:36:32 -0800
Message-Id: <20221223203638.41293-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221223203638.41293-1-ebiggers@kernel.org>
References: <20221223203638.41293-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In preparation for allowing the Merkle tree block size to differ from
PAGE_SIZE, replace fsverity_hash_page() with fsverity_hash_block().  The
new function is similar to the old one, but it operates on the block at
the given offset in the page instead of on the full page.

(For now, all callers still pass a full page.)

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/enable.c           |  4 ++--
 fs/verity/fsverity_private.h |  6 +++---
 fs/verity/hash_algs.c        | 24 +++++++++++-------------
 fs/verity/verify.c           |  9 +++++----
 4 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 8a9189d479837..144483319f1a3 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -99,8 +99,8 @@ static int build_merkle_tree_level(struct file *filp, unsigned int level,
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
index fc1c2797fab19..23ded939d649f 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -88,9 +88,9 @@ void fsverity_free_hash_request(struct fsverity_hash_alg *alg,
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
index 6f8170cf4ae71..13fcf31be8441 100644
--- a/fs/verity/hash_algs.c
+++ b/fs/verity/hash_algs.c
@@ -220,35 +220,33 @@ const u8 *fsverity_prepare_hash_state(struct fsverity_hash_alg *alg,
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
@@ -264,7 +262,7 @@ int fsverity_hash_page(const struct merkle_tree_params *params,
 
 	err = crypto_wait_req(err, &wait);
 	if (err)
-		fsverity_err(inode, "Error %d computing page hash", err);
+		fsverity_err(inode, "Error %d computing block hash", err);
 	return err;
 }
 
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index d2fcb6a21ea8e..44df06ddcc603 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -125,12 +125,13 @@ static bool verify_page(struct inode *inode, const struct fsverity_info *vi,
 
 	want_hash = vi->root_hash;
 descend:
-	/* Descend the tree verifying hash pages */
+	/* Descend the tree verifying hash blocks. */
 	for (; level > 0; level--) {
 		struct page *hpage = hpages[level - 1];
 		unsigned int hoffset = hoffsets[level - 1];
 
-		err = fsverity_hash_page(params, inode, req, hpage, real_hash);
+		err = fsverity_hash_block(params, inode, req, hpage, 0,
+					  real_hash);
 		if (err)
 			goto out;
 		err = cmp_hashes(vi, want_hash, real_hash, index, level - 1);
@@ -142,8 +143,8 @@ static bool verify_page(struct inode *inode, const struct fsverity_info *vi,
 		put_page(hpage);
 	}
 
-	/* Finally, verify the data page */
-	err = fsverity_hash_page(params, inode, req, data_page, real_hash);
+	/* Finally, verify the data block. */
+	err = fsverity_hash_block(params, inode, req, data_page, 0, real_hash);
 	if (err)
 		goto out;
 	err = cmp_hashes(vi, want_hash, real_hash, index, -1);
-- 
2.39.0

