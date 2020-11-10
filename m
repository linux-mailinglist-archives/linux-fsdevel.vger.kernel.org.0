Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03912ACBF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 04:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbgKJDhY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 22:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731477AbgKJDhX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:37:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5ADC0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 19:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WSK6X5f51flP4GAO5LBJPf4LSumT0/CAC7oCIohpVfk=; b=F3Y2D/GMhwqRdhTnMn/kbzVqHv
        hrGweohaXVpAkdUlpRwvVEm4Bso5LwYCIdmal8oarc9G6AHHFaO8lWKbJzE9SN8XZuC0SEewg6wKe
        ggR+0D3f+zyg9D4riOkqyv+hixLU5fecKnmJcRJG/bsObI/wZLRr0r1jJT+263IqM7qeA7OgMFnX1
        02203wa518xgJmmIZ1PdumYeRuekF3JHPEq8TXZNaQWXTTYfS7dUqBG2/QZzsn7T1skcVRvgIa70X
        JT4g/PN9W/eeynVFyCoYU3Fnyu4dQ2qfTuDLGgGMiBDnvqb6iZI6/AiLMeb37Ug0GdwedSJsXu8YH
        HctJajnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcKTA-000685-MU; Tue, 10 Nov 2020 03:37:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v3 16/18] mm/filemap: Don't relock the page after calling readpage
Date:   Tue, 10 Nov 2020 03:37:01 +0000
Message-Id: <20201110033703.23261-17-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201110033703.23261-1-willy@infradead.org>
References: <20201110033703.23261-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't need to get the page lock again; we just need to wait for
the I/O to finish, so use wait_on_page_locked_killable() like the
other callers of ->readpage.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/filemap.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9d0cbdd288fe..e39a255200d5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2212,23 +2212,16 @@ static int filemap_read_page(struct file *file, struct address_space *mapping,
 	error = mapping->a_ops->readpage(file, page);
 	if (error)
 		return error;
-	if (PageUptodate(page))
-		return 0;
 
-	error = lock_page_killable(page);
+	error = wait_on_page_locked_killable(page);
 	if (error)
 		return error;
-	if (!PageUptodate(page)) {
-		if (page->mapping == NULL) {
-			/* page truncated */
-			error = AOP_TRUNCATED_PAGE;
-		} else {
-			shrink_readahead_size_eio(&file->f_ra);
-			error = -EIO;
-		}
-	}
-	unlock_page(page);
-	return error;
+	if (PageUptodate(page))
+		return 0;
+	if (!page->mapping)	/* page truncated */
+		return AOP_TRUNCATED_PAGE;
+	shrink_readahead_size_eio(&file->f_ra);
+	return -EIO;
 }
 
 static bool filemap_range_uptodate(struct kiocb *iocb,
-- 
2.28.0

