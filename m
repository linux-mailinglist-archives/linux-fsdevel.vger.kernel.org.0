Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BA030E0DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 18:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhBCRXF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 12:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhBCRWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:22:20 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A587FC0617A9;
        Wed,  3 Feb 2021 09:21:34 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s23so162187pgh.11;
        Wed, 03 Feb 2021 09:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WjCWNWtT0pxxhAlETV2zIWjv0Gl4p3lxrm3/RhLgkFI=;
        b=WOTROWby4+O9mii6I9VKEbRf1e0JneRRZWuOzB+sxeZyY83rimGnXwHvmaiAJl950J
         UC1zbSHRcY3mTA7B7y5OXXYbolcIsJvey4DCBh5Rx9c8WPmcnqZ8EoMX7SoBo1/dBquC
         tR1gRLP/wJVJIFcmMJeEliFw3zJ+c6urFzhFbDBrToGBAXbPykkH8hZXQzmV8T5PwuOV
         ZTYQ445OhWUCveVh+i5qqcAGuex8IQZuctk9F/8j9ZQF2vUTFLPiSFOGi51pyiuqTTet
         1cWjwGBAO9noeYyjswJyg79dR8Ck0twVz5IdcPGwpVR02yX8Xg1W8CbhBOQe0PhHS1mv
         Occg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WjCWNWtT0pxxhAlETV2zIWjv0Gl4p3lxrm3/RhLgkFI=;
        b=G8F28NA3U3XF/dvNrsgU7LSeW4dV+0CLzUiQhTHeOSvy+/T3sDHoDA1C0sqoDrJMf/
         qnRp6wy9MxfovD73VZJrv0LKZm6IrYjW8e4S6Ct0Mm5LBxqFIENNnO+WrFQds5xBnLCH
         XyQVgIk6JE+VhF4u6i1BriEWDuSfiCzo1WTBUOwL+nbpm5bU4gsc9M2EqKxVzBHXHb8R
         /BVJGB23ZX69ZhgWHIB4lJQKm1agCvWxi8qg8z7amDhxXeow6PV7Rrhi4617HEDb7cZN
         8KbpBAGpEe/l8mG0FYqrETNLYCYAFljfkBqn4x0X8lKS36lWTV8PynpH55mGtiEgYw+C
         eQ4A==
X-Gm-Message-State: AOAM5327trkusBOnQClUKH73hWrFfVjrRESP5zni4D6ps+ZgF283sclP
        qzo0RZTcLV8EcK+cabtcmGU=
X-Google-Smtp-Source: ABdhPJzqcaYYDKlp3sUAGpXDR3SSEmVgbvV1MQeGqx85pwWP5dg6r1K9s1IWZLx1A1HO79RYXirMpQ==
X-Received: by 2002:a62:760b:0:b029:1b6:3897:3f86 with SMTP id r11-20020a62760b0000b02901b638973f86mr3803216pfc.24.1612372894244;
        Wed, 03 Feb 2021 09:21:34 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x21sm2368636pfn.100.2021.02.03.09.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 09:21:32 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v6 PATCH 11/11] mm: vmscan: shrink deferred objects proportional to priority
Date:   Wed,  3 Feb 2021 09:20:42 -0800
Message-Id: <20210203172042.800474-12-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203172042.800474-1-shy828301@gmail.com>
References: <20210203172042.800474-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The number of deferred objects might get windup to an absurd number, and it
results in clamp of slab objects.  It is undesirable for sustaining workingset.

So shrink deferred objects proportional to priority and cap nr_deferred to twice
of cache items.

The idea is borrowed fron Dave Chinner's patch:
https://lore.kernel.org/linux-xfs/20191031234618.15403-13-david@fromorbit.com/

Tested with kernel build and vfs metadata heavy workload in our production
environment, no regression is spotted so far.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 40 +++++-----------------------------------
 1 file changed, 5 insertions(+), 35 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 574d920c4cab..d0a86170854b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -649,7 +649,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 */
 	nr = count_nr_deferred(shrinker, shrinkctl);
 
-	total_scan = nr;
 	if (shrinker->seeks) {
 		delta = freeable >> priority;
 		delta *= 4;
@@ -663,37 +662,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
@@ -732,10 +703,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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

