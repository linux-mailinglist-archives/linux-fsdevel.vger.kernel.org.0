Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB31370069
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 20:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhD3SYI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 14:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3SYI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:24:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A983CC06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 11:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=n0jrc9yXOZFqM1+RQ8nbm9n1a9h7Lyetp7NHKvmt03o=; b=I/yCKDBElqzFM6Zyw3K1u45RPu
        v3CoBUBjMQHUUnqiqXGdKvwwik866mIlDf6ZgXvtNt/qoXj6Bmqeo+uKLPvv1rt0KMTQ6Rq2Vzqab
        xcsc3JBqOcnIrP8bBGBtJdnHfVpupYLSIbsrMyKdukG/MNe033D1Vr3YcpnF8sfggYsOSiTUaPGw5
        uTkecWhIIDWz7mOrqAii4vkZtCEEGAjUC5ZBtdrmOJh3AzH+HmxCo7ehoi2PgHxwLzAbHqNENhzyw
        8X/ZYl6ODIZOYuoqQxzeJvPBGIZ24cgL4NgNjV61cJD7q7TkqeO/aTGMb4Aaq22Ro54Icm6ExK7PV
        Brr3ySHw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcXkg-00BNAb-FL; Fri, 30 Apr 2021 18:21:01 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 15/31] mm: Add folio_mapcount
Date:   Fri, 30 Apr 2021 19:07:24 +0100
Message-Id: <20210430180740.2707166-16-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430180740.2707166-1-willy@infradead.org>
References: <20210430180740.2707166-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the folio equivalent of page_mapcount().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/mm.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fb779dca5ee8..bca3e2518e5e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -883,6 +883,22 @@ static inline int page_mapcount(struct page *page)
 	return atomic_read(&page->_mapcount) + 1;
 }
 
+/**
+ * folio_mapcount - The number of mappings of this folio.
+ * @folio: The folio.
+ *
+ * The result includes the number of times any of the pages in the
+ * folio are mapped to userspace.
+ *
+ * Return: The number of page table entries which refer to this folio.
+ */
+static inline int folio_mapcount(struct folio *folio)
+{
+	if (unlikely(folio_multi(folio)))
+		return __page_mapcount(&folio->page);
+	return atomic_read(&folio->_mapcount) + 1;
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 int total_mapcount(struct page *page);
 int page_trans_huge_mapcount(struct page *page, int *total_mapcount);
-- 
2.30.2

