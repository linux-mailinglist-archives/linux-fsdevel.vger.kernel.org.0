Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064167447BF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jul 2023 09:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjGAHfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jul 2023 03:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGAHfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jul 2023 03:35:30 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784341B0;
        Sat,  1 Jul 2023 00:35:29 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6726d5d92afso1622946b3a.1;
        Sat, 01 Jul 2023 00:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688196928; x=1690788928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfrcRZSVSc6FW1n1MsNyxKR20bTVgx4c9T+kFzqOa1Y=;
        b=JkMO+EeB7TWOE7W9QKoHmH8W7iCPrZjQqvp66uxp/7zD0bvofSDW0F2mnGA6yjxk1/
         oiKRTXah1NwQ/NJ6aCXTL9nGevQ1llhhZEiltwyvZOOFJMhuP3N6+rAPLjUpw9HfgpJb
         LPYdA+1snOR4OkjMYLMWStvmN0nO9JAtxbi1fwsoPpycBM27MuxBCOU0bU13k7QX+ILr
         vP+w2s56aLLUqL8ZKsRVFaFwlp9jfRDv3vUlXCU9EsMf6tFj9zATjXvLbJB16JOchmXI
         t8J1Taof/3wU+XiVDKoSDwtZnY/CdOBLEfxsw+TDWx4ZvF5gdIOUAQrj4oqYHMZz8yBt
         KAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688196928; x=1690788928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfrcRZSVSc6FW1n1MsNyxKR20bTVgx4c9T+kFzqOa1Y=;
        b=dmuk4Eb1sAeGXNYWhDHUetL3H/uLtZcNlAGQFyt9uerii2n0gR/BA6QXwQcrDaqiSq
         QwujuLeuQjoFKPU079sJeBchBHlj3AadRaOeqCbxjGsJN/vzY9E/Xbywr7j5REOm1Eag
         qmfTJ21xf4BHPoVIN20e3DRU2BN5nbAZA7jhowAeYAEQW00H8ciRE1aIhE5W1THoe6wW
         mH0mrXg8wpmQ7e3bvkC5BJGJ3Efz2QkcyMA6W/jwwlf/0q/5rNurZVBBIZbT74LIdMOa
         k2Ft5Nr/ZFHkoGL52degbfOxisguaEJl7Cmvn7b53QoiuInPC5hxLB1Sa1wa1J7457Vg
         I7Rg==
X-Gm-Message-State: AC+VfDxw5SZdg/w6UZwe8F0IKnc0c/Rfl4mDVSTUY5b/hBH9YzhKUPAc
        d+EEL3oUdnVP1yYV6KGitAm2gbZlpdY=
X-Google-Smtp-Source: ACHHUZ4lqHz9MT/g7gUNPBOy4CAGK9iU55942CR0NdkIt9xEpN+iRavJLNCgE9cBSSKkRUMFazWxfg==
X-Received: by 2002:a05:6a20:1612:b0:11d:9249:170e with SMTP id l18-20020a056a20161200b0011d9249170emr6580892pzj.12.1688196928216;
        Sat, 01 Jul 2023 00:35:28 -0700 (PDT)
Received: from dw-tp.localdomain ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id h14-20020aa786ce000000b0063aa1763146sm8603414pfo.17.2023.07.01.00.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 00:35:27 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv11 2/8] iomap: Drop ifs argument from iomap_set_range_uptodate()
Date:   Sat,  1 Jul 2023 13:04:35 +0530
Message-Id: <d23a8d36820d1b5be0b2ffaa37ad07f816f73b01.1688188958.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1688188958.git.ritesh.list@gmail.com>
References: <cover.1688188958.git.ritesh.list@gmail.com>
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

iomap_folio_state (ifs) can be derived directly from the folio, making it
unnecessary to pass "ifs" as an argument to iomap_set_range_uptodate().
This patch eliminates "ifs" argument from iomap_set_range_uptodate()
function.

