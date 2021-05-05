Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF62D373E31
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhEEPMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbhEEPMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:12:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2919C061574;
        Wed,  5 May 2021 08:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fyQDBoLRjVEIc34oTX/DhVq3Ck4tbF5ZYnx/FCHbDo8=; b=q3wEq6eLxvrAKTb5K5dL1ZfLJ+
        SX+MX4njqFFxD7mUW+yLKdOYqqXf04kChGbWdaL80tLVmCeVrUB2Atiw7WINryftkfUCisQWcgvNL
        J1pRccJdMRmXo2Rio08NWdwwNuBHHwxEQYjv8Ma3YjHP8psTCLpBQF1yTINDxqcwVQ8d2kCtqYQwm
        +YqK1jr3V2GF5I8MIoZXQnUqqNQRPS+5Q5UGVc1UhzJJb83mUgPiOWLwsRyXQxS7kVQ/bk7VvHt/b
        vWzFCx/WIwvigA/6VnU7bppEsSzZtDYQ8w8UTjAEL+bw9Ti/gjOpNCpMldyYk5ZurZqk7VVQSMe0G
        K4MliNqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJ9I-000TIM-7o; Wed, 05 May 2021 15:09:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v9 04/96] mm/page_owner: Constify dump_page_owner
Date:   Wed,  5 May 2021 16:04:56 +0100
Message-Id: <20210505150628.111735-5-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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

