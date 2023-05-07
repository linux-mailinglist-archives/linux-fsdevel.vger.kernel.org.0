Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7614C6F9B30
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 21:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjEGT21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 15:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjEGT2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 15:28:25 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6564711547;
        Sun,  7 May 2023 12:28:24 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64115e652eeso30067139b3a.0;
        Sun, 07 May 2023 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683487703; x=1686079703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agiEqnLjzjXxpXLDTF39APBkVtFZSKM6C+u+Yt5CMi4=;
        b=NjBaByKXRGFTzdX2KJuB7Xeosxi/DMnQggs9p17YnmjkDgIKso8hFa5IIjDRELMvHW
         pLr8wdLNcQiGap6RnkPvWr/wrgPjwRXeI/ZwpjrFoImXVtXWldxOm9laAPdidinn9Lwp
         SH42KojklWkuYcJli7L5zIlW3xY6v05/mPOv1yYTo/9UGZwWlQF1ybuvekTemRvjBCpo
         Rg8DLjpvyjrmLMxoWdKk6O3sqaqdq61BxG7UJCYI5Py6pgYpimprrUS6YweUuEHsbZfP
         rCkDo+pql33UTKnMqaP809CavDLgodI/N37iDTLIYcqIvd8Y8VM8skVijfrbhQ2KezzI
         hQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683487703; x=1686079703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agiEqnLjzjXxpXLDTF39APBkVtFZSKM6C+u+Yt5CMi4=;
        b=lQcyENEbkbx700t6yslf0ovqyIyB8w7MHiGn4Q6ABvCUj4jfuNAg6sJP6tD82kS46G
         OQS/mN8ldDdu20GDlRHvLNTZoDcJKe+6rXoFDJFLtF+qn/nLlPeUqwxxLEWYSwMGSCAZ
         7ZiFnisoa0JSvmiAIafaTH8pFzobpv78beT1dXfgBGodPv13JPE5K5sotSJnZmS1Nbng
         40vEnqR0TcoND+1p1UrCefdOTKWqLngIlK/OYapQcsGG9/Bv4twXvhUdx2rlbIG3t1k/
         dWQD6pcd9RsUcW7Bc/G3NqyAluyd2De7wQ5bbzS9hn93Uv1fUKfYTGpPIlJqyJ7lACAg
         slGw==
X-Gm-Message-State: AC+VfDzVX2TL3cw5Xyavklcc6PmtwNOcEA3pxwvm22avR+6BHNn1IgWm
        KDGwPYBk1whMubjUsR4CTpa7AamXtqk=
X-Google-Smtp-Source: ACHHUZ7UCtNxawgYhVbY67y9DriFqQNxvQuUINmq9J5Ph6JtkRb9JanChlqgwv8ILpRxFqbHWZEZjg==
X-Received: by 2002:a17:903:32c6:b0:1ab:1e6f:74d1 with SMTP id i6-20020a17090332c600b001ab1e6f74d1mr17206880plr.0.1683487703545;
        Sun, 07 May 2023 12:28:23 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:80ba:4cb4:7226:d064:79aa])
        by smtp.gmail.com with ESMTPSA id jg18-20020a17090326d200b001a505f04a06sm5485624plb.190.2023.05.07.12.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 12:28:23 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv5 3/5] iomap: Add iop's uptodate state handling functions
Date:   Mon,  8 May 2023 00:57:58 +0530
Message-Id: <5372f29f986052f37b45c368a0eb8eed25eb8fdb.1683485700.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1683485700.git.ritesh.list@gmail.com>
References: <cover.1683485700.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Firstly this patch renames iop->uptodate to iop->state bitmap.
This is because we will add dirty state to iop->state bitmap in later
patches. So it makes sense to rename the iop->uptodate bitmap to
iop->state.

Secondly this patch also adds other helpers for uptodate state bitmap
handling of iop->state.

No functionality change in this patch.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 78 +++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e732581dc2d4..5103b644e115 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -24,14 +24,14 @@
 #define IOEND_BATCH_SIZE	4096
 
 /*
- * Structure allocated for each folio when block size < folio size
- * to track sub-folio uptodate status and I/O completions.
+ * Structure allocated for each folio to track per-block uptodate state
+ * and I/O completions.
  */
 struct iomap_page {
 	atomic_t		read_bytes_pending;
 	atomic_t		write_bytes_pending;
-	spinlock_t		uptodate_lock;
-	unsigned long		uptodate[];
+	spinlock_t		state_lock;
+	unsigned long		state[];
 };
 
 static inline struct iomap_page *to_iomap_page(struct folio *folio)
