Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31FC1D4EEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgEONSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgEONRD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:17:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4805EC05BD17;
        Fri, 15 May 2020 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VBHxbXWW3Qhb1/gmMVxWWG1iraMa328VDgjrKr93eAE=; b=rfoG402GkvPk6pL6gkT+wbdy1p
        r21+u08oq7R/r91zmVXwag23Vm/4KjIUp9bq9HbPlKZk5yixaeGm8AjAHgeJnrFsz2v0T6Ql82MwM
        jivodTXcpzQ6NsilPnzPhQUZahunzmwgJelD1eiJAxps3gD891QlE0aOgAvYBKcjqVY2ZadYZCIpD
        x31Yi72/sC60lYnjUIqOuz8eGF36s6VqjoYBZnUvlbgOg5Yfi8CbFAQBuTwBfsIi6NNCc+1Rzwt+Z
        3EIS8pUY/49LN8TcXpyepCjcs8bzsIrKhqs2dx2g2qbZhW0q9ABiMS8lIHzZOiLZJoxCSEF/Ub1Vp
        MlcOBNNw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaD0-0005iV-24; Fri, 15 May 2020 13:17:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 23/36] mm: Allow large pages to be removed from the page cache
Date:   Fri, 15 May 2020 06:16:43 -0700
Message-Id: <20200515131656.12890-24-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
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
index 437484d42b78..9c760dd7208e 100644
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
2.26.2

