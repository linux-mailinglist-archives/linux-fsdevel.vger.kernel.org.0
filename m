Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0EF2CC528
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 19:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389517AbgLBS3Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 13:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389485AbgLBS3G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:29:06 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFA1C061A4A;
        Wed,  2 Dec 2020 10:28:03 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w6so1790762pfu.1;
        Wed, 02 Dec 2020 10:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKQ+xPb0r9nNI6kfI9ZBDBE9gitSqzBXebPL/8fpVzE=;
        b=nj/7BqYlZwg8znD81/vfXzs6ArF+M8qXSuJ5a9WuI9e/hfRhm1v4/gYPWalwc/TlM4
         6F/rSomsJXUQ4EpDQYFpSAh82V/WqdjDxQ2e8nvwVXN7wBTBOk61H5J76pHR1CCCBP6D
         nlYjFzW2cVvnSbb1SgCjZYUhc6Buvlkzq0ysPluyZJKMDazAYg5pvKm6HEKabirJdpd0
         uznrcMTWGebypvAmrpfEszv8FySwjX9gEMsLuqnOlTc4nluRGe74wVn2CsrAkjtWn0q7
         H6fB3X1eUY8eDTWJO1Byk1fTG7f99wZrqKamabm9OrNTJe1U0dkxa51GjjCm53Yu8RsL
         hh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKQ+xPb0r9nNI6kfI9ZBDBE9gitSqzBXebPL/8fpVzE=;
        b=CAaU4Y17uruZF6dtXlSasDrVr7tgsUWe3mTEXd5hTzN3PRUNyeHBbhoe/RaWzPjfBr
         VwZ1V23+KlFitSWLtgPznnlZSBkZNLDaJisS+rqVQwewD9fgIgVx9YDK8cN5PkPyutCu
         sWqRood1KUVVj1NPULOTRgahHnsi/5LfDiW1oCB3ZqW20lYNvlO8PRxbrT1taBjyiWug
         bZFTv6MZ0C2XBxvpQf9rw46kiZi/FBtd4qkwMFUwPF77NxTcRrHvp7SfaIh1EcyRRh68
         +px/xVyEGWvwm//phhnLsofqMgak/rdVb5wRDFTD0kKA96VQSStUvvEZusDvbUfjTtpj
         N+7g==
X-Gm-Message-State: AOAM532SALhEYBwPb62Z+fYLJqfDpH5eD9BN/N2i39HTJUv+RRhy600+
        zf1P1D5LahvqFMk+j1ndKDg=
X-Google-Smtp-Source: ABdhPJxQKoIFdMyU/1Ay7uLq3AbzqAGodA79ySyV5eVU7XWUWSccqPYCWM43OGq8/UFqVQgC2Ouo/Q==
X-Received: by 2002:a05:6a00:134d:b029:18b:2cde:d747 with SMTP id k13-20020a056a00134db029018b2cded747mr4069247pfu.60.1606933682661;
        Wed, 02 Dec 2020 10:28:02 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id c6sm396906pgl.38.2020.12.02.10.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:28:01 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] mm: memcontrol: reparent nr_deferred when memcg offline
Date:   Wed,  2 Dec 2020 10:27:24 -0800
Message-Id: <20201202182725.265020-9-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201202182725.265020-1-shy828301@gmail.com>
References: <20201202182725.265020-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now shrinker's nr_deferred is per memcg for memcg aware shrinkers, add to parent's
corresponding nr_deferred when memcg offline.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/shrinker.h |  4 ++++
 mm/memcontrol.c          | 24 ++++++++++++++++++++++++
 mm/vmscan.c              |  2 +-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 0bb5be88e41d..8f095e424799 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -82,6 +82,10 @@ struct shrinker {
 };
 #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
 
+#ifdef CONFIG_MEMCG
+extern int shrinker_nr_max;
+#endif
+
 /* Flags */
 #define SHRINKER_NUMA_AWARE	(1 << 0)
 #define SHRINKER_MEMCG_AWARE	(1 << 1)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d3d5c88db179..df128cab900f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -59,6 +59,7 @@
 #include <linux/tracehook.h>
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
+#include <linux/shrinker.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -619,6 +620,28 @@ void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 	}
 }
 
+static void memcg_reparent_shrinker_deferred(struct mem_cgroup *memcg)
+{
+	int i, nid;
+	long nr;
+	struct mem_cgroup *parent;
+	struct memcg_shrinker_deferred *child_deferred, *parent_deferred;
+
+	parent = parent_mem_cgroup(memcg);
+	if (!parent)
+		parent = root_mem_cgroup;
+
+	for_each_node(nid) {
+		child_deferred = memcg->nodeinfo[nid]->shrinker_deferred;
+		parent_deferred = parent->nodeinfo[nid]->shrinker_deferred;
+		for (i = 0; i < shrinker_nr_max; i ++) {
+			nr = atomic_long_read(&child_deferred->nr_deferred[i]);
+			atomic_long_add(nr,
+				&parent_deferred->nr_deferred[i]);
+		}
+	}
+}
+
 /**
  * mem_cgroup_css_from_page - css of the memcg associated with a page
  * @page: page of interest
@@ -5543,6 +5566,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	page_counter_set_low(&memcg->memory, 0);
 
 	memcg_offline_kmem(memcg);
+	memcg_reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
 
 	drain_all_stock(memcg);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5fd57060fafd..7dc8075c371b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -201,7 +201,7 @@ static DECLARE_RWSEM(shrinker_rwsem);
 #define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
 
 static DEFINE_IDR(shrinker_idr);
-static int shrinker_nr_max;
+int shrinker_nr_max;
 
 static inline bool is_deferred_memcg_aware(struct shrinker *shrinker)
 {
-- 
2.26.2

