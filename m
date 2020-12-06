Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8562D01DB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 09:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgLFIcu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 03:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgLFIct (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 03:32:49 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB8DC061A56
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 00:31:39 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id m9so6375363pgb.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 00:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jxjzCofAcULr7bnQMbpOvZCW6tNXMo722rzO5X3X+g0=;
        b=wNv4qDSehcayO/ihogNTwYkGmNfh5RiiwJJPy5Ul8/X5rRuoAcaO9IWiT/zhh7c3zE
         DkQdTnRVChsF0HNvUG0ZpVzWqoGDxZHC6UdxNFd1esXfxLRYG5JPaZt/ehJmxRKGxRcy
         j2K7ImVTdAGGUwQzHwmDDriZDLsK3oJ2kzyams7iLzW6JmsFMSnV6U0Q5tVhmTk88NLQ
         P1mxFKPCxWivQAZSOj3l5kb7OdCK33TsD2BMo7RzFcUXbMtYUb38SlvmlQtvx8PkvIV3
         EV0/A75iolf7+KiwyhLHgs4vUFCGQa7dSkHBYsNwoQvuzRX5BJsEWtgU5PNGExnjgrB6
         0zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jxjzCofAcULr7bnQMbpOvZCW6tNXMo722rzO5X3X+g0=;
        b=Dwwrgp/+kEbLpbQzUK2dDFYYLzqrCydzcIVQOq8rTTihydJoOrqletPuGxi9IULmRY
         2lFdQ0BgXjDzm+5LZPXMGTSO3QpT43gfFCdZzQYhD8yAN06sF8iWSsqYTVgemYOQjmau
         i4dQwwKz9KGsR6POYDkdGMvfrz1kAWO8RJKe9KzZlDaAsst+c+LbT7INo/OPZzEZtioZ
         RJTnbRTlZCtEltsI0DtgyzEkkbGaMpCL/BwskCWl4QETzrB/WJLoQhX/N6QTfYwb/1/Q
         9J3NdQs4Fk9BUAUm6smCAkuP+70NlmjGaMwSTA6WbEApipoKbjHwggB1P3w/gyQcRYV/
         TGug==
X-Gm-Message-State: AOAM533rfYNLfdlI78raSS0U5Py0jtoJlA3xQRaUoWz/YCHa+2kLesLL
        DlEuXDZ4kqW5l05sv+a/fH/EtA==
X-Google-Smtp-Source: ABdhPJwo9cB+Tm2M3Iwyh9yt/rFYa5lNsd3ZIr0YFpCtVd3XQ5n1KNw6GWOLG8mW/TLUg0oyOGP4rA==
X-Received: by 2002:a62:ab0f:0:b029:197:f771:fe8e with SMTP id p15-20020a62ab0f0000b0290197f771fe8emr11234671pff.65.1607243498804;
        Sun, 06 Dec 2020 00:31:38 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id c2sm10229107pfa.59.2020.12.06.00.31.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 00:31:38 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 09/12] mm: memcontrol: convert vmstat slab counters to bytes
Date:   Sun,  6 Dec 2020 16:29:45 +0800
Message-Id: <20201206082948.11812-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206082948.11812-1-songmuchun@bytedance.com>
References: <20201206082948.11812-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

the global and per-node counters are stored in pages, however memcg
and lruvec counters are stored in bytes. This scheme looks weird.
So convert all vmstat slab counters to bytes.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/vmstat.h | 17 ++++++++++-------
 mm/vmstat.c            | 21 ++++++++++-----------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 322dcbfcc933..fd1a3d5d4926 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -197,18 +197,26 @@ static inline
 unsigned long global_node_page_state_pages(enum node_stat_item item)
 {
 	long x = atomic_long_read(&vm_node_stat[item]);
+
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
 #endif
+	if (vmstat_item_in_bytes(item))
+		x >>= PAGE_SHIFT;
 	return x;
 }
 
 static inline unsigned long global_node_page_state(enum node_stat_item item)
 {
-	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
+	long x = atomic_long_read(&vm_node_stat[item]);
 
-	return global_node_page_state_pages(item);
+	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
+#ifdef CONFIG_SMP
+	if (x < 0)
+		x = 0;
+#endif
+	return x;
 }
 
 static inline unsigned long zone_page_state(struct zone *zone,
@@ -312,11 +320,6 @@ static inline void __mod_zone_page_state(struct zone *zone,
 static inline void __mod_node_page_state(struct pglist_data *pgdat,
 			enum node_stat_item item, int delta)
 {
-	if (vmstat_item_in_bytes(item)) {
-		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
-		delta >>= PAGE_SHIFT;
-	}
-
 	node_page_state_add(delta, pgdat, item);
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8d77ee426e22..7fb0c7cb9516 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -345,11 +345,6 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 	long x;
 	long t;
 
-	if (vmstat_item_in_bytes(item)) {
-		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
-		delta >>= PAGE_SHIFT;
-	}
-
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -554,11 +549,6 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 	s8 __percpu *p = pcp->vm_node_stat_diff + item;
 	long o, n, t, z;
 
-	if (vmstat_item_in_bytes(item)) {
-		VM_WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
-		delta >>= PAGE_SHIFT;
-	}
-
 	do {
 		z = 0;  /* overflow to node counters */
 
@@ -1012,19 +1002,28 @@ unsigned long node_page_state_pages(struct pglist_data *pgdat,
 				    enum node_stat_item item)
 {
 	long x = atomic_long_read(&pgdat->vm_stat[item]);
+
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
 #endif
+	if (vmstat_item_in_bytes(item))
+		x >>= PAGE_SHIFT;
 	return x;
 }
 
 unsigned long node_page_state(struct pglist_data *pgdat,
 			      enum node_stat_item item)
 {
+	long x = atomic_long_read(&pgdat->vm_stat[item]);
+
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
-	return node_page_state_pages(pgdat, item);
+#ifdef CONFIG_SMP
+	if (x < 0)
+		x = 0;
+#endif
+	return x;
 }
 #endif
 
-- 
2.11.0

