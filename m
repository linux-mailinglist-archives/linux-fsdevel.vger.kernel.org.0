Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDAE2FF89C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 00:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbhAUXTq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 18:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAUXHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:07:06 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0341BC061353;
        Thu, 21 Jan 2021 15:06:43 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id f63so2446584pfa.13;
        Thu, 21 Jan 2021 15:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9KysAzfeahGm6mPyUWMF7gAQ+XHowxRld+CYS+eHKLY=;
        b=WBYhztIOeeY04TJWXqc9qQSLVH5omlKxjvbotA3q3BZOdZBcZCRKzackoXnxcq2Yc6
         mCRwOBZO38UOqjX5/5IJUOPjU4gC+inxt6mAIO1dFghM0SscgNdi53CVxVhFDQPiD4D/
         QBZLyzueyDathFogij0nRBuVX7E0x0Uin5KKSYcr6/BRyfvoWZ+jFQseMDrwzoZ6O1F3
         TpjGO57KsySxbwmqEJDl3637iLv3aOk9ITA2ZWPzggbPaZVNHW5E1ElmenJQ0akR4kF0
         bBxK+jUom8OB1WgHgQGWXA6agAIsNwesmz0Gy4wRmaqMnTjWFThw4oDgbyD6yEXwqHZe
         TrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9KysAzfeahGm6mPyUWMF7gAQ+XHowxRld+CYS+eHKLY=;
        b=PtHwOlsio2oFeKxpBRadtT3LwKRbxvjRQrYBhFG9b3Icl3U2OaoCrUZvZa5cxYQBRE
         IDByzuaWLAPVA6c7b962HS6Z/6UaVprDm5wD1d73w3XGtYwmR7/CdYVYdHmoz0l5h0NC
         jqV8avT8B+hOEEAogOcJcdvOH2y7VulqQp2NYQ01y1T2zmFlfmVdd1vTsKmRErqO6vi3
         IRt06M5Vwtb31X4dlLmHcj9ChKnkAtL9Xr1fN+OUVugDL7QuNSBIn0GIpvPhKAnSwHhE
         nY2eYXgK1hnsEqoo6sSY2mL+q6hg7CNf1Jcqs7mHubls1EeBA6zKBO/iDBIg1M4Ev2M/
         4J6Q==
X-Gm-Message-State: AOAM5304IJL92DxNxMjIOK8q40np3wZipnfmAuXgNqEa3DwaOkA282xr
        I4J9ixZ1G05dk7eqf2YF3cE=
X-Google-Smtp-Source: ABdhPJywYL+McJDZGYLd5Wt25nO1Tlxegu3RhSomNZ37WaqnKe9HHRYdl+ws3Opt5V3VAcwEmyqujA==
X-Received: by 2002:a63:4c52:: with SMTP id m18mr1642106pgl.280.1611270402606;
        Thu, 21 Jan 2021 15:06:42 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y16sm6722921pfb.83.2021.01.21.15.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 15:06:41 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 03/11] mm: vmscan: use shrinker_rwsem to protect shrinker_maps allocation
Date:   Thu, 21 Jan 2021 15:06:13 -0800
Message-Id: <20210121230621.654304-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121230621.654304-1-shy828301@gmail.com>
References: <20210121230621.654304-1-shy828301@gmail.com>
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

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d950cead66ca..d3f3701dfcd2 100644
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
@@ -276,9 +273,8 @@ static int expand_shrinker_maps(int new_id)
 	if (size <= old_size)
 		return 0;
 
-	mutex_lock(&memcg_shrinker_map_mutex);
 	if (!root_mem_cgroup)
-		goto unlock;
+		goto out;
 
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
@@ -287,13 +283,13 @@ static int expand_shrinker_maps(int new_id)
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

