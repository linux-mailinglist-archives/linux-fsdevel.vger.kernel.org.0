Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FCC2FF893
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 00:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbhAUXRb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 18:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbhAUXHL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:07:11 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF05C061356;
        Thu, 21 Jan 2021 15:06:45 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id i5so2394279pgo.1;
        Thu, 21 Jan 2021 15:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ecr+uyWVMQYJIPC/0K3B/JrS2n6P+feKAlXvlt40fK0=;
        b=OfbJGr70L0LEsiZ7MaGL39F+x8jqf1HlI3cOx5jDnGeeynuSmYIdMRNKksm+7Xbb6G
         391CuA3S5xAbjI3C8zxnHkgkmazfA9kK8z+E5+B4Xb9hayZm/h2SioDmY5DHGRJ6+svS
         3x4o3aTYO8NdO22EWeSuMp52kr43X+WB5rucplbEZbNxVrA+neGUlJLRWSSFaHYxeLlR
         HAmgckMD0/txHmZqfwpOVzXotPSIxa+yaO0etz1jcjNKhKDBy3szftmNhD344/2PIU4M
         qv/QZpqhuNlHGkRpuRp+/dgGjXpVX7b99ua4O+Ecoe60pcvXYsqn7Yelg9VhlvZagJuj
         UB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ecr+uyWVMQYJIPC/0K3B/JrS2n6P+feKAlXvlt40fK0=;
        b=Anr8torBsRvGSKOXofeZ16UUvnEd8DNHaEZYYQsdeycnlodhsEJxOqnHmdXhKsEiwg
         iHvhFo9T19JUXCLnjG6Oo6BySrdjAN71vTwMShmPlCr5ho36t6L7+r5xhDqck5RQfuDF
         oHhUSGLPzvGQ00yncpvIjUa9LK2ChlqsgnCinyNnWvX5qAfWhiQDoJCb3bE4C04Px/yT
         6iwSUe05vDZ4Uo5orPRkmPthcBqOfD1wdqYEqrtIOaNb8aOj3f/qf7Imk65pNOeD7c+t
         chsHq2A0z1jn+jcpinoMmsvbCFwn62D6QqlQ6POq/PcKUnFyzPLCyNk1cKABQkBjcBbc
         zulQ==
X-Gm-Message-State: AOAM530SyYl0y2869glsF588c83cWes7dikf1LvH/58lSgo2yStCtrnA
        ZGlHnj29A/hbZMrA4HaJTus=
X-Google-Smtp-Source: ABdhPJwr0t0N81wvkWziICzoO8pyZXAIt1mXXq49BQqPpZ1o/XhNOsQ0dLrPkmS2E9OrdE0gEKa8HQ==
X-Received: by 2002:a63:1b11:: with SMTP id b17mr1618542pgb.322.1611270404859;
        Thu, 21 Jan 2021 15:06:44 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y16sm6722921pfb.83.2021.01.21.15.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 15:06:44 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 04/11] mm: vmscan: remove memcg_shrinker_map_size
Date:   Thu, 21 Jan 2021 15:06:14 -0800
Message-Id: <20210121230621.654304-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121230621.654304-1-shy828301@gmail.com>
References: <20210121230621.654304-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Both memcg_shrinker_map_size and shrinker_nr_max is maintained, but actually the
map size can be calculated via shrinker_nr_max, so it seems unnecessary to keep both.
Remove memcg_shrinker_map_size since shrinker_nr_max is also used by iterating the
bit map.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d3f3701dfcd2..40e7751ef961 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -185,8 +185,7 @@ static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
 #ifdef CONFIG_MEMCG
-
-static int memcg_shrinker_map_size;
+static int shrinker_nr_max;
 
 static void free_shrinker_map_rcu(struct rcu_head *head)
 {
@@ -248,7 +247,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
 		return 0;
 
 	down_write(&shrinker_rwsem);
-	size = memcg_shrinker_map_size;
+	size = (shrinker_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
 	for_each_node(nid) {
 		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
 		if (!map) {
@@ -266,10 +265,11 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
 static int expand_shrinker_maps(int new_id)
 {
 	int size, old_size, ret = 0;
+	int new_nr_max = new_id + 1;
 	struct mem_cgroup *memcg;
 
-	size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
-	old_size = memcg_shrinker_map_size;
+	size = (new_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
+	old_size = (shrinker_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
 	if (size <= old_size)
 		return 0;
 
@@ -286,9 +286,10 @@ static int expand_shrinker_maps(int new_id)
 			goto out;
 		}
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
+
 out:
 	if (!ret)
-		memcg_shrinker_map_size = size;
+		shrinker_nr_max = new_nr_max;
 
 	return ret;
 }
@@ -321,7 +322,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 #define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
 
 static DEFINE_IDR(shrinker_idr);
-static int shrinker_nr_max;
 
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
@@ -338,8 +338,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 			idr_remove(&shrinker_idr, id);
 			goto unlock;
 		}
-
-		shrinker_nr_max = id + 1;
 	}
 	shrinker->id = id;
 	ret = 0;
-- 
2.26.2

