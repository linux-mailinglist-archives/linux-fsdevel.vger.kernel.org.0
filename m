Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9DB2DA393
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 23:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441142AbgLNWlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 17:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502578AbgLNWjM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:39:12 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71286C061257;
        Mon, 14 Dec 2020 14:37:59 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id t8so13163831pfg.8;
        Mon, 14 Dec 2020 14:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w3fRQtpX8VRWJVNuVlihrDSl4Ew2OVDi3uoQ+orHFSM=;
        b=TUWsLN2EIgkfe9UBwtBIZfE2DYuDAvqDdRMI2Mzue4kMvvvzUiNj6Hple87HPp2G/p
         m2vn8lIGJ3ccErxvg6+mSJA9OIBTGnlxjN6kAz2Ha+JqXXUyhU6ToD/1s9ggBTx8my9u
         GDBG3+FZfNKeJlTdz+jGhB9ials3Yak4nSI6MqItr76HUvhNN/v50JsTz7G9COEt0C8Z
         fRLPSSHRlyYvfdIhxC8cpseF5JQJl/PbjXNlLlCtz45Czf8pup73ukEbKZSEmX/yD+JD
         NHII5vcveR9S7an5u1MUIetWNpbfHppz2X41tSHAnIv/Y2ezkciJBMStXI6b4xSAf1R0
         XaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w3fRQtpX8VRWJVNuVlihrDSl4Ew2OVDi3uoQ+orHFSM=;
        b=K5Vr8ZK7eRd99/AhtfUh9ZNSmaQe1ip1XgxQoFUYTwbusHjK5K7jhIKxkybZ+8AwF5
         pL7eyZ56Yk1i0uu+IMJfXb86qYdTwdaJMrNa5cGs2JXgbH1lkbxf3JxAH2bdnBiBm5f6
         Nl3H6RTVSilpnLk85s9ZMyjIL57Yckx59SriCbT9FTOrZds5bfq64oIH11zXuABxG2+o
         IHwC6UHYl9PM42iM6kesLBe97H2m8mwCwkPK2yP9MN+SEcYta7RpnGTnTbpl/gSTJvJW
         8s1hmWiPMJtdkf0QjhPyjxn/5mMtMsza+mt2MLVRkpNDLNZ/utvlJgS6CEk4PoDEm155
         NFKA==
X-Gm-Message-State: AOAM531xqAZHr1yRsdNZf1tnT+wB/rH0UNsjk+Vpirwv+qDbOU9cxTEV
        Yv0Chq0CLLWe8EBG73xdaZ4=
X-Google-Smtp-Source: ABdhPJy5whBOYsOd14m3qSnV22diJRbUamHDpaAsnC9yQbAgm+Kzx7vaAAYra+01E60AsBNY91361Q==
X-Received: by 2002:aa7:85d2:0:b029:1a2:73fe:5c28 with SMTP id z18-20020aa785d20000b02901a273fe5c28mr14313012pfn.40.1607985479060;
        Mon, 14 Dec 2020 14:37:59 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id d4sm20610758pfo.127.2020.12.14.14.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:37:58 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 8/9] mm: memcontrol: reparent nr_deferred when memcg offline
Date:   Mon, 14 Dec 2020 14:37:21 -0800
Message-Id: <20201214223722.232537-9-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201214223722.232537-1-shy828301@gmail.com>
References: <20201214223722.232537-1-shy828301@gmail.com>
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
index 1eac79ce57d4..85cfc910dde4 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -78,6 +78,10 @@ struct shrinker {
 };
 #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
 
+#ifdef CONFIG_MEMCG
+extern int shrinker_nr_max;
+#endif
+
 /* Flags */
 #define SHRINKER_REGISTERED	(1 << 0)
 #define SHRINKER_NUMA_AWARE	(1 << 1)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 321d1818ce3d..1f191a15bee1 100644
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
@@ -612,6 +613,28 @@ void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
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
index 8d5bfd818acd..693a41e89969 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -201,7 +201,7 @@ DECLARE_RWSEM(shrinker_rwsem);
 #define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
 
 static DEFINE_IDR(shrinker_idr);
-static int shrinker_nr_max;
+int shrinker_nr_max;
 
 static inline bool is_deferred_memcg_aware(struct shrinker *shrinker)
 {
-- 
2.26.2

