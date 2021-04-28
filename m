Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E509536D522
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 11:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbhD1Jzg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 05:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbhD1Jzf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:55:35 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D510BC06138F
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:48 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h11so3732888pfn.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hY8MMvczpGg13vjFG0pVN31ztr+LQshtCwbuU4Brm+8=;
        b=OVbU3euh7GNOL90p5IiOxYxd4FcV1VfX0Y9vH/DEq9PQ+YiGaCtAbF9kfcosIOpdNt
         +/+lxJEW370B9C2wMjLbygjflseJ/Bjqq3IiZmMZrz+aDvE97hM9gBX/TnJna/XR4twH
         ghtJswmWGKVLMbNUuVlgg+yv1Ui/e8jn7fEiLnj0my55Xpciv3n8/sSpBrnNSV17kx6g
         6WqjfZh1HFaIBmkPWTn8wwv6NFUYza8HXULyd3PUKJpw32v5videUL6humajUOB0SVuH
         W95VSs9KRquN+EZQVRhc35Ml9pUhxcqB966YC+EuQPDvO8LdqrpLONVSsK59dHAyLB4I
         NXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hY8MMvczpGg13vjFG0pVN31ztr+LQshtCwbuU4Brm+8=;
        b=FnriUK+kJYmahB6X7EEhaMyaAFgT/ltcdE+QjyefJucBeKYFlaD/+TO/uqYNngpQzz
         +QRXh0UezvHXdc8XE/hAn1J6W3RiAhrZ/C7pOagaquPLZaHbK/Mux1CIS5An5CUVpB0u
         y6z6LWrE5KDUwr7VQVWhiXJAz3vX9XyYxIO4mDRbysT88NV6yQvgA5hiZavECuJEygPl
         eSmHNxbe19VuP5IpLnE7s4qxxljP4KVhihJxLkIuotYQNZtWiYH/SXBUiG6AtVUMJ30c
         1xFNrMCbJqAy0KiU0YDWdgfI9+z+VoxfeY6biqXUygXqahR7gsGyviqQKrpvSlRd11Zd
         EHpw==
X-Gm-Message-State: AOAM530kzELVCwmRjKUwdm6OoV+K7kWrH3gRrMCmoSoq5BFhQwctbtDN
        oUPLfx0ZG5MnM/dqAfNbNC8wxQ==
X-Google-Smtp-Source: ABdhPJyzJQIe5mcRTW0GlTyxzjQmNhmM1GNGv6hhvKBTTupwNZQlaXeqkzuhovHXs5jNeEzNcBllrw==
X-Received: by 2002:a63:b52:: with SMTP id a18mr26475766pgl.276.1619603688418;
        Wed, 28 Apr 2021 02:54:48 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id x77sm4902365pfc.19.2021.04.28.02.54.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 02:54:48 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        alexander.h.duyck@linux.intel.com, richard.weiyang@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 9/9] mm: memcontrol: rename memcg_{get,put}_cache_ids to memcg_list_lru_resize_{lock,unlock}
Date:   Wed, 28 Apr 2021 17:49:49 +0800
Message-Id: <20210428094949.43579-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210428094949.43579-1-songmuchun@bytedance.com>
References: <20210428094949.43579-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The rwsem is held for writing during list lru arrays relocation and
memcg_nr_cache_ids updates. Therefore memcg_get_cache_ids implies
memcg_nr_cache_ids cannot be updated. It acts as a lock primitive.
So rename it to a more suitable name.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 8 ++++----
 mm/list_lru.c              | 8 ++++----
 mm/memcontrol.c            | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6350c563c7b8..e8ba6ee1b369 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1635,8 +1635,8 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
 extern struct static_key_false memcg_kmem_enabled_key;
 
 extern int memcg_nr_cache_ids;
-void memcg_get_cache_ids(void);
-void memcg_put_cache_ids(void);
+void memcg_list_lru_resize_lock(void);
+void memcg_list_lru_resize_unlock(void);
 
 /*
  * Helper macro to loop through all memcg-specific caches. Callers must still
@@ -1711,11 +1711,11 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 	return -1;
 }
 
-static inline void memcg_get_cache_ids(void)
+static inline void memcg_list_lru_resize_lock(void)
 {
 }
 
-static inline void memcg_put_cache_ids(void)
+static inline void memcg_list_lru_resize_unlock(void)
 {
 }
 
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 3ee5239922c9..e0ba0641b4e1 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -640,7 +640,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	else
 		lru->shrinker_id = -1;
 #endif
-	memcg_get_cache_ids();
+	memcg_list_lru_resize_lock();
 
 	lru->node = kcalloc(nr_node_ids, sizeof(*lru->node), GFP_KERNEL);
 	if (!lru->node)
@@ -663,7 +663,7 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 
 	list_lru_register(lru);
 out:
-	memcg_put_cache_ids();
+	memcg_list_lru_resize_unlock();
 	return err;
 }
 EXPORT_SYMBOL_GPL(__list_lru_init);
@@ -674,7 +674,7 @@ void list_lru_destroy(struct list_lru *lru)
 	if (!lru->node)
 		return;
 
-	memcg_get_cache_ids();
+	memcg_list_lru_resize_lock();
 
 	list_lru_unregister(lru);
 
@@ -685,6 +685,6 @@ void list_lru_destroy(struct list_lru *lru)
 #ifdef CONFIG_MEMCG_KMEM
 	lru->shrinker_id = -1;
 #endif
-	memcg_put_cache_ids();
+	memcg_list_lru_resize_unlock();
 }
 EXPORT_SYMBOL_GPL(list_lru_destroy);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f8cdd87cf693..437465611845 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -367,12 +367,12 @@ static int kmemcg_max_id;
 /* Protects memcg_nr_cache_ids */
 static DECLARE_RWSEM(memcg_cache_ids_sem);
 
-void memcg_get_cache_ids(void)
+void memcg_list_lru_resize_lock(void)
 {
 	down_read(&memcg_cache_ids_sem);
 }
 
-void memcg_put_cache_ids(void)
+void memcg_list_lru_resize_unlock(void)
 {
 	up_read(&memcg_cache_ids_sem);
 }
-- 
2.11.0

