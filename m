Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE329334567
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 18:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhCJRqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 12:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhCJRqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:46:21 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D6EC061760;
        Wed, 10 Mar 2021 09:46:21 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y67so12634883pfb.2;
        Wed, 10 Mar 2021 09:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aiM+lLYNubKNlhU5HOyGVLNEOVuVKT3O2pdKzgZrP7U=;
        b=L38uPzNxzeHdFm5yL8UeAwlmZ/6ul0Jc5NXK/TEsJNntKbqK6cuERyzxVNFntfJzpR
         MSzJpTbHGADjG5e0kPevhzKwvDipYOrp83GOb6zMtXAc21yCbXlVx3+JOat8amDsl9A3
         PTMGkBWbFpO1O8w1MTpxwQqsKgxG5OIZKCfOOWjUzgU9BKA9d0QQUT7HX3agjv/wcoj5
         lgrUlMfRhBiBUexwdNJayXurHC/gLCKLU2IpjXJzlbwNUW9qxioTi4laOh/qlTn5pyaw
         Oj9wV5XtmrJLnwyqWdj0wRAnfRG/19ZxvcBPqxOIF1QB4cPnGlMFJtNoKATCeAEGAeNN
         pfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aiM+lLYNubKNlhU5HOyGVLNEOVuVKT3O2pdKzgZrP7U=;
        b=ryTEbAKM+k9fOEHkP8if9lYD91y9TJx7mKS4eOFxucYPvGqUU+ptctwRFGJefnTWoR
         GC1hohnTlJ2q/myb3r7531D36DJO6ddnPDlLezEuAvQ2IG/LnD9mDIVvMy93PWxn1x5F
         YZ394Dr7X6YoghiQrXkEVD1BWenRi9CHrmPCJtvSaYZH0mhundjL6f4/9zcrrZ+k/ARY
         0aJNaIstyt7anKDfuxlJyZW9FwjxGerp7WW88/JbRpcu2Khu8Hs8JwDKw3dWbKpMkylw
         uZIkh1NOljonrUiosuD8a/jtjZ53cTjLEs49tX2SowMN8fi4AhLX4IUVutKHi1TW9Fek
         cGoQ==
X-Gm-Message-State: AOAM532oGOvdCJhOw4FJ3J0fi4HI7Xw5FcVuB+vR2pLJs7+5hSaEtoxA
        eFFW4fZEmyKepjNT3aNx+w0=
X-Google-Smtp-Source: ABdhPJyCE7pWMJCZS0OOk6anncpki25SoIBg7kTzYHtJ/2KgB4+490RPqKke3EkJ2ZeqQpgNIbP8rQ==
X-Received: by 2002:aa7:888b:0:b029:1ec:df4a:4da2 with SMTP id z11-20020aa7888b0000b02901ecdf4a4da2mr3830929pfe.66.1615398381083;
        Wed, 10 Mar 2021 09:46:21 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d6sm145804pfq.109.2021.03.10.09.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 09:46:20 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v9 PATCH 03/13] mm: vmscan: use shrinker_rwsem to protect shrinker_maps allocation
Date:   Wed, 10 Mar 2021 09:45:53 -0800
Message-Id: <20210310174603.5093-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210310174603.5093-1-shy828301@gmail.com>
References: <20210310174603.5093-1-shy828301@gmail.com>
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
index ad164f3af9a0..75fd8038a6c8 100644
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

