Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301D02A146E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 10:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgJaJIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 05:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgJaJIv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:08:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38177C0613D5
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 02:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UxcF/Ax2nIsVuoOm9+YumDdpvKlA4H0xkbAmouFAhOA=; b=aHmhXJQyVf83IvaSThL0uw53Xa
        UmNpYdK6al5Ok6nYbchIvi6srQB0Z+FrFJcPIOQcP/CnIaoZQkUnMe9p2+iKY8w35hngJVxxp0vxu
        7riidozLH7iTOKdPbsdO2AecTS3dITLRPBXXh53R84ejFPEeyyk/4/dsFEfQtrZpyp49bOliRN/Bl
        0pk5FOCFlp+gBb1stKHECalKwzfZHr9AQlMizKl1S9YW/BUJnf29vPyuafFEQN3z3WGWcSU7Hs0SQ
        CogmEjYvCe/Qd/TsBFrBrSl+0ZjwUWm8d4yREDfWzAwf+E547rd+XjAp0rL6Ur6NkYue4QS44pxCw
        xXm4HvMw==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYmsR-0007Lg-O6; Sat, 31 Oct 2020 09:08:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/13] mm: lift the nowait checks into generic_file_buffered_read_pagenotuptodate
Date:   Sat, 31 Oct 2020 09:59:54 +0100
Message-Id: <20201031090004.452516-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031090004.452516-1-hch@lst.de>
References: <20201031090004.452516-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the checks for IOCB_NOWAIT and IOCB_WAITQ from the only caller into
generic_file_buffered_read_pagenotuptodate, which simplifies the error
unwinding.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c717cfe35cc72a..bae5b905aa7bdc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2219,19 +2219,22 @@ static int filemap_readpage(struct kiocb *iocb, struct page *page)
 
 static int generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
 		struct iov_iter *iter, struct page *page, loff_t pos,
-		loff_t count)
+		loff_t count, bool first)
 {
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
-	int error;
+	int error = -EAGAIN;
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		goto put_page;
 
 	/*
-	 * See comment in do_read_cache_page on why
-	 * wait_on_page_locked is used to avoid unnecessarily
-	 * serialisations and why it's safe.
+	 * See comment in do_read_cache_page on why wait_on_page_locked is used
+	 * to avoid unnecessarily serialisations and why it's safe.
 	 */
 	if (iocb->ki_flags & IOCB_WAITQ) {
-		error = wait_on_page_locked_async(page,
-						iocb->ki_waitq);
+		if (!first)
+			goto put_page;
+		error = wait_on_page_locked_async(page, iocb->ki_waitq);
 	} else {
 		error = wait_on_page_locked_killable(page);
 	}
@@ -2376,17 +2379,8 @@ static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
 		}
 
 		if (!PageUptodate(page)) {
-			if ((iocb->ki_flags & IOCB_NOWAIT) ||
-			    ((iocb->ki_flags & IOCB_WAITQ) && i)) {
-				for (j = i; j < nr_got; j++)
-					put_page(pages[j]);
-				nr_got = i;
-				err = -EAGAIN;
-				break;
-			}
-
 			err = generic_file_buffered_read_pagenotuptodate(iocb,
-					iter, page, pg_pos, pg_count);
+					iter, page, pg_pos, pg_count, i == 0);
 			if (err) {
 				if (err == AOP_TRUNCATED_PAGE)
 					err = 0;
-- 
2.28.0

