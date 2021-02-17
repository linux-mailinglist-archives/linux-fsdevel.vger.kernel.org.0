Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C838731D351
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 01:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhBQAPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 19:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhBQAPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 19:15:11 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757ABC0617A9;
        Tue, 16 Feb 2021 16:13:55 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id c19so356510pjq.3;
        Tue, 16 Feb 2021 16:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GTXH9pU4UKvAeIiKlIuVYFEP3dOyBTmqLQ92jrFsTbY=;
        b=mhHHzKvtD90ogbwP0/K8kvPhFu2KAfiTc5QtEhGBbxt+Mb7fSTrStvGppXl9QXOypN
         SazTKsi8EowW96OwiEgtWaPT7e5yo4OKVvZDPgWwdJGdP1nF54Pc3hyQE3Z2J+StOCiV
         DpwBPNEoeirEHEdNsQdeRdQK2gTbVCCfMfacsfLPU5sT+RKu9nfzi0KUyruFIYrpvTku
         oYvfRJsDPRILjSZ2xuRO98HNvDdaA45MP5A8mnCt6rvsi56MMfPv3qhkrgQ4qQ2vv5zB
         QQ9b56NjjLtscCrZeme0cZprSZkmtqXE371xPBETREEtDSwfCwyJaJU72ytMZTJoK6ZI
         xzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GTXH9pU4UKvAeIiKlIuVYFEP3dOyBTmqLQ92jrFsTbY=;
        b=GMHq38fmcAPvjQg4VnWAxXNLjhTBDqdXvAiusXljHzV3wyxE6rE1d1s66aEYG9m/Qm
         XSshT394xlo8ZQNkxo5/bgbGafnkpVymK8auhPwZSqbyrpV+CrtGZJjXGxRh/P3chLHP
         PfnAlqmN4q9Lc+P+AdxODpGrwRAvpWDRNedIOTJrbzCLhdgVGKU3bb+MXFrC8XnNk5yc
         zL7965F5Rn0ciP1HN/FOLoCSF/tpIeCzbUvtynsaBD6M8hcrM6nsWjaIekEoDhYY1M3K
         qnijVv23DXpuBTSFbdrZl2+qSSawrc/Xk9YSqyU9STgV+Kd7r1qgdgegiH2UmegX2GrT
         RoLA==
X-Gm-Message-State: AOAM531FKd9jlcrd51wj9klqbTvtGBXi6C9w+LTvIgNbNrJ5T+UERL1E
        aq72DG7/jBGs9WLN7IfpB9Q=
X-Google-Smtp-Source: ABdhPJzjx38X/6z2lktUcBE2x/989ultR6wYHYlPOfUHfDB0TvkaLepuyhOH/fcjg2aO8iUuqVhjUg==
X-Received: by 2002:a17:902:ed0d:b029:e3:76d8:79de with SMTP id b13-20020a170902ed0db02900e376d879demr4980227pld.36.1613520835093;
        Tue, 16 Feb 2021 16:13:55 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y12sm99220pjc.56.2021.02.16.16.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 16:13:54 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v8 PATCH 12/13] mm: memcontrol: reparent nr_deferred when memcg offline
Date:   Tue, 16 Feb 2021 16:13:21 -0800
Message-Id: <20210217001322.2226796-13-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217001322.2226796-1-shy828301@gmail.com>
References: <20210217001322.2226796-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now shrinker's nr_deferred is per memcg for memcg aware shrinkers, add to parent's
corresponding nr_deferred when memcg offline.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/memcontrol.h |  1 +
 mm/memcontrol.c            |  1 +
 mm/vmscan.c                | 24 ++++++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c457fc7bc631..e1c4b93889ad 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1585,6 +1585,7 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 int alloc_shrinker_info(struct mem_cgroup *memcg);
 void free_shrinker_info(struct mem_cgroup *memcg);
 void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
+void reparent_shrinker_deferred(struct mem_cgroup *memcg);
 #else
 #define mem_cgroup_sockets_enabled 0
 static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f64ad0d044d9..21f36b73f36a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5282,6 +5282,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	page_counter_set_low(&memcg->memory, 0);
 
 	memcg_offline_kmem(memcg);
+	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
 
 	drain_all_stock(memcg);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d8800e4da67d..4247a3568585 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -395,6 +395,30 @@ static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
 	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
 }
 
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

