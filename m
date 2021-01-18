Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5882FA752
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407032AbhARRUP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392994AbhARRDY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:03:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16852C061796;
        Mon, 18 Jan 2021 09:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ML5D3QchsSfCvjh/6UQ/1m+q+OQV+91kWcgwnlcDp24=; b=Ry7JrSBd6iQQ4MvfXQoEVwAN9F
        TmQb4UXoz60oppMczsz01gcZMD9G6mJxmT+FTZB80pT25hJkv040mM2+wxVMd7gw30etQIcxHNR03
        irEr7irhwLXUph+H3Mg8RrltI21HfrEBUDZXDkxwSfLo7d9/Om8UCwUxBGgES2ge5H3d1lH39+fwf
        tFV4NK9pnlMNbCzTJjh1Px+sOdI3AAqUUArIdcOUIiNYd2LzWhmZuaN5s+D6RFIBHy2m+AyWfWAII
        elL12cXopcQrJk/Ysqeosl6AdPMz9YK7S3sD78ueUSPnOKG3CbMLhT2JAaubEoOh8rII36K6QVwxS
        4ZRW5vuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1Xuq-00D7K2-CU; Mon, 18 Jan 2021 17:02:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/27] mm/memcg: Add mem_cgroup_folio_lruvec
Date:   Mon, 18 Jan 2021 17:01:33 +0000
Message-Id: <20210118170148.3126186-13-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

mem_cgroup_page_lruvec() already expects a head page, so this will add some
typesafety once we can remove mem_cgroup_page_lruvec().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 89aaa22506e6..ec7ecfc0e47b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1454,6 +1454,12 @@ static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
 }
 #endif /* CONFIG_MEMCG */
 
+static inline struct lruvec *mem_cgroup_folio_lruvec(struct folio *folio,
+						    struct pglist_data *pgdat)
+{
+	return mem_cgroup_page_lruvec(&folio->page, pgdat);
+}
+
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
 {
 	__mod_lruvec_kmem_state(p, idx, 1);
-- 
2.29.2

