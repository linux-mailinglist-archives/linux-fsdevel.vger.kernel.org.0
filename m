Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926B033456C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 18:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbhCJRqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 12:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhCJRq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:46:29 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ABEC061760;
        Wed, 10 Mar 2021 09:46:29 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id g4so11873295pgj.0;
        Wed, 10 Mar 2021 09:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Py/EOd4SfsVAE1wGGKDRwg9/efRB8yrzYfbXqq9sd00=;
        b=Xpwz5NuPcHO0UONgccK0lxYzdukCMeF0Re0h4f0uNRyBewcR9stOMZVAtRxz61w3Z5
         BATO2TMLuqZ8FLGXpMgv9hV89IVkjrs5pMV2bbdKKA4sMJGez7zOY8rg+Usr+I0NDL7a
         WNfeuaIsyxwsfVOlfaEWD+fI+QZql3ZG6F4QZ6miI/TXrDnK2bFokzxTdh9jXJ0apslx
         w6WFNjigZFUzJS8ruS63XTqLSeg2C+6pPQUo7MRNxYa9YCLuyRUHGq7oa/5w3/jqnldZ
         LOr7MlAofEyyLVfsWbZHhlhY2cx6mT2acQeHanKOn215EMFA2SbUfZMjWJv5ZdJUIY9w
         ChhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Py/EOd4SfsVAE1wGGKDRwg9/efRB8yrzYfbXqq9sd00=;
        b=q2vRAKTrjTINUh/ZqoXT6QcBwrMv59NE7zXNHw7n1JgQ3zdW64ZM/8BEjiqWykPv8y
         ufmnRxIC6Hets6jpNOZpOF+8fTPNciYsebIBCgeuGCbCbXjRico7OidHtSY6oDcHB57N
         OeglIYnZnGW1dcZLb3cxSpAN7Y84ygaO+ZxYpaa9Ct/Lu3h6Hd1lz/E91ozk0fImEpnd
         Mj7VwEWGcZzF0xMSCqm3K1OxkQ8+5gAo+hvBOyEASjWfSwyH1HmHAew62S3OPYGUqiDB
         qvSBccKb137wssL6OPtQ1E3N8fV6gjHrj8dS2Rqha0dJ8D6pcylaxI08VdHHmvevwux5
         aGaA==
X-Gm-Message-State: AOAM5339mlKWPDwqIkpUs2KitvV+6Q1Bs5lxSaYuw7r+c5tABfdBvXgk
        lmSjuKldyTjDFo+L9TkWG/M=
X-Google-Smtp-Source: ABdhPJy2ZsOHvx2Hmu5HfY7PtlhmBiqC9ADbXQxKs8wOp8se+DZgPiNAvxMx83CNwYNWVOw6WhzXtA==
X-Received: by 2002:aa7:83cf:0:b029:1ee:f550:7d48 with SMTP id j15-20020aa783cf0000b02901eef5507d48mr4054966pfn.12.1615398389031;
        Wed, 10 Mar 2021 09:46:29 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d6sm145804pfq.109.2021.03.10.09.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 09:46:28 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v9 PATCH 07/13] mm: vmscan: add shrinker_info_protected() helper
Date:   Wed, 10 Mar 2021 09:45:57 -0800
Message-Id: <20210310174603.5093-8-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210310174603.5093-1-shy828301@gmail.com>
References: <20210310174603.5093-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The shrinker_info is dereferenced in a couple of places via rcu_dereference_protected
with different calling conventions, for example, using mem_cgroup_nodeinfo helper
or dereferencing memcg->nodeinfo[nid]->shrinker_info.  And the later patch
will add more dereference places.

So extract the dereference into a helper to make the code more readable.  No
functional change.

Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/vmscan.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7f3c00e76fd1..c0d04f242917 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -192,6 +192,13 @@ static inline int shrinker_map_size(int nr_items)
 	return (DIV_ROUND_UP(nr_items, BITS_PER_LONG) * sizeof(unsigned long));
 }
 
+static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
+						     int nid)
+{
+	return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
+					 lockdep_is_held(&shrinker_rwsem));
+}
+
 static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 				    int size, int old_size)
 {
@@ -199,8 +206,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 	int nid;
 
 	for_each_node(nid) {
-		old = rcu_dereference_protected(
-			mem_cgroup_nodeinfo(memcg, nid)->shrinker_info, true);
+		old = shrinker_info_protected(memcg, nid);
 		/* Not yet online memcg */
 		if (!old)
 			return 0;
@@ -231,7 +237,7 @@ void free_shrinker_info(struct mem_cgroup *memcg)
 
 	for_each_node(nid) {
 		pn = mem_cgroup_nodeinfo(memcg, nid);
-		info = rcu_dereference_protected(pn->shrinker_info, true);
+		info = shrinker_info_protected(memcg, nid);
 		kvfree(info);
 		rcu_assign_pointer(pn->shrinker_info, NULL);
 	}
@@ -674,8 +680,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	if (!down_read_trylock(&shrinker_rwsem))
 		return 0;
 
-	info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
-					 true);
+	info = shrinker_info_protected(memcg, nid);
 	if (unlikely(!info))
 		goto unlock;
 
-- 
2.26.2

