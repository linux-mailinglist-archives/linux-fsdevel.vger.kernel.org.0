Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056E66D3F62
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 10:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjDCIsV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 04:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjDCIsS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:48:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69BC3AB2
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 01:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79DD4B815CC
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 08:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B30C4339C;
        Mon,  3 Apr 2023 08:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680511695;
        bh=+0zQcAzsOXQwjktjWL0vkvwn0ez4Qoz15/Uz4pSYjMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOVUClk0KIZTDvpV3mvscFtpPF2E9p2tSjwXXXd55omX9+Sfl9gFfAWAZmnCJ8kqJ
         FxLGZtvPAUrXSVeV7xmWw6dWcj/NjHCCyhwJrkB5ZGVgRZXF7cKRpcqbZqwv9HE/Yj
         r44b6K6TLCdBm2O5W/xRmSIuu847/MGlQJyDQbZIbalse40bineyZYJc02fS/00J2f
         rDYithEgtWpu8kQ/IRRVEL/cnARFe6+xobqFzCf1DZuE8siuUrspndsHw9PpshtPgv
         ZXmX35H4eoi77BDXgPX6dim4BEdyK5CK0aISXVTRslWBmKhDm/03ApltyBev1YNESx
         gXMRZcHXp811g==
From:   cem@kernel.org
To:     hughd@google.com
Cc:     jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: [PATCH 1/6] shmem: make shmem_inode_acct_block() return error
Date:   Mon,  3 Apr 2023 10:47:54 +0200
Message-Id: <20230403084759.884681-2-cem@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230403084759.884681-1-cem@kernel.org>
References: <20230403084759.884681-1-cem@kernel.org>
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

From: Lukas Czerner <lczerner@redhat.com>

Make shmem_inode_acct_block() return proper error code instead of bool.
This will be useful later when we introduce quota support.

There should be no functional change.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 mm/shmem.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 448f393d8ab2b..0e63ea5f6ce69 100644
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
@@ -1589,7 +1590,8 @@ static struct folio *shmem_alloc_and_acct_folio(gfp_t gfp, struct inode *inode,
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

