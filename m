Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57918724145
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 13:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjFFLoK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 07:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbjFFLoH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:44:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F699E;
        Tue,  6 Jun 2023 04:44:05 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b075e13a5eso52465765ad.3;
        Tue, 06 Jun 2023 04:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686051844; x=1688643844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAzOgGtsg/+Kih2uty4XyhobUXGR9HLkebgBRhOE9sY=;
        b=lbZCRp8Tc/XE2OuvD+xEQtEFiUO7e1oohzRNOteCSbJn/iz4E72dUl16QQLm/19EvU
         mkDgeZUz1dkkX4fS3JQ1jAqJaFAOWEL6PyBHTXSrQpsyH41st3f8wT4/7mC8CiH7Mjhv
         d1fi6Ya+ypm26zYM/UX+YilTKRc6laUiBVRbtWlnizJgooswCiR398IiSpV87jO2L0Dv
         oMhhnvJn1V3fEI5fIcqHlgva7s+p2xfqTjf/65m0KG6tZeoFyM0/PWsYguTrvsEsfGIe
         FS34YKyohM7xjfXiYwkZ8XOpBBAasUBGUZVnS1zAre/WF2nSQLCcJvkrv0IjC8dM60Mn
         o8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686051844; x=1688643844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAzOgGtsg/+Kih2uty4XyhobUXGR9HLkebgBRhOE9sY=;
        b=OGLf7ZGygq+ZGb90u6wyDcNLDf3FK2RpGB8BFx6Y6prkFDVjtFUKr7sK878Q9ZDP3c
         87IK5eGmHckbZcZ+x9q7fktXGZn5FHyA+M1mmq8evqg7wyAU5Ym2Cbv+o7jCvOHS0NiQ
         mUFjy/6VnbzQ9BZ7hUgwMtwFrDbAAqGC6bdQFKWi1MQOPLm0ci2FTLnq8ld2qW7cG5oa
         I32WNDnOLFi/odqn9REiF0CPtFb7rUPUMpoyFYzwzg3KMPG4EA061ps6zYG0OypOl672
         /RFfIGjE0YuTta5CvBhoDB2a3bDzIIIVydJ54n6dAUvCyefjoSCusuEWLWDGfjQRpCVy
         yg7g==
X-Gm-Message-State: AC+VfDxD7oAk3hhlgMIrPd/RNBEAbzYiAVE7Au+gBNmJX3KXhCeSJ3qJ
        B2Ktm7o6RkoRZpT8HUiq66dfwhLvR4E=
X-Google-Smtp-Source: ACHHUZ68P6yhZMiR6wc8mpsq9FRoFW+jW0CbTneg9fNnAUggF1aBd4Nsek86qVA8bNKWmFZQp6Xmbg==
X-Received: by 2002:a17:903:1252:b0:1b0:5304:5b4e with SMTP id u18-20020a170903125200b001b053045b4emr2614604plh.43.1686051844064;
        Tue, 06 Jun 2023 04:44:04 -0700 (PDT)
Received: from dw-tp.localdomain ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001ab0a30c895sm8325120plb.202.2023.06.06.04.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:44:03 -0700 (PDT)
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
Subject: [PATCHv8 1/5] iomap: Rename iomap_page to iomap_folio and others
Date:   Tue,  6 Jun 2023 17:13:48 +0530
Message-Id: <de5ef97f16733a2acd544c1cabb3866bf7d2e701.1686050333.git.ritesh.list@gmail.com>
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

This patch renames -
1. struct iomap_page -> struct iomap_folio
2. iop -> iof
3. iomap_page_create() -> iomap_iof_alloc()
4. iomap_page_release() -> iomap_iof_free()
5. to_iomap_page() -> iomap_get_iof()

Since iomap works with folio and all the necessary conversions are
already in place. Hence rename the structures like struct iomap_page
while we are already working on it (later patches will add per-block
dirty status tracking to iomap_folio state bitmap).
Later patches also adds more functions for handling iof structure with
iomap_iof_** naming conventions. Hence iomap_iof_alloc/free() naming
makes more sense to be consistent with all APIs.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 138 ++++++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 063133ec77f4..741baa10c517 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -27,14 +27,14 @@
  * Structure allocated for each folio when block size < folio size
  * to track sub-folio uptodate status and I/O completions.
  */
