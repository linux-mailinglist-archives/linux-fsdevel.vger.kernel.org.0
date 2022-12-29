Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D9D658D19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 14:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiL2NaR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 08:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2NaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 08:30:15 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53044FACF;
        Thu, 29 Dec 2022 05:30:11 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NjTlj0fLRz8R040;
        Thu, 29 Dec 2022 21:30:09 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl1.zte.com.cn with SMTP id 2BTDTxbk062621;
        Thu, 29 Dec 2022 21:29:59 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 29 Dec 2022 21:30:03 +0800 (CST)
Date:   Thu, 29 Dec 2022 21:30:03 +0800 (CST)
X-Zmail-TransId: 2b0363ad965bffffffff8efe8e3d
X-Mailer: Zmail v1.0
Message-ID: <202212292130035747813@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <willy@infradead.org>,
        <iamjoonsoo.kim@lge.com>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHN3YXBfc3RhdGU6IHVwZGF0ZSBzaGFkb3dfbm9kZXMgZm9yIGFub255bW91cyBwYWdl?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2BTDTxbk062621
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63AD9661.000 by FangMail milter!
X-FangMail-Envelope: 1672320609/4NjTlj0fLRz8R040/63AD9661.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63AD9661.000/4NjTlj0fLRz8R040
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
anonymous page detection[1], we missied updating shadow nodes for
it.

[1] commit aae466b0052e ("mm/swap: implement workingset detection for anonymous LRU")

Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 include/linux/xarray.h | 3 ++-
 mm/swap_state.c        | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 44dd6d6e01bc..cd2ccb09c596 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1643,7 +1643,8 @@ static inline void xas_set_order(struct xa_state *xas, unsigned long index,
  * @update: Function to call when updating a node.
  *
  * The XArray can notify a caller after it has updated an xa_node.
- * This is advanced functionality and is only needed by the page cache.
+ * This is advanced functionality and is only needed by the page cache
+ * and anonymous page.
  */
 static inline void xas_set_update(struct xa_state *xas, xa_update_node_t update)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index cb9aaa00951d..ed7c652d06db 100644
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
-- 
2.15.2
