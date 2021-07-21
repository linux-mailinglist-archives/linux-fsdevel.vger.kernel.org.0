Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4763D0A2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 10:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhGUHTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 03:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbhGUHR6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:17:58 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC54DC061767;
        Wed, 21 Jul 2021 00:58:35 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id j73so1146195pge.1;
        Wed, 21 Jul 2021 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0r7Snqa7jDQOWEOYS2VGMrE6hSBLZKPe/sB/w5/dLBo=;
        b=StBryJxE4/C+5nTVVqXPx8OG+lzkRAytVgibKUxDnfdu/3oqfoyrySR97EKWK7M0X3
         46HpVhW1bgxw/Oh8SFfonOHmpAmqxSQjhJJ27e65pY63G8HanwKmZql7fMvWtZWSSD9/
         HVohh2GM4/H9+zUCQL3LsWbQcHW6uEH8vNb4OI8s/xNAXsn+rwtcRSodIruEMa385SYM
         dWgfrESiKr72J6LCa9q7Fv/fzFD06RKXsGF78mb7znMpP6vRgKyUfsPx7D1h95bvFHxC
         G9BSdrDgU1erOWhOJHIOEj+mumh6tZ29hnom2g6zCi3T1tCb+p3GQf6ZtXjqnQRJl5QT
         PCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0r7Snqa7jDQOWEOYS2VGMrE6hSBLZKPe/sB/w5/dLBo=;
        b=Mn3ujUaw9NcQLUk3ZINtBD14VYBL6LRsy5b0tBfQemQQS+3vCTjr6+25U3v5tASRua
         k/Z70o922WIVISVWaPrbr8MzciWT8XqAtYBD5uB6lGxcBhkGTDXXAzZUzED4b5RpxkYp
         pBzN0zj4W79BYpOCqG3AJfhhcL+W8o/S9PtVABtj8U4JhFustk9KoJr/Og15GMGLFrPh
         97bzoO1DZDUsGgupFRmICA/XV3EBQbRk+nFmHTv40Qor4VVpg7QCt2ZQTEqK/zfQ9Q7h
         XpYwkpxWXtwonwkJ7PgIkTKoLfEpgSZCR+LYqzJaM9FZe10by8JPDEIv8oG2UgfgEZQy
         S3aA==
X-Gm-Message-State: AOAM533GqceGLmGMhswHf8xEf+IdTchdRc+qTXeyg9SysWtqHu7djOsI
        2r9DH5+n9GdZaa0F8uusVTo=
X-Google-Smtp-Source: ABdhPJwnqma2Q1t6EX0yVDhku7X/8rpZqUZ75abYmy1GSmMErlU7PCYy67/XxXPHZZHsxboT7+ltlg==
X-Received: by 2002:a63:3704:: with SMTP id e4mr34657458pga.310.1626854315424;
        Wed, 21 Jul 2021 00:58:35 -0700 (PDT)
Received: from BJ10918PCW.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id q3sm27847723pfb.184.2021.07.21.00.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 00:58:35 -0700 (PDT)
From:   Xuewen Yan <xuewen.yan94@gmail.com>
To:     dietmar.eggemann@arm.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, pjt@google.com, qais.yousef@arm.com,
        qperret@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] sched/uclamp:  Introduce a method to transform UCLAMP_MIN into BOOST
Date:   Wed, 21 Jul 2021 15:57:51 +0800
Message-Id: <20210721075751.542-1-xuewen.yan94@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xuewen Yan <xuewen.yan@unisoc.com>

The uclamp can clamp the util within uclamp_min and uclamp_max,
it is benifit to some tasks with small util, but for those tasks
with middle util, it is useless.

To speed up those tasks, convert UCLAMP_MIN to BOOST,
the BOOST as schedtune does:

boot = uclamp_min / SCHED_CAPACITY_SCALE;
margin = boost * (uclamp_max - util)
boost_util = util + margin;

Scenario:
if the task_util = 200, {uclamp_min, uclamp_max} = {100, 1024}

without patch:
clamp_util = 200;

with patch:
clamp_util = 200 + (100 / 1024) * (1024 - 200) = 280;

