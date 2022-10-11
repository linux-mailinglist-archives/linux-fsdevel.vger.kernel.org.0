Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8712B5FBD3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 23:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJKV5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 17:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJKV5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:57:12 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540E09E2CF;
        Tue, 11 Oct 2022 14:57:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b15so13661570pje.1;
        Tue, 11 Oct 2022 14:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AXBXWk9KM8i6fKoe7c/6PSVGCSRYeW1GgiDFc8Dazo=;
        b=RcSCx6GfPgO1zqmEGbdDQcTUwIoMsiDavOa4LQzTIn/Kys1oeo6SjCBVThk33JTJqV
         lbJEHsFMZ7YTdE6nlgQh0eJxcFSzAqG4mXO8UOH0FDwsbOa2HIBnETyCkzMogatR+KjZ
         C5hu0sQPVZOOV1U766tB+LuH2Mg5cvwNUcHT2qaELJW4eV5wj8/v7aRQ5McJgFUCt6lL
         2GC+XXnttD4uZbATsL6DOkqDgmFtFMH6ir67cYUdZTnN/veUnWCSMWLBjX6lp/NyZ+m9
         RiOym3by81erUatbFgimWcCXnDcUnH9AAe8EHyx1Y3JDbKPa7BXFS5ISqh2IKGkwUSmZ
         hryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AXBXWk9KM8i6fKoe7c/6PSVGCSRYeW1GgiDFc8Dazo=;
        b=wuQCVh9yyK8zfRzuvxtE00a8tMfbfkiATLtxq9uqCBFxrq3hK1VMExBycHgcWRqC4f
         8qqh2/cA3iVBmOlWuQ+xfj9OmmvFJjUPLO0GrrmrE8LfbnIIov2Zqra7a+PKe/qudJGY
         xajWzKPlr1zGZesun/Le1GLGcZ+GViuM7o9eOap2KX3ETTVouhHg6BVFaXVGEF8dd6pK
         MyrJAMyAh8VOSjCEBSGydzvLhM5HHZvny/NtaRTWYCpz20ZmBmKbFYseRqjTs+DGbN3T
         RGnLCNMrq4cIMj9TAjrGff3v/hDXpJMfJigLXzzGlwtrzwRW4fSvCpHoQUuR5ucEGa3w
         3n2w==
X-Gm-Message-State: ACrzQf3S1XJq4cX+eu/DWs8dJ3AwCPZeonZYKYpOeBPA33mLh59d1Usx
        NzMeMvTvitNyoHcLIbhAG1C3PEME5qEqxw==
X-Google-Smtp-Source: AMsMyM5iKzVl/ZJYl342ueaPo+/J5AaNlY1YB4giH4BsCeRbJwSLh01n3j9aRW6XYipvoTRiZU04MA==
X-Received: by 2002:a17:903:2285:b0:17f:6a39:7097 with SMTP id b5-20020a170903228500b0017f6a397097mr27134374plh.51.1665525430731;
        Tue, 11 Oct 2022 14:57:10 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id z17-20020a170903019100b0018123556931sm6580371plg.204.2022.10.11.14.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 14:57:10 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 2/4] filemap: find_get_entries() now updates start offset
Date:   Tue, 11 Oct 2022 14:56:32 -0700
Message-Id: <20221011215634.478330-3-vishal.moola@gmail.com>
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

Initially, find_get_entries() was being passed in the start offset as a
value. That left the calculation of the offset to the callers. This led
to complexity in the callers trying to keep track of the index.

Now find_get_entires() takes in a pointer to the start offset and
updates the value to be directly after the last entry found. If no entry is
found, the offset is not changed. This gets rid of multiple hacky
calculations that kept track of the start offset.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/filemap.c  | 15 +++++++++++++--
 mm/internal.h |  2 +-
 mm/shmem.c    | 11 ++++-------
 mm/truncate.c | 23 +++++++++--------------
 4 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index e95500b07ee9..1b8022c18dc7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2047,11 +2047,13 @@ static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
  * shmem/tmpfs, are included in the returned array.
  *
  * Return: The number of entries which were found.
+ * Also updates @start to be positioned after the last found entry
  */
-unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
+unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices)
 {
-	XA_STATE(xas, &mapping->i_pages, start);
+	XA_STATE(xas, &mapping->i_pages, *start);
+	unsigned long nr;
 	struct folio *folio;
 
 	rcu_read_lock();
@@ -2061,7 +2063,16 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 			break;
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
index c504ac7267e0..68afdbe7106e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -108,7 +108,7 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
-unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
+unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 void filemap_free_folio(struct address_space *mapping, struct folio *folio);
 int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
diff --git a/mm/shmem.c b/mm/shmem.c
index ab4f6dfcf6bb..8240e066edfc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -973,7 +973,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	while (index < end) {
 		cond_resched();
 
-		if (!find_get_entries(mapping, index, end - 1, &fbatch,
+		if (!find_get_entries(mapping, &index, end - 1, &fbatch,
 				indices)) {
 			/* If all gone or hole-punch or unfalloc, we're done */
 			if (index == start || end != -1)
@@ -985,13 +985,12 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			folio = fbatch.folios[i];
 
-			index = indices[i];
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				if (shmem_free_swap(mapping, index, folio)) {
+				if (shmem_free_swap(mapping, folio->index, folio)) {
 					/* Swap was replaced by page: retry */
-					index--;
+					index = folio->index;
 					break;
 				}
 				nr_swaps_freed++;
@@ -1004,19 +1003,17 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 				if (folio_mapping(folio) != mapping) {
 					/* Page was replaced by swap: retry */
 					folio_unlock(folio);
-					index--;
+					index = folio->index;
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
index b0bd63b2359f..846ddbdb27a4 100644
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
-
 			if (xa_is_value(folio))
 				continue;
 
 			folio_lock(folio);
-			VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
+			VM_BUG_ON_FOLIO(!folio_contains(folio, folio->index),
+					folio);
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
@@ -637,16 +634,14 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 
 	folio_batch_init(&fbatch);
 	index = start;
-	while (find_get_entries(mapping, index, end, &fbatch, indices)) {
+	while (find_get_entries(mapping, &index, end, &fbatch, indices)) {
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			struct folio *folio = fbatch.folios[i];
 
 			/* We rely upon deletion not changing folio->index */
-			index = indices[i];
-
 			if (xa_is_value(folio)) {
 				if (!invalidate_exceptional_entry2(mapping,
-						index, folio))
+						folio->index, folio))
 					ret = -EBUSY;
 				continue;
 			}
@@ -656,13 +651,14 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 				 * If folio is mapped, before taking its lock,
 				 * zap the rest of the file in one hit.
 				 */
-				unmap_mapping_pages(mapping, index,
-						(1 + end - index), false);
+				unmap_mapping_pages(mapping, folio->index,
+					(1 + end - folio->index), false);
 				did_range_unmap = 1;
 			}
 
 			folio_lock(folio);
-			VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
+			VM_BUG_ON_FOLIO(!folio_contains(folio, folio->index),
+					folio);
 			if (folio->mapping != mapping) {
 				folio_unlock(folio);
 				continue;
@@ -685,7 +681,6 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
-		index++;
 	}
 	/*
 	 * For DAX we invalidate page tables after invalidating page cache.  We
-- 
2.36.1

