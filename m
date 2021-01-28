Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DE430706D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhA1H5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhA1HFi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:05:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DF4C0617A7;
        Wed, 27 Jan 2021 23:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ML5D3QchsSfCvjh/6UQ/1m+q+OQV+91kWcgwnlcDp24=; b=gx45QSjArv+x9Uo+HOoEzmAI7N
        gMYtd7k9aM8T5luVbz6pSuK+K/3UYjSfOVN4qTgrhM5pWL/AEuXbQDVUca3mXqtHgPoVoFT/+g4db
        2b4cJ3q2yQvNMJoeYeFR1Do2SXxJaG1TyC65HDgK8+t0C3OCqBKX2H7FcF+WdJDn3V1hjZnguc5U0
        7M/w2hZmMgHpuSCr2irnkZ29tsBbwazDKpRWqua1BI71a6afnl+4RCFs2RYYB46OUAkiuRhY2NrkY
        D0k4/5fhwrseuAVizM/Sz2A0ASw5CgUSWlmooLjUfk46mbBktgDwjXCCuLVuCtNV4gXQ8YB7sAy7N
        Vh7Qo6Yw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51Lt-00847n-U7; Thu, 28 Jan 2021 07:04:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/25] mm/memcg: Add mem_cgroup_folio_lruvec
Date:   Thu, 28 Jan 2021 07:03:51 +0000
Message-Id: <20210128070404.1922318-13-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
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

