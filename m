Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DBB721B8A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 03:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjFEBc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 21:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjFEBcU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 21:32:20 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958F8CA;
        Sun,  4 Jun 2023 18:32:18 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-75d4094f9baso134502185a.1;
        Sun, 04 Jun 2023 18:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685928737; x=1688520737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1L+oiSZSqnkbRDURfR6VZ5Tph30FYeliu+whZymZoMQ=;
        b=K5Fq2USFRb94LNjo/FizkaukbnHSnAdsoK4XnnIDJZy+G9+fhX2Ck0nhXhUEzwQlXV
         tnpmfbPAkk7o9E60uVlmtlxmxrrsobyMf9Up5h3P/HP5W+S7ts+z4snmEo1DWfDhIJh0
         Fw1rZayf1kwFKGTlyIoTpYWhgg3aPwvKbAFrzRykCUoqIhy+SmRF4YHduEJY0u0Qhe2D
         9jdNEtpE4n3ytP/LU2Qa6FSoLGMUwtNMlADZdcH20mju5onczw1K33e7JO35lpaHwg8F
         4+6NGXGfvFMptaXhrKijvP9FAN8Od5HQGuR6h4AjEiewRMmolj7iaRkbZ0caPZP6KUjl
         Jvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685928737; x=1688520737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1L+oiSZSqnkbRDURfR6VZ5Tph30FYeliu+whZymZoMQ=;
        b=erXTmPs0052q1TFSecEdcNxY34QwQsjGSwAmRpOmuCfEXRimUUvXb+bvwqh/7y4GKA
         XmtkiI9MMm0sHXwQoQer/ZKZKHb9HRRSoRSMLdtbe0q8gks1Wg5ctR8o8k6SN/X9wwAn
         /uvzMjwhy9Hi1kI68Ohd+RxeoKbG7GDbmsgcHi269eRtQyWcR6bjACV+NkO2NI/ot7cn
         uVyCibLQmTzTzDdw+FTmZugsFlO74xvwmwJbA8sMc5W9dNTFMMd90hl+ePJzLQVGaLCU
         VBIwJ1thE1VGqpxi2JQZOSJDBdwiDU4g5qx0MRFRptCHUz2ad/onlt+aDGvkbEwYRQQ1
         B9zg==
X-Gm-Message-State: AC+VfDyrzTgXWgoAb3sbgTBmHx9iyDyZtGRYLSZog/JrYr6anOqIvMs1
        4bCN15VbFbCmtYWGYutPcbR11KXHU34=
X-Google-Smtp-Source: ACHHUZ7jmtD2YNQPmfw3SPrO6mG9OIxC/YbRyvnjV0lVgfrlRMgUpUdOl4H2QLj1DMMpNeL7qHceQA==
X-Received: by 2002:a05:6214:4118:b0:625:aa48:e625 with SMTP id kc24-20020a056214411800b00625aa48e625mr6301208qvb.53.1685928737404;
        Sun, 04 Jun 2023 18:32:17 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c14d00b001aaec7a2a62sm5209287plj.188.2023.06.04.18.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 18:32:17 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv6 3/5] iomap: Refactor some iop related accessor functions
Date:   Mon,  5 Jun 2023 07:01:50 +0530
Message-Id: <0d52baa3865f4c8fe49b8389f8e8070ed01144f8.1685900733.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685900733.git.ritesh.list@gmail.com>
References: <cover.1685900733.git.ritesh.list@gmail.com>
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

We would eventually use iomap_iop_** function naming by the rest of the
buffered-io iomap code. This patch update function arguments and naming
from iomap_set_range_uptodate() -> iomap_iop_set_range_uptodate().
iop_set_range_uptodate() then becomes an accessor function used by
iomap_iop_** functions.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 108 ++++++++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 45 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6fffda355c45..e264ff0fa36e 100644
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
@@ -43,6 +43,48 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
 
 static struct bio_set iomap_ioend_bioset;
 
