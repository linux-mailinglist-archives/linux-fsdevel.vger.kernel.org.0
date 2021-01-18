Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBCB2FA726
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405592AbhARRLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406442AbhARREE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:04:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38DBC061757;
        Mon, 18 Jan 2021 09:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+jM+Ji5ilcdBl6ok4GHMueETlpEeNTh2fPWleKHuK0I=; b=Q7siTO+kk9YmPISJopwDDjO/p9
        IBLCo461dZLxLXOmbLlhndotjf4rFYGN+SC2vKnnkoXZ1dRveFXlsI1bEaH+2olNlapxkwdGN5h5R
        wj5zLl/eW7HlnLT+z+nPiM3BO4v3F5M5UMn6ewod9rxUfY4tQXyRnPs+58fSGXLiXKM4KyBaRWOFI
        A+I/oSklVRWsLH7jQAXst7lon0j+tiK8EU4L/7SJ9l7pAKfBokXbA+SJ2MAqm9a9DwIpA5nm+z79e
        zUFSP9lerdxp6hRAPIQWcv9Irr4hZAPDbwzhlxYT65QUvbWwDHRFlN35FAru8btGJuXgg3Tv018g6
        q8H8Ea8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1XvI-00D7NI-91; Mon, 18 Jan 2021 17:02:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/27] mm/filemap: Convert lock_page_for_iocb to lock_folio_for_iocb
Date:   Mon, 18 Jan 2021 17:01:38 +0000
Message-Id: <20210118170148.3126186-18-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The callers will eventually all have a folio, but for now do the
conversion at the call sites.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 95015bc57bb7..648f78577ab7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2174,14 +2174,14 @@ static void shrink_readahead_size_eio(struct file_ra_state *ra)
 	ra->ra_pages /= 4;
 }
 
-static int lock_page_for_iocb(struct kiocb *iocb, struct page *page)
+static int lock_folio_for_iocb(struct kiocb *iocb, struct folio *folio)
 {
 	if (iocb->ki_flags & IOCB_WAITQ)
-		return lock_folio_async(page_folio(page), iocb->ki_waitq);
+		return lock_folio_async(folio, iocb->ki_waitq);
 	else if (iocb->ki_flags & IOCB_NOWAIT)
-		return trylock_page(page) ? 0 : -EAGAIN;
+		return trylock_folio(folio) ? 0 : -EAGAIN;
 	else
-		return lock_page_killable(page);
+		return lock_folio_killable(folio);
 }
 
 static struct page *
@@ -2214,7 +2214,7 @@ generic_file_buffered_read_readpage(struct kiocb *iocb,
 	}
 
 	if (!PageUptodate(page)) {
-		error = lock_page_for_iocb(iocb, page);
+		error = lock_folio_for_iocb(iocb, page_folio(page));
 		if (unlikely(error)) {
 			put_page(page);
 			return ERR_PTR(error);
@@ -2287,7 +2287,7 @@ generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
 
 page_not_up_to_date:
 	/* Get exclusive access to the page ... */
-	error = lock_page_for_iocb(iocb, page);
+	error = lock_folio_for_iocb(iocb, page_folio(page));
 	if (unlikely(error)) {
 		put_page(page);
 		return ERR_PTR(error);
-- 
2.29.2

