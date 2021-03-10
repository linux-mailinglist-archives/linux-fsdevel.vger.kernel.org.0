Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE5233458B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 18:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhCJRrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 12:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbhCJRqk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:46:40 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1676DC061760;
        Wed, 10 Mar 2021 09:46:40 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y67so12635546pfb.2;
        Wed, 10 Mar 2021 09:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G7y5azUFXSsyavdHIsaT9AMO5ymd4GoyVzQs6Ax3Mec=;
        b=s23IbToCEQiW2LfwWgwPLKu/K9irz9puJBxy4pj77zsIN1F4mhp6kFZ0fvAnr8bRW/
         nix8GUrtk1m2rNPjffKA5w++RSNotRLG7AMG0xYRpHpPfBFWIUw4cF40Z2oBVIdBfUGA
         868+iPgOzhmkwBGjSPjYxsi0LRNDzHWeu72Dqiv+ZVOhlsmhAMYW2MgSvsoUx0am3akz
         BBQWSKepzU2L5MzrdVv24FZ/ZWf60yQVGJVNFsVXol0aW3SU69apMVL+roJ8a/GFu7A6
         rlkKCAnvXOe/sHkc1noaSpLzmzsINLfKBvsYZEASTt4GBr+owzhw8Aj4afFDFZALePnS
         Qatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G7y5azUFXSsyavdHIsaT9AMO5ymd4GoyVzQs6Ax3Mec=;
        b=BpVegxsnno3qBDA12enw704Q8umXkDsEkZiEPe06pSil+lwCep7lozwXqM8cnODblv
         VbWJmUEBWegL/3ZG8rW4xnWNmZ4R+ChYxL4CqG8+l3XMQ93/egHCMBtfahTGKdONchFe
         Yj4+5dVaui8WFROa8pOYL7Bb65N1IQbf9mVPsi1z/ZcZnfsCprf4pxVWj9UHWRBlm8vr
         T0R1BBsxIBYbQrgAzZCsg6RLZfr4sGycmlZ12LTtOWWOygSKHF6I/QQqUNB6xiuDumhN
         iq47pplSfkHEyNl954N98gO7LcTEgG3DcdTWs/hk+P19vuo1N92GoeCSpv9wUPmaSM0c
         XSVw==
X-Gm-Message-State: AOAM532+QcxQJ/9THYp0kV8CuW7jeICXsfYskArmi9a6nHUV2zMfn4xT
        5O0JYBVqgE25cTW1oOEek+U=
X-Google-Smtp-Source: ABdhPJzvRhb2rWON3l0wObFgGYmePKCSygAJAPGbZZV40nSzwpJc9kOk6TMgIw6aZvx6zbZDlOoUew==
X-Received: by 2002:a63:2a16:: with SMTP id q22mr3743667pgq.211.1615398399711;
        Wed, 10 Mar 2021 09:46:39 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d6sm145804pfq.109.2021.03.10.09.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 09:46:38 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v9 PATCH 12/13] mm: memcontrol: reparent nr_deferred when memcg offline
Date:   Wed, 10 Mar 2021 09:46:02 -0800
Message-Id: <20210310174603.5093-13-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210310174603.5093-1-shy828301@gmail.com>
References: <20210310174603.5093-1-shy828301@gmail.com>
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
index 42a4facb5b7c..2c76fe53fb6d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1569,6 +1569,7 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 int alloc_shrinker_info(struct mem_cgroup *memcg);
 void free_shrinker_info(struct mem_cgroup *memcg);
 void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
+void reparent_shrinker_deferred(struct mem_cgroup *memcg);
 #else
 #define mem_cgroup_sockets_enabled 0
 static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index edd8a06c751f..dacb1c6087ea 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5262,6 +5262,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	page_counter_set_low(&memcg->memory, 0);
 
 	memcg_offline_kmem(memcg);
+	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
 
 	drain_all_stock(memcg);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index cf25c78661d1..9a2dfeaa79f4 100644
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

