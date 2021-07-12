Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4A23C6321
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbhGLTH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbhGLTH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:07:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2181C0613DD;
        Mon, 12 Jul 2021 12:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oho32fb4EndS/uwM41GnXhOxiT41S3Jw0vCTyJbW2Cc=; b=FXKbSqcLZ/h1W4RPnHritQS78D
        L/uVLDMBjZ2Pd73VUu2/6nolZizgyaOluT9YYX6SPc/Kgd3vi296mDeHRKEuSrfl+VUHYP9a7c8PH
        H0FP4+gEMPLb+Ai3/8mQYtNpuSVQQswtFZkyEtMEW7IFEdIt+LYqz/zx+8RG0PeoNKUtoDDp0fN8u
        xWo9PH8b2+3n+fS6d67zhttNJAdQKvNcrufZ6jG09wgbNOphXVGtG7qktGXVBnnWsOtxb7Ci0HunX
        j3XUJXRELSQBG3F+lYqDdk1IAlKxF1XnWYfyNYU6xNO8tE1iD9u7b9WX+UVYkcPPTxzBKo+1nDZwz
        Ikb/KafA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m31Dc-000LEv-97; Mon, 12 Jul 2021 19:03:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v13 04/32] mm/vmstat: Add functions to account folio statistics
Date:   Mon, 12 Jul 2021 20:01:36 +0100
Message-Id: <20210712190204.80979-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712190204.80979-1-willy@infradead.org>
References: <20210712190204.80979-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow page counters to be more readily modified by callers which have
a folio.  Name these wrappers with 'stat' instead of 'state' as requested
by Linus here:
https://lore.kernel.org/linux-mm/CAHk-=wj847SudR-kt+46fT3+xFFgiwpgThvm7DJWGdi4cVrbnQ@mail.gmail.com/
No change to generated code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 include/linux/vmstat.h | 107 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index d6a6cf53b127..241bd0f53fb9 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -415,6 +415,78 @@ static inline void drain_zonestat(struct zone *zone,
 			struct per_cpu_zonestat *pzstats) { }
 #endif		/* CONFIG_SMP */
 
+static inline void __zone_stat_mod_folio(struct folio *folio,
+		enum zone_stat_item item, long nr)
+{
+	__mod_zone_page_state(folio_zone(folio), item, nr);
+}
+
+static inline void __zone_stat_add_folio(struct folio *folio,
+		enum zone_stat_item item)
+{
+	__mod_zone_page_state(folio_zone(folio), item, folio_nr_pages(folio));
+}
+
+static inline void __zone_stat_sub_folio(struct folio *folio,
+		enum zone_stat_item item)
+{
+	__mod_zone_page_state(folio_zone(folio), item, -folio_nr_pages(folio));
+}
+
+static inline void zone_stat_mod_folio(struct folio *folio,
+		enum zone_stat_item item, long nr)
+{
+	mod_zone_page_state(folio_zone(folio), item, nr);
+}
+
+static inline void zone_stat_add_folio(struct folio *folio,
+		enum zone_stat_item item)
+{
+	mod_zone_page_state(folio_zone(folio), item, folio_nr_pages(folio));
+}
+
+static inline void zone_stat_sub_folio(struct folio *folio,
+		enum zone_stat_item item)
+{
+	mod_zone_page_state(folio_zone(folio), item, -folio_nr_pages(folio));
+}
+
+static inline void __node_stat_mod_folio(struct folio *folio,
+		enum node_stat_item item, long nr)
+{
+	__mod_node_page_state(folio_pgdat(folio), item, nr);
+}
+
+static inline void __node_stat_add_folio(struct folio *folio,
+		enum node_stat_item item)
+{
+	__mod_node_page_state(folio_pgdat(folio), item, folio_nr_pages(folio));
+}
+
+static inline void __node_stat_sub_folio(struct folio *folio,
+		enum node_stat_item item)
+{
+	__mod_node_page_state(folio_pgdat(folio), item, -folio_nr_pages(folio));
+}
+
+static inline void node_stat_mod_folio(struct folio *folio,
+		enum node_stat_item item, long nr)
+{
+	mod_node_page_state(folio_pgdat(folio), item, nr);
+}
+
+static inline void node_stat_add_folio(struct folio *folio,
+		enum node_stat_item item)
+{
+	mod_node_page_state(folio_pgdat(folio), item, folio_nr_pages(folio));
+}
+
+static inline void node_stat_sub_folio(struct folio *folio,
+		enum node_stat_item item)
+{
+	mod_node_page_state(folio_pgdat(folio), item, -folio_nr_pages(folio));
+}
+
 static inline void __mod_zone_freepage_state(struct zone *zone, int nr_pages,
 					     int migratetype)
 {
@@ -543,6 +615,24 @@ static inline void __dec_lruvec_page_state(struct page *page,
 	__mod_lruvec_page_state(page, idx, -1);
 }
 
+static inline void __lruvec_stat_mod_folio(struct folio *folio,
+					   enum node_stat_item idx, int val)
+{
+	__mod_lruvec_page_state(&folio->page, idx, val);
+}
+
+static inline void __lruvec_stat_add_folio(struct folio *folio,
+					   enum node_stat_item idx)
+{
+	__lruvec_stat_mod_folio(folio, idx, folio_nr_pages(folio));
+}
+
+static inline void __lruvec_stat_sub_folio(struct folio *folio,
+					   enum node_stat_item idx)
+{
+	__lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
+}
+
 static inline void inc_lruvec_page_state(struct page *page,
 					 enum node_stat_item idx)
 {
@@ -555,4 +645,21 @@ static inline void dec_lruvec_page_state(struct page *page,
 	mod_lruvec_page_state(page, idx, -1);
 }
 
+static inline void lruvec_stat_mod_folio(struct folio *folio,
+					 enum node_stat_item idx, int val)
+{
+	mod_lruvec_page_state(&folio->page, idx, val);
+}
+
+static inline void lruvec_stat_add_folio(struct folio *folio,
+					 enum node_stat_item idx)
+{
+	lruvec_stat_mod_folio(folio, idx, folio_nr_pages(folio));
+}
+
+static inline void lruvec_stat_sub_folio(struct folio *folio,
+					 enum node_stat_item idx)
+{
+	lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
+}
 #endif /* _LINUX_VMSTAT_H */
-- 
2.30.2

