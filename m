Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307B7721B7B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 03:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjFEBcQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 21:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjFEBcN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 21:32:13 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307E7A1;
        Sun,  4 Jun 2023 18:32:12 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-38dec65ab50so3705173b6e.2;
        Sun, 04 Jun 2023 18:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685928731; x=1688520731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxrzfIp1bwlxrggScZU2c1c7t8HyvxqKo5xx2x+BHzs=;
        b=ZhXeTtpuVcgvVDbY1dfOup6Ldk16IIubJUXqGucRD5kz4YgZ4tAqh3Faon7A0meR+u
         wqle3fVsQfPYcjp9erTTIZg4eBEBysJK6kZ6ixGe2yhAq2aRBdRXhgd9U39uwzxR5E3x
         0T0bcXnb/G14/ER9lH8MVvSSvIuoIJWVZz4m+gqEgKclO4WJKuWrT0JAbftrhQ5s41Sd
         uC9My94hDSd5CAKh65bXlJWCSanDCw4cUFl3wn+oBhsvo/r1DTd/UTCQstaTrCu0nYUV
         TC6lhOvc+DQzEck16laapZXAekCX/jVk8/T0UOd5ZxZI7ixGeFX2oYqgSNKxDC464e8N
         vqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685928731; x=1688520731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxrzfIp1bwlxrggScZU2c1c7t8HyvxqKo5xx2x+BHzs=;
        b=jZe6Y1kp5AvEnUa0XnjsJBZ6V2iGcwWmQSgZK5Eq5LbOQEkj/pP+wZwNgxAgrUtCZM
         dBzRlN47iA5mNhcSjGEdrnRYzHgGgfluW8H9BFeNvlP567b/AwSk/8ga4eeINrwBmd8K
         i/5y07qHjEtNGrZzZMfvKyIPfdBjbm5eLXYQISVn/bGW6BD/Gbc297AHvaUENuKxgifr
         A5lvAcwnNRIh+Eyf6XLAhhQo9qYKi5L1pDzLEM/IH7rE4lW83HTMg8a4CN1rejaa7Q1Y
         x6GQ/lrHf7oiy1fU5TAYnjbAxRaJe5ny769w/3REJBbBK7YJnMAy8oQLzZP3z9nETCu3
         vURA==
X-Gm-Message-State: AC+VfDymBLkpZwv/wSqwhWkgbV027ZnQyJCyiZWZoQub4OrhZY9sm/GR
        hi4uO0QHM+PJnX4kyjMool5UZzTDADI=
X-Google-Smtp-Source: ACHHUZ6RYWiSVkkZ4VhODX4Mhf1YOWaKUEbzP6jNZkPQI6Q5WgZjsqbNR2QuoYYGXIr9vPq9jrfS7w==
X-Received: by 2002:a05:6808:288f:b0:39a:967e:b962 with SMTP id eu15-20020a056808288f00b0039a967eb962mr4653025oib.33.1685928730963;
        Sun, 04 Jun 2023 18:32:10 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c14d00b001aaec7a2a62sm5209287plj.188.2023.06.04.18.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 18:32:10 -0700 (PDT)
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
Subject: [PATCHv6 1/5] iomap: Rename iomap_page_create/release() to iomap_iop_alloc/free()
Date:   Mon,  5 Jun 2023 07:01:48 +0530
Message-Id: <9982c97c646a4a970340b67ccfc96bdb2c981b3f.1685900733.git.ritesh.list@gmail.com>
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

This patch renames the iomap_page_create/release() functions to
iomap_iop_alloc/free() calls. Later patches adds more functions for
handling iop structure with iomap_iop_** naming conventions.
Hence iomap_iop_alloc/free() makes more sense to be consistent with all
APIs.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 063133ec77f4..4567bdd4fff9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -43,8 +43,8 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
 
 static struct bio_set iomap_ioend_bioset;
 
-static struct iomap_page *
-iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
+static struct iomap_page *iomap_iop_alloc(struct inode *inode,
+				struct folio *folio, unsigned int flags)
 {
 	struct iomap_page *iop = to_iomap_page(folio);
 	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
@@ -69,7 +69,7 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
 	return iop;
 }
 
-static void iomap_page_release(struct folio *folio)
+static void iomap_iop_free(struct folio *folio)
 {
 	struct iomap_page *iop = folio_detach_private(folio);
 	struct inode *inode = folio->mapping->host;
@@ -231,7 +231,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
 	if (offset > 0)
-		iop = iomap_page_create(iter->inode, folio, iter->flags);
+		iop = iomap_iop_alloc(iter->inode, folio, iter->flags);
 	else
 		iop = to_iomap_page(folio);
 
@@ -269,7 +269,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		return iomap_read_inline_data(iter, folio);
 
 	/* zero post-eof blocks as the page may be mapped */
-	iop = iomap_page_create(iter->inode, folio, iter->flags);
+	iop = iomap_iop_alloc(iter->inode, folio, iter->flags);
 	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
@@ -490,7 +490,7 @@ bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags)
 	 */
 	if (folio_test_dirty(folio) || folio_test_writeback(folio))
 		return false;
-	iomap_page_release(folio);
+	iomap_iop_free(folio);
 	return true;
 }
 EXPORT_SYMBOL_GPL(iomap_release_folio);
@@ -507,12 +507,12 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 	if (offset == 0 && len == folio_size(folio)) {
 		WARN_ON_ONCE(folio_test_writeback(folio));
 		folio_cancel_dirty(folio);
-		iomap_page_release(folio);
+		iomap_iop_free(folio);
 	} else if (folio_test_large(folio)) {
 		/* Must release the iop so the page can be split */
 		WARN_ON_ONCE(!folio_test_uptodate(folio) &&
 			     folio_test_dirty(folio));
-		iomap_page_release(folio);
+		iomap_iop_free(folio);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
@@ -559,7 +559,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		return 0;
 	folio_clear_error(folio);
 
-	iop = iomap_page_create(iter->inode, folio, iter->flags);
+	iop = iomap_iop_alloc(iter->inode, folio, iter->flags);
+
 	if ((iter->flags & IOMAP_NOWAIT) && !iop && nr_blocks > 1)
 		return -EAGAIN;
 
@@ -1612,7 +1613,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct folio *folio, u64 end_pos)
 {
-	struct iomap_page *iop = iomap_page_create(inode, folio, 0);
+	struct iomap_page *iop = iomap_iop_alloc(inode, folio, 0);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	unsigned nblocks = i_blocks_per_folio(inode, folio);
-- 
2.40.1

