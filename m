Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188016CB545
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 06:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjC1EEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 00:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC1EEJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 00:04:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942AFDE;
        Mon, 27 Mar 2023 21:04:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B7F6B81A99;
        Tue, 28 Mar 2023 04:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93724C433EF;
        Tue, 28 Mar 2023 04:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679976243;
        bh=U8u8RHtFpIXoTDC+Riv+bh2zpb2DHksLhp8+BIJJ1yw=;
        h=From:To:Subject:Date:From;
        b=QeNSAAS3B9jg2seYIVjg/BMjcTRGxTZgXbZD88xxTmOtDAo57v77whwJpFM1TAJeF
         XH22APpuM3ufAiI0+t9K+xXCbqbh8K2585O+dOMnYGQP//vFowAONw146w3JaWmFVh
         lpAAg8SbvfcrT9Vp94gsvqKE9C0/rhGURDrZAk+31BAgOI6em3MpX4ik7lTN/6wj2D
         D3MYlnQrRJSaqeqiWHREom8M3pQ/Lj4tq6oAfJ27gWjzIsfYmzzjtWpiwu7GkMc3ei
         SXBNz+eyJ67Mz7UHCCjQ+rHtSx9K71lyHLbYOWIaap88KFOog7WDazOOsjGcEg3H1L
         HYi7uVP/NhOlA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fsverity: use WARN_ON_ONCE instead of WARN_ON
Date:   Mon, 27 Mar 2023 21:03:26 -0700
Message-Id: <20230328040326.105018-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/enable.c    | 4 ++--
 fs/verity/hash_algs.c | 4 ++--
 fs/verity/open.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

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

base-commit: 2da81b8479434c62a9ae189ec24729445f74b6a9
-- 
2.40.0

