Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD9E6EB0C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 19:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjDURkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 13:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjDURkd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:40:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A291012589
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 10:40:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b98f3ca02b5so2075899276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 10:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682098832; x=1684690832;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xEOFJLcgICBTmNTLnyQD1ooBVf7w9cMBHK4zBwAxhps=;
        b=2LLI0uS0HCGgUG+To5FG73zbxk+tuzk5tTcOBZNGKwnVbYk9yq2r0zkyTl0MD4wfQ3
         kKiggVfa7NNclULg8NuxAqHV3zYnq7LZjfMrcVD62yChQCNHWbk54zVsBhxomTb0t0SN
         +XgJr7wul3fQD2JopF/MZfktxPtuUWKER8IL9ZU+RSEl7sW66jFXxgj6K5ErZztO7Nce
         l4ZWAyWNanyDDUgKfIgOcWOkpHNwJKJvYyr6/84gH8i9GqoBVPKeVaSusHPk+GdeSMBt
         A9hidHBqS6YCIVpadKtHiQ8uYxCY8mC3l7iI3bjfr9izY/KQoToKFIDt3lP79eIF321D
         fMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098832; x=1684690832;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEOFJLcgICBTmNTLnyQD1ooBVf7w9cMBHK4zBwAxhps=;
        b=fwAqsuICJanVqlRRsgUembDrXgTm3LO0cWxy75i0LdKqA3DkGowANnPRdS/rtTnwf3
         mHyx2m5InoTASm0h234fptxcHLn2A0X9cjF+IFDYCXRFv2NjIy68i0glF9TyRKXjUUKC
         sIjP+tOHO+MY+tJcJZLjxJmXmNYIkUmaVhw+oo8BbS/19uvauX7nbJTrOqSwCeiQg3d3
         syq0QNzCeiuxN5g0ssC78OvWBIYPRegWzPSTJsNUcMKnje0eOQUL2jfbDnUd2FUN5xwX
         jmCGZwDzQMwWXYBg9spwfH/lZVippeClEJz6/UfJdoxcCp6OzEoVEOrFdhqsXNs9JW1Z
         t+fA==
X-Gm-Message-State: AAQBX9dgN7RTR0nQ0IRspBg7BUhbHb8P8XH0VypM1uflU3Udjzidaj2S
        M+1rxCjHIIVBZqILM0WoGX++myNBUlPzwQXm
X-Google-Smtp-Source: AKy350ZZ8ts19Uuwp1KvgVZn+d+WSE2zsbcOTm9kgrCL3PJuuy6na6YJxn3jgGZppB+bAg1Vc1I9v8GZpcBWJ5vX
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a25:bc4a:0:b0:b33:531b:3dd4 with SMTP
 id d10-20020a25bc4a000000b00b33531b3dd4mr1583021ybk.1.1682098831943; Fri, 21
 Apr 2023 10:40:31 -0700 (PDT)
Date:   Fri, 21 Apr 2023 17:40:20 +0000
In-Reply-To: <20230421174020.2994750-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230421174020.2994750-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421174020.2994750-6-yosryahmed@google.com>
Subject: [PATCH v5 5/5] cgroup: remove cgroup_rstat_flush_atomic()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
index 885f5395fcd0..567c547cf371 100644
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
index d3252b0416b6..f9ad33f117c8 100644
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
2.40.0.634.g4ca3ef3211-goog

