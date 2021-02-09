Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31917315592
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 19:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhBISDT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 13:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbhBIRrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:47:53 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623FAC06178A;
        Tue,  9 Feb 2021 09:47:12 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id my11so1813175pjb.1;
        Tue, 09 Feb 2021 09:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jMTd+AsX3BHmetJX1pSMFbMyduyVUPUtb+au9yZ0BQ8=;
        b=fb+LVYBoz1sAntMs28140vW8hhrBN9G2hhhUfuOAnPJDxB2NSshgpMJ9J2i5x+VN/f
         BTgbNHrvx+hIDQtkNqkxrQpE3Tx5105FsVMdgmnt9RYit5nYtD5kpLh6YjiuKqaaouID
         yLqsMwMoqWVaFX9IdBU1mODZD3wpmOajuHzlG3sshZrFWqywgoUXOPNhXKCeA8LPVWvd
         jMn7avn64DoAZsd80tsvoI7buryToQAvZMMKvo/S+CLifa3FY7g46diyVh+iqrpww0SV
         MNpazR9nSH9XVe5Cn0ItFLN/oAKCPr6VyBQmvX7aQZvEhoMsuaagEYlQZpDpYa67c+US
         ptUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jMTd+AsX3BHmetJX1pSMFbMyduyVUPUtb+au9yZ0BQ8=;
        b=HhfF4HYAd5eN2yxYBcr2HmwdVzPnBuH+g1pMNWvdhw+D4r2fMHaapN5qBgRYbbVIDM
         2jR7a18dGHEXjAydKYv2FuPYCOzNaUBj+Oxket00EJymc0sW3vQTFChNp+qE/Elw0wgk
         NNT9WTsXo8I/gPsx0FfJjjDAiwk7cq5RtlsRz3vqPADD9UK39ezNART/b9DmO0toWf5u
         lZsUOfT8jXioQzwbQJnIcauz4VMFPB2xi5C8omtwFA6KzBw3mgYgkWx1gKaQ6QuOPnst
         kgz/q2QOSBBZpUg7OzgYG8pNLL5cVny798oZgqFVzjpa5kqj15Slsqf7fVN4+XlLbSd5
         qtGA==
X-Gm-Message-State: AOAM532tzsNhrn9jvYWIJH3NSw3wOszRFcb1JrqMPGxe6idgT6rgqP2b
        rrXyODFRKhyf8d+fq4TkNpY=
X-Google-Smtp-Source: ABdhPJwaqafmo1fqnOIsjZW/57shfRny1c9eDctpoMFQE7YXYsnfdumP7ICN/Kp3/hMsG89JqypTSg==
X-Received: by 2002:a17:902:a383:b029:e0:10e6:6ed7 with SMTP id x3-20020a170902a383b02900e010e66ed7mr22633037pla.5.1612892831486;
        Tue, 09 Feb 2021 09:47:11 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id j1sm22260929pfr.78.2021.02.09.09.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:47:10 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v7 PATCH 04/12] mm: vmscan: remove memcg_shrinker_map_size
Date:   Tue,  9 Feb 2021 09:46:38 -0800
Message-Id: <20210209174646.1310591-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209174646.1310591-1-shy828301@gmail.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
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

