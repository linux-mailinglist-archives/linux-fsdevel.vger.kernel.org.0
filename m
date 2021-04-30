Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F07C36FD4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 17:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhD3PFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 11:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhD3PFa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:05:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165D5C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 08:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ANmp9Os/LHR/T8LANBKOkml2dwgYRoABl1lrJ/0d2NQ=; b=CUBUN6oI0fK7XGKP0dLAM1UhYA
        iJF1+2Hem8T8ezJX6Ihu5zuA7mValTrJUAPCUXNWLbKLPSPnnelcDLtX5CAJ/llyX5mVTmPzJOuoq
        DRJc6oynkDxwasrGDllNuhL4NG+tLam6OIIzEqes/85yn1v8E04IJjkviJKthYy1zRnR2Bv4k+bw7
        SpnrXON1V4LvIdaA7V+xbF5Q663ztFhl/UIQ7y3yruf/Tv+ZVYwefW9l7bwPxfp8iA5wlFxP/5I4c
        zhsKTXMR89WIGoHDItM1XVK8sjFZXE0H5v1qy0Hg4POzkDSXLWw5umN/IcYbZi/q8J2chS9ojOFfv
        LoUog4Bg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcUfe-00BBB4-Tv; Fri, 30 Apr 2021 15:03:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH 6/8] mm: Constify get_pfnblock_flags_mask and get_pfnblock_migratetype
Date:   Fri, 30 Apr 2021 15:55:47 +0100
Message-Id: <20210430145549.2662354-7-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430145549.2662354-1-willy@infradead.org>
References: <20210430145549.2662354-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The struct page is not modified by these routines, so it can be marked
const.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/pageblock-flags.h |  2 +-
 mm/page_alloc.c                 | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index fff52ad370c1..973fd731a520 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -54,7 +54,7 @@ extern unsigned int pageblock_order;
 /* Forward declaration */
 struct page;
 
-unsigned long get_pfnblock_flags_mask(struct page *page,
+unsigned long get_pfnblock_flags_mask(const struct page *page,
 				unsigned long pfn,
 				unsigned long mask);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f23702e7c564..5a1e5b624594 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -474,7 +474,7 @@ static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 #endif
 
 /* Return a pointer to the bitmap storing bits affecting a block of pages */
-static inline unsigned long *get_pageblock_bitmap(struct page *page,
+static inline unsigned long *get_pageblock_bitmap(const struct page *page,
 							unsigned long pfn)
 {
 #ifdef CONFIG_SPARSEMEM
@@ -484,7 +484,7 @@ static inline unsigned long *get_pageblock_bitmap(struct page *page,
 #endif /* CONFIG_SPARSEMEM */
 }
 
-static inline int pfn_to_bitidx(struct page *page, unsigned long pfn)
+static inline int pfn_to_bitidx(const struct page *page, unsigned long pfn)
 {
 #ifdef CONFIG_SPARSEMEM
 	pfn &= (PAGES_PER_SECTION-1);
@@ -495,7 +495,7 @@ static inline int pfn_to_bitidx(struct page *page, unsigned long pfn)
 }
 
 static __always_inline
-unsigned long __get_pfnblock_flags_mask(struct page *page,
+unsigned long __get_pfnblock_flags_mask(const struct page *page,
 					unsigned long pfn,
 					unsigned long mask)
 {
@@ -520,13 +520,14 @@ unsigned long __get_pfnblock_flags_mask(struct page *page,
  *
  * Return: pageblock_bits flags
  */
-unsigned long get_pfnblock_flags_mask(struct page *page, unsigned long pfn,
-					unsigned long mask)
+unsigned long get_pfnblock_flags_mask(const struct page *page,
+					unsigned long pfn, unsigned long mask)
 {
 	return __get_pfnblock_flags_mask(page, pfn, mask);
 }
 
-static __always_inline int get_pfnblock_migratetype(struct page *page, unsigned long pfn)
+static __always_inline int get_pfnblock_migratetype(const struct page *page,
+					unsigned long pfn)
 {
 	return __get_pfnblock_flags_mask(page, pfn, MIGRATETYPE_MASK);
 }
-- 
2.30.2

