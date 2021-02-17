Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F91731D343
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 01:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhBQAOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 19:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhBQAOT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 19:14:19 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65DFC061786;
        Tue, 16 Feb 2021 16:13:37 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id t11so7331215pgu.8;
        Tue, 16 Feb 2021 16:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nrWTpq2dO7Eg3GTZ90HCf5mhya6dwUv+AMyfdHDY2DA=;
        b=o0z2F6Qc4S3+vXblyH0mYP/ax8EyOS1mKW7gexinUfzv49fXukNW7QCAIA0ZJO7iTC
         UFtZo0CfeeWgJA5Kisa28tJcIIP5jkq8NG4R/Xz3dumFOL3PVv10yxHovzM54BYnrwjb
         339Ev1AqMok156YI1cCj2582/Nj7Z9RRljbb5+8CVJANnOMYZo3wRD5zxdyYj9e2KysG
         lunfq90/Zcfbk7OApA2LeuHcdVbYVKvNa+/u2dzBG7OABLCGxhRzaY5Hnk0nnj+aEyWr
         c6R5Ns4obmv87viI7yUaHvMjcG5TnoKJ7Iq+zOnCtLkd1tTR+2TfCpOBysbFZyVMPiHY
         V9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nrWTpq2dO7Eg3GTZ90HCf5mhya6dwUv+AMyfdHDY2DA=;
        b=DRXtaIk6S2dzIMnBn7yBuXYMdpxVJq9qIQ16ZwMwI1J/X+nidok5PWjr3Tuv4ctlO9
         SMqxXvGX2yY1YLlX9SFuw03gCyjB7zYrXV3kSpdspVeOQ8THh1bvIlgewntw6GospZVc
         pM7QUJcF3yxKCoQRAxjGkyyH7lwRUAheABS+xS+969h+iMSDSxzp1Ikjx7GEbTqApEak
         NUI8bx/38Ax1ex1R/XL3yZR1WvGWWOmG+Rb5C0MJ9Z5hSOaQUnEyPQSJV067EfNZ0NsE
         fyTbSgdMYywTvqjFQGNeT3eyW+GeN86i5pmub3AXa8bdLX1oHns0YTmjNF7ewaaB1oFG
         NBIw==
X-Gm-Message-State: AOAM532XBlx9OXGCt6dJUVJ9H1r0mA5bjueInHe1slHEgxChilmWnNwk
        6jAOH6ax0+zjLJZvHELT1Dw=
X-Google-Smtp-Source: ABdhPJy3A83kV+erXZ8lkFiabZggHE6dNpCc6tIrExHC220czNBuC5EzLT1Qs5H6KpkeBQPb4+gfOA==
X-Received: by 2002:aa7:8811:0:b029:1eb:77b1:6e77 with SMTP id c17-20020aa788110000b02901eb77b16e77mr15629198pfo.22.1613520817524;
        Tue, 16 Feb 2021 16:13:37 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y12sm99220pjc.56.2021.02.16.16.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 16:13:36 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v8 PATCH 04/13] mm: vmscan: remove memcg_shrinker_map_size
Date:   Tue, 16 Feb 2021 16:13:13 -0800
Message-Id: <20210217001322.2226796-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217001322.2226796-1-shy828301@gmail.com>
References: <20210217001322.2226796-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Both memcg_shrinker_map_size and shrinker_nr_max is maintained, but actually the
map size can be calculated via shrinker_nr_max, so it seems unnecessary to keep both.
Remove memcg_shrinker_map_size since shrinker_nr_max is also used by iterating the
bit map.

Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 543af6ec1e02..2e753c2516fa 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -185,8 +185,12 @@ static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
 #ifdef CONFIG_MEMCG
+static int shrinker_nr_max;
 
-static int memcg_shrinker_map_size;
+static inline int shrinker_map_size(int nr_items)
+{
+	return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
+}
 
 static void free_shrinker_map_rcu(struct rcu_head *head)
 {
@@ -247,7 +251,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
 		return 0;
 
 	down_write(&shrinker_rwsem);
-	size = memcg_shrinker_map_size;
+	size = shrinker_map_size(shrinker_nr_max);
 	for_each_node(nid) {
 		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
 		if (!map) {
@@ -265,12 +269,13 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
 static int expand_shrinker_maps(int new_id)
 {
 	int size, old_size, ret = 0;
+	int new_nr_max = new_id + 1;
 	struct mem_cgroup *memcg;
 
-	size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
-	old_size = memcg_shrinker_map_size;
+	size = shrinker_map_size(new_nr_max);
+	old_size = shrinker_map_size(shrinker_nr_max);
 	if (size <= old_size)
-		return 0;
+		goto out;
 
 	if (!root_mem_cgroup)
 		goto out;
@@ -289,7 +294,7 @@ static int expand_shrinker_maps(int new_id)
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 out:
 	if (!ret)
-		memcg_shrinker_map_size = size;
+		shrinker_nr_max = new_nr_max;
 
 	return ret;
 }
@@ -322,7 +327,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 #define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
 
 static DEFINE_IDR(shrinker_idr);
-static int shrinker_nr_max;
 
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
@@ -339,8 +343,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
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

