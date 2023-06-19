Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7489B734A36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 04:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjFSC3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 22:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjFSC3H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 22:29:07 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BB2E49;
        Sun, 18 Jun 2023 19:29:06 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-668689ce13fso288577b3a.0;
        Sun, 18 Jun 2023 19:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687141744; x=1689733744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTSBRxmT6EFcDgvBi8GZxfXilWylDwjfXz02P+8Pqkw=;
        b=B2SJtG/5MC21ka2BlkOuMekjI/oI6XjptLljcNLMcZjPfIqCoET6d/G/ocWRMhFx1b
         4gQvu5Bsarh9jEOOEuhRJiJXxjN7UtR7wTk6W6+4bhepSDVr4p89I1Co6lkJOnIDWLw/
         xYmZN71p5pdg4LfVXBnOEIRXbLwDTSp1RzVqd9GtKaKj5udi3TJMs8CHReMDZOdBJS7Z
         35rZyfRtxjj0VFg1lQUNyrVvve/3keMb7MYjnfC7D720GzlVWy3tNNb+Fm983njukizR
         zqOV/hSy3Xx7nvyvHC8JVhAHk/polF++uCOrcGih4r0YNwNgTa7dtCPUhkFJM+zng4Pl
         aI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687141744; x=1689733744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTSBRxmT6EFcDgvBi8GZxfXilWylDwjfXz02P+8Pqkw=;
        b=PWhMQr+LqpunCjlOQtbejzA3otSL68egG3vQqpJ48+QWi3uf89hRfnkzxi81cDZ0SF
         8Gek6gAkBDeJBSz3BcaWpFWaWzw3VbtzNVGK490IKQj2LNkmxEhjsIBmGfBLwR2WIf4i
         gNVosiJGuV2eKfWnyvh9vYWyvaxlSxxk+KhiiujLzuxBjxk42oCMyT6/VYBFN3dTp0TF
         /wMhGzHsRsCPwBgkd6HSXvVF0vnH8PmRIRkNnXyAFfWTdw0qZoRFQniT1FUnE758ZNNF
         bJawL9CxorWNKzw6Zx1EIlphD/ExAsfAuu/6MwE9+5hhk0rRbRED7OBDOPpq+kwh05uI
         DfEA==
X-Gm-Message-State: AC+VfDyo0ZOYeWU36Neqvj2LtJpmd5r09Q5CXGaGy6XnvSs8KgA4Rlfk
        +xgCIk3Hte+aLzc8OtL2maZPhp1PhBc=
X-Google-Smtp-Source: ACHHUZ6ExRC5qV050fC6EEkKDzkE9HaTCOd4YOKM4KpkpcGkc2EEcdw3HCofosEEjm6eT4KkO3emDQ==
X-Received: by 2002:a05:6a00:b51:b0:668:71a1:2e74 with SMTP id p17-20020a056a000b5100b0066871a12e74mr1607558pfo.5.1687141744342;
        Sun, 18 Jun 2023 19:29:04 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b0064ff1f1df65sm399531pfo.61.2023.06.18.19.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 19:29:03 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv10 1/8] iomap: Rename iomap_page to iomap_folio_state and others
Date:   Mon, 19 Jun 2023 07:58:44 +0530
Message-Id: <75f5cd6a20bd3f1aa88150b903d9ef21d4c6856d.1687140389.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687140389.git.ritesh.list@gmail.com>
References: <cover.1687140389.git.ritesh.list@gmail.com>
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

struct iomap_page actually tracks per-block state of a folio.
Hence it make sense to rename some of these function names and data
structures for e.g.
1. struct iomap_page (iop) -> struct iomap_folio_state (ifs)
2. iomap_page_create() -> ifs_alloc()
3. iomap_page_release() -> ifs_free()
4. iomap_iop_set_range_uptodate() -> ifs_set_range_uptodate()
5. to_iomap_page() -> folio->private

Since in later patches we are also going to add per-block dirty state
tracking to iomap_folio_state. Hence this patch also renames "uptodate"
& "uptodate_lock" members of iomap_folio_state to "state" and"state_lock".

We don't really need to_iomap_page() function, instead directly open code
it as folio->private;

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 151 ++++++++++++++++++++---------------------
 1 file changed, 72 insertions(+), 79 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 063133ec77f4..2675a3e0ac1d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -24,64 +24,57 @@
 #define IOEND_BATCH_SIZE	4096
 
 /*
- * Structure allocated for each folio when block size < folio size
- * to track sub-folio uptodate status and I/O completions.
+ * Structure allocated for each folio to track per-block uptodate state
+ * and I/O completions.
  */
