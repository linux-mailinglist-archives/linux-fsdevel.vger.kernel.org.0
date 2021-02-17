Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F4431D352
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 01:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhBQAP4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 19:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhBQAPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 19:15:11 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31336C0617AA;
        Tue, 16 Feb 2021 16:13:58 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z6so7264130pfq.0;
        Tue, 16 Feb 2021 16:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3hgH+28WYE3ZXoblhdSElWyJzRaS9xgsMhEuGQG4Ck=;
        b=QMtwxddL/Doi8ti3RVqupaiMXJnaV9oGrObTbm+fsfP+CLJwAhTg4H2cVedturf5DV
         zxMhDQidZP6zDkrUwUy3kcfi15WIvwH1mEzbKU7Ans11F5RGcUqAjy0++7ZCS1Fbt7UR
         Y6Ivl518m6sTiAbBGyoEKpHzsD2kY7Q4DVKMy1qWplkTEvLvyjpv9y5gW4RWppP6eE4M
         bzVo3X+si5N15PafDj0vU/TQRrW9QAKXgxtiKEJZcZ6m0SjlfAJ6KPp7s3soh2rRiMLJ
         MEcAAAj9p+wWS6Sck1vMJ3xrRtpHGXpntrpfA1T6vI15ZY7v+XbVstR+0U155i9htOoU
         brvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l3hgH+28WYE3ZXoblhdSElWyJzRaS9xgsMhEuGQG4Ck=;
        b=IUwmvcJAXvVGylakpi2Ii+uJ43eqr3Nn8exWY36R61FXR2hplqq4/PiB5C4AhR/GYN
         Pk1TVONH2LwIA5EisaBbly1H22GYURrZuOKcsb048G5ETcuReubcz/ti0fIiFXO/Ry3W
         byjU1XlLJ6m7Nww0p2en3qnC3D17fGyquYMx+1J7GZHoynQsHr7U2Vpjbw6BWimjt9hj
         lyGiutSFx6R+0ySSajkYF8Xo+Yg6ysONiDn5fcQ3bwx+rLB5HjiWJz7s2IEfYGU+Pwvr
         XmcEjilB4AsBgeCQKmcHdeygM4jwd2jt6uf71Wh36CgL26TLQXlW4lVT2st3Y/VRQu4S
         BQjQ==
X-Gm-Message-State: AOAM533erk0Dhl/RIO/GNfsgH3AgDygGuSXGtN3F5wlfSobarg9K0H7Z
        vBdQZw22Ds9Mp0LSu2VEjuc=
X-Google-Smtp-Source: ABdhPJzDqnLKOjhckWkxEnIUdYEfij0kOz6DzuqxoZpDS+iPjz7y/hkLXnRk9SrvxZKe5UMlLh6QPA==
X-Received: by 2002:aa7:888b:0:b029:1ec:df4a:4da2 with SMTP id z11-20020aa7888b0000b02901ecdf4a4da2mr14656pfe.66.1613520837746;
        Tue, 16 Feb 2021 16:13:57 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y12sm99220pjc.56.2021.02.16.16.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 16:13:56 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v8 PATCH 13/13] mm: vmscan: shrink deferred objects proportional to priority
Date:   Tue, 16 Feb 2021 16:13:22 -0800
Message-Id: <20210217001322.2226796-14-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217001322.2226796-1-shy828301@gmail.com>
References: <20210217001322.2226796-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The number of deferred objects might get windup to an absurd number, and it
results in clamp of slab objects.  It is undesirable for sustaining workingset.

So shrink deferred objects proportional to priority and cap nr_deferred to twice
of cache items.

The idea is borrowed from Dave Chinner's patch:
https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/

Tested with kernel build and vfs metadata heavy workload in our production
environment, no regression is spotted so far.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 46 +++++++++++-----------------------------------
 1 file changed, 11 insertions(+), 35 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4247a3568585..b3bdc3ba8edc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -661,7 +661,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 */
 	nr = xchg_nr_deferred(shrinker, shrinkctl);
 
-	total_scan = nr;
 	if (shrinker->seeks) {
 		delta = freeable >> priority;
 		delta *= 4;
@@ -675,37 +674,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		delta = freeable / 2;
 	}
 
+	total_scan = nr >> priority;
 	total_scan += delta;
-	if (total_scan < 0) {
-		pr_err("shrink_slab: %pS negative objects to delete nr=%ld\n",
-		       shrinker->scan_objects, total_scan);
-		total_scan = freeable;
-		next_deferred = nr;
-	} else
-		next_deferred = total_scan;
-
-	/*
-	 * We need to avoid excessive windup on filesystem shrinkers
-	 * due to large numbers of GFP_NOFS allocations causing the
-	 * shrinkers to return -1 all the time. This results in a large
-	 * nr being built up so when a shrink that can do some work
-	 * comes along it empties the entire cache due to nr >>>
-	 * freeable. This is bad for sustaining a working set in
-	 * memory.
-	 *
-	 * Hence only allow the shrinker to scan the entire cache when
-	 * a large delta change is calculated directly.
-	 */
-	if (delta < freeable / 4)
-		total_scan = min(total_scan, freeable / 2);
-
-	/*
-	 * Avoid risking looping forever due to too large nr value:
-	 * never try to free more than twice the estimate number of
-	 * freeable entries.
-	 */
-	if (total_scan > freeable * 2)
-		total_scan = freeable * 2;
+	total_scan = min(total_scan, (2 * freeable));
 
 	trace_mm_shrink_slab_start(shrinker, shrinkctl, nr,
 				   freeable, delta, total_scan, priority);
@@ -744,10 +715,15 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		cond_resched();
 	}
 
-	if (next_deferred >= scanned)
-		next_deferred -= scanned;
-	else
-		next_deferred = 0;
+	/*
+	 * The deferred work is increased by any new work (delta) that wasn't
+	 * done, decreased by old deferred work that was done now.
+	 *
+	 * And it is capped to two times of the freeable items.
+	 */
+	next_deferred = max_t(long, (nr + delta - scanned), 0);
+	next_deferred = min(next_deferred, (2 * freeable));
+
 	/*
 	 * move the unused scan count back into the shrinker in a
 	 * manner that handles concurrent updates.
-- 
2.26.2

