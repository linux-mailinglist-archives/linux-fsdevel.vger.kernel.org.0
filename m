Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018D576F9A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 07:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjHDFq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 01:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjHDFqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 01:46:23 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376E0212D
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 22:46:21 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-583d702129cso18716577b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Aug 2023 22:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691127980; x=1691732780;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nMTcKrM0/91Zf8Zeg8rjIb8NVhTnUCYvBNvEyCaKgmo=;
        b=kWQZeobcqOvBW3XO281uUDefJA1B2oQmDtSRWHIi91h9RtYTKv6izPtQz7XBdiPUzO
         Sb9cWq9csktzLqyx81H3rnO47mFskd7jEIrfrGZ9i3bBaNkYvSNfmIju/lJ38BXIL5aH
         UJJy5yDGZnzn+Mhiddhebofu3+MUhxDKZiWsUCPYRUS/YR45e0auviscZddxcDUPpyYW
         90bGP1H9b9D90s3CkjN52ouxGP8kLE9WvMZzb/YqcEgG/R0Ky1aswtotNEc1KSvvMzef
         PAdDQcPHE5V4lEZhfIzgvQgJeT1Z4KifT+a9214dVmBhoZ4JBsqryBhfh78xaxvVP9w4
         5rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691127980; x=1691732780;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nMTcKrM0/91Zf8Zeg8rjIb8NVhTnUCYvBNvEyCaKgmo=;
        b=AyNFVDoPUs0VgDAsu+tYfOg2bfimPnWjHg6cICv674OwqCLwqnndYkUxE8hMwNtb/H
         usiMPWvQl+fKPOyuDShY4cMC7hHmWMCliBKjy6Q1Yg0iw/ys6lldAJ2ohMx617Qixfqh
         UxH+eLFJZ3OwxbZ49xk4hyUIu3FV64zMy6Iet6ffs6rg1bLELayPfeiwPhUxfc5z8VyP
         ijPZZq47uU7Y+XmBOJERB3d5pnfmwau9umFFx0ftSMNdk9cARU+45nHIdDbhY2WeecXp
         F3mHIz4LjUXh3VvfMlV8YiKmxl9r2Kfy1Mvqr4o+RYYBYd5kOcIzfecPK0m7s0DYNQjP
         JLXw==
X-Gm-Message-State: AOJu0YyrSjPGOvRCacGpCwo0yoGwCHbjapAVw5x1AVBWag03KAUKXBXI
        X7ZqVCYwAFCd3Ld/CCzY9Vh/qg==
X-Google-Smtp-Source: AGHT+IGHgelWtSWNiIOwK+Z7hskyZ6aMc5Q1zllUtCrQ3fg9mIvxVr6rk/hjG72vAAEDh2C8k2DEAg==
X-Received: by 2002:a0d:db86:0:b0:57a:8456:3401 with SMTP id d128-20020a0ddb86000000b0057a84563401mr673915ywe.29.1691127980295;
        Thu, 03 Aug 2023 22:46:20 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o19-20020a0dcc13000000b00561949f713fsm504382ywd.39.2023.08.03.22.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 22:46:19 -0700 (PDT)
Date:   Thu, 3 Aug 2023 22:46:11 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Christian Brauner <brauner@kernel.org>
cc:     Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH vfs.tmpfs] shmem: move spinlock into shmem_recalc_inode() to
 fix quota support
Message-ID: <29f48045-2cb5-7db-ecf1-72462f1bef5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit "shmem: fix quota lock nesting in huge hole handling" was not so
good: Smatch caught shmem_recalc_inode()'s shmem_inode_unacct_blocks()
descending into quota_send_warning(): where blocking GFP_NOFS is used,
yet shmem_recalc_inode() is called holding the shmem inode's info->lock.

Yes, both __dquot_alloc_space() and __dquot_free_space() are commented
"This operation can block, but only after everything is updated" - when
calling flush_warnings() at the end - both its print_warning() and its
quota_send_warning() may block.

Rework shmem_recalc_inode() to take the shmem inode's info->lock inside,
and drop it before calling shmem_inode_unacct_blocks().

And why were the spin_locks disabling interrupts?  That was just a relic
from when shmem_charge() and shmem_uncharge() were called while holding
i_pages xa_lock: stop disabling interrupts for info->lock now.

