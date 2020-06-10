Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592691F5CEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgFJUNs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgFJUNr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708C7C03E96B;
        Wed, 10 Jun 2020 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kKWPr83CCnHxxtwHeEEuUXJQCYa+w6gxRXIKGEN1m+Y=; b=OXf4GvZchXc6QIc+E9EWDGpoXa
        b0FYw3Hv3hDk7d6Y8R3NO6NMgpO3eAu39v4kfFYvvF0zioGarbKKkiBbMRD85YicAXpqlhq8cJll2
        jjDhMWGd3cmCdmLScyIHKBbA4rr00ssIoR7eIwFjQodO6L9iE+SyCIWtBd1ugLkSvzh9VtaFunCnO
        5CU0Y/EnCaC6pj67tcNy33cGxWgUiBwbN/V3lAmOhGhpi4b2jCh/e8xEL9rfMBpxpW1CH+eVC+G7F
        3zLzer60FS3bxocfGvmaz/Vn10mhTwrWYCxQci1DbFMgnq6qc6UeGABpl2sdUEnvWjU6xaeA7f1Wp
        8Z+zcqpQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76Z-0003Sr-8m; Wed, 10 Jun 2020 20:13:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/51] mm: Print head flags in dump_page
Date:   Wed, 10 Jun 2020 13:12:55 -0700
Message-Id: <20200610201345.13273-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Tail page flags contain very little useful information.  Print the head
page's flags instead (even though PageHead is a little misleading).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/debug.c b/mm/debug.c
index b5b1de8c71ac..384eef80649d 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -163,7 +163,7 @@ void __dump_page(struct page *page, const char *reason)
 out_mapping:
 	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
 
-	pr_warn("%sflags: %#lx(%pGp)%s\n", type, page->flags, &page->flags,
+	pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags, &head->flags,
 		page_cma ? " CMA" : "");
 
 hex_only:
-- 
2.26.2

