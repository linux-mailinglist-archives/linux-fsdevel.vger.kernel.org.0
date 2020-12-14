Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC48A2DA398
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 23:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502315AbgLNWia (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 17:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441179AbgLNWiZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:38:25 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D14CC061794;
        Mon, 14 Dec 2020 14:37:45 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id 4so9747674plk.5;
        Mon, 14 Dec 2020 14:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ozVKgrz/cuTdhl0CMZyCRzGO4Sb1PcBOLEI+PfNUSHM=;
        b=dXTQDcP72TdGCCJV+w/cgvaAaD/MLr2B5g5F2KSNONWtAZWOrf4mUN2HiA0vEeHEcK
         mIdVk7cX8wqk32sJglGFovFRe9g17sNd9lz4PWd6gnOEUagZ7k0cfxk9LsNabtlnHoIH
         K5V13cL6igyAu0466QaJrJHXMIXQaEoAlJ2rCYucdM8mhULTLteNYDGA14m2Sb1m15Ur
         cDzckkG3rRz9pDmouO3zJm9mPEaPtswg3Ql+oC+VsTkihgfEfbOVXn6tSZkZZHZpHwCJ
         yDgYlgKsPsUFqLDbti8/VKsZZ3l139LvxDf/arZ3LGUfghanuwCfHYoAKv10FumTEAmX
         5ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ozVKgrz/cuTdhl0CMZyCRzGO4Sb1PcBOLEI+PfNUSHM=;
        b=T4mUC570oOAy15o//umuG5ThwaZfyCHDQqHu716gpW4PH0BBD+emh7EQiZFuBVwrI7
         Xmml4GKNGTVwjg4X0KtTwmu/0XIwxTYDknnuo/lVqUbjnV1YOExEyU7Fbh2OyI/U1yNi
         nIAbjhrrSfsAKU3+5l+Hy0m3KA3jMU6agr6MePYnDHYth3UWIVQe3kf53/7ZUPqmCCe0
         qE4n4YUS4uEfd6Hulyy2H65eU2K7B6o7yQBKD9UiyYZ58ipVHk3bS+WvDGIO5i5Bt96D
         5lh8yKIPJ8wcHx2DgGFCfsTIZCTN36oCuvB3H+gv1FElemQjkUpUIgekT7qb/5HJC9Uk
         3Eyg==
X-Gm-Message-State: AOAM532cH7YSOwDPSdbmVv1s84YIyrZNEGOYqKQdoa5J6N/LlatF/w7t
        vxAHUpU14oy5BnMUHK49//c=
X-Google-Smtp-Source: ABdhPJwNKKhYDEpsImErYCx1i9yXj/MdY2yg4ExDO6Zf1q/mFSBm62tiTbO3AGPAWepsMKNUSLxTfw==
X-Received: by 2002:a17:90a:f0c5:: with SMTP id fa5mr27964263pjb.144.1607985464867;
        Mon, 14 Dec 2020 14:37:44 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d4sm20610758pfo.127.2020.12.14.14.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:37:43 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 2/9] mm: memcontrol: use shrinker_rwsem to protect shrinker_maps allocation
Date:   Mon, 14 Dec 2020 14:37:15 -0800
Message-Id: <20201214223722.232537-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201214223722.232537-1-shy828301@gmail.com>
References: <20201214223722.232537-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since memcg_shrinker_map_size just can be changd under holding shrinker_rwsem
exclusively, the read side can be protected by holding read lock, so it sounds
superfluous to have a dedicated mutex.  This should not exacerbate the contention
to shrinker_rwsem since just one read side critical section is added.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/internal.h   |  1 +
 mm/memcontrol.c | 17 +++++++----------
 mm/vmscan.c     |  2 +-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index c43ccdddb0f6..10c79d199aaa 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -108,6 +108,7 @@ extern unsigned long highest_memmap_pfn;
 /*
  * in mm/vmscan.c:
  */
+extern struct rw_semaphore shrinker_rwsem;
 extern int isolate_lru_page(struct page *page);
 extern void putback_lru_page(struct page *page);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 29459a6ce1c7..ed942734235f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -394,8 +394,8 @@ DEFINE_STATIC_KEY_FALSE(memcg_kmem_enabled_key);
 EXPORT_SYMBOL(memcg_kmem_enabled_key);
 #endif
 
+/* It is only can be changed with holding shrinker_rwsem exclusively */
 static int memcg_shrinker_map_size;
-static DEFINE_MUTEX(memcg_shrinker_map_mutex);
 
 static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
 {
@@ -408,8 +408,6 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
 	struct memcg_shrinker_map *new, *old;
 	int nid;
 
-	lockdep_assert_held(&memcg_shrinker_map_mutex);
-
 	for_each_node(nid) {
 		old = rcu_dereference_protected(
 			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
@@ -458,7 +456,7 @@ static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
 	if (mem_cgroup_is_root(memcg))
 		return 0;
 
-	mutex_lock(&memcg_shrinker_map_mutex);
+	down_read(&shrinker_rwsem);
 	size = memcg_shrinker_map_size;
 	for_each_node(nid) {
 		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
@@ -469,7 +467,7 @@ static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
 		}
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
 	}
-	mutex_unlock(&memcg_shrinker_map_mutex);
+	up_read(&shrinker_rwsem);
 
 	return ret;
 }
@@ -484,9 +482,8 @@ int memcg_expand_shrinker_maps(int new_id)
 	if (size <= old_size)
 		return 0;
 
-	mutex_lock(&memcg_shrinker_map_mutex);
 	if (!root_mem_cgroup)
-		goto unlock;
+		goto out;
 
 	for_each_mem_cgroup(memcg) {
 		if (mem_cgroup_is_root(memcg))
@@ -494,13 +491,13 @@ int memcg_expand_shrinker_maps(int new_id)
 		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
 		if (ret) {
 			mem_cgroup_iter_break(NULL, memcg);
-			goto unlock;
+			goto out;
 		}
 	}
-unlock:
+out:
 	if (!ret)
 		memcg_shrinker_map_size = size;
-	mutex_unlock(&memcg_shrinker_map_mutex);
+
 	return ret;
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 48c06c48b97e..912c044301dd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -184,7 +184,7 @@ static void set_task_reclaim_state(struct task_struct *task,
 }
 
 static LIST_HEAD(shrinker_list);
-static DECLARE_RWSEM(shrinker_rwsem);
+DECLARE_RWSEM(shrinker_rwsem);
 
 #ifdef CONFIG_MEMCG
 /*
-- 
2.26.2

