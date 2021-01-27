Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9F3306812
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 00:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhA0XiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 18:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhA0Xfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:35:37 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC5DC0617A7;
        Wed, 27 Jan 2021 15:34:16 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id f63so2463523pfa.13;
        Wed, 27 Jan 2021 15:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6zTr7oQng8A44UhAdRsCMp9TEBoUovtHbqgUeR1gt90=;
        b=ufz7fAq+D1Ldzv3KQIQSXZJiFZzJBw07ab2lzgQc/xuHOlmS+AJXgqzLu0ip18ohT8
         JaE7UH03ZVgMWDLZUo4zt+NJLC0MyzS9x/iCNVun2KLczlFHn6KUEs1ISJyWcpLqsO+5
         Uubhk+CWE8XQ5f94DHoDndqULxC30pSdqwurFm4eUs6pyEdBULbSA8b4iJ+xtBQ7g9Vz
         +eEortvkZ9BZVCes8RtcDa9eM3QutksUtdWBOxxts+d19fAF/iQ70rykYqSSRub/FI1k
         z9mTe2t8ETz37O5vFOsRcf9RGnwUhXRFFTjzn/3VQ7XMlisXynda4Kpf9UL8+5jfSViK
         KLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6zTr7oQng8A44UhAdRsCMp9TEBoUovtHbqgUeR1gt90=;
        b=lXjiP5uwe1j3BoPv7yB5scIAbkdCPzs8no86JUdlzu8xpnzVEnd0Jg4J9apksHi2H9
         mt7CmZ3YiqT5t5o60offVfZ/mrLM7FxYzx3mlr7b8RgMswv7xA7DsygWYAZJeL0SOwSt
         SuPDRq1TL2UlLK0npzBLKLvBx6suKlTGi6byNWNC3GoxNuhTbhspFjW6URbS5OxspCPR
         vak0+i+AwS4WcQRJQlRm0Lyg/jtwGUKxOajRQOxEH018RBDz6js1nwatwuckV5Puv2Qv
         +cVICcnxGHDMDX8d+pcGjUfLKzN0UbYyPiI3BM4g9sJPjJ4tpZK6dyppx8JuWBS6kpp8
         Kbxw==
X-Gm-Message-State: AOAM533lUkIAtBw7yjRDXdONeykmUpD/9UrffWrhrYXRIx/mUEXgCCS2
        MpxVLClcvjLvoY31gC1ILcI=
X-Google-Smtp-Source: ABdhPJxRoYG80XjL2szA2Xx9L3qJm5uTvO6Za+n3fNgIluivnAlS4ESMxzMdazerK1m7Lg4dmWhFyg==
X-Received: by 2002:a63:da46:: with SMTP id l6mr14006921pgj.134.1611790455956;
        Wed, 27 Jan 2021 15:34:15 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id 124sm3498648pfd.59.2021.01.27.15.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 15:34:15 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v5 PATCH 11/11] mm: vmscan: shrink deferred objects proportional to priority
Date:   Wed, 27 Jan 2021 15:33:45 -0800
Message-Id: <20210127233345.339910-12-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210127233345.339910-1-shy828301@gmail.com>
References: <20210127233345.339910-1-shy828301@gmail.com>
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
index 55ad91a26ba3..471d037d735e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -662,7 +662,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 */
 	nr = count_nr_deferred(shrinker, shrinkctl);
 
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
@@ -745,10 +716,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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

