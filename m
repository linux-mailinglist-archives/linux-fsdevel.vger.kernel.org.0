Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878C21ACB57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 17:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896197AbgDPPqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 11:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442555AbgDPPqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:46:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9613CC061A0C
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kMLTih8CX/GbD68c1YCwFJOmEFKi+9QpHvxsolCFJz4=; b=Sc6BiJMIFfeDtTxK3dZEyjKYGF
        21+2xVXAwK0Hl6SI+MezZyD1Je9z5982qOQBkRo1ip6Cv3ygeeNpdH18EG/WbsJHUgeVvkgooZSUM
        J2lrSueDn4CjTNT4mm9Q77ixHQa5L0LhC8ZHsKPTXS9SDbKrynU820RlJigqZQ3P+tos9Vv8CnGN7
        LUtFeN+KLIe3sNVZnrPIinCYpGCi9DzZGZb1dVqtwCRL+iFkv630+s50BGLOG+64eTBtLVQJ71JpV
        uH4IVBydJBRsPI1GUBl1/up5EkFQicGIDxWI9/AdX1lAS9NamrbMJY726ERwElcQtexNmy42tFktN
        M9pN7P+Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP6iN-00006X-Fp; Thu, 16 Apr 2020 15:46:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2 3/5] mm: Convert writeback BUG to WARN_ON
Date:   Thu, 16 Apr 2020 08:46:04 -0700
Message-Id: <20200416154606.306-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200416154606.306-1-willy@infradead.org>
References: <20200416154606.306-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

If this BUG() ever triggers, we'll have a dead system with no particular
information.  Dumping the page will give us a fighting chance of debugging
the problem, and I think it's safe for us to just continue if we try
to clear the writeback bit on a page which already has the writeback
bit clear.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c        | 4 +---
 mm/page-writeback.c | 5 +++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b7c5d2402370..401b24d980ba 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1293,9 +1293,7 @@ void end_page_writeback(struct page *page)
 		rotate_reclaimable_page(page);
 	}
 
-	if (!test_clear_page_writeback(page))
-		BUG();
-
+	test_clear_page_writeback(page);
 	smp_mb__after_atomic();
 	wake_up_page(page, PG_writeback);
 }
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 7326b54ab728..ebaf0d8263a6 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2718,6 +2718,11 @@ int test_clear_page_writeback(struct page *page)
 	struct lruvec *lruvec;
 	int ret;
 
+	if (WARN_ON(!PageWriteback(page))) {
+		dump_page(page, "!writeback");
+		return false;
+	}
+
 	memcg = lock_page_memcg(page);
 	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
 	if (mapping && mapping_use_writeback_tags(mapping)) {
-- 
2.25.1

