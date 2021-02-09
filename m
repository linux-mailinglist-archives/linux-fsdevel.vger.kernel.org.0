Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CF8315591
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 19:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhBISCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 13:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbhBIRru (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:47:50 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80395C061788;
        Tue,  9 Feb 2021 09:47:09 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g3so10170260plp.2;
        Tue, 09 Feb 2021 09:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lKgWNZLrDd0Eei0IRyAIkFAH1mH+Bykeng/kbWxOqQI=;
        b=ZHWKtzam//P32Zt7GlfUKQIgBqYXUgTyfJinorJosiN4SiLrzzOB5gFaNy9iJPTsPN
         iPNHM27PiAPGB5B5c2eRk1s2MuhbvZdKUF7MQW36PC643l1nz2cLprkX4h8spiJ8jFEM
         pBjDaHNEkGKNJNJqa4xSfuBzq5rTR8un/e/5j2cJ2ZsFtl63pVnkczp08X+J+M+G3oIF
         h/M88R6hBlAunlW+0VEWzipqpwJLeqbBNybrwkL7u1PCkv0XAs12IdNqhPQUC0oRvAxx
         xH8GEGROukGKQd17TyxiF6LNll/AACoe60iKnAGJsJxmhF1dMl5M6AGPZ4vC3siAzn+i
         SffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKgWNZLrDd0Eei0IRyAIkFAH1mH+Bykeng/kbWxOqQI=;
        b=OSZChlA6pvizHHM3OrAjzMqXL7btmMlflfu1LI64BD9zNIkrFvt2kdIhmHvZPmlZ8P
         g5meL0g2pdGCGIaim4ujSVzW2N8MHyESesNbhPKsp2Nwy36SFNPR8Mpe9GMBZsgJ4TdV
         tpbcFR1uKvz92SjM7BozFOK379kuTaKXvI6mFX39HbAd3TcCSM0dC0peCAHzbwsJvZBM
         I+EyT4oLHK1167UZ7jSV16EDTPTwEDvEeErljg2E+JTZq+x2zBE1s8GIhFIhl6mKTiqt
         sCcR8Z0H0kI3dfmExsfB9V8tyArxvsGjPtXup66GXdbRpn2F2vK/u/z9NSTxl8pBNCTt
         TZwg==
X-Gm-Message-State: AOAM531NWCv6HAZur8xmZ4c60Y1B+cIKC++g4fuvUEC25qAejysJmtOo
        IQZqk8aHUgpSHKhAQdlIf14=
X-Google-Smtp-Source: ABdhPJyHwMvBQ3+/v8vjRYQfJSipk1mypCtSPFHjH6iMTYpJBuPnLWzUJFqrD/AfsPW7vbQFYGYRFA==
X-Received: by 2002:a17:90a:ab17:: with SMTP id m23mr5057195pjq.0.1612892829115;
        Tue, 09 Feb 2021 09:47:09 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id j1sm22260929pfr.78.2021.02.09.09.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:47:07 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v7 PATCH 03/12] mm: vmscan: use shrinker_rwsem to protect shrinker_maps allocation
Date:   Tue,  9 Feb 2021 09:46:37 -0800
Message-Id: <20210209174646.1310591-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209174646.1310591-1-shy828301@gmail.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
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

