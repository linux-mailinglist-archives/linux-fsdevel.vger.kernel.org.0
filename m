Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DD42DA390
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 23:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441180AbgLNWlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 17:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502582AbgLNWjM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:39:12 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD524C0611C5;
        Mon, 14 Dec 2020 14:38:01 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w5so12982470pgj.3;
        Mon, 14 Dec 2020 14:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4UvK5zU8YmbSA4ZaOjSKDv3yX4mccXYxyaNC7iOnySk=;
        b=GeoybizuMfpDpfAV+/8gXc4rn4T8bM6oj5/eYEvqje82syR/3rKUqljo8Tm4WFWUg1
         1w3F/pPUjwfEfRfpHW9pcmwhju62t7p3ZHTesDosxN1rma5RaKBYCUeBZL8cVQW7R79n
         OUaSC1f5iQFNeQHbcisZmna4WNL6WB3YRH+v5d/mMEW1oMAJ6BQBkqmf//LLdSlBMxP6
         zsC0eX1wJB0kp1pCC5P6dLcZDzlLMAjPM3zUDse2W7bS6YBN5J/x6RhkXV1hKcLIa8zO
         D45Jw/7xDAM8F8o2M9p+L767QPqRyEGI77zEZbivRA/B5qGv7qFXpKsR3TvKy0dKlxBS
         Qmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4UvK5zU8YmbSA4ZaOjSKDv3yX4mccXYxyaNC7iOnySk=;
        b=ip9r+PKY3/ePbc9+E2BIj2lHKwOb7cGBDO/8iL/wwESLBo7J++DoRCISL+CVq/J334
         hnOQyQt1rIvzJ8rTTHhCIFPRkGsuaSsHLgrbC2TTp7TcX3oAtcizpLAF/w33o/qoZlxx
         HDpPKKMgxDkDIH5+pHCqISBrLYkYB7Zh2gRwyJ1u65Wknp0DlOjhit3vpBULYj3qC3WB
         WrBKR4voC3cxlmsOiWOZNwUQJ/cZ76kc2KHFdSupW3CHcDDNYEJK2EZ+FQndKpTpk+oq
         x7/QgEgxITskCCzQqLBsbkCZ4zkt7yheA73C5OF9vo8qHg5XLnz/mlbR4uB75EyUhhnM
         f5QQ==
X-Gm-Message-State: AOAM530EGV/N4U6nhuWveCGx/+V6BOqdtJ6STFR7ofVVBibjG1Y5E6ME
        vvuRaJY3hBOY1ProZhjJlrY=
X-Google-Smtp-Source: ABdhPJzYQzO1DELUNIEnqXV01z7jV6nNrNROlE526aXtT8QmQi4/cQdvSHCGGkYYtvsWa+qjj0okbA==
X-Received: by 2002:a63:344b:: with SMTP id b72mr16684261pga.406.1607985481301;
        Mon, 14 Dec 2020 14:38:01 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d4sm20610758pfo.127.2020.12.14.14.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:38:00 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 9/9] mm: vmscan: shrink deferred objects proportional to priority
Date:   Mon, 14 Dec 2020 14:37:22 -0800
Message-Id: <20201214223722.232537-10-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201214223722.232537-1-shy828301@gmail.com>
References: <20201214223722.232537-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The number of deferred objects might get windup to an absurd number, and it results in
clamp of slab objects.  It is undesirable for sustaining workingset.

So shrink deferred objects proportional to priority and cap nr_deferred to twice of
cache items.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 40 +++++-----------------------------------
 1 file changed, 5 insertions(+), 35 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 693a41e89969..58f4a383f0df 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -525,7 +525,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 */
 	nr = count_nr_deferred(shrinker, shrinkctl);
 
-	total_scan = nr;
 	if (shrinker->seeks) {
 		delta = freeable >> priority;
 		delta *= 4;
@@ -539,37 +538,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
@@ -608,10 +579,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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

