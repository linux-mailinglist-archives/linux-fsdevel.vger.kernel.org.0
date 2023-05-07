Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3599A6F9B2C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 21:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjEGT2X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 15:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGT2T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 15:28:19 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909F3AD31;
        Sun,  7 May 2023 12:28:18 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64384274895so2616045b3a.2;
        Sun, 07 May 2023 12:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683487698; x=1686079698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYZXBFa4nJVghUci8sYWd0cGOxJus9KnW3k3Yf7tQpM=;
        b=GQFQpOplbWBwDsTmAKzcESbiZOgSgBpPK8at8oKeA/AwD9acAP49MUdcSYjmA1vSQQ
         Gz2MjXEoCq7jP5ox6sHA8gRWXv9MotpZJVzBniOicx7c+lvkgHL1PEl7KRD6r+Q+WBck
         enECn2YxctOIHdFQYtExy47g/gsTWygpoz3r4DeZ9ec1LPcK0aNowLXOUBS7PWsQ880x
         TBg2YcntG0UlOOWMdVosFuu6v9Iaj4pS63TMt1rHU77KRdr2DxL0qN7cI9OStCyKAm0Y
         vCeegE9TXO6Iedhr0neQO1v7vrwqUvL8bFghqdmVDUPnwjdDDB4pIMWqke00S/GGQ4xE
         n3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683487698; x=1686079698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYZXBFa4nJVghUci8sYWd0cGOxJus9KnW3k3Yf7tQpM=;
        b=e7B4m6+7qxTVrKkyYHoHyNHqJ0fExHGfroBuxVwYHCHDeAYk587ndcQELZo3vHDmxf
         iRY1mDOtOQxiDJbCX94ToCZntk8RMbH2p+7Xedi+RizlxZGJWPHHu21sAzA9Wpkg3t67
         W/NjWd8ZCPd2ixFrfrADc+4vQb1Ktuovr3hLUW8of7o2op9+0wo9F5mDGiMjC/dFd2nH
         9Q9Qy8aQf4gk46CC4vrhLdMJ0ffY6camO7GMnbQ/OwoODwZQ1O5mGGxcLXqD+m1kNSMS
         fLBLCmENjyvb3IqlJ8QC8XG4qy3r1RWsmiCCpU+qQwpqkMWCv7Aj21hk03Gwrnd7AwS3
         bjUw==
X-Gm-Message-State: AC+VfDwkxFV5D2iGtG1G+SY4K5GxVFpD+0fZeMKFNqLZSfTVlmpagipf
        9bZo1mwvK7gR32OIDUoLk4pXS/Wuzso=
X-Google-Smtp-Source: ACHHUZ4yEIKajAYcYng78lhSAI4gDqICGe4vcoo+C8yE26ucYVjGRQnDk/l2EI0sOIT7/CdUf/40DQ==
X-Received: by 2002:a17:902:d510:b0:1ac:7ae7:3fdf with SMTP id b16-20020a170902d51000b001ac7ae73fdfmr1000474plg.41.1683487697673;
        Sun, 07 May 2023 12:28:17 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:80ba:4cb4:7226:d064:79aa])
        by smtp.gmail.com with ESMTPSA id jg18-20020a17090326d200b001a505f04a06sm5485624plb.190.2023.05.07.12.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 12:28:17 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv5 1/5] iomap: Rename iomap_page_create/release() to iop_alloc/free()
Date:   Mon,  8 May 2023 00:57:56 +0530
Message-Id: <03639dbe54a0a0ef2bd789f4e8318df22a4c5d12.1683485700.git.ritesh.list@gmail.com>
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

This patch renames the iomap_page_create/release() functions to
iop_alloc/free() calls. Later patches adds more functions for
handling iop structure with iop_** naming conventions.
Hence iop_alloc/free() makes more sense.

Note, this patch also move folio_detach_private() to happen later
after checking for bitmap_full(). This is just another small refactor
because in later patches we will move bitmap_** helpers to iop_** related
helpers which will only take a folio and hence we should move
folio_detach_private() to the end before calling kfree(iop).

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6f4c97a6d7e9..cbd945d96584 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -43,8 +43,8 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
 
 static struct bio_set iomap_ioend_bioset;
 
-static struct iomap_page *
-iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
+static struct iomap_page *iop_alloc(struct inode *inode, struct folio *folio,
+				    unsigned int flags)
 {
 	struct iomap_page *iop = to_iomap_page(folio);
 	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
@@ -69,9 +69,9 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
 	return iop;
 }
 
-static void iomap_page_release(struct folio *folio)
+static void iop_free(struct folio *folio)
 {
-	struct iomap_page *iop = folio_detach_private(folio);
+	struct iomap_page *iop = to_iomap_page(folio);
 	struct inode *inode = folio->mapping->host;
 	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 
@@ -81,6 +81,7 @@ static void iomap_page_release(struct folio *folio)
 	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
 	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
 			folio_test_uptodate(folio));
+	folio_detach_private(folio);
 	kfree(iop);
 }
 
@@ -231,7 +232,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
 	if (offset > 0)
-		iop = iomap_page_create(iter->inode, folio, iter->flags);
+		iop = iop_alloc(iter->inode, folio, iter->flags);
 	else
 		iop = to_iomap_page(folio);
 
@@ -269,7 +270,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		return iomap_read_inline_data(iter, folio);
 
 	/* zero post-eof blocks as the page may be mapped */
-	iop = iomap_page_create(iter->inode, folio, iter->flags);
+	iop = iop_alloc(iter->inode, folio, iter->flags);
 	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
@@ -497,7 +498,7 @@ bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
 	 */
 	if (folio_test_dirty(folio) || folio_test_writeback(folio))
 		return false;
-	iomap_page_release(folio);
+	iop_free(folio);
 	return true;
 }
 EXPORT_SYMBOL_GPL(iomap_release_folio);
@@ -514,12 +515,12 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 	if (offset == 0 && len == folio_size(folio)) {
 		WARN_ON_ONCE(folio_test_writeback(folio));
 		folio_cancel_dirty(folio);
-		iomap_page_release(folio);
+		iop_free(folio);
 	} else if (folio_test_large(folio)) {
 		/* Must release the iop so the page can be split */
 		WARN_ON_ONCE(!folio_test_uptodate(folio) &&
 			     folio_test_dirty(folio));
-		iomap_page_release(folio);
+		iop_free(folio);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
@@ -566,7 +567,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		return 0;
 	folio_clear_error(folio);
 
-	iop = iomap_page_create(iter->inode, folio, iter->flags);
+	iop = iop_alloc(iter->inode, folio, iter->flags);
+
 	if ((iter->flags & IOMAP_NOWAIT) && !iop && nr_blocks > 1)
 		return -EAGAIN;
 
@@ -1619,7 +1621,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct folio *folio, u64 end_pos)
 {
-	struct iomap_page *iop = iomap_page_create(inode, folio, 0);
+	struct iomap_page *iop = iop_alloc(inode, folio, 0);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	unsigned nblocks = i_blocks_per_folio(inode, folio);
-- 
2.39.2

