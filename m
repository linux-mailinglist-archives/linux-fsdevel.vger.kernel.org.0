Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681A5724147
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 13:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbjFFLoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 07:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbjFFLoJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:44:09 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66329A6;
        Tue,  6 Jun 2023 04:44:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so5348388a12.1;
        Tue, 06 Jun 2023 04:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686051847; x=1688643847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFQmtCO5X8RL2byGnSDVe/dhJz84S0keklInfDm9x90=;
        b=rz0d6plF7+jgQGcg2gMjYuusf2MwZwFLhm6ip/gPtoqd+QUi9mN55xveBvaWZqrd9b
         R4rzdmyvU4Lw6mayNw0znbh/4rnCZwrb8lMAZFz0LdP9kRGtnySXHeGUqx43hAwdl1NT
         4SyP+XnkmVLyu/Pb92NLfDLQuodsx+KPiuwno1yhN6b7OGPV4vke8sfuwVPdOG5EYYl7
         ZqieNWK9jtAToGm4P/HvTqQZMy3KGYHyoH3R+RUdDiWEnQucT0RxP1GQz/7IrVBaGqng
         pm68G8lAsU7FQ5Lg0CPWl9W5iSQ923FnC0OvBLlJh1hXxLBEgF5rm3+srz7xoSmvRYQX
         vrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686051847; x=1688643847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFQmtCO5X8RL2byGnSDVe/dhJz84S0keklInfDm9x90=;
        b=Hsrq/ieEPPQBRceWw6LyD858kD6J4TczErbEG2teoIO4ygakiaxwaQf4zzHwOYM5Br
         IeckHpKou9jOw+IDSQmHBpDk6XNrZg4DKittNzjRfuOiUjiSTFHXh1X0fhSbEtJhXumb
         IDgneeSDp9ClkLEw0wCYR9myzcQuiV1V2bdo48x/LIQfxPJhe4iOWBvN0+Mv0XfmBVOz
         2TWrsQoMrlMZFYSwLQmKhVXpaWoUIuAzBc/vnndKzeZQPxEcxzn8Vj80UaLF7+1PlI4Q
         4d5k19PmUEoYlHSeayfMEcZZfXcHYdW7qhYRZVXjQ9pUIv8eXriqNdM3YIoeAlVnEM8R
         Hz+g==
X-Gm-Message-State: AC+VfDz141Shmzheec5gKSgGLwRsohkqPoyhQo63ov1SGrSsB0G8jz0b
        kscz/W+R6EM+XILlMu+I17MA5nBGNNw=
X-Google-Smtp-Source: ACHHUZ4pf3abHm/IXIAKzaT9X/ZQ/3AJ9nt/1TSG0eXzauzrfr0uS1QLTZXC/RluGrfOzXTslITvcw==
X-Received: by 2002:a17:902:da87:b0:1b2:2400:f324 with SMTP id j7-20020a170902da8700b001b22400f324mr2133476plx.64.1686051847487;
        Tue, 06 Jun 2023 04:44:07 -0700 (PDT)
Received: from dw-tp.localdomain ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001ab0a30c895sm8325120plb.202.2023.06.06.04.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:44:07 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv8 2/5] iomap: Renames and refactor iomap_folio state bitmap handling
Date:   Tue,  6 Jun 2023 17:13:49 +0530
Message-Id: <54583c1f42a87f19bda5a015e641c8d08fa72071.1686050333.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686050333.git.ritesh.list@gmail.com>
References: <cover.1686050333.git.ritesh.list@gmail.com>
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

This patch renames iomap_folio's uptodate bitmap to state bitmap.
Also refactors and adds iof->state handling functions for uptodate
state.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 107 +++++++++++++++++++++++------------------
 1 file changed, 59 insertions(+), 48 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 741baa10c517..08f2a1cf0a66 100644
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
 struct iomap_folio {
 	atomic_t		read_bytes_pending;
 	atomic_t		write_bytes_pending;
-	spinlock_t		uptodate_lock;
-	unsigned long		uptodate[];
+	spinlock_t		state_lock;
+	unsigned long		state[];
 };
 
 static inline struct iomap_folio *iomap_get_iof(struct folio *folio)
