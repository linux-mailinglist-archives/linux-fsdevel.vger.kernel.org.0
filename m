Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431FD36D517
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 11:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbhD1JzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 05:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238481AbhD1JzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:55:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787AAC06138A
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:21 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z6-20020a17090a1706b0290155e8a752d8so328346pjd.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NP/rxZesEiIIrfKiG+UYq1kkvOJzyQmEnIKOjy9l8kg=;
        b=Svyqhok6H6Syu6MAMe9UCLt3sv86mUklBNHn2V++/4jxLrT2f5AFZv9tKBSqsHVgiP
         ZoCf3jsDk5APQTo72uUAk2ZNYE4xWEseg/ya9aj/kyQzqUV0P6jWd7Mxu/vdl2t1ZEy5
         Qo1yA2mysgdJliLeZxMv2OtZsL83h8tp0G5w837IQwOgUKEbPn/1f/zs2TfaS2/YR0s8
         AKF0JFo43aaX3cyIP+5m3KmlrByf3LlDwqDNQM/sjmmhbHjgaVHa+UAb6KnrpRUuyc4X
         lGNSqcaj1YgmDEAaerlHT9cm+BQvw4HtgjshaqMQQV/vAZFH8Vz2aw87Eo8Gcx4MW+pC
         0avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NP/rxZesEiIIrfKiG+UYq1kkvOJzyQmEnIKOjy9l8kg=;
        b=WP/LLIhHp51gSYdxg287AR/Ai22MNjSE26ID8RK+XPG55mbUsntzRfJtSY9+xUCF/D
         M09z72YagyBgQThglF97ndv2kxa0kpkikWBLVs6I11aC1sFTjSWGTOmyPOxrAxDa0Vgq
         l9J2JErqOz0Yc3y3nNQ7Q+wzh9IJbuD/ETY9qsLC6yEQhuY2BS/RrjHXvV5rfCjX9ptw
         CLwV+goPVKBL+Ag+pO3unNBwwY6hWd7JipveV5RWqHJPr5IY8Y7Mjhr/YS9+la7YPoZX
         0A1b3IzEGhWWPHnMabP5z3ciCTbaz9xorf52zgq3PcbJ4JE0zrwlt8gcrdSxnrvAeUhJ
         krOg==
X-Gm-Message-State: AOAM530Y9cbgw7+7g+9iA5WMadpHH2j0w2TElm+UOPTDJeQ/UPWZnO1Z
        Ms/ev6VSp/LlREj5/0ZhJ0hDKg==
X-Google-Smtp-Source: ABdhPJy2UAfP3e/NNwuaLzNawPPbdd+obpHPXRqeQPBax1hGR6109fKOvajSwFFeB/oc84VrtkReyg==
X-Received: by 2002:a17:90a:c717:: with SMTP id o23mr25749439pjt.214.1619603661139;
        Wed, 28 Apr 2021 02:54:21 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id x77sm4902365pfc.19.2021.04.28.02.54.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 02:54:20 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        alexander.h.duyck@linux.intel.com, richard.weiyang@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 4/9] mm: memcontrol: remove the kmem states
Date:   Wed, 28 Apr 2021 17:49:44 +0800
Message-Id: <20210428094949.43579-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210428094949.43579-1-songmuchun@bytedance.com>
References: <20210428094949.43579-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now the kmem states is only used to indicate whether the kmem is
offlined. But we can use ->kmemcg_id to do the same things. So
remove the kmem states to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  7 -------
 mm/memcontrol.c            | 10 ++--------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c193be760709..6350c563c7b8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -182,12 +182,6 @@ struct mem_cgroup_thresholds {
 	struct mem_cgroup_threshold_ary *spare;
 };
 
-enum memcg_kmem_state {
-	KMEM_NONE,
-	KMEM_ALLOCATED,
-	KMEM_ONLINE,
-};
-
 #if defined(CONFIG_SMP)
 struct memcg_padding {
 	char x[0];
@@ -320,7 +314,6 @@ struct mem_cgroup {
 
 #ifdef CONFIG_MEMCG_KMEM
 	int kmemcg_id;
-	enum memcg_kmem_state kmem_state;
 	struct obj_cgroup __rcu *objcg;
 	struct list_head objcg_list; /* list of inherited objcgs */
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c1ce4fdba028..9b9a5368a3e9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3461,7 +3461,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 		return 0;
 
 	BUG_ON(memcg->kmemcg_id >= 0);
-	BUG_ON(memcg->kmem_state);
 
 	memcg_id = memcg_alloc_cache_id();
 	if (memcg_id < 0)
@@ -3478,7 +3477,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	static_branch_enable(&memcg_kmem_enabled_key);
 
 	memcg->kmemcg_id = memcg_id;
-	memcg->kmem_state = KMEM_ONLINE;
 
 	return 0;
 }
@@ -3488,11 +3486,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	struct mem_cgroup *parent;
 	int kmemcg_id;
 
-	if (memcg->kmem_state != KMEM_ONLINE)
-		return;
-
-	memcg->kmem_state = KMEM_ALLOCATED;
-
 	parent = parent_mem_cgroup(memcg);
 	if (!parent)
 		parent = root_mem_cgroup;
@@ -3506,12 +3499,13 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	memcg_reparent_list_lrus(memcg, parent);
 
 	memcg_free_cache_id(kmemcg_id);
+	memcg->kmemcg_id = -1;
 }
 
 static void memcg_free_kmem(struct mem_cgroup *memcg)
 {
 	/* css_alloc() failed, offlining didn't happen */
-	if (unlikely(memcg->kmem_state == KMEM_ONLINE))
+	if (unlikely(memcg->kmemcg_id != -1))
 		memcg_offline_kmem(memcg);
 }
 #else
-- 
2.11.0