On the other hand, adding a SYS interface to  allow users
to configure it according to their own needs.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 include/linux/sched/sysctl.h |  1 +
 kernel/sched/core.c          | 19 +++++++++++++++++++
 kernel/sched/fair.c          | 15 ++++++++++++---
 kernel/sched/sched.h         | 10 +++++++++-
 kernel/sysctl.c              |  9 +++++++++
 5 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index db2c0f34aaaf..97d8c5ecd4e6 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -69,6 +69,7 @@ extern unsigned int sysctl_sched_dl_period_min;
 extern unsigned int sysctl_sched_uclamp_util_min;
 extern unsigned int sysctl_sched_uclamp_util_max;
 extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
+extern unsigned int sysctl_sched_uclamp_min_to_boost;
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d9ff40f4661..8a49f9962cda 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1245,6 +1245,9 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
  */
 unsigned int sysctl_sched_uclamp_util_min_rt_default = SCHED_CAPACITY_SCALE;
 
+/* map util clamp_min to boost */
+unsigned int sysctl_sched_uclamp_min_to_boost;
+
 /* All clamps are required to be less or equal than these values */
 static struct uclamp_se uclamp_default[UCLAMP_CNT];
 
@@ -1448,6 +1451,22 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
 	return uc_req;
 }
 
+unsigned long uclamp_transform_boost(unsigned long util, unsigned long uclamp_min,
+				    unsigned long uclamp_max)
+{
+	unsigned long margin;
+
+	if (unlikely(uclamp_min > uclamp_max))
+		return util;
+
+	if (util >= uclamp_max)
+		return uclamp_max;
+
+	margin = DIV_ROUND_CLOSEST_ULL(uclamp_min * (uclamp_max - util),
+					SCHED_CAPACITY_SCALE);
+	return util + margin;
+}
+
 unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_eff;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 44c452072a1b..790dfbb6c897 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3934,9 +3934,18 @@ static inline unsigned long task_util_est(struct task_struct *p)
 #ifdef CONFIG_UCLAMP_TASK
 static inline unsigned long uclamp_task_util(struct task_struct *p)
 {
-	return clamp(task_util_est(p),
-		     uclamp_eff_value(p, UCLAMP_MIN),
-		     uclamp_eff_value(p, UCLAMP_MAX));
+	unsigned long min_util = uclamp_eff_value(p, UCLAMP_MIN);
+	unsigned long max_util = uclamp_eff_value(p, UCLAMP_MAX);
+	unsigned long clamp_util, util;
+
+	util = task_util_est(p);
+
+	if (sysctl_sched_uclamp_min_to_boost)
+		clamp_util = uclamp_transform_boost(util, min_util, max_util);
+	else
+		clamp_util = clamp(util, min_util, max_util);
+
+	return clamp_util;
 }
 #else
 static inline unsigned long uclamp_task_util(struct task_struct *p)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 14a41a243f7b..73657be84678 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2796,6 +2796,8 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 
 #ifdef CONFIG_UCLAMP_TASK
 unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
+unsigned long uclamp_transform_boost(unsigned long util, unsigned long uclamp_min,
+				     unsigned long uclamp_max);
 
 /**
  * uclamp_rq_util_with - clamp @util with @rq and @p effective uclamp values.
@@ -2820,6 +2822,7 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
 {
 	unsigned long min_util = 0;
 	unsigned long max_util = 0;
+	unsigned long clamp_util;
 
 	if (!static_branch_likely(&sched_uclamp_used))
 		return util;
@@ -2847,7 +2850,12 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
 	if (unlikely(min_util >= max_util))
 		return min_util;
 
-	return clamp(util, min_util, max_util);
+	if (sysctl_sched_uclamp_min_to_boost)
+		clamp_util = uclamp_transform_boost(util, min_util, max_util);
+	else
+		clamp_util = clamp(util, min_util, max_util);
+
+	return clamp_util;
 }
 
 /*
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 272f4a272f8c..b3a83356a969 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1827,6 +1827,15 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sysctl_sched_uclamp_handler,
 	},
+	{
+		.procname	= "sched_clamp_min2boost",
+		.data		= &sysctl_sched_uclamp_min_to_boost,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 #endif
 #ifdef CONFIG_SCHED_AUTOGROUP
 	{
-- 
2.25.1

