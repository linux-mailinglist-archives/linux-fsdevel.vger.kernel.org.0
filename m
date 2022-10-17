Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D149601346
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 18:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiJQQSK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 12:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiJQQSH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:18:07 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC406CF44;
        Mon, 17 Oct 2022 09:18:07 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l1so11193093pld.13;
        Mon, 17 Oct 2022 09:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5j539BVjq27URS/HNG9DrLeM7Wv07f4M+R4mIEbK3S8=;
        b=IZf7M4v9cnmFrzMJwOe8cLn5+Qylo/CbrK6HuvbD4tXqp1aNaO+PxREpTWmtbiQfoZ
         rkFFM5OGIXhOG5RBxFssGCCjha4z7MMaWFEdyDb8btzv4cryoz6nmkPaAZScnIBMLlZl
         yxW/lgSJK+ViQKNVz/hGoIxhgwdZrPf6n1CrYP59o9rKamMFFpKamkmYRw7bGUaYmBJx
         BZ1GZGEW1O/ez8uQK+m5hpt3CmvuUcxTcKVG3dJvbUU48n1JKRfjs3U0EnZFxNHv/H80
         EqTGht9vIXXrK5u+HWNrVo7MYwxH+QgbSPttQjmN1VdaVQZvqqDqNZSBhDOoZuS/unrJ
         bPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5j539BVjq27URS/HNG9DrLeM7Wv07f4M+R4mIEbK3S8=;
        b=dKH+ifd12RufR1FbiXeGEVQXERY3nhpRQT7lXQxj2h4WukkXVWKd/B7Dk75Xqev+iu
         /An0vUgiP87o889m7VwOyq/i57g/oTJLM7qAMcDiukevfEhQaRi5YFL7XAiu7f+2e5Bz
         S1qI8RKdWT/FNcOaX0piFEzE2NOw+FoTGVbC4ioCvfMkBLVBmA3TOpVnvcNAmLwHPxC3
         Tfhr93zkTU3Aa6HYIgClsG+dRz1338MCNlr4pn5YBsFZTRYcJbNdt18iFtTT5+hVAxkA
         jQtSkNUm08qb6DkQFA1K93c1cCJaNZfYRn1LtPc/nMgs8ruPDHqm6PNyvhRlx0Zq77hv
         6R8g==
X-Gm-Message-State: ACrzQf226fESbozwgzfqXoX41S/p4I9b84i8wucNpHtsbU2S/jn9YMZk
        61183OSiznnbYObztBhfxt4=
X-Google-Smtp-Source: AMsMyM4ftJIMA25PfGYTh9jK2D4BU/OQiynH29ZlT6JT9jOJKWuweEcyzHkyoCTQhSqQMCMdystdRA==
X-Received: by 2002:a17:90a:1785:b0:20a:6162:2b6a with SMTP id q5-20020a17090a178500b0020a61622b6amr14373016pja.180.1666023486520;
        Mon, 17 Oct 2022 09:18:06 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id z22-20020a62d116000000b0055f209690c0sm7272326pfg.50.2022.10.17.09.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:18:06 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 1/2] filemap: find_lock_entries() now updates start offset
Date:   Mon, 17 Oct 2022 09:17:59 -0700
Message-Id: <20221017161800.2003-2-vishal.moola@gmail.com>
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

Initially, find_lock_entries() was being passed in the start offset as a
value. That left the calculation of the offset to the callers. This led
to complexity in the callers trying to keep track of the index.

Now find_lock_entries() takes in a pointer to the start offset and
updates the value to be directly after the last entry found. If no entry is
found, the offset is not changed. This gets rid of multiple hacky
calculations that kept track of the start offset.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/filemap.c  | 15 ++++++++++++---
 mm/internal.h |  2 +-
 mm/shmem.c    |  8 ++------
 mm/truncate.c | 11 +++--------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c943d1b90cc2..f1fec7bf5b15 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2090,16 +2090,16 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
  *
  * Return: The number of entries which were found.
  */
-unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
+unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices)
 {
-	XA_STATE(xas, &mapping->i_pages, start);
+	XA_STATE(xas, &mapping->i_pages, *start);
 	struct folio *folio;
 
 	rcu_read_lock();
 	while ((folio = find_get_entry(&xas, end, XA_PRESENT))) {
 		if (!xa_is_value(folio)) {
-			if (folio->index < start)
+			if (folio->index < *start)
 				goto put;
 			if (folio->index + folio_nr_pages(folio) - 1 > end)
 				goto put;
@@ -2122,6 +2122,15 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
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
index 785409805ed7..14625de6714b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -104,7 +104,7 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 	force_page_cache_ra(&ractl, nr_to_read);
 }
 
-unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
+unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
diff --git a/mm/shmem.c b/mm/shmem.c
index 42e5888bf84d..9e17a2b0dc43 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -932,21 +932,18 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 
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
+							indices[i], folio);
 				continue;
 			}
-			index += folio_nr_pages(folio) - 1;
 
 			if (!unfalloc || !folio_test_uptodate(folio))
 				truncate_inode_folio(mapping, folio);
@@ -955,7 +952,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
-		index++;
 	}
 
 	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
diff --git a/mm/truncate.c b/mm/truncate.c
index 0b0708bf935f..9fbe282e70ba 100644
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
@@ -510,20 +509,17 @@ unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
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
+							     indices[i], folio);
 				continue;
 			}
-			index += folio_nr_pages(folio) - 1;
 
 			ret = mapping_evict_folio(mapping, folio);
 			folio_unlock(folio);
@@ -542,7 +538,6 @@ unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
-		index++;
 	}
 	return count;
 }
-- 
2.36.1

