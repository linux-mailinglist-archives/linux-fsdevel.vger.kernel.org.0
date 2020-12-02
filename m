Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BF62CC523
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 19:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389496AbgLBS3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 13:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389484AbgLBS3G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:29:06 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B13EC061A49;
        Wed,  2 Dec 2020 10:28:00 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id x15so1604344pll.2;
        Wed, 02 Dec 2020 10:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nkAj+kfHLpRV/jrsXiaGZp9Y0zC5JrRi0VSe75y5/ok=;
        b=mFFs1yr0iQTTA94bdtdkPFC5iIeeiXvamHuI6dQajmLDW8uGAAoqBp0Lco3wkWfx9X
         XgJ97GBMEc2SMDjQPCj+a5M07Gh39FRvnOmmvwjmF1+esdeCTOYDHpJ9B1vdKIIVhiVL
         cxZ2ENAG7T2UE3wDBTh1PYjNJRdmB1+Y/KukMvEL/zwL7J/XVwCcZaZBJC+zR5/xVc52
         ELrSZNt13NL5slziBmuUUaYzyR3dBL0T55R1IcembCzKHT+z/H8uz5Swh1XykgYqXNxo
         H840U2OiFmjZnLoc2uPad4qAR41nfo846N8h8Fd5P2oP2YpqAVUTqJuvqR2XhfmcJ5VI
         CvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nkAj+kfHLpRV/jrsXiaGZp9Y0zC5JrRi0VSe75y5/ok=;
        b=XPxRTWE8cOKYP3mXMCosBe7weJj2dC87TJQgES8oovUmmDiHrMQAbgyBoQ1JQYLEDT
         ehIrrHTiiFZI4Ugf32AHUgXDR7RFtnT0vibS3y8gyZrYYT+wSLbMhJ77lRwzDX4ZW5lz
         Ani1WiKtNFtY4x0VIgKrvSIr2WB6K1lPZMaLX09nsXfSWh0AK63kBdQFAShJNRFA+bmT
         1E3qfNZo1rGFk6FlnWRToQ6+Ru6FCr0PbkExBiKtiJ1iEl4yrV1i248KbG3fP9JT93g9
         wGODlqWYAACOLZ64qoMFzt/CSbH7y/kBbBOBtUnYTVVP1M51NxGtQlMn4dC1Lk7GuO5L
         B9vQ==
X-Gm-Message-State: AOAM531M1tuEDfjHRKZMXG8PWbwNUsmUehCEVMNDGkAiMVeQuVMocmHd
        9G4geKTtaWXajMPf3nXcfNI=
X-Google-Smtp-Source: ABdhPJysUUGeVaOYuNGBSl2GIw5j+IQLduO6JMDdjjacV2utahIR7URRPrC/8JjUx772SiJV7yEvWw==
X-Received: by 2002:a17:90b:1945:: with SMTP id nk5mr1107509pjb.30.1606933680300;
        Wed, 02 Dec 2020 10:28:00 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id c6sm396906pgl.38.2020.12.02.10.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:27:59 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] mm: vmscan: don't need allocate shrinker->nr_deferred for memcg aware shrinkers
Date:   Wed,  2 Dec 2020 10:27:23 -0800
Message-Id: <20201202182725.265020-8-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201202182725.265020-1-shy828301@gmail.com>
References: <20201202182725.265020-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now nr_deferred is available on per memcg level for memcg aware shrinkers, so don't need
allocate shrinker->nr_deferred for such shrinkers anymore.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d569fdcaba79..5fd57060fafd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -420,7 +420,15 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
  */
 int prealloc_shrinker(struct shrinker *shrinker)
 {
-	unsigned int size = sizeof(*shrinker->nr_deferred);
+	unsigned int size;
+
+	if (is_deferred_memcg_aware(shrinker)) {
+		if (prealloc_memcg_shrinker(shrinker))
+			return -ENOMEM;
+		return 0;
+	}
+
+	size = sizeof(*shrinker->nr_deferred);
 
 	if (shrinker->flags & SHRINKER_NUMA_AWARE)
 		size *= nr_node_ids;
@@ -429,26 +437,18 @@ int prealloc_shrinker(struct shrinker *shrinker)
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
 
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
-		if (prealloc_memcg_shrinker(shrinker))
-			goto free_deferred;
-	}
-
 	return 0;
-
-free_deferred:
-	kfree(shrinker->nr_deferred);
-	shrinker->nr_deferred = NULL;
-	return -ENOMEM;
 }
 
 void free_prealloced_shrinker(struct shrinker *shrinker)
 {
-	if (!shrinker->nr_deferred)
+	if (is_deferred_memcg_aware(shrinker)) {
+		unregister_memcg_shrinker(shrinker);
 		return;
+	}
 
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
-		unregister_memcg_shrinker(shrinker);
+	if (!shrinker->nr_deferred)
+		return;
 
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
-- 
2.26.2

