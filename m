Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101192A6F0E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 21:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbgKDUmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 15:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732235AbgKDUmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:42:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D58C0401C1
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2020 12:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FZ0ilWfNk+LpFZcrrKvvNb3YXA8+YdnxL9l6nFjVvBM=; b=QBhGioKn7YTkyVA5GiUrUBp9Z2
        ROw64aIQhY2vCO1ljIts11NuNBX9xp/yYJN6Wn9wtGFyuMepl+bRZQprB52tYKyrl4zj9SrrK9pMv
        aWn8pZ0dEv7Sli9o9maFjiRPe8nqorXEkOHJujnEfbKRevmvV8vgGGlWEtcrWnHtgmRXCCTLA6RlS
        L2PIvLSuNZrTyzMLQd3lJKH1LJi1oO1PZTVorBaVnH/CWTgXg4QKD/Asvu4x0DLyqgdrNdl2RdHsp
        WDGJXFR5dYrWVODdxD5N0Pa21oAuoWkNSFbKa6dLANqxnIRfMAW+jMhmf4zWYUWaE7Z4KL1f01+sM
        sDUxLsOw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaPbu-0006Em-Bn; Wed, 04 Nov 2020 20:42:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v2 16/18] mm/filemap: Don't relock the page after calling readpage
Date:   Wed,  4 Nov 2020 20:42:17 +0000
Message-Id: <20201104204219.23810-17-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201104204219.23810-1-willy@infradead.org>
References: <20201104204219.23810-1-willy@infradead.org>
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
index 22716f4bc977..721dcb580657 100644
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

