Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A93373F5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbhEEQQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbhEEQQi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:16:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3FEC061574;
        Wed,  5 May 2021 09:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6ySUgGIK//1XyPAJLykpgI+hzQvxV3K74pGhbXeFMbQ=; b=WfEvDKmOYKNxdyHMUWorpwpLLZ
        VDOq85cEZLX3eqOdLfJja+O1Ha5LNo8Cli/yrmlLNUPYIosszT525sb3Ze+5iMPEsx0jp1HsORaZt
        suqnBCfiXQzIvxnZpAFHPJAxOhG2kKBEFJhc1+WqVW7RPLNSp7ihjqO3EutPIGwPeA31N/thu9SQs
        3JWDEVoPBAtxRA+Qmgi/rV83ynplpQAC8YRoMF2vRHExBJwAmRGEnF077dF6qX2w/C/5nn2xubuX8
        jTN076AzpbuuA8YeFtmT5uMzCicEisP+IwRwvZqTJ4gIbP/lXNeuhJMJW6PalH7A1ieJRZQPu8j4V
        sY3+o83w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leK9j-000ZZE-D4; Wed, 05 May 2021 16:13:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 56/96] mm/writeback: Change __wb_writeout_inc to __wb_writeout_add
Date:   Wed,  5 May 2021 16:05:48 +0100
Message-Id: <20210505150628.111735-57-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow for accounting N pages at once instead of one page at a time.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 764e92bd9014..98efb3fc6466 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -568,12 +568,12 @@ static unsigned long wp_next_time(unsigned long cur_time)
 	return cur_time;
 }
 
-static void wb_domain_writeout_inc(struct wb_domain *dom,
+static void wb_domain_writeout_add(struct wb_domain *dom,
 				   struct fprop_local_percpu *completions,
-				   unsigned int max_prop_frac)
+				   unsigned int max_prop_frac, long nr)
 {
 	__fprop_add_percpu_max(&dom->completions, completions,
-			       max_prop_frac, 1);
+			       max_prop_frac, nr);
 	/* First event after period switching was turned off? */
 	if (unlikely(!dom->period_time)) {
 		/*
@@ -591,18 +591,18 @@ static void wb_domain_writeout_inc(struct wb_domain *dom,
  * Increment @wb's writeout completion count and the global writeout
  * completion count. Called from test_clear_page_writeback().
  */
-static inline void __wb_writeout_inc(struct bdi_writeback *wb)
+static inline void __wb_writeout_add(struct bdi_writeback *wb, long nr)
 {
 	struct wb_domain *cgdom;
 
-	inc_wb_stat(wb, WB_WRITTEN);
-	wb_domain_writeout_inc(&global_wb_domain, &wb->completions,
-			       wb->bdi->max_prop_frac);
+	wb_stat_mod(wb, WB_WRITTEN, nr);
+	wb_domain_writeout_add(&global_wb_domain, &wb->completions,
+			       wb->bdi->max_prop_frac, nr);
 
 	cgdom = mem_cgroup_wb_domain(wb);
 	if (cgdom)
-		wb_domain_writeout_inc(cgdom, wb_memcg_completions(wb),
-				       wb->bdi->max_prop_frac);
+		wb_domain_writeout_add(cgdom, wb_memcg_completions(wb),
+				       wb->bdi->max_prop_frac, nr);
 }
 
 void wb_writeout_inc(struct bdi_writeback *wb)
@@ -610,7 +610,7 @@ void wb_writeout_inc(struct bdi_writeback *wb)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	__wb_writeout_inc(wb);
+	__wb_writeout_add(wb, 1);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(wb_writeout_inc);
@@ -2739,7 +2739,7 @@ int test_clear_page_writeback(struct page *page)
 				struct bdi_writeback *wb = inode_to_wb(inode);
 
 				dec_wb_stat(wb, WB_WRITEBACK);
-				__wb_writeout_inc(wb);
+				__wb_writeout_add(wb, 1);
 			}
 		}
 
-- 
2.30.2

