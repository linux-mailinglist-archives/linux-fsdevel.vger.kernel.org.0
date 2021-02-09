Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A822B3155A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 19:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhBISHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 13:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbhBIRsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:48:10 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17260C0617A7;
        Tue,  9 Feb 2021 09:47:30 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id w18so12357841pfu.9;
        Tue, 09 Feb 2021 09:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vxSQstCm0rFqXMJSzTOrbGMjufuS8TCQJNnJKNC7TU=;
        b=kWhwJCn2HSplrJKmcFdUT8xE5+TrhsIvBVUakU3FxNw0V+tHRbkhT9QhFviWZpXngw
         O6YPg2xJbS+4A7+wI4BykkTC/dfls4ro1MyqlcWXEt7q+G83CsFdata9Mmc25DFWYEbi
         HyIGwQJUnNONeORegAXbOu0pWHI0/jWS0cEEFzSu30Nr0SftX+v2gBHde0oymvzY2Az9
         Scfy1oEoB/gGsaxcDcKKiKleTcg1o+YfHeGd2wv/OX/ugFUI9/6xc8cepfppZsLWfj4i
         3JsngITGO7n9ZlSdRCLEd6CUuCtvosTId5gZo1cxNtaM82gjTd/dQhC6trwkZerSrsdP
         3GWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vxSQstCm0rFqXMJSzTOrbGMjufuS8TCQJNnJKNC7TU=;
        b=d8ZYFioTNfY7asbUmJkscrwdMo54ARiOlzqiBz5TxfKqhI+tKYuupO9U4WoM96CYXJ
         oVFM2iPT2CPRogT+MBJ6bbvBc52efJWXaIzueLNQ1+SuQUaWAFvHPuWg0LUvAfm5kn07
         5K0OVO37eSdEUIxjDz+TvQv0wSFPB8ziFD7WVI9t8nP/MMBDzzu0rpk6BWsUKocBML/l
         A5nCm6rwzvEmuQGXu3kC8M7Ly62stq8Jk805ne7k14OxDc2G7jHx8k91uyOfRMC5YBPH
         ot4aid/tUlPoZuTKRChS2ZfIoVKfVhz/Cofe/KJ/VBv8sY6KlUsEDtIkdarfBpCAUohJ
         LVvw==
X-Gm-Message-State: AOAM532v0lLEvK6X+kpziPlaITY+wCNnbzg4LNZHgOykM9eaY3YgmLCI
        yrrkEN7qGwi+hZRu98PhfR8=
X-Google-Smtp-Source: ABdhPJyb1163li3Zilu1BpE4OXhPrvUfIC+orUtZkhePoodhjE4yilOtjb1DQgGcYyBK0qRpqo9ZZw==
X-Received: by 2002:a62:b60c:0:b029:1dd:f110:b27d with SMTP id j12-20020a62b60c0000b02901ddf110b27dmr9796973pff.42.1612892849699;
        Tue, 09 Feb 2021 09:47:29 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id j1sm22260929pfr.78.2021.02.09.09.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:47:28 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v7 PATCH 11/12] mm: memcontrol: reparent nr_deferred when memcg offline
Date:   Tue,  9 Feb 2021 09:46:45 -0800
Message-Id: <20210209174646.1310591-12-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209174646.1310591-1-shy828301@gmail.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now shrinker's nr_deferred is per memcg for memcg aware shrinkers, add to parent's
corresponding nr_deferred when memcg offline.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
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
index dfde6e7fd7f5..66163082cc6f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -389,6 +389,30 @@ static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
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

