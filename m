Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397DB306821
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 00:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhA0XkZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 18:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhA0Xf3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:35:29 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E583EC06178B;
        Wed, 27 Jan 2021 15:34:04 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id o7so2837145pgl.1;
        Wed, 27 Jan 2021 15:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0qOZRcKtz9kja21tsQM1jjJMKJ1BMp88S9zi7WuYMo=;
        b=PwacIXXYOOrNNuWAIrBAFfvozxj3s/deo2VW6K4hOuVhtA5CdaNNq8PVUQdBzYT+mB
         lIyQUvi+l2SK/6A9Rv+2gkay1eD1LfWFs6NYt0eBiNC5bj1NL0zMbrHPc3FnfOgePrkw
         qD78ylPN7I/ryYcTMiW8IbdqyifrYbU8OUetpefcEWH6O1h4IMZ37Iqr70bCjeUt/Oip
         MyPtcDkCtStbW4G8fDLtyQBFUQCn2ocFSpIMHxsqTwc2aGYsm4mepS2PO7zC0ctCpBLB
         E7usm6cMpfMPnrVKoedBGoZECuvRFncT9Tr6RwQu3QmEPUV6lOtNaeKP9zAyhM13RsUy
         N2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0qOZRcKtz9kja21tsQM1jjJMKJ1BMp88S9zi7WuYMo=;
        b=ujQSZd+XkVrxxFxUwZ+ahTpsJh3wXP3JfubFNJNyuNH/VlDBw9rpDXXo0GKDadax4C
         9k/wopzApJWvpWsqOEUluh1Rqr3V2YknHCvrxKVoJLmS3nW1h1QIVaxtgiIfrSjXYMtn
         LvjnmjxObP5balPaPm0U9u78ZfhUIHCc9eJ7ejWppdvE9NO2KZdyntCI+IihfxCAri1K
         K0jpoZyDyM+WpNbbVkFI+iJIvQPc0tiGT/oEYqzLhnah+0XzReZUfw2FT1QLV1vZBohE
         vGfJWLSmftvw2dbVfD2NNohtaOWW3ZnJNAdZ3M9D6HMXdrFzaOhCsjQBOSsabW2lYl7G
         VR0A==
X-Gm-Message-State: AOAM531dReAwQXRCJhJJ+kcSdOCA6CTyTiqM8fEE/R4/faPck9E5OBeS
        t6dteIEYwbwf7XJnSyzx5Vw=
X-Google-Smtp-Source: ABdhPJwmNRsc3/SzIbQ591nJDEumm52L/rIIR4+QoGy+oHboi6njK9SDr2+KcbtNnfp6wdACwZwwZA==
X-Received: by 2002:a63:ee4a:: with SMTP id n10mr13603776pgk.375.1611790444512;
        Wed, 27 Jan 2021 15:34:04 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id 124sm3498648pfd.59.2021.01.27.15.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 15:34:03 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v5 PATCH 06/11] mm: vmscan: use a new flag to indicate shrinker is registered
Date:   Wed, 27 Jan 2021 15:33:40 -0800
Message-Id: <20210127233345.339910-7-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210127233345.339910-1-shy828301@gmail.com>
References: <20210127233345.339910-1-shy828301@gmail.com>
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
index 92e917033797..256896d157d4 100644
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

