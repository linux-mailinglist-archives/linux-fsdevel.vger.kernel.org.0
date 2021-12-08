Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0138746CC53
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240015AbhLHE0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhLHE0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8C8C061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gbbxmu+s+53RY1++9cSXBb5q+fBsNrDNEdjEeiwvuA8=; b=KHT2l7KWrwSvVWmmvX7PpKnxK1
        L8+ad2z1XwLEB+iBzc92Z4LmFXM67tn867+cijQQFdXI2SK/5jA1QXQcTW3hSxM+C45hpOrESrQ4B
        ro/4VwGFTzcFUFK9qjyUvnndvI0NbL1QWBL61Cc1mlcJM4zG65o9vRwvTFSreAiukTBewdO9W5/uY
        34/Mqzb/sUX0MXY2bRZDtEv3xnMmFLrwa+EHLFimUpN749LatBzS/MS3mNypJ+VsHFuYiXCgdgb3r
        CE5hzDxfh+gbc9pCSY90zXL7rZWAGHbxL8DbfnTxAtioZJKQ3pPPeXgPy9vbU9+djpyw5MKd07zXO
        fvJoOcWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU1-0084Wl-Nj; Wed, 08 Dec 2021 04:23:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 03/48] mm/doc: Add documentation for folio_test_uptodate
Date:   Wed,  8 Dec 2021 04:22:11 +0000
Message-Id: <20211208042256.1923824-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the PG_uptodate documentation to be documentation for
folio_test_uptodate() and expand on it a little.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b5f14d581113..b3d353d537e2 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -68,9 +68,6 @@
  * might lose their PG_swapbacked flag when they simply can be dropped (e.g. as
  * a result of MADV_FREE).
  *
- * PG_uptodate tells whether the page's contents is valid.  When a read
- * completes, the page becomes uptodate, unless a disk I/O error happened.
- *
  * PG_referenced, PG_reclaim are used for page reclaim for anonymous and
  * file-backed pagecache (see mm/vmscan.c).
  *
@@ -615,6 +612,16 @@ TESTPAGEFLAG_FALSE(Ksm, ksm)
 
 u64 stable_page_flags(struct page *page);
 
+/**
+ * folio_test_uptodate - Is this folio up to date?
+ * @folio: The folio.
+ *
+ * The uptodate flag is set on a folio when every byte in the folio is
+ * at least as new as the corresponding bytes on storage.  Anonymous
+ * and CoW folios are always uptodate.  If the folio is not uptodate,
+ * some of the bytes in it may be; see the is_partially_uptodate()
+ * address_space operation.
+ */
 static inline bool folio_test_uptodate(struct folio *folio)
 {
 	bool ret = test_bit(PG_uptodate, folio_flags(folio, 0));
-- 
2.33.0

