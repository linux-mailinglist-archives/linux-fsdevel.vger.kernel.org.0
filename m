Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED21185B18
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 08:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgCOHxF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 03:53:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39698 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgCOHxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 03:53:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id b22so1723524pgb.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2020 00:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r9vLV6Qq04cRRMSwOI+dLFQIqvFaYX0FB1SLrcgz+pc=;
        b=a6HzSxBnbEYIPl5ofeVIDVAmAl+juJ9bvXsP5A1bAOFzTp023UsfLTUEyd747zvH7M
         Mq/BT0PkcYddsr0awLrIqFwyHHjsTbD2+3U0FMGxiGEbVYcYhMNlMa89+NYeBVMbme9F
         gs74dco12foKmtPt0XDqi1CgoUSyOhr7KS+eTqx5m4yLI2RBG5p9ATVBG8d2Rk8cyKqU
         FFhA9v529m90kT6vYBRtUzYVK1nNsPAhgnuRJpLAP+vpmu5ysZXZp8FYLfluJIlJV/uP
         nxzBSCsRMZEF52iDxuMqQN/M9wfI0ScGzNeV/7jzYi/rtvoi/lXHV2tQaUKwp9qm1anD
         7yOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r9vLV6Qq04cRRMSwOI+dLFQIqvFaYX0FB1SLrcgz+pc=;
        b=GPP8v+AGPHrdESx4f2P2+wOPfBVDFjgIwiv8/ODiJcXYIv5+ZSOk2xpTKlKliHoQce
         7eL9yLy+tMWMV8h/FwcfFzQ7XRk7/u7EUmRvX976C9lBZ1BM6t94mz/m7mb/babQn+Rt
         IJYH3NFadpc0FP4LgvSlD9ACHSf7QoKmlqp1wq0HzqtF0C6HJDd2lA5g/lcbIR4TQcjU
         iVSs6KDGY2arkoy+3iyenD7PpYDXX8srfFWegt4Cb/ga0IHIfw157i+yIHh+ODVe1BtC
         aGc6eAFUdXBeDCcIZYD1izz4+Dk67KzBq2QkKQ0VsCN+3P57pJn6h/PUErjL1dirOZxM
         2Erw==
X-Gm-Message-State: ANhLgQ3bImD96XdCEgJ2+G4F6F7AqJ8/vsFImfjR2op+o9qFHXNL9W01
        34EACogHssr5A5yAt1iZLWE=
X-Google-Smtp-Source: ADFU+vuv2Fvoe3wxjcT4absfB1RnH6gkjP/X1kgSOnsg6owh1BfecuBWq3uSBVuRh4psUGbwZ9ECVQ==
X-Received: by 2002:a63:cd12:: with SMTP id i18mr9138743pgg.98.1584258783452;
        Sun, 15 Mar 2020 00:53:03 -0700 (PDT)
Received: from master.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id w11sm62592984pfn.4.2020.03.15.00.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 00:53:02 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     dchinner@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, guro@fb.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 2/3] mm, shrinker: make memcg low reclaim visible to lru walker isolation function
Date:   Sun, 15 Mar 2020 05:53:41 -0400
Message-Id: <20200315095342.10178-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20200315095342.10178-1-laoar.shao@gmail.com>
References: <20200315095342.10178-1-laoar.shao@gmail.com>
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
index 0f80123650e2..dc42ae57e8dc 100644
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
index 876370565455..385750840979 100644
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
2.18.1

