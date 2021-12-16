Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A48C477E46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241678AbhLPVHj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241569AbhLPVHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790A6C06173F;
        Thu, 16 Dec 2021 13:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9FeMlPUoktdp/YpxNBbRES3BvPNhzOqTg88y0XGGm68=; b=PkhhdeSsA2OZin8SLjjXrDzRF7
        nSLifAZ3hOE929JAllJk0g48OfOOiC4oTSaxtMLmLAouw/drMeXXdHCbU5aYwdlDDjtUU6PEGqAhJ
        /vHZI3xl4xPjFICcsVg6v6pCw7vfgpJ/b/eNnjah2bN8mlkiC5HmIR4oAEpkrv85QMrxtZ3KORZrR
        M2TAtqX6f0DL6/ayOqNL0iWqs56rLLx6dbKdRjm1i9dGX+RVIK/KNMqNSQHWYHvWOqWXXQ017Yf7y
        aMieMLq7Cq9kh0QFIJuAA2VIuavYXOk15Dd6jANRM6ij1ZC8PDrm+NQSnTKr7jNoEaVNGKFW21qJ8
        YKl+0/Ng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxyC-00Fx4S-QK; Thu, 16 Dec 2021 21:07:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 16/25] iomap: Convert __iomap_zero_iter to use a folio
Date:   Thu, 16 Dec 2021 21:07:06 +0000
Message-Id: <20211216210715.3801857-17-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216210715.3801857-1-willy@infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The zero iterator can work in folio-sized chunks instead of page-sized
chunks.  This will save a lot of page cache lookups if the file is cached
in large folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b1ded5204d1c..47cf558244f4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -893,19 +893,23 @@ EXPORT_SYMBOL_GPL(iomap_file_unshare);
 
 static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
 {
+	struct folio *folio;
 	struct page *page;
 	int status;
-	unsigned offset = offset_in_page(pos);
+	size_t offset;
 	unsigned bytes = min_t(u64, UINT_MAX, length);
 
 	status = iomap_write_begin(iter, pos, bytes, &page);
 	if (status)
 		return status;
-	if (bytes > PAGE_SIZE - offset)
-		bytes = PAGE_SIZE - offset;
+	folio = page_folio(page);
+
+	offset = offset_in_folio(folio, pos);
+	if (bytes > folio_size(folio) - offset)
+		bytes = folio_size(folio) - offset;
 
-	zero_user(page, offset, bytes);
-	mark_page_accessed(page);
+	folio_zero_range(folio, offset, bytes);
+	folio_mark_accessed(folio);
 
 	return iomap_write_end(iter, pos, bytes, bytes, page);
 }
-- 
2.33.0

