Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEF06F9B2F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 21:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjEGT2Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 15:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjEGT2W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 15:28:22 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B27100D9;
        Sun,  7 May 2023 12:28:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-643465067d1so2789395b3a.0;
        Sun, 07 May 2023 12:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683487701; x=1686079701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK0wQ7QKcUfY9HPjMPEbXTmR1QCK1bRi/YuJR9xyKMU=;
        b=e78tsOUHdrd4DbrN/nOW/i66l6Kl2a83dBZBq3kfQ/g5+WzwY+QM44/XlMcorQN4be
         9GuwkHsJ4kdp2MRYCSdmrIaWnNh4dd+Zsv4/J+obmhAlsJW0Hv29TZOt+8KVAjwftVSU
         gDpnWPtYRRNdB/YOzjb4j3Vgyj9U0VOXgpS/mNwGn2+SUhDZF92r6t2HGS/R8atzFbjk
         whtQK7DHd7fPOxp8AGQiGCc1FSm6slMUrbLtk9r2y61Lrez2O1fws9qgGQ/XwxeKnLhH
         c+AAkyQrKbmZonFLxkJzrr9dUz7MDNb9aDYLZUSfHfSxjXmxQX8AAJZz9y5YFGdobwiy
         +9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683487701; x=1686079701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sK0wQ7QKcUfY9HPjMPEbXTmR1QCK1bRi/YuJR9xyKMU=;
        b=VRNe0LFELCfHj3L3LV+WU2BNlxDrt9G2dRm5mNj9JercDCDqzwqoDJ60cCH50KlQph
         veW1ZK7hl+HfQpiOotU5Wpn2sEnJHzfHFXF8gGBA8t4Jhnh5WrrSVKU70I2Rbe1xsxDn
         0VfqHSuxuhit+05AkhgPqlPRRjHMmarMioZnLPgOuzsQ/gH5o+pxzWCEtK+EEIl3IXpR
         kcuYdALkaGbQZy1b4hrRgqUZjp3Ee16/Sm5uRCU8x27f1zgwRlL/W+f5foNcHUVBEZP4
         cE6GX/PlX/Em4sIWe95Zjq9jIK5g8EJ5W4lJI2/ncBGJNwTCvKbokJ6Z/TYRGRCNZqvg
         26eg==
X-Gm-Message-State: AC+VfDzd5lcVOOAnVtT21yyS/2RLe8Pt9lRq3zMRcZK4qATn5L3Fr83H
        HsEJVLDUGvZMcXQ9e6AyLTnppqfMbmc=
X-Google-Smtp-Source: ACHHUZ5IWVJk+QBzRS2+ieAWmqfrC8kJEsIQNnE/4XlUagWqiBOCKE7WK5ral1NF09nwIKaEssqvOg==
X-Received: by 2002:a17:903:247:b0:1ab:16cd:51a3 with SMTP id j7-20020a170903024700b001ab16cd51a3mr10619270plh.10.1683487700636;
        Sun, 07 May 2023 12:28:20 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:80ba:4cb4:7226:d064:79aa])
        by smtp.gmail.com with ESMTPSA id jg18-20020a17090326d200b001a505f04a06sm5485624plb.190.2023.05.07.12.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 12:28:20 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv5 2/5] iomap: Refactor iop_set_range_uptodate() function
Date:   Mon,  8 May 2023 00:57:57 +0530
Message-Id: <203a9e25873f6c94c9de89823439aa1f6a7dc714.1683485700.git.ritesh.list@gmail.com>
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

This patch moves up and combine the definitions of two functions
(iomap_iop_set_range_uptodate() & iomap_set_range_uptodate()) into
iop_set_range_uptodate() & refactors it's arguments a bit.

No functionality change in this patch.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 57 ++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index cbd945d96584..e732581dc2d4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -43,6 +43,27 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)

 static struct bio_set iomap_ioend_bioset;

+static void iop_set_range_uptodate(struct inode *inode, struct folio *folio,
+				   size_t off, size_t len)
+{
+	struct iomap_page *iop = to_iomap_page(folio);
+	unsigned int first_blk = off >> inode->i_blkbits;
+	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
+	unsigned int nr_blks = last_blk - first_blk + 1;
+	unsigned long flags;
+
+	if (iop) {
+		spin_lock_irqsave(&iop->uptodate_lock, flags);
+		bitmap_set(iop->uptodate, first_blk, nr_blks);
+		if (bitmap_full(iop->uptodate,
+				i_blocks_per_folio(inode, folio)))
+			folio_mark_uptodate(folio);
+		spin_unlock_irqrestore(&iop->uptodate_lock, flags);
+	} else {
+		folio_mark_uptodate(folio);
+	}
+}
+
 static struct iomap_page *iop_alloc(struct inode *inode, struct folio *folio,
 				    unsigned int flags)
 {
@@ -145,30 +166,6 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
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
@@ -178,7 +175,8 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 		folio_clear_uptodate(folio);
 		folio_set_error(folio);
 	} else {
-		iomap_set_range_uptodate(folio, iop, offset, len);
+		iop_set_range_uptodate(folio->mapping->host, folio, offset,
+				       len);
 	}

 	if (!iop || atomic_sub_and_test(len, &iop->read_bytes_pending))
@@ -240,7 +238,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - poff - size);
 	kunmap_local(addr);
-	iomap_set_range_uptodate(folio, iop, offset, PAGE_SIZE - poff);
+	iop_set_range_uptodate(iter->inode, folio, offset, PAGE_SIZE - poff);
 	return 0;
 }

@@ -277,7 +275,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,

 	if (iomap_block_needs_zeroing(iter, pos)) {
 		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, iop, poff, plen);
+		iop_set_range_uptodate(iter->inode, folio, poff, plen);
 		goto done;
 	}

@@ -598,7 +596,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 			if (status)
 				return status;
 		}
-		iomap_set_range_uptodate(folio, iop, poff, plen);
+		iop_set_range_uptodate(iter->inode, folio, poff, plen);
 	} while ((block_start += plen) < block_end);

 	return 0;
@@ -705,7 +703,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
-	struct iomap_page *iop = to_iomap_page(folio);
 	flush_dcache_folio(folio);

 	/*
@@ -721,7 +718,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 */
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return 0;
-	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
+	iop_set_range_uptodate(inode, folio, offset_in_folio(folio, pos), len);
 	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
 }
--
2.39.2

