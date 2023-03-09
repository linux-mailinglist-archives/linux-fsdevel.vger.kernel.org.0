Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D51F6B2012
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 10:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCIJbc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 04:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjCIJba (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:31:30 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040EA32505
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 01:31:29 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id mp16-20020a17090b191000b0023ab4b5b064so885372pjb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Mar 2023 01:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678354288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6dgxagOpBb1myYnk/1Y2AGrRWWDZLYTueWoLu8qIY4=;
        b=KzU6h4ueyt1nc3fHTw62ynzTN6cM5FPoDfMBmAqJ1Wwes61zVej5BOhlYyPncxm4Zm
         nkjKeBNIQMZU0E9YJO2405czXqReQIP71dpM6JRcIVBwGfbOfnDAO+93r67dHWvV1VcL
         zONddPvKo2/hWkzUIRnhDO3Zqp+7yh7T+acFffATa66sYzOvTr15BMFihxW3t2a2tMq/
         8Ig75rYkpQRqgddwtZBlA3k3y0eMCsf3xzOYsCI2yvjWMp0avrLAbOSW5a+OH2FI5iL+
         ETd/0TFbN+DnBMOE/8xtP1qGx1HOTcBW/q+JbvhFqWJVi18NNllY9Hag5hM4SObpgkS6
         mKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678354288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6dgxagOpBb1myYnk/1Y2AGrRWWDZLYTueWoLu8qIY4=;
        b=LGUKt2LTAP99QNsM2EAgCoLTxEwGbq+Ar6RRa7hOVr3IimZBDJls94b8qEgfgTJsZj
         +kymrvM1dyl1avMhLHjxGDQghpMPiNEMsZzj7EcMX0MKM0ktoxS2eAbg1ERyFAp5L8G3
         Ion7oE9ugxGkPRD6JypB2H+uQiWefUFkeTK6XCXfpKIuLOUt3MWlH2mQdcQWF730MNgJ
         +E+yTAaY1qfx8cDWElMybgkUrYKIrErJNG1cVZqZeZm4dQ+DZ60bAfJJvXYg95SAiH7G
         EbCMpjchxmTuJiuC38i2KRyS44jUQmOBEIoo0d1E1r6VoUjp9FT57ZU5+cQPBOPUNPcw
         +nIA==
X-Gm-Message-State: AO0yUKUjPn13QsFdSFwJdjiRm7Pl8Fl1SxlU8SOBoBBCmaPnK2nBlrZo
        +PiAV36BKAOz4ZiKu8waj/yoXxw8YQMfS30l
X-Google-Smtp-Source: AK7set82CEBSuqo8FpS3nsNPKqDoN9u1SA11kEpTwZaYFka9KSS8D9zMVtgu+8uzsp90VdIxYuFl/oAa7auTdfM+
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:5508:0:b0:502:fd71:d58c with SMTP
 id j8-20020a635508000000b00502fd71d58cmr7728137pgb.9.1678354288447; Thu, 09
 Mar 2023 01:31:28 -0800 (PST)
Date:   Thu,  9 Mar 2023 09:31:07 +0000
In-Reply-To: <20230309093109.3039327-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230309093109.3039327-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230309093109.3039327-2-yosryahmed@google.com>
Subject: [PATCH v2 1/3] mm: vmscan: move set_task_reclaim_state() after cgroup_reclaim()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

set_task_reclaim_state() is currently defined in mm/vmscan.c above
an #ifdef CONFIG_MEMCG block where cgroup_reclaim() is defined. We are
about to add some more helpers that operate on reclaim_state, and will
need to use cgroup_reclaim(). Move set_task_reclaim_state() after
the #ifdef CONFIG_MEMCG block containing the definition of
cgroup_reclaim() to keep helpers operating on reclaim_state together.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/vmscan.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9c1c5e8b24b8..fef7d1c0f82b 100644
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
 static long xchg_nr_deferred(struct shrinker *shrinker,
 			     struct shrink_control *sc)
 {
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

