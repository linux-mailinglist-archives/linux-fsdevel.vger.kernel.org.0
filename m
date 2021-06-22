Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A7E3B0365
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 13:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhFVL5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 07:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhFVL5r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:57:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8B5C061574;
        Tue, 22 Jun 2021 04:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4SCmFvTMz8WbZWeYFg3RyglQ4RfNbDDyDvk/e/7SgLw=; b=XZV1Z48ASOEziv5nMwSHUoIRXe
        ROMS05B8jhm1xw8QaFlbyrIGFWOEeD43gBYroM9HoCJpS7s+rDfIJzmYkG3t497P54C1ohgVde2qx
        hzWs8lKz0F+ZkJtUlmZEwJBCkPTaIYB8aRiGrwRTadECnfHcLg4f6g5xInPaBDVy+21rGtZe5uFOj
        WX4FVmnC685Qbsi/OB/2iDRKEYaFR3PUzRnIK9gegMryHScbOqAop4XueH5P9joWyGWttCaY+XYEG
        rQnOiyryQVNCZxM/PeyWQZNbRFO3kMZKwCjt7h6tgEC617cznBs/gg6DfA1dNYb9Hr3VAg5jQTPht
        92m5v9LQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvey9-00EEL2-KA; Tue, 22 Jun 2021 11:53:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v12 15/33] mm/filemap: Add folio_pos() and folio_file_pos()
Date:   Tue, 22 Jun 2021 12:41:00 +0100
Message-Id: <20210622114118.3388190-16-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622114118.3388190-1-willy@infradead.org>
References: <20210622114118.3388190-1-willy@infradead.org>
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
index 4b3ce5f76a7b..d073589b7be2 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -561,6 +561,27 @@ static inline loff_t page_file_offset(struct page *page)
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

