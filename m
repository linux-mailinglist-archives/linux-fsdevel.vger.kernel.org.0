Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32613B04AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhFVMix (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhFVMix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:38:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB68CC061574;
        Tue, 22 Jun 2021 05:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=AnIW5/160jcik/Ycnbe6tcQLFvvQg0pQ8jkgjf3oayc=; b=EJefbaF5utBjjGGIDOFMp4w/Nz
        fl+gvErU++CD5c6tnLug7F9vcMeo/zp1H79utvdGJkYqBU4RGCdsyPgpdDLzhvlN9S5z2luiY5TWo
        aVD8SalwlqBzrLDbNVuPhPD/jlgi4LZYsFf8BaZJIRGW7OjJO//PPaFHNn48KlmeKlF8iuq0HzUFd
        Cv+i4qY9LNkagn9mlyf53oRaAwNG8qHJi7rGxTjX0LknAibFhT6C7PUfabF9KIMmdzSByFq/PAdJe
        bqLO6XwCHuui6NoYxQPTwc5lmcJVdPiXqtWfbPwW4f5HlVpyPqfp8zkKVmiv2NKHoKkW75/jL1qKx
        GnsEQ+RQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvfcP-00EHdA-DK; Tue, 22 Jun 2021 12:35:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/46] mm/writeback: Change __wb_writeout_inc() to __wb_writeout_add()
Date:   Tue, 22 Jun 2021 13:15:28 +0100
Message-Id: <20210622121551.3398730-24-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622121551.3398730-1-willy@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
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
index 8079d5ef19df..dc66ff78f033 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -567,12 +567,12 @@ static unsigned long wp_next_time(unsigned long cur_time)
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
@@ -590,18 +590,18 @@ static void wb_domain_writeout_inc(struct wb_domain *dom,
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
@@ -609,7 +609,7 @@ void wb_writeout_inc(struct bdi_writeback *wb)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	__wb_writeout_inc(wb);
+	__wb_writeout_add(wb, 1);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(wb_writeout_inc);
@@ -2747,7 +2747,7 @@ int test_clear_page_writeback(struct page *page)
 				struct bdi_writeback *wb = inode_to_wb(inode);
 
 				dec_wb_stat(wb, WB_WRITEBACK);
-				__wb_writeout_inc(wb);
+				__wb_writeout_add(wb, 1);
 			}
 		}
 
-- 
2.30.2