-struct iomap_page {
+struct iomap_folio_state {
 	atomic_t		read_bytes_pending;
 	atomic_t		write_bytes_pending;
-	spinlock_t		uptodate_lock;
-	unsigned long		uptodate[];
+	spinlock_t		state_lock;
+	unsigned long		state[];
 };
 
-static inline struct iomap_page *to_iomap_page(struct folio *folio)
-{
-	if (folio_test_private(folio))
-		return folio_get_private(folio);
-	return NULL;
-}
-
 static struct bio_set iomap_ioend_bioset;
 
-static struct iomap_page *
-iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
+static struct iomap_folio_state *ifs_alloc(struct inode *inode,
+		struct folio *folio, unsigned int flags)
 {
-	struct iomap_page *iop = to_iomap_page(folio);
+	struct iomap_folio_state *ifs = folio->private;
 	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 	gfp_t gfp;
 
-	if (iop || nr_blocks <= 1)
-		return iop;
+	if (ifs || nr_blocks <= 1)
+		return ifs;
 
 	if (flags & IOMAP_NOWAIT)
 		gfp = GFP_NOWAIT;
 	else
 		gfp = GFP_NOFS | __GFP_NOFAIL;
 
-	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
+	ifs = kzalloc(struct_size(ifs, state, BITS_TO_LONGS(nr_blocks)),
 		      gfp);
-	if (iop) {
-		spin_lock_init(&iop->uptodate_lock);
+	if (ifs) {
+		spin_lock_init(&ifs->state_lock);
 		if (folio_test_uptodate(folio))
-			bitmap_fill(iop->uptodate, nr_blocks);
-		folio_attach_private(folio, iop);
+			bitmap_fill(ifs->state, nr_blocks);
+		folio_attach_private(folio, ifs);
 	}
-	return iop;
+	return ifs;
 }
 
-static void iomap_page_release(struct folio *folio)
+static void ifs_free(struct folio *folio)
 {
-	struct iomap_page *iop = folio_detach_private(folio);
+	struct iomap_folio_state *ifs = folio_detach_private(folio);
 	struct inode *inode = folio->mapping->host;
 	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 
-	if (!iop)
+	if (!ifs)
 		return;
-	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
-	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
-	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
+	WARN_ON_ONCE(atomic_read(&ifs->read_bytes_pending));
+	WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending));
+	WARN_ON_ONCE(bitmap_full(ifs->state, nr_blocks) !=
 			folio_test_uptodate(folio));
-	kfree(iop);
+	kfree(ifs);
 }
 
 /*
@@ -90,7 +83,7 @@ static void iomap_page_release(struct folio *folio)
 static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 		loff_t *pos, loff_t length, size_t *offp, size_t *lenp)
 {
-	struct iomap_page *iop = to_iomap_page(folio);
+	struct iomap_folio_state *ifs = folio->private;
 	loff_t orig_pos = *pos;
 	loff_t isize = i_size_read(inode);
 	unsigned block_bits = inode->i_blkbits;
@@ -105,12 +98,12 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	 * per-block uptodate status and adjust the offset and length if needed
 	 * to avoid reading in already uptodate ranges.
 	 */
