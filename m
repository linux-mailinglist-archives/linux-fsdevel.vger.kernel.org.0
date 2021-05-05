Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6EA373E23
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhEEPKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhEEPKw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:10:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190FBC061574;
        Wed,  5 May 2021 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TW6D4gLjvFkVSJeHS9vsTuEGdTwutQJI9gyKTOBGklQ=; b=Vxp5Ywcdw7c9SepbVisoYry1xw
        +VpGAlSHf57A+wQ7KhieZr4IOK8ri6YCYcmVVxR0kpcJh5iT4jtLKzNtYc0ZdsyaWD9SJJX0F474l
        5etPlCeTbLHObhVUdPEzo+HH8dUlwEe+1ynCRd8iOuP8q7b/lEaNG5/xfqDBdWXKCg0QSQoJPOuiJ
        N55MhAdqI/Dl3gGoD8hbzf5qQXvkcEbsJPUsYQIIu36cL6m+TtoVrZLq9dSAZ5L2+cFpHCPDFLJrF
        PJujGw/bcnTBJ58TLfYCzbbQOe/eFijnJS9PRtysRXzklnJzfmoWDfY4YXk8Sozpn36vQyAffH3wS
        ez8m4M7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJ8X-000TDX-Bx; Wed, 05 May 2021 15:09:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v9 03/96] mm/debug: Factor PagePoisoned out of __dump_page
Date:   Wed,  5 May 2021 16:04:55 +0100
Message-Id: <20210505150628.111735-4-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the PagePoisoned test into dump_page().  Skip the hex print
for poisoned pages -- we know they're full of ffffffff.  Move the
reason printing from __dump_page() to dump_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/debug.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index 84cdcd0f7bd3..e73fe0a8ec3d 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -42,11 +42,10 @@ const struct trace_print_flags vmaflag_names[] = {
 	{0, NULL}
 };
 
-static void __dump_page(struct page *page, const char *reason)
+static void __dump_page(struct page *page)
 {
 	struct page *head = compound_head(page);
 	struct address_space *mapping;
-	bool page_poisoned = PagePoisoned(page);
 	bool compound = PageCompound(page);
 	/*
 	 * Accessing the pageblock without the zone lock. It could change to
@@ -58,16 +57,6 @@ static void __dump_page(struct page *page, const char *reason)
 	int mapcount;
 	char *type = "";
 
-	/*
-	 * If struct page is poisoned don't access Page*() functions as that
-	 * leads to recursive loop. Page*() check for poisoned pages, and calls
-	 * dump_page() when detected.
-	 */
-	if (page_poisoned) {
-		pr_warn("page:%px is uninitialized and poisoned", page);
-		goto hex_only;
-	}
-
 	if (page < head || (page >= head + MAX_ORDER_NR_PAGES)) {
 		/*
 		 * Corrupt page, so we cannot call page_mapping. Instead, do a
@@ -173,8 +162,6 @@ static void __dump_page(struct page *page, const char *reason)
 
 	pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags, &head->flags,
 		page_cma ? " CMA" : "");
-
-hex_only:
 	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
 			sizeof(struct page), false);
@@ -182,14 +169,16 @@ static void __dump_page(struct page *page, const char *reason)
 		print_hex_dump(KERN_WARNING, "head: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), head,
 			sizeof(struct page), false);
-
-	if (reason)
-		pr_warn("page dumped because: %s\n", reason);
 }
 
 void dump_page(struct page *page, const char *reason)
 {
-	__dump_page(page, reason);
+	if (PagePoisoned(page))
+		pr_warn("page:%p is uninitialized and poisoned", page);
+	else
+		__dump_page(page);
+	if (reason)
+		pr_warn("page dumped because: %s\n", reason);
 	dump_page_owner(page);
 }
 EXPORT_SYMBOL(dump_page);
-- 
2.30.2

