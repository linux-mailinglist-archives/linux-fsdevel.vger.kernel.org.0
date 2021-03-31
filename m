Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609C63506B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 20:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhCaSsn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 14:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbhCaSsP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:48:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66080C061574;
        Wed, 31 Mar 2021 11:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FyrpBJWj25ijLPQvz5Bf0+SLReGmXxIsewezEd/5bAA=; b=SXa1uRTBasOjaK9myGKyGWvD4S
        dgGAJfn11UDDp/sW/2kX3BxQOPM7dyVWtIPIdTyNDRqdpoKkbO96M7tvulj0jfyvkw3WkVE9n3jOo
        bdEEb7Jdxkq3pOk5n5XswwO07tQxrluzHMqt0FW42oNKcQ/Fb0PrAJ4gYOfIsHsbqFGE7myBMa+OI
        nT+OSehpnwzx0YIG9yJkYXaKoQ4pQVvfIW8ITynjMgeyWuYojbWycmb5a/kFVsDeWIxWqTEQyAI/0
        Ye3oOhTJbPtD7xn5XAKG5PZNavq9jsZlUpKRA9r2CH66KIeMGp98CU5UJakTznxgnKI4qa/fyOmVh
        jg1A3XWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRfsV-004z5w-PK; Wed, 31 Mar 2021 18:47:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v6 02/27] mm: Add folio_pgdat and folio_zone
Date:   Wed, 31 Mar 2021 19:47:03 +0100
Message-Id: <20210331184728.1188084-3-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210331184728.1188084-1-willy@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are just convenience wrappers for callers with folios; pgdat and
zone can be reached from tail pages as well as head pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/mm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 761063e733bf..195c4740522d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1546,6 +1546,16 @@ static inline pg_data_t *page_pgdat(const struct page *page)
 	return NODE_DATA(page_to_nid(page));
 }
 
+static inline struct zone *folio_zone(const struct folio *folio)
+{
+	return page_zone(&folio->page);
+}
+
+static inline pg_data_t *folio_pgdat(const struct folio *folio)
+{
+	return page_pgdat(&folio->page);
+}
+
 #ifdef SECTION_IN_PAGE_FLAGS
 static inline void set_page_section(struct page *page, unsigned long section)
 {
-- 
2.30.2