-	if (iop) {
+	if (ifs) {
 		unsigned int i;
 
 		/* move forward for each leading block marked uptodate */
 		for (i = first; i <= last; i++) {
-			if (!test_bit(i, iop->uptodate))
+			if (!test_bit(i, ifs->state))
 				break;
 			*pos += block_size;
 			poff += block_size;
@@ -120,7 +113,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		for ( ; i <= last; i++) {
-			if (test_bit(i, iop->uptodate)) {
+			if (test_bit(i, ifs->state)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
 				break;
@@ -144,26 +137,26 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	*lenp = plen;
 }
 
-static void iomap_iop_set_range_uptodate(struct folio *folio,
-		struct iomap_page *iop, size_t off, size_t len)
+static void ifs_set_range_uptodate(struct folio *folio,
+		struct iomap_folio_state *ifs, size_t off, size_t len)
 {
 	struct inode *inode = folio->mapping->host;
 	unsigned first = off >> inode->i_blkbits;
 	unsigned last = (off + len - 1) >> inode->i_blkbits;
 	unsigned long flags;
 
-	spin_lock_irqsave(&iop->uptodate_lock, flags);
-	bitmap_set(iop->uptodate, first, last - first + 1);
-	if (bitmap_full(iop->uptodate, i_blocks_per_folio(inode, folio)))
+	spin_lock_irqsave(&ifs->state_lock, flags);
+	bitmap_set(ifs->state, first, last - first + 1);
+	if (bitmap_full(ifs->state, i_blocks_per_folio(inode, folio)))
 		folio_mark_uptodate(folio);
-	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
+	spin_unlock_irqrestore(&ifs->state_lock, flags);
 }
 
 static void iomap_set_range_uptodate(struct folio *folio,
-		struct iomap_page *iop, size_t off, size_t len)
+		struct iomap_folio_state *ifs, size_t off, size_t len)
 {
-	if (iop)
-		iomap_iop_set_range_uptodate(folio, iop, off, len);
+	if (ifs)
+		ifs_set_range_uptodate(folio, ifs, off, len);
 	else
 		folio_mark_uptodate(folio);
 }
@@ -171,16 +164,16 @@ static void iomap_set_range_uptodate(struct folio *folio,
 static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 		size_t len, int error)
 {
-	struct iomap_page *iop = to_iomap_page(folio);
+	struct iomap_folio_state *ifs = folio->private;
 
 	if (unlikely(error)) {
 		folio_clear_uptodate(folio);
 		folio_set_error(folio);
 	} else {
-		iomap_set_range_uptodate(folio, iop, offset, len);
+		iomap_set_range_uptodate(folio, ifs, offset, len);
 	}
 
-	if (!iop || atomic_sub_and_test(len, &iop->read_bytes_pending))
+	if (!ifs || atomic_sub_and_test(len, &ifs->read_bytes_pending))
 		folio_unlock(folio);
 }
 
@@ -213,7 +206,7 @@ struct iomap_readpage_ctx {
 static int iomap_read_inline_data(const struct iomap_iter *iter,
 		struct folio *folio)
 {
-	struct iomap_page *iop;
+	struct iomap_folio_state *ifs;
 	const struct iomap *iomap = iomap_iter_srcmap(iter);
 	size_t size = i_size_read(iter->inode) - iomap->offset;
 	size_t poff = offset_in_page(iomap->offset);
@@ -231,15 +224,15 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
 	if (offset > 0)
-		iop = iomap_page_create(iter->inode, folio, iter->flags);
+		ifs = ifs_alloc(iter->inode, folio, iter->flags);
 	else
-		iop = to_iomap_page(folio);
+		ifs = folio->private;
 
 	addr = kmap_local_folio(folio, offset);
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - poff - size);
 	kunmap_local(addr);
-	iomap_set_range_uptodate(folio, iop, offset, PAGE_SIZE - poff);
+	iomap_set_range_uptodate(folio, ifs, offset, PAGE_SIZE - poff);
 	return 0;
 }
 
@@ -260,7 +253,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	loff_t pos = iter->pos + offset;
 	loff_t length = iomap_length(iter) - offset;
 	struct folio *folio = ctx->cur_folio;
-	struct iomap_page *iop;
+	struct iomap_folio_state *ifs;
 	loff_t orig_pos = pos;
 	size_t poff, plen;
 	sector_t sector;
@@ -269,20 +262,20 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		return iomap_read_inline_data(iter, folio);
 
 	/* zero post-eof blocks as the page may be mapped */
-	iop = iomap_page_create(iter->inode, folio, iter->flags);
+	ifs = ifs_alloc(iter->inode, folio, iter->flags);
 	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
 
 	if (iomap_block_needs_zeroing(iter, pos)) {
 		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, iop, poff, plen);
+		iomap_set_range_uptodate(folio, ifs, poff, plen);
 		goto done;
 	}
 
 	ctx->cur_folio_in_bio = true;
-	if (iop)
-		atomic_add(plen, &iop->read_bytes_pending);
+	if (ifs)
+		atomic_add(plen, &ifs->read_bytes_pending);
 
 	sector = iomap_sector(iomap, pos);
 	if (!ctx->bio ||
@@ -436,11 +429,11 @@ EXPORT_SYMBOL_GPL(iomap_readahead);
  */
 bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 {
-	struct iomap_page *iop = to_iomap_page(folio);
+	struct iomap_folio_state *ifs = folio->private;
 	struct inode *inode = folio->mapping->host;
 	unsigned first, last, i;
 
-	if (!iop)
+	if (!ifs)
 		return false;
 
 	/* Caller's range may extend past the end of this folio */
@@ -451,7 +444,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 	last = (from + count - 1) >> inode->i_blkbits;
 
 	for (i = first; i <= last; i++)
-		if (!test_bit(i, iop->uptodate))
+		if (!test_bit(i, ifs->state))
 			return false;
 	return true;
 }
@@ -490,7 +483,7 @@ bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
 	 */
 	if (folio_test_dirty(folio) || folio_test_writeback(folio))
 		return false;
-	iomap_page_release(folio);
+	ifs_free(folio);
 	return true;
 }
 EXPORT_SYMBOL_GPL(iomap_release_folio);
@@ -507,12 +500,12 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 	if (offset == 0 && len == folio_size(folio)) {
 		WARN_ON_ONCE(folio_test_writeback(folio));
 		folio_cancel_dirty(folio);
-		iomap_page_release(folio);
+		ifs_free(folio);
 	} else if (folio_test_large(folio)) {
-		/* Must release the iop so the page can be split */
+		/* Must release the ifs so the page can be split */
 		WARN_ON_ONCE(!folio_test_uptodate(folio) &&
 			     folio_test_dirty(folio));
-		iomap_page_release(folio);
+		ifs_free(folio);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
@@ -547,7 +540,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		size_t len, struct folio *folio)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	struct iomap_page *iop;
+	struct iomap_folio_state *ifs;
 	loff_t block_size = i_blocksize(iter->inode);
 	loff_t block_start = round_down(pos, block_size);
 	loff_t block_end = round_up(pos + len, block_size);
@@ -559,8 +552,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		return 0;
 	folio_clear_error(folio);
 
-	iop = iomap_page_create(iter->inode, folio, iter->flags);
-	if ((iter->flags & IOMAP_NOWAIT) && !iop && nr_blocks > 1)
+	ifs = ifs_alloc(iter->inode, folio, iter->flags);
+	if ((iter->flags & IOMAP_NOWAIT) && !ifs && nr_blocks > 1)
 		return -EAGAIN;
 
 	do {
@@ -589,7 +582,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 			if (status)
 				return status;
 		}
-		iomap_set_range_uptodate(folio, iop, poff, plen);
+		iomap_set_range_uptodate(folio, ifs, poff, plen);
 	} while ((block_start += plen) < block_end);
 
 	return 0;
@@ -696,7 +689,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
-	struct iomap_page *iop = to_iomap_page(folio);
+	struct iomap_folio_state *ifs = folio->private;
 	flush_dcache_folio(folio);
 
 	/*
@@ -712,7 +705,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 */
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return 0;
-	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
+	iomap_set_range_uptodate(folio, ifs, offset_in_folio(folio, pos), len);
 	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
 }
@@ -1290,17 +1283,17 @@ EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len, int error)
 {
-	struct iomap_page *iop = to_iomap_page(folio);
+	struct iomap_folio_state *ifs = folio->private;
 
 	if (error) {
 		folio_set_error(folio);
 		mapping_set_error(inode->i_mapping, error);
 	}
 
-	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !iop);
-	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) <= 0);
+	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
+	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <= 0);
 
