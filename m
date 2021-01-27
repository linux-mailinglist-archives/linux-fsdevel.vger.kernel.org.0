Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32989306839
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 00:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhA0XoZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 18:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhA0XfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:35:24 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852EBC061788;
        Wed, 27 Jan 2021 15:34:00 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id jx18so2680670pjb.5;
        Wed, 27 Jan 2021 15:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=65bxltQ5JyyivvvnTuxpyri2gVYu+eURJIDc8089YFI=;
        b=fF/4lvKdCeIWSpDsS59C71/1pkx5orm4veM66Uq59nJjBqNxFLFJiO1FFck57I6rg+
         kFTyXYD/RvF9uSoP+TJpeDbb++3BEcWLvxpQbyseTcvDccweUbooPirPVUfeUtXOUToL
         oGkxd99AYI4VyVsgsIpbJTzwfIixg2ABX0z+8ddBIgWfIjnFVpGDQ9Z2fAD6/v01hAjA
         1e/27ekiV+R9rDAj6lVzyWU5lWCB5gBcIOJi/DVEDZHSo/qm2GxS8F610GHfAMC/b/ZQ
         BqQm4/uEdh7tRXGiwL/8cOOea3R7vj1RIyo4BxRwn5EjX2fkJlhlCMnH0krkQ+eyLgHs
         /w+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=65bxltQ5JyyivvvnTuxpyri2gVYu+eURJIDc8089YFI=;
        b=gIZoDu0y6/wIWI+oW164mYWXo4AAxD7keuGELqYbpu40jqSArriybXaMh9mHuXxinP
         i9McnQEQoz3Jb2ULXQNQQ2AWqHEoNorxs2099KJ3LQMm1LDp4FajBTcbgbqt+ImLxxKq
         r69Vk9MhCmZy3FrzXvYHK8N3XVb252JUjYlT04hasLL24OwzzSL2kDa9w2F8QN/YndBj
         oElIbs52pTjIf6dxeaM9qgid3bEbFM5ODhqOBijK7nzcRV9ohv81IJWdD8nnRMXPVflB
         eSS3uLocUDNuUh44xCsM1PGjEFjMdL8KCdmyvxCc9n9etHAB1XNTZr60QbQdDnsnX6YH
         wU7g==
X-Gm-Message-State: AOAM532i5oiI/5H8IAK0ShJrEJNANXkNugCk7AH8Togrh9qznyr6ywh/
        GOC2ty0s67Sxj+c2v0mnI0Y=
X-Google-Smtp-Source: ABdhPJyEROsqkycAYaLMggreyUDXfEmKv4d5fu9Tu67KGSVlcjm+y4TKGJ/ZQPQKP4WS1C3zBGyMrg==
X-Received: by 2002:a17:90a:12c4:: with SMTP id b4mr7896770pjg.98.1611790440132;
        Wed, 27 Jan 2021 15:34:00 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id 124sm3498648pfd.59.2021.01.27.15.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 15:33:59 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v5 PATCH 04/11] mm: vmscan: remove memcg_shrinker_map_size
Date:   Wed, 27 Jan 2021 15:33:38 -0800
Message-Id: <20210127233345.339910-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210127233345.339910-1-shy828301@gmail.com>
References: <20210127233345.339910-1-shy828301@gmail.com>
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
 mm/vmscan.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d3f3701dfcd2..847369c19775 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -185,8 +185,7 @@ static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
 #ifdef CONFIG_MEMCG
-
-static int memcg_shrinker_map_size;
+static int shrinker_nr_max;
 
 static void free_shrinker_map_rcu(struct rcu_head *head)
 {
@@ -248,7 +247,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
 		return 0;
 
 	down_write(&shrinker_rwsem);
-	size = memcg_shrinker_map_size;
+	size = (shrinker_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
 	for_each_node(nid) {
 		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
 		if (!map) {
@@ -266,12 +265,13 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
 static int expand_shrinker_maps(int new_id)
 {
 	int size, old_size, ret = 0;
+	int new_nr_max = new_id + 1;
 	struct mem_cgroup *memcg;
 
-	size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
-	old_size = memcg_shrinker_map_size;
+	size = (new_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
+	old_size = (shrinker_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
 	if (size <= old_size)
-		return 0;
+		goto out;
 
 	if (!root_mem_cgroup)
 		goto out;
@@ -286,9 +286,10 @@ static int expand_shrinker_maps(int new_id)
 			goto out;
 		}
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
+
 out:
 	if (!ret)
-		memcg_shrinker_map_size = size;
+		shrinker_nr_max = new_nr_max;
 
 	return ret;
 }
@@ -321,7 +322,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 #define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
 
 static DEFINE_IDR(shrinker_idr);
-static int shrinker_nr_max;
 
 static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 {
@@ -338,8 +338,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
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

