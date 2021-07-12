Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AB53C41FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbhGLDiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhGLDiE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:38:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211A1C0613DD;
        Sun, 11 Jul 2021 20:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=g0f91Ce67VZVh40hHvyvzcG6kDKC8un4MCAd5032QwE=; b=bf2gNa1a+p3VR9tVRebBDYrogN
        FlcM7GbpaGowPayjE3ffHDh4FcAF6thqVaBS4/FrnJHP6DW4RJ0LQN2Wk1wlkPdMe0L92PYklMdp3
        G2lnhvf2jzfnj5KIgdKvl9GoZU9OrIWoxw0CzCzBQ8miApIxUsOPF2U1GbiZVyMFDEpbVIt29rTvb
        YphmcgZDQMePpJcoSCQCKcE1BKySHzGE1AVCN0AJ8YfDRwskX6oCbgh9pGNzXHfeotZ70HgaWeHIw
        6C4oxHuW2SgH5ok+l8hG5zGzQWtbL7iC98qLuoKj8LBbWaKsM8a6dqcaGi1gmzYlKDOlmK5iNGcPR
        8K4BfqCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mhw-00GogS-IR; Mon, 12 Jul 2021 03:34:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 051/137] mm: Add folio_pfn()
Date:   Mon, 12 Jul 2021 04:05:35 +0100
Message-Id: <20210712030701.4000097-52-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
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
index 80f27eb151ba..fa5974870660 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1622,6 +1622,20 @@ static inline unsigned long page_to_section(const struct page *page)
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