@@ -43,6 +43,47 @@ static inline struct iomap_folio *iomap_get_iof(struct folio *folio)
 
 static struct bio_set iomap_ioend_bioset;
 
+static inline bool iomap_iof_is_fully_uptodate(struct folio *folio,
+					       struct iomap_folio *iof)
+{
+	struct inode *inode = folio->mapping->host;
+
+	return bitmap_full(iof->state, i_blocks_per_folio(inode, folio));
+}
+
+static inline bool iomap_iof_is_block_uptodate(struct iomap_folio *iof,
+					       unsigned int block)
+{
+	return test_bit(block, iof->state);
+}
+
+static void iomap_iof_set_range_uptodate(struct folio *folio,
+			struct iomap_folio *iof, size_t off, size_t len)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int first_blk = off >> inode->i_blkbits;
+	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
+	unsigned int nr_blks = last_blk - first_blk + 1;
+	unsigned long flags;
+
+	spin_lock_irqsave(&iof->state_lock, flags);
+	bitmap_set(iof->state, first_blk, nr_blks);
+	if (iomap_iof_is_fully_uptodate(folio, iof))
+		folio_mark_uptodate(folio);
+	spin_unlock_irqrestore(&iof->state_lock, flags);
+}
+
+static void iomap_set_range_uptodate(struct folio *folio, size_t off,
+				     size_t len)
+{
+	struct iomap_folio *iof = iomap_get_iof(folio);
+
+	if (iof)
+		iomap_iof_set_range_uptodate(folio, iof, off, len);
+	else
+		folio_mark_uptodate(folio);
+}
+
 static struct iomap_folio *iomap_iof_alloc(struct inode *inode,
 				struct folio *folio, unsigned int flags)
 {
@@ -58,12 +99,12 @@ static struct iomap_folio *iomap_iof_alloc(struct inode *inode,
 	else
 		gfp = GFP_NOFS | __GFP_NOFAIL;
 
-	iof = kzalloc(struct_size(iof, uptodate, BITS_TO_LONGS(nr_blocks)),
+	iof = kzalloc(struct_size(iof, state, BITS_TO_LONGS(nr_blocks)),
 		      gfp);
 	if (iof) {
-		spin_lock_init(&iof->uptodate_lock);
+		spin_lock_init(&iof->state_lock);
 		if (folio_test_uptodate(folio))
-			bitmap_fill(iof->uptodate, nr_blocks);
+			bitmap_fill(iof->state, nr_blocks);
 		folio_attach_private(folio, iof);
 	}
 	return iof;
@@ -72,14 +113,12 @@ static struct iomap_folio *iomap_iof_alloc(struct inode *inode,
 static void iomap_iof_free(struct folio *folio)
 {
 	struct iomap_folio *iof = folio_detach_private(folio);
-	struct inode *inode = folio->mapping->host;
-	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 
 	if (!iof)
 		return;
 	WARN_ON_ONCE(atomic_read(&iof->read_bytes_pending));
 	WARN_ON_ONCE(atomic_read(&iof->write_bytes_pending));
-	WARN_ON_ONCE(bitmap_full(iof->uptodate, nr_blocks) !=
+	WARN_ON_ONCE(iomap_iof_is_fully_uptodate(folio, iof) !=
 			folio_test_uptodate(folio));
 	kfree(iof);
 }
@@ -110,7 +149,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* move forward for each leading block marked uptodate */
 		for (i = first; i <= last; i++) {
-			if (!test_bit(i, iof->uptodate))
+			if (!iomap_iof_is_block_uptodate(iof, i))
 				break;
 			*pos += block_size;
 			poff += block_size;
@@ -120,7 +159,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		for ( ; i <= last; i++) {
-			if (test_bit(i, iof->uptodate)) {
+			if (iomap_iof_is_block_uptodate(iof, i)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
 				break;
@@ -144,30 +183,6 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	*lenp = plen;
 }
 
-static void iomap_iof_set_range_uptodate(struct folio *folio,
-		struct iomap_folio *iof, size_t off, size_t len)
-{
-	struct inode *inode = folio->mapping->host;
-	unsigned first = off >> inode->i_blkbits;
-	unsigned last = (off + len - 1) >> inode->i_blkbits;
-	unsigned long flags;
-
-	spin_lock_irqsave(&iof->uptodate_lock, flags);
-	bitmap_set(iof->uptodate, first, last - first + 1);
-	if (bitmap_full(iof->uptodate, i_blocks_per_folio(inode, folio)))
-		folio_mark_uptodate(folio);
-	spin_unlock_irqrestore(&iof->uptodate_lock, flags);
-}
-
-static void iomap_set_range_uptodate(struct folio *folio,
-		struct iomap_folio *iof, size_t off, size_t len)
-{
-	if (iof)
-		iomap_iof_set_range_uptodate(folio, iof, off, len);
-	else
-		folio_mark_uptodate(folio);
-}
-
 static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 		size_t len, int error)
 {
@@ -177,7 +192,7 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 		folio_clear_uptodate(folio);
 		folio_set_error(folio);
 	} else {
-		iomap_set_range_uptodate(folio, iof, offset, len);
+		iomap_set_range_uptodate(folio, offset, len);
 	}
 
 	if (!iof || atomic_sub_and_test(len, &iof->read_bytes_pending))
@@ -213,7 +228,6 @@ struct iomap_readpage_ctx {
 static int iomap_read_inline_data(const struct iomap_iter *iter,
 		struct folio *folio)
 {
-	struct iomap_folio *iof;
 	const struct iomap *iomap = iomap_iter_srcmap(iter);
 	size_t size = i_size_read(iter->inode) - iomap->offset;
 	size_t poff = offset_in_page(iomap->offset);
@@ -231,15 +245,13 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
 	if (offset > 0)
-		iof = iomap_iof_alloc(iter->inode, folio, iter->flags);
-	else
-		iof = iomap_get_iof(folio);
+		iomap_iof_alloc(iter->inode, folio, iter->flags);
 
 	addr = kmap_local_folio(folio, offset);
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - poff - size);
 	kunmap_local(addr);
-	iomap_set_range_uptodate(folio, iof, offset, PAGE_SIZE - poff);
+	iomap_set_range_uptodate(folio, offset, PAGE_SIZE - poff);
 	return 0;
 }
 
@@ -276,7 +288,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
 	if (iomap_block_needs_zeroing(iter, pos)) {
 		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, iof, poff, plen);
+		iomap_set_range_uptodate(folio, poff, plen);
 		goto done;
 	}
 
@@ -451,7 +463,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 	last = (from + count - 1) >> inode->i_blkbits;
 
 	for (i = first; i <= last; i++)
-		if (!test_bit(i, iof->uptodate))
+		if (!iomap_iof_is_block_uptodate(iof, i))
 			return false;
 	return true;
 }
@@ -589,7 +601,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 			if (status)
 				return status;
 		}
-		iomap_set_range_uptodate(folio, iof, poff, plen);
+		iomap_set_range_uptodate(folio, poff, plen);
 	} while ((block_start += plen) < block_end);
 
 	return 0;
@@ -696,7 +708,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
-	struct iomap_folio *iof = iomap_get_iof(folio);
 	flush_dcache_folio(folio);
 
 	/*
@@ -712,7 +723,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 */
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return 0;
-	iomap_set_range_uptodate(folio, iof, offset_in_folio(folio, pos), len);
+	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
 	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
 }
@@ -1628,7 +1639,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (iof && !test_bit(i, iof->uptodate))
+		if (iof && !iomap_iof_is_block_uptodate(iof, i))
 			continue;
 
 		error = wpc->ops->map_blocks(wpc, inode, pos);
-- 
2.40.1

