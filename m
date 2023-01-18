Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3C671C95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 13:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjARMwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 07:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjARMvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:51:51 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029D04347C;
        Wed, 18 Jan 2023 04:13:46 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4Nxl6J36nzz501Sc;
        Wed, 18 Jan 2023 20:13:44 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl2.zte.com.cn with SMTP id 30ICD0IN038239;
        Wed, 18 Jan 2023 20:13:00 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 18 Jan 2023 20:13:03 +0800 (CST)
Date:   Wed, 18 Jan 2023 20:13:03 +0800 (CST)
X-Zmail-TransId: 2b0663c7e24fffffffff983002a8
X-Mailer: Zmail v1.0
Message-ID: <202301182013032211005@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <willy@infradead.org>, <bagasdotme@gmail.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <iamjoonsoo.kim@lge.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjRdIHN3YXBfc3RhdGU6IHVwZGF0ZSBzaGFkb3dfbm9kZXMgZm9yIGFub255bW91cyBwYWdl?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 30ICD0IN038239
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63C7E278.000/4Nxl6J36nzz501Sc
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Shadow_nodes is for shadow nodes reclaiming of workingset handling,
it is updated when page cache add or delete since long time ago
workingset only supported page cache. But when workingset supports
anonymous page detection, we missied updating shadow nodes for
it. This caused that shadow nodes of anonymous page will never be
reclaimd by scan_shadow_nodes() even they use much memory and
system memory is tense.

So update shadow_nodes of anonymous page when swap cache is
add or delete by calling xas_set_update(..workingset_update_node).

Fixes: aae466b0052e ("mm/swap: implement workingset detection for anonymous LRU")
Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
change for v4
- Fix kernel panic while calling spin_trylock(&mapping->host->i_lock) in shadow_lru_isolate().
For anonymous page mapping->host is NULL, so add a check. Thanks to Matthew Wilcox.
change for v3
- Modify git log of explain of what this patch do in imperative mood. Thanks to
Bagas Sanjaya.
change for v2
- Include a description of the user-visible effect. Add fixes tag. Modify comments.
Also call workingset_update_node() in clear_shadow_from_swap_cache(). Thanks
to Matthew Wilcox.
---
 include/linux/xarray.h |  3 ++-
 mm/swap_state.c        |  6 ++++++
 mm/workingset.c        | 21 +++++++++++++--------
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 44dd6d6e01bc..741703b45f61 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1643,7 +1643,8 @@ static inline void xas_set_order(struct xa_state *xas, unsigned long index,
  * @update: Function to call when updating a node.
  *
  * The XArray can notify a caller after it has updated an xa_node.
- * This is advanced functionality and is only needed by the page cache.
+ * This is advanced functionality and is only needed by the page
+ * cache and swap cache.
  */
 static inline void xas_set_update(struct xa_state *xas, xa_update_node_t update)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index cb9aaa00951d..7a003d8abb37 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -94,6 +94,8 @@ int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
 	unsigned long i, nr = folio_nr_pages(folio);
 	void *old;

+	xas_set_update(&xas, workingset_update_node);
+
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_swapbacked(folio), folio);
@@ -145,6 +147,8 @@ void __delete_from_swap_cache(struct folio *folio,
 	pgoff_t idx = swp_offset(entry);
 	XA_STATE(xas, &address_space->i_pages, idx);

+	xas_set_update(&xas, workingset_update_node);
+
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
@@ -252,6 +256,8 @@ void clear_shadow_from_swap_cache(int type, unsigned long begin,
 		struct address_space *address_space = swap_address_space(entry);
 		XA_STATE(xas, &address_space->i_pages, curr);

+		xas_set_update(&xas, workingset_update_node);
+
 		xa_lock_irq(&address_space->i_pages);
 		xas_for_each(&xas, old, end) {
 			if (!xa_is_value(old))
diff --git a/mm/workingset.c b/mm/workingset.c
index f194d13beabb..00c6f4d9d9be 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -657,11 +657,14 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 		goto out;
 	}

-	if (!spin_trylock(&mapping->host->i_lock)) {
-		xa_unlock(&mapping->i_pages);
-		spin_unlock_irq(lru_lock);
-		ret = LRU_RETRY;
-		goto out;
+	/* For page cache we need to hold i_lock */
+	if (mapping->host != NULL) {
+		if (!spin_trylock(&mapping->host->i_lock)) {
+			xa_unlock(&mapping->i_pages);
+			spin_unlock_irq(lru_lock);
+			ret = LRU_RETRY;
+			goto out;
+		}
 	}

 	list_lru_isolate(lru, item);
@@ -683,9 +686,11 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,

 out_invalid:
 	xa_unlock_irq(&mapping->i_pages);
-	if (mapping_shrinkable(mapping))
-		inode_add_lru(mapping->host);
-	spin_unlock(&mapping->host->i_lock);
+	if (mapping->host != NULL) {
+		if (mapping_shrinkable(mapping))
+			inode_add_lru(mapping->host);
+		spin_unlock(&mapping->host->i_lock);
+	}
 	ret = LRU_REMOVED_RETRY;
 out:
 	cond_resched();
-- 
2.25.1
