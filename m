Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B798974D6D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 15:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjGJNEV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 09:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjGJNEJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:04:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C406F268D;
        Mon, 10 Jul 2023 06:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Xa62x9tUe4HdESmmryNJxUBaFH7m3AqjBIhlcBkeDm8=; b=FFhwt7/0AsvUiMBzPstg+Qq1DT
        bDT+M53lIT+ER0YOXK++7ZawneOi8wN4m2wfLwI8AMjAY7BqsAdxHqWxzQXE+Q9gytc9vko6ITMk7
        ucmC0zUEI3vT/dDt2R3IAA+nqMefP7Tk49JuwBMTcr/8bxggh/VjfYaxtKfucpIesU+owRhV/AkRN
        WQL+tpVAe5rWx4VGiHV93hkIShXBugd9eNe6aVsfYE3MEsJIx1sEPnjz9EYbaLJBa72GB+xCWIL0t
        6Kz1L19a76SqED9GDggf+yRgGukriA3ijPyE1uOalPxb6/keeZGSNmwrlBKwDcHB9gyIZw6+ZRO13
        TEV4AUeg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIqXY-00EcXT-2T; Mon, 10 Jul 2023 13:02:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 9/9] iomap: Copy larger chunks from userspace
Date:   Mon, 10 Jul 2023 14:02:53 +0100
Message-Id: <20230710130253.3484695-10-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230710130253.3484695-1-willy@infradead.org>
References: <20230710130253.3484695-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we have a large folio, we can copy in larger chunks than PAGE_SIZE.
Start at the maximum page cache size and shrink by half every time we
hit the "we are short on memory" problem.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2d3e90f4d16e..f21f1f641c4a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -769,6 +769,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 {
 	loff_t length = iomap_length(iter);
+	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
 	loff_t pos = iter->pos;
 	ssize_t written = 0;
 	long status = 0;
@@ -777,15 +778,12 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 
 	do {
 		struct folio *folio;
-		struct page *page;
-		unsigned long offset;	/* Offset into pagecache page */
-		unsigned long bytes;	/* Bytes to write to page */
+		size_t offset;		/* Offset into folio */
+		size_t bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
 
-		offset = offset_in_page(pos);
-		bytes = min_t(unsigned long, PAGE_SIZE - offset,
-						iov_iter_count(i));
-again:
+		offset = pos & (chunk - 1);
+		bytes = min(chunk - offset, iov_iter_count(i));
 		status = balance_dirty_pages_ratelimited_flags(mapping,
 							       bdp_flags);
 		if (unlikely(status))
@@ -815,12 +813,14 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
-		page = folio_file_page(folio, pos >> PAGE_SHIFT);
-		if (mapping_writably_mapped(mapping))
-			flush_dcache_page(page);
+		offset = offset_in_folio(folio, pos);
+		if (bytes > folio_size(folio) - offset)
+			bytes = folio_size(folio) - offset;
 
-		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
+		if (mapping_writably_mapped(mapping))
+			flush_dcache_folio(folio);
 
+		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
 		status = iomap_write_end(iter, pos, bytes, copied, folio);
 
 		if (unlikely(copied != status))
@@ -836,11 +836,13 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			 */
 			if (copied)
 				bytes = copied;
-			goto again;
+			if (chunk > PAGE_SIZE)
+				chunk /= 2;
+		} else {
+			pos += status;
+			written += status;
+			length -= status;
 		}
-		pos += status;
-		written += status;
-		length -= status;
 	} while (iov_iter_count(i) && length);
 
 	if (status == -EAGAIN) {
-- 
2.39.2

