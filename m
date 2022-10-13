Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0F25FE5BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 00:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJMW6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 18:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJMW6E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:58:04 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2901F1781CF;
        Thu, 13 Oct 2022 15:57:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id f23so3135178plr.6;
        Thu, 13 Oct 2022 15:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9bFubddI7+LphibKGGsyeFrDKSrtJVqH6WoZiz/0OA=;
        b=izj+aFrM2A2YLCP8N2Z1OeEPjJ3QDtEAYp3/EAZxWX84usO2nGiTCNwPOiEljhuObH
         GT8PZO9wo+C0EyBnKLTSwja7tYV0oUy39jQjvPjZcZrlpZdvh1AUvw47wgTod2EV1O4A
         Q6l91qtcBv3ko1ZYGIBptB3q4weFCVJAh9/Ft/SPwRBv/CrXPsVeAgBy1AzvRGxBYRnm
         f4lF2st1UCtoh7vPNM512wR2oK64S1kRtc7ZbkHaJWWhlkw9uo2CPiklkzNZ4waG5O9b
         gYoLljt/LHA1LuLDXW1tyRh637U72Kb9ZTpV2yXjrNfw4t+Y/rRgYOWFSTxkBYm9vM5S
         LI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9bFubddI7+LphibKGGsyeFrDKSrtJVqH6WoZiz/0OA=;
        b=kghgYM2Cm9oiwv2aPGLXZlZ2DcBLFh95BCPWW/VuiMyVikJ1RCDsVkKADJTzz5vLqJ
         KKv+lyspvsd/pueD1FSgVp6JjUE7/FATEhBm8F663o+e3umhr2thp8hy3+hfG6PHb+qy
         ApH1ezYPZYWoFhF6NUi7fHM2PmitqGf/GD624sbIX6dy/SfTHRh4lisSBMQVXyVPlZvP
         4ExpbRQkmGD6/A7ZKtOcEDKj/PulidtglhlHMwGyoORIGGLgHTHOdf+zDYGUSWglulCw
         RJOioI7zKQWF3FB3HVXaU6z0S2QBGYg30nuDm1ED9jtcT75UCC4RC3xq6r0tETGH9emE
         Ndhw==
X-Gm-Message-State: ACrzQf01d0RFbCgGbsjQDM2jED2zoLkUX2Hp0LiSyyy0APuja2GFurjJ
        wpkni0bm3df12PnT9ODlaHHhS1Glsn4qOg==
X-Google-Smtp-Source: AMsMyM4+mX8wZ+lqkAPXL//k45qm7r2YiR8F+rJTouER/FcREWcnYsnlEXuxCOR0dVytZN+0gT0GjQ==
X-Received: by 2002:a17:90b:384:b0:20d:aa78:92da with SMTP id ga4-20020a17090b038400b0020daa7892damr5173642pjb.159.1665701851641;
        Thu, 13 Oct 2022 15:57:31 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id lx4-20020a17090b4b0400b001fde655225fsm7480269pjb.2.2022.10.13.15.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:57:30 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 2/2] filemap: find_get_entries() now updates start offset
Date:   Thu, 13 Oct 2022 15:57:08 -0700
Message-Id: <20221013225708.1879-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221013225708.1879-1-vishal.moola@gmail.com>
References: <20221013225708.1879-1-vishal.moola@gmail.com>
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

Now find_get_entires() takes in a pointer to the start offset and
updates the value to be directly after the last entry found. If no entry is
found, the offset is not changed. This gets rid of multiple hacky
calculations that kept track of the start offset.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/filemap.c  | 15 ++++++++++++---
 mm/internal.h |  2 +-
 mm/shmem.c    | 11 ++++-------
 mm/truncate.c | 19 +++++++------------
 4 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b6aaded95132..ed66fecf06d9 100644
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
@@ -2065,8 +2065,17 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 		if (!folio_batch_add(fbatch, folio))
 			break;
 	}
-	rcu_read_unlock();
 
+	if (folio_batch_count(fbatch)) {
+		unsigned long nr = 1;
+		int idx = folio_batch_count(fbatch) - 1;
+
+		folio = fbatch->folios[idx];
+		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+			nr = folio_nr_pages(folio);
+		*start = indices[idx] + nr;
+	}
+	rcu_read_unlock();
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

