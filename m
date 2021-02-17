Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97C231D341
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 01:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhBQAOR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 19:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhBQAOP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 19:14:15 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92378C0613D6;
        Tue, 16 Feb 2021 16:13:35 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id t29so7232195pfg.11;
        Tue, 16 Feb 2021 16:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9kmwvTRVdVE30SERAs5GtvM6Gm5zn00pBYFxryVSYDw=;
        b=Apl5JLsT8gxKLTZobcVZz6rQgkrf7fQH/siVQrIumS8tleaop2xVxnCc1CVoVkVJle
         rEBSWCXJ4hgljG6TwwrSCSET42iM1SypFs4U9pXsbsGS9cN1u+TN9L1qYNRvDz3LItls
         Ge3B/4WeTdat0V1dhsU6QowLkWjm7g+w17A6BFufm8mkrMno6SUeQD2CQhHKuOPF7Uxk
         zU1c6ZKQsWhYDuEtW7kYlqmyD2hruwXytfAMU8YVYBuncyTrbQHQMP3LHOORQ9WL2uH4
         4ao0Lx3XyQx7Qi851KdhTdcmrGzoI+2PT6TZiSWkVELbysIpYRKOcVkE6dI01pF14uzo
         dfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9kmwvTRVdVE30SERAs5GtvM6Gm5zn00pBYFxryVSYDw=;
        b=ei8Zq/8/oxNu+sdSxvuk0zFBunv/qOp4Wq22A9+EVY5g8DQ0GN8rGJnKb4uy/3IPBX
         P6I+47s/MH/Q2RmRLYLrvqXN/M+pYqm1nRF1HwfR9lvER2hdUUbiPVu/flYzXffmCxQQ
         gcDaI+pG0iU+Kr+gI+F8tDvYupyUuIlHg9s1zJ3tU4gUKEQdgofdbmpzlJCFa7bV9YMm
         0SGHFzzAKrH5Dly5Mlw32+OQbURB2dSFNoz8/Q7PocRgXb6m01c/AGqHB9Zc4JZ4YJNd
         jOqHx/yPc2/otSMIJZPnZdoIJr4gf/Fa0AjSPyUpeTcZs8Ya/+FsaWWDJxTBwgOEWh/l
         1zTw==
X-Gm-Message-State: AOAM532q73jZTSTTaYJ3AFUK0xQi/5cmFf5ST84aoY3HCt6aYE9FDMD0
        gIDF9fpCgSG9WiYbYbVJljw=
X-Google-Smtp-Source: ABdhPJxwYwEKGAq8dceduxuD8dwCPV4j9BtMWCo2ogoZYclu44P7088TKtQSQLx9LwfhLkUdFWexiw==
X-Received: by 2002:a62:b410:0:b029:1a4:7868:7e4e with SMTP id h16-20020a62b4100000b02901a478687e4emr215718pfn.62.1613520815217;
        Tue, 16 Feb 2021 16:13:35 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y12sm99220pjc.56.2021.02.16.16.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 16:13:34 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v8 PATCH 03/13] mm: vmscan: use shrinker_rwsem to protect shrinker_maps allocation
Date:   Tue, 16 Feb 2021 16:13:12 -0800
Message-Id: <20210217001322.2226796-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217001322.2226796-1-shy828301@gmail.com>
References: <20210217001322.2226796-1-shy828301@gmail.com>
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
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 96b08c79f18d..543af6ec1e02 100644
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
@@ -275,9 +272,10 @@ static int expand_shrinker_maps(int new_id)
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
@@ -286,13 +284,13 @@ static int expand_shrinker_maps(int new_id)
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

