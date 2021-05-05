Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B68C373FDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhEEQcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbhEEQcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:32:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F0EC061574;
        Wed,  5 May 2021 09:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nI9lCM1C11RSMX9mr5wZgr4g67mkfOZVIXRulnGLED0=; b=NVEbDkgSTcGEjcdWw2YB2EKFR4
        sKdm3fflfwJg/yVRja8shrLxdPXgSo6pI5hgfQamAuyQ1uXWxl2ZcUv0M3bnSCtoHIcpRoBomdX98
        JMoKYthWHWyN/IYsog5rj407j1Ko00Z6glZk42QlfeIc8R9H0VTqNBXg1ohpAZKp15jsqgkxYd6of
        F+u/NyKwZAnQ/Gh7cIgFHkordBG2IwMcdzSIGUYkVZ6tVYOy0f6T24T+uHjgz+e0ol9hqBArhRJei
        Q/ZjGq8u5LIiwXBvoxNXPtCJF2q4mEVkl+wAe4uZfJ+JCS+Aex97d2jl2DAKTkVgg0W6C4DnTPFpJ
        Na9mTyZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKOS-000abl-5P; Wed, 05 May 2021 16:29:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 69/96] mm/filemap: Add folio_mkwrite_check_truncate
Date:   Wed,  5 May 2021 16:06:01 +0100
Message-Id: <20210505150628.111735-70-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
index 2f896574aad7..8fd00dc5ebd5 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1195,6 +1195,34 @@ static inline unsigned long dir_pages(struct inode *inode)
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

