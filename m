Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AED1186947
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 11:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgCPKkh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 06:40:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38230 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbgCPKkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:40:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id x7so9523431pgh.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2020 03:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vY2V4Msx6oxN9LJCRiKwHFiisubxDrfzwxG6lOa9dNU=;
        b=IkCicFVaHxkWKrGSUxrZpHqQj9D/t3mOLXb5kShBej3eTD5sYwXm9X3p4YWr5Gzm+x
         uJP3PkLtPqj7wDEK5JGRSu5vutp/fJZhT5xhC4wL1ARSWkiOTebAc7xq8wVFfb7opWtP
         bYkyFe8nefFlO094Bs/19gEBgiYAIn0974G/QbHc43y4F5+dsheomEAyaEl1D3BeaFn2
         qX1pF0ENmCLYXTiKmQl2A2ipBjagoqoO5qQUYLd4ra0pSq3EURChDalYBAlj70XEb3Ku
         wJ9Y5CvNB1huHe7dqfHdRHqWFgag3RD7kY0Q1m+TwboHVdFlsLyX6zKRWR0/0iPP/Lud
         m/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vY2V4Msx6oxN9LJCRiKwHFiisubxDrfzwxG6lOa9dNU=;
        b=K6e7/d/OgoL+0dxB4UrauWxIG6RtCSnY05hvAtQzYyfUjFUYMW5fe2xf2iYnulTfhG
         /rsHRQFUjPBbOvGGdqkafyYmeOoSy5ehUQgGamUL8Oop1f2J5wrIQSYPM8qqEZK6R9zi
         G5iBq4JPcasOSmIvKOH5rsdhwEaoXOuFuzUs8+NeLVbt/pXMOR53knBIdwHTnX7xbU9H
         XQztPg3Ek5hmVLM1KxeAEYFglnbcqp0/ap78JSLkZbNFUfXI/q7Rpg4wDbh9yMFc8YZv
         ORsfITzIEL8Kjr6AkHEyKGf3Xva8BtlhKFUI2EBDFzWmcwsWT/JYEg/Jnnwv/CDP43ey
         g+5Q==
X-Gm-Message-State: ANhLgQ3ZplP2O6G5qLbZhOlmR3JGvKWCPwsRbg4c0erUM7t/XfspT8Oa
        JYSQuoB6YQVyJg3yxzaxDsM=
X-Google-Smtp-Source: ADFU+vvuCGJScZZkfVQplCLS3rrwKochvebnJHsILTRfc2PNbM4o3inEYYU3KocRr5PPgQyktY6Cdw==
X-Received: by 2002:a62:5544:: with SMTP id j65mr28084461pfb.121.1584355236772;
        Mon, 16 Mar 2020 03:40:36 -0700 (PDT)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id h2sm19834276pjc.7.2020.03.16.03.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2020 03:40:36 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     dchinner@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, guro@fb.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 2/3] mm, shrinker: make memcg low reclaim visible to lru walker isolation function
Date:   Mon, 16 Mar 2020 06:39:57 -0400
Message-Id: <1584355198-10137-3-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1584355198-10137-1-git-send-email-laoar.shao@gmail.com>
References: <1584355198-10137-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A new member memcg_low_reclaim is introduced in shrink_control struct,
which is derived from scan_control struct, in order to tell the shrinker
whether the reclaim session is under memcg low reclaim or not.
The followup patch will use this new member.

Cc: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/shrinker.h |  3 +++
 mm/vmscan.c              | 27 ++++++++++++++++-----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 0f80123..dc42ae5 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -31,6 +31,9 @@ struct shrink_control {
 
 	/* current memcg being shrunk (for memcg aware shrinkers) */
 	struct mem_cgroup *memcg;
+
+	/* derived from struct scan_control */
+	bool memcg_low_reclaim;
 };
 
 #define SHRINK_STOP (~0UL)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8763705..3857508 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -625,10 +625,9 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 
 /**
  * shrink_slab - shrink slab caches
- * @gfp_mask: allocation context
- * @nid: node whose slab caches to target
  * @memcg: memory cgroup whose slab caches to target
- * @priority: the reclaim priority
+ * @sc: scan_control struct for this reclaim session
+ * @nid: node whose slab caches to target
  *
  * Call the shrink functions to age shrinkable caches.
  *
@@ -638,15 +637,18 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
  * @memcg specifies the memory cgroup to target. Unaware shrinkers
  * are called only if it is the root cgroup.
  *
- * @priority is sc->priority, we take the number of objects and >> by priority
- * in order to get the scan target.
+ * @sc is the scan_control struct, we take the number of objects
+ * and >> by sc->priority in order to get the scan target.
  *
  * Returns the number of reclaimed slab objects.
  */
-static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
-				 struct mem_cgroup *memcg,
-				 int priority)
+static unsigned long shrink_slab(struct mem_cgroup *memcg,
+				 struct scan_control *sc,
+				 int nid)
 {
+	bool memcg_low_reclaim = sc->memcg_low_reclaim;
+	gfp_t gfp_mask = sc->gfp_mask;
+	int priority = sc->priority;
 	unsigned long ret, freed = 0;
 	struct shrinker *shrinker;
 
@@ -668,6 +670,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 			.gfp_mask = gfp_mask,
 			.nid = nid,
 			.memcg = memcg,
+			.memcg_low_reclaim = memcg_low_reclaim,
 		};
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
@@ -694,6 +697,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 void drop_slab_node(int nid)
 {
 	unsigned long freed;
+	struct scan_control sc = {
+		.gfp_mask = GFP_KERNEL,
+	};
 
 	do {
 		struct mem_cgroup *memcg = NULL;
@@ -701,7 +707,7 @@ void drop_slab_node(int nid)
 		freed = 0;
 		memcg = mem_cgroup_iter(NULL, NULL, NULL);
 		do {
-			freed += shrink_slab(GFP_KERNEL, nid, memcg, 0);
+			freed += shrink_slab(memcg, &sc, nid);
 		} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 	} while (freed > 10);
 }
@@ -2673,8 +2679,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 
 		shrink_lruvec(lruvec, sc);
 
-		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
-			    sc->priority);
+		shrink_slab(memcg, sc, pgdat->node_id);
 
 		/* Record the group's reclaim efficiency */
 		vmpressure(sc->gfp_mask, memcg, false,
-- 
1.8.3.1

