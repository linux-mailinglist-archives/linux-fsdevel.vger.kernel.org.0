Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217122CC524
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 19:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389503AbgLBS3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 13:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389492AbgLBS3J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:29:09 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA3BC061A4B;
        Wed,  2 Dec 2020 10:28:05 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id i38so1544851pgb.5;
        Wed, 02 Dec 2020 10:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/KThC6++Y6o6leiTwROJ96GvddZx8+czWeSmb5amZVQ=;
        b=EMi/tuOVxp5UeIBbQHuc0MvOjXaJL4xMfzAPKC7vAdSGUX+AukgNU6lbSCEl1pa40s
         CzGFvy2f9sxECBStwdH2cBnDzBzlMji6d0TkKGY36wzDoRVCBRuf5Irax63BIyEYZsV1
         hd+v6o02bEmjxBhOs0e07+ABx6uC99D3Xg3bhAUFvSZcPWzJzjpxVs7Pg9F6XbO+PP/Y
         8KbvW7Sbe06Jvw/Ig0FqkoPmY8jWSszcCz+ff02L+L9d4Q9R6UKL+fhF6h0Uv+TyVPDj
         q6dqCTWgosHvZbrEXyjzSVAS2jtMKMCtFGukFVkeyUr8DKuEOAbBBwsLwLHWlKpfihhn
         pEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/KThC6++Y6o6leiTwROJ96GvddZx8+czWeSmb5amZVQ=;
        b=alEfcNx5kT6g3TQ69LN0w1QeHyenq9rHE9YSJS5qPw7JMq5T7hjCRBfDtbodngED6k
         ImtEcyJ0KvKZ33VEQw75YSQGq56vrV5KLcuu2/EHFyS6xEB89TZWWVVCkThUKV6DCuvo
         Bb+RrUJtLBQJryl5bpR+mlqE65aeD6xmis5D/QO+R2ykWUUlBEXRNosK8tzfWaH2sUje
         awG7SaUNPYYQuYWfuNHdt2V42CYhGiRiaRm8lGZ2pJdx3N8ccm5O+sVJBQcSY3CTedyg
         0XbZcQLWhCZMeZiU2mwFPPD5fPqatG2W2RK8vlg87O0sNMN2ItRCLWkvXQdy8blOGQdf
         2fqg==
X-Gm-Message-State: AOAM532L4qM8ZPJj1nvrAVnrXFsLCgO3kA2QWtsLolKrZqMulTaSO4Ff
        54rV5OXfaIyL4WOeAxbVZA0=
X-Google-Smtp-Source: ABdhPJwastASUnMXqQBRmmSHtYhnA9Bcu2/dYOOI2LdtM0gtv3ElGxk1WiZ9iMjXMoN8OXJgmnux8A==
X-Received: by 2002:a63:d45:: with SMTP id 5mr1078522pgn.0.1606933685165;
        Wed, 02 Dec 2020 10:28:05 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id c6sm396906pgl.38.2020.12.02.10.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:28:04 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] mm: vmscan: shrink deferred objects proportional to priority
Date:   Wed,  2 Dec 2020 10:27:25 -0800
Message-Id: <20201202182725.265020-10-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201202182725.265020-1-shy828301@gmail.com>
References: <20201202182725.265020-1-shy828301@gmail.com>
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
index 7dc8075c371b..9d2a6485e982 100644
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

