Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9632130E0CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 18:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhBCRVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 12:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhBCRVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:21:52 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B78EC06178B;
        Wed,  3 Feb 2021 09:21:09 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o63so184505pgo.6;
        Wed, 03 Feb 2021 09:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0bFxTF/fV4lUiN+s4AG3CM0LDtyH0oMQ5dQsmLRqP1s=;
        b=cF9bUgmWRIFWkWywVBfWjyk3eYjGnd+C3QQJJQ429Ohbfhz4RMjMXDJYmRQWzPLRxo
         DP1bvqrQ4E5QQiUdFn8vgOVZJiPdbEEfH5Ejak4tBOPi091dHewFQX2tEE67nKjoKb+i
         p4pdIj/RQfrCbIQTIfUB9JmtANB/k4OjATh1Tb5KIqiNUIQ6xdiBILHCEnp8gXDMRMNr
         dF7RiPXNoomwPlUVR0eq8bWVh8LjJhD8aI6w4HARvGZKP5dJCrGdxEV9W8iUaVwCA38T
         FxUCb1UywDlLDwvrsD11hFtOXXVr7pTEfXpvgSWqiUtjTZYaA6gvuu2iB5s0EtaGV/ve
         voaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0bFxTF/fV4lUiN+s4AG3CM0LDtyH0oMQ5dQsmLRqP1s=;
        b=IEyUFJyIT7aXwVtCsd1LOV33zegBQaBtR1hvue6U69Yzjo0Gad9lcsflP5ul2hu39l
         dT3UZg5Ae88YS9Dhk3ph/rq6OitVm9r949nAbogzT+2f5NPCH3kJoOANpIt6lsymsF5t
         dASweAme96tZq3YPsD3dTZhPpBhXjJVNjOPzkLgF758MqhBCEvXMrMpcbQxgKe3JAfcN
         yTWmBBytKsD57H6/lGNRQYrcqXXcURwvTSwoVU2TcSXokTUjMx1prj0K9L0MrRoH1t5W
         9HLYg16ZgqvvNCzHzbxFUUYfbyPtdAiDlOYyKaQY5584btFbFlrVMEN2KQ0+yW6CAe0L
         kdTg==
X-Gm-Message-State: AOAM5306saw94BbnOq/11UONXy+fXhDgrctMH7QiWkB/7dhZsEh1innJ
        oHJ2/nKbR9W/xeEUsg4rjhY=
X-Google-Smtp-Source: ABdhPJyFn1IB5V7R9cYm0jM5l0K5a2g7aBSrAi+GhAnFcb0PnNL5kNoBuaHVMv7Ok8iEy1DWiX5QzA==
X-Received: by 2002:a63:1f45:: with SMTP id q5mr4657962pgm.414.1612372868943;
        Wed, 03 Feb 2021 09:21:08 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x21sm2368636pfn.100.2021.02.03.09.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 09:21:07 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v6 PATCH 03/11] mm: vmscan: use shrinker_rwsem to protect shrinker_maps allocation
Date:   Wed,  3 Feb 2021 09:20:34 -0800
Message-Id: <20210203172042.800474-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203172042.800474-1-shy828301@gmail.com>
References: <20210203172042.800474-1-shy828301@gmail.com>
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
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 96b08c79f18d..e4ddaaaeffe2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -187,7 +187,6 @@ static DECLARE_RWSEM(shrinker_rwsem);
 #ifdef CONFIG_MEMCG
 
 static int memcg_shrinker_map_size;
-static DEFINE_MUTEX(memcg_shrinker_map_mutex);
 
 static void free_shrinker_map_rcu(struct rcu_head *head)
 {
@@ -200,8 +199,6 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
 	struct memcg_shrinker_map *new, *old;
 	int nid;
 
-	lockdep_assert_held(&memcg_shrinker_map_mutex);
-
 	for_each_node(nid) {
 		old = rcu_dereference_protected(
 			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
@@ -249,7 +246,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
 	if (mem_cgroup_is_root(memcg))
 		return 0;
 
-	mutex_lock(&memcg_shrinker_map_mutex);
+	down_write(&shrinker_rwsem);
 	size = memcg_shrinker_map_size;
 	for_each_node(nid) {
 		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
@@ -260,7 +257,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
 		}
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
 	}
-	mutex_unlock(&memcg_shrinker_map_mutex);
+	up_write(&shrinker_rwsem);
 
 	return ret;
 }
@@ -275,9 +272,8 @@ static int expand_shrinker_maps(int new_id)
 	if (size <= old_size)
 		return 0;
 
-	mutex_lock(&memcg_shrinker_map_mutex);
 	if (!root_mem_cgroup)
-		goto unlock;
+		goto out;
 
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
@@ -286,13 +282,13 @@ static int expand_shrinker_maps(int new_id)
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

