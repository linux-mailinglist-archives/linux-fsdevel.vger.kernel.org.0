Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2B2337D40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 20:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhCKTJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 14:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhCKTJI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:09:08 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695CBC061574;
        Thu, 11 Mar 2021 11:09:08 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id c16so10713098ply.0;
        Thu, 11 Mar 2021 11:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x5MgFJmx+qCDHDBM5m9Z4h2MfyiNvh6Fg7+MEJeG5Hc=;
        b=hXphMEKp+eXWbBLvMNGFTgWa2pZEr+COjecriAAxFhNEeooa/BbyJ/YAUkkA5wytZg
         1AOGSEuDCvR6ZGXii+4K3P587qy73WiAQZneeJ7C0uD7Z0mWY+a/BVm80vwEktHPLVTL
         h0JA6lJ4dixnOPuJ+vtVuF6X3lHth7AamKG6/i7xTYqmvTrxQhTaXeydTKIhQQ8uyErC
         cARoNTMaCQIoEqXH/PxRgv7SeHSbS16T9+VEylrr+clF2S7LDC5E05N64ru7HbzhA4pX
         0jtq6H5/L4hmEqQHSIWq/c/kIuUfTpqG0Y+azFNdJvwnwW6cfCDMFHKjSJgtsN4MUgSl
         ZsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x5MgFJmx+qCDHDBM5m9Z4h2MfyiNvh6Fg7+MEJeG5Hc=;
        b=GrBZDOmE8DyTKfwd5fUhl8wFHKx5BTVSVqpnBj4O00Y/zjxdrFUm4bE2qhNbeLhsXe
         liw1xGd7fDf3PC8q5+4SEjwvz+ycR0UwdXp61IzBLlAC+NOqlnTyfZuIU23Ge4lFKbQz
         cReCmXkE1jD2I9h1u4wk2HnltkL2rv1GjYzUm94Ktg2glGyzxqMfWjn3jiRvTZf9zQO2
         ruE8BO/C3VbiMjTxo2hELGm2wmXk8U5a8wxdeQzZBVa49cYJjhRgliq8EqTVy/vhLji0
         dTBJC8QnH5G9eV861WNJIoBHLCp44GQ7zoGP9Ygl5ww9ARfRipntD8rMu8CRbZtwDn3s
         mvLA==
X-Gm-Message-State: AOAM531diJWDZMPRdrW+3ay4qIo6hIX3XUZQ7Lg+1bfzhePd/dO0JDkn
        /hhNfwAmcULwt3mZG2eE3Qg=
X-Google-Smtp-Source: ABdhPJxjyKooM+K/uNd8RQ5pj9o2KzidC1fcsHNXVoUBXa8795yLlGRklotc+LNSeYmurtCbsO8ZbQ==
X-Received: by 2002:a17:90b:3553:: with SMTP id lt19mr4840931pjb.222.1615489747922;
        Thu, 11 Mar 2021 11:09:07 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id t12sm2999111pfe.203.2021.03.11.11.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:09:07 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v10 PATCH 04/13] mm: vmscan: remove memcg_shrinker_map_size
Date:   Thu, 11 Mar 2021 11:08:36 -0800
Message-Id: <20210311190845.9708-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210311190845.9708-1-shy828301@gmail.com>
References: <20210311190845.9708-1-shy828301@gmail.com>
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
index b08c8d9055ae..641a0b8b4ea9 100644
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
@@ -248,7 +252,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
 		return 0;
 
 	down_write(&shrinker_rwsem);
-	size = memcg_shrinker_map_size;
+	size = shrinker_map_size(shrinker_nr_max);
 	for_each_node(nid) {
 		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
 		if (!map) {
@@ -266,12 +270,13 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
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
@@ -290,7 +295,7 @@ static int expand_shrinker_maps(int new_id)
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 out:
 	if (!ret)
-		memcg_shrinker_map_size = size;
+		shrinker_nr_max = new_nr_max;
 
 	return ret;
 }
@@ -323,7 +328,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 #define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
 
 static DEFINE_IDR(shrinker_idr);
-static int shrinker_nr_max;
 
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
@@ -340,8 +344,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
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

