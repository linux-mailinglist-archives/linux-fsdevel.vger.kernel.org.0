Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F4F337D4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 20:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhCKTJv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 14:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhCKTJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:09:28 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F179CC061574;
        Thu, 11 Mar 2021 11:09:27 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id p21so14283309pgl.12;
        Thu, 11 Mar 2021 11:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EGK/9wMv8jRkB25hW3W7zHOqmtj2V0f0Nz5E9gUfq7E=;
        b=ruApEZXuvYHuRSS42zVIXrt9gJn10TsmfS0rhjKeh7yTcyMqOtl+EUi621sWLY3dre
         JeLTadgUNwsgqpPn2aJrvqDzLnXySmAWzha19/qTRCmT0xHyh1WuhXdQpSIysjiUKTKV
         F4ShMw4xHCgAc1jmekBhITwEAR07rska7p6IgcsYESGaTX6NpLcQTE708grIJflhLBQk
         urtp6/waSHfkEb2Pz/w6zSGviQxZc+zw5JPdO9L4+q5QeSUIScgmLd0g65+QkyHuvM/F
         8yZpU8GH3N4MLvLnAtlV8qvp7VWvd5rbMz9MtLhgCwr2+TD9hjppVEbgOxLBShEunfr4
         F1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGK/9wMv8jRkB25hW3W7zHOqmtj2V0f0Nz5E9gUfq7E=;
        b=YEvF7oVuHv8Sk7hE93MYiHzy9BHmQifJFcnKjoYeIwzl01sW9YGReZgEZO4f3KAB+n
         s6kzJb0Ou/MXnv9T8mWedlBk33g/alBKvNY8Z4k174sbWLeTxYynkAxkESU70bFNm+i5
         bvD2+K8f697btghznhrvbBVCIrigsFuuAvoL+ZkddE2Fm795EGJW8z1WBhGi5BsXFQsh
         BBBQJecwp8J66T6GGrmNoWdaIgoUQm3z8B87X9455/LWM5qOq06txxSIbzE6PdZZKQIj
         QsKPde6Bj141L/OOOTBwuKHLOWEOj+yzrIcZRCpVV0ABhxxUnauZ4usr/Af4squMlgfT
         zfrw==
X-Gm-Message-State: AOAM532Arwd3O+w8pZHeOsfqiaBiG9dft4kPq9j5FcBAAJT4fUiQY8Bu
        9+mZQL8nhL2JKVIPvWpHiDk=
X-Google-Smtp-Source: ABdhPJzYGwUvbjrr9D3b2YYS9YyC7I1ThLnks5DFJYnKtTpSfEdsyC9fjHwBMOZQXfqjjGMp8cSnLw==
X-Received: by 2002:a63:1343:: with SMTP id 3mr8397519pgt.166.1615489767493;
        Thu, 11 Mar 2021 11:09:27 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id t12sm2999111pfe.203.2021.03.11.11.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:09:26 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v10 PATCH 13/13] mm: vmscan: shrink deferred objects proportional to priority
Date:   Thu, 11 Mar 2021 11:08:45 -0800
Message-Id: <20210311190845.9708-14-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210311190845.9708-1-shy828301@gmail.com>
References: <20210311190845.9708-1-shy828301@gmail.com>
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
index d0791ebd6761..163616e78a4e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -664,7 +664,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 */
 	nr = xchg_nr_deferred(shrinker, shrinkctl);
 
-	total_scan = nr;
 	if (shrinker->seeks) {
 		delta = freeable >> priority;
 		delta *= 4;
@@ -678,37 +677,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
@@ -747,10 +718,15 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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

