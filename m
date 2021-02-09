Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BD5315586
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 19:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhBIRzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 12:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbhBIRrg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:47:36 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E51C061793;
        Tue,  9 Feb 2021 09:47:20 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id j11so10140626plt.11;
        Tue, 09 Feb 2021 09:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NF6HThwQUpqhcxPrBlYzwJ+cqS/FPyEXXyhktWrJklc=;
        b=T25wb3ff0wno0w5hs/bushE7ZWa46bofCJTkQrTEctOaXfljMeIg4rk08r/Gf82LnK
         Oq6pBXT1NBenLp59ywUUlnHMQeD8wEnqUPeIsS2fD4ukwJpUFO+YFjlHQrsP+l8eNHE1
         tjq5FS0ZAGfDK3mAgLsgUdrq/pcJMicB716nhoXTMufgMop3hVZis+ASnY93sI6qTdcr
         cSG7qRwkYmDGSf/fSWTmXXEB7i5FtYxSR+Qku19/pMaT8nS5HQs9KNkVWcuQE0MR210O
         iYwXE7yKlYIumUI0NpL/Z0k5wtdO89W0//D6EQcOBbmjnMMsgqnuhVKImYrIdC9DMFex
         +oQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NF6HThwQUpqhcxPrBlYzwJ+cqS/FPyEXXyhktWrJklc=;
        b=uIm1MrJzLNYHIX+8ms6zwMzdXCXr22ENvjT0HuStYAEupxX3L7tSGpQ+QQYugCJixy
         tMqHs3+n2Q9FSmaNVcYjQyENpjjgATY4giI8WVWQiy8lZCvCa06CQ4+optZ8mRkutjWn
         EJe91nBzA7ocldE+RkfWKRW7WNlaHaMV4lec1dNMXzGBfK4KxYqgK8F0EmmgMVehYBHs
         gaUfRkOt9cQvlwz+xmMpx56AURzvHFUUx6d5CUIGmwDxgiMKl5EC77gHVvho5bvXh2OM
         cQMIVQHFPp+XIsKVDAIIFbYYIndUoqDrEII2bgcnfpW1Hm1JrbYAa3s1BVzyiTjm4U/o
         YOow==
X-Gm-Message-State: AOAM53217gSvKT+TIQok2faQZ8TzVGDaRCV1oyE3LnH7s1Zoe5o026V8
        IRBt4zQpVoMX1qlwj+lV/14=
X-Google-Smtp-Source: ABdhPJye6RRH94+CGlvBo7IaC/UfHgjz9ba5WHxA0haMxMB24SUnJVINCvkrXRLTHgG+sGs23jEyVw==
X-Received: by 2002:a17:902:ee44:b029:e2:bb4a:9ffb with SMTP id 4-20020a170902ee44b02900e2bb4a9ffbmr18582560plo.39.1612892839666;
        Tue, 09 Feb 2021 09:47:19 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id j1sm22260929pfr.78.2021.02.09.09.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:47:18 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v7 PATCH 07/12] mm: vmscan: use a new flag to indicate shrinker is registered
Date:   Tue,  9 Feb 2021 09:46:41 -0800
Message-Id: <20210209174646.1310591-8-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209174646.1310591-1-shy828301@gmail.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
This approach is fine with nr_deferred at the shrinker level, but the following
patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
from unregistering correctly.

Remove SHRINKER_REGISTERING since we could check if shrinker is registered
successfully by the new flag.

Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/shrinker.h |  7 ++++---
 mm/vmscan.c              | 31 +++++++++----------------------
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 0f80123650e2..1eac79ce57d4 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -79,13 +79,14 @@ struct shrinker {
 #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
 
 /* Flags */
-#define SHRINKER_NUMA_AWARE	(1 << 0)
-#define SHRINKER_MEMCG_AWARE	(1 << 1)
+#define SHRINKER_REGISTERED	(1 << 0)
+#define SHRINKER_NUMA_AWARE	(1 << 1)
+#define SHRINKER_MEMCG_AWARE	(1 << 2)
 /*
  * It just makes sense when the shrinker is also MEMCG_AWARE for now,
  * non-MEMCG_AWARE shrinker should not have this flag set.
  */
-#define SHRINKER_NONSLAB	(1 << 2)
+#define SHRINKER_NONSLAB	(1 << 3)
 
 extern int prealloc_shrinker(struct shrinker *shrinker);
 extern void register_shrinker_prepared(struct shrinker *shrinker);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 273efbf4d53c..a047980536cf 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -315,19 +315,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 	}
 }
 
-/*
- * We allow subsystems to populate their shrinker-related
- * LRU lists before register_shrinker_prepared() is called
- * for the shrinker, since we don't want to impose
- * restrictions on their internal registration order.
- * In this case shrink_slab_memcg() may find corresponding
- * bit is set in the shrinkers map.
- *
- * This value is used by the function to detect registering
- * shrinkers and to skip do_shrink_slab() calls for them.
- */
-#define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
-
 static DEFINE_IDR(shrinker_idr);
 
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
@@ -336,7 +323,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 
 	down_write(&shrinker_rwsem);
 	/* This may call shrinker, so it must use down_read_trylock() */
-	id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
+	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
 
@@ -499,10 +486,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	down_write(&shrinker_rwsem);
 	list_add_tail(&shrinker->list, &shrinker_list);
-#ifdef CONFIG_MEMCG
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
-		idr_replace(&shrinker_idr, shrinker, shrinker->id);
-#endif
+	shrinker->flags |= SHRINKER_REGISTERED;
 	up_write(&shrinker_rwsem);
 }
 
@@ -522,13 +506,16 @@ EXPORT_SYMBOL(register_shrinker);
  */
 void unregister_shrinker(struct shrinker *shrinker)
 {
-	if (!shrinker->nr_deferred)
+	if (!(shrinker->flags & SHRINKER_REGISTERED))
 		return;
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
-		unregister_memcg_shrinker(shrinker);
+
 	down_write(&shrinker_rwsem);
 	list_del(&shrinker->list);
+	shrinker->flags &= ~SHRINKER_REGISTERED;
 	up_write(&shrinker_rwsem);
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		unregister_memcg_shrinker(shrinker);
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
@@ -693,7 +680,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 		struct shrinker *shrinker;
 
 		shrinker = idr_find(&shrinker_idr, i);
-		if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
+		if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
 			if (!shrinker)
 				clear_bit(i, info->map);
 			continue;
-- 
2.26.2

