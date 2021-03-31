Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B563506DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 20:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhCaSxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 14:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbhCaSwb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:52:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAEFC061574;
        Wed, 31 Mar 2021 11:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sZgQF80BKFcXL1KhtXQhmco+ar+gKbSse6TKs0pgmFc=; b=IRtWHpUDVhL3uTEtjJ/oTIvKLD
        TVisxo8gexQZmH/JbZqj2lszyfKrHgULUNnN6ykUckX66rmYwvDmHXTnBevfwVQ/gsC3EuRvF2dJ1
        dylJHM6s5+AtyCBxhrpVRRZrDbSqnFQEkoHhgH1fAtdUifQYzMXNsWvxHoCQF3Oid2KH4tAItKD0l
        ao7W3cmBOWkiQVy4z0hlpvxjaYhHWm3e+/zOxZt5+QtiDcfia6TNYq1u4OOwyOYV9P2DMMl6vS06Q
        B2UIVoJf1wEBZdjB48SDbINkgKD/guwd+tMADoxXN3qA7QhIhYfBe+dZJf9QZxDT621+nyCn9Zji7
        Xro5w1ZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRfwN-004zW2-Bx; Wed, 31 Mar 2021 18:51:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v6 12/27] mm/filemap: Add folio_offset and folio_file_offset
Date:   Wed, 31 Mar 2021 19:47:13 +0100
Message-Id: <20210331184728.1188084-13-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210331184728.1188084-1-willy@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are just wrappers around their page counterpart.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 3aefe6558f7d..b4570422a691 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -634,6 +634,16 @@ static inline loff_t page_file_offset(struct page *page)
 	return ((loff_t)page_index(page)) << PAGE_SHIFT;
 }
 
+static inline loff_t folio_offset(struct folio *folio)
+{
+	return page_offset(&folio->page);
+}
+
+static inline loff_t folio_file_offset(struct folio *folio)
+{
+	return page_file_offset(&folio->page);
+}
+
 extern pgoff_t linear_hugepage_index(struct vm_area_struct *vma,
 				     unsigned long address);
 
-- 
2.30.2

