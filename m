Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F5E1E7326
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391710AbgE2DAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407317AbgE2C6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079F4C008635;
        Thu, 28 May 2020 19:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MKRr7ww84nPVgNZDl/LbIY5Kct5MfTlH0fl1kdElxWI=; b=isc6VxuAROW6QPBdcZWtCOBdXK
        Dce35Uix6ld8hXKaOLvM+/NheumIXF3rstHLTirQ+KxHFYVB1mjF65YT2Nu7IkJAhRA/LpICuXy/0
        FangQ7Oz4W/i5RLkasSKaW3CzH3btIF6qcTGO82dj9tfJXo0Dbs1nh8P8mLPttPD/QTpNuBMBVG2P
        Alf1Enktwl0R+YuY3+mN/G1mEpoJagSdRJWWhG3p+sXvhB9kSgarpl7QKSEYtuyYS8WvKAPtQindp
        4kIYXGliEJRd46t8ETBL96Ff9/RvWDsQfZFCXkWP3F6LfqYiNl7V7jlkz9ng/31/6Tjc9vKOxSq5W
        LMUk8JGQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008Sb-IQ; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 26/39] mm: Fix total_mapcount assumption of page size
Date:   Thu, 28 May 2020 19:58:11 -0700
Message-Id: <20200529025824.32296-27-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill@shutemov.name>

File THPs may now be of arbitrary order.

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/huge_memory.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7a5e2b470bc7..15a86b06befc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2668,7 +2668,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 int total_mapcount(struct page *page)
 {
-	int i, compound, ret;
+	int i, compound, nr, ret;
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
@@ -2676,16 +2676,17 @@ int total_mapcount(struct page *page)
 		return atomic_read(&page->_mapcount) + 1;
 
 	compound = compound_mapcount(page);
+	nr = compound_nr(page);
 	if (PageHuge(page))
 		return compound;
 	ret = compound;
-	for (i = 0; i < HPAGE_PMD_NR; i++)
+	for (i = 0; i < nr; i++)
 		ret += atomic_read(&page[i]._mapcount) + 1;
 	/* File pages has compound_mapcount included in _mapcount */
 	if (!PageAnon(page))
-		return ret - compound * HPAGE_PMD_NR;
+		return ret - compound * nr;
 	if (PageDoubleMap(page))
-		ret -= HPAGE_PMD_NR;
+		ret -= nr;
 	return ret;
 }
 
-- 
2.26.2

