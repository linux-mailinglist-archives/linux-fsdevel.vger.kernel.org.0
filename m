Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AFB3CADFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 22:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhGOUeq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 16:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbhGOUeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:34:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCFAC061762
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 13:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Y5UinLMttKqw/QQSFxAT646FpHEwMgiRMjMa0npizhw=; b=LY08HvZb1KdMfnKkEHmmRuOxfO
        GrLaQK7gJoqeX6SGaDFpYBnkIgBgeDrMTufPukFJbdIz8YhGKMuMdLLzvvWqLg55dJFet11wvGZ63
        2JFOZjBn2a0XoRsdkNQ0tt7tCU32oYPSbHanmrMygve57dTD1KC8SYOXO11zztGf6bpmnibyB2Vg1
        LzIFcxCM6etRinsZEh8NIwf0oAZjEuKgwubFSOrje0DoGblLXapjYw+Vz0JvQaZ1R6nkPfaCSSTmw
        9jl1jLgyb43cmgHFTKvWmhAFKjP2g/lOdXRoLG28pVAvfGNpks1HANlBG8wBBM6sOpg8k6WpDWVDK
        P1vIVVKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m47yq-003pwV-Ht; Thu, 15 Jul 2021 20:29:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v14 28/39] mm/filemap: Add folio_mkwrite_check_truncate()
Date:   Thu, 15 Jul 2021 21:00:19 +0100
Message-Id: <20210715200030.899216-29-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715200030.899216-1-willy@infradead.org>
References: <20210715200030.899216-1-willy@infradead.org>
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
index 412db88b8d0c..18c06c3e42c3 100644
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

