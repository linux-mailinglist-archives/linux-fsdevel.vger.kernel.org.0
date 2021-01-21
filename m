Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BECB2FF891
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 00:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbhAUXRK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 18:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbhAUXHL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:07:11 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C7AC061756;
        Thu, 21 Jan 2021 15:06:49 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id i5so2394412pgo.1;
        Thu, 21 Jan 2021 15:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nnB8h59OPJ5JvB/lyk5EwUCcxRhMfxfME1UgDyDGoQ4=;
        b=QCywdeQAJFYgBjkq16w9Nwd1NEJ6ZQaVs0eqqZSRHYkuLblNXGnvzIhx1G+5k3GrR0
         CL7EEnT4+9GOVXUQsbTzqzeo2uRy2ogXPFp7fH+Q5ad3kp3n/mZmGHGvG8TDaduz/5fZ
         yhMubrMH+qn+GOnwuajNYd446QuDY7qy9ytv401sIGjE4QYo+B5fAEULnwDCD5A+SBkN
         LqMTcA6zvOIof+MLYmcXm8IfwjVcmSz/OSPTh+jnhbBzO+G4zIIMhZAO/Bh6Tc9epdLU
         Bcn6sqbHgRLUO8pdrHQh8/d1eh8rfkNutkMz7dmtkQhwJm/irdm7xOlBGyVLOtL6MtOw
         i4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nnB8h59OPJ5JvB/lyk5EwUCcxRhMfxfME1UgDyDGoQ4=;
        b=IJ1n10GZSlYEp5//6M6F5CiLeuJXOL0h4iDlMzAmX/Miin70/QGDjQS2o4RDQUqM+0
         MaXTvVgjgmkwlR5NzL5PiNzRIyxAZPF5kTwWwfSKsv/vylQvHkYjnU5xT+N2pxqqtmry
         JU/WsIjzuq48xqztfQeXNEriHt/OTv051x1XnRHjJ4I+dX2W9eUX+nxMXZCeiJxaySux
         ARA4u7o52B0br/HI010co7EpdStf0qePjOkxSj7U8Ja5MOLQSFy7zssXrc9hCjb5BMAb
         PQuTPtRXaBn93ypwoEJdMRWfO5bIfTs3So3ISbYU2UupxtdB7YuFoVaR126gQrWxFpOL
         xivA==
X-Gm-Message-State: AOAM532hEQLHCRcUbWWPP0mYl9KjI1gFcjWMSpmLmvz1tQNd6JH7eSyP
        lqP41V7dukCxaWUaSA4jreg=
X-Google-Smtp-Source: ABdhPJzSxoYXXWg9qJp6Wsca6bMsr1MdN+qYTw1gM5auopTSgB/O1V2pm1yyZwbcayuB+/p//fu8Pw==
X-Received: by 2002:a63:4923:: with SMTP id w35mr1615014pga.404.1611270409472;
        Thu, 21 Jan 2021 15:06:49 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y16sm6722921pfb.83.2021.01.21.15.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 15:06:48 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 06/11] mm: vmscan: use a new flag to indicate shrinker is registered
Date:   Thu, 21 Jan 2021 15:06:16 -0800
Message-Id: <20210121230621.654304-7-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121230621.654304-1-shy828301@gmail.com>
References: <20210121230621.654304-1-shy828301@gmail.com>
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

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/shrinker.h |  7 ++++---
 mm/vmscan.c              | 27 +++++++++------------------
 2 files changed, 13 insertions(+), 21 deletions(-)

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
index dcb7f2913ace..018e1beb24c9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -308,19 +308,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
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
@@ -329,7 +316,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 
 	down_write(&shrinker_rwsem);
 	/* This may call shrinker, so it must use down_read_trylock() */
-	id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
+	id = idr_alloc(&shrinker_idr, NULL, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
 
@@ -496,6 +483,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		idr_replace(&shrinker_idr, shrinker, shrinker->id);
 #endif
+	shrinker->flags |= SHRINKER_REGISTERED;
 	up_write(&shrinker_rwsem);
 }
 
@@ -515,13 +503,16 @@ EXPORT_SYMBOL(register_shrinker);
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
@@ -687,7 +678,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 		struct shrinker *shrinker;
 
 		shrinker = idr_find(&shrinker_idr, i);
-		if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
+		if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
 			if (!shrinker)
 				clear_bit(i, info->map);
 			continue;
-- 
2.26.2

