Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35CD36FD3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhD3PDo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 11:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhD3PDn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:03:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E245C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fyQDBoLRjVEIc34oTX/DhVq3Ck4tbF5ZYnx/FCHbDo8=; b=fszMhBpTACAkkQgZG4tyh5FsCF
        uVa0gtuljHPnTZ17Ib69X8Vm0LznNs2hH+biVMUGjHW09gf/PchBxjc1V4aiAa6mul/T+x6GJvveu
        umtuTMHDKxYErM9ciHDEQDm4Blu7NTZpk3xIthuZctmiX47yuIKk/25jmoX7W0HA4txsE4XqohCe2
        dU3n+gejT6VHYMI60Sl8hj51zuJWJLh+lpwSXnwdrJnQA5WOinCzTmQ4CyQHSPcIkCZV5NpmtYnKB
        dBjVBeGG3tw2n1oeYOd3Qft5IdTjNJfYTsbfX97+5yK4TNJCLn0sZOAc0xmKqsakyD6k9pkhm9RRv
        ahrDUAbg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcUdL-00BAw1-8Q; Fri, 30 Apr 2021 15:01:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH 4/8] mm/page_owner: Constify dump_page_owner
Date:   Fri, 30 Apr 2021 15:55:45 +0100
Message-Id: <20210430145549.2662354-5-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430145549.2662354-1-willy@infradead.org>
References: <20210430145549.2662354-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

dump_page_owner() only uses struct page to find the page_ext, and
lookup_page_ext() already takes a const argument.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/page_owner.h | 6 +++---
 mm/page_owner.c            | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index 3468794f83d2..719bfe5108c5 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -14,7 +14,7 @@ extern void __set_page_owner(struct page *page,
 extern void __split_page_owner(struct page *page, unsigned int nr);
 extern void __copy_page_owner(struct page *oldpage, struct page *newpage);
 extern void __set_page_owner_migrate_reason(struct page *page, int reason);
-extern void __dump_page_owner(struct page *page);
+extern void __dump_page_owner(const struct page *page);
 extern void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 					pg_data_t *pgdat, struct zone *zone);
 
@@ -46,7 +46,7 @@ static inline void set_page_owner_migrate_reason(struct page *page, int reason)
 	if (static_branch_unlikely(&page_owner_inited))
 		__set_page_owner_migrate_reason(page, reason);
 }
-static inline void dump_page_owner(struct page *page)
+static inline void dump_page_owner(const struct page *page)
 {
 	if (static_branch_unlikely(&page_owner_inited))
 		__dump_page_owner(page);
@@ -69,7 +69,7 @@ static inline void copy_page_owner(struct page *oldpage, struct page *newpage)
 static inline void set_page_owner_migrate_reason(struct page *page, int reason)
 {
 }
-static inline void dump_page_owner(struct page *page)
+static inline void dump_page_owner(const struct page *page)
 {
 }
 #endif /* CONFIG_PAGE_OWNER */
diff --git a/mm/page_owner.c b/mm/page_owner.c
index adfabb560eb9..f51a57e92aa3 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -392,7 +392,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 	return -ENOMEM;
 }
 
-void __dump_page_owner(struct page *page)
+void __dump_page_owner(const struct page *page)
 {
 	struct page_ext *page_ext = lookup_page_ext(page);
 	struct page_owner *page_owner;
-- 
2.30.2

