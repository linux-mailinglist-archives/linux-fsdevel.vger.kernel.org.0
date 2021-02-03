Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232CC30E0D0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 18:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhBCRW0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 12:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhBCRVz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:21:55 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E1FC0613D6;
        Wed,  3 Feb 2021 09:21:12 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id y142so260221pfb.3;
        Wed, 03 Feb 2021 09:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jGo1wZIt/fCsKVzxBYv264UFJPxmYGbYaCbSnPwe2l4=;
        b=vh7uA7u67PDDrYGZSYLwqb7USds8nfHkUzW09yhUIYOG1uHAEAoqqzzvBTMxaNrGJp
         BHm4T1Yd5hHzpIreZVDVorSzUu0BK/i/JMCoVChOz1Aii8fX2P7gycxDwf2YJOn6IvwM
         J1TyoHF/7lEDhBAtvAVpzepcaP+E9TD+NzP6OTYM43LnEpSPGmtmP1iduHYTHxzrhKzo
         a2XVhUy9WazceAk/apQK0ZAhVdhm+QJQdHH1Skd1n2XPKwxAOEkv34+y5Y31DZtMlgcf
         SmhDvmz44toTKe+o6sGY5cGmf7FMAvFEoytv1hlsQT8Wki5mG+8UfNdwcdLvUMEVEB+J
         wMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jGo1wZIt/fCsKVzxBYv264UFJPxmYGbYaCbSnPwe2l4=;
        b=YZVr5A0FlD79mrzZdtCK05H+aVoxg7rJ37SktePyGNsFOUgs+/cgmiVjGby5ckqEJs
         RungpHyzdA0BO16G3o2hG0uMFDgkFYlmsJZ4f2rrhdXXxgadp5l6+x4g7EN3EffqQGJW
         4QmmjYdhEQGNI5DcV9dlgh7SeKyr3EJUMd54phEzimAIywvdbPPcVU+cprCAJhtWHVx/
         CWrm+GsX8gsw+nk7Vwm7R3ZRMBRJHYV4tTVfPjpk+RhO2NewD5LyXeBS/MfNsJpFkCno
         71iucgqcDvXjGwzOcMPkNtKHcN6IiGAXnV+vzT8OYw1Eg8LSI0rEy2lJfOLCMIYEg6C9
         F31Q==
X-Gm-Message-State: AOAM532xVNPQHf7FyfkT7rWslY409PDg3JcuG0WStNkTMWYgdGkK091S
        vKc7+n0wegbm8t0Vlq96T5o=
X-Google-Smtp-Source: ABdhPJzVaNXDkSSog60kMfbrB19ALynz5XcuMkn6xrdACF5Gn2BkoSfmP0yMQI/oQwzIph4vEgw6BQ==
X-Received: by 2002:a62:528c:0:b029:19e:4a39:d9ea with SMTP id g134-20020a62528c0000b029019e4a39d9eamr4036033pfb.20.1612372872042;
        Wed, 03 Feb 2021 09:21:12 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id x21sm2368636pfn.100.2021.02.03.09.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 09:21:10 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v6 PATCH 04/11] mm: vmscan: remove memcg_shrinker_map_size
Date:   Wed,  3 Feb 2021 09:20:35 -0800
Message-Id: <20210203172042.800474-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203172042.800474-1-shy828301@gmail.com>
References: <20210203172042.800474-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Both memcg_shrinker_map_size and shrinker_nr_max is maintained, but actually the
map size can be calculated via shrinker_nr_max, so it seems unnecessary to keep both.
Remove memcg_shrinker_map_size since shrinker_nr_max is also used by iterating the
bit map.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e4ddaaaeffe2..641077b09e5d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -185,8 +185,10 @@ static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
 #ifdef CONFIG_MEMCG
+static int shrinker_nr_max;
 
-static int memcg_shrinker_map_size;
+#define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
+	(DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))
 
 static void free_shrinker_map_rcu(struct rcu_head *head)
 {
@@ -247,7 +249,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
 		return 0;
 
 	down_write(&shrinker_rwsem);
-	size = memcg_shrinker_map_size;
+	size = NR_MAX_TO_SHR_MAP_SIZE(shrinker_nr_max);
 	for_each_node(nid) {
 		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
 		if (!map) {
@@ -265,12 +267,13 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
 static int expand_shrinker_maps(int new_id)
 {
 	int size, old_size, ret = 0;
+	int new_nr_max = new_id + 1;
 	struct mem_cgroup *memcg;
 
-	size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
-	old_size = memcg_shrinker_map_size;
+	size = NR_MAX_TO_SHR_MAP_SIZE(new_nr_max);
+	old_size = NR_MAX_TO_SHR_MAP_SIZE(shrinker_nr_max);
 	if (size <= old_size)
-		return 0;
+		goto out;
 
 	if (!root_mem_cgroup)
 		goto out;
@@ -287,7 +290,7 @@ static int expand_shrinker_maps(int new_id)
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 out:
 	if (!ret)
-		memcg_shrinker_map_size = size;
+		shrinker_nr_max = new_nr_max;
 
 	return ret;
 }
@@ -320,7 +323,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 #define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
 
 static DEFINE_IDR(shrinker_idr);
-static int shrinker_nr_max;
 
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
@@ -337,8 +339,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 			idr_remove(&shrinker_idr, id);
 			goto unlock;
 		}
-
-		shrinker_nr_max = id + 1;
 	}
 	shrinker->id = id;
 	ret = 0;
-- 
2.26.2

