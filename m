Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5126D5477
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 00:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjDCWEN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 18:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjDCWEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:04:06 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C924C35
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 15:03:49 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id d13-20020a17090ad98d00b00240922fdb7cso10509936pjv.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 15:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680559428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QacupsFZGNVPJSGTJC6YypXeluEyL82tnZkM1VlhIdc=;
        b=kWaOfIm3ix3CjQ6P0LRgdpWoqBgJu3ykmdsz32NiUF8x9A1dmCU0K7B4JSzYOReEDZ
         FYgPQlT3SuWLrHKrP3wDopLbn9eVfq4lg7l4naylQ8tTZgKaGOhXPPjrkCrnIEo3mSYz
         lk/IOCkztnHJOg8hCDeaYralpjItb0pP1L9kf7xz8p5kouBsn/T4mHo837Hsw6EVM4fX
         wXifin0wFGMZCFLJ9fRpD2UTXhFCMfIx9NWguUNma600XyrmJZUcuoS1IkX3lwn5WJbF
         /q9yx8rYhgQBtZhs0hPFucZM0Rd23Z/nGcnjDiwXILvEaD94FJtXEZgMXINCRE/Es3tO
         KyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680559428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QacupsFZGNVPJSGTJC6YypXeluEyL82tnZkM1VlhIdc=;
        b=DAwE7HSStJUPQzr+gf5Ul9mEjb+0k6aMWQ4bLZEp6L2srcH5XA+DHNZcYoke+IoQBR
         HGafX4LPle20hIazqmb1N0wMvEH+sVv9/Qq9ewy3zG7MkXzk+8ya9yRJOdM7cdQEYXKG
         c2eaaZoTOvYq7vXf2G4TBhiYdwKsAhj/7bqiVjf1xc5eI5qlyu0Fv4ztL0uGmAZy4UOQ
         LiWtC9iFhBVf8zUdG3oMnCP/bvY51ABlM5IRt5RFivpi8k0GrfmzpIepRAniqpkQeHDc
         VXmpb8gtuvtysi/zRIdpUmBxOLa//bqXE11gDE4XwHWIygsCMXoeijLGswCpQ2xMRAu4
         YAHQ==
X-Gm-Message-State: AAQBX9c1Z56fEqr6jV0J9nZWjerqmbxUhsuZqFW07Z7+RhThw3dITD5t
        91WSnm9luGYNahC8WcsAPwk4t666eOPpkE6I
X-Google-Smtp-Source: AKy350bOmcX4bhvMcYbhTSAl8lBQ2O0deW3xZkttmpHKSB+VEjNEWJFCZZnxKvEdtC6SV8VkwoJDDIrEQNByEpas
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:485d:0:b0:4f2:8281:8afb with SMTP
 id x29-20020a63485d000000b004f282818afbmr35913pgk.4.1680559428241; Mon, 03
 Apr 2023 15:03:48 -0700 (PDT)
Date:   Mon,  3 Apr 2023 22:03:37 +0000
In-Reply-To: <20230403220337.443510-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230403220337.443510-6-yosryahmed@google.com>
Subject: [PATCH mm-unstable RFC 5/5] cgroup: remove cgroup_rstat_flush_atomic()
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

Previous patches removed the only caller of cgroup_rstat_flush_atomic().
Remove the function and simplify the code.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/cgroup.h |  1 -
 kernel/cgroup/rstat.c  | 26 +++++---------------------
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 885f5395fcd04..567c547cf371f 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -692,7 +692,6 @@ static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
  */
 void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
 void cgroup_rstat_flush(struct cgroup *cgrp);
-void cgroup_rstat_flush_atomic(struct cgroup *cgrp);
 void cgroup_rstat_flush_hold(struct cgroup *cgrp);
 void cgroup_rstat_flush_release(void);
 
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index d3252b0416b69..f9ad33f117c82 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -171,7 +171,7 @@ __weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
 __diag_pop();
 
 /* see cgroup_rstat_flush() */
-static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
+static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
 {
 	int cpu;
@@ -207,9 +207,8 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
 		}
 		raw_spin_unlock_irqrestore(cpu_lock, flags);
 
-		/* if @may_sleep, play nice and yield if necessary */
-		if (may_sleep && (need_resched() ||
-				  spin_needbreak(&cgroup_rstat_lock))) {
+		/* play nice and yield if necessary */
+		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
 			spin_unlock_irq(&cgroup_rstat_lock);
 			if (!cond_resched())
 				cpu_relax();
@@ -236,25 +235,10 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 	might_sleep();
 
 	spin_lock_irq(&cgroup_rstat_lock);
-	cgroup_rstat_flush_locked(cgrp, true);
+	cgroup_rstat_flush_locked(cgrp);
 	spin_unlock_irq(&cgroup_rstat_lock);
 }
 
-/**
- * cgroup_rstat_flush_atomic- atomic version of cgroup_rstat_flush()
- * @cgrp: target cgroup
- *
- * This function can be called from any context.
- */
-void cgroup_rstat_flush_atomic(struct cgroup *cgrp)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&cgroup_rstat_lock, flags);
-	cgroup_rstat_flush_locked(cgrp, false);
-	spin_unlock_irqrestore(&cgroup_rstat_lock, flags);
-}
-
 /**
  * cgroup_rstat_flush_hold - flush stats in @cgrp's subtree and hold
  * @cgrp: target cgroup
@@ -269,7 +253,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 {
 	might_sleep();
 	spin_lock_irq(&cgroup_rstat_lock);
-	cgroup_rstat_flush_locked(cgrp, true);
+	cgroup_rstat_flush_locked(cgrp);
 }
 
 /**
-- 
2.40.0.348.gf938b09366-goog