Also, the definition of iomap_set_range_uptodate() and
ifs_set_range_uptodate() functions are moved above ifs_alloc().
In upcoming patches, we plan to introduce additional helper routines for
handling dirty state, with the intention of consolidating all of "ifs"
state handling routines at one place.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 67 +++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2675a3e0ac1d..3ff7688b360a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -36,6 +36,33 @@ struct iomap_folio_state {
 
 static struct bio_set iomap_ioend_bioset;
 
+static void ifs_set_range_uptodate(struct folio *folio,
+		struct iomap_folio_state *ifs, size_t off, size_t len)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int first_blk = off >> inode->i_blkbits;
+	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
+	unsigned int nr_blks = last_blk - first_blk + 1;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ifs->state_lock, flags);
+	bitmap_set(ifs->state, first_blk, nr_blks);
+	if (bitmap_full(ifs->state, i_blocks_per_folio(inode, folio)))
+		folio_mark_uptodate(folio);
+	spin_unlock_irqrestore(&ifs->state_lock, flags);
+}
+
+static void iomap_set_range_uptodate(struct folio *folio, size_t off,
+		size_t len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	if (ifs)
+		ifs_set_range_uptodate(folio, ifs, off, len);
+	else
+		folio_mark_uptodate(folio);
+}
+
 static struct iomap_folio_state *ifs_alloc(struct inode *inode,
 		struct folio *folio, unsigned int flags)
 {
@@ -137,30 +164,6 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	*lenp = plen;
 }
 
-static void ifs_set_range_uptodate(struct folio *folio,
-		struct iomap_folio_state *ifs, size_t off, size_t len)
-{
-	struct inode *inode = folio->mapping->host;
-	unsigned first = off >> inode->i_blkbits;
-	unsigned last = (off + len - 1) >> inode->i_blkbits;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ifs->state_lock, flags);
-	bitmap_set(ifs->state, first, last - first + 1);
-	if (bitmap_full(ifs->state, i_blocks_per_folio(inode, folio)))
-		folio_mark_uptodate(folio);
-	spin_unlock_irqrestore(&ifs->state_lock, flags);
-}
-
-static void iomap_set_range_uptodate(struct folio *folio,
-		struct iomap_folio_state *ifs, size_t off, size_t len)
-{
-	if (ifs)
-		ifs_set_range_uptodate(folio, ifs, off, len);
-	else
-		folio_mark_uptodate(folio);
-}
-
 static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 		size_t len, int error)
 {
@@ -170,7 +173,7 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 		folio_clear_uptodate(folio);
 		folio_set_error(folio);
 	} else {
-		iomap_set_range_uptodate(folio, ifs, offset, len);
+		iomap_set_range_uptodate(folio, offset, len);
 	}
 
 	if (!ifs || atomic_sub_and_test(len, &ifs->read_bytes_pending))
@@ -206,7 +209,6 @@ struct iomap_readpage_ctx {
 static int iomap_read_inline_data(const struct iomap_iter *iter,
 		struct folio *folio)
 {
-	struct iomap_folio_state *ifs;
 	const struct iomap *iomap = iomap_iter_srcmap(iter);
 	size_t size = i_size_read(iter->inode) - iomap->offset;
 	size_t poff = offset_in_page(iomap->offset);
@@ -224,15 +226,13 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
 	if (offset > 0)
-		ifs = ifs_alloc(iter->inode, folio, iter->flags);
-	else
-		ifs = folio->private;
+		ifs_alloc(iter->inode, folio, iter->flags);
 
 	addr = kmap_local_folio(folio, offset);
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - poff - size);
 	kunmap_local(addr);
-	iomap_set_range_uptodate(folio, ifs, offset, PAGE_SIZE - poff);
+	iomap_set_range_uptodate(folio, offset, PAGE_SIZE - poff);
 	return 0;
 }
 
@@ -269,7 +269,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
 	if (iomap_block_needs_zeroing(iter, pos)) {
 		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, ifs, poff, plen);
+		iomap_set_range_uptodate(folio, poff, plen);
 		goto done;
 	}
 
@@ -582,7 +582,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 			if (status)
 				return status;
 		}
-		iomap_set_range_uptodate(folio, ifs, poff, plen);
+		iomap_set_range_uptodate(folio, poff, plen);
 	} while ((block_start += plen) < block_end);
 
 	return 0;
@@ -689,7 +689,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
-	struct iomap_folio_state *ifs = folio->private;
 	flush_dcache_folio(folio);
 
 	/*
@@ -705,7 +704,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 */
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return 0;
-	iomap_set_range_uptodate(folio, ifs, offset_in_folio(folio, pos), len);
+	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
 	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
 }
-- 
2.40.1

