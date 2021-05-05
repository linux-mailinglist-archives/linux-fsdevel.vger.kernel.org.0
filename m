Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DB8373E38
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhEEPNx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhEEPNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:13:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0FAC061574;
        Wed,  5 May 2021 08:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lOmqEPnS7Hw2fLegrIjeF+PaasHglD3GyP6d0HUc9GQ=; b=Ij5zjdVNciQQCz7Q+x7DNTR1WT
        wy89WDf9z8IFCOQz6QbCEk3k3YZr7ySqJzQx6RsnZdbVCvln/MLZqWksjtPnTAHpZ/h8U6v8311x9
        ZVFyp47eHeuwFVNLR7K4sKQyRtIZzJ0leSFVjDsKPu1OPqt5iFGkovc+TNkzPMh8wRFAIWyFQugBJ
        zyhpgmPPymwdtdKy5yKptnGKIBpNozDlHIvhjneqcr3TxHM8qsxLfvgy1bq2uEillBYWDrxi8YfOH
        zGCa7TSuLFBAHGlFe26SL7odgkpX3WhILfyerG9OhK6jhDu8jpKZPivwMSYi4DVLzRs7vRKI1nGPL
        VLNp1yDw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJAY-000TTA-0F; Wed, 05 May 2021 15:11:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v9 05/96] mm: Make compound_head const-preserving
Date:   Wed,  5 May 2021 16:04:57 +0100
Message-Id: <20210505150628.111735-6-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If you pass a const pointer to compound_head(), you get a const pointer
back; if you pass a mutable pointer, you get a mutable pointer back.
Also remove an unnecessary forward definition of struct page; we're about
to dereference page->compound_head, so it must already have been defined.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/page-flags.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 04a34c08e0a6..d8e26243db25 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -177,17 +177,17 @@ enum pageflags {
 
 #ifndef __GENERATING_BOUNDS_H
 
-struct page;	/* forward declaration */
-
-static inline struct page *compound_head(struct page *page)
+static inline unsigned long _compound_head(const struct page *page)
 {
 	unsigned long head = READ_ONCE(page->compound_head);
 
 	if (unlikely(head & 1))
-		return (struct page *) (head - 1);
-	return page;
+		return head - 1;
+	return (unsigned long)page;
 }
 
+#define compound_head(page)	((typeof(page))_compound_head(page))
+
 static __always_inline int PageTail(struct page *page)
 {
 	return READ_ONCE(page->compound_head) & 1;
-- 
2.30.2

