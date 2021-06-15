Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994973A8667
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 18:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFOQ2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 12:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhFOQ2D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:28:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE019C061574;
        Tue, 15 Jun 2021 09:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=z7u3S8CmzDwUu+KyqGJsHre51dm3R8D4XFikCNhQZro=; b=TrwGrPYYk0csy2V772vjm/TBMs
        MPFn4TL2k+daZO7QYkEneGiuGooTGskcXwH1KskqBbq+ybWlJ+60+c4om7tTC7juy61j+r/p1F7K/
        LJbYGC2O7nO3XRFM7re5hqvFqSq0VBQKNkF7VvbDWZ+NWRaDIEFlu7f2294dILHKo2Ya52XsD2GFK
        gQOELbQBimN3ZFMv+26wwOuY4WdXDyvzpEgD9prfm8eyI2OskkXr1++RjxVfBt/ruZfXd6Rn9y7lZ
        ekt1sHzxy/XrcErWU0wr12BJFoj5PprVYo5mbDIn8IMG3P2uaD2S5Zx/Su4dR6kvvrls0ivMcrSYu
        wWVvCGJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltBrf-0070MF-UG; Tue, 15 Jun 2021 16:24:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 2/6] mm/writeback: Use __set_page_dirty in __set_page_dirty_nobuffers
Date:   Tue, 15 Jun 2021 17:23:38 +0100
Message-Id: <20210615162342.1669332-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615162342.1669332-1-willy@infradead.org>
References: <20210615162342.1669332-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is fundamentally the same code, so just call it instead of
duplicating it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0c2c8355f97f..980a6cb9cbd9 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2503,20 +2503,12 @@ int __set_page_dirty_nobuffers(struct page *page)
 	lock_page_memcg(page);
 	if (!TestSetPageDirty(page)) {
 		struct address_space *mapping = page_mapping(page);
-		unsigned long flags;
 
 		if (!mapping) {
 			unlock_page_memcg(page);
 			return 1;
 		}
-
-		xa_lock_irqsave(&mapping->i_pages, flags);
-		BUG_ON(page_mapping(page) != mapping);
-		WARN_ON_ONCE(!PagePrivate(page) && !PageUptodate(page));
-		account_page_dirtied(page, mapping);
-		__xa_set_mark(&mapping->i_pages, page_index(page),
-				   PAGECACHE_TAG_DIRTY);
-		xa_unlock_irqrestore(&mapping->i_pages, flags);
+		__set_page_dirty(page, mapping, !PagePrivate(page));
 		unlock_page_memcg(page);
 
 		if (mapping->host) {
-- 
2.30.2

