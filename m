Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BEF1BDF53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 15:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgD2Nlx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 09:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgD2Ng7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:36:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D08C035494;
        Wed, 29 Apr 2020 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=oT+8lwQ/brzvgB0YZUbOhpyCrOjpQvYYX3M679KauI8=; b=BXbcKwKXX4J6B5Yq6W27whKHfW
        RMek7pSE6UZ0GxybudeKSgbhH+cCqv73jI+nOszKGY+bcB1YX5s0ZujbIdT7mi9j7Pjrk9OxuC5Sb
        huG+X0qvDsNQCTStg4wPMddhLvrNa3hYx3iLc3O6V2F9JIVhKGbXVXLiph/NBGINeCpP8aLaMdOIW
        i88lUe/CgX4vEcAHNsPPgJQVVW2/GgC9bz0T/COBMLSY51Hz63YO6oQXEaN0yScVr2ky0dCyEEy7l
        sbv7AWy0m6Rk4qr2fgjIN88Bmxcc+Y7J4vg2/uIrPMMkYzx686hj+vm+QOhGWjABWNCcRxKZKUghe
        UB4OtL8Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTmtX-0005uS-5w; Wed, 29 Apr 2020 13:36:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/25] mm: Introduce thp_order
Date:   Wed, 29 Apr 2020 06:36:35 -0700
Message-Id: <20200429133657.22632-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200429133657.22632-1-willy@infradead.org>
References: <20200429133657.22632-1-willy@infradead.org>
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
 include/linux/huge_mm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e944f9757349..1f6245091917 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -276,6 +276,11 @@ static inline unsigned long thp_size(struct page *page)
 	return page_size(page);
 }
 
+static inline unsigned int thp_order(struct page *page)
+{
+	return compound_order(page);
+}
+
 struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
 struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
@@ -335,6 +340,7 @@ static inline int hpage_nr_pages(struct page *page)
 }
 
 #define thp_size(x)		PAGE_SIZE
+#define thp_order(x)		0U
 
 static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
-- 
2.26.2

