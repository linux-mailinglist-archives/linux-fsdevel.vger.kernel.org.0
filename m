Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C601F5CD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbgFJURD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbgFJUNt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB75C08C5CA;
        Wed, 10 Jun 2020 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4figGncYPDs23Of7IYih6m6FXzxa/L1ppRPiwe0GXZ0=; b=PJFR2z3iqH2Nw5qEV5yTriVnR4
        HHwB6hGy6N6yjAOR3migbMhFuAjDYBO6zIYCw/fNrcXicSxzoCBkGdnPHKmUgvpT3T7TDaLRyvaav
        JGyWQdEtV3qbBb8Akw6Oicgk1HRqEMSDKJxUuBiCo2XzUryuxUSF9ai14FYO7HMb5E4/Zviwb/xGA
        S7OwUAUqIjL/lz0EN8hcdX7VP/Url6U4TE9XF7AVlkVigU2+dimH6OoHYtq/2FFpNUe1FupIPkIOg
        2atAbD5fBVz0PhB1Bm/qWf0zS8QyDPlrlJg1vM2oxmuuHtC7d1wQRZUWYh/wEa8J9je9BFvpqk0R4
        ceJa2iyQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76Z-0003Ue-TO; Wed, 10 Jun 2020 20:13:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 17/51] fs: Make page_mkwrite_check_truncate thp-aware
Date:   Wed, 10 Jun 2020 13:13:11 -0700
Message-Id: <20200610201345.13273-18-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

If the page is compound, check the last index in the page and return
the appropriate size.  Change the return type to ssize_t in case we ever
support pages larger than 2GB.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 3ad0c92be649..f47ba9f18f3e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -868,22 +868,22 @@ static inline unsigned long dir_pages(struct inode *inode)
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
2.26.2

