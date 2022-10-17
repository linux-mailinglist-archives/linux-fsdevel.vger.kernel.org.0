Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184FC601349
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 18:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiJQQSW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 12:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiJQQSK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:18:10 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8396D578;
        Mon, 17 Oct 2022 09:18:09 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e129so10866259pgc.9;
        Mon, 17 Oct 2022 09:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKguiJYDkzC95u9M4wpAvwaM2MiZsshmjZtegeg9N/Q=;
        b=TIQdmVF/NUwB/SC10cgEjN0v81RQV4XfsM2gsj49cKH1uKhnxv8or3N2n+8di1/cy5
         ksaoz6ZWmpfqgJw8oe4LP1eHuU5iYjvbWUdEcIU42mhLa9/DR1wk8eF7w5mkpvuDxH5k
         Frc5J7/dz8+dcZosr/RJ3iVX5qCKTfHNnWy1HOm5YQQsR0JzKvH1BPAQGIjt5eEq7nOy
         urZE6CmYghSeCdoTM33tuH7cESEIQoAjwunqDBnehyZ534twCYrHGJabtZvKdDoSFBGs
         ZNAY7x48BwWy1V5HyLU6HHoSbsJWMrpr0v9p18sup05YIbPm1FGcgcg9E9QW4PD02jDF
         Z3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKguiJYDkzC95u9M4wpAvwaM2MiZsshmjZtegeg9N/Q=;
        b=uFcw9tOtVCl1B8Eb8Z5Nagl6EvfIkBrb6vvijvNQGRg4S8qujJI8hcnWEeG0MddwtJ
         NQVZ9HG+6BUC6d5r1x1p5hjEK1KMn27GIFSM8JgV9OCM3e2+WVLWIEr3+cZ99Xloon75
         PDahgBaFaZ7a9SolT4owcox8cXPAjm60Fx1n6JJ32HV4Z0X+zbaEj66MhyKZ8xPYOW9z
         E9JW0baNC7QCJEShA3nCfIYXC09pZdSmTtQdkH/TKZtZhnyrdOHfNgtpV3hyxM4MIRhi
         A0b2gbqES9FI7KRpDqY0uI3Sh/4mFONyR8T9UGBtdhwTzxD8yTkMh1+G91JY31xsa5aM
         b0Dw==
X-Gm-Message-State: ACrzQf096un1ASDMupN4NpFkrmeSvf1brDv9Ir8AXryAkkxI4Y9ALRB6
        YlWBLOTcrwoFXAhN3LBIfOw=
X-Google-Smtp-Source: AMsMyM6s03W1kgLl5YtFLJYwAnNNLW3lEp+bMieGrzvLyShF1+2uxmb0yhnKBrwbaSQZRb0uJ64giA==
X-Received: by 2002:aa7:888b:0:b0:563:aa1:adae with SMTP id z11-20020aa7888b000000b005630aa1adaemr13235253pfe.15.1666023488527;
        Mon, 17 Oct 2022 09:18:08 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id z22-20020a62d116000000b0055f209690c0sm7272326pfg.50.2022.10.17.09.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:18:08 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 2/2] filemap: find_get_entries() now updates start offset
Date:   Mon, 17 Oct 2022 09:18:00 -0700
Message-Id: <20221017161800.2003-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017161800.2003-1-vishal.moola@gmail.com>
References: <20221017161800.2003-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Initially, find_get_entries() was being passed in the start offset as a
value. That left the calculation of the offset to the callers. This led
to complexity in the callers trying to keep track of the index.

Now find_get_entries() takes in a pointer to the start offset and
updates the value to be directly after the last entry found. If no entry is
found, the offset is not changed. This gets rid of multiple hacky
calculations that kept track of the start offset.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/filemap.c  | 13 +++++++++++--
 mm/internal.h |  2 +-
 mm/shmem.c    | 11 ++++-------
 mm/truncate.c | 19 +++++++------------
 4 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f1fec7bf5b15..804d335504f0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2053,10 +2053,10 @@ static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
  *
  * Return: The number of entries which were found.
  */
-unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
+unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices)
 {
-	XA_STATE(xas, &mapping->i_pages, start);
+	XA_STATE(xas, &mapping->i_pages, *start);
 	struct folio *folio;
 
 	rcu_read_lock();
@@ -2067,6 +2067,15 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 	}
 	rcu_read_unlock();
 
