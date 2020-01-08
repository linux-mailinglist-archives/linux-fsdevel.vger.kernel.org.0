Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1A45134714
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 17:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAHQEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 11:04:23 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34734 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbgAHQEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:04:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so1808489pgf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2020 08:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6tDRHfnOHhoFqOdXrEqpx02xS4p7Z8x/5vQQY0aLm8A=;
        b=B5fOQPY05C9Lq+n9bt52buT2A7zkUL4sgv4b5/aECGwJd39DWMxRsy2c8cF/pkfLyU
         WfKb7TzULr/fJztTjK8x2Ui/8G47hn0Y5MfDn10NN0zXi7fXrY921d+aW4z5EsMaQGHl
         1nMAkJPUXIe0WM2pBF51WSkdzUJC2fR20TYqFFckLRPZURcOZOlQVOctax8yGfmmAETM
         ZwsFdFiQR+5CVXOF9LYIPsDlrakNHc6JzoFI2UexDMfzdNQwGjCKls1cqjYlaKO2dpNa
         JkFTLjRci3FahIpEeUq0kC6qrHFqK2UwB786bPemUQg35E8ECpLqlhqSxw52rdXrclg9
         5bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6tDRHfnOHhoFqOdXrEqpx02xS4p7Z8x/5vQQY0aLm8A=;
        b=ARq7E6hr4bSOOYo+3y1Z4IjtxH1ri/lRpe0QTyyObLhj5bjJrHamDxJSZWuDN3csif
         ozTO4JpYZ9yYcwWpaRWVDzgfTYzrm0q/rEm/6WsRn9mwbnH//qJkoCcDaQoKxL2XCb58
         BwSEEYXFQTU41vyVFB14zpV/9gOJTdSS+4LndbwUEW8aKsGsuLpYBtNG8mTQ4ydwI/Ln
         UPNrWhG8VCyI95BrioRZp3t0dFx7m0bQnEGO+0FTIZjFi3qn81nhpjiR3lN2t0EDGHje
         dKtDSOmc1z9XlYql+dNdpE+0aFGpyFDx3M6sE8ReleKsZwUnPQclrs3G/qZpaAOAspUn
         odww==
X-Gm-Message-State: APjAAAUbUIqW2u73Wkn0zgsTomj05FVTsDb5EQ5GrGonNp5+68AGFaKE
        UiZ02vQSTlB3XRX48JydjGo=
X-Google-Smtp-Source: APXvYqwfRgPZUp3MgB5cdkyxCriBpjrgtBHzNG9GXRLTGn33q60rXLqX9nFm9V64JP+A+KjED3q8EQ==
X-Received: by 2002:a62:ee11:: with SMTP id e17mr5905285pfi.48.1578499462405;
        Wed, 08 Jan 2020 08:04:22 -0800 (PST)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id d22sm4079894pfo.187.2020.01.08.08.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 08:04:21 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     dchinner@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, guro@fb.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 2/3] mm, shrinker: make memcg low reclaim visible to lru walker isolation function
Date:   Wed,  8 Jan 2020 11:03:56 -0500
Message-Id: <1578499437-1664-3-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578499437-1664-1-git-send-email-laoar.shao@gmail.com>
References: <1578499437-1664-1-git-send-email-laoar.shao@gmail.com>
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
index 5a6445e..c97d005 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -639,10 +639,9 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 
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
@@ -652,15 +651,18 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
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
 
@@ -682,6 +684,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 			.gfp_mask = gfp_mask,
 			.nid = nid,
 			.memcg = memcg,
+			.memcg_low_reclaim = memcg_low_reclaim,
 		};
 
 		ret = do_shrink_slab(&sc, shrinker, priority);
@@ -708,6 +711,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 void drop_slab_node(int nid)
 {
 	unsigned long freed;
+	struct scan_control sc = {
+		.gfp_mask = GFP_KERNEL,
+	};
 
 	do {
 		struct mem_cgroup *memcg = NULL;
@@ -715,7 +721,7 @@ void drop_slab_node(int nid)
 		freed = 0;
 		memcg = mem_cgroup_iter(NULL, NULL, NULL);
 		do {
-			freed += shrink_slab(GFP_KERNEL, nid, memcg, 0);
+			freed += shrink_slab(memcg, &sc, nid);
 		} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 	} while (freed > 10);
 }
@@ -2684,8 +2690,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 
 		shrink_lruvec(lruvec, sc);
 
-		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
-			    sc->priority);
+		shrink_slab(memcg, sc, pgdat->node_id);
 
 		/* Record the group's reclaim efficiency */
 		vmpressure(sc->gfp_mask, memcg, false,
-- 
1.8.3.1

