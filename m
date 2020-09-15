Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4FE26B0E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 00:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgIOWVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 18:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbgIOQ1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:27:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85891C061225
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 09:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=zQTxSs573VULBWPuCxmoflXzQjwes3gZPaQR8Axdd/Y=; b=fA+eH3axpy6W3V36avhivtwyD6
        La3OeMqwHH3U073uSamxw0fELO4rh+cyxmonr4oPd6UqpDMRAs8cr0s182gB0ZCz4uk7kNmestUMQ
        jawWgZekvbNzsBNIKAb+usKs0s158drz+lrGeS+hlQJRjFM7NqpyuQgyfjU2Vr7yBq8LQtDM6aFBY
        Oe8JjVIZweHqxxbgPeNBYtMyC9rYgUi2BY2M+j7+JbbgrdxZa8PCdEx+5/B+hlFclsFQo6EMzWrmc
        6y7aF4oVVt1AoT7/zxC1WFc43X8m1Bne6K6LtgrLLzy/4llwRKqPVvqCEnxaHc/QePELkzwGrXWD/
        ZshDg3YA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIDRQ-00047Q-UZ; Tue, 15 Sep 2020 16:04:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] fs: Make page_mkwrite_check_truncate thp-aware
Date:   Tue, 15 Sep 2020 17:04:23 +0100
Message-Id: <20200915160423.15785-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
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
index 2b637960be3a..655ecee666e6 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -982,22 +982,22 @@ static inline unsigned long dir_pages(struct inode *inode)
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

