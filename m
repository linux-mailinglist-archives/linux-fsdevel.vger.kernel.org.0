Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AFB31D34F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 01:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhBQAPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 19:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhBQAO4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 19:14:56 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC51C0617A7;
        Tue, 16 Feb 2021 16:13:53 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id kr16so360150pjb.2;
        Tue, 16 Feb 2021 16:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qF6ksg7l8pC6izRWMIXhdTqgtS4B/O7ETuSZILY8w1s=;
        b=efLeE7WoLcttQISB/mbXgF8wP3e76TpoE8gJQSpz8Doiv4ijcze5SDWuVLpPilWugW
         4ase4ksfGx3DQ1vQ9YPS8cvJgTc6yrYkXYYL16cV5wUUsZMCRKE/0CVqrMEUDcpFG7cd
         98ppxJELp7IKlxIyYmzLE5sHSXYOslrGVPOJE8ZnB87f5l1xOwj/PBABqjJKvDrEEw0W
         9A6cMzrD8TEYAQG0O6lKGFyhv14a3xGy/upbPa7cmjFMZMoYe6VkfETTgNFzEsRK7Lh4
         PHM2MHODmm3VT4wd+ECwKb9Is2ipviXZPb4J6RTTOURjIepkEuKENtWyJrrwEoxbi+GI
         q8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qF6ksg7l8pC6izRWMIXhdTqgtS4B/O7ETuSZILY8w1s=;
        b=alTv6g1c4GYxLLwqiKYWKOv7phwA1g08bJ5VYK+8HQx78P55G8g4S8jk7MCLBHoldq
         wgPL5MEE4RlUoNtDcsEowVlz+O25tjnwe5JmtDTY6ghFI1TfleTxJlNNeDSbLF+LuGmb
         HYzzdb6Q/Gad2Vrg3IfBJq6C7VFgb28bB8RMumYvy/YyBC6wtMcM9LL9nl3Q6rAJawGJ
         qLuZ897t9nfgXfcbKh6Dh06tVNyh5YznV2L6sdK+SPz//2UA0aLhJxADeEPHCldMaRsG
         UH/LVVMHob7Cay3DiVX/BsABg1BtJgeWhTOM2/TQKVekJDZLwCxOqWjtyHMc3ItYTfEd
         i/cA==
X-Gm-Message-State: AOAM533EOhhjkFys1pzh4pl3QfmAWYRSw6tU8sBe4hhmembdkaXRFvBK
        hT+M9pcol7IU9O3lBqsN7rI=
X-Google-Smtp-Source: ABdhPJxLa2Ndx3ZiLcTf5jq9MtNEjZleRMgJ3G3T68XGHQVRcwZQievbuP+0T/xY4M5LCfHxhgP3gg==
X-Received: by 2002:a17:90a:7108:: with SMTP id h8mr6288180pjk.98.1613520832960;
        Tue, 16 Feb 2021 16:13:52 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y12sm99220pjc.56.2021.02.16.16.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 16:13:52 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v8 PATCH 11/13] mm: vmscan: don't need allocate shrinker->nr_deferred for memcg aware shrinkers
Date:   Tue, 16 Feb 2021 16:13:20 -0800
Message-Id: <20210217001322.2226796-12-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217001322.2226796-1-shy828301@gmail.com>
References: <20210217001322.2226796-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now nr_deferred is available on per memcg level for memcg aware shrinkers, so don't need
allocate shrinker->nr_deferred for such shrinkers anymore.

The prealloc_memcg_shrinker() would return -ENOSYS if !CONFIG_MEMCG or memcg is disabled
by kernel command line, then shrinker's SHRINKER_MEMCG_AWARE flag would be cleared.
This makes the implementation of this patch simpler.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 57cbc6bc8a49..d8800e4da67d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -344,6 +344,9 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
 	int id, ret = -ENOMEM;
 
+	if (mem_cgroup_disabled())
+		return -ENOSYS;
+
 	down_write(&shrinker_rwsem);
 	/* This may call shrinker, so it must use down_read_trylock() */
 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
@@ -423,7 +426,7 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 #else
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
-	return 0;
+	return -ENOSYS;
 }
 
 static void unregister_memcg_shrinker(struct shrinker *shrinker)
@@ -534,8 +537,18 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
  */
 int prealloc_shrinker(struct shrinker *shrinker)
 {
-	unsigned int size = sizeof(*shrinker->nr_deferred);
+	unsigned int size;
+	int err;
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+		err = prealloc_memcg_shrinker(shrinker);
+		if (err != -ENOSYS)
+			return err;
 
+		shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
+	}
+
+	size = sizeof(*shrinker->nr_deferred);
 	if (shrinker->flags & SHRINKER_NUMA_AWARE)
 		size *= nr_node_ids;
 
@@ -543,28 +556,16 @@ int prealloc_shrinker(struct shrinker *shrinker)
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
 
-	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
-		if (prealloc_memcg_shrinker(shrinker))
-			goto free_deferred;
-	}
-
 	return 0;
-
-free_deferred:
-	kfree(shrinker->nr_deferred);
-	shrinker->nr_deferred = NULL;
-	return -ENOMEM;
 }
 
 void free_prealloced_shrinker(struct shrinker *shrinker)
 {
-	if (!shrinker->nr_deferred)
-		return;
-
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
 		down_write(&shrinker_rwsem);
 		unregister_memcg_shrinker(shrinker);
 		up_write(&shrinker_rwsem);
+		return;
 	}
 
 	kfree(shrinker->nr_deferred);
-- 
2.26.2

