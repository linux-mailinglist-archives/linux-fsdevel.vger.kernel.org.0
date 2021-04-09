Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6F735A698
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 21:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbhDITEc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 15:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbhDITEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:04:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFB5C061762;
        Fri,  9 Apr 2021 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Mf5he/ba/r+UNHVPyU98btIvka6mXa95Hf7mjCLcMVg=; b=MkIcROPHjS314CkgaiIP1CwgF5
        0HmmGbBqvwsE50d2qgjUX3MrkVflXJ19XWFcijM7SFcDtqGhyYBIK0c8B4Isau+a9cqhhfWjdhRbg
        8L4ixVGGE4FU60SyPRkUHx5HpAIgad3XMG3+9ps6P9wyWpxJnkn9NmlwAn9FeTlrV7PR2d5wT94Lg
        1b/D/5+nRwq3f+SKSu/eRu/PUy7mAAk9Rvpk1VORM/9KXDWSTL3OII/91qH9b2wvD1WM+x8f6888p
        Izb2bbn81A5bzHbxyzJCjAH52N7a0Yl0JsFeJAhz2Q8thoXIu1QyCr4/UbhW+onpHBFlLoN3Ics9Y
        3KGAI4bQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUwOC-000o2d-SM; Fri, 09 Apr 2021 19:02:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v7 15/28] mm: Add folio_mapcount
Date:   Fri,  9 Apr 2021 19:50:52 +0100
Message-Id: <20210409185105.188284-16-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409185105.188284-1-willy@infradead.org>
References: <20210409185105.188284-1-willy@infradead.org>
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
index 143b354c3f4a..7bd2ce197e2f 100644
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
+	if (unlikely(FolioMulti(folio)))
+		return __page_mapcount(&folio->page);
+	return atomic_read(&folio->_mapcount) + 1;
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 int total_mapcount(struct page *page);
 int page_trans_huge_mapcount(struct page *page, int *total_mapcount);
-- 
2.30.2

