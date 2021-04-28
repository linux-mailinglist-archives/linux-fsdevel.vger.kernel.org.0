Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3303936D512
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 11:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbhD1Jy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 05:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbhD1Jyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:54:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7530C06138B
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:10 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a12so1056924pfc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m1CFbU+mCktpHQ1dKqvusnGfjIT06imnu2MiKnHY6nk=;
        b=v4VjCZlNqoTtno1oSp5L516Q2Oq7puICK/nvOGS2G21b+Zf8dDbqpbPxbXBFaxZyPX
         +9XX3GF59psC7dYErKQ1Wd1WNsQ+vI7dYeuNft1Ozh+O1wGMo22QQASc86eHBg+p/taX
         0nt80fb8lIzpAY70hZqGDF1imMiyDa8M/NsPH3xct7MNOLYD0cR3yy9FOLpKSE51hOFh
         hoyOIPv/848DsYPW8PmuRPui51Ovt41Nq0xw0czJphN9QGOR5l8mxqA0xVizRBGv80Dm
         V7n+ezDBiebnuPwdwgVwZO118XmqHJVIwU+D7QP07FQozcA5XNWoYM4DmScmZFDqI3Fp
         cdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m1CFbU+mCktpHQ1dKqvusnGfjIT06imnu2MiKnHY6nk=;
        b=dVvo2TVZUmGbL3OIJJRnyfiH5PYvdHd/eRlM+FbrAlI1DoYY2d8qCz07vsA7sqLhja
         pB/PZc+xrB3dJpEtYjnfgmk8STf00yusKKy22MRoclom/1zpJqPMMwuvWcd696sKGVH1
         75vXNOWqzjDcJLws0sA8nKvOOuU7uejLYcGwRda0vZFj9bdOI0Sw6DuAsemjlNmVYEdi
         ZbkJgEBhhk26JyAu3yokSnwJrsPMYNwaYivzqCvo77YqmOJdMJAkA3TI2jq7rbffrRGV
         VhRcx4lrSaSoYgEUDidVhMMS4v2wAvPpPWh3Tr4LvzBDQ3Kfxbqv/QymmrDx2ALopeTg
         dGFA==
X-Gm-Message-State: AOAM532e5pPgA+H39eX0pQa2D9IHBlCcMMQwAhorWfbyYTaBbzgtbyjW
        DybyFrYudF6fIYeW6iA5x63bLQ==
X-Google-Smtp-Source: ABdhPJw6KaQEv1gmE2Ru2d5aoT7DK6/dT4q9Q9aoINopiR0PMuD4/fmPAfJYaLngGk2J5Pm10PwxBA==
X-Received: by 2002:a62:7646:0:b029:27a:29b6:e10b with SMTP id r67-20020a6276460000b029027a29b6e10bmr8361616pfc.14.1619603650322;
        Wed, 28 Apr 2021 02:54:10 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id x77sm4902365pfc.19.2021.04.28.02.54.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 02:54:10 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        alexander.h.duyck@linux.intel.com, richard.weiyang@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/9] mm: memcontrol: remove kmemcg_id reparenting
Date:   Wed, 28 Apr 2021 17:49:42 +0800
Message-Id: <20210428094949.43579-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210428094949.43579-1-songmuchun@bytedance.com>
References: <20210428094949.43579-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since slab objects and kmem pages are charged to object cgroup instead
of memory cgroup, memcg_reparent_objcgs() will reparent this cgroup and
all its descendants to the parent cgroup. It means that the new parent
memory cgroup can be returned by mem_cgroup_from_obj() which is called
from list_lru_from_kmem(). This can make further list_lru_add()'s add
elements to the parent's list. So we do not need to change kmemcg_id
of an offline cgroup to its parent's id. This is just waste CPU cycles.
Just remove those redundant code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 64ada9e650a5..21e12312509c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3485,8 +3485,7 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
-	struct cgroup_subsys_state *css;
-	struct mem_cgroup *parent, *child;
+	struct mem_cgroup *parent;
 	int kmemcg_id;
 
 	if (memcg->kmem_state != KMEM_ONLINE)
@@ -3503,22 +3502,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
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

