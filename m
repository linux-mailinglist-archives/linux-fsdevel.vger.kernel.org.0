Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A259130E0DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 18:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhBCRXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 12:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbhBCRWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:22:20 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6981C0617A7;
        Wed,  3 Feb 2021 09:21:31 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id w14so266930pfi.2;
        Wed, 03 Feb 2021 09:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nUMzA/3BdE993wfDsCQXdvkjPYfyPVaNNJORKwDz80c=;
        b=LfePu6UejxvQdOh2GoD/fAj3ONicQbkZc2mxXNU+hyyYQdjy+n01l4dwHIL3TDJNHO
         AdoGTQBnvO8yWixQGBdGasySYE0ZZ3RDXxzE7Mej7z0noxcd+JARknsNgIQnql7xvO85
         VH6SJ/HLz90ywXZizbp/ooQSNn+GF27tDVTEhVwcPnwp6a3CuVS8QdSPFULH10IXLefO
         BxNVxluFNk8His5xm6J3gzqJQ9Uw+kheGFOarhrreg5auDg37mVW2H7ahS4n5W8J8N/E
         mspkFr/a4UqQxVP+K2DmWtfNLKcri14wm/mD+aAZPFOZDWMO28TObbEeRckub47dLOJF
         W2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nUMzA/3BdE993wfDsCQXdvkjPYfyPVaNNJORKwDz80c=;
        b=hDY7lxcEAbHfRZLvqjYCG8qOtJt463TSn9+21ETAmtoiXMc+J0igHOERWKYJGUT9U1
         kslzUNVBiKXp0UOEXdJkA3N2Rt9WGpKuShATwVG3vNzqxwZceA1HhUZGokl0Wa4xuF2/
         UQ+l8UGbKcJmOC2sp/xbP2dQ4HU3KAK2j9Ct079JkAqPbsG6l0ayvUGxzmaqd0W6Eaxb
         9WmZwG29rhlLp3hTBa5coF9bBqlaKcXmYrBc6xz0ia0hZ6cQnZ+qROdYZ75ivRuOO4S7
         o0qtfcGmP1YCulMoVb6XdhbxzVuQJwL1EHi+jhc7RtHup1PJKC+EPSRoLiKBSJZoPs4Y
         RF9A==
X-Gm-Message-State: AOAM532joMU+y0x+7dCdpETk2OePLhIC5kJg+z+zUosLv286aN93w7DQ
        oSlht0rKchLko4PnGWJg2I8=
X-Google-Smtp-Source: ABdhPJxZ85kIgUNuaFI1hCRoW+MvELqUQ5WPGXjcXFhMMHfHj4lg+FZdDFrWcWpXQWIVRJnKqH+SuQ==
X-Received: by 2002:aa7:8881:0:b029:1b4:5b52:b00b with SMTP id z1-20020aa788810000b02901b45b52b00bmr4015162pfe.47.1612372891539;
        Wed, 03 Feb 2021 09:21:31 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x21sm2368636pfn.100.2021.02.03.09.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 09:21:30 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v6 PATCH 10/11] mm: memcontrol: reparent nr_deferred when memcg offline
Date:   Wed,  3 Feb 2021 09:20:41 -0800
Message-Id: <20210203172042.800474-11-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203172042.800474-1-shy828301@gmail.com>
References: <20210203172042.800474-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now shrinker's nr_deferred is per memcg for memcg aware shrinkers, add to parent's
corresponding nr_deferred when memcg offline.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
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
index 20a35d26ae12..574d920c4cab 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -386,6 +386,30 @@ static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
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

