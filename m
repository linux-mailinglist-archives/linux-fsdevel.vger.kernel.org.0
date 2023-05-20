Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE58770A93F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 18:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjETQgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 12:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjETQgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 12:36:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584F312B;
        Sat, 20 May 2023 09:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=G8R+9r5H5eayXawZZnfYLCL8sm7lGrrcnrGnQVim6Zc=; b=ftlkdCsZOc/Yrd3rhMkCMxS4ZJ
        KtgOjsdMgaCtf0x1HkxzN2o/hOz3kUAWGZFm6UEytzqGzPWp4cMHRAXD7pCIcysbxPAszJOBXp1EW
        4Wx/9SerSNtiyGoHLp8kV8K/X2mb7qRIkxWpL9F+KnvgNprBe58NZ7Jvnc+M156RlZXqHhjhdJpfY
        ONt1pvIVF0XeHC/cgcI8/B9O5LZPWhrQDyRnbRAE+nuLjx4hEFGy403dA9FZvqCudFD2bMHcZ+BY9
        Vl17fDJnZEfECMT0AjNTRHDsfnaok7AW6mdWBPYDXIZZqn5JPbcJQ4IAHv9svzO6XdCwy2EmLzct9
        WgBFm09w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q0PYr-007WmX-MU; Sat, 20 May 2023 16:36:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 3/3] iomap: Copy larger chunks from userspace
Date:   Sat, 20 May 2023 17:36:03 +0100
Message-Id: <20230520163603.1794256-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230520163603.1794256-1-willy@infradead.org>
References: <20230520163603.1794256-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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
---
 fs/iomap/buffered-io.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 651af2d424ac..aa1268e708fb 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -775,6 +775,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 {
 	loff_t length = iomap_length(iter);
+	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
 	loff_t pos = iter->pos;
 	ssize_t written = 0;
 	long status = 0;
@@ -783,15 +784,13 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 
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
@@ -821,11 +820,14 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
-		page = folio_file_page(folio, pos >> PAGE_SHIFT);
+		offset = offset_in_folio(folio, pos);
+		if (bytes > folio_size(folio) - offset);
+			bytes = folio_size(folio) - offset;
+
 		if (mapping_writably_mapped(mapping))
-			flush_dcache_page(page);
+			flush_dcache_folio(folio);
 
-		copied = copy_page_from_iter_atomic(page, offset, bytes, i);
+		copied = copy_page_from_iter_atomic(&folio->page, offset, bytes, i);
 
 		status = iomap_write_end(iter, pos, bytes, copied, folio);
 
@@ -842,6 +844,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
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

