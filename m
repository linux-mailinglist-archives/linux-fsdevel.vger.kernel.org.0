Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FFE6D546A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 00:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbjDCWDr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 18:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjDCWDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:03:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868A5E5B
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 15:03:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-546422bd3ceso129342417b3.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 15:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680559423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Hf88QAEgRalaH3f7thcio7vExcVqqDxAYa/aCaE9Jc=;
        b=Qd1B7SbDQyGizezUFQyV/0tO/bOhj44AtZ1VKHtgOG9TbJavAnnMGZmO6zQIpqIoK7
         5cj24hiW5m5RcceJDQ1KEplDfhRxIe4M8gmfj3L+NZAuLHvyis3MtYjzW6MZhBerb1QT
         JbsSvLpI6syO5GW80nsYNqGOYj2kCCLCJxDrHY++EHRBCuORnOG3ZRIIIY9qF02f9mrK
         7QKQBjFz8zSpKFSQE5ME0/wr0Ah4Zv+Tdpoq6l9nLH2lZJPiIROIUeme5UI6HVL7rK6b
         PMhT9C0HP1QYba587rjt9xa6OsG8uX3e11ytS9ZKFnspyAhVnb6ce2SHS6u9IWMy0H74
         szug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680559423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Hf88QAEgRalaH3f7thcio7vExcVqqDxAYa/aCaE9Jc=;
        b=6KiPFHO7NVtweYpwCkLF7kiQ6q5LznaQUZTwehBFbfqM8MlYmXtRHPDMeGX63z4Kvz
         vZ9GWlzwxHXTla7XyfCcvreid+FhH46wBxzaGsKqee149pHLQTM+0dR5n0ry/M2Ihud8
         VGcVR5jPhrDdrYMdvtOI59jH31aat4RMytrWlWxNKLiXEyltpWE1NYCVwkrmr/fAi8my
         I4xmG418nPmesn0NJxR2CckwdZgPCOdIMj/hvU9q7G81KVGpaoN2DrZfddpZjTBmDDaU
         VIEk1xZ2tOC0gRStKM/zrLGR714PXsdotS1AnzwN7X2jPsMwbmom3epHitCDf0UeKTT2
         tYgQ==
X-Gm-Message-State: AAQBX9fQK3q3kaJBhtJfjGiWfp7atdsy1IKQd/RSMTTY5dF6TNLeyKcL
        2HtrTl8Q1i2ihjlrtR+Y1KXxqN4NOIfmLl6z
X-Google-Smtp-Source: AKy350Yk7PN55oyTS/2Ex0GZoWZBdH4qO4jUdn7c2dJd2J2mTTnpo7+qXB1LBcPp06lmU8+Do/T+aXIn4r5a27Uq
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:b60f:0:b0:545:bade:c57e with SMTP
 id u15-20020a81b60f000000b00545badec57emr288637ywh.5.1680559422857; Mon, 03
 Apr 2023 15:03:42 -0700 (PDT)
Date:   Mon,  3 Apr 2023 22:03:34 +0000
In-Reply-To: <20230403220337.443510-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230403220337.443510-3-yosryahmed@google.com>
Subject: [PATCH mm-unstable RFC 2/5] memcg: flush stats non-atomically in mem_cgroup_wb_stats()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The previous patch moved the wb_over_bg_thresh()->mem_cgroup_wb_stats()
code path in wb_writeback() outside the lock section. We no longer need
to flush the stats atomically. Flush the stats non-atomically.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3d040a5fa7a35..bdd52fe9e7e4b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4637,11 +4637,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
 
-	/*
-	 * wb_writeback() takes a spinlock and calls
-	 * wb_over_bg_thresh()->mem_cgroup_wb_stats(). Do not sleep.
-	 */
-	mem_cgroup_flush_stats_atomic();
+	mem_cgroup_flush_stats();
 
 	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
 	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
-- 
2.40.0.348.gf938b09366-goog

