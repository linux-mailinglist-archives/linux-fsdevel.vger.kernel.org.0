Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1294128DD7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 11:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbgJNJYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 05:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbgJNJUB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F40C0F26E9;
        Tue, 13 Oct 2020 20:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Fzh51vQNpYK9qDtm8DdSGaGA15CKG5lqyy79LzIykwE=; b=KjYOvQja/Iwuct+ojBrauVcVFx
        AxDAnkywo8nFPa+UzyHzrFSK8cpK50zKIJo5mc2Lkn4uXOfdssASd7f2vK5QZ2A2Em9jS6AH0C5FC
        q4eA7p84qUjFnY6ez4a9CO6Ao3Obj7lPz31pHvQxpsSXd38W2AuQW6RysUkD1xOLviU4QgPO/v0vy
        QVyWPtDCp2/Zp9sWQ9r7gUosW/VBQnfn4kpninNnAGchfyQPqgy1H5sGp/ZGoBvExla98nY1tCq8U
        AJjTXeo+/HXc9pH26lwtrVUh2cB7McLvU5g8jdj3ciXceDJrtncqAn8Jbh1STKhZta/UmTXamuMlL
        Uwi7ZsHA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSX55-0005i8-Lw; Wed, 14 Oct 2020 03:03:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 02/14] fs: Make page_mkwrite_check_truncate thp-aware
Date:   Wed, 14 Oct 2020 04:03:45 +0100
Message-Id: <20201014030357.21898-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201014030357.21898-1-willy@infradead.org>
References: <20201014030357.21898-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 7dc6bf713d27..5083a0efafa8 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -983,22 +983,22 @@ static inline unsigned long dir_pages(struct inode *inode)
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