To help stop me from making the same mistake again, add a might_sleep()
into shmem_inode_acct_block() and shmem_inode_unacct_blocks(); and those
functions have grown, so let the compiler decide whether to inline them.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-fsdevel/ffd7ca34-7f2a-44ee-b05d-b54d920ce076@moroto.mountain/
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 107 ++++++++++++++++++++++-------------------------------
 1 file changed, 44 insertions(+), 63 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 3ae7c9fb95d7..8ed9487fa6ee 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -203,7 +203,7 @@ static inline void shmem_unacct_blocks(unsigned long flags, long pages)
 		vm_unacct_memory(pages * VM_ACCT(PAGE_SIZE));
 }
 
-static inline int shmem_inode_acct_block(struct inode *inode, long pages)
+static int shmem_inode_acct_block(struct inode *inode, long pages)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
@@ -212,6 +212,7 @@ static inline int shmem_inode_acct_block(struct inode *inode, long pages)
 	if (shmem_acct_block(info->flags, pages))
 		return err;
 
+	might_sleep();	/* when quotas */
 	if (sbinfo->max_blocks) {
 		if (percpu_counter_compare(&sbinfo->used_blocks,
 					   sbinfo->max_blocks - pages) > 0)
@@ -235,11 +236,12 @@ static inline int shmem_inode_acct_block(struct inode *inode, long pages)
 	return err;
 }
 
-static inline void shmem_inode_unacct_blocks(struct inode *inode, long pages)
+static void shmem_inode_unacct_blocks(struct inode *inode, long pages)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 
+	might_sleep();	/* when quotas */
 	dquot_free_block_nodirty(inode, pages);
 
 	if (sbinfo->max_blocks)
@@ -400,30 +402,45 @@ static void shmem_free_inode(struct super_block *sb)
 /**
  * shmem_recalc_inode - recalculate the block usage of an inode
  * @inode: inode to recalc
+ * @alloced: the change in number of pages allocated to inode
+ * @swapped: the change in number of pages swapped from inode
  *
  * We have to calculate the free blocks since the mm can drop
  * undirtied hole pages behind our back.
  *
  * But normally   info->alloced == inode->i_mapping->nrpages + info->swapped
  * So mm freed is info->alloced - (inode->i_mapping->nrpages + info->swapped)
- *
- * It has to be called with the spinlock held.
  */
-static void shmem_recalc_inode(struct inode *inode)
+static void shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	long freed;
 
-	freed = info->alloced - info->swapped - inode->i_mapping->nrpages;
-	if (freed > 0) {
+	spin_lock(&info->lock);
+	info->alloced += alloced;
+	info->swapped += swapped;
+	freed = info->alloced - info->swapped -
+		READ_ONCE(inode->i_mapping->nrpages);
+	/*
+	 * Special case: whereas normally shmem_recalc_inode() is called
+	 * after i_mapping->nrpages has already been adjusted (up or down),
+	 * shmem_writepage() has to raise swapped before nrpages is lowered -
+	 * to stop a racing shmem_recalc_inode() from thinking that a page has
+	 * been freed.  Compensate here, to avoid the need for a followup call.
+	 */
+	if (swapped > 0)
+		freed += swapped;
+	if (freed > 0)
 		info->alloced -= freed;
+	spin_unlock(&info->lock);
+
+	/* The quota case may block */
+	if (freed > 0)
 		shmem_inode_unacct_blocks(inode, freed);
-	}
 }
 
 bool shmem_charge(struct inode *inode, long pages)
 {
-	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct address_space *mapping = inode->i_mapping;
 
 	if (shmem_inode_acct_block(inode, pages))
@@ -434,24 +451,16 @@ bool shmem_charge(struct inode *inode, long pages)
 	mapping->nrpages += pages;
 	xa_unlock_irq(&mapping->i_pages);
 
-	spin_lock_irq(&info->lock);
-	info->alloced += pages;
-	shmem_recalc_inode(inode);
-	spin_unlock_irq(&info->lock);
-
+	shmem_recalc_inode(inode, pages, 0);
 	return true;
 }
 
 void shmem_uncharge(struct inode *inode, long pages)
 {
-	struct shmem_inode_info *info = SHMEM_I(inode);
-
+	/* pages argument is currently unused: keep it to help debugging */
 	/* nrpages adjustment done by __filemap_remove_folio() or caller */
 
-	spin_lock_irq(&info->lock);
-	shmem_recalc_inode(inode);
-	/* which has called shmem_inode_unacct_blocks() if necessary */
-	spin_unlock_irq(&info->lock);
+	shmem_recalc_inode(inode, 0, 0);
 }
 
 /*
@@ -1108,10 +1117,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		folio_batch_release(&fbatch);
 	}
 
-	spin_lock_irq(&info->lock);
-	info->swapped -= nr_swaps_freed;
-	shmem_recalc_inode(inode);
-	spin_unlock_irq(&info->lock);
+	shmem_recalc_inode(inode, 0, -nr_swaps_freed);
 }
 
 void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
@@ -1129,11 +1135,9 @@ static int shmem_getattr(struct mnt_idmap *idmap,
 	struct inode *inode = path->dentry->d_inode;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 
-	if (info->alloced - info->swapped != inode->i_mapping->nrpages) {
-		spin_lock_irq(&info->lock);
-		shmem_recalc_inode(inode);
-		spin_unlock_irq(&info->lock);
-	}
+	if (info->alloced - info->swapped != inode->i_mapping->nrpages)
+		shmem_recalc_inode(inode, 0, 0);
+
 	if (info->fsflags & FS_APPEND_FL)
 		stat->attributes |= STATX_ATTR_APPEND;
 	if (info->fsflags & FS_IMMUTABLE_FL)
@@ -1518,11 +1522,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	if (add_to_swap_cache(folio, swap,
 			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
 			NULL) == 0) {
-		spin_lock_irq(&info->lock);
-		shmem_recalc_inode(inode);
-		info->swapped++;
-		spin_unlock_irq(&info->lock);
-
+		shmem_recalc_inode(inode, 0, 1);
 		swap_shmem_alloc(swap);
 		shmem_delete_from_page_cache(folio, swp_to_radix_entry(swap));
 
@@ -1793,7 +1793,6 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 					 struct folio *folio, swp_entry_t swap)
 {
 	struct address_space *mapping = inode->i_mapping;
-	struct shmem_inode_info *info = SHMEM_I(inode);
 	swp_entry_t swapin_error;
 	void *old;
 
@@ -1806,16 +1805,12 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 
 	folio_wait_writeback(folio);
 	delete_from_swap_cache(folio);
-	spin_lock_irq(&info->lock);
 	/*
-	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks won't
-	 * be 0 when inode is released and thus trigger WARN_ON(inode->i_blocks) in
-	 * shmem_evict_inode.
+	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks
+	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
+	 * in shmem_evict_inode().
 	 */
