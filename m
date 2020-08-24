Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07422500E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 17:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgHXPSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 11:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgHXPRN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:17:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC85FC061573;
        Mon, 24 Aug 2020 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GPFgCYmxv4H+cWd8xnvyf0L9mCYFI6Udvua5Tow80pE=; b=ZGQSHZbYFffQRLYPHl3+9lLOEn
        ro8mxCPTSctq7sAjopAJF3cl7hz3/7B5iPaXBF5RrxLqMc3DCDTUljy8j6vPTOXrVftxqvAy1mFlx
        nng+/8uH9xWqZWIU5bZpmF5JPW9UdI4rizhs7YeTdL0xuEsXAB/Y7EeUnyJ932yBalU/UIPRgKE2S
        Jx22Ac6Ep2KtmGawfYtHtk3j4WYZ724agSeNWgh0RzA1ZQUyEsAEXvdjehlVCLftHrD/n4+03mP8y
        ifIj5+ILXK8MrOeMm5Z+vtvKMdq5jShLv+o/22evclmJsSZPoavZEJM0snV8VlXhLJ9wogSzyvytm
        9IlleK4w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAEDW-0004CQ-Cn; Mon, 24 Aug 2020 15:17:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] fs: Make page_mkwrite_check_truncate thp-aware
Date:   Mon, 24 Aug 2020 16:16:50 +0100
Message-Id: <20200824151700.16097-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200824151700.16097-1-willy@infradead.org>
References: <20200824151700.16097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the page is compound, check the last index in the page and return
the appropriate size.  Change the return type to ssize_t in case we ever
support pages larger than 2GB.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 853733286138..50b176b65911 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -876,22 +876,22 @@ static inline unsigned long dir_pages(struct inode *inode)
  * @page: the page to check
  * @inode: the inode to check the page against
  *
- * Returns the number of bytes in the page up to EOF,
+ * Return: The number of bytes in the page up to EOF,
  * or -EFAULT if the page was truncated.
  */
-static inline int page_mkwrite_check_truncate(struct page *page,
+static inline ssize_t page_mkwrite_check_truncate(struct page *page,
 					      struct inode *inode)
 {
 	loff_t size = i_size_read(inode);
 	pgoff_t index = size >> PAGE_SHIFT;
-	int offset = offset_in_page(size);
+	unsigned long offset = offset_in_thp(page, size);
 
 	if (page->mapping != inode->i_mapping)
 		return -EFAULT;
 
 	/* page is wholly inside EOF */
-	if (page->index < index)
-		return PAGE_SIZE;
+	if (page->index + thp_nr_pages(page) - 1 < index)
+		return thp_size(page);
 	/* page is wholly past EOF */
 	if (page->index > index || !offset)
 		return -EFAULT;
-- 
2.28.0

