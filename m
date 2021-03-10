Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8286833458C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 18:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhCJRrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 12:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbhCJRqm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:46:42 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EA2C061760;
        Wed, 10 Mar 2021 09:46:41 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso7900391pjb.3;
        Wed, 10 Mar 2021 09:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sHD52Sa+hkPXZ82uTwxwMMAdUbtnhYs3jM+eAa3hQC4=;
        b=PMvgCUnE80nILtQ2zlCJoYAgUvQmTVJucA6+y4K4wxwO6YJrKobwbUSLVLeis7S1KP
         d6UAmZakJ6HVzaoCYaOUOiQ87cpXlRynpv8Bdx94Osz6Ftkzr6wCePVsT1sWHtlg9t+u
         iXaL0vCXp4wW9yJa4ABJ8J0FK+LgqGPjx3Z/Wa4iu0fa97r1AiOiMX+vt9tT3ltyErqS
         tORkHF48vI39D1syGD3K2TzbOOs6S52RzC2oIl8HKh5dum7GPMi623Bz2mD2aUUIGQ3Z
         5Tiqo/hn89JdQ0CGpkcxgi9hm/yMlCRAPcoNLPrMQszIe6HMuu6cHctnB4murDsq3NOk
         MqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sHD52Sa+hkPXZ82uTwxwMMAdUbtnhYs3jM+eAa3hQC4=;
        b=hmWCTSpkuJPh0xXIYXM14ZNY+nRonHqLSU1s9WSe0rEgXMJ7NOM6XuyPKBEzCYU9ho
         CEEyQvv9MzAEHBfr3fH3BFA382g2tVqHza1IdtnefLC4nzBI4d9QH4Plz1yu+IRpK308
         Gos0MjFaEA1OglDStryNQvBBl43E+XDz+VP5HcDdHnvwfxX2zTG7KcegjH0slfL782IF
         3djlLJOgU0iW0H7Jdi4utZrJEoPhYY2FpV6zN6CegeQtkPusA/ZqBG7/HY84fCTdryG/
         ptZASPoucfiEEkKy2VEnpJPY399U4I+jirV1yzFzg29hCOfObSg8Cy+4+dH95Af3WIev
         9eyA==
X-Gm-Message-State: AOAM5327IAzpZ0kRCsMnYZTni2SEzbF4vQLZJnk/eYOQL2i/fPHrFMeJ
        bzhX+AdTC8R/8xUSXPuo+oo=
X-Google-Smtp-Source: ABdhPJy0/FEbV2UYtiznaebUra6fBNIUYPi6n9765r1hA2Y/cHKhUMldo7IUnb9SWEgqSkqvqxTrdQ==
X-Received: by 2002:a17:90a:8908:: with SMTP id u8mr4549214pjn.135.1615398401563;
        Wed, 10 Mar 2021 09:46:41 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d6sm145804pfq.109.2021.03.10.09.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 09:46:41 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v9 PATCH 13/13] mm: vmscan: shrink deferred objects proportional to priority
Date:   Wed, 10 Mar 2021 09:46:03 -0800
Message-Id: <20210310174603.5093-14-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210310174603.5093-1-shy828301@gmail.com>
References: <20210310174603.5093-1-shy828301@gmail.com>
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
index 9a2dfeaa79f4..6a0a91b23597 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -662,7 +662,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 */
 	nr = xchg_nr_deferred(shrinker, shrinkctl);
 
-	total_scan = nr;
 	if (shrinker->seeks) {
 		delta = freeable >> priority;
 		delta *= 4;
@@ -676,37 +675,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
@@ -745,10 +716,15 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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

