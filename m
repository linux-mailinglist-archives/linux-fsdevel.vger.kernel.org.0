Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BAD655447
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 21:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiLWUhB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 15:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiLWUg7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:36:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013C81DA4E;
        Fri, 23 Dec 2022 12:36:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 617AB60AC5;
        Fri, 23 Dec 2022 20:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB06C433F1;
        Fri, 23 Dec 2022 20:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671827816;
        bh=t0yAzf0aY4TIwKR3lJb5ncYuHOsUm40J81t2ZXzWYCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OrB9nct0a4D75w6OZb/PSADeO79+yJwZst83UJeD+WY4kVJr7xzqBKafuOYGiydbt
         DFBA/1jsp1UtZ45r05r5BpGhQn58FTfFYWUxdIug8yNDjXpbK1Jk56GbMRE6MTPX/X
         Jg1i+Tk1sadNzYRvqZWbUb1umRD1ailVYXQV97mbspBG8y7C57Z3oLQXhXKYeJPHM4
         +o+7Iyok+em4Zkzw2AkQI+IY8ysPbxMU818Q8qOqubpg5WNVStEQF6M3vNB2sPo8VF
         pneBVurJaEV04Vc1JTOKA10j3s8g/EK1VOdp+hMlfzjzMoe1qWQmZkrO1LHjpjJAIb
         ast7KgPHOwJDA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 02/11] fsverity: simplify Merkle tree readahead size calculation
Date:   Fri, 23 Dec 2022 12:36:29 -0800
Message-Id: <20221223203638.41293-3-ebiggers@kernel.org>
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

First, calculate max_ra_pages more efficiently by using the bio size.

Second, calculate the number of readahead pages from the hash page
index, instead of calculating it ahead of time using the data page
index.  This ends up being a bit simpler, especially since level 0 is
last in the tree, so we can just limit the readahead to the tree size.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/fsverity_private.h |  2 +-
 fs/verity/open.c             |  3 ++-
 fs/verity/verify.c           | 21 +++++++--------------
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index e8b40c8000be7..48b97f5d05569 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -46,7 +46,7 @@ struct merkle_tree_params {
 	unsigned int log_arity;		/* log2(hashes_per_block) */
 	unsigned int num_levels;	/* number of levels in Merkle tree */
 	u64 tree_size;			/* Merkle tree size in bytes */
-	unsigned long level0_blocks;	/* number of blocks in tree level 0 */
+	unsigned long tree_pages;	/* Merkle tree size in pages */
 
 	/*
 	 * Starting block index for each tree level, ordered from leaf level (0)
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 83ccc3c137363..e356eefb54d7b 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -7,6 +7,7 @@
 
 #include "fsverity_private.h"
 
+#include <linux/mm.h>
 #include <linux/slab.h>
 
 static struct kmem_cache *fsverity_info_cachep;
@@ -97,7 +98,6 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 			 params->log_arity;
 		blocks_in_level[params->num_levels++] = blocks;
 	}
-	params->level0_blocks = blocks_in_level[0];
 
 	/* Compute the starting block of each level */
 	offset = 0;
@@ -118,6 +118,7 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 	}
 
 	params->tree_size = offset << log_blocksize;
+	params->tree_pages = PAGE_ALIGN(params->tree_size) >> PAGE_SHIFT;
 	return 0;
 
 out_err:
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index de0d7aef785bf..4c57a1bd01afc 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -74,7 +74,7 @@ static inline int cmp_hashes(const struct fsverity_info *vi,
  */
 static bool verify_page(struct inode *inode, const struct fsverity_info *vi,
 			struct ahash_request *req, struct page *data_page,
-			unsigned long level0_ra_pages)
+			unsigned long max_ra_pages)
 {
 	const struct merkle_tree_params *params = &vi->tree_params;
 	const unsigned int hsize = params->digest_size;
@@ -103,7 +103,8 @@ static bool verify_page(struct inode *inode, const struct fsverity_info *vi,
 		hash_at_level(params, index, level, &hindex, &hoffset);
 
 		hpage = inode->i_sb->s_vop->read_merkle_tree_page(inode, hindex,
-				level == 0 ? level0_ra_pages : 0);
+				level == 0 ? min(max_ra_pages,
+					params->tree_pages - hindex) : 0);
 		if (IS_ERR(hpage)) {
 			err = PTR_ERR(hpage);
 			fsverity_err(inode,
@@ -199,14 +200,13 @@ void fsverity_verify_bio(struct bio *bio)
 {
 	struct inode *inode = bio_first_page_all(bio)->mapping->host;
 	const struct fsverity_info *vi = inode->i_verity_info;
-	const struct merkle_tree_params *params = &vi->tree_params;
 	struct ahash_request *req;
 	struct bio_vec *bv;
 	struct bvec_iter_all iter_all;
 	unsigned long max_ra_pages = 0;
 
 	/* This allocation never fails, since it's mempool-backed. */
-	req = fsverity_alloc_hash_request(params->hash_alg, GFP_NOFS);
+	req = fsverity_alloc_hash_request(vi->tree_params.hash_alg, GFP_NOFS);
 
 	if (bio->bi_opf & REQ_RAHEAD) {
 		/*
@@ -218,24 +218,17 @@ void fsverity_verify_bio(struct bio *bio)
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
+		if (!verify_page(inode, vi, req, bv->bv_page, max_ra_pages)) {
 			bio->bi_status = BLK_STS_IOERR;
 			break;
 		}
 	}
 
-	fsverity_free_hash_request(params->hash_alg, req);
+	fsverity_free_hash_request(vi->tree_params.hash_alg, req);
 }
 EXPORT_SYMBOL_GPL(fsverity_verify_bio);
 #endif /* CONFIG_BLOCK */
-- 
2.39.0

