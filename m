Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D2866933C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 10:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbjAMJsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 04:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240722AbjAMJrf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:47:35 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE6A6B1BF;
        Fri, 13 Jan 2023 01:36:59 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Ntbsj6HXgz8RTZH;
        Fri, 13 Jan 2023 17:36:57 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
        by mse-fl2.zte.com.cn with SMTP id 30D9agSE049932;
        Fri, 13 Jan 2023 17:36:42 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 13 Jan 2023 17:36:45 +0800 (CST)
Date:   Fri, 13 Jan 2023 17:36:45 +0800 (CST)
X-Zmail-TransId: 2b0363c1262d2bddc3a3
X-Mailer: Zmail v1.0
Message-ID: <202301131736452546903@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <willy@infradead.org>, <bagasdotme@gmail.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <iamjoonsoo.kim@lge.com>,
        <ran.xiaokai@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjNdIHN3YXBfc3RhdGU6IHVwZGF0ZSBzaGFkb3dfbm9kZXMgZm9yIGFub255bW91cyBwYWdl?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 30D9agSE049932
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63C12639.000 by FangMail milter!
X-FangMail-Envelope: 1673602617/4Ntbsj6HXgz8RTZH/63C12639.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63C12639.000/4Ntbsj6HXgz8RTZH
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
add or delete by calling  xas_set_update(..workingset_update_node).

Fixes: aae466b0052e ("mm/swap: implement workingset detection for anonymous LRU")
Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
change for v3
- Modify git log of explain of this patch do in imperative mood. Thanks to
Bagas Sanjaya.
change for v2
- Include a description of the user-visible effect. Add fixes tag. Modify comments.
Also call workingset_update_node() in clear_shadow_from_swap_cache(). Thanks
to Matthew Wilcox.
---
 include/linux/xarray.h | 3 ++-
 mm/swap_state.c        | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 44dd6d6e01bc..5cc1f718fec9 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1643,7 +1643,8 @@ static inline void xas_set_order(struct xa_state *xas, unsigned long index,
  * @update: Function to call when updating a node.
  *
  * The XArray can notify a caller after it has updated an xa_node.
- * This is advanced functionality and is only needed by the page cache.
+ * This is advanced functionality and is only needed by the page cache
+ * and swap cache.
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
-- 
2.15.2
