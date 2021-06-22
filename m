Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC85F3B0527
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhFVMun (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhFVMun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:50:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342C4C06175F;
        Tue, 22 Jun 2021 05:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=W0SIHD7gURwKZexVyJVzLC0q8DhdNENwe62cjUS99wY=; b=a90ROAebXnEpP578E9dgu3syKc
        Bwp3zW/7D3sMtuSHCkZSSAsvZ6ddw1q+K7WL4gGEPm22i/9554ZHsUO5Ev/ixuG+7Yysz3n6Gudxa
        jZhxNv2UuWm2baWFKToSZCKBZYbnMwXDFruz29pEU2dZ/ddScJli8Y5cZQHNJzacGY5mKLod3Y7iz
        lp0Mm0xhV3fnFOnobL2q+usqv89ZISC1HYu7tI8WdyS4R17y/qnxq6kpXMMDeaqzGH2T2S6e+eBzv
        waIuky1Y3kDxK/vYsV0z2zMIFk68VhmWN/kTqFyxezmLSaqV3/TuzPTuKLo2fFo4IK1MBj1HRB8x4
        DpxglwFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfnK-00EITC-Ar; Tue, 22 Jun 2021 12:46:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 35/46] mm/filemap: Add folio_mkwrite_check_truncate()
Date:   Tue, 22 Jun 2021 13:15:40 +0100
Message-Id: <20210622121551.3398730-36-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the folio equivalent of page_mkwrite_check_truncate().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c30db827b65d..14f0c5260234 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1120,6 +1120,34 @@ static inline unsigned long dir_pages(struct inode *inode)
 			       PAGE_SHIFT;
 }
 
+/**
+ * folio_mkwrite_check_truncate - check if folio was truncated
+ * @folio: the folio to check
+ * @inode: the inode to check the folio against
+ *
+ * Return: the number of bytes in the folio up to EOF,
+ * or -EFAULT if the folio was truncated.
+ */
+static inline ssize_t folio_mkwrite_check_truncate(struct folio *folio,
+					      struct inode *inode)
+{
+	loff_t size = i_size_read(inode);
+	pgoff_t index = size >> PAGE_SHIFT;
+	size_t offset = offset_in_folio(folio, size);
+
+	if (!folio->mapping)
+		return -EFAULT;
+
+	/* folio is wholly inside EOF */
+	if (folio_next_index(folio) - 1 < index)
+		return folio_size(folio);
+	/* folio is wholly past EOF */
+	if (folio->index > index || !offset)
+		return -EFAULT;
+	/* folio is partially inside EOF */
+	return offset;
+}
+
 /**
  * page_mkwrite_check_truncate - check if page was truncated
  * @page: the page to check
-- 
2.30.2

