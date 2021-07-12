Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C31C3C4223
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhGLDpo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbhGLDpn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:45:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324E2C0613E5;
        Sun, 11 Jul 2021 20:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=t2Ue8hohe0pF6sPw264yLqtPcY2s5kqfqxUYxLR6MGU=; b=qRK/TXSkqPR9VHoJ43P3z42m3d
        iSjVZX2rkIkECG9EAxDN+nq4TiaHzOnv5hC2JZlVJ85HBqs0n7bEF+jMN+IpgLCAfU24RcHVulV7v
        U/NvQvwUQTv64im15gZOo8xbg0/M9sqsg2Uyt2wEMnBNn2mboZtU4zAlkclHL3GPIA8Zy8UcnC6Bj
        YVInFse6IUJgMQR2lnZKas6SKrcyvFp/z/QSrLSIvDU+VH2CSH09RRrs4e9zgnOIFZAXGoRpEgrRx
        Eua6JTfl3FSLwNWqAmF/4xZ4xPbl0YkyaF+3BeZAXVhgbhh40jJvMgbA4NEE1NCf5aXqeg/YrOjZq
        wfHCRZag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mp9-00GpDT-Q0; Mon, 12 Jul 2021 03:41:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 065/137] mm/writeback: Change __wb_writeout_inc() to __wb_writeout_add()
Date:   Mon, 12 Jul 2021 04:05:49 +0100
Message-Id: <20210712030701.4000097-66-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow for accounting N pages at once instead of one page at a time.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/page-writeback.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 63c0dd9f8bf7..1056ff779bfe 100644
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

