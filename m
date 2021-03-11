Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B76B337D49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 20:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhCKTJv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 14:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhCKTJ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:09:26 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF62DC061574;
        Thu, 11 Mar 2021 11:09:25 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso9822832pjb.4;
        Thu, 11 Mar 2021 11:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=387U6EUXBh7mLus/UDVh51X6DyrD4kEMfbx59TkIzlA=;
        b=ckPBzV+wjhR0jD6bD3xGl+wIqtfYTy22s8zEq9ESXN0mhXp9+zcVvvHlw3gxtFQPKT
         HRMXK7vIOLygJ54Uifyobx+ZVSjYyKNy3EUYp7N5A10/cn2ZlqM0x+OH6NI47iSMV4Gk
         4oOY5NFCM5rH6st4OXi5JWySRl05hCS+SFhxmvxx5l8B4JLWzDBzbIIbNXgy3SHcEtEE
         cq7hJO5htnHv3DWlJ4wTfFnmUCijyxR70rjXUGMmOLGtWrctfVpkI9sxv25xJGWaF7O8
         gpY+b5g+vtqaSyUqWYe3TJ8T90RfZZDRKBWkwBB3zzBgYF9r0WMGR5MI5AP4mEGB6cxk
         03jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=387U6EUXBh7mLus/UDVh51X6DyrD4kEMfbx59TkIzlA=;
        b=UQZljw/7loRn+IBIruo3/HU9KtVt5F3Ms/g5P0fIRY/KD9AwaS2VGbkH+wUo02vZuo
         2dhiwaIi/duVh2+ALR8rv54qAoxlvQm+cKBAzGSFoVHe6TbFyN+TsQLG4SsrLIEboaQY
         Lw1VvbsIUUQ8TgHLSEk5GygZTNLrhr/q9qUKEvXEg0oQ4djxu8WolVQQQBOQNNl9/D09
         mkZQuDVbUtYpjZEDwWU2CM7y6zj58bz0hiVLCgW/7M7sACIVYxKpYfuglxNxepq4pmVp
         l4D7oh/BclpjqAKfg+JODA4tBsWJ5OF8m6suJ8neGTi6uRiWkh4cVkycyq4IqPQljhEG
         E6aw==
X-Gm-Message-State: AOAM531rKrFQ1wWuBY5Iq1HRcd+Izk/O1oMlDGs9J9CdF8B9ENocF+wI
        kTw6+lrwD135GPnE947tl3E=
X-Google-Smtp-Source: ABdhPJyQw3LropgZkq0gCBA33nFDKXoIlKKNSZisQrGtPL1ucO8aoBJm/2M9nRLHLxAcIIw7eGjC5g==
X-Received: by 2002:a17:902:d64a:b029:e6:30a6:64e3 with SMTP id y10-20020a170902d64ab02900e630a664e3mr9933203plh.28.1615489765521;
        Thu, 11 Mar 2021 11:09:25 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id t12sm2999111pfe.203.2021.03.11.11.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:09:24 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v10 PATCH 12/13] mm: memcontrol: reparent nr_deferred when memcg offline
Date:   Thu, 11 Mar 2021 11:08:44 -0800
Message-Id: <20210311190845.9708-13-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210311190845.9708-1-shy828301@gmail.com>
References: <20210311190845.9708-1-shy828301@gmail.com>
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
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/memcontrol.h |  1 +
 mm/memcontrol.c            |  1 +
 mm/vmscan.c                | 24 ++++++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 24e735434a46..4064c9dda534 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1537,6 +1537,7 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 int alloc_shrinker_info(struct mem_cgroup *memcg);
 void free_shrinker_info(struct mem_cgroup *memcg);
 void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
+void reparent_shrinker_deferred(struct mem_cgroup *memcg);
 #else
 #define mem_cgroup_sockets_enabled 0
 static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 35d44afdd9fc..a945dfc85156 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5167,6 +5167,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	page_counter_set_low(&memcg->memory, 0);
 
 	memcg_offline_kmem(memcg);
+	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
 
 	drain_all_stock(memcg);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 324c34c6e5cf..d0791ebd6761 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -397,6 +397,30 @@ static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
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

