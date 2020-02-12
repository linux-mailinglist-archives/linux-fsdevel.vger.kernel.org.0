Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89F0E159FE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgBLESs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:18:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53992 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgBLESr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UfFsjnMZO/Rq4fYsTDy7TAQ1WDn/2/A9cAH2PPVx4Dc=; b=bpV61dLdwafyzPNxp6FbhzqRwJ
        XRn6Pl44OIU/41u7z97pqglIliE/1VqmSbRySYbVFJRuVRft/OXdYdyRLmTwpF2EOAPnFqRL15qO1
        Qa9Rj/fj1zgklqzpMA+8V+9h9dosTebFWSLFNs5UN1x8Ps6gkKlgYQCJLXJJVhU5yx1wk99j4BH3n
        zQQzS+2vNL2Uckl/cCaJ5uig19zh2yCoKyNzbW++uU1cObrtqkEOZ16W4xaiGNzCCXxjUIz3K0+3W
        6fzXvOVRw8o3SuD+lZD9WyLJDwKJ3Bp4KiGInAH4GKrU0eTmxhESHW7zSeyv7QGwzZwssYGybcAAQ
        L4PEpiJQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU7-0006p3-Fh; Wed, 12 Feb 2020 04:18:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/25] mm: Allow large pages to be removed from the page cache
Date:   Tue, 11 Feb 2020 20:18:43 -0800
Message-Id: <20200212041845.25879-24-willy@infradead.org>
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

page_cache_free_page() assumes compound pages are PMD_SIZE; fix
that assumption.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 08b5cd4ce47b..e74a22af7e4e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -248,7 +248,7 @@ static void page_cache_free_page(struct address_space *mapping,
 		freepage(page);
 
 	if (PageTransHuge(page) && !PageHuge(page)) {
-		page_ref_sub(page, HPAGE_PMD_NR);
+		page_ref_sub(page, hpage_nr_pages(page));
 		VM_BUG_ON_PAGE(page_count(page) <= 0, page);
 	} else {
 		put_page(page);
-- 
2.25.0

