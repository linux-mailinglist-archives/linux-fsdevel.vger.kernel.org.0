Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2172A9630
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 13:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgKFMap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 07:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgKFMao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:30:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3F3C0613D2
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2020 04:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kkDY/A+zQxc2i95QfvhU+XAHKtbfTy4uXu8lLNerbsw=; b=wDr7t34wIJm+GPx9QugRfOlaVv
        65UOdzBqP/NbNfJsusEDba3Z6yAvZJD9jiHtHAwu+F9+Kfk8NhxMYlIV3Vongavmd3KbaiLdtlIGM
        0CRoZFp9UeM6UQpDaLYqjQFxDWUQCNJdMUxDA4Qu0u+ymSMe8WSaQndx2vKVOxz+RO5Vl7zynUsE3
        aiwakoI2jXgS0qYYT9GgFvlFiRMK88Ectkq8+rm/eqNCcSWIfKYS0Q7NQFCyATKHPpR6DueSVPE4D
        sQnryvoNQe+ag081u66tV7gXmP5JvX+kAmyb3x3nJ/UTo/+zqgTaLWuRmmSNobmUiPVede3UN1pMp
        kzUFX26w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb0t8-0007Ql-Fn; Fri, 06 Nov 2020 12:30:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 3/4] pagevec: Add dynamically allocated pagevecs
Date:   Fri,  6 Nov 2020 12:30:39 +0000
Message-Id: <20201106123040.28451-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201106123040.28451-1-willy@infradead.org>
References: <20201106080815.GC31585@lst.de>
 <20201106123040.28451-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add pagevec_alloc() and pagevec_free() to allow for pagevecs up to 255
entries in size.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagevec.h |  7 +++++++
 mm/swap.c               | 28 ++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 4dc45392d776..4d5a48d7a372 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -36,6 +36,13 @@ struct pagevec {
 
 void __pagevec_release(struct pagevec *pvec);
 void __pagevec_lru_add(struct pagevec *pvec);
+struct pagevec *pagevec_alloc(unsigned long sz, gfp_t gfp);
+
+static inline void pagevec_free(struct pagevec *pvec)
+{
+	kfree(pvec);
+}
+
 void pagevec_remove_exceptionals(struct pagevec *pvec);
 
 unsigned pagevec_lookup_range_tag(struct pagevec *pvec,
diff --git a/mm/swap.c b/mm/swap.c
index 1e6f50b312ea..3f856a272cb2 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -988,6 +988,34 @@ void __pagevec_release(struct pagevec *pvec)
 }
 EXPORT_SYMBOL(__pagevec_release);
 
+/**
+ * pagevec_alloc - Allocate a pagevec.
+ * @sz: Number of pages wanted.
+ * @gfp: Memory allocation flags.
+ *
+ * Allocates a new pagevec.  The @sz parameter is advisory; this function
+ * may allocate a pagevec that can contain fewer pages than requested.  If
+ * the caller cares how many were allocated, it can check pagevec_size(),
+ * but most callers will simply use as many as were allocated.
+ *
+ * Return: A new pagevec, or NULL if memory allocation failed.
+ */
+struct pagevec *pagevec_alloc(unsigned long sz, gfp_t gfp)
+{
+	struct pagevec *pvec;
+
+	if (sz > 255)
+		sz = 255;
+	pvec = kmalloc_array(sz + 1, sizeof(void *), gfp);
+	if (!pvec)
+		return NULL;
+	pvec->nr = 0;
+	pvec->sz = sz;
+
+	return pvec;
+}
+EXPORT_SYMBOL(pagevec_alloc);
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /* used by __split_huge_page_refcount() */
 void lru_add_page_tail(struct page *page, struct page *page_tail,
-- 
2.28.0

