Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAFF28DD5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 11:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbgJNJYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 05:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731165AbgJNJV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:21:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7154CC0F26EE;
        Tue, 13 Oct 2020 20:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0MPgJlidjQUsAxPbCUuZp6ht/vrWL0vbWyhDYWDy180=; b=WykgJeVCo2jBQUR9e914mBBRiL
        t/lZ2mFkZxghyBxhOoN0gFG4v4rBCu0O8s+jjng4FgaJdj2EsMcCkCSkh+dr9VEj2ml19Jd+E4hC0
        k0ZdVqKhuOx51oPCzYDDFk42yzL1+JCDjJv9Q2WG0rrLDeKgs66dLxPxhbn2kr1msHppQ+OYTROqV
        ZlMhXD/1ztzOIQpwfCmWcMTEGtVLWtatHUrKfNq9lh46GEbr7tO2hR4IhKm0BJNbZtLvPE9JsqQ/K
        eODQ+8dzCnkWwPNVForkhUZEQyL2kCn6wX5tSY96UCkylBbkGgdWExB+OkxMhemfbWANj/RQGCtOF
        ix1iQOyw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSX56-0005ip-Uo; Wed, 14 Oct 2020 03:04:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 07/14] iomap: Support THPs in readpage
Date:   Wed, 14 Oct 2020 04:03:50 +0100
Message-Id: <20201014030357.21898-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201014030357.21898-1-willy@infradead.org>
References: <20201014030357.21898-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The VFS only calls readpage if readahead has encountered an error.
Assume that any error requires the page to be split, and attempt to
do so.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4ea6c601a183..ca305fbaf811 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -343,15 +343,50 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	return pos - orig_pos + plen;
 }
 
+/*
+ * The page that was passed in has become Uptodate.  This may be due to
+ * the storage being synchronous or due to a page split finding the page
+ * is actually uptodate.  The page is still locked.
+ * Lift this into the VFS at some point.
+ */
+#define AOP_UPDATED_PAGE       (AOP_TRUNCATED_PAGE + 1)
+
+static int iomap_split_page(struct inode *inode, struct page *page)
+{
+	struct page *head = thp_head(page);
+	bool uptodate = iomap_range_uptodate(inode, head,
+				(page - head) * PAGE_SIZE, PAGE_SIZE);
+
+	iomap_page_release(head);
+	if (split_huge_page(page) < 0) {
+		unlock_page(page);
+		return AOP_TRUNCATED_PAGE;
+	}
+	if (!uptodate)
+		return 0;
+	SetPageUptodate(page);
+	return AOP_UPDATED_PAGE;
+}
+
 int
 iomap_readpage(struct page *page, const struct iomap_ops *ops)
 {
 	struct iomap_readpage_ctx ctx = { .cur_page = page };
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = thp_head(page)->mapping->host;
 	unsigned poff;
 	loff_t ret;
 
-	trace_iomap_readpage(page->mapping->host, 1);
+	trace_iomap_readpage(inode, 1);
+
+	if (PageTransCompound(page)) {
+		int status = iomap_split_page(inode, page);
+		if (status == AOP_UPDATED_PAGE) {
+			unlock_page(page);
+			return 0;
+		}
+		if (status)
+			return status;
+	}
 
 	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
 		ret = iomap_apply(inode, page_offset(page) + poff,
-- 
2.28.0

