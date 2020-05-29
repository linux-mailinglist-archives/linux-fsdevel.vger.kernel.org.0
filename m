Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E0A1E7309
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407432AbgE2C6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 22:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391617AbgE2C6d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32859C08C5CB;
        Thu, 28 May 2020 19:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=oT+8lwQ/brzvgB0YZUbOhpyCrOjpQvYYX3M679KauI8=; b=qo7Pg4gBGqaEYqgnCvJuRTJOVA
        VRwmaaVw5bvOt4WyDosLRIwecxzg/zS9JQideBZfsJp1xCCkW6/2jIdhxzCsGVa9nsrR8zp4SPDvR
        pKVTh0W63IupSxC4VEgoboU3JgYX8CwDN4J4pAADQvUD0bYvJ1u9Ba0g+d5KGbr6/RpZuaGAt63Lg
        qmyLflOi1sPTjJjlzfy+Sq/YxnnfR/dR4ukzYFE9S9CPqKMbn+fWuv9qiZzrHpuJY244rvrOSaicH
        3FkEFHP64tQgkjU+CeN8tLabzZnW2o8osZK9uy+svPztsGsoC8Q5D2E/Ya7Vk3uNqmmWexZiDSRcl
        O2xHMFtw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE2-0008Q7-PB; Fri, 29 May 2020 02:58:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/39] mm: Introduce thp_order
Date:   Thu, 28 May 2020 19:57:50 -0700
Message-Id: <20200529025824.32296-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
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

