Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A4E37002F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 20:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhD3SKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 14:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3SKt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:10:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B18C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fTmQo50oOSW96isullJfUZVK+rFw+CfueZc2tV0ZVTs=; b=aUphQNaZeDz+IkNQt5COBdS4Aa
        JfYQdt3KAiJoJ20uunXmQZChQBdvWXpvSYoq0ZhI4u8W66dR44Pq1T7I2FhmStvtAJdxiHqZiMJFo
        yGnG0sLzB9GJWUd5YU4u8kRpDXIkzu5pC7H/ARW0HDz9wGwsbEPanNH8p985ZXM1hXD5Rq9gn1sAr
        7k78Q6DHfJ5Cl0SZRewr0LEQxZiVX4IuwyxNsIRjHMsyacADhPNErf/djZNfDAxwkHQvieUh4vhZV
        6Q83KlTfoHrboC6HMN9KXUVECOzOyNfWSmC3AgtBsQYvOe6yTLrWdt1nmF4SqgJKKsjIbSlftI5Yl
        6AlrVGyw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcXZZ-00BMLL-Rt; Fri, 30 Apr 2021 18:09:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zi Yan <ziy@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 02/31] mm: Add folio_pgdat and folio_zone
Date:   Fri, 30 Apr 2021 19:07:11 +0100
Message-Id: <20210430180740.2707166-3-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430180740.2707166-1-willy@infradead.org>
References: <20210430180740.2707166-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are just convenience wrappers for callers with folios; pgdat and
zone can be reached from tail pages as well as head pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/mm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b29c86824e6b..a55c2c0628b6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1560,6 +1560,16 @@ static inline pg_data_t *page_pgdat(const struct page *page)
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

