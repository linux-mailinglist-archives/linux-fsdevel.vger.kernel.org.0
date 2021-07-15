Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9204F3C9771
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbhGOEck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbhGOEcd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:32:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68BBC06175F;
        Wed, 14 Jul 2021 21:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aqelWOdE9he82qcK+Xkgh5XZDZXAn149Pewl+8PCiDw=; b=RVkBmvRsI+PUyfpGcXKHF4oyS5
        xTKTbgnUaHtGz9M3MFuTcd5MN3i1YyMicq8j9Y0Jti0BETqx1XUuFfMGHlAaW3LcKvdg243L04n+L
        f8snDymJXTPcBxwLAn4eTaXy/zpkaBpDe+c1bb7pkeOZmUx13grS/rcUpdYVNZwYeTdndW++0MnlH
        WsqmM0AuiCwMczaBdudRhTlQhocnhjd3BZydK1hmajernSTb3SEH3o7QDbFf6U2GzxtfTFePa3m7B
        FIMevDqfRx9pD8eNrOUjhGgNnvB/6IQaZnI9VvsKUiu5d+D1nQqHoVX17UCm1r6UNtVkgtzrQ5mEc
        5Jg8aZOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3syg-002xU5-DN; Thu, 15 Jul 2021 04:28:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: [PATCH v14 064/138] flex_proportions: Allow N events instead of 1
Date:   Thu, 15 Jul 2021 04:35:50 +0100
Message-Id: <20210715033704.692967-65-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
Reviewed-by: Jan Kara <jack@suse.cz>
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
index b34278d05395..f55f2ebdd9a9 100644
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

