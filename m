Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686B636D520
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 11:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbhD1Jz3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 05:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238675AbhD1Jz2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:55:28 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F15C06138C
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v20so5240515plo.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eVgbS1r6y4dIIx1w8PNRWtWwFVatPvGWznCWZtpnt6I=;
        b=Ye3xQ26M7eyxBvF1bS1McN7GEP62giojy9IF5P3ezIkyXipoDT7N/fkT6NCMcTVycO
         7wweELpBf6jyeLY2t40FbNsG2yEJmQOMZqknkludEfimlm98g0muJrDzSN4TMKeBKWVo
         IdsaNDiqZVjUGqKQHFJidvKzW0JWGw9SfYEEniTlb/nFTAaMbDOFCxSxHQc8PU/nI1FF
         AW+vhhOSTAEq1pU1U8J7yA88C+NgjHgUhKShdfD5DRi825nWvy2Ev0gS3E+s8hHn4cbX
         xyhvAS+Ou5nHUyqvsyRpg4ure61j3lSlohGXXPmXLO3WATbp3rAQdQhi+JCJ7XIbBsO6
         nSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eVgbS1r6y4dIIx1w8PNRWtWwFVatPvGWznCWZtpnt6I=;
        b=pOWXX7sbCruMhdfNyUJ1qCjrrDkfpRO2WZhDCErkSI8z+4NWkGjBIzaa20RazQyXIC
         MW+wMG64MpfSeSkpF9HN+eTeKkfrcVHzGyD454N6OV9bz7MpWCVVTTfZgVXWclKRVT4D
         Na5aCaMd6/rG0JM7axy9ygbEL5pfJYP8BlzHprKNpRwbseqkfX5/BHq50pcHyEdO57jD
         IWiWZ/bvUnXUN/WdJ/4PK7zhIcyzYjjx1oRd0eJgYqSxnbQRR5lyH/d+wVOmQCvJ4xKE
         odzxzH4hezQyE8doZv4Y3aKC2743zUUeh9+7xuia1qJsZ5czBaMNOXYGZkDSQjMzroO+
         43kw==
X-Gm-Message-State: AOAM530jMyfY/+R4cgA6vLOgyK6C7yPfC3nl43yEKbr+2bq6gm/a+egH
        ic03u2ypGu5pPGx2Ec6wKukb5g==
X-Google-Smtp-Source: ABdhPJykGeKEYrTpape4UuVoYtuRgn6sXbKt1+jlCioXuVws9hGzmd0k8K7tcpxp1Y4c4yq3YegKxA==
X-Received: by 2002:a17:90a:6687:: with SMTP id m7mr384642pjj.75.1619603682998;
        Wed, 28 Apr 2021 02:54:42 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id x77sm4902365pfc.19.2021.04.28.02.54.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 02:54:42 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        alexander.h.duyck@linux.intel.com, richard.weiyang@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 8/9] mm: memcontrol: shrink the list lru size
Date:   Wed, 28 Apr 2021 17:49:48 +0800
Message-Id: <20210428094949.43579-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210428094949.43579-1-songmuchun@bytedance.com>
References: <20210428094949.43579-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In our server, we found a suspected memory leak problem. The kmalloc-32
consumes more than 6GB of memory. Other kmem_caches consume less than 2GB
memory.

After our in-depth analysis, the memory consumption of kmalloc-32 slab
cache is the cause of list_lru_one allocation.

  crash> p memcg_nr_cache_ids
  memcg_nr_cache_ids = $2 = 24574

memcg_nr_cache_ids is very large and memory consumption of each list_lru
can be calculated with the following formula.

  num_numa_node * memcg_nr_cache_ids * 32 (kmalloc-32)

There are 4 numa nodes in our system, so each list_lru consumes ~3MB.

  crash> list super_blocks | wc -l
  952

