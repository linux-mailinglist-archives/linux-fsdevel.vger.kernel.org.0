Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA7036FD44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 17:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhD3PEt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 11:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhD3PEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:04:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9B4C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 08:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lOmqEPnS7Hw2fLegrIjeF+PaasHglD3GyP6d0HUc9GQ=; b=CsSgrvoY1Chojmg4apEUjTeFyV
        jcSU8yhuHSGNZQB8SlqPojoAg78sGXhlsa6UD2fxyb0rmtQBNeEm2Vg6Uv5DLevvjs7IxBjCMvBgz
        H02+A28vy6QIN9e93lrg1V9yTjJEhsmHsILCQhAIdJksaCYT8WQrklDc4DqMiu2l+XPcyoJe2+Kzu
        /ML1zjlk4MtAzJ8JXCloFc8sOmN45vhp8EGOuiuEjWuOtDd6CmzVcsvyFCJmclW8jHUDs/+i5G+VS
        NCItqz0H7s4Pv87DmYqOWBmBalraS9FflB3gyd2rYVJW2XS8M0WxcmD0lhktAnoHHoI+pJakXT3hu
        33G87KJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcUeR-00BB4J-7a; Fri, 30 Apr 2021 15:02:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH 5/8] mm: Make compound_head const-preserving
Date:   Fri, 30 Apr 2021 15:55:46 +0100
Message-Id: <20210430145549.2662354-6-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430145549.2662354-1-willy@infradead.org>
References: <20210430145549.2662354-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If you pass a const pointer to compound_head(), you get a const pointer
back; if you pass a mutable pointer, you get a mutable pointer back.
Also remove an unnecessary forward definition of struct page; we're about
to dereference page->compound_head, so it must already have been defined.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/page-flags.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 04a34c08e0a6..d8e26243db25 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -177,17 +177,17 @@ enum pageflags {
 
 #ifndef __GENERATING_BOUNDS_H
 
-struct page;	/* forward declaration */
-
-static inline struct page *compound_head(struct page *page)
+static inline unsigned long _compound_head(const struct page *page)
 {
 	unsigned long head = READ_ONCE(page->compound_head);
 
 	if (unlikely(head & 1))
-		return (struct page *) (head - 1);
-	return page;
+		return head - 1;
+	return (unsigned long)page;
 }
 
+#define compound_head(page)	((typeof(page))_compound_head(page))
+
 static __always_inline int PageTail(struct page *page)
 {
 	return READ_ONCE(page->compound_head) & 1;
-- 
2.30.2

