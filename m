Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58493169707
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 10:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgBWJcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 04:32:08 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37811 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWJcI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 04:32:08 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so2743070pjb.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2020 01:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GJtxJvSc58vjyddnB/C/XHPYzi3+0cfBzGH9GFwf45I=;
        b=bQCDECanAhRGQQRTAd6yocWkVda+KDrS0dn/+9oCiTuHCbm0uZglkg4ccN2tNKHayN
         CFHLGLBWD8sHqlf/VBu3xQUT7cV4A9dJQx0GNq27ROSlqjPBOzsuDh+WqW5C5HyGNtRf
         qvud8z1QFxILnAqGmtHNnIcwd/FK9ZBFkJlJFveXRFwHBok7mzZa2FBIC9NdmVPjWOwQ
         tq6A5PHK25PzPf48f/jZ4h5aOYP2bJCkAgqcXe6ppf5c9pB0Ci2auXlrH/gHwD5JWo7l
         v9BurOb6Br/aPGeTaiJl70DKG8mZEFcdIHdBaikpdyOdloh8h4qsl2jBRs9TL7Mjgfk9
         5q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GJtxJvSc58vjyddnB/C/XHPYzi3+0cfBzGH9GFwf45I=;
        b=s+QYXjgBUG2+A+BE/Wz85zK37hZy/mywIdjTxL93d83gyTGtnWPCFQzHsuj1SQFdL2
         WckPII8EhHHnpzVdRnmuZazPibuGHR37M4zvLIj/06Js9smsManHTF3ClEEeiY3H7eZf
         euB8RGh1OcfmZvSmtKp/tz+Fl6ehrCk26CRrm+X5x0OZliJ6/dKn0dy6E8teZ6k/yYW0
         dekgHuc3dSWzK7OCRrXRXhY1Nt7wB1BLCYIcDZcGP0xPktBww+jZb310pqzJ0q0WORbM
         O0ynOS+73Sfmtcd7HgnwVN/h0AxGFpmLmAa1vVCfIiShWXzp76zACOdUUPyMPtrTMFdJ
         UfDg==
X-Gm-Message-State: APjAAAWCjPj8jSIL80LFD4HSAQh/QWybX/V1dZAGN/zVV3hWZTLTgjUr
        k8oYaWT0yDRUCiE99DYpN6A=
X-Google-Smtp-Source: APXvYqwv5eVkXNOBrbBo/0ywINZyJ5hpO+6pKnGtIr2ORGOQBfe3SJUAa9ZwaanqoTyVALmizu1sCg==
X-Received: by 2002:a17:902:b206:: with SMTP id t6mr46058940plr.211.1582450327847;
        Sun, 23 Feb 2020 01:32:07 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id t19sm8346011pgg.23.2020.02.23.01.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Feb 2020 01:32:07 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     dchinner@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, guro@fb.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 2/3] mm, shrinker: make memcg low reclaim visible to lru walker isolation function
Date:   Sun, 23 Feb 2020 04:31:33 -0500
Message-Id: <1582450294-18038-3-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582450294-18038-1-git-send-email-laoar.shao@gmail.com>
References: <1582450294-18038-1-git-send-email-laoar.shao@gmail.com>
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
index f14c8c6..c6e1ad8 100644
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
Yafang Shao

