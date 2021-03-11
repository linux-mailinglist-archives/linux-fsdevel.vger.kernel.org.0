Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6D0337D43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 20:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhCKTJp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 14:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhCKTJK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:09:10 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE86C061574;
        Thu, 11 Mar 2021 11:09:10 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q2-20020a17090a2e02b02900bee668844dso9543574pjd.3;
        Thu, 11 Mar 2021 11:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uVGBdCD7D46KwnzDeHFbJFDsSaALpjrd7Gd+gGd1rXE=;
        b=LeRQjwnw2LeCRF7BgliFeq65y5FqMfUxpySNgLPB8dqZdAbhQXJ40f0eFMxW9ZtgGG
         E0PyIWo7ZNLhtfEW2BvloPIVyyCGRi+eJE5NS1W9uxh8vnnaGPDGH3tWoMIsh5z4AQTm
         hxSr5rUUO7S4wWeYBcp826RkRVHHQk6oSA3g706vUAtBpGUQVwgQoWexRVWjLYArFBiI
         OginCWSvf/ZVJjz1oYD6mFaQp/CuFxViPEO1jemusmUawvrw12sNUWHgWyw46IV8UU7q
         x08rY9hN+i8bF6OlEQF1ItrcygFnRzH2Q0KW/19CbdnCl0MlSTw+tZVmt9AczdOCx6xl
         KY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uVGBdCD7D46KwnzDeHFbJFDsSaALpjrd7Gd+gGd1rXE=;
        b=pqCL1dvwcd8NCBi/mEbSNJ+1onve/jkAh3ANYU8yPGmfuMx3PeqmLNULaK2V+d1n0n
         h5LzDaGvZV4jSXjtFWYsPQnfzH4qWnlmtncdzLO1+nR2kYQT+ag5dxyZlf+VCzyRFIRZ
         7ljC0k/pGXktRW6BUCO8W+qMiWUHt1OSRqfKRgsBhBJ34+lX/mH7sICWW9+t4QJIAlkf
         x044wt/tHCu0r81Bjd89Z/XtvcuQEmsg/mMylc9NAKNvMWrMmWaYa95TfCGB32x74wzp
         8rezRwmX7OYmacm9lquqjU612gdZbFYAh34xRhMfuC+SA/pprD9PjfLWN9Npolsijqse
         nK1Q==
X-Gm-Message-State: AOAM533S1nhcwBLK+CkY6RbiOdfM/560we+Fli0H9380nlYfVNI4rHy7
        l4HjLt8WMtWDFuzf86b4IHg=
X-Google-Smtp-Source: ABdhPJzDjGg0JWVU4rrN0/JBFOTry3IxyIysSN54EZUh/VsTJfCbQjf4QVKvcXFG8sZ5SEY6RKN2Pg==
X-Received: by 2002:a17:90a:540c:: with SMTP id z12mr9963872pjh.163.1615489750107;
        Thu, 11 Mar 2021 11:09:10 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id t12sm2999111pfe.203.2021.03.11.11.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:09:09 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v10 PATCH 05/13] mm: vmscan: use kvfree_rcu instead of call_rcu
Date:   Thu, 11 Mar 2021 11:08:37 -0800
Message-Id: <20210311190845.9708-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210311190845.9708-1-shy828301@gmail.com>
References: <20210311190845.9708-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Using kvfree_rcu() to free the old shrinker_maps instead of call_rcu().
We don't have to define a dedicated callback for call_rcu() anymore.

Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 641a0b8b4ea9..bbe13985ae05 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -192,11 +192,6 @@ static inline int shrinker_map_size(int nr_items)
 	return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
 }
 
-static void free_shrinker_map_rcu(struct rcu_head *head)
-{
-	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
-}
-
 static int expand_one_shrinker_map(struct mem_cgroup *memcg,
 				   int size, int old_size)
 {
@@ -220,7 +215,7 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
 		memset((void *)new->map + old_size, 0, size - old_size);
 
 		rcu_assign_pointer(pn->shrinker_map, new);
-		call_rcu(&old->rcu, free_shrinker_map_rcu);
+		kvfree_rcu(old, rcu);
 	}
 
 	return 0;
-- 
2.26.2

