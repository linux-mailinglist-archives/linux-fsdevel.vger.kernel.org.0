Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D34D30681A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 00:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhA0Xjf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 18:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhA0Xfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:35:37 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BD0C061797;
        Wed, 27 Jan 2021 15:34:14 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d4so2051762plh.5;
        Wed, 27 Jan 2021 15:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rtMUSqzuW0mmPVrpVmtzg3xeLjYzKxf0vIpZFRWhJNw=;
        b=IK7YmjHgj3pG2Gx8I4pi5CXEEK/MPNLJUX4VO9Jdoy/OhHpqD4N9Rjybc3tE1VprDL
         faSkbMaZzSd+bXQJfD4wq3KQ+rS+HR6XRRzQatXUhi3fcnuH786tYm+8LpHKV8oINHnC
         x3ih9cNljKRSf1cnl7ytq9eMTTqSA14ESeIVH7QMzIXStQxo6pfiI47aUCdph1Trlhc4
         udhsPCMwEfjg6Swin7MBa6JurkEsyX3wvV5tlL5oibECFNES/9DjFgfZabm5IWGD8cgp
         WYU8ECzM6bi9wEzHsAJHbDQ4i9wx/++eUPrBv+6UWIFqhabLqRtMe3seEOYCHAAXBRfr
         j+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rtMUSqzuW0mmPVrpVmtzg3xeLjYzKxf0vIpZFRWhJNw=;
        b=tbRiq2BI1x+72mp1yNAHUPVpnuArq8GcO2O+9qfZ/Cp5YK/x2ae5mSatHSgxz/Lsqg
         Kki2jfX49/DVngEV/3EfH3Day9XvdUV2MshtYbV8cdwOqqqNHf69tadQnhbpf6wYZNRr
         JH595qOrPMTwxu4S1sSuHVUqdxbyYmTvY8t1UZq/UBLFN7OTHSf2xflZjPHo2b8YFLS/
         FYD41mZdFmleOeptwGZgA5+eajdzmCC2e+sDQdPkR7ED38iXn87IpNRt8e71LrnkyHcZ
         dsf94FrL7X0N1qkrU2WpgnqOiiJPPhSeW/j57a9389GM5V/KFxxz6Z1DPB3yMp92PdJu
         E7Uw==
X-Gm-Message-State: AOAM532sp4bamp9aiMce97Xg2SwhMYaICfwtOKChwKPY+QUdqxKbQihy
        bgQLqM109o5V4xV9D7AaCUHnoJVhhEZYKQ==
X-Google-Smtp-Source: ABdhPJwJbUr7AEV5afH0AkrswES2yI+fQ1dNzepkpXY5WMSGLXOLIFnWa24NcIjMjMn7Ku8CPLOEgA==
X-Received: by 2002:a17:90a:7e84:: with SMTP id j4mr2214547pjl.167.1611790453815;
        Wed, 27 Jan 2021 15:34:13 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id 124sm3498648pfd.59.2021.01.27.15.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 15:34:12 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v5 PATCH 10/11] mm: memcontrol: reparent nr_deferred when memcg offline
Date:   Wed, 27 Jan 2021 15:33:44 -0800
Message-Id: <20210127233345.339910-11-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210127233345.339910-1-shy828301@gmail.com>
References: <20210127233345.339910-1-shy828301@gmail.com>
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
index 0373d7619d7b..55ad91a26ba3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -386,6 +386,37 @@ static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
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

