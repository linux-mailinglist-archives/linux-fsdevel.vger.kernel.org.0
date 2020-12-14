Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4362DA384
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 23:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502369AbgLNWib (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 17:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441180AbgLNWi2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:38:28 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31CDC06179C;
        Mon, 14 Dec 2020 14:37:47 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x12so9275997plr.10;
        Mon, 14 Dec 2020 14:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RnXK+gZ1C2/dQ0iAczaSS+4uBnqZQVQH1YKLl+NZ61M=;
        b=GGQmRYRtTlBV1mtp1fkqgUKL0n34FOR26CqFeArLaZtWKB97t753yJch9PooXHpLPB
         FFL31FyLa6SpRP+3/Z0kWL3bXc0aEaQP7CmkOOgzgIxDiSSIJTe9E0UDD+D7+IOMXNdq
         G32XeAoRxQ4Gj9cZLsbnwzlpUj1jOUS1JaEU/TlA8GRMDiBhfEAq6+Z8gPbS7KQNUQO+
         047aDRXN/m70MRnprmi6cLoOwFaRYNUAcDtCC4tLBVY/sYP3ED7zOjg9FjRrwMyYi+K1
         YIh/vfq2/gW4y2Tdc7GdFKtnUOKWimotpGDHPEzQGyU0c2quOU94BM3rJ0TF8VKN2gK9
         6y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RnXK+gZ1C2/dQ0iAczaSS+4uBnqZQVQH1YKLl+NZ61M=;
        b=eU4ZSDzxaaeSvAOlJ6Z4cYJshDq9p2tlOPtdcQ0KjZRso59m90vgtvFrx/u8uya+uu
         Iabxi6NzGqypJWqCBMGJdaZk052zpFs/93jPqfBTz/KTrbl0MobwJQD91fZg7YSU6nPY
         7DoWMV+FiT8yZrOK+jGNYDQWYfkMc9SuaMWt+vSJQoptqVYvRCdyEedOOF/nrDOReLbA
         TQ/HVSklzCQvjjG18p4oRBYxCnuiIS5zeuhYxvXaBRmV0FuvD68qkmDFW69pUVTyU2OK
         Vf0dONaRG2yTTXcYMxV2AY3Mw7zx5lmWz5OyrHpitflVpm9eoUNG6WZEAAKeMcMECURC
         HQag==
X-Gm-Message-State: AOAM530cuRr9+8ETGCZL1I36u/hT+Zy1FjMsf0ou9AY41s6Nhop//aAF
        r5qLnsJpKg5DB/3qCGWWJ/g=
X-Google-Smtp-Source: ABdhPJx2Cv9p2Tq9vADJWiKsvIEIe5Ww975Xm0kVR2bMbuwE9HC7vTBHlQ9cBXkEeK2Pe9I1qyYDNg==
X-Received: by 2002:a17:90a:e7cc:: with SMTP id kb12mr27236213pjb.234.1607985467358;
        Mon, 14 Dec 2020 14:37:47 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d4sm20610758pfo.127.2020.12.14.14.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:37:46 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 3/9] mm: vmscan: guarantee shrinker_slab_memcg() sees valid shrinker_maps for online memcg
Date:   Mon, 14 Dec 2020 14:37:16 -0800
Message-Id: <20201214223722.232537-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201214223722.232537-1-shy828301@gmail.com>
References: <20201214223722.232537-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The shrink_slab_memcg() races with mem_cgroup_css_online(). A visibility of CSS_ONLINE flag
in shrink_slab_memcg()->mem_cgroup_online() does not guarantee that we will see
memcg->nodeinfo[nid]->shrinker_maps != NULL.  This may occur because of processor reordering
on !x86.

This seems like the below case:

           CPU A          CPU B
store shrinker_map      load CSS_ONLINE
store CSS_ONLINE        load shrinker_map

So the memory ordering could be guaranteed by smp_wmb()/smp_rmb() pair.

The memory barriers pair will guarantee the ordering between shrinker_deferred and CSS_ONLINE
for the following patches as well.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/memcontrol.c | 7 +++++++
 mm/vmscan.c     | 8 +++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ed942734235f..3d4ddbb84a01 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5406,6 +5406,13 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 		return -ENOMEM;
 	}
 
+	/*
+	 * Barrier for CSS_ONLINE, so that shrink_slab_memcg() sees shirnker_maps
+	 * and shrinker_deferred before CSS_ONLINE. It pairs with the read barrier
+	 * in shrink_slab_memcg().
+	 */
+	smp_wmb();
+
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	refcount_set(&memcg->id.ref, 1);
 	css_get(css);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 912c044301dd..9b31b9c419ec 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -552,13 +552,15 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	if (!mem_cgroup_online(memcg))
 		return 0;
 
+	/* Pairs with write barrier in mem_cgroup_css_online() */
+	smp_rmb();
+
 	if (!down_read_trylock(&shrinker_rwsem))
 		return 0;
 
+	/* Once memcg is online it can't be NULL */
 	map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
 					true);
-	if (unlikely(!map))
-		goto unlock;
 
 	for_each_set_bit(i, map->map, shrinker_nr_max) {
 		struct shrink_control sc = {
@@ -612,7 +614,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			break;
 		}
 	}
-unlock:
+
 	up_read(&shrinker_rwsem);
 	return freed;
 }
-- 
2.26.2

