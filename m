Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFE43A7119
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 23:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbhFNVVO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 17:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhFNVVN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 17:21:13 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273C5C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jun 2021 14:19:10 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c18so24822939qkc.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jun 2021 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sgb+fuaFTgoZ/okWwz0fCGk2erI6Ba+62W428kydMsA=;
        b=cVWUH0f1+aGvFTLqzf7RJTBR7K+/orq4vCRKi2GARBla0mItJiAjqyUPfz33yCFaI+
         d0JyTzYOR/pT75cxDCwyBcC0FWBIWv05whp2rKIiIhZOQO2mzw6aQcsAwD6UhGJqu6gR
         1ygYrnw9gO6hV74fvHExc+Ffz2U3L6lPZXvn3btl4L55IRHmMKjR8ZNQRvkNQssayzvg
         TWMG+irrP+wXze7QsjXXVzJOzyK0xtmZ51LYuG0lldGynOKFf74cCyTR+OQjf4RVD1sq
         isP6Zq5/uhz2bHgliaTpKb8krNnXDulKBT0ULL4UM2pJrlJ/q50J0vCzTfltNPAVV+pG
         RKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sgb+fuaFTgoZ/okWwz0fCGk2erI6Ba+62W428kydMsA=;
        b=UJyFh7wxS4kslTMOaDCGHdPL/Z13b3rNhixUvf2ETyJwFuqBpMc2g3kDUazGTns0I8
         IPYueqCN3x1uWGOC866vjEMfWvC1oUjfqobvCS0UniQzIOjzj5PPxOaNnU+q2DOlRuMW
         SpThMqBZSQ7QUJXq7WxxK+1R/uk5nYXpbvhYuMhIGfB5/bDx8VljsmPTMBlF6EYj08y5
         aZImsCA2fuDcs26rEkb/qCXCNnUTovoyAZC4cGzO2AWa8skAbO0lmr1nSmhsfNsb9+Tb
         FYQgAF9Xd68cQTltV3t8dkVfq5X70NnJrNnKlTzfPQR7OxTR/tUxph9jXqFP+Nuo+LvP
         /kNg==
X-Gm-Message-State: AOAM533kHz5FlN2G3rg5BqnTOBWRZKiH3Z2oEDLEnKxuju3NtG94zP1y
        VHd/vcNpSQfTd4jN2tLjRIaw1w==
X-Google-Smtp-Source: ABdhPJzSF4akbF9UeyuNlv52c3S5EjiIMmK/poM1yMN0hqxBsN6pWFJcNTaVJKemRIyhzASAXKFzzQ==
X-Received: by 2002:ae9:f205:: with SMTP id m5mr12202354qkg.412.1623705545942;
        Mon, 14 Jun 2021 14:19:05 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id q16sm10895592qkq.121.2021.06.14.14.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 14:19:05 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/4] mm: remove irqsave/restore locking from contexts with irqs enabled
Date:   Mon, 14 Jun 2021 17:19:01 -0400
Message-Id: <20210614211904.14420-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The page cache deletion paths all have interrupts enabled, so no need
to use irqsafe/irqrestore locking variants.

They used to have irqs disabled by the memcg lock added in commit
c4843a7593a9 ("memcg: add per cgroup dirty page accounting"), but that
has since been replaced by memcg taking the page lock instead, commit
0a31bc97c80c ("mm: memcontrol: rewrite uncharge AP").

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/filemap.c  | 15 ++++++---------
 mm/truncate.c |  8 +++-----
 mm/vmscan.c   |  9 ++++-----
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ba1068a1837f..819d2589abef 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -258,12 +258,11 @@ static void page_cache_free_page(struct address_space *mapping,
 void delete_from_page_cache(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
-	unsigned long flags;
 
 	BUG_ON(!PageLocked(page));
-	xa_lock_irqsave(&mapping->i_pages, flags);
+	xa_lock_irq(&mapping->i_pages);
 	__delete_from_page_cache(page, NULL);
-	xa_unlock_irqrestore(&mapping->i_pages, flags);
+	xa_unlock_irq(&mapping->i_pages);
 
 	page_cache_free_page(mapping, page);
 }
@@ -335,19 +334,18 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct pagevec *pvec)
 {
 	int i;
-	unsigned long flags;
 
 	if (!pagevec_count(pvec))
 		return;
 
-	xa_lock_irqsave(&mapping->i_pages, flags);
+	xa_lock_irq(&mapping->i_pages);
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		trace_mm_filemap_delete_from_page_cache(pvec->pages[i]);
 
 		unaccount_page_cache_page(mapping, pvec->pages[i]);
 	}
 	page_cache_delete_batch(mapping, pvec);
