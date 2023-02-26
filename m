Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF566A33BC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 20:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjBZTny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 14:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZTnw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:43:52 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0D5113DE;
        Sun, 26 Feb 2023 11:43:50 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id d6so2374909pgu.2;
        Sun, 26 Feb 2023 11:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AEyK0FD0u7m5Fuvoz2Qq2YVOMRISslRd1RMA8yn7JE=;
        b=lkkiQBNLfsuFFDZJELu8gkUVrdbQ8TcB2xVC6jTdHhJC4dVVroZZ54hR8IJMdDLwB+
         LF1W/HQxcqIjghTI7gDGKG3H1EHYsTUwOz2lNnoYnrGQvIh1D2lj83zupmzRO/haq4WR
         5gMERUS0X7THMkNVioyJ8l/kwVOjlai5Y2RS+xc7i6lFeMUTcod0a0gbln2IEwIZTITa
         k1V9qGE1HBUornKCU/kQKr8DiLS92Q+haoWoyKdbAp0pvgZkVBa2M28sMPQxgvlObxjO
         QiaW//3+xj3blegbNGSTjc8TpfdT9Yk/cDfu5OqnFRYGlkImO3K3M6JwNlmDDDlDT66x
         AHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AEyK0FD0u7m5Fuvoz2Qq2YVOMRISslRd1RMA8yn7JE=;
        b=c6Toh3pM+sK2vDS59pkFpCkzff+eTZMqFXdoc6IhOPwpUD6oEtYVy4FF4J+Y5m4u4V
         kiGxxWFaEXJF+gQH2sOb1pwe5NbCjrXXEaxis4VmNkzZcgUFzm3MpzKzJZZyo2lXn8Fz
         RqI9mGIVMZgojhuq2r1KW1vNg9A5Spqq8VYcMO8WGh6gKJW0SJeAcLo5HrdYY48EOiXQ
         bwPnefN/TFpk0qFO/vKLbcKxwt1fjQ6Q/qgzO2n5QBL5SJBqCnq8fw2DyH3UyqY+rcXN
         KNUJ6p+lwkdrXyaGEmDZ9aKTEQz/ob9UmowYME5Sh3YpboDUXfMpEj7wgeNQisJ4mKC9
         At5A==
X-Gm-Message-State: AO0yUKWwqPxo5vtCMm9oyFhE4g3gUNfMgIKhuGR8dLbT7tmX4yQfgsEs
        2az6LmZ9006G50+lM5DjMZbkuo05IbI=
X-Google-Smtp-Source: AK7set/1p2/w1dVvug4DgSJPlHvv2nbAbeoEkxBoCEFPNM6o0PfLcXSDoXxLMGmP7xaQ5y+RrBHy5g==
X-Received: by 2002:aa7:9558:0:b0:5e4:5b2d:5864 with SMTP id w24-20020aa79558000000b005e45b2d5864mr6644763pfq.5.1677440629784;
        Sun, 26 Feb 2023 11:43:49 -0800 (PST)
Received: from rh-tp.. ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id r15-20020a62e40f000000b00582f222f088sm2815606pfh.47.2023.02.26.11.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 11:43:49 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv3 2/3] iomap: Change uptodate variable name to state
Date:   Mon, 27 Feb 2023 01:13:31 +0530
Message-Id: <457680a57d7c581aae81def50773ed96034af420.1677428794.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677428794.git.ritesh.list@gmail.com>
References: <cover.1677428794.git.ritesh.list@gmail.com>
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