-struct iomap_page {
+struct iomap_folio {
 	atomic_t		read_bytes_pending;
 	atomic_t		write_bytes_pending;
 	spinlock_t		uptodate_lock;
 	unsigned long		uptodate[];
 };
 
-static inline struct iomap_page *to_iomap_page(struct folio *folio)
+static inline struct iomap_folio *iomap_get_iof(struct folio *folio)
 {
 	if (folio_test_private(folio))
 		return folio_get_private(folio);
@@ -43,45 +43,45 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
 
 static struct bio_set iomap_ioend_bioset;
 
-static struct iomap_page *
-iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
+static struct iomap_folio *iomap_iof_alloc(struct inode *inode,
+				struct folio *folio, unsigned int flags)
 {
-	struct iomap_page *iop = to_iomap_page(folio);
+	struct iomap_folio *iof = iomap_get_iof(folio);
 	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 	gfp_t gfp;
 
-	if (iop || nr_blocks <= 1)
-		return iop;
+	if (iof || nr_blocks <= 1)
+		return iof;
 
 	if (flags & IOMAP_NOWAIT)
 		gfp = GFP_NOWAIT;
 	else
 		gfp = GFP_NOFS | __GFP_NOFAIL;
 
-	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
+	iof = kzalloc(struct_size(iof, uptodate, BITS_TO_LONGS(nr_blocks)),
 		      gfp);
-	if (iop) {
-		spin_lock_init(&iop->uptodate_lock);
+	if (iof) {
+		spin_lock_init(&iof->uptodate_lock);
 		if (folio_test_uptodate(folio))
-			bitmap_fill(iop->uptodate, nr_blocks);
-		folio_attach_private(folio, iop);
+			bitmap_fill(iof->uptodate, nr_blocks);
+		folio_attach_private(folio, iof);
 	}
-	return iop;
+	return iof;
 }
 
-static void iomap_page_release(struct folio *folio)
+static void iomap_iof_free(struct folio *folio)
 {
-	struct iomap_page *iop = folio_detach_private(folio);
+	struct iomap_folio *iof = folio_detach_private(folio);
 	struct inode *inode = folio->mapping->host;
 	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 
-	if (!iop)
+	if (!iof)
 		return;
-	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
-	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
-	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
+	WARN_ON_ONCE(atomic_read(&iof->read_bytes_pending));
+	WARN_ON_ONCE(atomic_read(&iof->write_bytes_pending));
+	WARN_ON_ONCE(bitmap_full(iof->uptodate, nr_blocks) !=
 			folio_test_uptodate(folio));
-	kfree(iop);
+	kfree(iof);
 }
 
 /*
@@ -90,7 +90,7 @@ static void iomap_page_release(struct folio *folio)
 static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 		loff_t *pos, loff_t length, size_t *offp, size_t *lenp)
 {
-	struct iomap_page *iop = to_iomap_page(folio);
+	struct iomap_folio *iof = iomap_get_iof(folio);
 	loff_t orig_pos = *pos;
 	loff_t isize = i_size_read(inode);
 	unsigned block_bits = inode->i_blkbits;
@@ -105,12 +105,12 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	 * per-block uptodate status and adjust the offset and length if needed
 	 * to avoid reading in already uptodate ranges.
 	 */
-	if (iop) {
+	if (iof) {
 		unsigned int i;
 
 		/* move forward for each leading block marked uptodate */
 		for (i = first; i <= last; i++) {
-			if (!test_bit(i, iop->uptodate))
+			if (!test_bit(i, iof->uptodate))
 				break;
 			*pos += block_size;
 			poff += block_size;
@@ -120,7 +120,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		for ( ; i <= last; i++) {
-			if (test_bit(i, iop->uptodate)) {
+			if (test_bit(i, iof->uptodate)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
 				break;
@@ -144,26 +144,26 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	*lenp = plen;
 }
 
-static void iomap_iop_set_range_uptodate(struct folio *folio,
-		struct iomap_page *iop, size_t off, size_t len)
+static void iomap_iof_set_range_uptodate(struct folio *folio,
+		struct iomap_folio *iof, size_t off, size_t len)
 {
 	struct inode *inode = folio->mapping->host;
 	unsigned first = off >> inode->i_blkbits;
 	unsigned last = (off + len - 1) >> inode->i_blkbits;
 	unsigned long flags;
 
-	spin_lock_irqsave(&iop->uptodate_lock, flags);
-	bitmap_set(iop->uptodate, first, last - first + 1);
-	if (bitmap_full(iop->uptodate, i_blocks_per_folio(inode, folio)))
+	spin_lock_irqsave(&iof->uptodate_lock, flags);
+	bitmap_set(iof->uptodate, first, last - first + 1);
+	if (bitmap_full(iof->uptodate, i_blocks_per_folio(inode, folio)))
 		folio_mark_uptodate(folio);
-	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
+	spin_unlock_irqrestore(&iof->uptodate_lock, flags);
 }
 
 static void iomap_set_range_uptodate(struct folio *folio,
-		struct iomap_page *iop, size_t off, size_t len)
+		struct iomap_folio *iof, size_t off, size_t len)
 {
-	if (iop)
-		iomap_iop_set_range_uptodate(folio, iop, off, len);
+	if (iof)
+		iomap_iof_set_range_uptodate(folio, iof, off, len);
 	else
 		folio_mark_uptodate(folio);
 }
@@ -171,16 +171,16 @@ static void iomap_set_range_uptodate(struct folio *folio,
 static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 		size_t len, int error)
 {
-	struct iomap_page *iop = to_iomap_page(folio);
+	struct iomap_folio *iof = iomap_get_iof(folio);
 
 	if (unlikely(error)) {
 		folio_clear_uptodate(folio);
 		folio_set_error(folio);
 	} else {
-		iomap_set_range_uptodate(folio, iop, offset, len);
+		iomap_set_range_uptodate(folio, iof, offset, len);
 	}
 
-	if (!iop || atomic_sub_and_test(len, &iop->read_bytes_pending))
+	if (!iof || atomic_sub_and_test(len, &iof->read_bytes_pending))
 		folio_unlock(folio);
 }
 
@@ -213,7 +213,7 @@ struct iomap_readpage_ctx {
 static int iomap_read_inline_data(const struct iomap_iter *iter,
 		struct folio *folio)
 {
-	struct iomap_page *iop;
+	struct iomap_folio *iof;
 	const struct iomap *iomap = iomap_iter_srcmap(iter);
 	size_t size = i_size_read(iter->inode) - iomap->offset;
 	size_t poff = offset_in_page(iomap->offset);
@@ -231,15 +231,15 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
 	if (offset > 0)
-		iop = iomap_page_create(iter->inode, folio, iter->flags);
+		iof = iomap_iof_alloc(iter->inode, folio, iter->flags);
 	else
-		iop = to_iomap_page(folio);
+		iof = iomap_get_iof(folio);
 
 	addr = kmap_local_folio(folio, offset);
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - poff - size);
 	kunmap_local(addr);
-	iomap_set_range_uptodate(folio, iop, offset, PAGE_SIZE - poff);
+	iomap_set_range_uptodate(folio, iof, offset, PAGE_SIZE - poff);
 	return 0;
 }
 
@@ -260,7 +260,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	loff_t pos = iter->pos + offset;
 	loff_t length = iomap_length(iter) - offset;
 	struct folio *folio = ctx->cur_folio;
-	struct iomap_page *iop;
+	struct iomap_folio *iof;
 	loff_t orig_pos = pos;
 	size_t poff, plen;
 	sector_t sector;
@@ -269,20 +269,20 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		return iomap_read_inline_data(iter, folio);
 
 	/* zero post-eof blocks as the page may be mapped */
-	iop = iomap_page_create(iter->inode, folio, iter->flags);
+	iof = iomap_iof_alloc(iter->inode, folio, iter->flags);
 	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
 
 	if (iomap_block_needs_zeroing(iter, pos)) {
 		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, iop, poff, plen);
+		iomap_set_range_uptodate(folio, iof, poff, plen);
 		goto done;
 	}
 
 	ctx->cur_folio_in_bio = true;
-	if (iop)
-		atomic_add(plen, &iop->read_bytes_pending);
+	if (iof)
+		atomic_add(plen, &iof->read_bytes_pending);
 
 	sector = iomap_sector(iomap, pos);
 	if (!ctx->bio ||
@@ -436,11 +436,11 @@ EXPORT_SYMBOL_GPL(iomap_readahead);
  */
 bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 {
-	struct iomap_page *iop = to_iomap_page(folio);
+	struct iomap_folio *iof = iomap_get_iof(folio);
 	struct inode *inode = folio->mapping->host;
 	unsigned first, last, i;
 
-	if (!iop)
+	if (!iof)
 		return false;
 
 	/* Caller's range may extend past the end of this folio */
@@ -451,7 +451,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 	last = (from + count - 1) >> inode->i_blkbits;
 
 	for (i = first; i <= last; i++)
-		if (!test_bit(i, iop->uptodate))
+		if (!test_bit(i, iof->uptodate))
 			return false;
 	return true;
 }
@@ -490,7 +490,7 @@ bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
 	 */
 	if (folio_test_dirty(folio) || folio_test_writeback(folio))
 		return false;
-	iomap_page_release(folio);
+	iomap_iof_free(folio);
 	return true;
 }
 EXPORT_SYMBOL_GPL(iomap_release_folio);
@@ -507,12 +507,12 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 	if (offset == 0 && len == folio_size(folio)) {
 		WARN_ON_ONCE(folio_test_writeback(folio));
 		folio_cancel_dirty(folio);
-		iomap_page_release(folio);
+		iomap_iof_free(folio);
 	} else if (folio_test_large(folio)) {
-		/* Must release the iop so the page can be split */
+		/* Must release the iof so the page can be split */
 		WARN_ON_ONCE(!folio_test_uptodate(folio) &&
 			     folio_test_dirty(folio));
-		iomap_page_release(folio);
+		iomap_iof_free(folio);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
@@ -547,7 +547,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		size_t len, struct folio *folio)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	struct iomap_page *iop;
+	struct iomap_folio *iof;
 	loff_t block_size = i_blocksize(iter->inode);
 	loff_t block_start = round_down(pos, block_size);
 	loff_t block_end = round_up(pos + len, block_size);
@@ -559,8 +559,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		return 0;
 	folio_clear_error(folio);
 
-	iop = iomap_page_create(iter->inode, folio, iter->flags);
-	if ((iter->flags & IOMAP_NOWAIT) && !iop && nr_blocks > 1)
+	iof = iomap_iof_alloc(iter->inode, folio, iter->flags);
+	if ((iter->flags & IOMAP_NOWAIT) && !iof && nr_blocks > 1)
 		return -EAGAIN;
 
 	do {
@@ -589,7 +589,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 			if (status)
 				return status;
 		}
-		iomap_set_range_uptodate(folio, iop, poff, plen);
+		iomap_set_range_uptodate(folio, iof, poff, plen);
 	} while ((block_start += plen) < block_end);
 
 	return 0;
@@ -696,7 +696,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
-	struct iomap_page *iop = to_iomap_page(folio);
+	struct iomap_folio *iof = iomap_get_iof(folio);
 	flush_dcache_folio(folio);
 
 	/*
@@ -712,7 +712,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 */
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return 0;
-	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
+	iomap_set_range_uptodate(folio, iof, offset_in_folio(folio, pos), len);
 	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
 }
@@ -1290,17 +1290,17 @@ EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len, int error)
 {
-	struct iomap_page *iop = to_iomap_page(folio);
+	struct iomap_folio *iof = iomap_get_iof(folio);
 
 	if (error) {
 		folio_set_error(folio);
 		mapping_set_error(inode->i_mapping, error);
 	}
 
-	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !iop);
-	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) <= 0);
+	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !iof);
+	WARN_ON_ONCE(iof && atomic_read(&iof->write_bytes_pending) <= 0);
 
