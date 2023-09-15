Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA7B7A2631
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbjIOSmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236866AbjIOSlq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:41:46 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93D12D4B;
        Fri, 15 Sep 2023 11:40:16 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RnNJx3l54z9sTN;
        Fri, 15 Sep 2023 20:39:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rV9SUN768+vUSf43/qCLKk3hEIsfVKLWNcCU7V4zUtQ=;
        b=eI+gl/BNfS9Dhty41um4KR+wRrFDQO+mDTbD65wgK9zPsLejVpU804xRIAjk7oY4J+Azil
        IVzX5dngUXpyfVClHiUUCaBnCc+02/4pud5dgOX6JQnyg72eUcxNj6QU8Sc/dnYHpcWObe
        paf2iuxl+EBFXfzLebEiH8GmUnBXq2RbfhMZtDylytHzq6bcq/Gpwf9XOVdf78jI04ETB+
        xT7AyyaXTYUNMDkeQe91i2XK/OSfmotxpNcOTnfyY/W3bQz1zAy50mXsvOq+rw1ZgADZ8w
        TPwbbIX4YN/46fNwwcoiCqVkUIJwiBKy2eunAvqT3IHljCII7Tbs1TqQdCUCGg==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 19/23] truncate: align index to mapping_min_order
Date:   Fri, 15 Sep 2023 20:38:44 +0200
Message-Id: <20230915183848.1018717-20-kernel@pankajraghav.com>
In-Reply-To: <20230915183848.1018717-1-kernel@pankajraghav.com>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RnNJx3l54z9sTN
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Align indices to mapping_min_order in invalidate_inode_pages2_range(),
mapping_try_invalidate() and truncate_inode_pages_range(). This is
necessary to keep the folios added to the page cache aligned with
mapping_min_order.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/truncate.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 8e3aa9e8618e..d5ce8e30df70 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -337,6 +337,8 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	int		i;
 	struct folio	*folio;
 	bool		same_folio;
+	unsigned int order = mapping_min_folio_order(mapping);
+	unsigned int nrpages = 1U << order;
 
 	if (mapping_empty(mapping))
 		return;
@@ -347,7 +349,9 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	 * start of the range and 'partial_end' at the end of the range.
 	 * Note that 'end' is exclusive while 'lend' is inclusive.
 	 */
-	start = (lstart + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	start = (lstart + (nrpages * PAGE_SIZE) - 1) >> PAGE_SHIFT;
+	start = round_down(start, nrpages);
+
 	if (lend == -1)
 		/*
 		 * lend == -1 indicates end-of-file so we have to set 'end'
@@ -356,7 +360,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 		 */
 		end = -1;
 	else
-		end = (lend + 1) >> PAGE_SHIFT;
+		end = round_down((lend + 1) >> PAGE_SHIFT, nrpages);
 
 	folio_batch_init(&fbatch);
 	index = start;
@@ -372,8 +376,9 @@ void truncate_inode_pages_range(struct address_space *mapping,
 		cond_resched();
 	}
 
-	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
-	folio = __filemap_get_folio(mapping, lstart >> PAGE_SHIFT, FGP_LOCK, 0);
+	same_folio = round_down(lstart >> PAGE_SHIFT, nrpages) ==
+		     round_down(lend >> PAGE_SHIFT, nrpages);
+	folio = __filemap_get_folio(mapping, start, FGP_LOCK, 0);
 	if (!IS_ERR(folio)) {
 		same_folio = lend < folio_pos(folio) + folio_size(folio);
 		if (!truncate_inode_partial_folio(folio, lstart, lend)) {
@@ -387,7 +392,8 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	}
 
 	if (!same_folio) {
-		folio = __filemap_get_folio(mapping, lend >> PAGE_SHIFT,
+		folio = __filemap_get_folio(mapping,
+					    round_down(lend >> PAGE_SHIFT, nrpages),
 						FGP_LOCK, 0);
 		if (!IS_ERR(folio)) {
 			if (!truncate_inode_partial_folio(folio, lstart, lend))
@@ -497,15 +503,18 @@ EXPORT_SYMBOL(truncate_inode_pages_final);
 unsigned long mapping_try_invalidate(struct address_space *mapping,
 		pgoff_t start, pgoff_t end, unsigned long *nr_failed)
 {
+	unsigned int min_order = mapping_min_folio_order(mapping);
+	unsigned int nrpages = 1UL << min_order;
 	pgoff_t indices[PAGEVEC_SIZE];
 	struct folio_batch fbatch;
-	pgoff_t index = start;
+	pgoff_t index = round_up(start, nrpages);
+	pgoff_t end_idx = round_down(end, nrpages);
 	unsigned long ret;
 	unsigned long count = 0;
 	int i;
 
 	folio_batch_init(&fbatch);
-	while (find_lock_entries(mapping, &index, end, &fbatch, indices)) {
+	while (find_lock_entries(mapping, &index, end_idx, &fbatch, indices)) {
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			struct folio *folio = fbatch.folios[i];
 
@@ -618,9 +627,11 @@ static int folio_launder(struct address_space *mapping, struct folio *folio)
 int invalidate_inode_pages2_range(struct address_space *mapping,
 				  pgoff_t start, pgoff_t end)
 {
+	unsigned int min_order = mapping_min_folio_order(mapping);
+	unsigned int nrpages = 1UL << min_order;
 	pgoff_t indices[PAGEVEC_SIZE];
 	struct folio_batch fbatch;
-	pgoff_t index;
+	pgoff_t index, end_idx;
 	int i;
 	int ret = 0;
 	int ret2 = 0;
@@ -630,8 +641,9 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 		return 0;
 
 	folio_batch_init(&fbatch);
-	index = start;
-	while (find_get_entries(mapping, &index, end, &fbatch, indices)) {
+	index = round_up(start, nrpages);
+	end_idx = round_down(end, nrpages);
+	while (find_get_entries(mapping, &index, end_idx, &fbatch, indices)) {
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			struct folio *folio = fbatch.folios[i];
 
@@ -660,6 +672,8 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 				continue;
 			}
 			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
+			VM_BUG_ON_FOLIO(folio_order(folio) < min_order, folio);
+			VM_BUG_ON_FOLIO(folio->index & (nrpages - 1), folio);
 			folio_wait_writeback(folio);
 
 			if (folio_mapped(folio))
-- 
2.40.1

