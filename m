Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F4935A64A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 20:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhDISyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 14:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbhDISyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:54:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080F9C061762;
        Fri,  9 Apr 2021 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1UMnGDDWJmAY1/6y8962U/m+lllkXlT3V7rNpYDGr6k=; b=NqIvMsYD4n148d5ZNxfZSozu7d
        el0ki0QHCZmYxYCI2MvgjX2tirsLwh4rtfM3Em88nwcW3xE/XFsZctoJzLV9UCNA6i6SsjTawQysp
        GTJey5U++GVztP4qmuNrGTql3qxkWIu74cgprn0oWegVmIchycHkNaqgBmsTmC4EmnpRlLVe0ePcW
        vogSW/ynwG+Ta3A9Ik0b7v044JHV2kRk9ZjUg1g6pl7irwj7wS/f0oN/+Y7vBGmelcmKLBlcgZdyD
        vs+lbtLNmGf7RwGseIcdDCRKcTg4loQtDD0AaxKJbb2AJSgd1r55bv+Ed7reiMCMmoW3numbQ54C/
        62+ODHdg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUwFH-000n6v-4n; Fri, 09 Apr 2021 18:52:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Zi Yan <ziy@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v7 03/28] mm: Add folio_pgdat and folio_zone
Date:   Fri,  9 Apr 2021 19:50:40 +0100
Message-Id: <20210409185105.188284-4-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409185105.188284-1-willy@infradead.org>
References: <20210409185105.188284-1-willy@infradead.org>
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
index 4ece80aa8d05..4c98b52613b7 100644
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

