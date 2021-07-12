Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B120F3C4173
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhGLDO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhGLDO3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:14:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7969C0613DD;
        Sun, 11 Jul 2021 20:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eRg3ak94wgijDr1AzRTG+e7qA9plHYcT37M29iDpI7Y=; b=FtakyrM0xctOhbxJeoLPywcVGE
        Xo7vvLdLzw8oWGIRSa2inGOz4LWqRnvzfAwJ6g+Fs8brJ9yLabQEylpl/Sgs5lY4007s8Z2fvRGSR
        VA+6s0M8nWkf8OgbexZft48yRul6Aff2Xus8003mRV3GcHpxsxygKztIDqMTfW+fKcTcBcwl/TR6V
        OvCkdFRmxJtNEJv1QnRPeveu1I9gF1DGL9nlXkin/9jckxizqKGITLN6GgH37KxZWMZMxp7+xu8+R
        dV1DJPovSbnvEz7giCUFF4GzfJMo8QWkswSVUgCiueMvgWoLTxuwG2HfhGnsvLOUMd/YNTDNJosEJ
        +Phl/+aA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mLA-00GmxN-TQ; Mon, 12 Jul 2021 03:10:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v13 005/137] mm/debug: Add VM_BUG_ON_FOLIO() and VM_WARN_ON_ONCE_FOLIO()
Date:   Mon, 12 Jul 2021 04:04:49 +0100
Message-Id: <20210712030701.4000097-6-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are the folio equivalents of VM_BUG_ON_PAGE and
VM_WARN_ON_ONCE_PAGE.  No change to generated code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 include/linux/mmdebug.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index 1935d4c72d10..d7285f8148a3 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -22,6 +22,13 @@ void dump_mm(const struct mm_struct *mm);
 			BUG();						\
 		}							\
 	} while (0)
+#define VM_BUG_ON_FOLIO(cond, folio)					\
+	do {								\
+		if (unlikely(cond)) {					\
+			dump_page(&folio->page, "VM_BUG_ON_FOLIO(" __stringify(cond)")");\
+			BUG();						\
+		}							\
+	} while (0)
 #define VM_BUG_ON_VMA(cond, vma)					\
 	do {								\
 		if (unlikely(cond)) {					\
@@ -47,6 +54,17 @@ void dump_mm(const struct mm_struct *mm);
 	}								\
 	unlikely(__ret_warn_once);					\
 })
+#define VM_WARN_ON_ONCE_FOLIO(cond, folio)	({			\
+	static bool __section(".data.once") __warned;			\
+	int __ret_warn_once = !!(cond);					\
+									\
+	if (unlikely(__ret_warn_once && !__warned)) {			\
+		dump_page(&folio->page, "VM_WARN_ON_ONCE_FOLIO(" __stringify(cond)")");\
+		__warned = true;					\
+		WARN_ON(1);						\
+	}								\
+	unlikely(__ret_warn_once);					\
+})
 
 #define VM_WARN_ON(cond) (void)WARN_ON(cond)
 #define VM_WARN_ON_ONCE(cond) (void)WARN_ON_ONCE(cond)
@@ -55,11 +73,13 @@ void dump_mm(const struct mm_struct *mm);
 #else
 #define VM_BUG_ON(cond) BUILD_BUG_ON_INVALID(cond)
 #define VM_BUG_ON_PAGE(cond, page) VM_BUG_ON(cond)
+#define VM_BUG_ON_FOLIO(cond, folio) VM_BUG_ON(cond)
 #define VM_BUG_ON_VMA(cond, vma) VM_BUG_ON(cond)
 #define VM_BUG_ON_MM(cond, mm) VM_BUG_ON(cond)
 #define VM_WARN_ON(cond) BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ON_ONCE(cond) BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ON_ONCE_PAGE(cond, page)  BUILD_BUG_ON_INVALID(cond)
+#define VM_WARN_ON_ONCE_FOLIO(cond, folio)  BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #endif
-- 
2.30.2

