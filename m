Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5433477E33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241661AbhLPVHh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241568AbhLPVHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E82AC06173E;
        Thu, 16 Dec 2021 13:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ojl5PaoTezGTatzmMRn19yoajNZ3Q7oGrHkVaeCU+1s=; b=KrDp8ssOxyFOEkwsHG1jbhpE+m
        f3ox4dRdgAMy1a/FKw/GLEyZ5kCeNcyd2YGIqI4Hd8Gdi+R6X6Ly4fkFbl1iz1FTXzKilqyf7at8l
        o8Da2diwp4PDcOXMCYhXtAT2SgzjKFrjJWo606LDpG1eul3/EyDj4gaT5lAbeG7jQi5F2B97UBv1W
        qJncU7hUTseU3KMKxRklCknrcBcMYlWSL05EOh9kmd8Hs5nhFOE6gdwequd74YvQPEVUo7WZOg8Nm
        +SPjIeue68Exu9t68fgYWQhIllPPk8hNHCZJWwBAF6FCFRD4e1TWbmLQtHKsYaf55jdV60/cUmSkM
        +i6JJ4YQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxyC-00Fx4M-Lz; Thu, 16 Dec 2021 21:07:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/25] iomap: Allow iomap_write_begin() to be called with the full length
Date:   Thu, 16 Dec 2021 21:07:05 +0000
Message-Id: <20211216210715.3801857-16-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216210715.3801857-1-willy@infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the future, we want write_begin to know the entire length of the
write so that it can choose to allocate large folios.  Pass the full
length in from __iomap_zero_iter() and limit it where necessary.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8d7a67655b60..b1ded5204d1c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -619,6 +619,9 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
+	if (!mapping_large_folio_support(iter->inode->i_mapping))
+		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
+
 	if (page_ops && page_ops->page_prepare) {
 		status = page_ops->page_prepare(iter->inode, pos, len);
 		if (status)
@@ -632,6 +635,8 @@ static int iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 		goto out_no_page;
 	}
 	folio = page_folio(page);
+	if (pos + len > folio_pos(folio) + folio_size(folio))
+		len = folio_pos(folio) + folio_size(folio) - pos;
 
 	if (srcmap->type == IOMAP_INLINE)
 		status = iomap_write_begin_inline(iter, page);
@@ -891,11 +896,13 @@ static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
 	struct page *page;
 	int status;
 	unsigned offset = offset_in_page(pos);
-	unsigned bytes = min_t(u64, PAGE_SIZE - offset, length);
+	unsigned bytes = min_t(u64, UINT_MAX, length);
 
 	status = iomap_write_begin(iter, pos, bytes, &page);
 	if (status)
 		return status;
+	if (bytes > PAGE_SIZE - offset)
+		bytes = PAGE_SIZE - offset;
 
 	zero_user(page, offset, bytes);
 	mark_page_accessed(page);
-- 
2.33.0

