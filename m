Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0E2300982
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 18:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbhAVQuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729562AbhAVQOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:14:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2001FC061786;
        Fri, 22 Jan 2021 08:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vPBpsG8Y9bd3KuPs8xt0zB/EQXJ9nDnfU8YkfkH81Kg=; b=H2FzzfYxjwuwUPc3YQp7VL8e5T
        pyC8W5VRSTd72GjAqFTEjjUdHAdFi00S52ZyuRwO7qfUcAe7WtrRtquIavHruu+fLiA2+6YFk5jWv
        xBCa7jzD4a9BIfbpAWnWPmqBRZc9rn5KaupGbI1n6rchCv/B+9vRly/QYXIzlQXwbWJEdzH+pBDHA
        0F2lgVnsZN+Dbj5dmpZDeqEcLvb7gRvqxadaZ3V4FWs62RxbsCm7Fdvyow0UJkzj9398ZuwgrNwo7
        FNehBlWbeApF5LOHDSnYW0gatvcqi0GF4tCcJr1nzAcHho3Jq0jyq7LyDQsfwKYExDNcZWM0uvcPh
        tLNnbf+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2z35-000whC-LO; Fri, 22 Jan 2021 16:12:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 16/18] mm/filemap: Don't relock the page after calling readpage
Date:   Fri, 22 Jan 2021 16:01:38 +0000
Message-Id: <20210122160140.223228-17-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122160140.223228-1-willy@infradead.org>
References: <20210122160140.223228-1-willy@infradead.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1fba96dab4b8e..542d9c93732c2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2227,23 +2227,16 @@ static int filemap_read_page(struct file *file, struct address_space *mapping,
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
 
 static bool filemap_range_uptodate(struct address_space *mapping,
-- 
2.29.2

