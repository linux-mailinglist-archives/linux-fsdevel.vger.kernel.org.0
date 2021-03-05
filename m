Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE58332E084
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhCEETR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhCEETP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:19:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4330EC061574;
        Thu,  4 Mar 2021 20:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/ziAJ/GI8dm5TexYAQD4UuVoJKdeAx1m/+HmyZTNY7I=; b=WggUtDfW+fP/+lke5TpqBPeH3U
        PvKUe5/NU7Xs+Sy5ioYl7QfiGg8dXPtgB5jjDiJGS9P5+Zpfg+akJtjl8zQwgflHtD/IiA3bUgz0F
        C03c26Dg0kTEXzPt8Yw+bbKaq0Tvrg0eX9NVyhOAG0EpzaBEA/fHzdNtvSCdAkfpCnTck7us8BDTT
        g+Sw9r1+oCrh2uMgK/nIXp2EZGXL4s329Bw/E47kMyd/e89zLE5U4a9hpd2vQpkwjMhaCqe/jm0iJ
        q0IkAWW+/VXoWL0Dy/ZZUtI1O+VfSey7SvdsfM1x1gLQLDgeeFBEdsfdFf+186G+CJHsfzSpw9SoC
        59uyyamA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI1vi-00A3SZ-0r; Fri, 05 Mar 2021 04:19:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>
Subject: [PATCH v4 02/25] mm: Add folio_pgdat and folio_zone
Date:   Fri,  5 Mar 2021 04:18:38 +0000
Message-Id: <20210305041901.2396498-3-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
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
index a46e5a4385b0..ecfe202aa4ec 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1488,6 +1488,16 @@ static inline pg_data_t *page_pgdat(const struct page *page)
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
2.30.0

