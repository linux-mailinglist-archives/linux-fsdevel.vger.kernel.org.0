Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656D43C9714
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbhGOEVz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbhGOEVz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:21:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B1DC06175F;
        Wed, 14 Jul 2021 21:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3MhUuhvN5PSzy3FDchiZH89Zo2RpiYRVaWvbf1NSsWY=; b=kjDHlMefUZNhNNaGGwuh7CT9D6
        XeO13Tz2B8j9im+ZA4alHATGSiQJ3qFX18jn8B7rk1EnioSI+u17DQqCz5VWO1VbeCaD6DYKozSF9
        qwKr3ObX7ohWGqAEvj8eYh/ZhD+2a6XpsUbjon9j0BHFDkGaXEupt25N+N2av0fREmHSiuwtrWK1L
        0Y82XUJv0RV35eZmz0c8na6rjWIJmmiUpk6mLjDSqpt9gLYeGRihqIWDUHiCgwqzAycHzJ+K7njOS
        QFH8BNG9u+g3fGGUcPwmgEjHu69eoCaCiru+2VumGlw4lXWeSaX4LG3B0Lt9KNVEPFZgqSuAFLiXS
        vZzuixeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3soY-002wg5-TI; Thu, 15 Jul 2021 04:18:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 051/138] mm: Add folio_pfn()
Date:   Thu, 15 Jul 2021 04:35:37 +0100
Message-Id: <20210715033704.692967-52-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the folio equivalent of page_to_pfn().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c6e2a1682a6d..89daae93aa9b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1623,6 +1623,20 @@ static inline unsigned long page_to_section(const struct page *page)
 }
 #endif
 
+/**
+ * folio_pfn - Return the Page Frame Number of a folio.
+ * @folio: The folio.
+ *
+ * A folio may contain multiple pages.  The pages have consecutive
+ * Page Frame Numbers.
+ *
+ * Return: The Page Frame Number of the first page in the folio.
+ */
+static inline unsigned long folio_pfn(struct folio *folio)
+{
+	return page_to_pfn(&folio->page);
+}
+
 /* MIGRATE_CMA and ZONE_MOVABLE do not allow pin pages */
 #ifdef CONFIG_MIGRATION
 static inline bool is_pinnable_page(struct page *page)
-- 
2.30.2

