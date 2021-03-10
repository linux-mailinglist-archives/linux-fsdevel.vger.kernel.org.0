Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0AB334586
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 18:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhCJRrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 12:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbhCJRqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:46:33 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A010DC061760;
        Wed, 10 Mar 2021 09:46:31 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so7639879pjc.2;
        Wed, 10 Mar 2021 09:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9fzXcQw4lBeUc4+bt/8wnQKsoR0U89o0QoJXEyYgW5c=;
        b=FB2Yz9RmCu+ccD2Dwwe/AYp1avMlu8LfTcD9I/7Gkv1HQtjz9zXwn8q9snSDKkBaOR
         Zmt5nDGnCdt+LLNUHbIjOmgX2dSrfPgvj0KqfBCk/9GvlYT980VQrjV8xpu7fgpMyK6f
         nXvGEhzI6pwyU1kepjOtJ1wIYlzLxogcub7t4cOLohSg4FQfhhnf1WSnMAhk05Q0IqAl
         p4SekSkSINOsiM7LvObXt/kMivy57B5UvPhushop8U+a7PlgNjOX5FrrZfmHAdl0SHYr
         o91epyagM874nS7cOdKfFA9NGDRNS6pTzCNG0mbvAvPOBMgW+L0nuFK97z9Z41i6MKK1
         PacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9fzXcQw4lBeUc4+bt/8wnQKsoR0U89o0QoJXEyYgW5c=;
        b=akFLpGZlbI3Zdm0nmIsIjLtYFqQnTPG4bB5jX75rNvA0DMrwwWGMuUZBeVxCSDlGcG
         I4qQkc4X7emfEY91IaGO28pazkuQ5I7EEkhTCKEDhf1HGVa8LwlQ3TAmyvBGvkcIfvFM
         1SYcL0iJ+rX6jpdZIDZd0xNB/sdK115LK+y5xqL7YGYr1wP3J9pXl5nQTz4f92cDr65k
         nF+LB/6RXALx4FtpQfqoL2m2j1HsCkGHRzbles3N2ofxPgq0Pr2FTY64VA41Zv+iB8Bz
         mGStH/M0Ql3XKJx0QRK3yJ/74tDhmNdNIQn9ee+hS4OCAD3RUxATYevaEeJVjnhG7Jdd
         O77w==
X-Gm-Message-State: AOAM530OT93otENKwYyaNEb6mV2RsQP5YDmY2LI53Mo9l3/QeidoAf4a
        ATvh1guU96LJIWSRXBpewscyMA71/y0=
X-Google-Smtp-Source: ABdhPJz8789kCVyakl8XlWuYd//XMEoDUSopV1h4rWINLev2b+o9UbsIsldLfTnNXgAxWJQtsoMRow==
X-Received: by 2002:a17:90a:bf04:: with SMTP id c4mr4610626pjs.170.1615398391251;
        Wed, 10 Mar 2021 09:46:31 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d6sm145804pfq.109.2021.03.10.09.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 09:46:30 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v9 PATCH 08/13] mm: vmscan: use a new flag to indicate shrinker is registered
Date:   Wed, 10 Mar 2021 09:45:58 -0800
Message-Id: <20210310174603.5093-9-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210310174603.5093-1-shy828301@gmail.com>
References: <20210310174603.5093-1-shy828301@gmail.com>
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
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/shrinker.h |  7 ++++---
 mm/vmscan.c              | 40 +++++++++++++++-------------------------
 2 files changed, 19 insertions(+), 28 deletions(-)

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
index c0d04f242917..d0876970601e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -314,19 +314,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
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
@@ -335,7 +322,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 
 	down_write(&shrinker_rwsem);
 	/* This may call shrinker, so it must use down_read_trylock() */
-	id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
+	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
 
@@ -358,9 +345,9 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 
 	BUG_ON(id < 0);
 
-	down_write(&shrinker_rwsem);
+	lockdep_assert_held(&shrinker_rwsem);
+
 	idr_remove(&shrinker_idr, id);
-	up_write(&shrinker_rwsem);
 }
 
 static bool cgroup_reclaim(struct scan_control *sc)
@@ -488,8 +475,11 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 	if (!shrinker->nr_deferred)
 		return;
 
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+		down_write(&shrinker_rwsem);
 		unregister_memcg_shrinker(shrinker);
+		up_write(&shrinker_rwsem);
+	}
 
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
@@ -499,10 +489,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
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
 
@@ -522,13 +509,16 @@ EXPORT_SYMBOL(register_shrinker);
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
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		unregister_memcg_shrinker(shrinker);
 	up_write(&shrinker_rwsem);
+
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
@@ -693,7 +683,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 		struct shrinker *shrinker;
 
 		shrinker = idr_find(&shrinker_idr, i);
-		if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
+		if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
 			if (!shrinker)
 				clear_bit(i, info->map);
 			continue;
-- 
2.26.2

