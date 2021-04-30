Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916AD36FF93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 19:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhD3ReV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 13:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3ReV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 13:34:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125E5C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 10:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2LF9s6ztlfkwUoc9WiMAwPbJOk4SdwzUE/qme9lPWG0=; b=W1IWBQN/mNsK+6wLiy5iIkyXtC
        a3TI7f7zWeTWPEm3YcHpc5cckKYMDLSN9BVszRSM0Ll+vcBHKWfuWBmw1k0/cp+sf3BnLiPode5SZ
        plDGP501cJuXWsA+ORnMJ3ptiz117Z7EVUsZ/p9+/d5hE1gS6T29drZ9Ii6OSqhJTUao3mRJaRVmg
        /Fp9RCOjIdNkYnwPyr4+8pyE8z9GNiQazrimYBbdMOBB8FFeTqLwPpJqGZ5HY9sPBANNI82z7GKWl
        LoTewhcY4cSpugnoYwDK73oNhm+VOmDzJrbFNzjrd8yIrNKFkR92BLVRhSuGEnPr5dXPkWCPF7H+B
        njFEt3Jg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcWzy-00BJp2-K9; Fri, 30 Apr 2021 17:32:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 13/27] mm/filemap: Add folio_offset and folio_file_offset
Date:   Fri, 30 Apr 2021 18:22:21 +0100
Message-Id: <20210430172235.2695303-14-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430172235.2695303-1-willy@infradead.org>
References: <20210430172235.2695303-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are just wrappers around their page counterpart.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/pagemap.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 5301131cc5b3..3d4ca4fd7b96 100644
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

