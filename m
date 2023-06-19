Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA891734A37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 04:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjFSC3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 22:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjFSC3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 22:29:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53818E47;
        Sun, 18 Jun 2023 19:29:09 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6686708c986so1560950b3a.0;
        Sun, 18 Jun 2023 19:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687141748; x=1689733748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfrcRZSVSc6FW1n1MsNyxKR20bTVgx4c9T+kFzqOa1Y=;
        b=bW0JsG/reWfDG+u9jNK1U11TWIgRONrCGYFwL1nlLVPe3ASeKsNr61sJSWSEYj4CXM
         abQYPrKM+8NbBdLPqgSnJr33kHiSNLfeQnKRK5sC5mM8Ggk42jQUAeo4QBp22lZ1cG64
         Jqj2FOyy3Ev88rgnwVjrovxveDofGI9IxnIAWy0jnjBFZ4cqRFLuWUwYuh7AJyLCZMJW
         Q6SEpf8X07/gg0P5SIaJ90WYmsNA7ZhIFhAFlqq061CTQ9tVXVZ4iTdLR8b7aUTqod5F
         SHxs8KZE4WDqqPmWJ5SOIpy7N6tFr8HHYkqntqzwEZMqrqNeJ8zE4QoRKpKYjhR3or3r
         Afzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687141748; x=1689733748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfrcRZSVSc6FW1n1MsNyxKR20bTVgx4c9T+kFzqOa1Y=;
        b=KH7is+m0dR4qQj4sLnIk5beYPTyBv+wf6lxthOwNYJz/yOfG70/YhXR53u/SYu/v/a
         kG/LvoAHEw7Wn21731VcmqOCNtvMtGNRzyuuZWXMqtIXLWqaJzS6eUuVcpTfaUnIoRrg
         woJm39ZpPLjgGuRVH45sq4rSN1aBiMEH63emf0hXg82lU8Mduegm3G1wG5sAPGBrnr+J
         DYzKp6Xw05jReRqRjZRCgOwaBrGkpflwYy4sErR0uLsfsw3Hagp2J1uCbMSqdWjiZnP7
         slqFKl/8N71jdB7Su4AkX+HZjQ1shPYhjAlAqpz0C73j9EPIjPx4u+pF+C2ugEchAb6U
         oziA==
X-Gm-Message-State: AC+VfDwfg0MtUaG7mYuDu+XkGjmbV9Nt3K8zhPT4XZjitAfujaLuLwSb
        VQEKG8ay0SXvoXGYNzEyRZBplaKwmE4=
X-Google-Smtp-Source: ACHHUZ7azD7f7y28Qj3VDpZQtADUJXLOmJmUnP7dWC+ZQ7EQQTx9Qty4n0R62Y0g1qpOSYdBssKnAw==
X-Received: by 2002:a05:6a20:9389:b0:122:958:9fc7 with SMTP id x9-20020a056a20938900b0012209589fc7mr473435pzh.40.1687141748019;
        Sun, 18 Jun 2023 19:29:08 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b0064ff1f1df65sm399531pfo.61.2023.06.18.19.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 19:29:07 -0700 (PDT)
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
Subject: [PATCHv10 2/8] iomap: Drop ifs argument from iomap_set_range_uptodate()
Date:   Mon, 19 Jun 2023 07:58:45 +0530
Message-Id: <e6c7a6e282d3cc73424f16b9d2a397283ea834f2.1687140389.git.ritesh.list@gmail.com>
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

