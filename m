Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C635FBD3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 23:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJKV5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 17:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJKV5O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:57:14 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3A69E2CF;
        Tue, 11 Oct 2022 14:57:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so241480pjb.2;
        Tue, 11 Oct 2022 14:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXDbujsutxz3ngIaiJSWN9PnHbyRD3OgFchLZ9JC5Lo=;
        b=AYlGz70PIZyhQNjM/Pp+kDlhxI0tF4WMQOfLtk/ekNQRgN9Ryg8nV3g6d7Ogp9hFb4
         RkFKc7VcBUyFEuKbtWBk7zY+UaP8ogbIUMr5IikoXh6EZt10Bn9RTXbf9klImU9xpiwG
         OVrarOKuCw2ZiFWChKbD6Jlpb+uuALJpUAegSOOJPrPRUog6y8xBumfw0exi2HOTTuTh
         MZS44y2LBJvC/jA+mSA8DntE1hWUO7M3xntY8klRbwxceSFR1yDXCloilgbWz/S8Suv2
         TWhPwZF1LE1kzT39Kim3Ki6gXy6AeTHGoWppqfPxgNk7GJxrZgGxyFISdjoH/kRbpn6z
         s0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXDbujsutxz3ngIaiJSWN9PnHbyRD3OgFchLZ9JC5Lo=;
        b=dbm3jxye1TC/o/VLmsWJkWqTXktSm84jUuHqpMT05Ew3or+WiHaWsldofgaWF48P6N
         szI7RpdzY+EnRx1gyz4SdpPCi6QBFrnDqgvNiNbJNXI5Smb5K3f2nAWKi8N/nICzQbn2
         lEZwor+5ZzFo60GQpHhy+LqMP83rpckYfivcofA74Qo4shOd3eBE+tEXIwgtsuCNbLVJ
         DQ/ngCB7HUM7VPInPhiCslpW7ja3O+tkf7QTY3dv921/LBCmFL9PSpWqZ7E98LUD1wpc
         PxRIttvIB4T4R2rriLnc6W6FK4Hin0uqO1AFYsA1yIm4PdAEkoj9KbHoIB4EFVZH1K06
         NQHw==
X-Gm-Message-State: ACrzQf2Zeg0Ornn9OGnq16rlNcJSR0VQfhMXUll1YIxJojT1o0/ch71l
        +0wb9AzVfUftvhdUMJbTHr4=
X-Google-Smtp-Source: AMsMyM4lMDBv1ZDaUDkxWrgrJDmvQQx72heA97zHEVahr9/xNPYg8P/qKhBWIIlPosLXZJVP3x8/3A==
X-Received: by 2002:a17:902:760d:b0:184:29:8ab8 with SMTP id k13-20020a170902760d00b0018400298ab8mr3405046pll.36.1665525432423;
        Tue, 11 Oct 2022 14:57:12 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id z17-20020a170903019100b0018123556931sm6580371plg.204.2022.10.11.14.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 14:57:12 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 4/4] filemap: Remove indices argument from find_lock_entries() and find_get_entries()
Date:   Tue, 11 Oct 2022 14:56:34 -0700
Message-Id: <20221011215634.478330-5-vishal.moola@gmail.com>
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

The indices array is unnecessary. Folios keep track of their xarray indices
in the folio->index field which can simply be accessed as needed.

This change removes the indices argument from find_lock_entries() and
find_get_entries(). All of the callers are able to remove their indices
arrays as well.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/filemap.c  |  8 ++------
 mm/internal.h |  4 ++--
 mm/shmem.c    |  6 ++----
 mm/truncate.c | 12 ++++--------
 4 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1b8022c18dc7..1f6be113a214 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2034,7 +2034,6 @@ static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
  * @start:	The starting page cache index
  * @end:	The final page index (inclusive).
  * @fbatch:	Where the resulting entries are placed.
- * @indices:	The cache indices corresponding to the entries in @entries
  *
  * find_get_entries() will search for and return a batch of entries in
  * the mapping.  The entries are placed in @fbatch.  find_get_entries()
@@ -2050,7 +2049,7 @@ static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
  * Also updates @start to be positioned after the last found entry
  */
 unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
-		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices)
+		pgoff_t end, struct folio_batch *fbatch)
 {
 	XA_STATE(xas, &mapping->i_pages, *start);
 	unsigned long nr;
@@ -2058,7 +2057,6 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 
 	rcu_read_lock();
 	while ((folio = find_get_entry(&xas, end, XA_PRESENT)) != NULL) {
-		indices[fbatch->nr] = xas.xa_index;
 		if (!folio_batch_add(fbatch, folio))
 			break;
 	}
@@ -2082,7 +2080,6 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
  * @start:	The starting page cache index.
  * @end:	The final page index (inclusive).
  * @fbatch:	Where the resulting entries are placed.
- * @indices:	The cache indices of the entries in @fbatch.
  *
  * find_lock_entries() will return a batch of entries from @mapping.
  * Swap, shadow and DAX entries are included.  Folios are returned
@@ -2098,7 +2095,7 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
  * Also updates @start to be positioned after the last found entry
  */
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
-		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices)
+		pgoff_t end, struct folio_batch *fbatch)
 {
 	XA_STATE(xas, &mapping->i_pages, *start);
 	unsigned long nr;
@@ -2119,7 +2116,6 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 			VM_BUG_ON_FOLIO(!folio_contains(folio, xas.xa_index),
 					folio);
 		}
