Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAC4334568
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 18:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhCJRqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 12:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbhCJRqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:46:23 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B815C061760;
        Wed, 10 Mar 2021 09:46:23 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id w34so10807732pga.8;
        Wed, 10 Mar 2021 09:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8qnm1r39F1+nLF2q+MJEWtJZ2OA03LbHXXfmJXBg/bU=;
        b=bQha59oGw/ATUzMVQxON9irQJ6V4Iq4VT34my0MPRxVqoD3pc3R7GOZ4Ihw9+D3w7J
         QbcWdPEOKc7kLp9evqhFteAsW6sH5UhtJNH9G8COXvScubfZr5yqOEPqb6FpdRZ1d7z7
         IH68e2svWzJIzb+jG1kbN/SK5aHjP1dtN9op49wnjmKxIzjTUusOBvm5SD52yI2sOXN4
         LCEZYzkLc1103vE/bmiPc59xEU2imubQ8rKnH7rx2ssNjYyNBPTQy2XSHdGOLD/e/qQV
         UbBghQvT4rK1Hea+MZEy2+QfEqswO7+A4Vj4uIq2h9AMIUk5AzoqbOzCpuTf62uCGU/D
         A9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8qnm1r39F1+nLF2q+MJEWtJZ2OA03LbHXXfmJXBg/bU=;
        b=ZXJHIuM88xhKjc7deP0m5BCtlN5XyehqoTZ/dS3GbEvwMZIFAEIg5zSXBdvXB976JC
         PfdIMSE6wiUUOnkfGXJ2d0d9qaJ4Odmg/sE9PZTfwgi9V2RH47kBLexTgadocjCk3uyJ
         2dAFV04qnVRskMplfdFR1q+qxF1VNX074Jf7dfexaEJaa1HY7LeECI6kr2x4/HvZsb05
         NeeCEoJfDrdBiyo1JWfNyFcS9MbnnZSMrsWfLXKmvgASwQvN2HVuL2ZAF/FBJdm1KsoP
         1q6ipKnsVYvtGg5QuZNVM4UplSH1PTSDG0kMfVps80jMMocg1ip2PFNG++OacC4xs0j+
         hiYQ==
X-Gm-Message-State: AOAM5339FNHHWQv4MymBusO1l0VhTsW1sDEWkbkmBdJyqBH+O4mWXH9S
        6rLvIKfk2disT1Owl6DTjxw=
X-Google-Smtp-Source: ABdhPJzBn8tAF3hvcNEKpLzZbv6EQt380V9sSRJOIaoGi/hfNxA10rSwz5p+lofpE1kxGrEMUTQNhg==
X-Received: by 2002:a65:6642:: with SMTP id z2mr3695109pgv.214.1615398383207;
        Wed, 10 Mar 2021 09:46:23 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d6sm145804pfq.109.2021.03.10.09.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 09:46:22 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v9 PATCH 04/13] mm: vmscan: remove memcg_shrinker_map_size
Date:   Wed, 10 Mar 2021 09:45:54 -0800
Message-Id: <20210310174603.5093-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210310174603.5093-1-shy828301@gmail.com>
References: <20210310174603.5093-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Both memcg_shrinker_map_size and shrinker_nr_max is maintained, but actually the
map size can be calculated via shrinker_nr_max, so it seems unnecessary to keep both.
Remove memcg_shrinker_map_size since shrinker_nr_max is also used by iterating the
bit map.

Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 75fd8038a6c8..bda67e1ac84b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -185,8 +185,12 @@ static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
 #ifdef CONFIG_MEMCG
+static int shrinker_nr_max;
 
-static int memcg_shrinker_map_size;
+static inline int shrinker_map_size(int nr_items)
+{
+	return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
+}
 
 static void free_shrinker_map_rcu(struct rcu_head *head)
 {
@@ -247,7 +251,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
 		return 0;
 
 	down_write(&shrinker_rwsem);
-	size = memcg_shrinker_map_size;
+	size = shrinker_map_size(shrinker_nr_max);
 	for_each_node(nid) {
 		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
 		if (!map) {
@@ -265,12 +269,13 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
 static int expand_shrinker_maps(int new_id)
 {
 	int size, old_size, ret = 0;
+	int new_nr_max = new_id + 1;
 	struct mem_cgroup *memcg;
 
-	size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
-	old_size = memcg_shrinker_map_size;
+	size = shrinker_map_size(new_nr_max);
+	old_size = shrinker_map_size(shrinker_nr_max);
 	if (size <= old_size)
-		return 0;
+		goto out;
 
 	if (!root_mem_cgroup)
 		goto out;
@@ -289,7 +294,7 @@ static int expand_shrinker_maps(int new_id)
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 out:
 	if (!ret)
-		memcg_shrinker_map_size = size;
+		shrinker_nr_max = new_nr_max;
 
 	return ret;
 }
@@ -322,7 +327,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 #define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
 
 static DEFINE_IDR(shrinker_idr);
-static int shrinker_nr_max;
 
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
@@ -339,8 +343,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
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

