Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6FD65543E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 21:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiLWUg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 15:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiLWUg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:36:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7236C1D309;
        Fri, 23 Dec 2022 12:36:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0630261EED;
        Fri, 23 Dec 2022 20:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4AAC433F0;
        Fri, 23 Dec 2022 20:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671827816;
        bh=iUdBvdNiQeVKQXe2/6eUg98m/CYbzWe1kqf/gTptRGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8C+LgP264e1gacZYiTziQL/GH12JCvASKiy5SXoD1HtZfRYZgkHJnfdt2sNMXL0v
         X34BZqbXGrrKNvyzK3y83BjWzbYzV5+Q1Is+CpOJXNGdxZDkXLyjDTQUga5Q2CZpCw
         OqVIOMlddULiPdjDnZ3AymdRzg1VekEkK3hxKn9z04fj6l6qHYAgUz5kgQN0f41Od9
         gAi0ffWHW59SXVPnfoc5xbsnhxtkkvYOI/9lYfpiJE0UuQWSj5+gwE6Mx9N32bmvLx
         gZsX1DoA4hCdVrVaOBmsJQJMOwKM95SYpLYribt5jmS/hpnI7h7Xb+DI4LHfKiL+mL
         ZLwS/xH9MtKVQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 01/11] fsverity: use unsigned long for level_start
Date:   Fri, 23 Dec 2022 12:36:28 -0800
Message-Id: <20221223203638.41293-2-ebiggers@kernel.org>
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

fs/verity/ isn't consistent with whether Merkle tree block indices are
'unsigned long' or 'u64'.  There's no real point to using u64 for them,
though, since (a) a Merkle tree with over ULONG_MAX blocks would only be
needed for a file larger than MAX_LFS_FILESIZE, and (b) for reads, the
status of all Merkle tree blocks has to be tracked in memory.

Therefore, let's make things a bit more efficient on 32-bit systems by
using 'unsigned long[]' for merkle_tree_params::level_start, instead of
'u64[]'.  Also, to be extra safe, explicitly check that there aren't
more than ULONG_MAX Merkle tree blocks.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/fsverity_private.h |  2 +-
 fs/verity/open.c             | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index a16038a0ee67d..e8b40c8000be7 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -52,7 +52,7 @@ struct merkle_tree_params {
 	 * Starting block index for each tree level, ordered from leaf level (0)
 	 * to root level ('num_levels - 1')
 	 */
-	u64 level_start[FS_VERITY_MAX_LEVELS];
+	unsigned long level_start[FS_VERITY_MAX_LEVELS];
 };
 
 /*
diff --git a/fs/verity/open.c b/fs/verity/open.c
index e0ef1a6283943..83ccc3c137363 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -34,6 +34,7 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 	struct fsverity_hash_alg *hash_alg;
 	int err;
 	u64 blocks;
+	u64 blocks_in_level[FS_VERITY_MAX_LEVELS];
 	u64 offset;
 	int level;
 
@@ -94,17 +95,26 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 		}
 		blocks = (blocks + params->hashes_per_block - 1) >>
 			 params->log_arity;
-		/* temporarily using level_start[] to store blocks in level */
-		params->level_start[params->num_levels++] = blocks;
+		blocks_in_level[params->num_levels++] = blocks;
 	}
-	params->level0_blocks = params->level_start[0];
+	params->level0_blocks = blocks_in_level[0];
 
 	/* Compute the starting block of each level */
 	offset = 0;
 	for (level = (int)params->num_levels - 1; level >= 0; level--) {
-		blocks = params->level_start[level];
 		params->level_start[level] = offset;
-		offset += blocks;
+		offset += blocks_in_level[level];
+	}
+
+	/*
+	 * Since the data, and thus also the Merkle tree, cannot have more than
+	 * ULONG_MAX pages, hash block indices can always fit in an
+	 * 'unsigned long'.  To be safe, explicitly check for it too.
+	 */
+	if (offset > ULONG_MAX) {
+		fsverity_err(inode, "Too many blocks in Merkle tree");
+		err = -EFBIG;
+		goto out_err;
 	}
 
 	params->tree_size = offset << log_blocksize;
-- 
2.39.0

