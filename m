Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41592EB5A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 00:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbhAEW7q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 17:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbhAEW7p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:59:45 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E8CC06179A;
        Tue,  5 Jan 2021 14:58:51 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b5so571185pjl.0;
        Tue, 05 Jan 2021 14:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bGybKTjA83xTJvlWZhj7XA4Wdp0i+ARI2lQlbpxX72o=;
        b=WcWzs+V8qDAX9mVXmv3EA0qhcUeTJb8tzF5h/PgGmz/7fhFhkASM0MgxImZPsN7TCl
         ayyFUhw9DKlf0jB9LjqOE4VgsW3d7zH0i33HZT+qjY4/KX6MDGSGIBdrTze8RvbPO5mX
         +OLlz+mgARD35P5CzIlMgXAmAhGF0/fG6jQWTVDrzhSTQS+P3Vw1rr+Nk5R2eDmWgKhG
         VHHr/frUx53Sd+RvHB0oqMWMynhxVqUEIPRSbcq2rLhFuUFRy0UMihlwdFuogdtAYVGz
         kJnNkoMEMiRzxwPy7ijGjt353m0GTeIb23w5FsZlpg2mDqFWJQ/0yfy0jl6SJchwBWy2
         9I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bGybKTjA83xTJvlWZhj7XA4Wdp0i+ARI2lQlbpxX72o=;
        b=O+dGQuPwsJ0tr1NeqAxzpaW+CrS7rIU8q7xDPbdcV95FkNJJCE3rEP0exHCrll7uaD
         A81aHAqrIRGGaOt6hoAvRvWvuiFDhhdz2TrPT/vi8UJu0JFC7aORqN+b/Gxb6wB/Vipe
         K1ISBgO1CmzSnLiTwiER+ctejpNsRzm1FTZIJK8c3kPbFzaKXT/OkRWYtBlZRsZoRIEQ
         Bo2udmcTIFGZUGVXaPiYqqPXKW1AIDe91EZ0zCgosDGOaElxixlb6B4sEKHp6fjFNihU
         PuU6X6e7C4MdPdLFdiFJMsdTgwYiPqraEZLcIsrZ1ZgQzztY7eGxp8fpitKSWaKchlhs
         JrRA==
X-Gm-Message-State: AOAM532ZjsUQdabh4QBGdUVQYScfrOxUyqSKhJJLuAMKaRFvlNNB02IB
        4m286JOO+cVaXZdyEzTJbc0=
X-Google-Smtp-Source: ABdhPJzP2qgztI07SHedDB/qQDrkBM+TAdRyMKBnnsus28kMHVYBpk9b+kGQ5ZTyANOp1Uxn8YT1lg==
X-Received: by 2002:a17:902:a983:b029:dc:2564:91f2 with SMTP id bh3-20020a170902a983b02900dc256491f2mr1671677plb.46.1609887531190;
        Tue, 05 Jan 2021 14:58:51 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id fw12sm244233pjb.43.2021.01.05.14.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 14:58:49 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 03/11] mm: vmscan: use shrinker_rwsem to protect shrinker_maps allocation
Date:   Tue,  5 Jan 2021 14:58:09 -0800
Message-Id: <20210105225817.1036378-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210105225817.1036378-1-shy828301@gmail.com>
References: <20210105225817.1036378-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since memcg_shrinker_map_size just can be changd under holding shrinker_rwsem
exclusively, the read side can be protected by holding read lock, so it sounds
superfluous to have a dedicated mutex.  This should not exacerbate the contention
to shrinker_rwsem since just one read side critical section is added.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9db7b4d6d0ae..ddb9f972f856 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -187,7 +187,6 @@ static DECLARE_RWSEM(shrinker_rwsem);
 #ifdef CONFIG_MEMCG
 
 static int memcg_shrinker_map_size;
-static DEFINE_MUTEX(memcg_shrinker_map_mutex);
 
 static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
 {
@@ -200,8 +199,6 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
 	struct memcg_shrinker_map *new, *old;
 	int nid;
 
-	lockdep_assert_held(&memcg_shrinker_map_mutex);
-
 	for_each_node(nid) {
 		old = rcu_dereference_protected(
 			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
@@ -250,7 +247,7 @@ int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
 	if (mem_cgroup_is_root(memcg))
 		return 0;
 
-	mutex_lock(&memcg_shrinker_map_mutex);
+	down_read(&shrinker_rwsem);
 	size = memcg_shrinker_map_size;
 	for_each_node(nid) {
 		map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
@@ -261,7 +258,7 @@ int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
 		}
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
 	}
-	mutex_unlock(&memcg_shrinker_map_mutex);
+	up_read(&shrinker_rwsem);
 
 	return ret;
 }
@@ -276,9 +273,8 @@ static int memcg_expand_shrinker_maps(int new_id)
 	if (size <= old_size)
 		return 0;
 
-	mutex_lock(&memcg_shrinker_map_mutex);
 	if (!root_mem_cgroup)
-		goto unlock;
+		goto out;
 
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
@@ -287,13 +283,13 @@ static int memcg_expand_shrinker_maps(int new_id)
 		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
 		if (ret) {
 			mem_cgroup_iter_break(NULL, memcg);
-			goto unlock;
+			goto out;
 		}
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
-unlock:
+out:
 	if (!ret)
 		memcg_shrinker_map_size = size;
-	mutex_unlock(&memcg_shrinker_map_mutex);
+
 	return ret;
 }
 
-- 
2.26.2

