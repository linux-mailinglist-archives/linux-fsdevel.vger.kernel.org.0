Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66859761C22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 16:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjGYOpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 10:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjGYOpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:45:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD215116
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 07:45:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B70C6178F
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 14:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76547C433C9;
        Tue, 25 Jul 2023 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690296335;
        bh=FqduMW218UjXbigOXgHtnWEu6jRYoPHoS15ts7Vta+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tz5z1Bt1rRRlUekc6O6q7KfGynmu+z+ELJkl6mLrLYvuMugTk7pV0o6kHp5yfkS52
         xaHg+jlh7iYD77h5HRAjCe0bcAuub2a19HFUEAg4gBHejxGIrUNnuvzCPrFhnAg3RF
         bGRz4ubaQYbB7Wopc6aqu4uLS2VVLMtvnHkh4PraPGBpnWTXSxmruDXY5refk3/cGf
         z/Wtnqh9kcf2bExBfJwbf47O+4ullVjPLWzWBvYDKSBSOuCWInzIYMhOMU62AuPlFq
         k0qHd0/Vjh9HajsegiiW7cI1fUYiAKFpXEcsxqYPgBrd2XP8aaCWVVUmOn9sY3AfmS
         1wTjybPZC+xyA==
From:   cem@kernel.org
To:     linux-fsdevel@vger.kernel.org
Cc:     jack@suse.cz, akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, djwong@kernel.org, hughd@google.com,
        brauner@kernel.org, mcgrof@kernel.org
Subject: [PATCH 7/7] shmem: fix quota lock nesting in huge hole handling
Date:   Tue, 25 Jul 2023 16:45:10 +0200
Message-Id: <20230725144510.253763-8-cem@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230725144510.253763-1-cem@kernel.org>
References: <20230725144510.253763-1-cem@kernel.org>
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

From: Hugh Dickins <hughd@google.com>

i_pages lock nests inside i_lock, but shmem_charge() and shmem_uncharge()
were being called from THP splitting or collapsing while i_pages lock was
held, and now go on to call dquot_alloc_block_nodirty() which takes
i_lock to update i_blocks.

We may well want to take i_lock out of this path later, in the non-quota
case even if it's left in the quota case (or perhaps use i_lock instead
of shmem's info->lock throughout); but don't get into that at this time.

Move the shmem_charge() and shmem_uncharge() calls out from under i_pages
lock, accounting the full batch of holes in a single call.

Still pass the pages argument to shmem_uncharge(), but it happens now to
be unused: shmem_recalc_inode() is designed to account for clean pages
freed behind shmem's back, so it gets the accounting right by itself;
then the later call to shmem_inode_unacct_blocks() led to imbalance
(that WARN_ON(inode->i_blocks) in shmem_evict_inode()).

Reported-by: syzbot+38ca19393fb3344f57e6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/0000000000008e62f40600bfe080@google.com/
Reported-by: syzbot+440ff8cca06ee7a1d4db@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/00000000000076a7840600bfb6e8@google.com/
Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Tested-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 mm/huge_memory.c |  6 ++++--
 mm/khugepaged.c  | 13 +++++++------
 mm/shmem.c       | 19 +++++++++----------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index eb3678360b97..d301c323c69a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2521,7 +2521,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	struct address_space *swap_cache = NULL;
 	unsigned long offset = 0;
 	unsigned int nr = thp_nr_pages(head);
-	int i;
+	int i, nr_dropped = 0;
 
 	/* complete memcg works before add pages to LRU */
 	split_page_memcg(head, nr);
@@ -2546,7 +2546,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 			struct folio *tail = page_folio(head + i);
 
 			if (shmem_mapping(head->mapping))
-				shmem_uncharge(head->mapping->host, 1);
+				nr_dropped++;
 			else if (folio_test_clear_dirty(tail))
 				folio_account_cleaned(tail,
 					inode_to_wb(folio->mapping->host));
@@ -2583,6 +2583,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	}
 	local_irq_enable();
 
+	if (nr_dropped)
+		shmem_uncharge(head->mapping->host, nr_dropped);
 	remap_page(folio, nr);
 
 	if (PageSwapCache(head)) {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 78c8d5d8b628..47d1d32c734f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1955,10 +1955,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 						goto xa_locked;
 					}
 				}
-				if (!shmem_charge(mapping->host, 1)) {
-					result = SCAN_FAIL;
-					goto xa_locked;
-				}
 				nr_none++;
 				continue;
 			}
@@ -2145,8 +2141,13 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	 */
 	try_to_unmap_flush();
 
-	if (result != SCAN_SUCCEED)
+	if (result == SCAN_SUCCEED && nr_none &&
+	    !shmem_charge(mapping->host, nr_none))
+		result = SCAN_FAIL;
+	if (result != SCAN_SUCCEED) {
+		nr_none = 0;
 		goto rollback;
+	}
 
 	/*
 	 * The old pages are locked, so they won't change anymore.
@@ -2283,8 +2284,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	if (nr_none) {
 		xas_lock_irq(&xas);
 		mapping->nrpages -= nr_none;
-		shmem_uncharge(mapping->host, nr_none);
 		xas_unlock_irq(&xas);
+		shmem_uncharge(mapping->host, nr_none);
 	}
 
 	list_for_each_entry_safe(page, tmp, &pagelist, lru) {
diff --git a/mm/shmem.c b/mm/shmem.c
index bd02909bacd6..5f83c18abc45 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -424,18 +424,20 @@ static void shmem_recalc_inode(struct inode *inode)
 bool shmem_charge(struct inode *inode, long pages)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	unsigned long flags;
+	struct address_space *mapping = inode->i_mapping;
 
 	if (shmem_inode_acct_block(inode, pages))
 		return false;
 
 	/* nrpages adjustment first, then shmem_recalc_inode() when balanced */
-	inode->i_mapping->nrpages += pages;
+	xa_lock_irq(&mapping->i_pages);
+	mapping->nrpages += pages;
+	xa_unlock_irq(&mapping->i_pages);
 
-	spin_lock_irqsave(&info->lock, flags);
+	spin_lock_irq(&info->lock);
 	info->alloced += pages;
 	shmem_recalc_inode(inode);
-	spin_unlock_irqrestore(&info->lock, flags);
+	spin_unlock_irq(&info->lock);
 
 	return true;
 }
@@ -443,16 +445,13 @@ bool shmem_charge(struct inode *inode, long pages)
 void shmem_uncharge(struct inode *inode, long pages)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	unsigned long flags;
 
 	/* nrpages adjustment done by __filemap_remove_folio() or caller */
 
-	spin_lock_irqsave(&info->lock, flags);
-	info->alloced -= pages;
+	spin_lock_irq(&info->lock);
 	shmem_recalc_inode(inode);
-	spin_unlock_irqrestore(&info->lock, flags);
-
-	shmem_inode_unacct_blocks(inode, pages);
+	/* which has called shmem_inode_unacct_blocks() if necessary */
+	spin_unlock_irq(&info->lock);
 }
 
 /*
-- 
2.39.2

