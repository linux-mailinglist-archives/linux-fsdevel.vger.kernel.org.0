Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111E96D9FA0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 20:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbjDFSQN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 14:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239635AbjDFSQL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:16:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F8EB0;
        Thu,  6 Apr 2023 11:16:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B89D60F7A;
        Thu,  6 Apr 2023 18:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F7BC433EF;
        Thu,  6 Apr 2023 18:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680804968;
        bh=trf5F2WX+RYI6ExpB2fYPeUVtOa9b0dLMtB52AZJZ3I=;
        h=From:To:Cc:Subject:Date:From;
        b=LzuYfVxkj7HHlFc4xhRiXJkc0tcqCtTJr+KYrjvJ8DtKNlFJ//fZcThlZhcDe8YtK
         uKjxoWLKspclLzKOa+wB5TRAGzh2cneyWwMxwDyR3RB393cWrgq6f/gaIwSZ1nUu4X
         D66Aj0AUUEBWWRm9v7LQHs2iP4FKWealJ86KyNPyOjs6N3j7E4JZcBTR+aMKA8tfDC
         bGiNAMBwC/JFrzOTs3mGuJUojowyCSkgxemWZTAXGsNVgSNfjfO0bEd74UJzpBcfXe
         qrt7HtSpxxQQxv7IPDvIN5B0h3My6+GHf9/MABGY+vaTfi0EYq29SgRjJUDQAM/40V
         dZ/4BXPWaHaRA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     fsverity@lists.linux.dev
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2] fsverity: use WARN_ON_ONCE instead of WARN_ON
Date:   Thu,  6 Apr 2023 11:15:42 -0700
Message-Id: <20230406181542.38894-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

As per Linus's suggestion
(https://lore.kernel.org/r/CAHk-=whefxRGyNGzCzG6BVeM=5vnvgb-XhSeFJVxJyAxAF8XRA@mail.gmail.com),
use WARN_ON_ONCE instead of WARN_ON.  This barely adds any extra
overhead, and it makes it so that if any of these ever becomes reachable
(they shouldn't, but that's the point), the logs can't be flooded.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/enable.c       | 4 ++--
 fs/verity/hash_algs.c    | 4 ++--
 fs/verity/open.c         | 2 +-
 include/linux/fsverity.h | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 7a0e3a84d370b..541c2a277c5c6 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -165,7 +165,7 @@ static int build_merkle_tree(struct file *filp,
 		}
 	}
 	/* The root hash was filled by the last call to hash_one_block(). */
-	if (WARN_ON(buffers[num_levels].filled != params->digest_size)) {
+	if (WARN_ON_ONCE(buffers[num_levels].filled != params->digest_size)) {
 		err = -EINVAL;
 		goto out;
 	}
@@ -277,7 +277,7 @@ static int enable_verity(struct file *filp,
 		fsverity_err(inode, "%ps() failed with err %d",
 			     vops->end_enable_verity, err);
 		fsverity_free_info(vi);
-	} else if (WARN_ON(!IS_VERITY(inode))) {
+	} else if (WARN_ON_ONCE(!IS_VERITY(inode))) {
 		err = -EINVAL;
 		fsverity_free_info(vi);
 	} else {
diff --git a/fs/verity/hash_algs.c b/fs/verity/hash_algs.c
index 13fcf31be8441..ea00dbedf756b 100644
--- a/fs/verity/hash_algs.c
+++ b/fs/verity/hash_algs.c
@@ -84,9 +84,9 @@ struct fsverity_hash_alg *fsverity_get_hash_alg(const struct inode *inode,
 	}
 
 	err = -EINVAL;
-	if (WARN_ON(alg->digest_size != crypto_ahash_digestsize(tfm)))
+	if (WARN_ON_ONCE(alg->digest_size != crypto_ahash_digestsize(tfm)))
 		goto err_free_tfm;
-	if (WARN_ON(alg->block_size != crypto_ahash_blocksize(tfm)))
+	if (WARN_ON_ONCE(alg->block_size != crypto_ahash_blocksize(tfm)))
 		goto err_free_tfm;
 
 	err = mempool_init_kmalloc_pool(&alg->req_pool, 1,
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 9366b441d01ca..52048b7630dcc 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -83,7 +83,7 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 	params->log_blocks_per_page = PAGE_SHIFT - log_blocksize;
 	params->blocks_per_page = 1 << params->log_blocks_per_page;
 
-	if (WARN_ON(!is_power_of_2(params->digest_size))) {
+	if (WARN_ON_ONCE(!is_power_of_2(params->digest_size))) {
 		err = -EINVAL;
 		goto out_err;
 	}
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 119a3266791fd..e76605d5b36ee 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -233,18 +233,18 @@ static inline int fsverity_ioctl_read_metadata(struct file *filp,
 static inline bool fsverity_verify_blocks(struct folio *folio, size_t len,
 					  size_t offset)
 {
-	WARN_ON(1);
+	WARN_ON_ONCE(1);
 	return false;
 }
 
 static inline void fsverity_verify_bio(struct bio *bio)
 {
-	WARN_ON(1);
+	WARN_ON_ONCE(1);
 }
 
 static inline void fsverity_enqueue_verify_work(struct work_struct *work)
 {
-	WARN_ON(1);
+	WARN_ON_ONCE(1);
 }
 
 #endif	/* !CONFIG_FS_VERITY */

base-commit: 1238c8b91c5aca6dd13bccb1b4dc716718e7bfac
-- 
2.40.0

