Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A1628DCDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 11:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbgJNJUu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 05:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731049AbgJNJUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A43C0F26ED;
        Tue, 13 Oct 2020 20:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3K1TcA9ng9V8ipeBlpNGiMaylyWSGeQVhOpeVH2itWk=; b=rC3J4SbtqpkzQ1b036e2mLfvI4
        oWvmxuQVRrYNkC8ODb4AFicqOCMYWUmy/RJoLyi/MH7gm4Sn6GFWC1ZpwP32WgHEFut8PS0plvbOf
        qUGBRvqQmkLmsmboFYn0MHCBAjgxKUHpCyfkzvjF+cqlluDaAFK7bCOCR1sTjy1nWq787sSFORN+x
        wolPiv9KqKkmY0g/2hEMkjFTeMBhGMsVi54Pbu56zHxYpZAcpIDxo/iHSiRU9on+eEgkZKsoKW8ok
        Faiw7eDvCChe/VIce3eURUenV8cPw7KmCuySJEZ84ZDQQdUxc3MJcKBj32K/jX3FIIJjtGWmgjTaV
        BwaQFfOw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSX56-0005ii-Ng; Wed, 14 Oct 2020 03:04:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 06/14] iomap: Support THPs in iomap_is_partially_uptodate
Date:   Wed, 14 Oct 2020 04:03:49 +0100
Message-Id: <20201014030357.21898-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201014030357.21898-1-willy@infradead.org>
References: <20201014030357.21898-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor iomap_range_uptodate() out of iomap_is_partially_uptodate() to use
by iomap_readpage() later.  iomap_is_partially_uptodate() can be called
on a tail page by generic_file_buffered_read(), so handle that correctly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 43 ++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4633ebd03a3f..4ea6c601a183 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -141,6 +141,24 @@ static void iomap_adjust_read_range(struct inode *inode, struct page *page,
 	*lenp = plen;
 }
 
+static bool iomap_range_uptodate(struct inode *inode, struct page *page,
+		size_t start, size_t len)
+{
+	struct iomap_page *iop = to_iomap_page(page);
+	size_t first = start >> inode->i_blkbits;
+	size_t last = (start + len - 1) >> inode->i_blkbits;
+	size_t i;
+
+	VM_BUG_ON_PGFLAGS(!PageLocked(page), page);
+	if (!iop)
+		return false;
+
+	for (i = first; i <= last; i++)
+		if (!test_bit(i, iop->uptodate))
+			return false;
+	return true;
+}
+
 static void
 iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 {
@@ -446,26 +464,15 @@ int
 iomap_is_partially_uptodate(struct page *page, unsigned long from,
 		unsigned long count)
 {
-	struct iomap_page *iop = to_iomap_page(page);
-	struct inode *inode = page->mapping->host;
-	unsigned len, first, last;
-	unsigned i;
-
-	/* Limit range to one page */
-	len = min_t(unsigned, PAGE_SIZE - from, count);
+	struct page *head = thp_head(page);
+	size_t len;
 
-	/* First and last blocks in range within page */
-	first = from >> inode->i_blkbits;
-	last = (from + len - 1) >> inode->i_blkbits;
+	/* 'from' is relative to page, but the bitmap is relative to head */
+	from += (page - head) * PAGE_SIZE;
+	/* Limit range to this page */
+	len = min(thp_size(head) - from, count);
 
-	if (iop) {
-		for (i = first; i <= last; i++)
-			if (!test_bit(i, iop->uptodate))
-				return 0;
-		return 1;
-	}
-
-	return 0;
+	return iomap_range_uptodate(head->mapping->host, head, from, len);
 }
 EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
 
-- 
2.28.0