-	xa_unlock_irqrestore(&mapping->i_pages, flags);
+	xa_unlock_irq(&mapping->i_pages);
 
 	for (i = 0; i < pagevec_count(pvec); i++)
 		page_cache_free_page(mapping, pvec->pages[i]);
@@ -821,7 +819,6 @@ void replace_page_cache_page(struct page *old, struct page *new)
 	void (*freepage)(struct page *) = mapping->a_ops->freepage;
 	pgoff_t offset = old->index;
 	XA_STATE(xas, &mapping->i_pages, offset);
-	unsigned long flags;
 
 	VM_BUG_ON_PAGE(!PageLocked(old), old);
 	VM_BUG_ON_PAGE(!PageLocked(new), new);
@@ -833,7 +830,7 @@ void replace_page_cache_page(struct page *old, struct page *new)
 
 	mem_cgroup_migrate(old, new);
 
-	xas_lock_irqsave(&xas, flags);
+	xas_lock_irq(&xas);
 	xas_store(&xas, new);
 
 	old->mapping = NULL;
@@ -846,7 +843,7 @@ void replace_page_cache_page(struct page *old, struct page *new)
 		__dec_lruvec_page_state(old, NR_SHMEM);
 	if (PageSwapBacked(new))
 		__inc_lruvec_page_state(new, NR_SHMEM);
-	xas_unlock_irqrestore(&xas, flags);
+	xas_unlock_irq(&xas);
 	if (freepage)
 		freepage(old);
 	put_page(old);
diff --git a/mm/truncate.c b/mm/truncate.c
index 57a618c4a0d6..b92b86222625 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -563,21 +563,19 @@ void invalidate_mapping_pagevec(struct address_space *mapping,
 static int
 invalidate_complete_page2(struct address_space *mapping, struct page *page)
 {
-	unsigned long flags;
-
 	if (page->mapping != mapping)
 		return 0;
 
 	if (page_has_private(page) && !try_to_release_page(page, GFP_KERNEL))
 		return 0;
 
-	xa_lock_irqsave(&mapping->i_pages, flags);
+	xa_lock_irq(&mapping->i_pages);
 	if (PageDirty(page))
 		goto failed;
 
 	BUG_ON(page_has_private(page));
 	__delete_from_page_cache(page, NULL);
-	xa_unlock_irqrestore(&mapping->i_pages, flags);
+	xa_unlock_irq(&mapping->i_pages);
 
 	if (mapping->a_ops->freepage)
 		mapping->a_ops->freepage(page);
@@ -585,7 +583,7 @@ invalidate_complete_page2(struct address_space *mapping, struct page *page)
 	put_page(page);	/* pagecache ref */
 	return 1;
 failed:
-	xa_unlock_irqrestore(&mapping->i_pages, flags);
+	xa_unlock_irq(&mapping->i_pages);
 	return 0;
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index eb314525c889..cc5d7cd75935 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1049,14 +1049,13 @@ static pageout_t pageout(struct page *page, struct address_space *mapping)
 static int __remove_mapping(struct address_space *mapping, struct page *page,
 			    bool reclaimed, struct mem_cgroup *target_memcg)
 {
-	unsigned long flags;
 	int refcount;
 	void *shadow = NULL;
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(mapping != page_mapping(page));
 
-	xa_lock_irqsave(&mapping->i_pages, flags);
+	xa_lock_irq(&mapping->i_pages);
 	/*
 	 * The non racy check for a busy page.
 	 *
@@ -1097,7 +1096,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		if (reclaimed && !mapping_exiting(mapping))
 			shadow = workingset_eviction(page, target_memcg);
 		__delete_from_swap_cache(page, swap, shadow);
-		xa_unlock_irqrestore(&mapping->i_pages, flags);
+		xa_unlock_irq(&mapping->i_pages);
 		put_swap_page(page, swap);
 	} else {
 		void (*freepage)(struct page *);
@@ -1123,7 +1122,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		    !mapping_exiting(mapping) && !dax_mapping(mapping))
 			shadow = workingset_eviction(page, target_memcg);
 		__delete_from_page_cache(page, shadow);
-		xa_unlock_irqrestore(&mapping->i_pages, flags);
+		xa_unlock_irq(&mapping->i_pages);
 
 		if (freepage != NULL)
 			freepage(page);
@@ -1132,7 +1131,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 	return 1;
 
 cannot_free:
-	xa_unlock_irqrestore(&mapping->i_pages, flags);
+	xa_unlock_irq(&mapping->i_pages);
 	return 0;
 }
 
-- 
2.32.0