-	if (!iop || atomic_sub_and_test(len, &iop->write_bytes_pending))
+	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
 		folio_end_writeback(folio);
 }
 
@@ -1567,7 +1560,7 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
  */
 static void
 iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
-		struct iomap_page *iop, struct iomap_writepage_ctx *wpc,
+		struct iomap_folio_state *ifs, struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct list_head *iolist)
 {
 	sector_t sector = iomap_sector(&wpc->iomap, pos);
@@ -1585,8 +1578,8 @@ iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
 		bio_add_folio(wpc->ioend->io_bio, folio, len, poff);
 	}
 
-	if (iop)
-		atomic_add(len, &iop->write_bytes_pending);
+	if (ifs)
+		atomic_add(len, &ifs->write_bytes_pending);
 	wpc->ioend->io_size += len;
 	wbc_account_cgroup_owner(wbc, &folio->page, len);
 }
@@ -1612,7 +1605,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct folio *folio, u64 end_pos)
 {
-	struct iomap_page *iop = iomap_page_create(inode, folio, 0);
+	struct iomap_folio_state *ifs = ifs_alloc(inode, folio, 0);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	unsigned nblocks = i_blocks_per_folio(inode, folio);
@@ -1620,7 +1613,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	int error = 0, count = 0, i;
 	LIST_HEAD(submit_list);
 
-	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
+	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) != 0);
 
 	/*
 	 * Walk through the folio to find areas to write back. If we
@@ -1628,7 +1621,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (iop && !test_bit(i, iop->uptodate))
+		if (ifs && !test_bit(i, ifs->state))
 			continue;
 
 		error = wpc->ops->map_blocks(wpc, inode, pos);
@@ -1639,7 +1632,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 			continue;
 		if (wpc->iomap.type == IOMAP_HOLE)
 			continue;
-		iomap_add_to_ioend(inode, pos, folio, iop, wpc, wbc,
+		iomap_add_to_ioend(inode, pos, folio, ifs, wpc, wbc,
 				 &submit_list);
 		count++;
 	}
-- 
2.40.1

