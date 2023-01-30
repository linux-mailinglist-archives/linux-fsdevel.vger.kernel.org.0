Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486DF681620
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 17:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbjA3QO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 11:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbjA3QO6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:14:58 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F496A0;
        Mon, 30 Jan 2023 08:14:57 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so15993756pjq.0;
        Mon, 30 Jan 2023 08:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVnQJu5sfmw97epqgNZa/UVQe2bS1bQ24l2zy0fQaR8=;
        b=eMsJYaljyU4mBXqckYJ7679gMuOoAW39TtZVifzp8OZe8Ry7Cdx2ykc1N2LI+jD+RY
         KIcuyomKnye6YiqO4oBAWGJzLgrY/E4ekx8bCD9ydjsEhCwOMtLOMFaCh3hB6k/hRyNL
         37h6+dHEus5bgGQHIiztxOeGCfSMH1+HG2lTP45wNTkvOvv35YijQoLt30LGoTzP2Wgf
         urfo8wuOkgwNg/n+fQQLqxYAhQ5Wqdzu8ABywMBfJt/MtZrwQ8wlpKoUXzrJy/C09VOK
         p1dC+GyIcRb/gRs59qwRwUVIPPE022SMggUML0/sMYnNNXlOUzUz8A/USn5/+XUDJXCE
         gqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVnQJu5sfmw97epqgNZa/UVQe2bS1bQ24l2zy0fQaR8=;
        b=4eEib6UYLpM8YrXQmegJIVNYog5LmXiwMsLmAf3NQ6DJrkOFjP4u1pRduFEVZkZBuf
         Y3wu9CbKEQcVYrksCgkslqtSlLignvbADai7WHG1vseLhxxEZxNY8MPZb8wbBNtggAh+
         Imi/jFS98Lp3uDQNnqfu3NP06EmQ20F+eGFQT1MM1bh1cVCeGxje35ltlxjQQGcjj3Xn
         WJv1vvjkWIyrLZZ/vSWZM8iB8lqxTliVqJd8GWJjxEE9LpjH1KZnppNkzW4b+R1EnkiV
         ZtFdYQE16GgbvZyKNnNusUuTF3x34PYB1sGgn5t3J/68Huwc9SV5xFrP5FZdXIaha22p
         /8rQ==
X-Gm-Message-State: AFqh2kqszFDuiaG4rfxDGs19gw5Bpirek8osP2NV1pPcNP/EuMCTWqGD
        YKWGRRJ81Rf4Vvikl2Bx1zfnb/EdpsA=
X-Google-Smtp-Source: AMrXdXslwc1bySRsEQVTpleWdHv2ZGFNzVXvqPujcOQcQUZksEVc9Vq2vfbPi+pwPQxtroccbF8MQA==
X-Received: by 2002:a05:6a20:d695:b0:af:9391:449 with SMTP id it21-20020a056a20d69500b000af93910449mr53788823pzb.45.1675095296569;
        Mon, 30 Jan 2023 08:14:56 -0800 (PST)
Received: from localhost ([2406:7400:63:1fd8:5041:db86:706c:f96b])
        by smtp.gmail.com with ESMTPSA id g22-20020a170902869600b00195e8f97e72sm7988369plo.111.2023.01.30.08.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 08:14:56 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Aravinda Herle <araherle@in.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 2/3] iomap: Change uptodate variable name to state
Date:   Mon, 30 Jan 2023 21:44:12 +0530
Message-Id: <bf30b7bfb03ef368e6e744b3c63af3dbfa11304d.1675093524.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675093524.git.ritesh.list@gmail.com>
References: <cover.1675093524.git.ritesh.list@gmail.com>
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

This patch just changes the struct iomap_page uptodate & uptodate_lock
member names to state and state_lock to better reflect their purpose for
the upcoming patch.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e9c85fcf7a1f..faee2852db8f 100644
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
@@ -58,12 +58,12 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
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
@@ -79,7 +79,7 @@ static void iomap_page_release(struct folio *folio)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
 	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
-	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
+	WARN_ON_ONCE(bitmap_full(iop->state, nr_blocks) !=
 			folio_test_uptodate(folio));
 	kfree(iop);
 }
@@ -110,7 +110,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* move forward for each leading block marked uptodate */
 		for (i = first; i <= last; i++) {
-			if (!test_bit(i, iop->uptodate))
+			if (!test_bit(i, iop->state))
 				break;
 			*pos += block_size;
 			poff += block_size;
@@ -120,7 +120,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		for ( ; i <= last; i++) {
-			if (test_bit(i, iop->uptodate)) {
+			if (test_bit(i, iop->state)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
 				break;
@@ -152,11 +152,11 @@ static void iomap_iop_set_range_uptodate(struct folio *folio,
 	unsigned last = (off + len - 1) >> inode->i_blkbits;
 	unsigned long flags;
 
-	spin_lock_irqsave(&iop->uptodate_lock, flags);
-	bitmap_set(iop->uptodate, first, last - first + 1);
-	if (bitmap_full(iop->uptodate, i_blocks_per_folio(inode, folio)))
+	spin_lock_irqsave(&iop->state_lock, flags);
+	bitmap_set(iop->state, first, last - first + 1);
+	if (bitmap_full(iop->state, i_blocks_per_folio(inode, folio)))
 		folio_mark_uptodate(folio);
-	spin_unlock_irqrestore(&iop->uptodate_lock, flags);
+	spin_unlock_irqrestore(&iop->state_lock, flags);
 }
 
 static void iomap_set_range_uptodate(struct folio *folio,
@@ -451,7 +451,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 	last = (from + count - 1) >> inode->i_blkbits;
 
 	for (i = first; i <= last; i++)
-		if (!test_bit(i, iop->uptodate))
+		if (!test_bit(i, iop->state))
 			return false;
 	return true;
 }
@@ -1606,7 +1606,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (iop && !test_bit(i, iop->uptodate))
+		if (iop && !test_bit(i, iop->state))
 			continue;
 
 		error = wpc->ops->map_blocks(wpc, inode, pos);
-- 
2.39.1

