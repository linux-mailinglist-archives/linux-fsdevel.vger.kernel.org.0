Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9874392759
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 08:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbhE0G0D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 02:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbhE0G0B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 02:26:01 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C226C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:24:29 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 27so2935621pgy.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q7vJMAr6kcKAU4X210/nbOxFkuInBwsFSpIer8aaFUI=;
        b=MJSyMYT7SXXVY5RKfMgD9gPHEWPZfFgJ4hyxtY+uBDRdgQ5e7Oit1Zx3N5s4m0xdRY
         jCfKSSNkrcdj4bSRih64lYEPhpVfJ8HvTeZpPvnpy2xV0P99YtQdGo/K8pndCpAFNasx
         BNf2rQQzAIJ7upbjmJzl+74rmrW+Xc0nOiWprLlOVWCUBpLYVyR/sHGux9KprYmeuEZN
         1EV6dB1bpOPrIWrVk+bseaN9DWHVOP4BrUdVSLwsaxxx4+tfRwrKQfnLKPEmAciAVwOa
         IBmHlybm2A/ZVmivR0R/FIl07T1NMscahzhc1EBy2pbgolJGn8qGnKVAd0epw0ZzjuEI
         zgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q7vJMAr6kcKAU4X210/nbOxFkuInBwsFSpIer8aaFUI=;
        b=ZebHBq/l0FRk2KwKm9FAT86pzCJ/FFJQd00ezAWLrWhJ+R04P0HTMMIwxfssnqSYhW
         FS5av1K2vPeG5aTUjY8/31oNtsfjimVR5vOtJifZp7PxR0UfvdB/cPhSUEwz/3WjrEpu
         2FSANV4ojGNBd5JWRBZsON5Bitizf2RQEmygBjoIHxrov7RtU7OyVeY2UjbBO+hvKsNT
         2CL3aefzwi/OwHybF0buDN9FuLBJV4uaVlHEl0UQW4F0zN/UpuLO1UOz4SztN8idP9JP
         MB/6hFbYpoSYnZ+5IYwMmuwC0vHONuDoWhgcUqeL5q31LSXZu/QlmofeGtt6eCMAoJ9Q
         I/Hw==
X-Gm-Message-State: AOAM532jnMlaPRUB1/wTRWXrfmbQYmtpf75SvT0hrqI8YMf2B97PRLLp
        +E3XQl3bFGXxojw2kbQ/MW1cew==
X-Google-Smtp-Source: ABdhPJy8Bw2nz9uQDINiomY4QIvSyT7wuAqcIJ8o4jUTbLhRRcBzsCGLwm+NacVvN/K7nNkk9DkQ/Q==
X-Received: by 2002:aa7:8491:0:b029:2dc:b1cc:5532 with SMTP id u17-20020aa784910000b02902dcb1cc5532mr1862562pfn.3.1622096668689;
        Wed, 26 May 2021 23:24:28 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.24.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:24:28 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 02/21] mm: memcontrol: remove kmemcg_id reparenting
Date:   Thu, 27 May 2021 14:21:29 +0800
Message-Id: <20210527062148.9361-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since slab objects and kmem pages are charged to object cgroup instead
of memory cgroup, memcg_reparent_objcgs() will reparent this cgroup and
all its descendants to the parent cgroup. This already makes further
list_lru_add()'s add elements to the parent's list. So we do not need
to change kmemcg_id of an offline cgroup to its parent's id. It is just
waste CPU cycles. Just remove those redundant code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index db29b96f7311..9add859f69d7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3654,8 +3654,7 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
-	struct cgroup_subsys_state *css;
-	struct mem_cgroup *parent, *child;
+	struct mem_cgroup *parent;
 	int kmemcg_id;
 
 	if (memcg->kmem_state != KMEM_ONLINE)
@@ -3672,22 +3671,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	kmemcg_id = memcg->kmemcg_id;
 	BUG_ON(kmemcg_id < 0);
 
-	/*
-	 * Change kmemcg_id of this cgroup and all its descendants to the
-	 * parent's id, and then move all entries from this cgroup's list_lrus
-	 * to ones of the parent. After we have finished, all list_lrus
-	 * corresponding to this cgroup are guaranteed to remain empty. The
-	 * ordering is imposed by list_lru_node->lock taken by
-	 * memcg_drain_all_list_lrus().
-	 */
-	rcu_read_lock(); /* can be called from css_free w/o cgroup_mutex */
-	css_for_each_descendant_pre(css, &memcg->css) {
-		child = mem_cgroup_from_css(css);
-		BUG_ON(child->kmemcg_id != kmemcg_id);
-		child->kmemcg_id = parent->kmemcg_id;
-	}
-	rcu_read_unlock();
-
+	/* memcg_reparent_objcgs() must be called before this. */
 	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
-- 
2.11.0

