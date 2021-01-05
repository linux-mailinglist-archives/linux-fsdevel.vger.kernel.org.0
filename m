Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D6A2EB5AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 00:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbhAEXAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 18:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731632AbhAEXAH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 18:00:07 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2CBC061574;
        Tue,  5 Jan 2021 14:59:06 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id j13so560984pjz.3;
        Tue, 05 Jan 2021 14:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c17ObrP6pIXejl0tN7A+aopaXDPRL2YppDlbMJ0mvSE=;
        b=tDqzSggaO61nrhp/sqcOfm7bU0V0LMNT0ZsN95jZJivUd9EtqeGXy38BvfNMee/7+l
         nKG0Y6mRHlVRht0nRcZtH0p5NN9X3Np0GWfBaXkVXG48ooF+N7m4YaTO4AgPbzkQb5vI
         hOZIaFwnttNdnZhEmmmcfjDXbwmosSgqMdIm6SqYaCTcsDFgcbPD6dR0yvSAwvirVlSm
         XZJW67Xv3f54G0Vswq+K8BcTjQgKDoo352vC1mVrmkAkeOO90u5dNOW23YkrF1SRd3dO
         baXzIpqFBhdBU9sqfoP+5dX/5bQPFqy2WxYwMAPN4VepGDH5kzs15Tnq9Jn+P2FPkBj1
         GSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c17ObrP6pIXejl0tN7A+aopaXDPRL2YppDlbMJ0mvSE=;
        b=e9lOzqlcgayLNVJPRVeCUL06ta17bjiztDE2bOGKyISi3JHg7DjnAw/vrXeMCfeQvJ
         T6Gmwts4a+JDV8XioIVnbcjzyBO12dzdppH8EGTgOid5MOWRZhoAcz/VIwmkJZmu9m0O
         5HVJatdp4NyXhZMr99nP3lJGBc6I9IZhMdjj585DS8K012RiKvddjVklLAd6L7iUdM2B
         KiaDBY2Jtemu3SWfee23Xp4b/vvwIW6YpLokv9bRGgLqcP0dU+O3n52PdAFD94W+ivnk
         99C805H+Z+Sb8iaXdyv1/Vnm6WHI1zKtQ+9UoO+pVmUhraz7Fr3P+qzhsZ4Nwb3mFuPF
         strA==
X-Gm-Message-State: AOAM5308SHfWqg8V7NJf0pwpYaCfNE/ticHzSE7/HIsrYv1HxEs5hmz7
        8LTcYpsxMTJXPMbDqyGdGYdS/L/46gLUVI+1
X-Google-Smtp-Source: ABdhPJwM3GKSl7VBuju8WlWtsE8xcxy/o5z2sT9Npe08X1CCSRXQkSoLyg1SdaZVWXQ4a9AcaPU2dA==
X-Received: by 2002:a17:90a:454e:: with SMTP id r14mr1377354pjm.194.1609887546032;
        Tue, 05 Jan 2021 14:59:06 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id fw12sm244233pjb.43.2021.01.05.14.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 14:59:04 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 10/11] mm: memcontrol: reparent nr_deferred when memcg offline
Date:   Tue,  5 Jan 2021 14:58:16 -0800
Message-Id: <20210105225817.1036378-11-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210105225817.1036378-1-shy828301@gmail.com>
References: <20210105225817.1036378-1-shy828301@gmail.com>
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
 mm/vmscan.c                | 29 +++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5599082df623..d1e52e916cc2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1586,6 +1586,7 @@ extern int memcg_alloc_shrinker_info(struct mem_cgroup *memcg);
 extern void memcg_free_shrinker_info(struct mem_cgroup *memcg);
 extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
 				   int nid, int shrinker_id);
+extern void memcg_reparent_shrinker_deferred(struct mem_cgroup *memcg);
 #else
 #define mem_cgroup_sockets_enabled 0
 static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 126f1fd550c8..19e555675582 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5284,6 +5284,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	page_counter_set_low(&memcg->memory, 0);
 
 	memcg_offline_kmem(memcg);
+	memcg_reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
 
 	drain_all_stock(memcg);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d9795fb0f1c5..71056057d26d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -396,6 +396,35 @@ static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
 	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
 }
 
+void memcg_reparent_shrinker_deferred(struct mem_cgroup *memcg)
+{
+	int i, nid;
+	long nr;
+	struct mem_cgroup *parent;
+	struct memcg_shrinker_info *child_info, *parent_info;
+
+	parent = parent_mem_cgroup(memcg);
+	if (!parent)
+		parent = root_mem_cgroup;
+
+	/* Prevent from concurrent shrinker_info expand */
+	down_read(&shrinker_rwsem);
+	for_each_node(nid) {
+		child_info = rcu_dereference_protected(
+					memcg->nodeinfo[nid]->shrinker_info,
+					true);
+		parent_info = rcu_dereference_protected(
+					parent->nodeinfo[nid]->shrinker_info,
+					true);
+		for (i = 0; i < shrinker_nr_max; i++) {
+			nr = atomic_long_read(&child_info->nr_deferred[i]);
+			atomic_long_add(nr,
+					&parent_info->nr_deferred[i]);
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

