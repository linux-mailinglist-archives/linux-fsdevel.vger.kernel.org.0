Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7733F9D1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 18:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbhH0Q4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 12:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhH0Q4n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:56:43 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1074EC0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 09:55:54 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h7-20020a37b707000000b003fa4d25d9d0so1039111qkf.17
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 09:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RtM8PgznJntS01ThQKPlB8uJpASuyv3TLEgy3t9rLqI=;
        b=vkWudJEEqVvY1/Sm71xRTxOAU+VXGOzXQgbglYQXCF9fOIJ6xikAFa7r1puof5Ov0B
         LCsAmYPLaC1GZYsbwpgJewGE4v6fvPSfG4uu9490bqCnsaFPuSaPmsPdcOXJCcaWrNEe
         vMwczfLa208fVS+s8D2Eo/DDCcVscy35pGkXXW56FfMF3H4RLit26YKsY5eHu42bkt0l
         fE3jRR8kgjbc9GYNQQg1lFhc3GhBRexOcJXPeabRTj4xq/zQAPmT0Bxx6gwicAnwC3V5
         OVtcxaQcNWRiD+taKUEbIdUcuYIKShZ2WG1zI4texJ/dCWJSh6DhJv286DpKJDw2E8HB
         SXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RtM8PgznJntS01ThQKPlB8uJpASuyv3TLEgy3t9rLqI=;
        b=EntLUO0WtucsA7isIE6jT6QNB5RrjG1YobeO1x5AaE/zR2Zde+G6DPnD5FCE4JkSAO
         BL8oAa+UB93AZ2x0qotaMWkHQou3Ri+0x91bf0UBEogpL59v3519bBSBUlwjOS/a9BFc
         iPx1onGMcR8a35BUiQJAGHJFxgnVpAFEFpRHZv4x5hqFq6EozZmfxKoiVYO8fM/xYKoF
         0n9BMXBLTlg0NXdm1NGKTNgXONHCPjXLrD90xJywrNQugGgH+KChqwzvsbFqhSDDZq+c
         gLxArsEPN0kCJ6Bwj/9br2ksplyhY9Anzm47c3SB6RiFpNWndVEtz99htbxlS81Q3vsY
         I0Ow==
X-Gm-Message-State: AOAM530jtYLYHRV1HwyEYgFkzI0nvvnCMPM6a8+HinQPeK/SKQw7hmNK
        OBcOhMDhlt7c5WO3b/K1+BkTQWCruXiP
X-Google-Smtp-Source: ABdhPJxeWb/MTpG6t8/uCWK6p62wWgeiCGdjUMkZ29GjHvFuM/RR0MA7saJi/yAWhDKNPgDMuFo/7d3UWJw2
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:762:3677:9a19:7f9d])
 (user=joshdon job=sendgmr) by 2002:a05:6214:23cc:: with SMTP id
 hr12mr10628012qvb.56.1630083353062; Fri, 27 Aug 2021 09:55:53 -0700 (PDT)
Date:   Fri, 27 Aug 2021 09:54:38 -0700
Message-Id: <20210827165438.3280779-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v2] fs/proc/uptime.c: fix idle time reporting in /proc/uptime
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Josh Don <joshdon@google.com>, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

/proc/uptime reports idle time by reading the CPUTIME_IDLE field from
the per-cpu kcpustats. However, on NO_HZ systems, idle time is not
continually updated on idle cpus, leading this value to appear
incorrectly small.

/proc/stat performs an accounting update when reading idle time; we can
use the same approach for uptime.

With this patch, /proc/stat and /proc/uptime now agree on idle time.
Additionally, the following shows idle time tick up consistently on an
idle machine:
(while true; do cat /proc/uptime; sleep 1; done) | awk '{print $2-prev; prev=$2}'

Reported-by: Luigi Rizzo <lrizzo@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
---
v2:
- Move get_idle_time() from cputime.c back into stat.c
- Use kcpustat_cpu_fetch

 fs/proc/stat.c              |  4 ++--
 fs/proc/uptime.c            | 14 +++++++++-----
 include/linux/kernel_stat.h |  1 +
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 6561a06ef905..4fb8729a68d4 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -24,7 +24,7 @@
 
 #ifdef arch_idle_time
 
-static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
+u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
 {
 	u64 idle;
 
@@ -46,7 +46,7 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 
 #else
 
-static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
+u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
 {
 	u64 idle, idle_usecs = -1ULL;
 
diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index 5a1b228964fb..deb99bc9b7e6 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -12,18 +12,22 @@ static int uptime_proc_show(struct seq_file *m, void *v)
 {
 	struct timespec64 uptime;
 	struct timespec64 idle;
-	u64 nsec;
+	u64 idle_nsec;
 	u32 rem;
 	int i;
 
-	nsec = 0;
-	for_each_possible_cpu(i)
-		nsec += (__force u64) kcpustat_cpu(i).cpustat[CPUTIME_IDLE];
+	idle_nsec = 0;
+	for_each_possible_cpu(i) {
+		struct kernel_cpustat kcs;
+
+		kcpustat_cpu_fetch(&kcs, i);
+		idle_nsec += get_idle_time(&kcs, i);
+	}
 
 	ktime_get_boottime_ts64(&uptime);
 	timens_add_boottime(&uptime);
 
-	idle.tv_sec = div_u64_rem(nsec, NSEC_PER_SEC, &rem);
+	idle.tv_sec = div_u64_rem(idle_nsec, NSEC_PER_SEC, &rem);
 	idle.tv_nsec = rem;
 	seq_printf(m, "%lu.%02lu %lu.%02lu\n",
 			(unsigned long) uptime.tv_sec,
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 44ae1a7eb9e3..69ae6b278464 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -102,6 +102,7 @@ extern void account_system_index_time(struct task_struct *, u64,
 				      enum cpu_usage_stat);
 extern void account_steal_time(u64);
 extern void account_idle_time(u64);
+extern u64 get_idle_time(struct kernel_cpustat *kcs, int cpu);
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 static inline void account_process_tick(struct task_struct *tsk, int user)
-- 
2.33.0.259.gc128427fd7-goog