Every mount will register 2 list lrus, one is for inode, another is for
dentry. There are 952 super_blocks. So the total memory is 952 * 2 * 3
MB (~5.6GB). But the number of memory cgroup is less than 500. So I
guess more than 12286 containers have been deployed on this machine (I
do not know why there are so many containers, it may be a user's bug or
the user really want to do that). But now there are less than 500
containers in the system. And memcg_nr_cache_ids has not been reduced
to a suitable value. This can waste a lot of memory. If we want to reduce
memcg_nr_cache_ids, we have to reboot the server. This is not what we
want. So this patch will dynamically adjust the value of
memcg_nr_cache_ids to keep healthy memory consumption. In this case, we
may be able to restore a healthy environment even if the users have
created tens of thousands of memory cgroups.

In this patch, I adjusted the calculation formula of memcg_nr_cache_ids
from "size = 2 * (id + 1)" to "size = 2 * id" in memcg_alloc_cache_id().
Because this can make things more simple when shrink the list lru size.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1610d501e7b5..f8cdd87cf693 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -362,6 +362,8 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
 static DEFINE_IDA(memcg_cache_ida);
 int memcg_nr_cache_ids;
 
+static int kmemcg_max_id;
+
 /* Protects memcg_nr_cache_ids */
 static DECLARE_RWSEM(memcg_cache_ids_sem);
 
@@ -2856,8 +2858,11 @@ static int memcg_alloc_cache_id(void)
 	if (id < 0)
 		return id;
 
-	if (id < memcg_nr_cache_ids)
+	if (id < memcg_nr_cache_ids) {
+		if (id > kmemcg_max_id)
+			kmemcg_max_id = id;
 		return id;
+	}
 
 	/*
 	 * There's no space for the new id in memcg_caches arrays,
@@ -2865,15 +2870,17 @@ static int memcg_alloc_cache_id(void)
 	 */
 	down_write(&memcg_cache_ids_sem);
 
-	size = 2 * (id + 1);
+	size = 2 * id;
 	if (size < MEMCG_CACHES_MIN_SIZE)
 		size = MEMCG_CACHES_MIN_SIZE;
 	else if (size > MEMCG_CACHES_MAX_SIZE)
 		size = MEMCG_CACHES_MAX_SIZE;
 
 	err = memcg_update_all_list_lrus(size);
-	if (!err)
+	if (!err) {
 		memcg_nr_cache_ids = size;
+		kmemcg_max_id = id;
+	}
 
 	up_write(&memcg_cache_ids_sem);
 
@@ -2884,9 +2891,48 @@ static int memcg_alloc_cache_id(void)
 	return id;
 }
 
+static inline int nearest_fit_id(int id)
+{
+	if (unlikely(id < MEMCG_CACHES_MIN_SIZE))
+		return MEMCG_CACHES_MIN_SIZE;
+
+	return 1 << (__fls(id) + 1);
+}
+
+/*
+ * memcg_alloc_cache_id() and memcg_free_cache_id() are serialized by
+ * cgroup_mutex. So there is no race on kmemcg_max_id.
+ */
 static void memcg_free_cache_id(int id)
 {
 	ida_simple_remove(&memcg_cache_ida, id);
+
+	if (kmemcg_max_id == id) {
+		/*
+		 * In order to avoid @memcg_nr_cache_ids bouncing between
+		 * @memcg_nr_cache_ids / 2 and @memcg_nr_cache_ids. We only
+		 * shrink the list lru size when @kmemcg_max_id is smaller
+		 * than @memcg_nr_cache_ids / 3.
+		 */
+		int size = memcg_nr_cache_ids / 3;
+
+		kmemcg_max_id = ida_max(&memcg_cache_ida);
+		if (kmemcg_max_id < size) {
+			/*
+			 * Find the first value greater than @kmemcg_max_id
+			 * which can fit our need. And shrink the list lru
+			 * to this size.
+			 */
+			size = nearest_fit_id(kmemcg_max_id);
+
+			down_write(&memcg_cache_ids_sem);
+			if (size != memcg_nr_cache_ids) {
+				memcg_update_all_list_lrus(size);
+				memcg_nr_cache_ids = size;
+			}
+			up_write(&memcg_cache_ids_sem);
+		}
+	}
 }
 
 /*
-- 
2.11.0