-	if (!iop || atomic_sub_and_test(len, &iop->write_bytes_pending))
+	if (!iof || atomic_sub_and_test(len, &iof->write_bytes_pending))
 		folio_end_writeback(folio);
 }
 
@@ -1567,7 +1567,7 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
  */
 static void
 iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
-		struct iomap_page *iop, struct iomap_writepage_ctx *wpc,
+		struct iomap_folio *iof, struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct list_head *iolist)
 {
 	sector_t sector = iomap_sector(&wpc->iomap, pos);
@@ -1585,8 +1585,8 @@ iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
 		bio_add_folio(wpc->ioend->io_bio, folio, len, poff);
 	}
 
-	if (iop)
-		atomic_add(len, &iop->write_bytes_pending);
+	if (iof)
+		atomic_add(len, &iof->write_bytes_pending);
 	wpc->ioend->io_size += len;
 	wbc_account_cgroup_owner(wbc, &folio->page, len);
 }
@@ -1612,7 +1612,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct folio *folio, u64 end_pos)
 {
-	struct iomap_page *iop = iomap_page_create(inode, folio, 0);
+	struct iomap_folio *iof = iomap_iof_alloc(inode, folio, 0);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	unsigned nblocks = i_blocks_per_folio(inode, folio);
@@ -1620,7 +1620,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	int error = 0, count = 0, i;
 	LIST_HEAD(submit_list);
 
-	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
+	WARN_ON_ONCE(iof && atomic_read(&iof->write_bytes_pending) != 0);
 
 	/*
 	 * Walk through the folio to find areas to write back. If we
@@ -1628,7 +1628,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (iop && !test_bit(i, iop->uptodate))
+		if (iof && !test_bit(i, iof->uptodate))
 			continue;
 
 		error = wpc->ops->map_blocks(wpc, inode, pos);
@@ -1639,7 +1639,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 			continue;
 		if (wpc->iomap.type == IOMAP_HOLE)
 			continue;
-		iomap_add_to_ioend(inode, pos, folio, iop, wpc, wbc,
+		iomap_add_to_ioend(inode, pos, folio, iof, wpc, wbc,
 				 &submit_list);
 		count++;
 	}
-- 
2.40.1