+	if (folio_batch_count(fbatch)) {
+		unsigned long nr = 1;
+		int idx = folio_batch_count(fbatch) - 1;
+
+		folio = fbatch->folios[idx];
+		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+			nr = folio_nr_pages(folio);
+		*start = indices[idx] + nr;
+	}
 	return folio_batch_count(fbatch);
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 14625de6714b..e87982cf1d48 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -106,7 +106,7 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
-unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
+unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 void filemap_free_folio(struct address_space *mapping, struct folio *folio);
 int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
diff --git a/mm/shmem.c b/mm/shmem.c
index 9e17a2b0dc43..8c3c2ac15759 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -983,7 +983,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	while (index < end) {
 		cond_resched();
 
-		if (!find_get_entries(mapping, index, end - 1, &fbatch,
+		if (!find_get_entries(mapping, &index, end - 1, &fbatch,
 				indices)) {
 			/* If all gone or hole-punch or unfalloc, we're done */
 			if (index == start || end != -1)
@@ -995,13 +995,12 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			folio = fbatch.folios[i];
 
-			index = indices[i];
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				if (shmem_free_swap(mapping, index, folio)) {
+				if (shmem_free_swap(mapping, indices[i], folio)) {
 					/* Swap was replaced by page: retry */
-					index--;
+					index = indices[i];
 					break;
 				}
 				nr_swaps_freed++;
@@ -1014,19 +1013,17 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 				if (folio_mapping(folio) != mapping) {
 					/* Page was replaced by swap: retry */
 					folio_unlock(folio);
-					index--;
+					index = indices[i];
 					break;
 				}
 				VM_BUG_ON_FOLIO(folio_test_writeback(folio),
 						folio);
 				truncate_inode_folio(mapping, folio);
 			}
-			index = folio->index + folio_nr_pages(folio) - 1;
 			folio_unlock(folio);
 		}
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
-		index++;
 	}
 
 	spin_lock_irq(&info->lock);
diff --git a/mm/truncate.c b/mm/truncate.c
index 9fbe282e70ba..faeeca45d4ed 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -400,7 +400,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	index = start;
 	while (index < end) {
 		cond_resched();
-		if (!find_get_entries(mapping, index, end - 1, &fbatch,
+		if (!find_get_entries(mapping, &index, end - 1, &fbatch,
 				indices)) {
 			/* If all gone from start onwards, we're done */
 			if (index == start)
@@ -414,21 +414,18 @@ void truncate_inode_pages_range(struct address_space *mapping,
 			struct folio *folio = fbatch.folios[i];
 
 			/* We rely upon deletion not changing page->index */
-			index = indices[i];
 
 			if (xa_is_value(folio))
 				continue;
 
 			folio_lock(folio);
-			VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
+			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
 			folio_wait_writeback(folio);
 			truncate_inode_folio(mapping, folio);
 			folio_unlock(folio);
-			index = folio_index(folio) + folio_nr_pages(folio) - 1;
 		}
 		truncate_folio_batch_exceptionals(mapping, &fbatch, indices);
 		folio_batch_release(&fbatch);
-		index++;
 	}
 }
 EXPORT_SYMBOL(truncate_inode_pages_range);
@@ -636,16 +633,15 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 
 	folio_batch_init(&fbatch);
 	index = start;
-	while (find_get_entries(mapping, index, end, &fbatch, indices)) {
+	while (find_get_entries(mapping, &index, end, &fbatch, indices)) {
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			struct folio *folio = fbatch.folios[i];
 
 			/* We rely upon deletion not changing folio->index */
-			index = indices[i];
 
 			if (xa_is_value(folio)) {
 				if (!invalidate_exceptional_entry2(mapping,
-						index, folio))
+						indices[i], folio))
 					ret = -EBUSY;
 				continue;
 			}
@@ -655,13 +651,13 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 				 * If folio is mapped, before taking its lock,
 				 * zap the rest of the file in one hit.
 				 */
-				unmap_mapping_pages(mapping, index,
-						(1 + end - index), false);
+				unmap_mapping_pages(mapping, indices[i],
+						(1 + end - indices[i]), false);
 				did_range_unmap = 1;
 			}
 
 			folio_lock(folio);
-			VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
+			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
 			if (folio->mapping != mapping) {
 				folio_unlock(folio);
 				continue;
@@ -684,7 +680,6 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
-		index++;
 	}
 	/*
 	 * For DAX we invalidate page tables after invalidating page cache.  We
-- 
2.36.1

