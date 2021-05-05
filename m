Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0078373F58
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbhEEQPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbhEEQPR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:15:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF99C061574;
        Wed,  5 May 2021 09:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=c2T2PlaSxh3xoS1T4IYREbul8jvjAA2s9H7C2q83KAw=; b=TCq4FXOEoskSoI96YHXI3agNy6
        ooqsELIjpoJsnAlf6MDdir6IUCT40SXvLCD8kdJnlgNdgYrsSs55N+msYGNckTH56MxffJwWYyOId
        DofbBByqbqH3qtZ0YF8NQAaAA7x26d+leNe9dPKYvwfgclIPeXQh+YIwCNwby0ahOJKuwzggx/UCn
        j3T1FLtG81pS/W0KXN+TEPDxK7O4jI30b9qE5EhJWbwrUOWXqnX0nBHEQ1slRG1CBoeeCxbQrxBlq
        EW//OK6LWbGk1aFd1TrhYLGTuu3naMszdA5eMP+GudxkrvQMIFjASUcKpnRAmS5efXNHtZjbEL91K
        twR7QnjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leK95-000ZWD-GT; Wed, 05 May 2021 16:13:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 55/96] flex_proportions: Allow N events instead of 1
Date:   Wed,  5 May 2021 16:05:47 +0100
Message-Id: <20210505150628.111735-56-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
index 157ed52e4b7d..764e92bd9014 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -572,8 +572,8 @@ static void wb_domain_writeout_inc(struct wb_domain *dom,
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

