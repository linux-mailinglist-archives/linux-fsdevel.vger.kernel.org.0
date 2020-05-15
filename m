Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441991D4EDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgEONRn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgEONRD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:17:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE092C05BD1B;
        Fri, 15 May 2020 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MKRr7ww84nPVgNZDl/LbIY5Kct5MfTlH0fl1kdElxWI=; b=kiAbDPTewmgI3eISPMqX72XGNu
        yzCMKUQ+gWQse6OYoJ/inqZDWB4YjDAvvsDgsA69+ZBDJa/0NfS/F2RIXWl/C5LmYBBYF1xtJ8G3J
        nXNkmnt9T6sQUCO9BQS1MeTNGuZmWF71da1I8CLu5FY/3fBm35aO5aMu4a+wNEdDKZmb/myAzCJ71
        Y2FtehLRyQjb/ENPUt7AOVHxzULSFW8whEZm3fK4ckkmMesrK8tEDZWCGa/Lyz7l7a3VWyokbbVvG
        vb9ddS9t/jI/cTX7fqDnOQ4JZUW2QOtA6/NR3eH0rhzM/qMBZWUp5npwPS1kpmHgAYuEBSbKmdhD3
        SZv88Kuw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaD0-0005jq-5j; Fri, 15 May 2020 13:17:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 25/36] mm: Fix total_mapcount assumption of page size
Date:   Fri, 15 May 2020 06:16:45 -0700
Message-Id: <20200515131656.12890-26-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
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

