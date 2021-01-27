Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37234306805
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 00:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhA0Xgc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 18:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhA0XfS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:35:18 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73742C061786;
        Wed, 27 Jan 2021 15:33:58 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id s23so1543427pgh.11;
        Wed, 27 Jan 2021 15:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9KysAzfeahGm6mPyUWMF7gAQ+XHowxRld+CYS+eHKLY=;
        b=tA1KOlZp5xzhh+BzLlPHRYZMj0u9g7hiVvgYM969FGcVOE5V3HXcV2Mz8TbSbEi1Bw
         xhDchcWpoAY76GfDuwo9A0kj/Km4hWBpVmHW0LKImZ7rqH6p+oAwjKBSmDEue9vcaMIo
         UcNGYy1VikvDBtNDM8j+H8nj6zJa/LaYljFXew3+vEaAVcUrvpsTE+XRVnfxJ6wgAowy
         vuiaJE/KrFo38K+DanTTwLsWG922IvmyoCk4/2d/pPcvTO5wdt+4gOShqo2x7vaeAcSg
         67QS4XCaw6zrPx9OJ6yFWGfsmoRDXAK5fjPT6cePC5J3TY/aGjXF7SY/X8H8Ox0VFpEs
         VCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9KysAzfeahGm6mPyUWMF7gAQ+XHowxRld+CYS+eHKLY=;
        b=tGoTCKM9E+YvO/mQrPwM3PuOi+T/kGQe1YD/z1nWHIc/6Vdj/qC/ftEfA5kKTifxbU
         KqFdZVzX9uWhpydBHxh42M/rIk0nIkSk8bLeU3iAzxNlqO60K5K/StT/6101BhTWerx/
         VG/JmVvZEhTWW4mPr6MFfziCG9xAeWDYVb8gNy8d0/5MnMXmJUin0UGPNrJa0gQzMbVg
         mjWe94wgIJODvhlVZunDBVnkCmpwCiGzyyl1jc3KlK2i0PduhGYQwrDrOoNrJP1WAlaD
         m3PIqRK6IJkalO0bAjFQMSrrgqhOBTJN5ERHeUaSvDejY5X/LVvxYrKpAkcZUlRambDr
         MCJQ==
X-Gm-Message-State: AOAM533BJPDyLnEPDbf7+gAiS9IEeEodMQ3c4BrxQy0FkiEHnnoEsx08
        Sw3ii6x+71L41w6hH41g3bM=
X-Google-Smtp-Source: ABdhPJw+ON6VKgYslWXLUXhFUVv8hlxDi+3h51p1DMxFCwmfU/ejOOO4FMb5xGih7lE2VLaiQPUQ8w==
X-Received: by 2002:a63:1159:: with SMTP id 25mr13765977pgr.321.1611790438071;
        Wed, 27 Jan 2021 15:33:58 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id 124sm3498648pfd.59.2021.01.27.15.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 15:33:56 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v5 PATCH 03/11] mm: vmscan: use shrinker_rwsem to protect shrinker_maps allocation
Date:   Wed, 27 Jan 2021 15:33:37 -0800
Message-Id: <20210127233345.339910-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210127233345.339910-1-shy828301@gmail.com>
References: <20210127233345.339910-1-shy828301@gmail.com>
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

