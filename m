Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1738D3C979A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbhGOEoE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhGOEoD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:44:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A34FC06175F;
        Wed, 14 Jul 2021 21:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Y5UinLMttKqw/QQSFxAT646FpHEwMgiRMjMa0npizhw=; b=WFH6dlsELQVVjX+HV0NFGHdH0w
        eGSPPKkomxBY/it3OaWwIJtUH3cn/z61yOH2qmOC9bnKnvtnrdYsI7VaucKXIf0iN3o/fLuMXQqWN
        cXmR7nM2/96m5Ef5p1XljULiwp/SvpQpri892bhQWR8ThSYAz7lsfXONLYqW5wXFkuR69bXPRAMfl
        2P3W7FLuQqA/pGWPvMQFTniqu9us+wmqZ0MMdu6hUTjcgzyl6k9Lrb7aU/AlJqNNf1a2RHSm995yd
        wDUtr9Z8BDkH1rsj1Vd0WdH6ECkWYO+ncm3Qj2MwyWhMwK7BLzFi2GeMsXg2MqnC6n0qVdhGFFuWK
        G0fBBm4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3t9v-002yBw-SA; Thu, 15 Jul 2021 04:40:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 078/138] mm/filemap: Add folio_mkwrite_check_truncate()
Date:   Thu, 15 Jul 2021 04:36:04 +0100
Message-Id: <20210715033704.692967-79-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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

