Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF1246CC69
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244259AbhLHE1h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240080AbhLHE0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F999C061D72
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zEgXkSFSyMhCDJOHlKNghSVrMcqn165U8NTQAl+dWqc=; b=bz12BuBcZTfHqa5dTwh8rOHjDm
        vc7TDqj5res0EDmYcwsR9xgH2Ney/EsiNS2mJY3zrc/MIkPBWDWvOZaFd0Rz8ra2P2GEEX6WcoJBb
        c0qtkWiokhfGoVJWW35NXYaUOD/OXEThVuW/fWJQSwHiYJ2K309g89G7iWK6n0fz6CoV5gCLOy4mR
        aC3faxLeAfmbx3ckFxm06CBguVnkFlg7C8xCmUqq5dj94ohonL9SrLOfExGnF2d4DTqW5NJA+GFu1
        Dxnuo71keuwoJsYfZa/54mxTnVykZI6En91fvb5Jt/Il2WQ46O11qs4KZ0+sETe8Bptnf0f/DUetz
        f9yr+Cdw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU3-0084YR-S5; Wed, 08 Dec 2021 04:23:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 20/48] filemap: Convert filemap_range_uptodate to folios
Date:   Wed,  8 Dec 2021 04:22:28 +0000
Message-Id: <20211208042256.1923824-21-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only caller was already passing a head page, so this simply avoids
a call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b044afef78ef..c4f887c277d0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2395,29 +2395,29 @@ static int filemap_read_folio(struct file *file, struct address_space *mapping,
 }
 
 static bool filemap_range_uptodate(struct address_space *mapping,
-		loff_t pos, struct iov_iter *iter, struct page *page)
+		loff_t pos, struct iov_iter *iter, struct folio *folio)
 {
 	int count;
 
-	if (PageUptodate(page))
+	if (folio_test_uptodate(folio))
 		return true;
 	/* pipes can't handle partially uptodate pages */
 	if (iov_iter_is_pipe(iter))
 		return false;
 	if (!mapping->a_ops->is_partially_uptodate)
 		return false;
-	if (mapping->host->i_blkbits >= (PAGE_SHIFT + thp_order(page)))
+	if (mapping->host->i_blkbits >= folio_shift(folio))
 		return false;
 
 	count = iter->count;
-	if (page_offset(page) > pos) {
-		count -= page_offset(page) - pos;
+	if (folio_pos(folio) > pos) {
+		count -= folio_pos(folio) - pos;
 		pos = 0;
 	} else {
-		pos -= page_offset(page);
+		pos -= folio_pos(folio);
 	}
 
-	return mapping->a_ops->is_partially_uptodate(page, pos, count);
+	return mapping->a_ops->is_partially_uptodate(&folio->page, pos, count);
 }
 
 static int filemap_update_page(struct kiocb *iocb,
@@ -2457,7 +2457,7 @@ static int filemap_update_page(struct kiocb *iocb,
 		goto unlock;
 
 	error = 0;
-	if (filemap_range_uptodate(mapping, iocb->ki_pos, iter, &folio->page))
+	if (filemap_range_uptodate(mapping, iocb->ki_pos, iter, folio))
 		goto unlock;
 
 	error = -EAGAIN;
-- 
2.33.0

