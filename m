Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9A75FBD3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 23:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJKV5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 17:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJKV5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:57:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC779E0EF;
        Tue, 11 Oct 2022 14:57:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso245954pjk.1;
        Tue, 11 Oct 2022 14:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3WvdRkzSdLVTgj44Ys6XklIheIaxbrqec5BQ0TfTfc=;
        b=EcEBClDeo6ogTrRId+6TLulSFrp2uvrU+ZkBvLmCm/JAUYaMDshArhrjPjASJyWpjD
         0XcrucWAEo5V+aKPBXl9o2biWj7vnOssQnsSa3MUmP8tm/CVyQcYe9op9mTL8+KueHrU
         Tbee5GWcb3LlXal/kFRUxbtqVWsnEezH5ynVxgLyrJFklrLxr5A7X5K2VR9ZYsaC8CJR
         Uj0lhF1aJEDuLlR1Sv8JB8Tyw/azUGoAJGDIK44DUxynYCuD/VxMLhPFUWU++voFSkAO
         OcR/qEjtWfnbPkj/a2JC+TOGNfTKTePy9UoWMZK7rNdFavGeqkGp4Md4exQ4hNbqe2sq
         wwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3WvdRkzSdLVTgj44Ys6XklIheIaxbrqec5BQ0TfTfc=;
        b=WSkGC0GN8A9ugHSHGjkDEtLr+jaJbgs5cQv8HnEtj05gnBsxpq8rh2oqukqplYJRHB
         /OiJqXEfxfOVJZmxSuQ5+YuFzebZohLs7MrPUkl+HdvRYSn2REttFIDpDgArk80Dmh0Y
         cSae2h/n+H9cp9DwXUPVXBP+G+DesrAaObYK2Fls3490GOT3FwCwn3+sunFI9pWSl9sI
         /spS0lMf6jRXjostUIVVr/wa970JjTi7m2098cFZRiu+ly7t4jV6rRQhQOVwj7W9dY+f
         RKG2hGYF09WIXhlD1jIfCqCcWTeG6ce0O3aTBhsnTN9q8Pqz0O4YGCDd03e6vq/S7QTZ
         u74Q==
X-Gm-Message-State: ACrzQf12HAKH+m5gjzdSd6ZQE4RVc4mI9YUdKlP+7hNRSK8iGBWhB8Zc
        hphQ7VSN9VrXLkjuNGAdK6w=
X-Google-Smtp-Source: AMsMyM6wjMzwhiGk87FX5YgO5U51L5rHNxunbkLzsRulGcSgra54n7TeCV+744ohlWrnCtmZWeJhAg==
X-Received: by 2002:a17:903:210d:b0:184:1881:bfe6 with SMTP id o13-20020a170903210d00b001841881bfe6mr2841548ple.80.1665525429934;
        Tue, 11 Oct 2022 14:57:09 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id z17-20020a170903019100b0018123556931sm6580371plg.204.2022.10.11.14.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 14:57:09 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 1/4] filemap: find_lock_entries() now updates start offset
Date:   Tue, 11 Oct 2022 14:56:31 -0700
Message-Id: <20221011215634.478330-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221011215634.478330-1-vishal.moola@gmail.com>
References: <20221011215634.478330-1-vishal.moola@gmail.com>
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

Initially, find_lock_entries() was being passed in the start offset as a
value. That left the calculation of the offset to the callers. This led
to complexity in the callers trying to keep track of the index.

Now find_lock_entires() takes in a pointer to the start offset and
updates the value to be directly after the last entry found. If no entry is
found, the offset is not changed. This gets rid of multiple hacky
calculations that kept track of the start offset.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/filemap.c  | 17 ++++++++++++++---
 mm/internal.h |  2 +-
 mm/shmem.c    |  8 ++------
 mm/truncate.c | 12 ++++--------
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 08341616ae7a..e95500b07ee9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2084,17 +2084,19 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
  * locked or folios under writeback.
  *
  * Return: The number of entries which were found.
+ * Also updates @start to be positioned after the last found entry
  */
-unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
+unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices)
 {
-	XA_STATE(xas, &mapping->i_pages, start);
+	XA_STATE(xas, &mapping->i_pages, *start);
+	unsigned long nr;
 	struct folio *folio;
 
 	rcu_read_lock();
 	while ((folio = find_get_entry(&xas, end, XA_PRESENT))) {
 		if (!xa_is_value(folio)) {
-			if (folio->index < start)
+			if (folio->index < *start)
 				goto put;
 			if (folio->index + folio_nr_pages(folio) - 1 > end)
 				goto put;
@@ -2116,7 +2118,16 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 		folio_put(folio);
 	}
 	rcu_read_unlock();
+	nr = folio_batch_count(fbatch);
+
+	if (nr) {
+		folio = fbatch->folios[nr - 1];
+		nr = folio_nr_pages(folio);
 
+		if (folio_test_hugetlb(folio))
+			nr = 1;
+		*start = folio->index + nr;
+	}
 	return folio_batch_count(fbatch);
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 6b7ef495b56d..c504ac7267e0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -106,7 +106,7 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 	force_page_cache_ra(&ractl, nr_to_read);
 }
 
-unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
+unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
diff --git a/mm/shmem.c b/mm/shmem.c
index 86214d48dd09..ab4f6dfcf6bb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -922,21 +922,18 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 
 	folio_batch_init(&fbatch);
 	index = start;
-	while (index < end && find_lock_entries(mapping, index, end - 1,
+	while (index < end && find_lock_entries(mapping, &index, end - 1,
 			&fbatch, indices)) {
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			folio = fbatch.folios[i];
 
-			index = indices[i];
-
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
 				nr_swaps_freed += !shmem_free_swap(mapping,
-								index, folio);
+							folio->index, folio);
 				continue;
 			}
-			index += folio_nr_pages(folio) - 1;
 
 			if (!unfalloc || !folio_test_uptodate(folio))
 				truncate_inode_folio(mapping, folio);
@@ -945,7 +942,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
-		index++;
 	}
 
 	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
diff --git a/mm/truncate.c b/mm/truncate.c
index c0be77e5c008..b0bd63b2359f 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -361,9 +361,8 @@ void truncate_inode_pages_range(struct address_space *mapping,
 
 	folio_batch_init(&fbatch);
 	index = start;
-	while (index < end && find_lock_entries(mapping, index, end - 1,
+	while (index < end && find_lock_entries(mapping, &index, end - 1,
 			&fbatch, indices)) {
-		index = indices[folio_batch_count(&fbatch) - 1] + 1;
 		truncate_folio_batch_exceptionals(mapping, &fbatch, indices);
 		for (i = 0; i < folio_batch_count(&fbatch); i++)
 			truncate_cleanup_folio(fbatch.folios[i]);
@@ -510,20 +509,18 @@ unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
 	int i;
 
 	folio_batch_init(&fbatch);
-	while (find_lock_entries(mapping, index, end, &fbatch, indices)) {
+	while (find_lock_entries(mapping, &index, end, &fbatch, indices)) {
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			struct folio *folio = fbatch.folios[i];
 
 			/* We rely upon deletion not changing folio->index */
-			index = indices[i];
 
 			if (xa_is_value(folio)) {
 				count += invalidate_exceptional_entry(mapping,
-								      index,
-								      folio);
+								  folio->index,
+								  folio);
 				continue;
 			}
-			index += folio_nr_pages(folio) - 1;
 
 			ret = mapping_evict_folio(mapping, folio);
 			folio_unlock(folio);
@@ -542,7 +539,6 @@ unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
-		index++;
 	}
 	return count;
 }
-- 
2.36.1

