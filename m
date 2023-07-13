Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4025475242B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjGMNtG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjGMNtC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:49:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4945219B4
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 06:49:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2D7E6153C
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 13:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD39C433C9;
        Thu, 13 Jul 2023 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689256140;
        bh=yJe4lhnTjof59vWoLkGO8Qqi3dVE6gVAeA03pQuGI1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rs1ObEZGwNKqvhMlpwjar7f75Lki51FGjVqCmYvs2qf9HPDqfPZbBD+gMa8rXM0vp
         tEnaAdW8rTV88g0jlrKy8uHObcWL/auXaMhWjP9Gl9wTxSxQbah1NbxSXw+Oso1U6K
         v2PwJU/lW5PlSE7gOtIH3tlAwsxb7KDVvyxe5oqFQ2TBZAhJcQNxAEdAO5x9WG8u/j
         pXw60UM7mT+51vi02bGPEJf+BeOhKgDEg29BR9z6ya1kaRvHLzLRmSfiA1Y45SGN0D
         gd3xSzqBtEHHjYQc7cw8Q2gtFvQFxPHxV8eZzTMmrW0KkEvonsTUjKgPf0bjUHtQql
         zd2BVzpqWvS6A==
From:   cem@kernel.org
To:     linux-fsdevel@vger.kernel.org
Cc:     jack@suse.cz, akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, djwong@kernel.org, hughd@google.com,
        brauner@kernel.org, mcgrof@kernel.org
Subject: [PATCH 1/6] shmem: make shmem_inode_acct_block() return error
Date:   Thu, 13 Jul 2023 15:48:43 +0200
Message-Id: <20230713134848.249779-2-cem@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230713134848.249779-1-cem@kernel.org>
References: <20230713134848.249779-1-cem@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Lukas Czerner <lczerner@redhat.com>

Make shmem_inode_acct_block() return proper error code instead of bool.
This will be useful later when we introduce quota support.

There should be no functional change.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 mm/shmem.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 2f2e0e618072..51d17655a6e1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -199,13 +199,14 @@ static inline void shmem_unacct_blocks(unsigned long flags, long pages)
 		vm_unacct_memory(pages * VM_ACCT(PAGE_SIZE));
 }
 
-static inline bool shmem_inode_acct_block(struct inode *inode, long pages)
+static inline int shmem_inode_acct_block(struct inode *inode, long pages)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	int err = -ENOSPC;
 
 	if (shmem_acct_block(info->flags, pages))
-		return false;
+		return err;
 
 	if (sbinfo->max_blocks) {
 		if (percpu_counter_compare(&sbinfo->used_blocks,
@@ -214,11 +215,11 @@ static inline bool shmem_inode_acct_block(struct inode *inode, long pages)
 		percpu_counter_add(&sbinfo->used_blocks, pages);
 	}
 
-	return true;
+	return 0;
 
 unacct:
 	shmem_unacct_blocks(info->flags, pages);
-	return false;
+	return err;
 }
 
 static inline void shmem_inode_unacct_blocks(struct inode *inode, long pages)
@@ -370,7 +371,7 @@ bool shmem_charge(struct inode *inode, long pages)
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	unsigned long flags;
 
-	if (!shmem_inode_acct_block(inode, pages))
+	if (shmem_inode_acct_block(inode, pages))
 		return false;
 
 	/* nrpages adjustment first, then shmem_recalc_inode() when balanced */
@@ -1588,13 +1589,14 @@ static struct folio *shmem_alloc_and_acct_folio(gfp_t gfp, struct inode *inode,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct folio *folio;
 	int nr;
-	int err = -ENOSPC;
+	int err;
 
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		huge = false;
 	nr = huge ? HPAGE_PMD_NR : 1;
 
-	if (!shmem_inode_acct_block(inode, nr))
+	err = shmem_inode_acct_block(inode, nr);
+	if (err)
 		goto failed;
 
 	if (huge)
@@ -2445,7 +2447,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 	int ret;
 	pgoff_t max_off;
 
-	if (!shmem_inode_acct_block(inode, 1)) {
+	if (shmem_inode_acct_block(inode, 1)) {
 		/*
 		 * We may have got a page, returned -ENOENT triggering a retry,
 		 * and now we find ourselves with -ENOMEM. Release the page, to
-- 
2.39.2

