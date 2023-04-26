Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5B36EF1CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 12:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbjDZKUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 06:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbjDZKUS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7106E35AC
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Apr 2023 03:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1F2E62D6B
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Apr 2023 10:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C341C4339B;
        Wed, 26 Apr 2023 10:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682504416;
        bh=yQxEH8B7hcia0LdUCOjtWF8FC0yJn1kyiVdffv5361U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHk783SYrc9I9mMYpULwfhg3/zQNX6ji12MXF4SlZYPJ10EhLGFxJLhSwEMataGU7
         HJNDyqcqXCqG7wspV3IQcYqnQg2b2ogrcCu1yJG00TdUGvkVAyodSQ6piMvgzeViaa
         a2CjwQ+FeoEROBTsiT9kvFXWXC6R4NOEpHIhwjWeR/BINgSIsHJb9rK3Avd9bV4BYQ
         I/GcekEsiB7AjnsW+/9WrPB/6N2TjEEqumaOBGSgJ82lqlI2cYPE8kphXIUr/7gsNS
         N+eCSjDyQeagwVgN3hy/RwCQhWVALX1cSYwI7kTqn3RtNjntAOkJ8rP0iOiWD4M6XE
         Bp9gdo1MXUR8g==
From:   cem@kernel.org
To:     hughd@google.com
Cc:     jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: [PATCH 1/6] shmem: make shmem_inode_acct_block() return error
Date:   Wed, 26 Apr 2023 12:20:03 +0200
Message-Id: <20230426102008.2930932-2-cem@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230426102008.2930932-1-cem@kernel.org>
References: <20230426102008.2930932-1-cem@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 448f393d8ab2b..b1b3b826f6189 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -198,13 +198,14 @@ static inline void shmem_unacct_blocks(unsigned long flags, long pages)
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
@@ -213,11 +214,11 @@ static inline bool shmem_inode_acct_block(struct inode *inode, long pages)
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
@@ -369,7 +370,7 @@ bool shmem_charge(struct inode *inode, long pages)
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	unsigned long flags;
 
-	if (!shmem_inode_acct_block(inode, pages))
+	if (shmem_inode_acct_block(inode, pages))
 		return false;
 
 	/* nrpages adjustment first, then shmem_recalc_inode() when balanced */
@@ -1583,13 +1584,14 @@ static struct folio *shmem_alloc_and_acct_folio(gfp_t gfp, struct inode *inode,
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
@@ -2433,7 +2435,7 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	int ret;
 	pgoff_t max_off;
 
-	if (!shmem_inode_acct_block(inode, 1)) {
+	if (shmem_inode_acct_block(inode, 1)) {
 		/*
 		 * We may have got a page, returned -ENOENT triggering a retry,
 		 * and now we find ourselves with -ENOMEM. Release the page, to
-- 
2.30.2

