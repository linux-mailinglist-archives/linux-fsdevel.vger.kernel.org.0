Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EFE31D34B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 01:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhBQAPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 19:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhBQAOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 19:14:55 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7381FC061793;
        Tue, 16 Feb 2021 16:13:47 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id b145so7253519pfb.4;
        Tue, 16 Feb 2021 16:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkn1dx6SBMPLTML2sqiHh/8OhgR0+c9GTaDqLQG9mRw=;
        b=mkH7qtgs/sWwR4kD6hoIFngLAQvUL2GPktVY3d/z4niwdZepWeEo7AH0a9NiFPODlv
         QUlrGVdMT+xO/IwguQ1bxvrUk9VU7j0GM/kWNkUC8svsymmD0dpabMk2lFgB5UFUiol9
         xdSaXqNCIQjHg8jECpAvnC+3rjEu7fwZ3tfuxV3VIqO6PL88KXmJ6MI0XwpX5uFa6MAH
         71grjRbccq6xRslenhUtEKq3fG1FBQTugbINLupLm0SmtGMhEh0RCGGVFWGI2jeO00Lv
         Fu7FyXqbyHU8B0p1+Uz6R9Ih6OtstECkyCfk6C2P2RBOCbvavrmIvF9pbwOI6pniRzHS
         y3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hkn1dx6SBMPLTML2sqiHh/8OhgR0+c9GTaDqLQG9mRw=;
        b=lU1sAH7ng/ByutXqdkW9XqKCBieHV2DjwX5fuC0SAKjfGwcWx6Ol9O4AqDXS6/eHRT
         IThN8jAHWc02mGVPYVlQqEdDPWk0GucIU5+dlClqaahEI7vUe7sPkoZVD36bndzLCEGb
         j/isNd8HKg527+yMlaAGHXoq5O4ycK5dV7maCxQ9jrIF61KCZcSHkz+eD5UZKtvOw0AS
         XJC5+YTzW217gbAUPVifdeaJ+5QZCueQ+4wDCiECcftxWc76YpMWHmozzmUdXTERIAvR
         3oR4/TcGmaGjreWPsUBV3JOqWpRWy4+kjSd4rgu+VW+nSBPSOD3xjktjdMD6yMUhTzcl
         BKjg==
X-Gm-Message-State: AOAM532CbZsw24Um22Gne52aRwI/sWXizdd71aYQJddnfgakvT+V4ZsC
        Fv2wRrtx70ye+eLNS0vieD0=
X-Google-Smtp-Source: ABdhPJxqdz7DA9e2dGvWSU81oXjXXmxqWC5jlwimj9yzT8it/Gn8cOPqh3jo1xVDg7Msfs3rW/c2kw==
X-Received: by 2002:a63:fc58:: with SMTP id r24mr556511pgk.72.1613520827032;
        Tue, 16 Feb 2021 16:13:47 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y12sm99220pjc.56.2021.02.16.16.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 16:13:46 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v8 PATCH 08/13] mm: vmscan: use a new flag to indicate shrinker is registered
Date:   Tue, 16 Feb 2021 16:13:17 -0800
Message-Id: <20210217001322.2226796-9-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217001322.2226796-1-shy828301@gmail.com>
References: <20210217001322.2226796-1-shy828301@gmail.com>
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
index fe6e25f46b55..a1047ea60ecf 100644
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
@@ -487,8 +474,11 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
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
@@ -498,10 +488,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
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
 
@@ -521,13 +508,16 @@ EXPORT_SYMBOL(register_shrinker);
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
@@ -692,7 +682,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 		struct shrinker *shrinker;
 
 		shrinker = idr_find(&shrinker_idr, i);
-		if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
+		if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
 			if (!shrinker)
 				clear_bit(i, info->map);
 			continue;
-- 
2.26.2

