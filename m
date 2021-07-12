Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A5B3C4243
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbhGLDwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbhGLDwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:52:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5ECC0613DD;
        Sun, 11 Jul 2021 20:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rig9TuSYZ8ISZ2eXwc2N6+sqR9xeb6/pxaFhZmO35Ps=; b=ZPmGJmAPlF369tcnWouschWr4i
        Vi8KJ+LH9ZOZqZEEQRVYGWAPvw+okopJZMnVndVTPz6X+HQhR6iQA2MmYXXKh6AtUghO0k0jI528g
        lT6i5eJdqAmM26OmpXFb96yltOqRGRTr9Vvq8vkMQ/81sePLvw1cOGLJFqZCxVjoo1eNYfOiQYH/F
        mEAc67r0ukOWrdoS5rIv09TXhJ8SxQG844TyD3ND4IStVCYQ23ovXjAOKKgOeA1ycDjRlXV9luTVe
        IkbMuTXthOACs8Xg+AhWsOkxglSTc4v/jpR9EYgJrAggGLYJeTbHCHwf2CoOpw6y61ufW/lXLYJLi
        s3aHsPZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mvi-00Gpgr-KY; Mon, 12 Jul 2021 03:48:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 077/137] mm/filemap: Add folio_mkwrite_check_truncate()
Date:   Mon, 12 Jul 2021 04:06:01 +0100
Message-Id: <20210712030701.4000097-78-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
index 319e2b486c0d..1aee9f711de8 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1121,6 +1121,34 @@ static inline unsigned long dir_pages(struct inode *inode)
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