@@ -43,6 +43,47 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
 
 static struct bio_set iomap_ioend_bioset;
 
+/*
+ * inline helpers for bitmap operations on iop->state
+ */
+static inline void iop_set_range(struct iomap_page *iop, unsigned int start_blk,
+				 unsigned int nr_blks)
+{
+	bitmap_set(iop->state, start_blk, nr_blks);
+}
+
+static inline bool iop_test_block(struct iomap_page *iop, unsigned int block)
+{
+	return test_bit(block, iop->state);
+}
+
+static inline bool iop_bitmap_full(struct iomap_page *iop,
+				   unsigned int blks_per_folio)
+{
+	return bitmap_full(iop->state, blks_per_folio);
+}
+
+/*
+ * iop related helpers for checking uptodate/dirty state of per-block
+ * or range of blocks within a folio
+ */
+static bool iop_test_full_uptodate(struct folio *folio)
+{
+	struct iomap_page *iop = to_iomap_page(folio);
+	struct inode *inode = folio->mapping->host;
+
+	WARN_ON(!iop);
+	return iop_bitmap_full(iop, i_blocks_per_folio(inode, folio));
+}
+
+static bool iop_test_block_uptodate(struct folio *folio, unsigned int block)
+{
+	struct iomap_page *iop = to_iomap_page(folio);
+
+	WARN_ON(!iop);
+	return iop_test_block(iop, block);
+}
+
 static void iop_set_range_uptodate(struct inode *inode, struct folio *folio,
 				   size_t off, size_t len)
 {
@@ -53,12 +94,11 @@ static void iop_set_range_uptodate(struct inode *inode, struct folio *folio,
 	unsigned long flags;
 
 	if (iop) {
-		spin_lock_irqsave(&iop->uptodate_lock, flags);
-		bitmap_set(iop->uptodate, first_blk, nr_blks);
-		if (bitmap_full(iop->uptodate,
-				i_blocks_per_folio(inode, folio)))
+		spin_lock_irqsave(&iop->state_lock, flags);
+		iop_set_range(iop, first_blk, nr_blks);
+		if (iop_test_full_uptodate(folio))
 			folio_mark_uptodate(folio);
-		spin_unlock_irqrestore(&iop->uptodate_lock, flags);
+		spin_unlock_irqrestore(&iop->state_lock, flags);
 	} else {
 		folio_mark_uptodate(folio);
 	}
@@ -79,12 +119,12 @@ static struct iomap_page *iop_alloc(struct inode *inode, struct folio *folio,
 	else
 		gfp = GFP_NOFS | __GFP_NOFAIL;
 
-	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
+	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
 		      gfp);
 	if (iop) {
-		spin_lock_init(&iop->uptodate_lock);
+		spin_lock_init(&iop->state_lock);
 		if (folio_test_uptodate(folio))
-			bitmap_fill(iop->uptodate, nr_blocks);
+			iop_set_range(iop, 0, nr_blocks);
 		folio_attach_private(folio, iop);
 	}
 	return iop;
@@ -93,15 +133,13 @@ static struct iomap_page *iop_alloc(struct inode *inode, struct folio *folio,
 static void iop_free(struct folio *folio)
 {
 	struct iomap_page *iop = to_iomap_page(folio);
-	struct inode *inode = folio->mapping->host;
-	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 
 	if (!iop)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
 	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
-	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
-			folio_test_uptodate(folio));
+	WARN_ON_ONCE(iop_test_full_uptodate(folio) !=
+		     folio_test_uptodate(folio));
 	folio_detach_private(folio);
 	kfree(iop);
 }
@@ -132,7 +170,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* move forward for each leading block marked uptodate */
 		for (i = first; i <= last; i++) {
-			if (!test_bit(i, iop->uptodate))
+			if (!iop_test_block_uptodate(folio, i))
 				break;
 			*pos += block_size;
 			poff += block_size;
@@ -142,7 +180,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		for ( ; i <= last; i++) {
-			if (test_bit(i, iop->uptodate)) {
+			if (iop_test_block_uptodate(folio, i)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
 				break;
@@ -450,7 +488,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 	last = (from + count - 1) >> inode->i_blkbits;
 
 	for (i = first; i <= last; i++)
-		if (!test_bit(i, iop->uptodate))
+		if (!iop_test_block_uptodate(folio, i))
 			return false;
 	return true;
 }
@@ -1634,7 +1672,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (iop && !test_bit(i, iop->uptodate))
+		if (iop && !iop_test_block_uptodate(folio, i))
 			continue;
 
 		error = wpc->ops->map_blocks(wpc, inode, pos);
-- 
2.39.2

