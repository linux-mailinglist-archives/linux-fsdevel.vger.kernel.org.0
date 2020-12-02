Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB67E2CC518
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 19:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389421AbgLBS2f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 13:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389384AbgLBS2e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:28:34 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A46C061A04;
        Wed,  2 Dec 2020 10:27:51 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id o7so1438062pjj.2;
        Wed, 02 Dec 2020 10:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L0EYVG9/JHZSwQKcdm/uLO/GzIIIcVeao0a1qNmlzMo=;
        b=GXcmtb/78TmgRjL90+9AKiKDg4mnBqNkTFZGUjNrkQyhPFWnxWHSVxs0DTYbJk6Phx
         TazQkZ9fOF7szRFViPIaI0ROE8eFgpvx9II8n3p38lZSVEjQ3dRqbbIMY3MVykotTJsl
         BNShLtVE/G84sNhuNL1LeF627T1FpxJ6SOdiwmWLT3yS5yTqHbSnYuid/xR5f77I54nR
         W0iyAUkHH4fT4u/nrsyR9xbgpZQiPCdF2WmENoSClFzMTLy0fdn0/lSSBI23C2/JJrw7
         XLS1iN+WD0VnI0t67kf8JimWA2DEpqR+PKa9DNv1EyRWPwGphhTjcTHMHeI/cBf2652r
         xDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L0EYVG9/JHZSwQKcdm/uLO/GzIIIcVeao0a1qNmlzMo=;
        b=rKIxaSHjqtFuwupGCGSi4Ffkk8/P4D5hnEcLSIbgHMMDd+PFTq4xK/Iln6YhAzMC3o
         h18hs2u0k969PDwD+9sPAFGb1qcw2fruBNHiXBQOYxz5Km8B8gwFEhodb9HjuWBwtbdJ
         Z3Cdi8exw0vZmm+oKVqhAEKxuolHRS44mBtjTloRhDYaPwsqOoCda+yDGRXol68eMOlc
         U0Gzldy5xmjqet1UV4SBEAWbzPhbt4ZbQdISMFMhS2+9bEA29UtPJTw0bmTgw/Ck40qb
         P1fL02HU+gD1BAt36L5bdFYBZf4PGemi+/1qKajauVK0hvJFv0O+ocrcqYa3jtidt/eR
         t2gA==
X-Gm-Message-State: AOAM530l1ylRVyGVbhnU7UtLSFEsuYh08gTjw9A65nCHrtUBGBBwt4nn
        Mxg6VQF8IcW3x/lPVgmMf9Y=
X-Google-Smtp-Source: ABdhPJz6Mh4mDqhuFxz84ELSR6dVfwNcpfWdx8Zo/0l4bcZNoiNkq6y2HGDqfzHOf/F2Rv9sAuVCLQ==
X-Received: by 2002:a17:90a:4817:: with SMTP id a23mr1102425pjh.16.1606933670937;
        Wed, 02 Dec 2020 10:27:50 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id c6sm396906pgl.38.2020.12.02.10.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:27:49 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] mm: memcontrol: rename memcg_shrinker_map_mutex to memcg_shrinker_mutex
Date:   Wed,  2 Dec 2020 10:27:19 -0800
Message-Id: <20201202182725.265020-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201202182725.265020-1-shy828301@gmail.com>
References: <20201202182725.265020-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following patch will add memcg_shrinker_deferred which could be protected by
the same mutex, rename it to a more common name.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/memcontrol.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 29459a6ce1c7..19e41684c96b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -395,7 +395,7 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
 #endif
 
 static int memcg_shrinker_map_size;
-static DEFINE_MUTEX(memcg_shrinker_map_mutex);
+static DEFINE_MUTEX(memcg_shrinker_mutex);
 
 static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
 {
@@ -408,7 +408,7 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
 	struct memcg_shrinker_map *new, *old;
 	int nid;
 
-	lockdep_assert_held(&memcg_shrinker_map_mutex);
+	lockdep_assert_held(&memcg_shrinker_mutex);
 
 	for_each_node(nid) {
 		old = rcu_dereference_protected(
@@ -458,7 +458,7 @@ static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
 	if (mem_cgroup_is_root(memcg))
 		return 0;
 
-	mutex_lock(&memcg_shrinker_map_mutex);
+	mutex_lock(&memcg_shrinker_mutex);
 	size = memcg_shrinker_map_size;
 	for_each_node(nid) {
 		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
@@ -469,7 +469,7 @@ static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
 		}
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
 	}
-	mutex_unlock(&memcg_shrinker_map_mutex);
+	mutex_unlock(&memcg_shrinker_mutex);
 
 	return ret;
 }
@@ -484,7 +484,7 @@ int memcg_expand_shrinker_maps(int new_id)
 	if (size <= old_size)
 		return 0;
 
-	mutex_lock(&memcg_shrinker_map_mutex);
+	mutex_lock(&memcg_shrinker_mutex);
 	if (!root_mem_cgroup)
 		goto unlock;
 
@@ -500,7 +500,7 @@ int memcg_expand_shrinker_maps(int new_id)
 unlock:
 	if (!ret)
 		memcg_shrinker_map_size = size;
-	mutex_unlock(&memcg_shrinker_map_mutex);
+	mutex_unlock(&memcg_shrinker_mutex);
 	return ret;
 }
 
-- 
2.26.2

