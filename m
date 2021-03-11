Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34C6337D45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 20:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhCKTJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 14:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhCKTJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:09:15 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1120C061574;
        Thu, 11 Mar 2021 11:09:14 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gb6so3940110pjb.0;
        Thu, 11 Mar 2021 11:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m2bLEDF9fLJ0ubUMCl5gxJ4ENWjURCD7GlteN0I+Pn0=;
        b=Mi6pTvW8VJpVzzmhCHBU6uqews5NbK1wW8i7GWTUtcQJm40tQfsU3q/4i1dMSxHChA
         fk6MOedbmi4Dz8b7j7f1wh094bz8Tx5NrY7UsuzP2ASxI72pn0IuoBBVuMk43qFKPe8C
         1cZA14u5QtwgFBzSURdke1P3WrCzExGbRVN1esGKANq6X5K9sbVyb3V7XoqeNexexucz
         FPYL/JPcPEexxog48emnyY+vMOIt9v1CyZKrbKjjc4BFkKUTaiNbT3hhy29DxT0AdsAK
         Rzk+DWX1+6urZv54JXCIQfJ7IxTYAkD9RnK4LQFq1LcW0b8nwp6SP+d25idwc3fprVC+
         Iv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m2bLEDF9fLJ0ubUMCl5gxJ4ENWjURCD7GlteN0I+Pn0=;
        b=HaDrr8kRB5AKnmXPvLXWwyc4xkDhWJtwWwwsqRLbah8brOg25HMV69eHpikoplDXwM
         2KGBZS0LX5GikzORAdbbVtEonlvIV7rQ77qZTtDXfy5tv1bd88CbYT64HHujyIQqBqrb
         5v3EwJtMLcFtUHhu49/jnO6OgmIO+xVDdlUDfAnHwgQyGTbN9sGQFdd30sqjx+IcR5Yx
         1ir9HtvVcf4W3IikTdr2Eme717cARK2Li2dmuFxDELgaWuk8VyAUOepesmh/TWvxuTqj
         3hvXUuQzcdpPPu8oFNn2bQA75u5sQsvijvwa13VW0JEAfMoQJre0cf4H5IctiShnkW9s
         IKag==
X-Gm-Message-State: AOAM530jRhTYl+t0WIRtaG+2+4Z0deNnAePciUfVBZN6m3AiOZF0Moi4
        AFdL29HpSbzNEg0+PA9KIf4=
X-Google-Smtp-Source: ABdhPJy6nmhaP70hLjuP7UUkSI2vRg+R6cLVH31ME6nZFnyfjO/2L99AjBImPmBY4M11zbaB7ha1TA==
X-Received: by 2002:a17:90a:fd0b:: with SMTP id cv11mr10319170pjb.183.1615489754458;
        Thu, 11 Mar 2021 11:09:14 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id t12sm2999111pfe.203.2021.03.11.11.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:09:13 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v10 PATCH 07/13] mm: vmscan: add shrinker_info_protected() helper
Date:   Thu, 11 Mar 2021 11:08:39 -0800
Message-Id: <20210311190845.9708-8-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210311190845.9708-1-shy828301@gmail.com>
References: <20210311190845.9708-1-shy828301@gmail.com>
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
 mm/vmscan.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7fdfdacf9a1f..ef9f1531a6ee 100644
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
@@ -201,7 +208,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
 
 	for_each_node(nid) {
 		pn = memcg->nodeinfo[nid];
-		old = rcu_dereference_protected(pn->shrinker_info, true);
+		old = shrinker_info_protected(memcg, nid);
 		/* Not yet online memcg */
 		if (!old)
 			return 0;
@@ -232,7 +239,7 @@ void free_shrinker_info(struct mem_cgroup *memcg)
 
 	for_each_node(nid) {
 		pn = memcg->nodeinfo[nid];
-		info = rcu_dereference_protected(pn->shrinker_info, true);
+		info = shrinker_info_protected(memcg, nid);
 		kvfree(info);
 		rcu_assign_pointer(pn->shrinker_info, NULL);
 	}
@@ -675,8 +682,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	if (!down_read_trylock(&shrinker_rwsem))
 		return 0;
 
-	info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
-					 true);
+	info = shrinker_info_protected(memcg, nid);
 	if (unlikely(!info))
 		goto unlock;
 
-- 
2.26.2

