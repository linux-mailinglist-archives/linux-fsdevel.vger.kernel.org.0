Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62DCC159FE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBLESr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:18:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgBLESr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=i7vboR3/DJp/zECAeL6j4GiEm3ZUJFUzH7UtZQ9ZEF0=; b=FAdp2tXxaIowBuCaDAdUtlgPMI
        REH220rdRzBHCOYiuA1BN9W47EQ538R6k5uZEtBF5gMgY1fSqKoONpkywoiMJYaTBVacuHgS1XX+5
        /ypXgTWDk74QCFtWDsO33RDqXvZqkbaQIv1735c50gFF7JWhNnPtRp18/lI1u3ogH9s0cZ2nclgDr
        nXd/qmh9tgn5N2nr2dZndgBL0oz0wuJZVqkOggxHGrl/I0AJqJ+VoKG5i2qF8m4FOVYnsvambdbMt
        VuFwGES8IyvxbUvH3bpT4T7NR4wNGX10JWVDUqKfgiN2Sh3rQaeZhjpZndaJGkIXb3P9rpzojlF1d
        Iz4gnKbg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU6-0006n7-Q5; Wed, 12 Feb 2020 04:18:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/25] mm: Introduce thp_order
Date:   Tue, 11 Feb 2020 20:18:28 -0800
Message-Id: <20200212041845.25879-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Like compound_order() except 0 when THP is disabled.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/huge_mm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 3680ae2d9019..3de788ee25bd 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -233,6 +233,7 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 
 #define hpage_nr_pages(page)	(long)compound_nr(page)
 #define thp_size(page)		page_size(page)
+#define thp_order(page)		compound_order(page)
 
 struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
@@ -288,6 +289,7 @@ static inline struct list_head *page_deferred_list(struct page *page)
 
 #define hpage_nr_pages(x) 1L
 #define thp_size(x)		PAGE_SIZE
+#define thp_order(x)		0U
 
 static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
-- 
2.25.0

