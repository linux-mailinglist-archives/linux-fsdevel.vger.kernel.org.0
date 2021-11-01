Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70231442264
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 22:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhKAVMZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 17:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhKAVMY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:12:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1172C061714;
        Mon,  1 Nov 2021 14:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=h+3jEzr7Ilau2SMq9EN4URkBu41FqQD5AgM5YMD1zSU=; b=r9QXxXhnq8S6YxshRFsqVLd0/u
        ERwp3f/NV7e5f/OPflRaXt7LJB7e1VskWMSGw617BDnb6Fs/EdftrvPSl17nsBMk/BGmANtdA4G41
        +7zDUjd9aQkMis4qxGOSsOPDZd6EzCMtuXACGf08PA37LKLCDMw4cVNbZtS2w996+HCULhWXuBJ2E
        md9KZafIMiN3er8Pxrm1xfKLA2efKmv6pmYg/HBNM1TOp6rs4JHekipDGI39VS9Z7q7aLTo1SUnUE
        A7GkTFv4vHqI+l6SzbQRJfrufcXlkQhXMAmEp1F7pOCnPWGZWXgImguHFlp7tuipDfie/8HBL2NF5
        B+Y0Fprw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mheV5-0041qA-H7; Mon, 01 Nov 2021 21:06:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 16/21] iomap: Convert iomap_write_end_inline to take a folio
Date:   Mon,  1 Nov 2021 20:39:24 +0000
Message-Id: <20211101203929.954622-17-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211101203929.954622-1-willy@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This conversion is only safe because iomap only supports writes to inline
data which starts at the beginning of the file.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6df8fdbb1951..6862487f4067 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -675,16 +675,16 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 }
 
 static size_t iomap_write_end_inline(const struct iomap_iter *iter,
-		struct page *page, loff_t pos, size_t copied)
+		struct folio *folio, loff_t pos, size_t copied)
 {
 	const struct iomap *iomap = &iter->iomap;
 	void *addr;
 
-	WARN_ON_ONCE(!PageUptodate(page));
+	WARN_ON_ONCE(!folio_test_uptodate(folio));
 	BUG_ON(!iomap_inline_data_valid(iomap));
 
-	flush_dcache_page(page);
-	addr = kmap_local_page(page) + pos;
+	flush_dcache_folio(folio);
+	addr = kmap_local_folio(folio, pos);
 	memcpy(iomap_inline_data(iomap, pos), addr, copied);
 	kunmap_local(addr);
 
@@ -703,7 +703,7 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 	size_t ret;
 
 	if (srcmap->type == IOMAP_INLINE) {
-		ret = iomap_write_end_inline(iter, page, pos, copied);
+		ret = iomap_write_end_inline(iter, folio, pos, copied);
 	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
 		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
 				copied, page, NULL);
-- 
2.33.0

