Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6ACF373E1E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhEEPKK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhEEPKI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:10:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED878C061574;
        Wed,  5 May 2021 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=46uKbRZFXcZtWinMwdAPkEZSqlzYBs3FzrcvKBHNtps=; b=WkQ+MIlpLVHqw5FBmOpgrqihqA
        RWmzd8U+aZqDq8a7A3iYTbfJAva413xu3o41LyXpNR5AkoFvvBINXEprZyPB+I9PsOyfCLDLl4JAz
        qt06rqbSdt6uqwls3aZJ31Wd0L5zXG8zlxTy8rwRsg1k+BVWa+8m5qi+tP+paqQ5orUciOCiRaxPT
        vIR/0PrRoYyGT+PypBG3OLncxbSKbSytThVO/K1xR7FgY7++NPvt7Fw51H24VFaaQ3uD7FKv9/REt
        DCwO4DGXsv95dYst9276Ft6UUza5+eahbWqIIdN/mAinFyhB/XOn3MTFPiEC6LkpR3eDcLhHSKiFh
        fVmClLfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJ7C-000T7S-Gh; Wed, 05 May 2021 15:07:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v9 02/96] mm: Make __dump_page static
Date:   Wed,  5 May 2021 16:04:54 +0100
Message-Id: <20210505150628.111735-3-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only caller of __dump_page() now opencodes dump_page(), so
remove it as an externally visible symbol.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/mmdebug.h | 3 +--
 mm/debug.c              | 2 +-
 mm/page_alloc.c         | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index 5d0767cb424a..1935d4c72d10 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -9,8 +9,7 @@ struct page;
 struct vm_area_struct;
 struct mm_struct;
 
-extern void dump_page(struct page *page, const char *reason);
-extern void __dump_page(struct page *page, const char *reason);
+void dump_page(struct page *page, const char *reason);
 void dump_vma(const struct vm_area_struct *vma);
 void dump_mm(const struct mm_struct *mm);
 
diff --git a/mm/debug.c b/mm/debug.c
index 0bdda8407f71..84cdcd0f7bd3 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -42,7 +42,7 @@ const struct trace_print_flags vmaflag_names[] = {
 	{0, NULL}
 };
 
-void __dump_page(struct page *page, const char *reason)
+static void __dump_page(struct page *page, const char *reason)
 {
 	struct page *head = compound_head(page);
 	struct address_space *mapping;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a2fe714aed93..f23702e7c564 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -658,8 +658,7 @@ static void bad_page(struct page *page, const char *reason)
 
 	pr_alert("BUG: Bad page state in process %s  pfn:%05lx\n",
 		current->comm, page_to_pfn(page));
-	__dump_page(page, reason);
-	dump_page_owner(page);
+	dump_page(page, reason);
 
 	print_modules();
 	dump_stack();
-- 
2.30.2

