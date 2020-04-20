Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462821B17B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 22:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgDTU6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 16:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgDTU6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:58:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E35BC061A0C;
        Mon, 20 Apr 2020 13:58:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x4so1136541wmj.1;
        Mon, 20 Apr 2020 13:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+Falpz6HHoXnu/HWvO2wa0FQA6oNcrwhc/NVvO9+xY=;
        b=btgqUHpKOiTnw2NTzK94CX7Ft/BqvOdxadUvSiPGFeqQOXqwO3Meyqyxx/pcWbCi2K
         baEMfAvgyt77uq84T56qlDwXsNDMhrAaaJaH/3bDMFqW7EH6QBqggrvHBvzetdmwNVWX
         /r+dLooeXS7hFKf0U+QZAWEPtIoygUgb7G0YF4Ad2jC8gN3h6fA0UUdls65msy4mijGB
         zJVLddn1Xh0g6zNeIL5xCt2VQKnqpmX+q/vBENFuzkI9iWtz/V9bVouueolxmaiZnpqO
         E+HGWXz98VpR8GMBdpm7KWCoJVOiIp05nm1TxzeNqC/0qy4oXDu5hfkokxxE/bQAvv15
         BPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+Falpz6HHoXnu/HWvO2wa0FQA6oNcrwhc/NVvO9+xY=;
        b=eGlXCCUbxpi21pEhpZxHWvx+hkPCrA1Lvw//1+QMTOvsK3EH8mNb/bd3/Dr7JIABxB
         xSHDo3rLFyq9G9VC1wO3YtVujvCa0USeaOyWTFkwDsUZCh0X3nA1oUWgwn8aUuIqeeEb
         sn9bNSlZv/xsJVm+48Nc7jTZ6RI6NKCBBNXDzWYUKJKuO8sJL6bvr5bJCDtHTAdc9KPq
         C/eetrKwmvBGDZjw1mrRL7jmwxgU+NrJoClD3eD7DWbD0+fiybA2ZRMrn60B3X4VH7hb
         sDbme9t4n7+baSTBrvHRGde0pNC6GbbyoAamzx66sakrMFc1xYoEg4aE8zfR+YHyYEq1
         pwpw==
X-Gm-Message-State: AGi0PuZgzbTOZirVGXGxffDIaYuP0IJNEq4TnCUQG8e8/+LUsMmEH1tN
        qGk900dXCUS2YhFGhjJC+A==
X-Google-Smtp-Source: APiQypJpilaVLxv+aiF2+DXnWaP0VP+MwWIuHa4Kz41XGL3r8lN5GAgZv+/Wtd7uEXQVgH6y1kQ+Eg==
X-Received: by 2002:a7b:c213:: with SMTP id x19mr1239688wmi.53.1587416289069;
        Mon, 20 Apr 2020 13:58:09 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.249.74])
        by smtp.gmail.com with ESMTPSA id m8sm863069wrx.54.2020.04.20.13.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:58:08 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: [PATCH 02/15] sched: make nr_iowait_cpu() return "unsigned int"
Date:   Mon, 20 Apr 2020 23:57:30 +0300
Message-Id: <20200420205743.19964-2-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200420205743.19964-1-adobriyan@gmail.com>
References: <20200420205743.19964-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Same logic: 2^32 threads stuck waiting in runqueue implies
2^32+ processes total which is absurd.

Per-runqueue ->nr_iowait member being 32-bit hints that it is
correct change!

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 drivers/cpuidle/governors/menu.c | 6 +++---
 fs/proc/stat.c                   | 2 +-
 include/linux/sched/stat.h       | 4 ++--
 kernel/sched/core.c              | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index b0a7ad566081..ddaaa36af290 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -117,7 +117,7 @@ struct menu_device {
 	int		interval_ptr;
 };
 
-static inline int which_bucket(u64 duration_ns, unsigned long nr_iowaiters)
+static inline int which_bucket(u64 duration_ns, unsigned int nr_iowaiters)
 {
 	int bucket = 0;
 
@@ -150,7 +150,7 @@ static inline int which_bucket(u64 duration_ns, unsigned long nr_iowaiters)
  * to be, the higher this multiplier, and thus the higher
  * the barrier to go to an expensive C state.
  */
-static inline int performance_multiplier(unsigned long nr_iowaiters)
+static inline int performance_multiplier(unsigned int nr_iowaiters)
 {
 	/* for IO wait tasks (per cpu!) we add 10x each */
 	return 1 + 10 * nr_iowaiters;
@@ -270,7 +270,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	unsigned int predicted_us;
 	u64 predicted_ns;
 	u64 interactivity_req;
-	unsigned long nr_iowaiters;
+	unsigned int nr_iowaiters;
 	ktime_t delta_next;
 	int i, idx;
 
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 93ce344f62a5..678feb7b9949 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -198,7 +198,7 @@ static int show_stat(struct seq_file *p, void *v)
 		"btime %llu\n"
 		"processes %lu\n"
 		"procs_running %u\n"
-		"procs_blocked %lu\n",
+		"procs_blocked %u\n",
 		nr_context_switches(),
 		(unsigned long long)boottime.tv_sec,
 		total_forks,
diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
index f3b86515bafe..c4bd2fc95219 100644
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -18,8 +18,8 @@ DECLARE_PER_CPU(unsigned long, process_counts);
 extern int nr_processes(void);
 unsigned int nr_running(void);
 extern bool single_task_running(void);
-extern unsigned long nr_iowait(void);
-extern unsigned long nr_iowait_cpu(int cpu);
+unsigned int nr_iowait(void);
+unsigned int nr_iowait_cpu(int cpu);
 
 static inline int sched_info_on(void)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d9bae602966c..ec98244e9d96 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3428,7 +3428,7 @@ unsigned long long nr_context_switches(void)
  * it does become runnable.
  */
 
-unsigned long nr_iowait_cpu(int cpu)
+unsigned int nr_iowait_cpu(int cpu)
 {
 	return atomic_read(&cpu_rq(cpu)->nr_iowait);
 }
@@ -3463,9 +3463,9 @@ unsigned long nr_iowait_cpu(int cpu)
  * Task CPU affinities can make all that even more 'interesting'.
  */
 
-unsigned long nr_iowait(void)
+unsigned int nr_iowait(void)
 {
-	unsigned long i, sum = 0;
+	unsigned int i, sum = 0;
 
 	for_each_possible_cpu(i)
 		sum += nr_iowait_cpu(i);
-- 
2.24.1

