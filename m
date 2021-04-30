Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAA236FD2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 17:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhD3PBd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 11:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbhD3PBI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:01:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36267C061350
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=46uKbRZFXcZtWinMwdAPkEZSqlzYBs3FzrcvKBHNtps=; b=EOB5qy5DBrXMdfJWsa8UWFiFGM
        Hfqj42uCsZ1vupFU/OT9LzjH7PMJ11d/W06bejDViBT4ovTNSIcHjISD8/34ccOrDAkPHAft/sLgl
        747bNVbdk1x739Wu8W6Wghd3ESUdtqIcw24Pw6RcL56oNkscirjMPyc36xk4Xms6xYCFHTdW+j+i4
        4SjPS0ect8osbS4NKYHFhcxA7V230E3r1n0qT6W9axp4ejDkTLXPEEN3sNN0Kb2TTq6GQQK5MkZtP
        8WUDZEjlfWJAfhBpTMzCQ+Ail8cs/tRm0yC/aq7Vj+vqr5JIN+y+VhPc+itk+T0vCTXBD43ukE3L2
        Nq9YJ1uw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcUZa-00BAf0-BU; Fri, 30 Apr 2021 14:57:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH 2/8] mm: Make __dump_page static
Date:   Fri, 30 Apr 2021 15:55:43 +0100
Message-Id: <20210430145549.2662354-3-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430145549.2662354-1-willy@infradead.org>
References: <20210430145549.2662354-1-willy@infradead.org>
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

