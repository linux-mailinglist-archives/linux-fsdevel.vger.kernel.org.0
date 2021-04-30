Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2863E370041
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 20:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhD3SMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 14:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhD3SMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:12:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5873FC06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 11:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bbfLrrxrIOJ6efe5uzmRDhuhNNZGQcaXvsHalFUyJQk=; b=GZDfjtBpG9btdCGeZEyVJnLJTd
        oZZYkyDBOArz1vzw/rsKf2z+QyrtL7aAOGBQe/cMsSBealIyZp07CeQtxG5tiRO+AAz3m5DzfcSnf
        Y7jc2ARTkm1ML67wKvfhSTDR9L4XZKUYm4DwQXjw+eaEvTxz61AsO0jhdjuJeLXZfBclYcRpZfMn7
        SQyyvIQBYSEvjSJ4HPQpaC3sXjVcvzeu9eUUHgFTCh7JsybZGGYIOWDFWOnxMiDKkN6smDrtVJqpB
        0Q/+J/CugAhjtdrTQXbr9ovJa1pnU6wPH7k1MGQ0+O/Ui6CC/RYzEks4jE9x8lo36Oh3W00oPJU6U
        f8fE8j9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcXaW-00BMTh-OF; Fri, 30 Apr 2021 18:10:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zi Yan <ziy@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 04/31] mm/debug: Add VM_BUG_ON_FOLIO and VM_WARN_ON_ONCE_FOLIO
Date:   Fri, 30 Apr 2021 19:07:13 +0100
Message-Id: <20210430180740.2707166-5-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430180740.2707166-1-willy@infradead.org>
References: <20210430180740.2707166-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are the folio equivalents of VM_BUG_ON_PAGE and VM_WARN_ON_ONCE_PAGE.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
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

