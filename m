Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CA43155A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 19:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhBISHt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 13:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbhBIRsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:48:16 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B88DC0617A9;
        Tue,  9 Feb 2021 09:47:32 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 189so3350195pfy.6;
        Tue, 09 Feb 2021 09:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kgP7rVV9XOms9KmN6ZlTZi1sz4j8/Qcyt5+yMhudraQ=;
        b=txhUUvGbr6Et8P+qJstH1wN52HTIP3XvuXU6oQ/9/6VheYliy+7dIEw6ZrrxZnE3W5
         8+KfztaNaJd32HRpr3VEsVNJVwTusKrTFLnbcTBWaDE6/cIbVDXhU5ipcpYUHcOzM+yt
         k9Z0nErlYMG7CPMHK3Pi0lZMM1vv5WTNH6iwzY/toOZvVUlk+Dekpk5VKNNFA/b5Wx3T
         5Sr97cG005c+mFUoa9ajLmq+nQAGDNLqnOCjho1uL+LIwdur9WgZGXXwRDsqFnNGtGup
         KBcut14qm2csTIyHLQaxIz6xanoMmyaX3RZ+jrqmzP612y7tdyguUMidEMT8XzWW2uiu
         fqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kgP7rVV9XOms9KmN6ZlTZi1sz4j8/Qcyt5+yMhudraQ=;
        b=YGOQscjHW27aNI6DFJIkbgoTm85U0+Ka/KMdDsyNZnyvxHq+rsk2XeiHxZ1crmK6zt
         EsHDvt7qShn6SJkXkAh4+9S43d5yGmx15SEOsf0oCSW8acCfGCexd580zxUb+DM8FkBS
         niH9yb9HfMITefG7Z9Otq/5tEYSITgu6AVuO/DXlst0u7xtn6HLMRfwxyDqFQlB1nhRf
         4UaxbztVc6CkOLvQuEMNPenR1I5P2o0nb4MzstDtmE8rjN0yBytUaEaHX6GQc3ZqjDSs
         s+J3x6XDrHNxLAwYEXUzCi3WM23aQJ1NowQZAy7l55wIgdY4tsrKGNIFDLKMfVnp2NjR
         0egw==
X-Gm-Message-State: AOAM533w9rbKT7km1sow6Kyu2MOsmMc0JcMtxk+REV7bojVB6tjTSag6
        lUkY9feCsd9gDKv5Ib4/Fj4=
X-Google-Smtp-Source: ABdhPJxSxqPLVfiBze/4jfixH2sN5dj1At9bov1ap2/6OLfH0or2smCvE1k6LYh2/CXBR93M629enA==
X-Received: by 2002:a65:6384:: with SMTP id h4mr22820090pgv.76.1612892852199;
        Tue, 09 Feb 2021 09:47:32 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id j1sm22260929pfr.78.2021.02.09.09.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:47:31 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v7 PATCH 12/12] mm: vmscan: shrink deferred objects proportional to priority
Date:   Tue,  9 Feb 2021 09:46:46 -0800
Message-Id: <20210209174646.1310591-13-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209174646.1310591-1-shy828301@gmail.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
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
 mm/vmscan.c | 40 +++++-----------------------------------
 1 file changed, 5 insertions(+), 35 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 66163082cc6f..d670b119d6bd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -654,7 +654,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 */
 	nr = count_nr_deferred(shrinker, shrinkctl);
 
-	total_scan = nr;
 	if (shrinker->seeks) {
 		delta = freeable >> priority;
 		delta *= 4;
@@ -668,37 +667,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
@@ -737,10 +708,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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

