Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F091E735C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391836AbgE2DEL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391625AbgE2C6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBD7C0A88B4;
        Thu, 28 May 2020 19:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+Gdlnc0udokkhmpgTuYwy/cxPMcGzAo5nlIsHs4S828=; b=azO5bv91BlL2PSAaefYCm2mmLr
        X/mOTyr1rHNC+2UV0xAy2gLqAN2y63TkhOjjSEijow/WP+r8CHKYZABY3rv1CtXJ7xFQDqpXI0rGk
        YzMx/U357PPIEgCk8q5pNJU6dH5RSYjfPKVIGk2sRQvLx61LMHjxDvCcuIYb+WLBXzNGAN/esgkIC
        57latdAMVIrO8pgSYfthHiq1TcUI7i0exv3KcjbkmH3hcAS2aCg2W3MpTC41t0mIaQIkNUEpU7Ulv
        yeWWeiBb5kf3RyALUA62kgdJPMSGfRxucinKMI6eT4uLylIzFSECEdbClkdNrR4PLcgKDWz+RcQva
        LR74BoAg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE2-0008Qc-Ux; Fri, 29 May 2020 02:58:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/39] fs: Make page_mkwrite_check_truncate thp-aware
Date:   Thu, 28 May 2020 19:57:55 -0700
Message-Id: <20200529025824.32296-11-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
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
index 53a914105591..612f6f090d0f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -828,22 +828,22 @@ static inline unsigned long dir_pages(struct inode *inode)
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
+	if (page->index + hpage_nr_pages(page) - 1 < index)
+		return thp_size(page);
 	/* page is wholly past EOF */
 	if (page->index > index || !offset)
 		return -EFAULT;
-- 
2.26.2

