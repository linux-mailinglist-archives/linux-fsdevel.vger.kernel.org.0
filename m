Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3E3720BEB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 00:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbjFBWZP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 18:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbjFBWZJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:25:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FC79D;
        Fri,  2 Jun 2023 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JKTgtHNHcRLTjQN0EAPfSucdF0QV/2Uzj27p0WALQZU=; b=M238qUoSHdAGx4OEliDBvdo+fY
        A8jil4e9S4a/jnWFywzU/duk0iAFs2an2zC6j96ueAA1Orukj0pT1142w60vq0AvUPxUsMWLRRhak
        IN7roTi9cNBSpoZJEA1Gp+2E8Io6r75gFiXNXATh8BtnzilNrBBkdFeFo9qEaduvaNmh7Y0dBJV0B
        HkD/Q6QRwRt3nXt5KSKdQoUyFeaAt1+892zEAHE4r5IDRwFqbRx/tgvVPLMiVBzRzyjIVvFqUbtIH
        JTm/78Vv6/TagZZYOl/uI5oXt1AllsRPCb+gsDG5FMfNTo9RoVz/3SEwrjT4FFUqas+smbK8m1y4I
        pnOBnX4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q5DCR-009aPU-7u; Fri, 02 Jun 2023 22:24:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 7/7] iomap: Copy larger chunks from userspace
Date:   Fri,  2 Jun 2023 23:24:44 +0100
Message-Id: <20230602222445.2284892-8-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230602222445.2284892-1-willy@infradead.org>
References: <20230602222445.2284892-1-willy@infradead.org>
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
index a10f9c037515..10434b07e0f9 100644
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

