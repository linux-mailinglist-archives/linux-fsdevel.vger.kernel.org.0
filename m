Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D623C421F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhGLDpG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbhGLDpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:45:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76F3C0613DD;
        Sun, 11 Jul 2021 20:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UnDDbhEQMea2tvMI1qXkB0SWNo8nHGa0hDE1opkln5o=; b=gopST4/yM9LOmOhMED9ru1bI1x
        H3wEtWsF2byI24SU+eF5O4COTCc1NmC69z/dljMeBcnnzbYqOIoulZ/EHp7NUKH82NV6wwhrZTwuS
        ACkob489gb2jc3gPTqdKYIARoRnAm3ry174sXNgH3kYW/TPnGFwxwqQN356RktjmLqOU2aAv/kdzw
        CBCMINgy8oNxIFMuhMMB6zVCvt9ExH/yIG3OovJVDR302pqsM6cynOWPCpOf1m0XCMK36wH4xvlob
        Swz6r2E6Y1ld4JJ30phaI0epzYA3sdY1toG1CS/FUy7XNC4Re/YUHvkoiNZJCPVTub0c90v6yWqNM
        KVXx3qpg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2moc-00GpBE-Uw; Mon, 12 Jul 2021 03:41:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 064/137] flex_proportions: Allow N events instead of 1
Date:   Mon, 12 Jul 2021 04:05:48 +0100
Message-Id: <20210712030701.4000097-65-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When batching events (such as writing back N pages in a single I/O), it
is better to do one flex_proportion operation instead of N.  There is
only one caller of __fprop_inc_percpu_max(), and it's the one we're
going to change in the next patch, so rename it instead of adding a
compatibility wrapper.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/flex_proportions.h |  9 +++++----
 lib/flex_proportions.c           | 28 +++++++++++++++++++---------
 mm/page-writeback.c              |  4 ++--
 3 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/include/linux/flex_proportions.h b/include/linux/flex_proportions.h
index c12df59d3f5f..3e378b1fb0bc 100644
--- a/include/linux/flex_proportions.h
+++ b/include/linux/flex_proportions.h
@@ -83,9 +83,10 @@ struct fprop_local_percpu {
 
 int fprop_local_init_percpu(struct fprop_local_percpu *pl, gfp_t gfp);
 void fprop_local_destroy_percpu(struct fprop_local_percpu *pl);
-void __fprop_inc_percpu(struct fprop_global *p, struct fprop_local_percpu *pl);
-void __fprop_inc_percpu_max(struct fprop_global *p, struct fprop_local_percpu *pl,
-			    int max_frac);
+void __fprop_add_percpu(struct fprop_global *p, struct fprop_local_percpu *pl,
+		long nr);
+void __fprop_add_percpu_max(struct fprop_global *p,
+		struct fprop_local_percpu *pl, int max_frac, long nr);
 void fprop_fraction_percpu(struct fprop_global *p,
 	struct fprop_local_percpu *pl, unsigned long *numerator,
 	unsigned long *denominator);
@@ -96,7 +97,7 @@ void fprop_inc_percpu(struct fprop_global *p, struct fprop_local_percpu *pl)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	__fprop_inc_percpu(p, pl);
+	__fprop_add_percpu(p, pl, 1);
 	local_irq_restore(flags);
 }
 
diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
index 451543937524..53e7eb1dd76c 100644
--- a/lib/flex_proportions.c
+++ b/lib/flex_proportions.c
@@ -217,11 +217,12 @@ static void fprop_reflect_period_percpu(struct fprop_global *p,
 }
 
 /* Event of type pl happened */
-void __fprop_inc_percpu(struct fprop_global *p, struct fprop_local_percpu *pl)
+void __fprop_add_percpu(struct fprop_global *p, struct fprop_local_percpu *pl,
+		long nr)
 {
 	fprop_reflect_period_percpu(p, pl);
-	percpu_counter_add_batch(&pl->events, 1, PROP_BATCH);
-	percpu_counter_add(&p->events, 1);
+	percpu_counter_add_batch(&pl->events, nr, PROP_BATCH);
+	percpu_counter_add(&p->events, nr);
 }
 
 void fprop_fraction_percpu(struct fprop_global *p,
@@ -253,20 +254,29 @@ void fprop_fraction_percpu(struct fprop_global *p,
 }
 
 /*
- * Like __fprop_inc_percpu() except that event is counted only if the given
+ * Like __fprop_add_percpu() except that event is counted only if the given
  * type has fraction smaller than @max_frac/FPROP_FRAC_BASE
  */
-void __fprop_inc_percpu_max(struct fprop_global *p,
-			    struct fprop_local_percpu *pl, int max_frac)
+void __fprop_add_percpu_max(struct fprop_global *p,
+		struct fprop_local_percpu *pl, int max_frac, long nr)
 {
 	if (unlikely(max_frac < FPROP_FRAC_BASE)) {
 		unsigned long numerator, denominator;
+		s64 tmp;
 
 		fprop_fraction_percpu(p, pl, &numerator, &denominator);
-		if (numerator >
-		    (((u64)denominator) * max_frac) >> FPROP_FRAC_SHIFT)
+		/* Adding 'nr' to fraction exceeds max_frac/FPROP_FRAC_BASE? */
+		tmp = (u64)denominator * max_frac -
+					((u64)numerator << FPROP_FRAC_SHIFT);
+		if (tmp < 0) {
+			/* Maximum fraction already exceeded? */
 			return;
+		} else if (tmp < nr * (FPROP_FRAC_BASE - max_frac)) {
+			/* Add just enough for the fraction to saturate */
+			nr = div_u64(tmp + FPROP_FRAC_BASE - max_frac - 1,
+					FPROP_FRAC_BASE - max_frac);
+		}
 	}
 
-	__fprop_inc_percpu(p, pl);
+	__fprop_add_percpu(p, pl, nr);
 }
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e677e79c7b9b..63c0dd9f8bf7 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -566,8 +566,8 @@ static void wb_domain_writeout_inc(struct wb_domain *dom,
 				   struct fprop_local_percpu *completions,
 				   unsigned int max_prop_frac)
 {
-	__fprop_inc_percpu_max(&dom->completions, completions,
-			       max_prop_frac);
+	__fprop_add_percpu_max(&dom->completions, completions,
+			       max_prop_frac, 1);
 	/* First event after period switching was turned off? */
 	if (unlikely(!dom->period_time)) {
 		/*
-- 
2.30.2

