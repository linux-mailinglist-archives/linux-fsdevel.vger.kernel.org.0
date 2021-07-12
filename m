Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3C83C6319
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbhGLTGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbhGLTGC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:06:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01871C0613DD;
        Mon, 12 Jul 2021 12:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/GrnvoldBJPOkfmLpqQw+fmlcz2a4ZH6OMDGrUDg2bI=; b=vYsQLqJYQfV4K2loEGSnah/Rx2
        32Qe/h5mYRJlH1e9LT4HSK1HWCSXxlNdXc1lDlYRqrVWTBN19u2TM3YQzjO3VN8vxvwgy1FUMUNGm
        SI6MSV5P5wismLhkEprbVOecnyk8TVehkFVlnPeRcVG6kTUARaxfRJR8xAa1DEdgDvFbPv5xhORww
        dil+Rfi33dxGDWUQ1/SE4MKJS8iaxnOikkUZhW2H0Z3LIMDEk5LMQ1p47e6AkAvJX32VcLna1BCZ/
        trW76bCEzWzkP7XoE3eC0N0q5mnZY+EdhZPk79GCNAaaArGll+qvIvUZ5u3qAZWhQ20v7PSUZ6DDG
        eNbpUTiw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m31CI-000L6v-2U; Mon, 12 Jul 2021 19:02:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v13 01/32] mm: Convert get_page_unless_zero() to return bool
Date:   Mon, 12 Jul 2021 20:01:33 +0100
Message-Id: <20210712190204.80979-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712190204.80979-1-willy@infradead.org>
References: <20210712190204.80979-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

atomic_add_unless() returns bool, so remove the widening casts to int
in page_ref_add_unless() and get_page_unless_zero().  This causes gcc
to produce slightly larger code in isolate_migratepages_block(), but
it's not clear that it's worse code.  Net +19 bytes of text.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/mm.h       | 2 +-
 include/linux/page_ref.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 57453dba41b9..02851931e958 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -755,7 +755,7 @@ static inline int put_page_testzero(struct page *page)
  * This can be called when MMU is off so it must not access
  * any of the virtual mappings.
  */
-static inline int get_page_unless_zero(struct page *page)
+static inline bool get_page_unless_zero(struct page *page)
 {
 	return page_ref_add_unless(page, 1, 0);
 }
diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 7ad46f45df39..3a799de8ad52 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -161,9 +161,9 @@ static inline int page_ref_dec_return(struct page *page)
 	return ret;
 }
 
-static inline int page_ref_add_unless(struct page *page, int nr, int u)
+static inline bool page_ref_add_unless(struct page *page, int nr, int u)
 {
-	int ret = atomic_add_unless(&page->_refcount, nr, u);
+	bool ret = atomic_add_unless(&page->_refcount, nr, u);
 
 	if (page_ref_tracepoint_active(page_ref_mod_unless))
 		__page_ref_mod_unless(page, nr, ret);
-- 
2.30.2

