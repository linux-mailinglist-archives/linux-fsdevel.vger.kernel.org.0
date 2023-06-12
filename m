Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0674072D0BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 22:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjFLUjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 16:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbjFLUje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:39:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A491739;
        Mon, 12 Jun 2023 13:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EkLmyaB6DA8CYGOh1SGUaX5l8dYnTWVJEORmgXgZcN8=; b=R4++hr39ESEVaBhBKwvgXoki8+
        XyhvyjhtQPZvlNvPojo9/BakFsoohm4U/VqtxhH+l6rJDjrin+mZtWzSsQokP8EsdChfXLjmhBHRp
        W/yQviM47ooc72QH5qvQv1YlgRxs6LBSvg+44G4KK1LCpgIVTOa0IdCOARbFlga8qqN10jjk0tk6h
        pYeWlKT28FEytcUzoOmdkKw0knvIW3y3z23uZ1P1AsxVtMp1GGualEk0jCc6jVzeCt/V6/hINkOO5
        1ma2qPNvsq8Erv8MwWt/YWxDjlI8EHmk/B82dkR4p2RLtJPk3nZNarGjUwDnL/5zvT9QZrO5pB06L
        eXzATyjg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8oJm-0032Sn-3S; Mon, 12 Jun 2023 20:39:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 8/8] iomap: Copy larger chunks from userspace
Date:   Mon, 12 Jun 2023 21:39:10 +0100
Message-Id: <20230612203910.724378-9-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230612203910.724378-1-willy@infradead.org>
References: <20230612203910.724378-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we have a large folio, we can copy in larger chunks than PAGE_SIZE.
Start at the maximum page cache size and shrink by half every time we
hit the "we are short on memory" problem.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a5d62c9640cf..818dc350ffc5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -768,6 +768,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 {
 	loff_t length = iomap_length(iter);
+	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
 	loff_t pos = iter->pos;
 	ssize_t written = 0;
 	long status = 0;
@@ -776,15 +777,13 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 
 	do {
 		struct folio *folio;
-		struct page *page;
-		unsigned long offset;	/* Offset into pagecache page */
-		unsigned long bytes;	/* Bytes to write to page */
+		size_t offset;		/* Offset into folio */
+		unsigned long bytes;	/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
 
-		offset = offset_in_page(pos);
-		bytes = min_t(unsigned long, PAGE_SIZE - offset,
-						iov_iter_count(i));
 again:
+		offset = pos & (chunk - 1);
+		bytes = min(chunk - offset, iov_iter_count(i));
 		status = balance_dirty_pages_ratelimited_flags(mapping,
 							       bdp_flags);
 		if (unlikely(status))
@@ -814,11 +813,14 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
-		page = folio_file_page(folio, pos >> PAGE_SHIFT);
+		offset = offset_in_folio(folio, pos);
+		if (bytes > folio_size(folio) - offset)
+			bytes = folio_size(folio) - offset;
+
 		if (mapping_writably_mapped(mapping))
-			flush_dcache_page(page);
+			flush_dcache_folio(folio);
 
-		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
+		copied = copy_page_from_iter_atomic(&folio->page, offset, bytes, i);
 
 		status = iomap_write_end(iter, pos, bytes, copied, folio);
 
@@ -835,6 +837,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			 */
 			if (copied)
 				bytes = copied;
+			if (chunk > PAGE_SIZE)
+				chunk /= 2;
 			goto again;
 		}
 		pos += status;
-- 
2.39.2

