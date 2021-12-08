Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156A646CC5E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbhLHE10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240063AbhLHE0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC39BC061A72
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qEOJB5zqrjmIjIMgFkQEnCrDBHeSM6KGmwYonkVVccg=; b=vj99tWu1MyReP+jzY/YAJWhNVE
        PHZjCc6Pivhz/Q9ENpqol0+nR60b2WugjfAeSEhB1LWNcfSnxdFswkB6r+fesy6E1jRQ9q6kJ8+zo
        xhelbKHgobmdMqubTl/xCBSm71n4RQGUBglLQi0z35Fe1a90ZQYhlU76sZM4/ZrTNgcyBRJGUE3FU
        FhE+wb16q6iolgmxvQVW0is3Xre7PW03hp9nmtbYVoKWnSpiWkYD/MZYm4tYbZsFSyzcftzp36ii8
        EkbgRiDndw3cqyMhQdq+PV3GMC6dUkxG+GZLyGEdNBwaVtKoqe8UPstfH8xdNvgrs0iRCGCX8PB52
        pLaup+Qw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU3-0084Xu-8H; Wed, 08 Dec 2021 04:23:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 15/48] filemap: Remove thp_contains()
Date:   Wed,  8 Dec 2021 04:22:23 +0000
Message-Id: <20211208042256.1923824-16-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function is now unused, so delete it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 3f26b191ede3..8c2cad7f0c36 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -512,15 +512,6 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
 			mapping_gfp_mask(mapping));
 }
 
-/* Does this page contain this index? */
-static inline bool thp_contains(struct page *head, pgoff_t index)
-{
-	/* HugeTLBfs indexes the page cache in units of hpage_size */
-	if (PageHuge(head))
-		return head->index == index;
-	return page_index(head) == (index & ~(thp_nr_pages(head) - 1UL));
-}
-
 #define swapcache_index(folio)	__page_file_index(&(folio)->page)
 
 /**
-- 
2.33.0