-	info->alloced--;
-	info->swapped--;
-	shmem_recalc_inode(inode);
-	spin_unlock_irq(&info->lock);
+	shmem_recalc_inode(inode, -1, -1);
 	swap_free(swap);
 }
 
@@ -1902,10 +1897,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	if (error)
 		goto failed;
 
-	spin_lock_irq(&info->lock);
-	info->swapped--;
-	shmem_recalc_inode(inode);
-	spin_unlock_irq(&info->lock);
+	shmem_recalc_inode(inode, 0, -1);
 
 	if (sgp == SGP_WRITE)
 		folio_mark_accessed(folio);
@@ -2070,12 +2062,9 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 					charge_mm);
 	if (error)
 		goto unacct;
-	folio_add_lru(folio);
 
-	spin_lock_irq(&info->lock);
-	info->alloced += folio_nr_pages(folio);
-	shmem_recalc_inode(inode);
-	spin_unlock_irq(&info->lock);
+	folio_add_lru(folio);
+	shmem_recalc_inode(inode, folio_nr_pages(folio), 0);
 	alloced = true;
 
 	if (folio_test_pmd_mappable(folio) &&
@@ -2124,9 +2113,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		if (alloced) {
 			folio_clear_dirty(folio);
 			filemap_remove_folio(folio);
-			spin_lock_irq(&info->lock);
-			shmem_recalc_inode(inode);
-			spin_unlock_irq(&info->lock);
+			shmem_recalc_inode(inode, 0, 0);
 		}
 		error = -EINVAL;
 		goto unlock;
@@ -2152,9 +2139,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		folio_put(folio);
 	}
 	if (error == -ENOSPC && !once++) {
-		spin_lock_irq(&info->lock);
-		shmem_recalc_inode(inode);
-		spin_unlock_irq(&info->lock);
+		shmem_recalc_inode(inode, 0, 0);
 		goto repeat;
 	}
 	if (error == -EEXIST)
@@ -2667,11 +2652,7 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 	if (ret)
 		goto out_delete_from_cache;
 
-	spin_lock_irq(&info->lock);
-	info->alloced++;
-	shmem_recalc_inode(inode);
-	spin_unlock_irq(&info->lock);
-
+	shmem_recalc_inode(inode, 1, 0);
 	folio_unlock(folio);
 	return 0;
 out_delete_from_cache:
-- 
2.35.3
