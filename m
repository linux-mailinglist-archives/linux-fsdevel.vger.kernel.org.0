Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A973B041D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhFVMUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhFVMUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:20:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC68C061574;
        Tue, 22 Jun 2021 05:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JDaUOJALMebNh4PadqGaBGITP/KUBgH2yokzmVW+A+Q=; b=HflKthEcpfi4iEAIp8kWdu7tVj
        /aLeavFL4VgsDHgAZAcACmjs6+Cn0/AxJJITR0CZlP9f7lkBKWiVdLg9nMeoeCuoju2GhTxA//oYv
        faMfxLbL/5qgFaWJq11KPxSf9YPDEZREpcan+N07u+nV80ySl2IN/L1EFHFW/HJeYnQdhjmqV8GYm
        OMaHQxf/UD0n1VIFRV8QvENzEp3JRjLZtc7xJdhciGlbDJeCVk6Ub+Z9UX5xMfQ6vBzw6c7ai9/yW
        gCkHw0nqqXGs8Hs8vGdDLI5tKzmXYIGOVLdpDZQHtPVy8GR4oYILzPCxAKVNIt36fqqEgFXLwFU/X
        b7b3Ml9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfKl-00EGEF-FG; Tue, 22 Jun 2021 12:17:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/46] mm: Add folio_to_pfn()
Date:   Tue, 22 Jun 2021 13:15:06 +0100
Message-Id: <20210622121551.3398730-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pfn of a folio is the pfn of its head page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9b7030d1899f..2c7b6ae1d3fc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1619,6 +1619,11 @@ static inline unsigned long page_to_section(const struct page *page)
 }
 #endif
 
+static inline unsigned long folio_to_pfn(struct folio *folio)
+{
+	return page_to_pfn(&folio->page);
+}
+
 /* MIGRATE_CMA and ZONE_MOVABLE do not allow pin pages */
 #ifdef CONFIG_MIGRATION
 static inline bool is_pinnable_page(struct page *page)
-- 
2.30.2

