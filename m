Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410263C96A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 05:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbhGODwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 23:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhGODwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:52:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0304EC06175F;
        Wed, 14 Jul 2021 20:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jhieiK0e9kwbSC0V6q3aiSMkZCoboL+CZsQ228vwdU4=; b=LxZuI/QR9IuYa+LwfxHpkY4YcQ
        widkRsmj9NmBwuwF6rFJIR3GxkmlCzXeREh/EQhw0TStgk2RLKYSvl8/957+HRkrKzm6f1Uwz4DLO
        OQ4DiLwKuhTx3+4gq6vKHssVbm0yQRlflgZQXaH7wuJU2oqc37I9nWk6cZ+T67anJO6YFjfF1S2zY
        hjeykIoDsbGJMgrbRUWIsNbd3R8+2DKpoHnX9X/+d0fgTASrAbxlxj/4sOO8PgqczVGZZP6SUUZhq
        p8SJfmpQp8B6HAKDfrq9Rg+PAW/imeo6i8PsWWTilQC4MIj1JXNT7JWakD0+DVsofQZjhajOf4SLA
        PcK618FQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sLi-002uvu-5t; Thu, 15 Jul 2021 03:48:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v14 015/138] mm/filemap: Add folio_pos() and folio_file_pos()
Date:   Thu, 15 Jul 2021 04:35:01 +0100
Message-Id: <20210715033704.692967-16-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are just wrappers around page_offset() and page_file_offset()
respectively.  No change to generated code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 include/linux/pagemap.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bd0e7e91bfd4..aa71fa82d6be 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -562,6 +562,27 @@ static inline loff_t page_file_offset(struct page *page)
 	return ((loff_t)page_index(page)) << PAGE_SHIFT;
 }
 
+/**
+ * folio_pos - Returns the byte position of this folio in its file.
+ * @folio: The folio.
+ */
+static inline loff_t folio_pos(struct folio *folio)
+{
+	return page_offset(&folio->page);
+}
+
+/**
+ * folio_file_pos - Returns the byte position of this folio in its file.
+ * @folio: The folio.
+ *
+ * This differs from folio_pos() for folios which belong to a swap file.
+ * NFS is the only filesystem today which needs to use folio_file_pos().
+ */
+static inline loff_t folio_file_pos(struct folio *folio)
+{
+	return page_file_offset(&folio->page);
+}
+
 extern pgoff_t linear_hugepage_index(struct vm_area_struct *vma,
 				     unsigned long address);
 
-- 
2.30.2

