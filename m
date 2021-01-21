Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59DD2FF874
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 00:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbhAUXI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 18:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbhAUXHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:07:31 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23D0C06121D;
        Thu, 21 Jan 2021 15:06:58 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id i5so2394643pgo.1;
        Thu, 21 Jan 2021 15:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ej4Rc46w5k8kBipb90Kqo5kCs6g2nAP16XzJEvULq1o=;
        b=Wqh1uFbzzPDacscNDMRfxpCDbzIF1XQwIiBMlgS+cV9sRWgHFqXIY9qtEWihLhQ0UB
         rqh4MQ0yYBJpe//Cml1XSs28/ErMUnnsBpuVAz+B5C6d/hbozV2a8Ktt/oq/hzCPaLlR
         /la3I+slLzw6pqS7/2XuIna/9MdSxor9BPj6rbidquQPAFtekFSoTkTSLY8L5wscXEIa
         Kndrh/n/GYE5V9O5aglQOH2T/CPtOGfbNb2wNelQke55C81U/mVos+fGI9rCRVBJDpT2
         RbR1iGoRmB+HdfSoTNaKiAOBRiC55td7OKx01KCVRDBEgwhMVH2FxEaO4DWLRJUP+fZ5
         lVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ej4Rc46w5k8kBipb90Kqo5kCs6g2nAP16XzJEvULq1o=;
        b=b4HBRCwHXptTNXdguohyRyHckbOGg1xb31Q9NN0qb/iyEwh3gE33sJ6S3As6wcaf/X
         TBIfiuYYyOoDyMKCcIHJhyP4PhVYycsMtPHA9dd3FQESIjpYv8SGJh9pWaOO9gEuXGPZ
         0nx6ERTtUlvsUyCYwtaCOftWA5ySKCh+3KZkneb8khm6siANN3CVjWuvICbjmUpZERND
         SlF7YvnP/ZihGTXXgEj7tUVpmrlcgvXXz7gdEfWEWmd3oUcwIivTSW1il5dLGvVnmhqy
         dHVm27XoE8j2XA6rBElG7acY+FE+WQ0g39ve5kQDzCbMPtZEMuF3Hi2HkXy6Q2nqyfHQ
         +ggQ==
X-Gm-Message-State: AOAM5309v3TYZ1y5LB3dY+MKQMifg6+hrhagnZr9zZt4iHTU4O2PllQQ
        krCWFog3nwdYReBK2BNZLuY=
X-Google-Smtp-Source: ABdhPJyNaukOZwbxtacagm3HKlPqsr9jW52mpjA/ls4Ymzr4VY6IHzD1KCGZIgN7gJ/FL+9MOX43Zw==
X-Received: by 2002:aa7:8ad0:0:b029:1a9:3a46:78d1 with SMTP id b16-20020aa78ad00000b02901a93a4678d1mr1709495pfd.77.1611270418325;
        Thu, 21 Jan 2021 15:06:58 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y16sm6722921pfb.83.2021.01.21.15.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 15:06:57 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 10/11] mm: memcontrol: reparent nr_deferred when memcg offline
Date:   Thu, 21 Jan 2021 15:06:20 -0800
Message-Id: <20210121230621.654304-11-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121230621.654304-1-shy828301@gmail.com>
References: <20210121230621.654304-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now shrinker's nr_deferred is per memcg for memcg aware shrinkers, add to parent's
corresponding nr_deferred when memcg offline.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/memcontrol.h |  1 +
 mm/memcontrol.c            |  1 +
 mm/vmscan.c                | 31 +++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e0384367e07d..fe1375f08881 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1586,6 +1586,7 @@ extern int alloc_shrinker_info(struct mem_cgroup *memcg);
 extern void free_shrinker_info(struct mem_cgroup *memcg);
 extern void set_shrinker_bit(struct mem_cgroup *memcg,
 			     int nid, int shrinker_id);
+extern void reparent_shrinker_deferred(struct mem_cgroup *memcg);
 #else
 #define mem_cgroup_sockets_enabled 0
 static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 65d9eb0215b5..cccf2bacb147 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5284,6 +5284,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	page_counter_set_low(&memcg->memory, 0);
 
 	memcg_offline_kmem(memcg);
+	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
 
 	drain_all_stock(memcg);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ea1402e7b968..e73f200ffd2d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -383,6 +383,37 @@ static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
 	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
 }
 
+static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
+						     int nid)
+{
+	return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
+					 lockdep_is_held(&shrinker_rwsem));
+}
+
+void reparent_shrinker_deferred(struct mem_cgroup *memcg)
+{
+	int i, nid;
+	long nr;
+	struct mem_cgroup *parent;
+	struct shrinker_info *child_info, *parent_info;
+
+	parent = parent_mem_cgroup(memcg);
+	if (!parent)
+		parent = root_mem_cgroup;
+
+	/* Prevent from concurrent shrinker_info expand */
+	down_read(&shrinker_rwsem);
+	for_each_node(nid) {
+		child_info = shrinker_info_protected(memcg, nid);
+		parent_info = shrinker_info_protected(parent, nid);
+		for (i = 0; i < shrinker_nr_max; i++) {
+			nr = atomic_long_read(&child_info->nr_deferred[i]);
+			atomic_long_add(nr, &parent_info->nr_deferred[i]);
+		}
+	}
+	up_read(&shrinker_rwsem);
+}
+
 static bool cgroup_reclaim(struct scan_control *sc)
 {
 	return sc->target_mem_cgroup;
-- 
2.26.2

