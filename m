Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97562EB5B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 00:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbhAEXAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 18:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731729AbhAEXAU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 18:00:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD77EC061793;
        Tue,  5 Jan 2021 14:59:08 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v1so549789pjr.2;
        Tue, 05 Jan 2021 14:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/w8zHA39ZxWTccojV8sgLaQmxN/C0nsAOHnTjuJkkjk=;
        b=pKw4juce56d+GBEmByu2Qylqs4jJTT/Le0PivjE/+r/aD5Wxc44Wei78Nv3+gdnxqw
         MNjdwru+fxvfv4VCkLlnVImf7Is22pfli8p+jUrXFtnRkfq+B062VnccJtCfaSXy/RVC
         5o/4rF3m9fuN2aIAKlIIfOKPOtKlQb2msBauxqK2Y/NQpzwr09sJG18Dzfp7vcIffN7n
         Xi3fPh4AcChPjKv/Gk46xGLEESYyN0XGD+JJ7V0nVOThUhBAJdVvMVzvs9p5g4FFb8zl
         xbITy9vE6FiQFC8FqKAdZsmeHz6EB6mCwCv40mHC2wllatjZkSUMIXy2HED4VzxNyrlY
         8MYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/w8zHA39ZxWTccojV8sgLaQmxN/C0nsAOHnTjuJkkjk=;
        b=EON5FJaTc1J1Dr8wR+plpx/VBG654OjGmxNHJqEiTD3+7eGYLYwe4/9zz/HdfTETFq
         IHvClYF0tfq9OziHgEHR2a9g2DQIqHj2UKYA3bYABPE/ZLWF6q0gwi5OUVwnqAfKpQYH
         Dscsj0UrFwOQCLNi6KtLfwOgj+OcYindAF8U4wJRSGbmnVUIGerR5SFm6P8qU476gtsc
         TSe2a/Jh5iyKL4Fql4/mbJXK6qHmpQCQI9Zlk2qakCbuzaHGte8wOQLw8hiHc4RREEA2
         CeceQ/zS/r7xF+nyHhBVSdRkm8nYMVRbvUy4ccc5ck99R1xvv59sVAltypffQgWEnmqT
         xbBg==
X-Gm-Message-State: AOAM532iKWaMPa3WSnB6zvRu1JhluwygPnO5235aKV0C5g5Uvwf3fCgP
        6SbL45UObFVJTBmnXNyrURg=
X-Google-Smtp-Source: ABdhPJxcHNSPb1E7+FuR9nJPd1obGqKUl+cSei//usANPGUrV3vQhFy/nLBh6vsG4MmdfaYibgjhHA==
X-Received: by 2002:a17:902:ee52:b029:da:4dee:1a54 with SMTP id 18-20020a170902ee52b02900da4dee1a54mr1306441plo.29.1609887548434;
        Tue, 05 Jan 2021 14:59:08 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id fw12sm244233pjb.43.2021.01.05.14.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 14:59:07 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 11/11] mm: vmscan: shrink deferred objects proportional to priority
Date:   Tue,  5 Jan 2021 14:58:17 -0800
Message-Id: <20210105225817.1036378-12-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210105225817.1036378-1-shy828301@gmail.com>
References: <20210105225817.1036378-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The number of deferred objects might get windup to an absurd number, and it results in
clamp of slab objects.  It is undesirable for sustaining workingset.

So shrink deferred objects proportional to priority and cap nr_deferred to twice of
cache items.

The idea is borrowed fron Dave Chinner's patch:
https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/

Tested with kernel build and vfs metadata heavy workload, no regression is spotted
so far.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 40 +++++-----------------------------------
 1 file changed, 5 insertions(+), 35 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 71056057d26d..6832f1d24d2b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -671,7 +671,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 */
 	nr = count_nr_deferred(shrinker, shrinkctl);
 
-	total_scan = nr;
 	if (shrinker->seeks) {
 		delta = freeable >> priority;
 		delta *= 4;
@@ -685,37 +684,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
@@ -754,10 +725,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		cond_resched();
 	}
 
-	if (next_deferred >= scanned)
-		next_deferred -= scanned;
-	else
-		next_deferred = 0;
+	next_deferred = max_t(long, (nr - scanned), 0) + total_scan;
+	next_deferred = min(next_deferred, (2 * freeable));
+
 	/*
 	 * move the unused scan count back into the shrinker in a
 	 * manner that handles concurrent updates.
-- 
2.26.2

