Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18766E0B8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 12:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjDMKkr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 06:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjDMKkm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:40:42 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B081B6
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 03:40:41 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-63b5a2099a6so26218b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 03:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681382440; x=1683974440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I6Nt0ZH454lLp6ex7hg7kbI+ex/azfnI8thXAXjWVq8=;
        b=G81CdUEmMWAR7s/uUh1o00+dki8yY8e8KOGduTMJ10Ih63YAx82qvcDq20SAZSx+g/
         ueZ3Msj52pKD1lqBImwulf/tYkqr/iT+UOeW4fd3KBZv547W+MwD6xwGD67DaW0HpcOa
         cz9n6Ru3its9gZbaaSThe+VV0hYHOvVD9yp2j0yltd9IKliEUrjXqAr+OK7m03l2qytF
         xr+P3ML7/b+lezaU3DwMQukf+O+TPg5UG2i07gjQlaxwJnTBDRcJhvP64M/wiFfrpZzz
         h7ozlZBA7r8DTpqJhi25AoIblQhs+3bOV3uTp+JguZijEY3iI74Y975Ed/lYiOS4TnGE
         iVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681382440; x=1683974440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6Nt0ZH454lLp6ex7hg7kbI+ex/azfnI8thXAXjWVq8=;
        b=JBe9TTgiA5zq1lTwXhWh/4i/H1VcuyXviIdkD2dXr2Yv7KnymQzWmqs81C6t6vzyc+
         BMXmQ0WmAf6X+C9PGG5BtJYwP7j5Ijun+8+nmtRins1jsTsdFIUeFXTGouOrHEsr1WIe
         Tk/azlKy2qD7ZMOuMrT1y2q+0owbeuTvMBWxspZEBcku8PQ9KgSiLPj0k9ZLuWIMaXTY
         qVxvNJF8lE9h2NtTNy8mElJ+OGOu0yJf9kQFfjbXWfoHRh0GHNPXlIcABQCHlv8S9r8t
         O1QEFdT1VRFLn0yRyAPrLKTdHgN/kLB/tm2S2G1geYb2Jyu+oCpiA13cATHR6PVPjlRn
         31PQ==
X-Gm-Message-State: AAQBX9e33xjdEkEQ7VBumt1lsPMa9cJ0Mzyw7SD90rhPCHx7CGKaoVBc
        oubJfUbrjAWlXWcILvIT89XDH6vIN5xzq6r1
X-Google-Smtp-Source: AKy350b4iSx5ozD7gi39VrWatA78FUtgnIqT2lDjsg7piXFtlDqLoC4lH3GhIMzW/GNCYSdmkQiW7wqZ38a9M/36
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:2e1d:b0:63b:234e:d641 with
 SMTP id fc29-20020a056a002e1d00b0063b234ed641mr975833pfb.4.1681382440554;
 Thu, 13 Apr 2023 03:40:40 -0700 (PDT)
Date:   Thu, 13 Apr 2023 10:40:33 +0000
In-Reply-To: <20230413104034.1086717-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230413104034.1086717-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230413104034.1086717-3-yosryahmed@google.com>
Subject: [PATCH v6 2/3] mm: vmscan: move set_task_reclaim_state() near flush_reclaim_state()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move set_task_reclaim_state() near flush_reclaim_state() so that all
helpers manipulating reclaim_state are in close proximity.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/vmscan.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index be657832be48..cb7d5a17c2b2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -188,18 +188,6 @@ struct scan_control {
  */
 int vm_swappiness = 60;
 
-static void set_task_reclaim_state(struct task_struct *task,
-				   struct reclaim_state *rs)
-{
-	/* Check for an overwrite */
-	WARN_ON_ONCE(rs && task->reclaim_state);
-
-	/* Check for the nulling of an already-nulled member */
-	WARN_ON_ONCE(!rs && !task->reclaim_state);
-
-	task->reclaim_state = rs;
-}
-
 LIST_HEAD(shrinker_list);
 DECLARE_RWSEM(shrinker_rwsem);
 
@@ -511,6 +499,18 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 }
 #endif
 
+static void set_task_reclaim_state(struct task_struct *task,
+				   struct reclaim_state *rs)
+{
+	/* Check for an overwrite */
+	WARN_ON_ONCE(rs && task->reclaim_state);
+
+	/* Check for the nulling of an already-nulled member */
+	WARN_ON_ONCE(!rs && !task->reclaim_state);
+
+	task->reclaim_state = rs;
+}
+
 /*
  * flush_reclaim_state(): add pages reclaimed outside of LRU-based reclaim to
  * scan_control->nr_reclaimed.
-- 
2.40.0.577.gac1e443424-goog

