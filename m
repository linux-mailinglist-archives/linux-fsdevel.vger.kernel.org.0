Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0C8407B75
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Sep 2021 06:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhILEOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Sep 2021 00:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhILEOa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Sep 2021 00:14:30 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4F9C061574;
        Sat, 11 Sep 2021 21:13:16 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id e16so5651079pfc.6;
        Sat, 11 Sep 2021 21:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1KbLREz15lk0MtSh9h887AXds7LlCcaKK7C95B4VbDY=;
        b=kkIzx6ASRR9yKSXgI/t6spVzuhmyJczTj5fFwBLfpypozKHcPMZ0bSYMuPh7j6j/HH
         6Z9s8CNouUOgbV5edEy/BcSpipWRqyWe7eugkg6zLDdwCshFuBOThPUfTZLKTdRLy9zD
         7bk0uKf05USU81zTeplHEJpMfWXGTKlB+pryAmaHex4MmR0WekVv6O6OvNGfvAdd6pcv
         qeCmYix7tmzLOiaz4vOfpSqUe6IouJF1sGLIOVdE+qFycGlpa6TvhRgZUff48Np+Qyps
         e4gVZ28ubosF+QvPyAetomoRvio3PAackM3nJimvG8yDFgpD2WQU1u+9kb4rNPsZ+hJn
         pTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1KbLREz15lk0MtSh9h887AXds7LlCcaKK7C95B4VbDY=;
        b=h7Vv+XJbfFl8IkVaA1WJpKrEkngCkE2lBQASUBzI9ZdKJY/AZZ9lvdfwVJW/MshR8S
         TA2LGJz75Gf/JMA2v27hXdwfY3g5deCaNtHcs1qGzowF1waDZd1mgrkfWRqqsAljzs9e
         /DyR5DvuvqlOXcZivDFELfgO4Yml9mitxKWSXyClSAZsom5s3+1aAPVG0VopJsAfSyug
         iEywe94qu8G0mbOSxJO5J5CQV54ilhofzIypFVX+LJJfqkUyqbBbXNatTOdLtaaY17Ii
         ZD7QehHAhIDEENYwkRw+LCnksffHvur12tP1HNZGAqmsedHdTTvbP8Yyi6+S6hrmLx/E
         IViA==
X-Gm-Message-State: AOAM531ImLMgSZg2obHZR/FTF9XRUzmCB38R4wjQ43DNkPulDcyc83Do
        qPAkRBNPLItj64r+2Fd6WCU=
X-Google-Smtp-Source: ABdhPJx9fk1GQ//vmXTQkX959b8fjaj1SY2/PIk2fPvsEYivSUg7DcbmWxevVi0k7vfW4wINZZxqDQ==
X-Received: by 2002:a63:4563:: with SMTP id u35mr5023521pgk.275.1631419996063;
        Sat, 11 Sep 2021 21:13:16 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b13sm2857685pjk.35.2021.09.11.21.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 21:13:15 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     peterz@infradead.org, yzaikin@google.com, liu.hailong6@zte.com.cn
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, mcgrof@kernel.org, keescook@chromium.org,
        pjt@google.com, yang.yang29@zte.com.cn, joshdon@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH] sched: Add a new version sysctl to control child runs first
Date:   Sun, 12 Sep 2021 04:12:23 +0000
Message-Id: <20210912041222.59480-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

The old version sysctl has some problems. First, it allows set value
bigger than 1, which is unnecessary. Second, it didn't follow the
rule of capabilities. Thirdly, it didn't use static key. This new
version fixes all the problems.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reported-by: Zeal Robot <zealci@zte.com.cm>
---
 include/linux/sched/sysctl.h |  2 ++
 kernel/sched/core.c          | 35 +++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c          |  3 ++-
 kernel/sched/sched.h         |  1 +
 kernel/sysctl.c              |  6 ++++--
 5 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 304f431178fd..0a194d0cf692 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -74,6 +74,8 @@ int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
+int sysctl_child_runs_first(struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos);
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 extern unsigned int sysctl_sched_energy_aware;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c4462c454ab9..bfea7ecf3b83 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4323,6 +4323,41 @@ int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 #endif /* CONFIG_PROC_SYSCTL */
 #endif /* CONFIG_SCHEDSTATS */
 
+DEFINE_STATIC_KEY_FALSE(child_runs_first);
+
+static void set_child_runs_first(bool enabled)
+{
+	if (enabled) {
+		static_branch_enable(&child_runs_first);
+		sysctl_sched_child_runs_first = 1;
+	} else {
+		static_branch_disable(&child_runs_first);
+		sysctl_sched_child_runs_first = 0;
+	}
+}
+
+#ifdef CONFIG_PROC_SYSCTL
+int sysctl_child_runs_first(struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table t;
+	int err;
+	int state = static_branch_likely(&child_runs_first);
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	t = *table;
+	t.data = &state;
+	err = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
+	if (err < 0)
+		return err;
+	if (write)
+		set_child_runs_first(state);
+	return err;
+}
+#endif /* CONFIG_PROC_SYSCTL */
+
 /*
  * fork()/clone()-time setup:
  */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff69f245b939..f6d4307bd654 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11099,7 +11099,8 @@ static void task_fork_fair(struct task_struct *p)
 	}
 	place_entity(cfs_rq, se, 1);
 
-	if (sysctl_sched_child_runs_first && curr && entity_before(curr, se)) {
+	if (static_branch_unlikely(&child_runs_first) &&
+	    curr && entity_before(curr, se)) {
 		/*
 		 * Upon rescheduling, sched_class::put_prev_task() will place
 		 * 'current' within the tree based on its new key value.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3d3e5793e117..89ac11e48173 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2002,6 +2002,7 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
 
 extern struct static_key_false sched_numa_balancing;
 extern struct static_key_false sched_schedstats;
+DECLARE_STATIC_KEY_FALSE(child_runs_first);
 
 static inline u64 global_rt_period(void)
 {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 083be6af29d7..72063cffc565 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1773,10 +1773,12 @@ int proc_do_static_key(struct ctl_table *table, int write,
 static struct ctl_table kern_table[] = {
 	{
 		.procname	= "sched_child_runs_first",
-		.data		= &sysctl_sched_child_runs_first,
+		.data		= NULL,
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= sysctl_child_runs_first,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #ifdef CONFIG_SCHEDSTATS
 	{
-- 
2.25.1

