Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682AE337D3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 20:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhCKTJn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 14:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhCKTJG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:09:06 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65944C061574;
        Thu, 11 Mar 2021 11:09:06 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o38so14278150pgm.9;
        Thu, 11 Mar 2021 11:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i2D+FuQfaS2ZRj4Qwe7N96xecJSI2gtUN3o6WXvG0vk=;
        b=q1nH2RikMTupiiFtmscgQ+W70fe3sDorZ4fRkLKO0XRwx+fzc24172LPMv2hziIcIF
         Sj0Gme3WOUqsQaMT129Zo5hCy7cm+AqdnoYV2Cuh9FuQW3Y2CCm0po075aPxccdcP7MH
         JQtHynViMEbBUKTFxHGjdWkTdjffgcUZdS9/R5dL+UTxEWcdWqze3uwdwYU8l/dGDHKq
         aJVp+6mo8dpTwNLt9NTxXBqI6czJdjPZbxuZ/IW1dEL8UGxEfeQs6DOWGB9+U/ModK9y
         xS9MFPQFUcmim0HU0A0XnS0WKcK5jKf7wSEN3pe5Dq2HVn+Qn8xBGNHIO3XjWMEIbKDG
         IwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i2D+FuQfaS2ZRj4Qwe7N96xecJSI2gtUN3o6WXvG0vk=;
        b=FC7wQHYW/Hdrde3KKvpwLWHa5e/O700h6aUMYbF2SLCujQpjHpCfUxT/tSJU4Mx8gd
         R/2ZMJO+JwL+g6tBJ52xDTd2CzM1oWzzXjopbvmomjTi9fy912AD4S9WOafmHq7HwOJu
         fe4ZVc+uf1Ih+ox6NfDMioI7cREl0BavI8dXh9phXrZAPz+/x1EvzYcgHRRUdlb2ocE2
         L4S/eWnVhW47z0jnVIW3RuIRgXbQcysCKwUj9a9AdT3lA8RwJmQFUG8dUaxshOH0bkLM
         mpjYSkyTs+FDQ3TPZBX/fKWYXTvtFNZqnHugL5vzHKNfknjvwt1x6vVesZBSqvIsPfyz
         D2FQ==
X-Gm-Message-State: AOAM530QKn1/Y4fbfaEmQMFG8v1VAUlretMTOxZG+P8UxY1wWnRgPLlq
        G9DyVm09eck1bgCdOnFqXao=
X-Google-Smtp-Source: ABdhPJxrXzkIllUs4SsPxfmE/PuCtdbdraco1NMsd2Am1G7MNDDRxNRwRr7Wjx+o2aWZ6a4lBHN1eg==
X-Received: by 2002:aa7:9431:0:b029:1f1:52fd:5444 with SMTP id y17-20020aa794310000b02901f152fd5444mr8525393pfo.47.1615489745932;
        Thu, 11 Mar 2021 11:09:05 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id t12sm2999111pfe.203.2021.03.11.11.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:09:05 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v10 PATCH 03/13] mm: vmscan: use shrinker_rwsem to protect shrinker_maps allocation
Date:   Thu, 11 Mar 2021 11:08:35 -0800
Message-Id: <20210311190845.9708-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210311190845.9708-1-shy828301@gmail.com>
References: <20210311190845.9708-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since memcg_shrinker_map_size just can be changed under holding shrinker_rwsem
exclusively, the read side can be protected by holding read lock, so it sounds
superfluous to have a dedicated mutex.

Kirill Tkhai suggested use write lock since:

  * We want the assignment to shrinker_maps is visible for shrink_slab_memcg().
  * The rcu_dereference_protected() dereferrencing in shrink_slab_memcg(), but
    in case of we use READ lock in alloc_shrinker_maps(), the dereferrencing
    is not actually protected.
  * READ lock makes alloc_shrinker_info() racy against memory allocation fail.
    alloc_shrinker_info()->free_shrinker_info() may free memory right after
    shrink_slab_memcg() dereferenced it. You may say
    shrink_slab_memcg()->mem_cgroup_online() protects us from it? Yes, sure,
    but this is not the thing we want to remember in the future, since this
    spreads modularity.

And a test with heavy paging workload didn't show write lock makes things worse.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 98a44fb81f8a..b08c8d9055ae 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -187,7 +187,6 @@ static DECLARE_RWSEM(shrinker_rwsem);
 #ifdef CONFIG_MEMCG
 
 static int memcg_shrinker_map_size;
-static DEFINE_MUTEX(memcg_shrinker_map_mutex);
 
 static void free_shrinker_map_rcu(struct rcu_head *head)
 {
@@ -201,8 +200,6 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
 	struct mem_cgroup_per_node *pn;
 	int nid;
 
-	lockdep_assert_held(&memcg_shrinker_map_mutex);
-
 	for_each_node(nid) {
 		pn = memcg->nodeinfo[nid];
 		old = rcu_dereference_protected(pn->shrinker_map, true);
@@ -250,7 +247,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
 	if (mem_cgroup_is_root(memcg))
 		return 0;
 
-	mutex_lock(&memcg_shrinker_map_mutex);
+	down_write(&shrinker_rwsem);
 	size = memcg_shrinker_map_size;
 	for_each_node(nid) {
 		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
@@ -261,7 +258,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
 		}
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
 	}
-	mutex_unlock(&memcg_shrinker_map_mutex);
+	up_write(&shrinker_rwsem);
 
 	return ret;
 }
@@ -276,9 +273,10 @@ static int expand_shrinker_maps(int new_id)
 	if (size <= old_size)
 		return 0;
 
-	mutex_lock(&memcg_shrinker_map_mutex);
 	if (!root_mem_cgroup)
-		goto unlock;
+		goto out;
+
+	lockdep_assert_held(&shrinker_rwsem);
 
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
@@ -287,13 +285,13 @@ static int expand_shrinker_maps(int new_id)
 		ret = expand_one_shrinker_map(memcg, size, old_size);
 		if (ret) {
 			mem_cgroup_iter_break(NULL, memcg);
-			goto unlock;
+			goto out;
 		}
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
-unlock:
+out:
 	if (!ret)
 		memcg_shrinker_map_size = size;
-	mutex_unlock(&memcg_shrinker_map_mutex);
+
 	return ret;
 }
 
-- 
2.26.2

