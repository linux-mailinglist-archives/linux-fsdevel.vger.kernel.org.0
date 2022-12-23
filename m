Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36908655477
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 21:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiLWUhV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 15:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiLWUhJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:37:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65991D307;
        Fri, 23 Dec 2022 12:36:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 673CAB8213F;
        Fri, 23 Dec 2022 20:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F55C433EF;
        Fri, 23 Dec 2022 20:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671827817;
        bh=wN7s/A4toTfgS+KIXn99r7XJg8+e84l5l3auBwZ0mnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+p4IyQ3t6U+M3aSYLY7BTKWPteCG8tVzna1JJQAIpse35DoJuLJVcnL9qLS4mzyh
         k7KwBMCk5nVGNNDuy2jvKNYRFsk5/nDWizFU+pzBPFBHk7xgCOw85MKqG17wjP18lX
         X8T9nGdOTH1z0NJ+Vos6/3qahMbaj5/jamCSA4XFqXx0oI+PtiZ/MgtUbJ2VNW1Rvo
         RCCMc80qeU3NmXJ6t9NCaBooCNzueEY61w6QyElnwELbfer37W5f7YGtJsKYPqErmQ
         41EyJ9E5j5WcBWIHGP00Uhg49JEFBe4CwecifaNHeN7+914nLOLfgCq/fZ5IsWLkaD
         dHUMnqCIZJZgw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 03/11] fsverity: store log2(digest_size) precomputed
Date:   Fri, 23 Dec 2022 12:36:30 -0800
Message-Id: <20221223203638.41293-4-ebiggers@kernel.org>
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

Add log_digestsize to struct merkle_tree_params so that it can be used
in verify.c.  Also save memory by using u8 for all the log_* fields.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/fsverity_private.h | 5 +++--
 fs/verity/open.c             | 3 ++-
 fs/verity/verify.c           | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index 48b97f5d05569..fc1c2797fab19 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -42,8 +42,9 @@ struct merkle_tree_params {
 	unsigned int digest_size;	/* same as hash_alg->digest_size */
 	unsigned int block_size;	/* size of data and tree blocks */
 	unsigned int hashes_per_block;	/* number of hashes per tree block */
-	unsigned int log_blocksize;	/* log2(block_size) */
-	unsigned int log_arity;		/* log2(hashes_per_block) */
+	u8 log_digestsize;		/* log2(digest_size) */
+	u8 log_blocksize;		/* log2(block_size) */
+	u8 log_arity;			/* log2(hashes_per_block) */
 	unsigned int num_levels;	/* number of levels in Merkle tree */
 	u64 tree_size;			/* Merkle tree size in bytes */
 	unsigned long tree_pages;	/* Merkle tree size in pages */
diff --git a/fs/verity/open.c b/fs/verity/open.c
index e356eefb54d7b..ca8de73e5a0b8 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -76,7 +76,8 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 		err = -EINVAL;
 		goto out_err;
 	}
-	params->log_arity = params->log_blocksize - ilog2(params->digest_size);
+	params->log_digestsize = ilog2(params->digest_size);
+	params->log_arity = log_blocksize - params->log_digestsize;
 	params->hashes_per_block = 1 << params->log_arity;
 
 	/*
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 4c57a1bd01afc..d2fcb6a21ea8e 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -35,7 +35,7 @@ static void hash_at_level(const struct merkle_tree_params *params,
 
 	/* Offset of the wanted hash (in bytes) within the hash block */
 	*hoffset = (position & ((1 << params->log_arity) - 1)) <<
-		   (params->log_blocksize - params->log_arity);
+		   params->log_digestsize;
 }
 
 static inline int cmp_hashes(const struct fsverity_info *vi,
-- 
2.39.0

