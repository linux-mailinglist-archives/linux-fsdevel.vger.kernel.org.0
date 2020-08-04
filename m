Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A0523BDF3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 18:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgHDQSL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 12:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgHDQSA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:18:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841FEC061757
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 09:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SGwNWjKjTMY0/QHlMsmsqDcOZ0fi2PHNBBwqVmM+U3g=; b=HfmGtJIL/+sXrLAdLC03ufZh/t
        gnYsPCGK2KObaKom8GqzlgjYkN7u0H8cWx3RNh1g7P0e+9VZxkOAJYbT2/B3iYWUZAcV2ng2r1Pqw
        eiHoKAHTOIZ5D9UFNEnQdTmg9Jlk3a4dRfEyTnAY3zCdiIjASO0USay5VwMsmXWSaQrFzWBI/YKdt
        kpyrUqRPckp5H9zERxzuTu6QOrBGw1eWXFeQzHXH4GV01SYVz+M9q7z55DNUoKIua4OPR8malpyLP
        nGFBhVtvnLqdu5dpnDyg4sUCN6uyFmDdN6BI6s/eQhnv7CcaM4dlo53j5rzmpeGqu7LufLw7khNfj
        GVkYV4qw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2zdV-0002e6-Pd; Tue, 04 Aug 2020 16:17:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-nvdimm@lists.01.org
Subject: [PATCH 2/4] mm: Stop accounting shadow entries
Date:   Tue,  4 Aug 2020 17:17:53 +0100
Message-Id: <20200804161755.10100-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200804161755.10100-1-willy@infradead.org>
References: <20200804161755.10100-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We no longer need to keep track of how many shadow entries are
present in a mapping.  This saves a few writes to the inode and
memory barriers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c    | 12 ------------
 mm/truncate.c   |  1 -
 mm/workingset.c |  1 -
 3 files changed, 14 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 76383d558b7c..7c3f97bd6dcd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -139,17 +139,6 @@ static void page_cache_delete(struct address_space *mapping,
 
 	page->mapping = NULL;
 	/* Leave page->index set: truncation lookup relies upon it */
-
-	if (shadow) {
-		mapping->nrexceptional += nr;
-		/*
-		 * Make sure the nrexceptional update is committed before
-		 * the nrpages update so that final truncate racing
-		 * with reclaim does not see both counters 0 at the
-		 * same time and miss a shadow entry.
-		 */
-		smp_wmb();
-	}
 	mapping->nrpages -= nr;
 }
 
@@ -860,7 +849,6 @@ static int __add_to_page_cache_locked(struct page *page,
 			goto unlock;
 
 		if (xa_is_value(old)) {
-			mapping->nrexceptional--;
 			if (shadowp)
 				*shadowp = old;
 		}
diff --git a/mm/truncate.c b/mm/truncate.c
index 7c4c8ac140be..a59184793607 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -40,7 +40,6 @@ static inline void __clear_shadow_entry(struct address_space *mapping,
 	if (xas_load(&xas) != entry)
 		return;
 	xas_store(&xas, NULL);
-	mapping->nrexceptional--;
 }
 
 static void clear_shadow_entry(struct address_space *mapping, pgoff_t index,
diff --git a/mm/workingset.c b/mm/workingset.c
index fdeabea54e77..0649bfb1ca33 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -547,7 +547,6 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 		goto out_invalid;
 	if (WARN_ON_ONCE(node->count != node->nr_values))
 		goto out_invalid;
-	mapping->nrexceptional -= node->nr_values;
 	xas.xa_node = xa_parent_locked(&mapping->i_pages, node);
 	xas.xa_offset = node->offset;
 	xas.xa_shift = node->shift + XA_CHUNK_SHIFT;
-- 
2.27.0