+static bool iop_test_full_uptodate(struct folio *folio)
+{
+	struct iomap_page *iop = to_iomap_page(folio);
+	struct inode *inode = folio->mapping->host;
+
+	return bitmap_full(iop->state, i_blocks_per_folio(inode, folio));
+}
+
+static bool iop_test_block_uptodate(struct folio *folio, unsigned int block)
+{
+	struct iomap_page *iop = to_iomap_page(folio);
+
+	return test_bit(block, iop->state);
+}
+
+static void iop_set_range_uptodate(struct inode *inode, struct folio *folio,
+				   size_t off, size_t len)
+{
+	struct iomap_page *iop = to_iomap_page(folio);
+	unsigned int first_blk = off >> inode->i_blkbits;
+	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
+	unsigned int nr_blks = last_blk - first_blk + 1;
+	unsigned long flags;
+
+	spin_lock_irqsave(&iop->state_lock, flags);
+	bitmap_set(iop->state, first_blk, nr_blks);
+	if (iop_test_full_uptodate(folio))
+		folio_mark_uptodate(folio);
+	spin_unlock_irqrestore(&iop->state_lock, flags);
+}
+
+static void iomap_iop_set_range_uptodate(struct inode *inode,
+		struct folio *folio, size_t off, size_t len)
+{
+	struct iomap_page *iop = to_iomap_page(folio);
+
+	if (iop)
+		iop_set_range_uptodate(inode, folio, off, len);
+	else
+		folio_mark_uptodate(folio);
+}
+
 static struct iomap_page *iomap_iop_alloc(struct inode *inode,
 				struct folio *folio, unsigned int flags)
 {
@@ -58,12 +100,12 @@ static struct iomap_page *iomap_iop_alloc(struct inode *inode,
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
+			bitmap_fill(iop->state, nr_blocks);
 		folio_attach_private(folio, iop);
 	}
 	return iop;
@@ -72,14 +114,12 @@ static struct iomap_page *iomap_iop_alloc(struct inode *inode,
 static void iomap_iop_free(struct folio *folio)
 {
 	struct iomap_page *iop = to_iomap_page(folio);
-	struct inode *inode = folio->mapping->host;
-	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 
 	if (!iop)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
 	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
-	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
+	WARN_ON_ONCE(iop_test_full_uptodate(folio) !=
 			folio_test_uptodate(folio));
 	folio_detach_private(folio);
 	kfree(iop);
@@ -111,7 +151,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* move forward for each leading block marked uptodate */
 		for (i = first; i <= last; i++) {
-			if (!test_bit(i, iop->uptodate))
+			if (!iop_test_block_uptodate(folio, i))
 				break;
 			*pos += block_size;
 			poff += block_size;
@@ -121,7 +161,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		for ( ; i <= last; i++) {
-			if (test_bit(i, iop->uptodate)) {
+			if (iop_test_block_uptodate(folio, i)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
 				break;
@@ -145,30 +185,6 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	*lenp = plen;
 }
 
-static void iomap_iop_set_range_uptodate(struct folio *folio,
-		struct iomap_page *iop, size_t off, size_t len)
-{
-	struct inode *inode = folio->mapping->host;
-	unsigned first = off >> inode->i_blkbits;
-	unsigned last = (off + len - 1) >> inode->i_blkbits;
-	unsigned long flags;
-
-	spin_lock_irqsave(&iop->uptodate_lock, flags);
-	bitmap_set(iop->uptodate, first, last - first + 1);
-	if (bitmap_full(iop->uptodate, i_blocks_per_folio(inode, folio)))
-		folio_mark_uptodate(folio);
-	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
-}
-
-static void iomap_set_range_uptodate(struct folio *folio,
-		struct iomap_page *iop, size_t off, size_t len)
-{
-	if (iop)
-		iomap_iop_set_range_uptodate(folio, iop, off, len);
-	else
-		folio_mark_uptodate(folio);
-}
-
 static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 		size_t len, int error)
 {
@@ -178,7 +194,8 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 		folio_clear_uptodate(folio);
 		folio_set_error(folio);
 	} else {
-		iomap_set_range_uptodate(folio, iop, offset, len);
+		iomap_iop_set_range_uptodate(folio->mapping->host, folio,
+					     offset, len);
 	}
 
 	if (!iop || atomic_sub_and_test(len, &iop->read_bytes_pending))
@@ -214,7 +231,7 @@ struct iomap_readpage_ctx {
 static int iomap_read_inline_data(const struct iomap_iter *iter,
 		struct folio *folio)
 {
-	struct iomap_page *iop;
+	struct iomap_page __maybe_unused *iop;
 	const struct iomap *iomap = iomap_iter_srcmap(iter);
 	size_t size = i_size_read(iter->inode) - iomap->offset;
 	size_t poff = offset_in_page(iomap->offset);
@@ -240,7 +257,8 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - poff - size);
 	kunmap_local(addr);
-	iomap_set_range_uptodate(folio, iop, offset, PAGE_SIZE - poff);
+	iomap_iop_set_range_uptodate(iter->inode, folio, offset,
+				     PAGE_SIZE - poff);
 	return 0;
 }
 
@@ -277,7 +295,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
 	if (iomap_block_needs_zeroing(iter, pos)) {
 		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, iop, poff, plen);
+		iomap_iop_set_range_uptodate(iter->inode, folio, poff, plen);
 		goto done;
 	}
 
@@ -452,7 +470,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 	last = (from + count - 1) >> inode->i_blkbits;
 
 	for (i = first; i <= last; i++)
-		if (!test_bit(i, iop->uptodate))
+		if (!iop_test_block_uptodate(folio, i))
 			return false;
 	return true;
 }
@@ -591,7 +609,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 			if (status)
 				return status;
 		}
-		iomap_set_range_uptodate(folio, iop, poff, plen);
+		iomap_iop_set_range_uptodate(iter->inode, folio, poff, plen);
 	} while ((block_start += plen) < block_end);
 
 	return 0;
@@ -698,7 +716,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
-	struct iomap_page *iop = to_iomap_page(folio);
 	flush_dcache_folio(folio);
 
 	/*
@@ -714,7 +731,8 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 */
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return 0;
-	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
+	iomap_iop_set_range_uptodate(inode, folio, offset_in_folio(folio, pos),
+				     len);
 	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
 }
@@ -1630,7 +1648,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (iop && !test_bit(i, iop->uptodate))
+		if (iop && !iop_test_block_uptodate(folio, i))
 			continue;
 
 		error = wpc->ops->map_blocks(wpc, inode, pos);
-- 
2.40.1