This patch changes the struct iomap_page uptodate & uptodate_lock
member names to state and state_lock to better reflect their purpose
for the upcoming patch. It also introduces the accessor functions for
updating uptodate state bits in iop->state bitmap. This makes the code
easy to understand on when different bitmap types are getting referred
in different code paths.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 65 ++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c5b51ab1184e..e0b0be16278e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -25,13 +25,13 @@
 
 /*
  * Structure allocated for each folio when block size < folio size
- * to track sub-folio uptodate status and I/O completions.
+ * to track sub-folio uptodate state and I/O completions.
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
@@ -43,6 +43,38 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
 
 static struct bio_set iomap_ioend_bioset;
 
+/*
+ * Accessor functions for setting/clearing/checking uptodate bits in
+ * iop->state bitmap.
+ * nrblocks is i_blocks_per_folio() which is passed in every
+ * function as the last argument for API consistency.
+ */
+static inline void iop_set_range_uptodate(struct iomap_page *iop,
+				unsigned int start, unsigned int len,
+				unsigned int nrblocks)
+{
+	bitmap_set(iop->state, start, len);
+}
+
+static inline void iop_clear_range_uptodate(struct iomap_page *iop,
+				unsigned int start, unsigned int len,
+				unsigned int nrblocks)
+{
+	bitmap_clear(iop->state, start, len);
+}
+
+static inline bool iop_test_uptodate(struct iomap_page *iop, unsigned int pos,
+				unsigned int nrblocks)
+{
+	return test_bit(pos, iop->state);
+}
+
+static inline bool iop_full_uptodate(struct iomap_page *iop,
+				unsigned int nrblocks)
+{
+	return bitmap_full(iop->state, nrblocks);
+}
+
 static struct iomap_page *
 iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
 {
@@ -58,12 +90,12 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
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
+			iop_set_range_uptodate(iop, 0, nr_blocks, nr_blocks);
 		folio_attach_private(folio, iop);
 	}
 	return iop;
@@ -79,7 +111,7 @@ static void iomap_page_release(struct folio *folio)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
 	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
-	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
+	WARN_ON_ONCE(iop_full_uptodate(iop, nr_blocks) !=
 			folio_test_uptodate(folio));
 	kfree(iop);
 }
@@ -99,6 +131,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	size_t plen = min_t(loff_t, folio_size(folio) - poff, length);
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
+	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 
 	/*
 	 * If the block size is smaller than the page size, we need to check the
@@ -110,7 +143,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* move forward for each leading block marked uptodate */
 		for (i = first; i <= last; i++) {
-			if (!test_bit(i, iop->uptodate))
+			if (!iop_test_uptodate(iop, i, nr_blocks))
 				break;
 			*pos += block_size;
 			poff += block_size;
@@ -120,7 +153,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		for ( ; i <= last; i++) {
-			if (test_bit(i, iop->uptodate)) {
+			if (iop_test_uptodate(iop, i, nr_blocks)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
 				break;
@@ -151,12 +184,13 @@ static void iomap_iop_set_range_uptodate(struct folio *folio,
 	unsigned first = off >> inode->i_blkbits;
 	unsigned last = (off + len - 1) >> inode->i_blkbits;
 	unsigned long flags;
+	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 
-	spin_lock_irqsave(&iop->uptodate_lock, flags);
-	bitmap_set(iop->uptodate, first, last - first + 1);
-	if (bitmap_full(iop->uptodate, i_blocks_per_folio(inode, folio)))
+	spin_lock_irqsave(&iop->state_lock, flags);
+	iop_set_range_uptodate(iop, first, last - first + 1, nr_blocks);
+	if (iop_full_uptodate(iop, nr_blocks))
 		folio_mark_uptodate(folio);
-	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
+	spin_unlock_irqrestore(&iop->state_lock, flags);
 }
 
 static void iomap_set_range_uptodate(struct folio *folio,
@@ -439,6 +473,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 	struct iomap_page *iop = to_iomap_page(folio);
 	struct inode *inode = folio->mapping->host;
 	unsigned first, last, i;
+	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 
 	if (!iop)
 		return false;
@@ -451,7 +486,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 	last = (from + count - 1) >> inode->i_blkbits;
 
 	for (i = first; i <= last; i++)
-		if (!test_bit(i, iop->uptodate))
+		if (!iop_test_uptodate(iop, i, nr_blocks))
 			return false;
 	return true;
 }
@@ -1611,7 +1646,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (iop && !test_bit(i, iop->uptodate))
+		if (iop && !iop_test_uptodate(iop, i, nblocks))
 			continue;
 
 		error = wpc->ops->map_blocks(wpc, inode, pos);
-- 
2.39.2

