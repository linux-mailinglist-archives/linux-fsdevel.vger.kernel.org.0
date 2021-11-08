Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBEC447997
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbhKHE4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbhKHE4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:56:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947A2C061570;
        Sun,  7 Nov 2021 20:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1MfuoVJ9jJTxJ9WkmEmBNOz/A1EWBAGH6ihCCWxw9G4=; b=TsafeHe+4IEkpDH9w0d/ySFVBJ
        rWKmiz+I+X6BaJlm8kkLoHvDbeynS1sPNU1IAgaTGt5JS3B7Ms3ejvtAsbheZJOqZ3rhY8nO4Fj9m
        Kv0j2/3zsoF3KnoHQA+tduRLai3gi8n3I2OmyW3XR2IBamLDk/qmelZBY66NM9asuQ2sDz4BNoxIO
        Vb1IVNiqLTFsC+Hi7Iq0Ur6/22D2/c/JEsAdUjXNOtoblsTXb525LUV/DJsVz5TSEeZc4dSQQZWZr
        Ch5+KlaP/DppZHrHbjL/JF/pw6+3eMkhmwlJghjboDtXikc+yfD/W+8PXBVixuWTIk96ChaAk/6pX
        jJbHyThA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjwb9-008ASA-HV; Mon, 08 Nov 2021 04:50:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 19/28] iomap: Convert __iomap_zero_iter to use a folio
Date:   Mon,  8 Nov 2021 04:05:42 +0000
Message-Id: <20211108040551.1942823-20-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The zero iterator can work in folio-sized chunks instead of page-sized
chunks.  This will save a lot of page cache lookups if the file is cached
in multi-page folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 64e54981b651..9c61d12028ca 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -881,17 +881,20 @@ EXPORT_SYMBOL_GPL(iomap_file_unshare);
 
 static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
 {
+	struct folio *folio;
 	struct page *page;
 	int status;
-	unsigned offset = offset_in_page(pos);
-	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
+	size_t offset, bytes;
 
-	status = iomap_write_begin(iter, pos, bytes, &page);
+	status = iomap_write_begin(iter, pos, length, &page);
 	if (status)
 		return status;
+	folio = page_folio(page);
 
-	zero_user(page, offset, bytes);
-	mark_page_accessed(page);
+	offset = offset_in_folio(folio, pos);
+	bytes = min_t(u64, folio_size(folio) - offset, length);
+	folio_zero_range(folio, offset, bytes);
+	folio_mark_accessed(folio);
 
 	return iomap_write_end(iter, pos, bytes, bytes, page);
 }
-- 
2.33.0