-		indices[fbatch->nr] = xas.xa_index;
 		if (!folio_batch_add(fbatch, folio))
 			break;
 		continue;
diff --git a/mm/internal.h b/mm/internal.h
index 68afdbe7106e..db8d5dfa6d68 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -107,9 +107,9 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 }
 
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
-		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
+		pgoff_t end, struct folio_batch *fbatch);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
-		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
+		pgoff_t end, struct folio_batch *fbatch);
 void filemap_free_folio(struct address_space *mapping, struct folio *folio);
 int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
 bool truncate_inode_partial_folio(struct folio *folio, loff_t start,
diff --git a/mm/shmem.c b/mm/shmem.c
index 8240e066edfc..ad6b5adf04ac 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -907,7 +907,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	pgoff_t start = (lstart + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	pgoff_t end = (lend + 1) >> PAGE_SHIFT;
 	struct folio_batch fbatch;
-	pgoff_t indices[PAGEVEC_SIZE];
 	struct folio *folio;
 	bool same_folio;
 	long nr_swaps_freed = 0;
@@ -923,7 +922,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	folio_batch_init(&fbatch);
 	index = start;
 	while (index < end && find_lock_entries(mapping, &index, end - 1,
-			&fbatch, indices)) {
+			&fbatch)) {
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			folio = fbatch.folios[i];
 
@@ -973,8 +972,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	while (index < end) {
 		cond_resched();
 
-		if (!find_get_entries(mapping, &index, end - 1, &fbatch,
-				indices)) {
+		if (!find_get_entries(mapping, &index, end - 1, &fbatch)) {
 			/* If all gone or hole-punch or unfalloc, we're done */
 			if (index == start || end != -1)
 				break;
diff --git a/mm/truncate.c b/mm/truncate.c
index 4e63d885498a..9db247a88483 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -332,7 +332,6 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	pgoff_t		start;		/* inclusive */
 	pgoff_t		end;		/* exclusive */
 	struct folio_batch fbatch;
-	pgoff_t		indices[PAGEVEC_SIZE];
 	pgoff_t		index;
 	int		i;
 	struct folio	*folio;
@@ -361,7 +360,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	folio_batch_init(&fbatch);
 	index = start;
 	while (index < end && find_lock_entries(mapping, &index, end - 1,
-			&fbatch, indices)) {
+			&fbatch)) {
 		truncate_folio_batch_exceptionals(mapping, &fbatch);
 		for (i = 0; i < folio_batch_count(&fbatch); i++)
 			truncate_cleanup_folio(fbatch.folios[i]);
@@ -399,8 +398,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	index = start;
 	while (index < end) {
 		cond_resched();
-		if (!find_get_entries(mapping, &index, end - 1, &fbatch,
-				indices)) {
+		if (!find_get_entries(mapping, &index, end - 1, &fbatch)) {
 			/* If all gone from start onwards, we're done */
 			if (index == start)
 				break;
@@ -497,7 +495,6 @@ EXPORT_SYMBOL(truncate_inode_pages_final);
 unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
 		pgoff_t start, pgoff_t end, unsigned long *nr_pagevec)
 {
-	pgoff_t indices[PAGEVEC_SIZE];
 	struct folio_batch fbatch;
 	pgoff_t index = start;
 	unsigned long ret;
@@ -505,7 +502,7 @@ unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
 	int i;
 
 	folio_batch_init(&fbatch);
-	while (find_lock_entries(mapping, &index, end, &fbatch, indices)) {
+	while (find_lock_entries(mapping, &index, end, &fbatch)) {
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			struct folio *folio = fbatch.folios[i];
 
@@ -620,7 +617,6 @@ static int folio_launder(struct address_space *mapping, struct folio *folio)
 int invalidate_inode_pages2_range(struct address_space *mapping,
 				  pgoff_t start, pgoff_t end)
 {
-	pgoff_t indices[PAGEVEC_SIZE];
 	struct folio_batch fbatch;
 	pgoff_t index;
 	int i;
@@ -633,7 +629,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 
 	folio_batch_init(&fbatch);
 	index = start;
-	while (find_get_entries(mapping, &index, end, &fbatch, indices)) {
+	while (find_get_entries(mapping, &index, end, &fbatch)) {
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			struct folio *folio = fbatch.folios[i];
 
-- 
2.36.1

