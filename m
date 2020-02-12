Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2FAE15A006
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgBLET6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:19:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbgBLESr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5Ar0Jeyv020FR8vajw8QCoSu+6yNwintSCRCindI1ZQ=; b=r8IAdQpEyytTz+UkRifmhnp5oX
        tug+Zi6+43HDkgNWNMhAa6OxOVd1gvh5gww7IiRtJBPzgMbvLgd4eyZtWFBYBKhBWDBKmzf9sKi6t
        2I9goiE3TQteNTlAxrA50cRHD4Dyj1NxT6zZxIc3j4q1cn4+JYscrIoBIFKc5iRshjfoKQLa441Ox
        xYxbbKWzdqFhZXpx8MbdbSRVRBHohpv2+cBC5IcdVnOeJJGWWpjF4qTtq/+1LJpHlyuqYxHdoA4JL
        4a+qp70EIhma0kqSu9bFWN7Vt/okHXBWf9mim6hn+OffxYV+Gb8S/Zv2Vh5S1N+x+hgBjCDvvh+RP
        nnc2wqAg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU6-0006na-Ty; Wed, 12 Feb 2020 04:18:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/25] fs: Make page_mkwrite_check_truncate thp-aware
Date:   Tue, 11 Feb 2020 20:18:31 -0800
Message-Id: <20200212041845.25879-12-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

If the page is compound, check the appropriate indices and return the
appropriate sizes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index aa925295347c..2ec33aabdbf6 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -732,17 +732,18 @@ static inline int page_mkwrite_check_truncate(struct page *page,
 					      struct inode *inode)
 {
 	loff_t size = i_size_read(inode);
-	pgoff_t index = size >> PAGE_SHIFT;
-	int offset = offset_in_page(size);
+	pgoff_t first_index = size >> PAGE_SHIFT;
+	pgoff_t last_index = first_index + hpage_nr_pages(page) - 1;
+	unsigned long offset = offset_in_this_page(page, size);
 
 	if (page->mapping != inode->i_mapping)
 		return -EFAULT;
 
 	/* page is wholly inside EOF */
-	if (page->index < index)
-		return PAGE_SIZE;
+	if (page->index < first_index)
+		return thp_size(page);
 	/* page is wholly past EOF */
-	if (page->index > index || !offset)
+	if (page->index > last_index || !offset)
 		return -EFAULT;
 	/* page is partially inside EOF */
 	return offset;
-- 
2.25.0

