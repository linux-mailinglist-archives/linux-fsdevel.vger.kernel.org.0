Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72D22FF876
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 00:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbhAUXJJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 18:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbhAUXHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:07:31 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBDDC06121E;
        Thu, 21 Jan 2021 15:07:00 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id o20so2481548pfu.0;
        Thu, 21 Jan 2021 15:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cFyZyyuzW/ERd/pESi1fpg8DhMcXb2BRIJWpsGqGYMg=;
        b=K+k8Xme1P0wSsE7PFMeGaVopgVa+k1Y498WdbK9y6Vatk2rx7jNoLmN3+5kYcRLqqK
         l8rOPPSYKTQzP7xrZiGtdzmcpCYM9Wah5qcEcLYHGWoTk9EKgYdi9gLLcg20U2eXkLKF
         TvKvzOD5LIma1GnDGEPyaQL45M+4wKB8g1hbxRmTpbrONiMwDCGCD7F/Q16/zcjG6Sqd
         GItJuuq+IVsY9f72PmOX2LP9JKJ33nLsZKSUuGJcR/+LmGZyXjcefw1CJjkLZnQ/4OmK
         4kE0X/54if2CtfTBeLlbp/+1imSeKqC8NUK/RrfZjM3HXvhZjy4qTlKF+D2Fwvg7u7MU
         IPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cFyZyyuzW/ERd/pESi1fpg8DhMcXb2BRIJWpsGqGYMg=;
        b=Q5lhlLLu52GUj41JK73G54WtLppjOLUduy+L6NvH47/ZLCBk/EUTbq9HdglHtpxS7/
         33jlptUxeMKCCIGSdbopizeL5mgV+e+kfcNn5HPdWGfk0JHZcqOtcDrNb8ZlF8W8VL0d
         PNFQ6QRQW5dYxXOFh1JNc1aU+ZW1R1cPBz/YUJShA4dTqPHvbjOhu9eBkAT4DcfyPWU+
         yYbXcS6dUl7QgvJDlNyZIF3iyPNrHJaUONHbyF52eSkJIIZZFyiA2WH1SgpQ7xYUsrmL
         2ii+d1WFP2Un8AzaWoVfc7046/lOkdgwJKtx0FdCSAQLvKEYKlPMIKo+ADlQBz5FY41R
         xP/A==
X-Gm-Message-State: AOAM531pdtOH94nWk1xt7M9l1tc2rR66ZnI2/SYzjbRHCvKq0ZkhN50Q
        IHaHIAVsYtcYHepyNql/NdI=
X-Google-Smtp-Source: ABdhPJx5OwK2Kp2/u2/VM8ly/p6rR5YhfIOFzAhndfeeO2sLl7p9z+F3NsQ/by+5PnKrRVX3gESrew==
X-Received: by 2002:a62:d449:0:b029:1bc:431b:6aa4 with SMTP id u9-20020a62d4490000b02901bc431b6aa4mr1755606pfl.58.1611270420524;
        Thu, 21 Jan 2021 15:07:00 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y16sm6722921pfb.83.2021.01.21.15.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 15:06:59 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 11/11] mm: vmscan: shrink deferred objects proportional to priority
Date:   Thu, 21 Jan 2021 15:06:21 -0800
Message-Id: <20210121230621.654304-12-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121230621.654304-1-shy828301@gmail.com>
References: <20210121230621.654304-1-shy828301@gmail.com>
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
so far.  But it still may have regression for some corner cases.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 40 +++++-----------------------------------
 1 file changed, 5 insertions(+), 35 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e73f200ffd2d..bb254d39339f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -659,7 +659,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 */
 	nr = count_nr_deferred(shrinker, shrinkctl);
 
-	total_scan = nr;
 	if (shrinker->seeks) {
 		delta = freeable >> priority;
 		delta *= 4;
@@ -673,37 +672,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
@@ -742,10 +713,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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

