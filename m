Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4BB3C9777
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbhGOEcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbhGOEcx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:32:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C28C06175F;
        Wed, 14 Jul 2021 21:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=giKDflwn+RmAPKF9gNtahm1hPB6l329Z4O/Dgj1Q+Z8=; b=CEqWNbQgkocoT/XSJy7r3ZluiU
        sr2T1N+bQY25ZBs9quL4WbiPCW100qmOJ+O576mHt/YpVTddZBw6YVjyU0Wp8t8hmC5O5RtYJZzSQ
        nGx1g+ahpQjdYGmSEwkN1MBcqFrj+30wfDUrVazjyd9xBeyRgP+79ENPVwvMyMsX0Ghtt3Mx6eKaz
        Jwkzci2zZvmRcVg5Lm0SSYNCj+Wetd0bLkj5Eo6KuCVQArKTUuTXpFMkCcyYWdYrVpzj6Y6wUXUZh
        dDdioCffnCsKWmS5KdViDKDj55t2Kky2bim6wPWTGBSuDB+mWx4sc3MWhPRbzz6WZwRrs9tatlvUH
        GEFw8IBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3szM-002xXf-8L; Thu, 15 Jul 2021 04:28:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: [PATCH v14 065/138] mm/writeback: Change __wb_writeout_inc() to __wb_writeout_add()
Date:   Thu, 15 Jul 2021 04:35:51 +0100
Message-Id: <20210715033704.692967-66-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow for accounting N pages at once instead of one page at a time.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 mm/page-writeback.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index f55f2ebdd9a9..e542ea37d605 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -562,12 +562,12 @@ static unsigned long wp_next_time(unsigned long cur_time)
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
@@ -585,18 +585,18 @@ static void wb_domain_writeout_inc(struct wb_domain *dom,
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
@@ -604,7 +604,7 @@ void wb_writeout_inc(struct bdi_writeback *wb)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	__wb_writeout_inc(wb);
+	__wb_writeout_add(wb, 1);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(wb_writeout_inc);
@@ -2751,7 +2751,7 @@ int test_clear_page_writeback(struct page *page)
 				struct bdi_writeback *wb = inode_to_wb(inode);
 
 				dec_wb_stat(wb, WB_WRITEBACK);
-				__wb_writeout_inc(wb);
+				__wb_writeout_add(wb, 1);
 			}
 		}
 
-- 
2.30.2

